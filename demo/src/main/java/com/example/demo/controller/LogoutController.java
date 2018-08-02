package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class LogoutController {

    @RequestMapping(value = "/user/logout")
    public String logout(Model model, HttpSession session) {
        session.invalidate();

        return "redirect:/";
    }


}
