package com.example.demo.util;

import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class StartupHousekeeper {

    @EventListener(ContextRefreshedEvent.class)
    public void contextRefreshedEvent() {
        //HibernateUtil.reIndexHibernateSearch();
    }
}