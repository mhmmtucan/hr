package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.service.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class UserController {
    private UserService userService;

    @Autowired
    @Qualifier(value = "userService")
    public void setUserService(UserService us) {
        this.userService = us;
    }

    @SuppressWarnings("unchecked")
    @ResponseBody
    @RequestMapping(value = "/search/users", method = RequestMethod.POST)
    public JSONObject searchUser(@RequestBody String text) {
        JSONParser jsonParser = new JSONParser();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();


        JSONObject userJson = null;
        JSONObject usersJson = new JSONObject();

        try {

            List<User> users = userService.searchUsers(text);
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

    public static double calculateScore(User user) {
        return Math.round((user.getExperience() * 3.14 + user.getGpa() * 2.71) * 100.0) / 100.0;
    }
}
