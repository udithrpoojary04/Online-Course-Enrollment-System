package com.system.course.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "enrollments")
public class Enrollment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", nullable = false)
    private User student;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;
    
    private Integer progressPercentage = 0;
    
    private boolean completed = false;
    
    private LocalDateTime enrollmentDate;

    @ManyToMany
    @JoinTable(
        name = "enrollment_completed_materials",
        joinColumns = @JoinColumn(name = "enrollment_id"),
        inverseJoinColumns = @JoinColumn(name = "material_id")
    )
    private java.util.Set<StudyMaterial> completedMaterials = new java.util.HashSet<>();
    
    public void calculateProgress() {
        if (course == null || course.getMaterials().isEmpty()) {
            this.progressPercentage = 0;
            return;
        }
        int total = course.getMaterials().size();
        int done = completedMaterials.size();
        this.progressPercentage = (done * 100) / total;
        if (this.progressPercentage >= 100) {
            this.completed = true;
        }
    }

    @PrePersist
    protected void onCreate() {
        enrollmentDate = LocalDateTime.now();
    }

    public Enrollment() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getStudent() { return student; }
    public void setStudent(User student) { this.student = student; }

    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }

    public Integer getProgressPercentage() { return progressPercentage; }
    public void setProgressPercentage(Integer progressPercentage) { this.progressPercentage = progressPercentage; }

    public boolean isCompleted() { return completed; }
    public void setCompleted(boolean completed) { this.completed = completed; }

    public LocalDateTime getEnrollmentDate() { return enrollmentDate; }
    public void setEnrollmentDate(LocalDateTime enrollmentDate) { this.enrollmentDate = enrollmentDate; }

    public java.util.Set<StudyMaterial> getCompletedMaterials() { return completedMaterials; }
    public void setCompletedMaterials(java.util.Set<StudyMaterial> completedMaterials) { this.completedMaterials = completedMaterials; }
}
