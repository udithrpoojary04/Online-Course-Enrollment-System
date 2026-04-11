package com.system.course.controller;

import com.system.course.entity.Course;
import com.system.course.entity.Enrollment;
import com.system.course.entity.StudyMaterial;
import com.system.course.entity.User;
import com.system.course.repository.CourseRepository;
import com.system.course.repository.EnrollmentRepository;
import com.system.course.repository.StudyMaterialRepository;
import com.system.course.security.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/student/course")
public class StudentCourseController {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @Autowired
    private StudyMaterialRepository studyMaterialRepository;

    @GetMapping("/{id}")
    public String viewCourseContent(@PathVariable("id") Long courseId,
                                    @AuthenticationPrincipal CustomUserDetails userDetails,
                                    Model model) {
        User student = userDetails.getUser();
        Course course = courseRepository.findById(courseId)
            .orElseThrow(() -> new IllegalArgumentException("Invalid course ID"));
            
        Enrollment enrollment = enrollmentRepository.findByStudentAndCourse(student, course)
            .orElseThrow(() -> new IllegalArgumentException("You are not enrolled in this course"));
            
        model.addAttribute("course", course);
        model.addAttribute("enrollment", enrollment);
        model.addAttribute("user", student);
        
        return "student_course_view";
    }

    @PostMapping("/{courseId}/complete/{materialId}")
    public String markMaterialComplete(@PathVariable("courseId") Long courseId,
                                       @PathVariable("materialId") Long materialId,
                                       @AuthenticationPrincipal CustomUserDetails userDetails) {
        User student = userDetails.getUser();
        Course course = courseRepository.findById(courseId)
            .orElseThrow(() -> new IllegalArgumentException("Invalid course ID"));
            
        Enrollment enrollment = enrollmentRepository.findByStudentAndCourse(student, course)
            .orElseThrow(() -> new IllegalArgumentException("You are not enrolled in this course"));
            
        StudyMaterial material = studyMaterialRepository.findById(materialId)
            .orElseThrow(() -> new IllegalArgumentException("Invalid material ID"));
            
        if (!enrollment.getCompletedMaterials().contains(material)) {
            enrollment.getCompletedMaterials().add(material);
            enrollment.calculateProgress();
            enrollmentRepository.save(enrollment);
        }
        
        return "redirect:/student/course/" + courseId;
    }
}
