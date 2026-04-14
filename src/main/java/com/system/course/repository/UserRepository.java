package com.system.course.repository;

import com.system.course.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    boolean existsByUsername(String username);
    java.util.List<User> findByRole(com.system.course.entity.Role role);
    boolean existsByEmail(String email);
}
