package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.service.UserService;
import com.example.demo.util.SessionAttributeUtil;
import com.github.scribejava.apis.LinkedInApi20;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Controller
public class UserLoginController {
    private String API_KEY = "868uqybmy5cx73";
    private String API_SECRET = "gXb1rx5TFFgOsrK7";
    private OAuth20Service service = new ServiceBuilder(API_KEY).apiSecret(API_SECRET).callback("http://localhost:8080/auth/linkedin").build(LinkedInApi20.instance());
    private Response linkedinResponse;
    private UserService userService;

    @Autowired
    @Qualifier(value = "userService")
    public void setUserService(UserService us) {
        this.userService = us;
    }

    @ResponseBody
    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    public String invokeRedirect(@RequestBody String text) {
        return service.getAuthorizationUrl();
    }

    @ResponseBody
    @RequestMapping(value = "/accessToken", method = RequestMethod.POST)
    public String accessToken(@RequestBody String code) {
        try {
            // TODO: look for linkedin error codes if good redirect, not redirect to error page
            final OAuth2AccessToken accessToken = service.getAccessToken(code);
            // TODO: timeout
            TimeUnit.SECONDS.sleep(10);

            String apiURL = "https://api.linkedin.com/v1/people/~:(id,headline,first-name,last-name,picture-url,public-profile-url,email-address)?format=json";
            final OAuthRequest request = new OAuthRequest(Verb.GET, apiURL);
            service.signRequest(accessToken, request); // the access token from step 4
            final Response response = service.execute(request);
            System.out.println(response.getBody());

            linkedinResponse = response;
            return linkedinResponse.getBody();
        } catch (Exception e) {
            System.out.println("AccessToken " + e);
            return "error";
        }
    }

    @RequestMapping("/auth/linkedin")
    public String home() {
        return "linkedin";
    }

    @RequestMapping(value = "/user/details", method = RequestMethod.GET)
    public String enrollmentPage(Model model, HttpSession session) {
        SessionAttributeUtil.intiSessionAttributes(session);
        JSONObject jsonObject;
        try {
            JSONParser jsonParser = new JSONParser();
            jsonObject = (JSONObject) jsonParser.parse(linkedinResponse.getBody());

            // if user already enrolled, turn back to home page, set session information
            if (userService.checkExists(jsonObject.get("id").toString())) {
                User user = userService.getUserByLinkedInId(jsonObject.get("id").toString());
                String userId = user.getId().toString();
                session.setAttribute("userId", userId);
                session.setAttribute("userLoggedIn", "true");

                UsernamePasswordAuthenticationToken authentication
                        = new UsernamePasswordAuthenticationToken(user, jsonObject.get("id"), user.getAuthorities());
                SecurityContextHolder.getContext().setAuthentication(authentication);

                return "redirect:/";
            }

            model.addAttribute("name", jsonObject.get("firstName").toString());
            model.addAttribute("surname", jsonObject.get("lastName").toString());
            model.addAttribute("title", jsonObject.get("headline").toString());
            model.addAttribute("pictureURL", jsonObject.get("pictureUrl").toString());

        } catch (NullPointerException nullE) {
            return "home";
        } catch (Exception e) {
            System.out.println("exception at user details");
        }
        return "userlogin";
    }

    @RequestMapping(value = "/user/details/complete", method = RequestMethod.POST)
    public String completeEnrollment(@ModelAttribute("user") User user, HttpSession session) {
        JSONObject jsonObject;
        try {
            JSONParser jsonParser = new JSONParser();
            jsonObject = (JSONObject) jsonParser.parse(linkedinResponse.getBody());
            user.setEmail(jsonObject.get("emailAddress").toString());
            user.setLinkedin_id(jsonObject.get("id").toString());
            user.setPicture_url(jsonObject.get("pictureUrl").toString());
            user.setPublicprofile_url(jsonObject.get("publicProfileUrl").toString());
            user.setScore(UserController.calculateScore(user));
            if (userService.checkExists(user.getLinkedin_id())) {
                User prev_user = userService.getUserByLinkedInId(user.getLinkedin_id());
                user.setId(prev_user.getId());
                user.setBlacklisted(prev_user.isBlacklisted());
                user.setBlreason(prev_user.getBlreason());
                userService.updateUser(user);
                return "redirect:/user/profile/" + prev_user.getId();
            } else {
                userService.addUser(user);
                UsernamePasswordAuthenticationToken authentication
                        = new UsernamePasswordAuthenticationToken(user, jsonObject.get("id"), user.getAuthorities());
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
            UUID userId = userService.getUserByLinkedInId(jsonObject.get("id").toString()).getId();
            session.setAttribute("userId", userId);
            session.setAttribute("userLoggedIn", "true");
        } catch (Exception e) {
            System.out.println("User/details/complete" + e);
        }
        return "redirect:/";
    }

}
