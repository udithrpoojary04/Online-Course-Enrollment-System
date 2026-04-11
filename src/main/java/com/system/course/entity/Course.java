package com.system.course.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "courses")
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String title;
    
    @Column(length = 2000)
    private String description;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "instructor_id")
    private User instructor;
    
    private BigDecimal price;
    
    private Integer durationInWeeks;

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL, orphanRemoval = true)
    private java.util.List<StudyMaterial> materials = new java.util.ArrayList<>();

    public Course() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public User getInstructor() { return instructor; }
    public void setInstructor(User instructor) { this.instructor = instructor; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public Integer getDurationInWeeks() { return durationInWeeks; }
    public void setDurationInWeeks(Integer durationInWeeks) { this.durationInWeeks = durationInWeeks; }

    public java.util.List<StudyMaterial> getMaterials() { return materials; }
    public void setMaterials(java.util.List<StudyMaterial> materials) { this.materials = materials; }
}
