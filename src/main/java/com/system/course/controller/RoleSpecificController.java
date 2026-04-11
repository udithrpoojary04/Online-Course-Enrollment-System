package com.system.course.controller;

import com.system.course.security.CustomUserDetails;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RoleSpecificController {

    @org.springframework.beans.factory.annotation.Autowired
    private com.system.course.repository.EnrollmentRepository enrollmentRepository;
    @org.springframework.beans.factory.annotation.Autowired
    private com.system.course.repository.CourseRepository courseRepository;

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
        com.system.course.entity.User student = userDetails.getUser();
        model.addAttribute("user", student);
        
        java.util.List<com.system.course.entity.Enrollment> enrollments = enrollmentRepository.findByStudent(student);
        model.addAttribute("enrollments", enrollments);
        
        java.util.List<com.system.course.entity.Course> allCourses = courseRepository.findAll();
        java.util.List<com.system.course.entity.Course> availableCourses = allCourses.stream()
            .filter(course -> enrollments.stream().noneMatch(e -> e.getCourse().getId().equals(course.getId())))
            .collect(java.util.stream.Collectors.toList());
            
        model.addAttribute("availableCourses", availableCourses);
        model.addAttribute("activeCourseCount", enrollments.size());
        
        return "student_dashboard";
    }
}
