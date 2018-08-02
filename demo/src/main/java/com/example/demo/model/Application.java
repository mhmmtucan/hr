package com.example.demo.model;

import org.hibernate.search.annotations.Indexed;
import org.hibernate.search.annotations.IndexedEmbedded;

import javax.persistence.*;
import java.util.UUID;

@Entity(name = "Application")
@Table(name = "application")
@Indexed
public class Application {
    @Id
    @Column(name = "id", updatable = false, nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @IndexedEmbedded(includePaths = {"name", "surname", "highschool", "university", "department", "email", "qualification", "title"})
    @OneToOne(targetEntity = User.class)
    @JoinColumn(name = "user_id")
    private User user;

    //@OneToOne(targetEntity = Job.class, cascade = CascadeType.ALL, fetch = FetchType.LAZY, optional = false)
    @IndexedEmbedded(includePaths = {"id"})
    @OneToOne(targetEntity = Job.class)
    @JoinColumn(name = "job_id")
    private Job job;

    private String currentstatus;
    private double user_score;

    public Application() {
    }

    public Application(User u, Job j) {
        this.user = u;
        this.job = j;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Job getJob() {
        return job;
    }

    public void setJob(Job job) {
        this.job = job;
    }

    public String getCurrentstatus() {
        return currentstatus;
    }

    public void setCurrentstatus(String currentStatus) {
        this.currentstatus = currentStatus;
    }

    public double getUser_score() {
        return user_score;
    }

    public void setUser_score(double user_score) {
        this.user_score = user_score;
    }
}


