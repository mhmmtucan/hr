package com.example.demo.util;

import javax.servlet.http.HttpSession;

public class SessionAttributeUtil {
    public static void intiSessionAttributes(HttpSession session) {
        if (session.getAttribute("userLoggedIn") == null) {
            session.setAttribute("userLoggedIn", "false");
        }
        if (session.getAttribute("hrLoggedIn") == null) {
            session.setAttribute("hrLoggedIn", "false");
        }
    }
}
