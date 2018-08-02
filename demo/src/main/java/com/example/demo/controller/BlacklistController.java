package com.example.demo.controller;

import com.example.demo.model.Application;
import com.example.demo.model.User;
import com.example.demo.service.ApplicationService;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@Controller
public class BlacklistController {
    private UserService userService;
    private ApplicationService applicationService;

    @Autowired
    @Qualifier("userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }


    @Autowired
    @Qualifier("applicationService")
    public void setApplicationService(ApplicationService applicationService) {
        this.applicationService = applicationService;
    }

    @ResponseBody
    @RequestMapping(value = "/user/{userId}/blacklist", method = RequestMethod.POST)
    public String blackListUser(@RequestBody String blreason, @PathVariable UUID userId) {
        User user = userService.getUserById(userId);
        List<Application> applications = applicationService.getApplicationsByUser(user);

        for (Application app : applications) {
            app.setCurrentstatus("Rejected");
            applicationService.updateApplication(app);
        }
        user.setBlacklisted(true);
        user.setBlreason(blreason);
        userService.updateUser(user);

        return "ok";
    }

    @ResponseBody
    @RequestMapping(value = "/user/{userId}/blacklist/cancel", method = RequestMethod.POST)
    public String cancelBlackListingUser(@RequestBody String blreason, @PathVariable UUID userId) {
        User user = userService.getUserById(userId);
        List<Application> applications = applicationService.getApplicationsByUser(user);

        for (Application app : applications) {
            app.setCurrentstatus("Pending");
            applicationService.updateApplication(app);
        }
        user.setBlacklisted(false);
        user.setBlreason("");
        userService.updateUser(user);
        return "ok";
    }

}
