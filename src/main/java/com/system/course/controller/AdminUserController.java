package com.system.course.controller;

import com.system.course.entity.Role;
import com.system.course.entity.User;
import com.system.course.repository.EnrollmentRepository;
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
@RequestMapping("/admin/users")
public class AdminUserController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping
    public String listUsers(Model model) {
        List<User> users = userRepository.findAll();
        model.addAttribute("users", users);

        long studentCount = userRepository.findByRole(Role.ROLE_STUDENT).size();
        long instructorCount = userRepository.findByRole(Role.ROLE_INSTRUCTOR).size();
        long adminCount = userRepository.findByRole(Role.ROLE_ADMIN).size();
        model.addAttribute("studentCount", studentCount);
        model.addAttribute("instructorCount", instructorCount);
        model.addAttribute("adminCount", adminCount);

        return "admin_users";
    }

    @GetMapping("/edit/{id}")
    public String showEditUserForm(@PathVariable Long id, Model model) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid user ID: " + id));
        model.addAttribute("editUser", user);
        return "admin_user_form";
    }

    @PostMapping("/edit/{id}")
    public String updateUser(@PathVariable Long id,
                             @RequestParam("fullName") String fullName,
                             @RequestParam("email") String email,
                             @RequestParam("role") String role,
                             @RequestParam(value = "password", required = false) String password,
                             Model model) {
        try {
            User user = userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid user ID: " + id));

            user.setFullName(fullName);
            user.setEmail(email);
            user.setRole(Role.valueOf(role));

            if (password != null && !password.trim().isEmpty()) {
                user.setPassword(passwordEncoder.encode(password));
            }

            userRepository.save(user);
            return "redirect:/admin/users?success=User updated successfully";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            User user = userRepository.findById(id).orElse(new User());
            model.addAttribute("editUser", user);
            return "admin_user_form";
        }
    }

    @PostMapping("/delete/{id}")
    public String deleteUser(@PathVariable Long id) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid user ID: " + id));

        if (user.getRole() == Role.ROLE_ADMIN) {
            long adminCount = userRepository.findByRole(Role.ROLE_ADMIN).size();
            if (adminCount <= 1) {
                return "redirect:/admin/users?error=Cannot delete the last admin account";
            }
        }

        // Delete enrollments for students before deleting the user
        if (user.getRole() == Role.ROLE_STUDENT) {
            enrollmentRepository.deleteByStudent(user);
        }

        userRepository.delete(user);
        return "redirect:/admin/users?success=User deleted successfully";
    }
}
