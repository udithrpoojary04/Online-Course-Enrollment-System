<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Elite Academy Admin</title>
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
                        <a class="nav-link active" href="/admin/users">Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/courses">Courses</a>
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

    <div class="container mb-5">
        <!-- Stats Row -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Students</h5>
                    <div class="stat-value">${studentCount}</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Instructors</h5>
                    <div class="stat-value text-info">${instructorCount}</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Admins</h5>
                    <div class="stat-value text-warning">${adminCount}</div>
                </div>
            </div>
        </div>

        <!-- Users Table -->
        <div class="row">
            <div class="col-md-12">
                <div class="dashboard-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4>All Users</h4>
                    </div>
                    
                    <c:if test="${param.success != null}">
                        <div class="alert alert-success mt-3">${param.success}</div>
                    </c:if>
                    <c:if test="${param.error != null}">
                        <div class="alert alert-danger mt-3">${param.error}</div>
                    </c:if>

                    <table class="table mt-4">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Full Name</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${users}">
                                <tr>
                                    <td>${u.id}</td>
                                    <td class="fw-bold" style="color: var(--text-main);">${u.fullName}</td>
                                    <td>${u.username}</td>
                                    <td>${u.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${u.role == 'ROLE_ADMIN'}">
                                                <span style="background: rgba(255,176,102,0.15); color: #ffb066; padding: 0.25rem 0.75rem; border-radius: 8px; font-size: 0.8rem; font-weight: 600;">Admin</span>
                                            </c:when>
                                            <c:when test="${u.role == 'ROLE_INSTRUCTOR'}">
                                                <span style="background: rgba(167,139,250,0.15); color: #c4b5fd; padding: 0.25rem 0.75rem; border-radius: 8px; font-size: 0.8rem; font-weight: 600;">Instructor</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="background: rgba(34,197,94,0.15); color: #86efac; padding: 0.25rem 0.75rem; border-radius: 8px; font-size: 0.8rem; font-weight: 600;">Student</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="/admin/users/edit/${u.id}" class="btn btn-sm btn-primary" style="padding: 0.5rem 1.2rem; font-size: 0.85rem; border-radius: 10px;">✏️ Edit</a>
                                        <form action="/admin/users/delete/${u.id}" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button type="submit" class="btn btn-sm btn-danger" style="padding: 0.5rem 1.2rem; font-size: 0.85rem; border-radius: 10px;">🗑️ Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty users}">
                                <tr>
                                    <td colspan="6" class="text-center py-4" style="color: var(--text-muted);">No users found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
