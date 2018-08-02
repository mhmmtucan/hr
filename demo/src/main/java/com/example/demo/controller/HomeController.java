package com.example.demo.controller;

import com.example.demo.model.Job;
import com.example.demo.service.JobService;
import com.example.demo.util.SessionAttributeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.security.Principal;
import java.util.Collections;
import java.util.List;

@Controller
public class HomeController {
    private JobService jobService;

    @Autowired
    @Qualifier(value = "jobService")
    public void setJobService(JobService jobService) {
        this.jobService = jobService;
    }

    @RequestMapping(value = "/")
    public String home(Model model, HttpSession session, Principal principal) {
        SessionAttributeUtil.intiSessionAttributes(session);
        List<Job> featuredJobs = jobService.listFeaturedJobs();

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = auth.getAuthorities().toArray()[0].toString();
        model.addAttribute("role", role);

        int featuredSize, featureLimit = 4;

        if (featuredJobs.size() > featureLimit) {
            Collections.shuffle(featuredJobs);
            featuredSize = featureLimit;
        } else {
            featuredSize = featuredJobs.size();
        }

        model.addAttribute("featuredJobs", featuredJobs.subList(0, featuredSize));
        return "home";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage() {
        return "login";
    }

}