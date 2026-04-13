package com.system.course.controller;

import com.system.course.entity.Course;
import com.system.course.entity.Role;
import com.system.course.entity.StudyMaterial;
import com.system.course.entity.User;
import com.system.course.repository.CourseRepository;
import com.system.course.repository.StudyMaterialRepository;
import com.system.course.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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

    @Autowired
    private StudyMaterialRepository studyMaterialRepository;

    @GetMapping
    public String listCourses(Model model) {
        List<Course> courses = courseRepository.findAll();
        model.addAttribute("courses", courses);
        return "admin_courses";
    }

    @GetMapping("/new")
    public String showAddCourseForm(Model model) {
        model.addAttribute("course", new Course());
        model.addAttribute("isEdit", false);
        List<User> instructors = userRepository.findByRole(Role.ROLE_INSTRUCTOR);
        model.addAttribute("instructors", instructors);
        return "admin_course_form";
    }

    @PostMapping("/new")
    public String addCourse(@ModelAttribute("course") Course course, 
                            @RequestParam("instructorId") Long instructorId,
                            @RequestParam(value = "materialTitle", required = false) List<String> materialTitles,
                            @RequestParam(value = "materialUrl", required = false) List<String> materialUrls,
                            Model model) {
        try {
            User instructor = userRepository.findById(instructorId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid instructor ID"));
            
            course.setInstructor(instructor);
            
            // Save the course first so we have an ID
            Course savedCourse = courseRepository.save(course);
            
            if (materialTitles != null && materialUrls != null) {
                for (int i = 0; i < materialTitles.size(); i++) {
                    String title = materialTitles.get(i);
                    String url = materialUrls.get(i);
                    
                    if (title != null && !title.trim().isEmpty() && url != null && !url.trim().isEmpty()) {
                        StudyMaterial material = new StudyMaterial();
                        material.setTitle(title);
                        material.setContentUrl(url);
                        material.setCourse(savedCourse);
                        studyMaterialRepository.save(material);
                    }
                }
            }
            
            return "redirect:/admin/courses?success=Course added successfully";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to add course: " + e.getMessage());
            model.addAttribute("isEdit", false);
            List<User> instructors = userRepository.findByRole(Role.ROLE_INSTRUCTOR);
            model.addAttribute("instructors", instructors);
            return "admin_course_form";
        }
    }

    @GetMapping("/edit/{id}")
    public String showEditCourseForm(@PathVariable Long id, Model model) {
        Course course = courseRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid course ID: " + id));
        model.addAttribute("course", course);
        model.addAttribute("isEdit", true);
        List<User> instructors = userRepository.findByRole(Role.ROLE_INSTRUCTOR);
        model.addAttribute("instructors", instructors);
        return "admin_course_form";
    }

    @PostMapping("/edit/{id}")
    public String updateCourse(@PathVariable Long id,
                               @ModelAttribute("course") Course courseForm,
                               @RequestParam("instructorId") Long instructorId,
                               @RequestParam(value = "materialTitle", required = false) List<String> materialTitles,
                               @RequestParam(value = "materialUrl", required = false) List<String> materialUrls,
                               Model model) {
        try {
            Course existingCourse = courseRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid course ID: " + id));
            User instructor = userRepository.findById(instructorId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid instructor ID"));

            existingCourse.setTitle(courseForm.getTitle());
            existingCourse.setDescription(courseForm.getDescription());
            existingCourse.setPrice(courseForm.getPrice());
            existingCourse.setDurationInWeeks(courseForm.getDurationInWeeks());
            existingCourse.setInstructor(instructor);

            // Clear old materials and add new ones
            existingCourse.getMaterials().clear();
            courseRepository.save(existingCourse);

            if (materialTitles != null && materialUrls != null) {
                for (int i = 0; i < materialTitles.size(); i++) {
                    String title = materialTitles.get(i);
                    String url = materialUrls.get(i);

                    if (title != null && !title.trim().isEmpty() && url != null && !url.trim().isEmpty()) {
                        StudyMaterial material = new StudyMaterial();
                        material.setTitle(title);
                        material.setContentUrl(url);
                        material.setCourse(existingCourse);
                        studyMaterialRepository.save(material);
                    }
                }
            }

            return "redirect:/admin/courses?success=Course updated successfully";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to update course: " + e.getMessage());
            model.addAttribute("isEdit", true);
            Course course = courseRepository.findById(id).orElse(courseForm);
            model.addAttribute("course", course);
            List<User> instructors = userRepository.findByRole(Role.ROLE_INSTRUCTOR);
            model.addAttribute("instructors", instructors);
            return "admin_course_form";
        }
    }
}
