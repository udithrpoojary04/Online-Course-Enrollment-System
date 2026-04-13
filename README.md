# Online Course Enrollment System

A full-stack web application built with **Spring Boot** that allows students to browse and enroll in courses, instructors to manage course content, and administrators to oversee the entire platform.

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Database Setup](#database-setup)
  - [Configuration](#configuration)
  - [Build & Run](#build--run)
- [Default Credentials](#default-credentials)
- [Application URLs](#application-urls)
- [Role-Based Access](#role-based-access)

---

## Features

### Admin
- Dedicated admin login portal (`/admin/login`)
- Dashboard with platform overview
- Create, edit, and manage courses
- Assign instructors to courses
- Add study materials (title + URL) to each course

### Instructor
- View assigned courses and enrolled students from the instructor dashboard

### Student
- Register and log in
- Browse available courses and enroll
- Access study materials for enrolled courses
- Mark individual study materials as complete
- Track course progress as a percentage

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Java 21 |
| Framework | Spring Boot 3.2.4 |
| Security | Spring Security (BCrypt, role-based) |
| Persistence | Spring Data JPA / Hibernate |
| Database | MySQL 8 (production), H2 (embedded/dev) |
| View Layer | JSP + JSTL |
| Build Tool | Maven |
| Packaging | WAR |

---

## Project Structure

```
src/main/
├── java/com/system/course/
│   ├── config/
│   │   ├── DataInitializer.java      # Seeds default admin & instructor accounts
│   │   └── SecurityConfig.java       # Dual security filter chains (admin / user)
│   ├── controller/
│   │   ├── AdminCourseController.java
│   │   ├── AuthController.java
│   │   ├── DashboardController.java
│   │   ├── RoleSpecificController.java
│   │   └── StudentCourseController.java
│   ├── entity/
│   │   ├── Course.java
│   │   ├── Enrollment.java
│   │   ├── Role.java                 # ROLE_ADMIN, ROLE_INSTRUCTOR, ROLE_STUDENT
│   │   ├── StudyMaterial.java
│   │   └── User.java
│   ├── repository/
│   │   ├── CourseRepository.java
│   │   ├── EnrollmentRepository.java
│   │   ├── StudyMaterialRepository.java
│   │   └── UserRepository.java
│   ├── security/
│   │   ├── CustomUserDetails.java
│   │   └── CustomUserDetailsService.java
│   └── service/
│       └── UserService.java
├── resources/
│   ├── application.properties
│   └── static/css/style.css
└── webapp/WEB-INF/jsp/               # JSP view templates
    ├── admin_login.jsp
    ├── admin_dashboard.jsp
    ├── admin_courses.jsp
    ├── admin_course_form.jsp
    ├── instructor_dashboard.jsp
    ├── login.jsp
    ├── register.jsp
    ├── student_dashboard.jsp
    └── student_course_view.jsp
```

---

## Getting Started

### Prerequisites

- Java 21+
- Maven 3.8+
- MySQL 8+

### Database Setup

1. Create the database in MySQL:

```sql
CREATE DATABASE course_enrollment;
```

2. Ensure a MySQL user has access to it. The default configuration uses `root` with a custom password (see [Configuration](#configuration) below).

### Configuration

Edit `src/main/resources/application.properties` and update the datasource credentials:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/course_enrollment?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=<your_password>
```

The application will automatically create / update the schema on startup (`spring.jpa.hibernate.ddl-auto=update`).

### Build & Run

```bash
# Using the Maven wrapper
./mvnw spring-boot:run

# Or build a WAR and deploy it
./mvnw clean package
```

The application starts on **port 8085** by default.

---

## Default Credentials

These accounts are seeded automatically on the first startup via `DataInitializer`.

| Role | Username | Password |
|---|---|---|
| Admin | `admin` | `admin123` |
| Instructor | `instructor` | `teach123` |

Student accounts are created through the self-registration page (`/register`).

---

## Application URLs

| URL | Description |
|---|---|
| `http://localhost:8085/` | Home / landing page |
| `http://localhost:8085/register` | Student self-registration |
| `http://localhost:8085/login` | Student & instructor login |
| `http://localhost:8085/dashboard` | Role-based dashboard redirect |
| `http://localhost:8085/student/**` | Student course & progress views |
| `http://localhost:8085/instructor/**` | Instructor dashboard |
| `http://localhost:8085/admin/login` | Admin login portal |
| `http://localhost:8085/admin/dashboard` | Admin dashboard |
| `http://localhost:8085/admin/courses` | Course management |

---

## Role-Based Access

The application uses two independent Spring Security filter chains:

- **Admin chain** (`/admin/**`) — authenticates against a separate session context; only `ROLE_ADMIN` users are permitted.
- **User chain** (all other URLs) — handles students (`ROLE_STUDENT`) and instructors (`ROLE_INSTRUCTOR`) with a shared session context.

Passwords are hashed with **BCrypt**.
