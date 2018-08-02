package com.example.demo.dao;

import com.example.demo.model.User;

import java.util.List;
import java.util.UUID;

public interface UserDAO {
    public void addUser(User u);

    public void updateUser(User u);

    public List<User> listAllUser();

    public User getUserById(UUID id);

    public User getUserByLinkedInId(String id);

    public boolean checkExists(String linkedInId);

    public void removeUser(UUID id);

    public List<User> searchUsers(String text);
}
