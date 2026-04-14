package com.system.course.controller;

import com.system.course.entity.Role;
import com.system.course.repository.CourseRepository;
import com.system.course.repository.EnrollmentRepository;
import com.system.course.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/settings")
public class AdminSettingsController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @GetMapping
    public String showSettings(Model model) {
        // Platform statistics
        model.addAttribute("totalUsers", userRepository.count());
        model.addAttribute("totalStudents", userRepository.findByRole(Role.ROLE_STUDENT).size());
        model.addAttribute("totalInstructors", userRepository.findByRole(Role.ROLE_INSTRUCTOR).size());
        model.addAttribute("totalAdmins", userRepository.findByRole(Role.ROLE_ADMIN).size());
        model.addAttribute("totalCourses", courseRepository.count());
        model.addAttribute("totalEnrollments", enrollmentRepository.count());

        // System information
        model.addAttribute("javaVersion", System.getProperty("java.version"));
        model.addAttribute("javaVendor", System.getProperty("java.vendor"));
        model.addAttribute("osName", System.getProperty("os.name"));
        model.addAttribute("osVersion", System.getProperty("os.version"));
        model.addAttribute("appVersion", "1.0.0");
        model.addAttribute("springBootVersion", "3.2.4");

        // Runtime info
        Runtime runtime = Runtime.getRuntime();
        long maxMemory = runtime.maxMemory() / (1024 * 1024);
        long totalMemory = runtime.totalMemory() / (1024 * 1024);
        long freeMemory = runtime.freeMemory() / (1024 * 1024);
        long usedMemory = totalMemory - freeMemory;
        model.addAttribute("maxMemory", maxMemory);
        model.addAttribute("usedMemory", usedMemory);
        model.addAttribute("freeMemory", freeMemory);

        return "admin_settings";
    }
}
