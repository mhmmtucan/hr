package com.example.demo.service;

import com.example.demo.dao.JobDAO;
import com.example.demo.model.Hr;
import com.example.demo.model.Job;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service("jobService")
public class JobServiceImpl implements JobService {
    private JobDAO jobDAO;

    @Autowired
    public void setJobDAO(JobDAO jobDAO) {
        this.jobDAO = jobDAO;
    }

    @Override
    public void addJob(Job j) {
        this.jobDAO.addJob(j);
    }

    @Override
    public void deleteJob(UUID id) {
        this.jobDAO.deleteJob(id);
    }

    @Override
    public void updateJob(Job j) {
        this.jobDAO.updateJob(j);
    }

    @Override
    public Job getJobById(UUID id) {
        return this.jobDAO.getJobById(id);
    }

    @Override
    public List<Job> getJobsByHr(Hr hr) {
        return this.jobDAO.getJobsByHr(hr);
    }

    @Override
    public List<Job> listAllJob() {
        return this.jobDAO.listAllJob();
    }

    @Override
    public List<Job> listFeaturedJobs() {
        return this.jobDAO.listFeaturedJobs();
    }

    @Override
    public List<Job> listActiveJobs() {
        return this.jobDAO.listActiveJobs();
    }

    @Override
    public List<Job> listActiveDateActiveJobs() {
        return this.jobDAO.listActiveDateActiveJobs();
    }

    @Override
    public List<Job> getJobsWithRange(int min, int max) {
        return this.jobDAO.getJobsWithRange(min, max);
    }

    @Override
    public List<Job> searchJobs(String text) {
        return this.jobDAO.searchJobs(text);
    }
}
