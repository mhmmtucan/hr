package com.example.demo.dao;

import com.example.demo.model.Hr;
import com.example.demo.model.Job;

import java.util.List;
import java.util.UUID;

public interface JobDAO {
    public void addJob(Job j);

    public void deleteJob(UUID id);

    public void updateJob(Job j);

    public Job getJobById(UUID id);

    public List<Job> getJobsByHr(Hr hr);

    public List<Job> listAllJob();

    public List<Job> listFeaturedJobs();

    public List<Job> listActiveJobs();

    public List<Job> listActiveDateActiveJobs();

    public List<Job> getJobsWithRange(int min, int max);

    public List<Job> searchJobs(String text);

}
