package com.system.course.repository;

import com.system.course.entity.Course;
import com.system.course.entity.Enrollment;
import com.system.course.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Long> {
    List<Enrollment> findByStudent(User student);
    List<Enrollment> findByCourse(Course course);
    Optional<Enrollment> findByStudentAndCourse(User student, Course course);
    boolean existsByStudentAndCourse(User student, Course course);
    long countByStudent(User student);
    @org.springframework.transaction.annotation.Transactional
    void deleteByStudent(User student);
    @org.springframework.transaction.annotation.Transactional
    void deleteByCourse(Course course);
}
