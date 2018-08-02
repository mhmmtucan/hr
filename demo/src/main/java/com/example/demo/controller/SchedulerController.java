package com.example.demo.controller;

import com.example.demo.model.Job;
import com.example.demo.service.JobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class SchedulerController {
    private JobService jobService;

    @Autowired
    @Qualifier(value = "jobService")
    public void setJobService(JobService jobService) {
        this.jobService = jobService;
    }

    //@Scheduled(cron="*/5 * * * * *", zone="Asia/Istanbul")
    @Scheduled(cron = "0 0 0 * * ?", zone = "Asia/Istanbul")
    public void checkJobRange() {
        List<Job> jobs = jobService.listActiveJobs();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");
        Date date = new Date();
        System.out.println("Checking jobs");

        for (Job j : jobs) {
            try {
                // compare with current time, if larger activate
                if (simpleDateFormat.parse(j.getActivation_date()).compareTo(date) <= 0) {
                    j.setIsdateactive(true);
                    System.out.println("Job: " + j.getTitle() + " is active now");
                    jobService.updateJob(j);
                }
                // compare with current time, if larger deactivate
                if (simpleDateFormat.parse(j.getFinal_date()).compareTo(date) <= 0) {
                    j.setIsdateactive(false);
                    System.out.println("Job: " + j.getTitle() + " is deactive now");
                    jobService.updateJob(j);
                }

            } catch (Exception e) {
                System.out.println(e);
            }

        }
    }
}
