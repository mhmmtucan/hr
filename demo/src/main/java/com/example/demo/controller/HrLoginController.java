package com.example.demo.controller;

import com.example.demo.model.Hr;
import com.example.demo.service.HrService;
import com.example.demo.util.SessionAttributeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class HrLoginController {
    public HrService hrService;

    @Autowired
    @Qualifier("hrService")
    public void setHrService(HrService hrService) {
        this.hrService = hrService;
    }

    @RequestMapping(value = "/hr/login")
    public String hrLogin(@RequestBody String text, Model model, HttpSession session) {
        SessionAttributeUtil.intiSessionAttributes(session);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        /*
        Pattern pattern = Pattern.compile("=(.*?)&");
        Matcher matcher = pattern.matcher(text);
        String hrUsername = "";
        if (matcher.find()) {
            hrUsername = matcher.group(1);
        }
        */
        String hrUsername = auth.getName();
        Hr hr = hrService.getHrByUsername(hrUsername);

        model.addAttribute("hrUsername", hrUsername);
        model.addAttribute("hrId", hr.getId().toString());

        return "hrlogin";
    }


}
