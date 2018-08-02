package com.example.demo.dao;

import com.example.demo.model.Hr;

import java.util.List;
import java.util.UUID;

public interface HrDAO {
    public void addHr(Hr hr);

    public Hr getHrById(UUID id);

    public Hr getHrByUsername(String username);

    public List<Hr> listAllHr();
}
