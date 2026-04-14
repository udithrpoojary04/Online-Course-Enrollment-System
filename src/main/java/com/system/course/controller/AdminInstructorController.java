package com.system.course.controller;

import com.system.course.entity.Role;
import com.system.course.entity.User;
import com.system.course.repository.CourseRepository;
import com.system.course.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin/instructors")
public class AdminInstructorController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping
    public String listInstructors(Model model) {
        List<User> instructors = userRepository.findByRole(Role.ROLE_INSTRUCTOR);
        model.addAttribute("instructors", instructors);
        return "admin_instructors";
    }

    @GetMapping("/new")
    public String showAddInstructorForm(Model model) {
        model.addAttribute("instructor", new User());
        model.addAttribute("isEdit", false);
        return "admin_instructor_form";
    }

    @PostMapping("/new")
    public String addInstructor(@RequestParam("username") String username,
                                @RequestParam("fullName") String fullName,
                                @RequestParam("email") String email,
                                @RequestParam("password") String password,
                                Model model) {
        try {
            if (userRepository.existsByUsername(username)) {
                throw new IllegalArgumentException("Username '" + username + "' is already taken.");
            }

            User instructor = new User();
            instructor.setUsername(username);
            instructor.setFullName(fullName);
            instructor.setEmail(email);
            instructor.setPassword(passwordEncoder.encode(password));
            instructor.setRole(Role.ROLE_INSTRUCTOR);
            userRepository.save(instructor);

            return "redirect:/admin/instructors?success=Instructor added successfully";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("isEdit", false);
            User instructor = new User();
            instructor.setUsername(username);
            instructor.setFullName(fullName);
            instructor.setEmail(email);
            model.addAttribute("instructor", instructor);
            return "admin_instructor_form";
        }
    }

    @GetMapping("/edit/{id}")
    public String showEditInstructorForm(@PathVariable Long id, Model model) {
        User instructor = userRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid instructor ID: " + id));

        if (instructor.getRole() != Role.ROLE_INSTRUCTOR) {
            return "redirect:/admin/instructors?error=User is not an instructor";
        }

        model.addAttribute("instructor", instructor);
        model.addAttribute("isEdit", true);
        return "admin_instructor_form";
    }

    @PostMapping("/edit/{id}")
    public String updateInstructor(@PathVariable Long id,
                                   @RequestParam("fullName") String fullName,
                                   @RequestParam("email") String email,
                                   @RequestParam(value = "password", required = false) String password,
                                   Model model) {
        try {
            User instructor = userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid instructor ID: " + id));

            instructor.setFullName(fullName);
            instructor.setEmail(email);

            if (password != null && !password.trim().isEmpty()) {
                instructor.setPassword(passwordEncoder.encode(password));
            }

            userRepository.save(instructor);
            return "redirect:/admin/instructors?success=Instructor updated successfully";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("isEdit", true);
            User instructor = userRepository.findById(id).orElse(new User());
            model.addAttribute("instructor", instructor);
            return "admin_instructor_form";
        }
    }

    @PostMapping("/delete/{id}")
    public String deleteInstructor(@PathVariable Long id) {
        User instructor = userRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid instructor ID: " + id));

        // Check if instructor has assigned courses
        long courseCount = courseRepository.findByInstructor(instructor).size();
        if (courseCount > 0) {
            return "redirect:/admin/instructors?error=Cannot delete instructor with " + courseCount + " assigned course(s). Reassign courses first.";
        }

        userRepository.delete(instructor);
        return "redirect:/admin/instructors?success=Instructor deleted successfully";
    }
}
