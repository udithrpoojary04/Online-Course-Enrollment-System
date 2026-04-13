package com.system.course.controller;

import com.system.course.security.CustomUserDetails;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RoleSpecificController {

    @org.springframework.beans.factory.annotation.Autowired
    private com.system.course.repository.EnrollmentRepository enrollmentRepository;
    @org.springframework.beans.factory.annotation.Autowired
    private com.system.course.repository.CourseRepository courseRepository;
    @org.springframework.beans.factory.annotation.Autowired
    private com.system.course.repository.UserRepository userRepository;
    @org.springframework.beans.factory.annotation.Autowired
    private org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    @GetMapping("/admin/dashboard")
    public String adminDashboard(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        model.addAttribute("user", userDetails.getUser());
        
        long totalUsers = userRepository.count();
        model.addAttribute("totalUsers", totalUsers);
        
        java.util.List<com.system.course.entity.Enrollment> allEnrollments = enrollmentRepository.findAll();
        java.math.BigDecimal totalRevenue = allEnrollments.stream()
            .map(e -> e.getCourse().getPrice())
            .filter(java.util.Objects::nonNull)
            .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);
        model.addAttribute("totalRevenue", totalRevenue);
        
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

    @PostMapping("/student/enroll")
    public String enrollInCourse(@RequestParam("courseId") Long courseId,
                                 @AuthenticationPrincipal CustomUserDetails userDetails) {
        com.system.course.entity.User student = userDetails.getUser();
        com.system.course.entity.Course course = courseRepository.findById(courseId)
            .orElseThrow(() -> new IllegalArgumentException("Invalid course ID"));

        if (!enrollmentRepository.existsByStudentAndCourse(student, course)) {
            com.system.course.entity.Enrollment enrollment = new com.system.course.entity.Enrollment();
            enrollment.setStudent(student);
            enrollment.setCourse(course);
            enrollment.setProgressPercentage(0);
            enrollmentRepository.save(enrollment);
            return "redirect:/student/dashboard?enrolled=true";
        }
        
        return "redirect:/student/dashboard?error=already_enrolled";
    }

    @PostMapping("/student/profile/update")
    public String updateProfile(@RequestParam("fullName") String fullName,
                                @RequestParam("email") String email,
                                @RequestParam(value = "newPassword", required = false) String newPassword,
                                @AuthenticationPrincipal CustomUserDetails userDetails) {
        com.system.course.entity.User student = userRepository.findById(userDetails.getUser().getId())
            .orElseThrow(() -> new IllegalArgumentException("User not found"));

        student.setFullName(fullName);
        student.setEmail(email);

        if (newPassword != null && !newPassword.trim().isEmpty()) {
            student.setPassword(passwordEncoder.encode(newPassword));
        }

        userRepository.save(student);

        // Refresh the security context with updated user details
        CustomUserDetails updatedDetails = new CustomUserDetails(student);
        UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(
            updatedDetails, updatedDetails.getPassword(), updatedDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(newAuth);

        return "redirect:/student/dashboard?profileUpdated=true";
    }
}
