package com.example.demo.service;

import com.example.demo.dao.ApplicationDAO;
import com.example.demo.model.Application;
import com.example.demo.model.Job;
import com.example.demo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service("applicationService")
public class ApplicationServiceImpl implements ApplicationService {
    private ApplicationDAO applicationDAO;

    @Autowired
    public void setApplicationDAO(ApplicationDAO applicationDAO) {
        this.applicationDAO = applicationDAO;
    }

    @Override
    public void createApplicaiton(Application app) {
        this.applicationDAO.createApplicaiton(app);
    }

    @Override
    public void removeApplication(UUID id) {
        this.applicationDAO.removeApplication(id);
    }

    @Override
    public void updateApplication(Application app) {
        this.applicationDAO.updateApplication(app);
    }

    @Override
    public Application getApplicationById(UUID id) {
        return this.applicationDAO.getApplicationById(id);
    }

    @Override
    public List<Application> getApplicationsByJob(Job job) {
        return this.applicationDAO.getApplicationsByJob(job);
    }

    @Override
    public List<Application> getApplicationsByUser(User user) {
        return this.applicationDAO.getApplicationsByUser(user);
    }

    @Override
    public List<Application> listAllApplication() {
        return this.applicationDAO.listAllApplication();
    }

    @Override
    public List<Application> searchApplicants(String text, UUID jobId) {
        return this.applicationDAO.searchApplicants(text, jobId);
    }

    @Override
    public boolean checkApplicationExists(UUID jobId, UUID userId) {
        return this.applicationDAO.checkApplicationExists(jobId, userId);
    }
}
