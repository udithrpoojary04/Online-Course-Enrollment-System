package com.system.course.controller;

import com.system.course.entity.Course;
import com.system.course.entity.Enrollment;
import com.system.course.entity.User;
import com.system.course.repository.CourseRepository;
import com.system.course.repository.EnrollmentRepository;
import com.system.course.security.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.time.format.DateTimeFormatter;
import java.util.Optional;

@Controller
public class CertificateController {

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @Autowired
    private CourseRepository courseRepository;

    @GetMapping("/student/certificate/{courseId}")
    public String viewCertificate(@PathVariable("courseId") Long courseId,
                                  @AuthenticationPrincipal CustomUserDetails userDetails,
                                  Model model) {
        User student = userDetails.getUser();
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid course ID"));

        Optional<Enrollment> enrollmentOpt = enrollmentRepository.findByStudent(student).stream()
                .filter(e -> e.getCourse().getId().equals(courseId))
                .findFirst();

        if (!enrollmentOpt.isPresent()) {
            return "redirect:/student/dashboard?error=not_enrolled";
        }

        Enrollment enrollment = enrollmentOpt.get();

        if (!enrollment.isCompleted()) {
            return "redirect:/student/dashboard?error=course_not_completed";
        }

        model.addAttribute("studentName", student.getFullName());
        model.addAttribute("courseTitle", course.getTitle());
        model.addAttribute("instructorName", course.getInstructor() != null ? course.getInstructor().getFullName() : "Elite Academy Instructor");
        
        // Use current date for the certificate view placeholder
        String issueDate = java.time.LocalDate.now().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy"));
        model.addAttribute("issueDate", issueDate);

        // Generate a random certificate ID for aesthetics
        String certificateId = java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        model.addAttribute("certificateId", "EA-" + certificateId);

        return "certificate";
    }
}
