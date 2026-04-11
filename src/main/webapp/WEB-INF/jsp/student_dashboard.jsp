<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Elite Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Background Orbs -->
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
    <div class="bg-orb orb-3"></div>
    <div class="grid-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="#">Elite Academy</a>
            <div class="d-flex align-items-center">
                <span class="text-white me-3" style="font-weight: 600;">Welcome, ${user.fullName}</span>
                <form action="/logout" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-outline-light btn-sm">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="row">
            <div class="col-md-12">
                <div class="dashboard-card text-center mb-4">
                    <h2>Your Progress Dashboard</h2>
                    <p>Track your enrolled courses and achievements.</p>
                </div>
            </div>
        </div>
        
        <div class="row g-4">
            <!-- Summary Stats -->
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Active Courses</h5>
                    <div class="stat-value">${activeCourseCount != null ? activeCourseCount : 0}</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Completed</h5>
                    <div class="stat-value text-success">0</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Certificates</h5>
                    <div class="stat-value text-warning">0</div>
                </div>
            </div>
        </div>

        <c:if test="${param.enrolled != null}">
            <div class="alert alert-success mt-4">Successfully enrolled in course!</div>
        </c:if>
        <c:if test="${param.error != null}">
            <div class="alert alert-danger mt-4">Unable to enroll. You may already be registered.</div>
        </c:if>
        
        <div class="row mt-4">
            <div class="col-md-12">
                <div class="dashboard-card mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4>My Enrolled Courses</h4>
                    </div>
                    <c:if test="${empty enrollments}">
                        <div class="alert alert-secondary text-center py-4">
                            You have not enrolled in any courses yet.
                        </div>
                    </c:if>
                    <c:if test="${not empty enrollments}">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Course Title</th>
                                    <th>Instructor</th>
                                    <th>Progress</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="enrollment" items="${enrollments}">
                                    <tr>
                                        <td class="fw-bold" style="color: var(--text-main);">${enrollment.course.title}</td>
                                        <td>${enrollment.course.instructor.fullName}</td>
                                        <td>${enrollment.progressPercentage}%</td>
                                        <td><a href="/student/course/${enrollment.course.id}" class="btn btn-sm btn-primary">Go to Course</a></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>

                <div class="dashboard-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4>Available Courses</h4>
                    </div>
                    <c:if test="${empty availableCourses}">
                        <div class="alert alert-secondary text-center py-4">
                            No new courses available to enroll at this time.
                        </div>
                    </c:if>
                    <c:if test="${not empty availableCourses}">
                        <div class="row g-3">
                            <c:forEach var="course" items="${availableCourses}">
                                <div class="col-md-6">
                                    <div class="card bg-transparent border border-secondary h-100 p-3" style="border-radius: 14px;">
                                        <h5 class="card-title text-white fw-bold mb-1">${course.title}</h5>
                                        <p class="text-muted small mb-2">By Prof. ${course.instructor.fullName} | ${course.durationInWeeks} weeks</p>
                                        <p class="card-text mb-3" style="font-size: 0.9em; flex-grow: 1;">${course.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="text-white fw-bold">$${course.price}</span>
                                            <form action="/student/enroll" method="post">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <input type="hidden" name="courseId" value="${course.id}"/>
                                                <button type="submit" class="btn btn-sm btn-primary">Enroll Now</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
