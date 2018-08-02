package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.Cascade;
import org.hibernate.search.annotations.*;
import org.hibernate.search.annotations.Index;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Entity(name = "Job")
@Table(name = "job")
@Indexed
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Job {
    @Id
    @Column(name = "id", updatable = false, nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @JsonIgnore
    @JoinColumn(name = "hr_id", referencedColumnName = "id", nullable = false)
    @OneToOne(targetEntity = Hr.class, fetch = FetchType.LAZY)
    @Cascade(org.hibernate.annotations.CascadeType.SAVE_UPDATE)
    private Hr hr;

    @Transient
    private int hr_id;

    @Transient
    private List<String> qualificationList;

    @Field(index = Index.YES, analyze = Analyze.YES, store = Store.NO)
    private String company;

    @Field(index = Index.YES, analyze = Analyze.YES, store = Store.NO)
    private String activation_date;

    @Field(index = Index.YES, analyze = Analyze.YES, store = Store.NO)
    private String final_date;

    @Field(index = Index.YES, analyze = Analyze.YES, store = Store.NO, analyzer = @Analyzer(definition = "textanalyzer"))
    private String title;
    @Field(index = Index.YES, analyze = Analyze.YES, store = Store.NO, analyzer = @Analyzer(definition = "textanalyzer"))
    private String summary;

    @Field(index = Index.YES, analyze = Analyze.YES, store = Store.NO, analyzer = @Analyzer(definition = "textanalyzer"))
    private String description;
    @Field(index = Index.YES, analyze = Analyze.YES, store = Store.NO)
    private String qualification;

    private boolean featured;
    @Field(index = Index.YES, analyze = Analyze.YES, store = Store.NO)
    private boolean isactive;
    @Field(index = Index.YES, analyze = Analyze.YES, store = Store.NO)
    private boolean isdateactive;

    public Job(String title, String description, String summary, String qualification, String activation_date, String final_date) {
        this.title = title;
        this.summary = summary;
        this.description = description;
        this.qualification = qualification;
        this.activation_date = activation_date;
        this.final_date = final_date;
    }

    public Job() {
    }
    public void setHr_id(int hr_id) {
        this.hr_id = hr_id;
    }

    public int getHr_id() {
        return hr_id;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public Hr getHr() {
        return hr;
    }

    public void setHr(Hr hr) {
        this.hr = hr;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getActivation_date() {
        return activation_date;
    }

    public void setActivation_date(String activation_date) {
        this.activation_date = activation_date;
    }

    public String getFinal_date() {
        return final_date;
    }

    public void setFinal_date(String final_date) {
        this.final_date = final_date;
    }

    public boolean isFeatured() {
        return featured;
    }

    public void setFeatured(boolean featured) {
        this.featured = featured;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public boolean isIsactive() {
        return isactive;
    }

    public void setIsactive(boolean isactive) {
        this.isactive = isactive;
    }

    public List<String> getQualificationList() {
        return qualificationList;
    }

    public void setQualificationList(List<String> qualificationList) {
        this.qualificationList = qualificationList;
    }

    public Date getFinalDateAsDate() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");
        try {
            return simpleDateFormat.parse(final_date);
        } catch (Exception e) {
            System.out.println("error" + e);
            return null;
        }
    }

    public boolean isIsdateactive() {
        return isdateactive;
    }

    public void setIsdateactive(boolean isdateactive) {
        this.isdateactive = isdateactive;
    }


    public boolean checkIfDateActive() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");
        Date date = new Date();
        try {
            return simpleDateFormat.parse(activation_date).compareTo(date) <= 0 && simpleDateFormat.parse(final_date).compareTo(date) >= 0;
        } catch (Exception e) {
            return false;
        }
    }
}
