<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit Instructor' : 'Add New Instructor'} - Elite Academy Admin</title>
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
                        <a class="nav-link" href="/admin/courses">Courses</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/admin/instructors">Instructors</a>
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

    <div class="container mb-5 d-flex justify-content-center flex-grow-1 flex-column">
        <div class="col-md-8">
            <div class="dashboard-card fade-up">
                <h4 class="mb-2">${isEdit ? 'Edit Instructor' : 'Add New Instructor'}</h4>
                <p class="mb-4" style="color: var(--text-muted);">${isEdit ? 'Update the instructor details below.' : 'Create a new instructor account.'}</p>
                
                <c:if test="${error != null}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="/admin/instructors/${isEdit ? 'edit/'.concat(instructor.id) : 'new'}" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" required value="${instructor.fullName}" placeholder="e.g., Dr. John Smith">
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required value="${instructor.username}" placeholder="e.g., john.smith" ${isEdit ? 'readonly' : ''}>
                            <c:if test="${isEdit}">
                                <small class="text-muted">Username cannot be changed after creation.</small>
                            </c:if>
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" required value="${instructor.email}" placeholder="e.g., john@eliteacademy.com">
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-label">${isEdit ? 'New Password (leave blank to keep current)' : 'Password'}</label>
                        <input type="password" class="form-control" id="password" name="password" ${isEdit ? '' : 'required'} placeholder="${isEdit ? 'Enter new password to change...' : 'Create a secure password'}" minlength="4">
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between">
                        <a href="/admin/instructors" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary px-4">${isEdit ? 'Update Instructor' : 'Create Instructor'}</button>
                    </div>
                </form>
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
