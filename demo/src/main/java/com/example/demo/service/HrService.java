package com.example.demo.service;

import com.example.demo.model.Hr;

import java.util.List;
import java.util.UUID;

public interface HrService {
    public void addHr(Hr hr);

    public Hr getHrById(UUID id);

    public Hr getHrByUsername(String username);

    public List<Hr> listHr();
}
