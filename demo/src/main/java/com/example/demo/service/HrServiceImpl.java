package com.example.demo.service;

import com.example.demo.dao.HrDAO;
import com.example.demo.model.Hr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service("hrService")
public class HrServiceImpl implements HrService {
    private HrDAO hrDAO;

    @Autowired
    public void setHrDAO(HrDAO hrDAO) {
        this.hrDAO = hrDAO;
    }

    @Override
    public void addHr(Hr hr) {
        this.hrDAO.addHr(hr);
    }

    @Override
    public Hr getHrById(UUID id) {
        return this.hrDAO.getHrById(id);
    }

    @Override
    public Hr getHrByUsername(String username) {
        return this.hrDAO.getHrByUsername(username);
    }

    @Override
    public List<Hr> listHr() {
        return this.hrDAO.listAllHr();
    }
}
