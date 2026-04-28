<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Elite Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <script src="/js/theme-toggle.js"></script>
</head>
<body>
    <!-- Background Orbs -->
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
    <div class="bg-orb orb-3"></div>
    <div class="grid-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="me-2" style="color: var(--primary);"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c3 3 9 3 12 0v-5"/></svg>
                Elite Academy Admin Portal
            </a>
            <div class="d-flex align-items-center">
                <button id="themeToggleBtn" class="theme-toggle" onclick="toggleTheme()" title="Toggle theme">☀️</button>
                <span class="me-3" style="color: var(--primary); font-weight: 700;">Admin: ${user.username}</span>
                <form action="/admin/logout" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-outline-light btn-sm">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="row g-4 mb-4">
            <div class="col-md-6">
                <div class="dashboard-card text-center">
                    <h5>Total Users</h5>
                    <div class="stat-value">${totalUsers}</div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="dashboard-card text-center">
                    <h5>Total Revenue</h5>
                    <div class="stat-value text-success">&#8377;${totalRevenue}</div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12">
                <div class="dashboard-card">
                    <h4>System Administration Shortcuts</h4>
                    <hr>
                    <div class="d-grid gap-3 d-md-flex align-items-stretch mt-4">
                        <a href="/admin/users" class="btn btn-primary px-4" style="text-decoration:none; display:inline-flex; align-items:center; justify-content:center; line-height:1.5;">Manage Users</a>
                        <a href="/admin/courses" class="btn btn-secondary px-4" style="text-decoration:none; display:inline-flex; align-items:center; justify-content:center; line-height:1.5;">Review Courses</a>
                        <a href="/admin/instructors" class="btn btn-accent px-4" style="text-decoration:none; display:inline-flex; align-items:center; justify-content:center; line-height:1.5;">Manage Instructors</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
