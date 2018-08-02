package com.example.demo.dao;

import com.example.demo.model.Application;
import com.example.demo.model.Job;
import com.example.demo.model.User;
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
public class ApplicationDAOImpl implements ApplicationDAO {
    private SessionFactory sessionFactory;

    public ApplicationDAOImpl() {
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
    public void createApplicaiton(Application app) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        session.saveOrUpdate("Application", app);
        HibernateUtil.commitAndCloseSession(session);
    }

    @Override
    public void removeApplication(UUID id) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        Application app = session.get(Application.class, id);

        if (app != null) {
            session.delete(app);
        }
        HibernateUtil.commitAndCloseSession(session);
    }

    @Override
    public void updateApplication(Application app) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        session.update(app);
        HibernateUtil.commitAndCloseSession(session);
    }

    @Override
    public Application getApplicationById(UUID id) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        Application app = session.get(Application.class, id);
        HibernateUtil.commitAndCloseSession(session);
        return app;
    }

    @Override
    public List<Application> getApplicationsByJob(Job job) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Application> criteriaQuery = criteriaBuilder.createQuery(Application.class);
        Root<Application> root = criteriaQuery.from(Application.class);
        criteriaQuery.select(root);
        criteriaQuery.where(criteriaBuilder.equal(root.get("job"), job));

        Query<Application> query = session.createQuery(criteriaQuery);

        List<Application> applications = query.getResultList();
        HibernateUtil.commitAndCloseSession(session);
        return applications;
    }

    @Override
    public List<Application> getApplicationsByUser(User user) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Application> criteriaQuery = criteriaBuilder.createQuery(Application.class);
        Root<Application> root = criteriaQuery.from(Application.class);
        criteriaQuery.select(root);
        criteriaQuery.where(criteriaBuilder.equal(root.get("user"), user));

        Query<Application> query = session.createQuery(criteriaQuery);

        List<Application> applications = null;
        applications = query.getResultList();
        HibernateUtil.commitAndCloseSession(session);
        return applications;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Application> listAllApplication() {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        List<Application> appList = session.createQuery("from Application ").list();
        /*
        for (User u : userList) {
            logger.info("User List:"+u);
        } */
        HibernateUtil.commitAndCloseSession(session);

        return appList;
    }

    @Override
    public List<Application> searchApplicants(String text, UUID jobId) {
        List<Application> applications = null;
        Session session = null;
        Transaction transaction = null;

        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.getTransaction();
            transaction.begin();

            FullTextSession fullTextSession = Search.getFullTextSession(session);
            QueryBuilder qb = fullTextSession.getSearchFactory().buildQueryBuilder().forEntity(Application.class).get();

            org.apache.lucene.search.Query combinedQuery = qb.bool().
                    must(
                            qb.keyword().onFields("user.name", "user.surname", "user.highschool", "user.university", "user.department", "user.email", "user.qualification", "user.title").matching(text).createQuery()
                    ).must(
                    qb.keyword().onFields("job.id").matching(jobId.toString()).createQuery()
            ).createQuery();

            @SuppressWarnings("unchecked")
            Query<Application> query = fullTextSession.createFullTextQuery(combinedQuery, Application.class);
            applications = query.getResultList();

            transaction.commit();

        } catch (Exception e) {
            System.out.println("Error at searching users: " + e);
            if (transaction != null) {
                transaction.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return applications;
    }

    @Override
    public boolean checkApplicationExists(UUID jobId, UUID userId) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        String queryString = "select 1 from Application a where a.job.id= :jobId and a.user.id= :userId";
        Query query = session.createQuery(queryString);
        query.setParameter("userId", userId);
        query.setParameter("jobId", jobId);
        Integer result = (Integer) query.uniqueResult();
        HibernateUtil.commitAndCloseSession(session);
        if (result != null) {
            return true;
        } else return false;
    }
}
