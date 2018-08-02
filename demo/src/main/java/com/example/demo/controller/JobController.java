package com.example.demo.controller;

import com.example.demo.model.Application;
import com.example.demo.model.Job;
import com.example.demo.model.User;
import com.example.demo.service.ApplicationService;
import com.example.demo.service.JobService;
import com.example.demo.service.UserService;
import com.example.demo.util.HibernateUtil;
import com.example.demo.util.SessionAttributeUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Controller
public class JobController {
    private UserService userService;
    private JobService jobService;
    private ApplicationService applicationService;

    @Autowired
    @Qualifier("userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Autowired
    @Qualifier("jobService")
    public void setJobService(JobService jobService) {
        this.jobService = jobService;
    }

    @Autowired
    @Qualifier("applicationService")
    public void setApplicationService(ApplicationService applicationService) {
        this.applicationService = applicationService;
    }

    @RequestMapping(value = "/job/{jobId}", method = RequestMethod.GET)
    public String jobDetails(@PathVariable UUID jobId, Model model, HttpSession session) {
        SessionAttributeUtil.intiSessionAttributes(session);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        String role = auth.getAuthorities().toArray()[0].toString();
        model.addAttribute("role", role);

        Job job = jobService.getJobById(jobId);
        List<Application> applications = applicationService.getApplicationsByJob(job);
        int applicationCount = applications.size();

        String qualification = job.getQualification();
        List<String> qualifications = Arrays.asList(qualification.split(","));

        model.addAttribute("applicationCount", applicationCount);
        model.addAttribute("qualifications", qualifications);
        model.addAttribute("job", job);
        model.addAttribute("userBlackListed", false);
        model.addAttribute("applicationMade", false);

        if (role.equals("ROLE_USER")) {
            User user = userService.getUserById(UUID.fromString(session.getAttribute("userId").toString()));

            if (user.isBlacklisted()) {
                model.addAttribute("userBlackListed", true);
            }

            if (applicationService.checkApplicationExists(job.getId(), user.getId())) {
                // user already made application
                model.addAttribute("applicationMade", true);
            }
        } else if (role.equals("ROLE_HR")) {
            if (session.getAttribute("hrId").equals(job.getHr().getId().toString())) {
                model.addAttribute("applications", applications);
            } else {
                model.addAttribute("role", "ROLE_UNKNOWN_HR");
            }
        }

        return "jobdetails";
    }

    @RequestMapping(value = "/job/{jobId}/edit", method = RequestMethod.POST)
    public String editJob(@PathVariable UUID jobId, Model model) {
        Job job = jobService.getJobById(jobId);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        String role = auth.getAuthorities().toArray()[0].toString();
        model.addAttribute("role", role);
        model.addAttribute("job", job);
        model.addAttribute("jobEvent", "Update job");
        model.addAttribute("jobisactive", job.isIsactive());
        return "newjob";
    }

    @RequestMapping(value = "/job/{jobId}/delete", method = RequestMethod.POST)
    public String removeJob(@PathVariable UUID jobId, HttpSession session) {
        String hrId = session.getAttribute("hrId").toString();
        Job job = jobService.getJobById(jobId);
        for (Application app : applicationService.getApplicationsByJob(job)) {
            applicationService.removeApplication(app.getId());
        }
        jobService.deleteJob(jobId);
        return "redirect:/hr/profile/" + hrId;
    }

    @RequestMapping(value = "/job/{jobId}/activate", method = RequestMethod.POST)
    @ResponseBody
    public String activateJob(@PathVariable UUID jobId, Model model, HttpSession session) {
        Job job = jobService.getJobById(jobId);
        job.setIsactive(true);
        jobService.updateJob(job);
        return "ok";
    }

    @RequestMapping(value = "/job/{jobId}/deactivate", method = RequestMethod.POST)
    @ResponseBody
    public String deactivateJob(@PathVariable UUID jobId, Model model, HttpSession session) {
        Job job = jobService.getJobById(jobId);
        job.setIsactive(false);
        jobService.updateJob(job);
        return "ok";
    }

    @RequestMapping(value = "/job/all")
    public String listAllActiveJobs(Model model, HttpSession session) {
        SessionAttributeUtil.intiSessionAttributes(session);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = auth.getAuthorities().toArray()[0].toString();
        model.addAttribute("role", role);

        List<Job> activeJobs = jobService.listActiveDateActiveJobs();
        model.addAttribute("activeJobs", activeJobs);

        for (Job job : activeJobs) {
            job.setQualificationList(Arrays.asList(job.getQualification().split(",")));
        }

        return "alljobs";
    }

    @RequestMapping(value = "/job/page/{pageNumber}")
    public String getJobsWithRange(@PathVariable int pageNumber, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = auth.getAuthorities().toArray()[0].toString();
        model.addAttribute("role", role);

        int jobsPerPage = 10;

        List<Job> activeJobs = jobService.getJobsWithRange((pageNumber - 1) * jobsPerPage, pageNumber * jobsPerPage);
        model.addAttribute("activeJobs", activeJobs);
        model.addAttribute("isPagination", true);
        model.addAttribute("pageNumber", pageNumber);

        if (!activeJobs.isEmpty() || activeJobs.size() >= jobsPerPage) {
            for (Job job : activeJobs) {
                job.setQualificationList(Arrays.asList(job.getQualification().split(",")));
            }
        } else {
            model.addAttribute("maxJobReached", true);
            model.addAttribute("pageNumber", 0);
            //return "redirect:/job/page/1";
        }

        return "alljobs";
    }

    @SuppressWarnings("unchecked")
    @ResponseBody
    @RequestMapping(value = "/search/job", method = RequestMethod.POST)
    public JSONObject getSearchResults(@RequestBody String text) {
        String search_text = text;
        if (text.charAt(text.length() - 1) == '=') {
            search_text = search_text.substring(0, search_text.length() - 1);
        }

        List<Job> jobs = jobService.searchJobs(search_text);

        if (jobs != null) {
            for (Job j : jobs) {
                j.setQualificationList(Arrays.asList(j.getQualification().split(",")));
            }
        }

        JSONParser jsonParser = new JSONParser();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        JSONObject jobJson = null;
        JSONObject jobsJson = new JSONObject();
        try {
            if (jobs.isEmpty()) {
                String noResult = "{\"result\":\"0\",\"jobs\":\"No results found!\"}";
                return (JSONObject) jsonParser.parse(noResult);
            }

            jobsJson.put("result", "1");
            JSONArray jobsArray = new JSONArray();
            for (int i = 0; i < 5 && i < jobs.size(); i++) {
                String jobJsonString = ow.writeValueAsString(jobs.get(i));
                String hrJsonString = ow.writeValueAsString(HibernateUtil.initializeAndUnproxy(jobs.get(0).getHr()));

                jobJson = (JSONObject) jsonParser.parse(jobJsonString);
                JSONObject hrJson = (JSONObject) jsonParser.parse(hrJsonString);

                jobJson.put("hr", hrJson);
                jobsArray.add(jobJson);
            }

            jobsJson.put("jobs", jobsArray);


        } catch (Exception e) {
            System.out.println("Exception" + e);
        }
        return jobsJson;
    }


}
