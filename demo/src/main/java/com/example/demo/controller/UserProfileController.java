package com.example.demo.controller;

import com.example.demo.model.Application;
import com.example.demo.model.User;
import com.example.demo.service.ApplicationService;
import com.example.demo.service.UserService;
import com.example.demo.util.SessionAttributeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.UUID;

@Controller
public class UserProfileController {
    private UserService userService;
    private ApplicationService applicationService;

    @Autowired
    @Qualifier(value = "userService")
    public void setUserService(UserService us) {
        this.userService = us;
    }

    @Autowired
    @Qualifier(value = "applicationService")
    public void setApplicationService(ApplicationService appService) {
        this.applicationService = appService;
    }

    @RequestMapping(value = "/user/profile/{userId}")
    public String userProfile(@PathVariable UUID userId, HttpSession session, Model model) {
        SessionAttributeUtil.intiSessionAttributes(session);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        String role = auth.getAuthorities().toArray()[0].toString();
        model.addAttribute("role", role);

        switch (role) {
            case "ROLE_ANONYMOUS":
                // netiher user nor hr not logged in
                return "redirect:/";
            case "ROLE_USER":
                User loggedUser = (User) auth.getPrincipal();
                UUID loggedUUID = loggedUser.getId();

                if (!loggedUUID.equals(userId)) {
                    return "redirect:/";
                } else {
                    User user = userService.getUserById(loggedUUID);
                    List<Application> applications = applicationService.getApplicationsByUser(user);
                    model.addAttribute("user", user);
                    model.addAttribute("applications", applications);
                }
                break;
            case "ROLE_HR":
                User user = userService.getUserById(userId);
                List<Application> applications = applicationService.getApplicationsByUser(user);
                model.addAttribute("user", user);
                model.addAttribute("applications", applications);
                break;
        }

        return "userprofile";
    }

    @RequestMapping(value = "/user/profile/{userId}/edit", method = RequestMethod.POST)
    public String editProfile(@PathVariable UUID userId, @RequestBody String text, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        ;
        String role = auth.getAuthorities().toArray()[0].toString();
        model.addAttribute("role", role);
        User user = userService.getUserById(userId);
        System.out.println(text);

        model.addAttribute("name", user.getName());
        model.addAttribute("surname", user.getSurname());
        model.addAttribute("title", user.getTitle());
        model.addAttribute("pictureURL", user.getPicture_url());
        model.addAttribute("university", user.getUniversity());
        model.addAttribute("department", user.getDepartment());
        model.addAttribute("highschool", user.getHighschool());
        model.addAttribute("gpa", user.getGpa());
        model.addAttribute("experience", user.getExperience());
        model.addAttribute("qualifications", user.getQualification());

        return "userlogin";
    }

}
