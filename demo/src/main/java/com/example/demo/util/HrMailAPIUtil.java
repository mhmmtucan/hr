package com.example.demo.util;

import com.example.demo.service.HrMailAPI;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class HrMailAPIUtil {
    private static String from = "gradproject1773@gmail.com";

    public static HrMailAPI initAndReturnHrMailAPI() {
        ApplicationContext context = new ClassPathXmlApplicationContext("./WEB-INF/spring-mail-config.xml");
        return (HrMailAPI) context.getBean("hrMail");
    }


    public static String getFrom() {
        return from;
    }

    public static void setFrom(String from) {
        HrMailAPIUtil.from = from;
    }
}
