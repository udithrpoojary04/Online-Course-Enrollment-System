package com.system.course.controller;

import com.system.course.security.CustomUserDetails;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @GetMapping({"/", "/dashboard"})
    public String dashboard(@AuthenticationPrincipal CustomUserDetails userDetails) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        String role = userDetails.getUser().getRole().name();
        if (role.equals("ROLE_ADMIN")) {
            return "redirect:/admin/dashboard";
        } else if (role.equals("ROLE_INSTRUCTOR")) {
            return "redirect:/instructor/dashboard";
        } else {
            return "redirect:/student/dashboard";
        }
    }
}
