package com.system.course.config;

import com.system.course.entity.Role;
import com.system.course.entity.User;
import com.system.course.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class DataInitializer {

    @Bean
    public CommandLineRunner loadData(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        return args -> {
            if (!userRepository.existsByUsername("admin")) {
                User admin = new User();
                admin.setUsername("admin");
                admin.setPassword(passwordEncoder.encode("admin123"));
                admin.setFullName("System Administrator");
                admin.setEmail("admin@eliteacademy.com");
                admin.setRole(Role.ROLE_ADMIN);
                userRepository.save(admin);
            }
            if (!userRepository.existsByUsername("instructor")) {
                User instructor = new User();
                instructor.setUsername("instructor");
                instructor.setPassword(passwordEncoder.encode("teach123"));
                instructor.setFullName("Master Instructor");
                instructor.setEmail("instructor@eliteacademy.com");
                instructor.setRole(Role.ROLE_INSTRUCTOR);
                userRepository.save(instructor);
            }
        };
    }
}
