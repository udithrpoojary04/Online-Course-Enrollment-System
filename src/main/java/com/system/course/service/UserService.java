package com.system.course.service;

import com.system.course.entity.Role;
import com.system.course.entity.User;
import com.system.course.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    public void registerUser(User user, Role role) {
        if (userRepository.existsByUsername(user.getUsername())) {
            throw new IllegalArgumentException("Username is already taken");
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(role);
        userRepository.save(user);
    }
}
