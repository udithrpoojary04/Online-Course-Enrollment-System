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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/student/enroll")
public class StudentCourseController {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @PostMapping
    public String enrollInCourse(@AuthenticationPrincipal CustomUserDetails userDetails, 
                                 @RequestParam("courseId") Long courseId) {
        User student = userDetails.getUser();
        
        Course course = courseRepository.findById(courseId)
            .orElseThrow(() -> new IllegalArgumentException("Invalid course ID"));
            
        if (!enrollmentRepository.existsByStudentAndCourse(student, course)) {
            Enrollment enrollment = new Enrollment();
            enrollment.setStudent(student);
            enrollment.setCourse(course);
            enrollment.setProgressPercentage(0);
            enrollmentRepository.save(enrollment);
            return "redirect:/student/dashboard?enrolled=true";
        }
        
        return "redirect:/student/dashboard?error=already_enrolled";
    }
}
