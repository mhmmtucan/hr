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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;


@Controller
public class NewJobController {
    private JobService jobService;
    private HrService hrService;

    @Autowired
    @Qualifier("jobService")
    public void setJobService(JobService jobService) {
        this.jobService = jobService;
    }

    @Autowired
    @Qualifier("hrService")
    public void setHrService(HrService hrService) {
        this.hrService = hrService;
    }

    @RequestMapping(value = "/hr/newJob", method = RequestMethod.GET)
    public String loadNewJobPage(Model model, HttpSession session) {
        SessionAttributeUtil.intiSessionAttributes(session);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        String role = auth.getAuthorities().toArray()[0].toString();
        model.addAttribute("role", role);
        model.addAttribute("jobEvent", "Create a new job");
        model.addAttribute("jobisactive", false);
        return "newjob";
    }

    @RequestMapping(value = "/hr/newJob", method = RequestMethod.POST)
    public String createNewJob(@ModelAttribute("job") Job job, HttpSession session, Model model) {
        Hr hr = hrService.getHrByUsername(session.getAttribute("hrUsername").toString());
        job.setHr(hr);
        job.setCompany(hr.getCompany());
        job.setIsdateactive(job.checkIfDateActive());

        if (job.getId() == null) {
            jobService.addJob(job);
        } else {
            jobService.updateJob(job);
        }
        return "redirect:/hr/profile/" + hr.getId().toString();
    }

}
