package com.example.demo.dao;

import com.example.demo.model.User;
import com.example.demo.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.hibernate.search.FullTextSession;
import org.hibernate.search.Search;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import java.util.UUID;

@Repository
public class UserDAOImpl implements UserDAO {
    private static final Logger logger = LoggerFactory.getLogger(UserDAOImpl.class);
    private SessionFactory sessionFactory;

    public UserDAOImpl() {
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
    public void addUser(User u) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        session.persist(u);
        HibernateUtil.commitAndCloseSession(session);
        logger.info("User saved successfully, user details=" + u);

    }

    @Override
    public void updateUser(User u) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        session.update(u);
        HibernateUtil.commitAndCloseSession(session);
        logger.info("User updated successfully, user details=" + u);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<User> listAllUser() {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        List<User> userList = session.createQuery("from User").list();
        HibernateUtil.commitAndCloseSession(session);

        return userList;
    }

    @Override
    public User getUserById(UUID id) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        User u = session.get(User.class, id);
        System.out.println("User" + u);
        HibernateUtil.commitAndCloseSession(session);
        logger.info("Person loaded successfully, user details=" + u);

        return u;

    }

    @Override
    public User getUserByLinkedInId(String id) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<User> criteriaQuery = criteriaBuilder.createQuery(User.class);
        Root<User> root = criteriaQuery.from(User.class);
        criteriaQuery.select(root);
        criteriaQuery.where(criteriaBuilder.equal(root.get("linkedin_id"), id));

        Query<User> query = session.createQuery(criteriaQuery);

        User user = query.getSingleResult();
        HibernateUtil.commitAndCloseSession(session);
        return user;
    }

    @Override
    public boolean checkExists(String linkedInId) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        String queryString = "select 1 from User u where u.linkedin_id= :id";
        Query query = session.createQuery(queryString);
        query.setParameter("id", linkedInId);
        Integer result = (Integer) query.uniqueResult();
        System.out.println("linkedin id: " + linkedInId + " " + result);
        HibernateUtil.commitAndCloseSession(session);
        if (result != null) {
            return true;
        } else return false;

    }

    @Override
    public void removeUser(UUID id) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        User u = session.get(User.class, id);

        if (u != null) {
            session.delete(u);
        }
        HibernateUtil.commitAndCloseSession(session);
        logger.info("Persen deleted succesfully, user details=" + u);

    }

    @Override
    public List<User> searchUsers(String text) {
        List<User> users = null;
        Session session = null;
        Transaction transaction = null;

        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.getTransaction();
            transaction.begin();

            FullTextSession fullTextSession = Search.getFullTextSession(session);
            QueryBuilder qb = fullTextSession.getSearchFactory().buildQueryBuilder().forEntity(User.class).get();

            org.apache.lucene.search.Query luceneQuery = qb.keyword().onFields("name", "surname", "highschool", "university", "department", "email", "qualification", "title")
                    .matching(text).createQuery();

            @SuppressWarnings("unchecked")
            Query<User> query = fullTextSession.createFullTextQuery(luceneQuery, User.class);
            users = query.getResultList();

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

        return users;
    }

}
