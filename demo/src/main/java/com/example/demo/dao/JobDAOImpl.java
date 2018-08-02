package com.example.demo.dao;

import com.example.demo.model.Hr;
import com.example.demo.model.Job;
import com.example.demo.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.hibernate.search.FullTextSession;
import org.hibernate.search.Search;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import java.util.UUID;

@Repository
public class JobDAOImpl implements JobDAO {
    private SessionFactory sessionFactory;


    public JobDAOImpl() {
        setSessionFactory(null);
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        if (sessionFactory == null) {
            this.sessionFactory = HibernateUtil.getSessionFactory();
        } else {
            this.sessionFactory = sessionFactory;
        }
    }

    @Override
    public void addJob(Job j) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        //Hr hr = session.load(Hr.class, j.getHr_id());
        //session.saveOrUpdate(hr);
        //j.setHr(hr);
        session.saveOrUpdate(j);
        HibernateUtil.commitAndCloseSession(session);
    }

    @Override
    public void deleteJob(UUID id) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        Job j = session.get(Job.class, id);

        if (j != null) {
            session.delete(j);
        }
        HibernateUtil.commitAndCloseSession(session);

    }

    @Override
    public void updateJob(Job j) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        session.update(j);
        HibernateUtil.commitAndCloseSession(session);
    }

    @Override
    public Job getJobById(UUID id) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        Job j = session.get(Job.class, id);
        HibernateUtil.commitAndCloseSession(session);
        return j;
    }

    @Override
    public List<Job> getJobsByHr(Hr hr) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Job> criteriaQuery = criteriaBuilder.createQuery(Job.class);
        Root<Job> root = criteriaQuery.from(Job.class);
        criteriaQuery.select(root);
        criteriaQuery.where(criteriaBuilder.equal(root.get("hr"), hr));

        Query<Job> query = session.createQuery(criteriaQuery);

        List<Job> hr_jobs = query.getResultList();
        HibernateUtil.commitAndCloseSession(session);
        return hr_jobs;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Job> listAllJob() {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        List<Job> jobList = session.createQuery("from Job").list();
        HibernateUtil.commitAndCloseSession(session);

        return jobList;
    }

    @Override
    public List<Job> listFeaturedJobs() {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Job> criteriaQuery = criteriaBuilder.createQuery(Job.class);
        Root<Job> root = criteriaQuery.from(Job.class);
        criteriaQuery.select(root);
        criteriaQuery.where(criteriaBuilder.equal(root.get("featured"), true));

        Query<Job> query = session.createQuery(criteriaQuery);

        List<Job> featuredJobs = query.getResultList();
        HibernateUtil.commitAndCloseSession(session);

        return featuredJobs;
    }

    @Override
    public List<Job> listActiveJobs() {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Job> criteriaQuery = criteriaBuilder.createQuery(Job.class);
        Root<Job> root = criteriaQuery.from(Job.class);
        criteriaQuery.select(root);
        criteriaQuery.where(criteriaBuilder.equal(root.get("isactive"), true));

        Query<Job> query = session.createQuery(criteriaQuery);

        List<Job> activeJobs = query.getResultList();
        HibernateUtil.commitAndCloseSession(session);
        return activeJobs;
    }

    @Override
    public List<Job> listActiveDateActiveJobs() {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Job> criteriaQuery = criteriaBuilder.createQuery(Job.class);
        Root<Job> root = criteriaQuery.from(Job.class);
        criteriaQuery.select(root);
        criteriaQuery.where(criteriaBuilder.equal(root.get("isactive"), true)).where(criteriaBuilder.equal(root.get("isdateactive"), true));

        Query<Job> query = session.createQuery(criteriaQuery);

        List<Job> activeDateActivejobs = query.getResultList();
        HibernateUtil.commitAndCloseSession(session);
        return activeDateActivejobs;
    }

    @Override
    public List<Job> getJobsWithRange(int min, int max) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Job> criteriaQuery = criteriaBuilder.createQuery(Job.class);
        Root<Job> root = criteriaQuery.from(Job.class);
        criteriaQuery.select(root);
        criteriaQuery.where(criteriaBuilder.equal(root.get("isactive"), true)).where(criteriaBuilder.equal(root.get("isdateactive"), true));

        Query<Job> query = session.createQuery(criteriaQuery);
        query.setFirstResult(min);
        query.setMaxResults(max);
        List<Job> activeJobs = query.getResultList();
        HibernateUtil.commitAndCloseSession(session);
        return activeJobs;
    }

    @Override
    public List<Job> searchJobs(String text) {
        List<Job> jobs = null;
        Session session = null;
        Transaction transaction = null;

        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.getTransaction();
            transaction.begin();

            FullTextSession fullTextSession = Search.getFullTextSession(session);
            QueryBuilder qb = fullTextSession.getSearchFactory().buildQueryBuilder().forEntity(Job.class).get();

            //org.apache.lucene.search.Query luceneQuery = qb.keyword().onFields("title", "description", "qualification").matching(text).createQuery();
            @SuppressWarnings("unchecked")
            org.apache.lucene.search.Query luceneQuery = qb.bool()
                    .must(qb.keyword().onFields("title", "description", "qualification", "company", "summary").matching(text).createQuery())
                    .must(qb.keyword().onField("isactive").matching(true).createQuery())
                    .must(qb.keyword().onField("isdateactive").matching(true).createQuery())
                    .createQuery();
            @SuppressWarnings("unchecked")
            Query<Job> query = fullTextSession.createFullTextQuery(luceneQuery, Job.class);
            jobs = query.getResultList();

            transaction.commit();
            ;
        } catch (Exception e) {
            System.out.println("Error at searching jobs: " + e);
            if (transaction != null) {
                transaction.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
                ;
            }
        }

        return jobs;
    }
}
