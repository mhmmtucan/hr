package com.example.demo.util;

import com.example.demo.model.Application;
import com.example.demo.model.Hr;
import com.example.demo.model.Job;
import com.example.demo.model.User;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.proxy.HibernateProxy;
import org.hibernate.search.FullTextSession;
import org.hibernate.search.Search;
import org.hibernate.service.ServiceRegistry;

import java.net.URL;

public class HibernateUtil {
    private static SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            if (sessionFactory == null) {
                Configuration configuration = new Configuration()
                        .addAnnotatedClass(User.class)
                        .addAnnotatedClass(Hr.class)
                        .addAnnotatedClass(Application.class)
                        .addAnnotatedClass(Job.class);
                URL cF = HibernateUtil.class.getClassLoader().getResource("hibernate.cfg.xml");
                configuration = configuration.configure(cF);
                StandardServiceRegistryBuilder serviceRegistryBuilder = new StandardServiceRegistryBuilder();
                serviceRegistryBuilder.applySettings(configuration.getProperties());
                ServiceRegistry serviceRegistry = serviceRegistryBuilder.build();
                sessionFactory = configuration.buildSessionFactory(serviceRegistry);
            }
            return sessionFactory;
        } catch (Throwable ex) {
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        getSessionFactory().close();
    }

    public static Session getSessionAndBeginTransaction() {
        Session session = sessionFactory.getCurrentSession();
        session.beginTransaction();
        return session;
    }

    public static void commitAndCloseSession(Session session) {
        session.getTransaction().commit();
        session.close();
    }

    public static void reIndexHibernateSearch() {
        try {

            FullTextSession fullTextSession = Search.getFullTextSession(sessionFactory.getCurrentSession());
            fullTextSession.createIndexer().startAndWait();
        } catch (Exception e) {
            System.out.println("Error at re-indexing " + e);
        }
    }

    @SuppressWarnings("unchecked")
    public static <T> T initializeAndUnproxy(T entity) {
        Hibernate.initialize(entity);
        if (entity == null) {
            throw new
                    NullPointerException("Entity passed for initialization is null");
        }
        if (entity instanceof HibernateProxy) {
            entity = (T) ((HibernateProxy) entity).getHibernateLazyInitializer()
                    .getImplementation();
        }
        return entity;
    }

}