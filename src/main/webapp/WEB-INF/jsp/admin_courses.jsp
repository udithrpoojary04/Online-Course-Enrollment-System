<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Management - Elite Academy Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <script src="/js/theme-toggle.js"></script>
</head>
<body class="admin-theme">
    <!-- Background Orbs -->
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
    <div class="bg-orb orb-3"></div>
    <div class="grid-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="/admin/dashboard">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="me-2" style="color: var(--primary);"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c3 3 9 3 12 0v-5"/></svg>
                Elite Academy Admin Portal
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/users">Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/admin/courses">Courses</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/instructors">Instructors</a>
                    </li>
                </ul>
            </div>
            <div class="d-flex align-items-center">
                <button id="themeToggleBtn" class="theme-toggle" onclick="toggleTheme()" title="Toggle theme">☀️</button>
                <form action="/admin/logout" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-outline-light btn-sm">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mb-5 flex-grow-1 d-flex flex-column">
        <div class="row">
            <div class="col-md-12">
                <div class="dashboard-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4>Course Directory</h4>
                        <a href="/admin/courses/new" class="btn btn-primary">+ Add New Course</a>
                    </div>
                    
                    <c:if test="${param.success != null}">
                        <div class="alert alert-success mt-3">${param.success}</div>
                    </c:if>

                    <table class="table mt-4">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Course Title</th>
                                <th>Instructor</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="course" items="${courses}">
                                <tr>
                                    <td>${course.id}</td>
                                    <td class="fw-bold" style="color: var(--text-main);">${course.title}</td>
                                    <td>${course.instructor != null ? course.instructor.fullName : 'Unassigned'}</td>
                                    <td>₹${course.price}</td>
                                    <td>
                                        <a href="/admin/courses/edit/${course.id}" class="btn btn-sm btn-primary" style="padding: 0.5rem 1.2rem; font-size: 0.85rem; border-radius: 10px;">✏️ Edit</a>
                                        <form action="/admin/courses/delete/${course.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this course? This will also remove all enrollments.');">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button type="submit" class="btn btn-sm btn-danger" style="padding: 0.5rem 1.2rem; font-size: 0.85rem; border-radius: 10px;">🗑️ Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty courses}">
                                <tr>
                                    <td colspan="5" class="text-center py-4" style="color: var(--text-muted);">No courses found. Click 'Add New Course' to begin.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <footer class="frontend-footer">
        <div class="container">
            <div class="row mb-4">
                <div class="col-md-4 mb-3 mb-md-0">
                    <h5 class="footer-heading">Elite Academy</h5>
                    <p class="small text-muted mb-0">Empowering your future with premium online education. Manage the platform efficiently.</p>
                </div>
                <div class="col-md-4 mb-3 mb-md-0">
                    <h5 class="footer-heading">Quick Links</h5>
                    <a href="/admin/dashboard" class="footer-link">Admin Dashboard</a>
                    <a href="/admin/users" class="footer-link">Manage Users</a>
                    <a href="/admin/courses" class="footer-link">Review Courses</a>
                    <a href="/admin/instructors" class="footer-link">Manage Instructors</a>
                </div>
                <div class="col-md-4">
                    <h5 class="footer-heading">Support</h5>
                    <a href="#" class="footer-link">Help Center</a>
                    <a href="#" class="footer-link">System Logs</a>
                    <a href="#" class="footer-link">Contact Support</a>
                </div>
            </div>
            <div class="text-center pt-3 border-top" style="border-color: var(--navbar-border) !important;">
                <p class="small">&copy; 2026 Elite Academy. All rights reserved.</p>
            </div>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
