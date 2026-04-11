package com.system.course.controller;

import com.system.course.entity.Course;
import com.system.course.entity.Role;
import com.system.course.entity.User;
import com.system.course.repository.CourseRepository;
import com.system.course.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin/courses")
public class AdminCourseController {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String listCourses(Model model) {
        List<Course> courses = courseRepository.findAll();
        model.addAttribute("courses", courses);
        return "admin_courses";
    }

    @GetMapping("/new")
    public String showAddCourseForm(Model model) {
        model.addAttribute("course", new Course());
        List<User> instructors = userRepository.findByRole(Role.ROLE_INSTRUCTOR);
        model.addAttribute("instructors", instructors);
        return "admin_course_form";
    }

    @PostMapping("/new")
    public String addCourse(@ModelAttribute("course") Course course, 
                            @RequestParam("instructorId") Long instructorId,
                            Model model) {
        try {
            User instructor = userRepository.findById(instructorId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid instructor ID"));
            
            course.setInstructor(instructor);
            courseRepository.save(course);
            return "redirect:/admin/courses?success=Course added successfully";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to add course: " + e.getMessage());
            List<User> instructors = userRepository.findByRole(Role.ROLE_INSTRUCTOR);
            model.addAttribute("instructors", instructors);
            return "admin_course_form";
        }
    }
}
