package com.example.demo.controller;

import com.example.demo.model.Application;
import com.example.demo.model.Job;
import com.example.demo.model.User;
import com.example.demo.service.ApplicationService;
import com.example.demo.service.HrMailAPI;
import com.example.demo.service.JobService;
import com.example.demo.service.UserService;
import com.example.demo.util.HibernateUtil;
import com.example.demo.util.HrMailAPIUtil;
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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Controller
public class ApplicationController {

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

    @ResponseBody
    @RequestMapping(value = "/job/application/{jobId}", method = RequestMethod.POST)
    public String makeApplication(@PathVariable UUID jobId, Model model, HttpSession session) {
        SessionAttributeUtil.intiSessionAttributes(session);

        User user = userService.getUserById(UUID.fromString(session.getAttribute("userId").toString()));
        user.setScore(UserController.calculateScore(user));

        Job job = jobService.getJobById(jobId);

        Application app = new Application(user, job);
        app.setCurrentstatus("Pending");

        String userQualification = user.getQualification();
        List<String> userQualifications = Arrays.asList(userQualification.split(","));

        String jobQualification = job.getQualification();
        List<String> jobQualifications = Arrays.asList(jobQualification.split(","));

        List<String> commonQualifications = new ArrayList<>(userQualifications);
        commonQualifications.retainAll(jobQualifications);
        app.setUser_score(user.getScore() + (double) commonQualifications.size() * 4.1);

        if (applicationService.checkApplicationExists(jobId, user.getId())) {
            model.addAttribute("applicationMade", "true");
            return "/job/" + jobId.toString();
        }
        model.addAttribute("applicationMade", "false");

        applicationService.createApplicaiton(app);

        return "/job/" + jobId.toString();
    }

    @RequestMapping(value = "/job/{jobId}/application/{appId}/accept", method = RequestMethod.POST)
    public String acceptApplication(@PathVariable UUID jobId, @PathVariable UUID appId, Model model, HttpSession session) {
        Application application = applicationService.getApplicationById(appId);
        User user = application.getUser();

        // mark job as accepted
        application.setCurrentstatus("Accepted");
        applicationService.updateApplication(application);

        // send accepted mail
        HrMailAPI hrMailAPI = HrMailAPIUtil.initAndReturnHrMailAPI();
        String subject = "Your Application Accepted";
        String msg = "Congratulations! Your application named " + application.getJob().getTitle() + " is accepted!";

        hrMailAPI.sendMail(HrMailAPIUtil.getFrom(), user.getEmail(), subject, msg);

        return "redirect:/job/" + jobId.toString();
    }

    @RequestMapping(value = "/job/{jobId}/application/{appId}/reject", method = RequestMethod.POST)
    public String rejectApplication(@PathVariable UUID jobId, @PathVariable UUID appId, Model model, HttpSession session) {
        Application application = applicationService.getApplicationById(appId);
        User user = application.getUser();
        // mark job as rejected
        application.setCurrentstatus("Rejected");
        applicationService.updateApplication(application);


        // send rejected mail
        HrMailAPI hrMailAPI = HrMailAPIUtil.initAndReturnHrMailAPI();
        String subject = "Your Application Rejected";
        String msg = "Sorry to say that, but your application named " + application.getJob().getTitle() + " is rejected!";

        hrMailAPI.sendMail(HrMailAPIUtil.getFrom(), user.getEmail(), subject, msg);

        return "redirect:/job/" + jobId.toString();
    }

    @SuppressWarnings("unchecked")
    @ResponseBody
    @RequestMapping(value = "/search/applicants/{jobId}", method = RequestMethod.POST)
    public JSONObject searchApplicants(@RequestBody String text, @PathVariable UUID jobId) {
        List<User> users = new ArrayList<User>();

        List<Application> applications = null;
        JSONParser jsonParser = new JSONParser();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();

        JSONObject userJson = null;
        JSONObject usersJson = new JSONObject();

        try {
            applications = applicationService.searchApplicants(text, jobId);

            for (Application app : applications) {
                users.add(HibernateUtil.initializeAndUnproxy(app.getUser()));
            }

            if (users == null || users.isEmpty()) {
                String noResult = "{\"result\":\"0\",\"users\":\"No results found!\"}";
                return (JSONObject) jsonParser.parse(noResult);
            }

            usersJson.put("result", "1");
            JSONArray usersArray = new JSONArray();
            for (User user : users) {
                String userJsonString = ow.writeValueAsString(user);
                userJson = (JSONObject) jsonParser.parse(userJsonString);
                usersArray.add(userJson);
            }

            usersJson.put("users", usersArray);

        } catch (Exception e) {
            System.out.println("Exception" + e);
        }

        return usersJson;
    }

    @RequestMapping(value = "/job/{jobId}/application/{appId}/cancel", method = RequestMethod.POST)
    public String cancelApplication(@PathVariable UUID jobId, @PathVariable UUID appId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) auth.getPrincipal();
        applicationService.removeApplication(appId);
        return "redirect:/user/profile/" + user.getId().toString();
    }

    @RequestMapping(value = "/calculatescore", method = RequestMethod.GET)
    public String calcUserScore() {
        List<Application> applications = applicationService.listAllApplication();

        for (Application app : applications) {
            Job job = app.getJob();
            User user = app.getUser();

            String userQualification = user.getQualification();
            List<String> userQualifications = Arrays.asList(userQualification.split(","));

            String jobQualification = job.getQualification();
            List<String> jobQualifications = Arrays.asList(jobQualification.split(","));

            List<String> commonQualifications = new ArrayList<>(userQualifications);
            commonQualifications.retainAll(jobQualifications);
            app.setUser_score(user.getScore() + (double) commonQualifications.size() * 4.1);

            applicationService.updateApplication(app);
        }
        return "redirect:/";
    }

}
