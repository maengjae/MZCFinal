package com.springtest.springtest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springtest.springtest.model.User;
import com.springtest.springtest.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User registerUser(String username, String password) {
        // Check if username is already taken
        if (userRepository.findByUsername(username) != null) {
            throw new RuntimeException("Username already exists");
        }

        // Create a new user entity and save it to the database
        User user = new User(username, password);
        return userRepository.save(user);
    }

    public User loginUser(String username, String password) {
        // Find user by username
        User user = userRepository.findByUsername(username);

        // Check if user exists and password matches
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }

        // If user does not exist or password does not match, return null
        return null;
    }
}
