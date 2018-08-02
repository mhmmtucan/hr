package com.example.demo.service;

import com.example.demo.model.User;

import java.util.List;
import java.util.UUID;

public interface UserService {
    public void addUser(User u);
    public void updateUser(User u);
    public List<User> listUsers();

    public User getUserById(UUID id);
    public User getUserByLinkedInId(String id);

    public boolean checkExists(String linkedInId);

    public void removeUser(UUID id);

    public List<User> searchUsers(String text);
}
