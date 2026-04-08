package com.system.course.controller;

import com.system.course.security.CustomUserDetails;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RoleSpecificController {

    @GetMapping("/admin/dashboard")
    public String adminDashboard(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        model.addAttribute("user", userDetails.getUser());
        return "admin_dashboard";
    }

    @GetMapping("/instructor/dashboard")
    public String instructorDashboard(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        model.addAttribute("user", userDetails.getUser());
        return "instructor_dashboard";
    }

    @GetMapping("/student/dashboard")
    public String studentDashboard(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        model.addAttribute("user", userDetails.getUser());
        return "student_dashboard";
    }
}
