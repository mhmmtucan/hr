package com.example.demo.service;

import com.example.demo.model.Application;
import com.example.demo.model.Job;
import com.example.demo.model.User;

import java.util.List;
import java.util.UUID;

public interface ApplicationService {
    public void createApplicaiton(Application app);

    public void removeApplication(UUID id);

    public void updateApplication(Application app);

    public Application getApplicationById(UUID id);

    public List<Application> getApplicationsByJob(Job job);

    public List<Application> getApplicationsByUser(User user);

    public List<Application> listAllApplication();

    public List<Application> searchApplicants(String text, UUID jobId);

    public boolean checkApplicationExists(UUID jobId, UUID userId);

}
