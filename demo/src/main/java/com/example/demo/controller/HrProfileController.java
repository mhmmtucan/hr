package com.example.demo.controller;

import com.example.demo.model.Hr;
import com.example.demo.model.Job;
import com.example.demo.service.HrService;
import com.example.demo.service.JobService;
import com.example.demo.util.SessionAttributeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.security.Principal;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;

@Controller
public class HrProfileController {
    private HrService hrService;
    private JobService jobService;

    @Autowired
    @Qualifier("hrService")
    public void setHrService(HrService hrService) {
        this.hrService = hrService;
    }

    @Autowired
    @Qualifier("jobService")
    public void setJobService(JobService jobService) {
        this.jobService = jobService;
    }

    @RequestMapping(value = "/hr/profile/{hrId}")
    public String testHR(@PathVariable UUID hrId, Model model, HttpSession session, Principal principal) {
        SessionAttributeUtil.intiSessionAttributes(session);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        ;
        String role = auth.getAuthorities().toArray()[0].toString();
        model.addAttribute("role", role);

        Hr hr = hrService.getHrById(hrId);

        List<Job> jobs = jobService.getJobsByHr(hr);

        model.addAttribute("hr", hr);

        if (jobs != null) {
            jobs.sort(Comparator.comparing(Job::getFinalDateAsDate));
            model.addAttribute("jobs", jobs);
        }

        return "hrprofile";
    }

}
