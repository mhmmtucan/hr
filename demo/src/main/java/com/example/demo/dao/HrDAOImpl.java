package com.example.demo.dao;

import com.example.demo.model.Hr;
import com.example.demo.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import java.util.UUID;

@Repository
public class HrDAOImpl implements HrDAO {
    private SessionFactory sessionFactory;

    public HrDAOImpl() {
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
    public void addHr(Hr hr) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        session.persist(hr);
        HibernateUtil.commitAndCloseSession(session);
    }

    @Override
    public Hr getHrById(UUID id) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        Hr hr = session.get(Hr.class, id);
        HibernateUtil.commitAndCloseSession(session);
        return hr;
    }

    @Override
    public Hr getHrByUsername(String username) {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Hr> criteriaQuery = criteriaBuilder.createQuery(Hr.class);
        Root<Hr> root = criteriaQuery.from(Hr.class);
        criteriaQuery.select(root);
        criteriaQuery.where(criteriaBuilder.equal(root.get("username"), username));

        Query<Hr> query = session.createQuery(criteriaQuery);

        Hr hr = query.getSingleResult();
        HibernateUtil.commitAndCloseSession(session);
        return hr;
    }

    @SuppressWarnings("unchekced")
    @Override
    public List<Hr> listAllHr() {
        Session session = HibernateUtil.getSessionAndBeginTransaction();
        ;
        List<Hr> hrList = session.createQuery("from Hr").list();
        HibernateUtil.commitAndCloseSession(session);
        return hrList;
    }
}
