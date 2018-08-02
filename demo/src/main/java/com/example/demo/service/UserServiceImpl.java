package com.example.demo.service;

import com.example.demo.dao.UserDAO;
import com.example.demo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service("userService")
public class UserServiceImpl implements UserService {
    private UserDAO userDAO;

    @Autowired
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Override
    public void addUser(User u) {
        this.userDAO.addUser(u);
    }

    @Override
    public void updateUser(User u) {
        this.userDAO.updateUser(u);
    }

    @Override
    public List<User> listUsers() {
        return this.userDAO.listAllUser();
    }

    @Override
    public User getUserById(UUID id) {
        return this.userDAO.getUserById(id);
    }

    @Override
    public User getUserByLinkedInId(String id) {
        return this.userDAO.getUserByLinkedInId(id);
    }

    @Override
    public boolean checkExists(String linkedInId) {
        return this.userDAO.checkExists(linkedInId);
    }

    @Override
    public void removeUser(UUID id) {
        this.userDAO.removeUser(id);
    }

    @Override
    public List<User> searchUsers(String text) {
        return this.userDAO.searchUsers(text);
    }
}
