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
</head>
<body>
    <!-- Background Orbs -->
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
    <div class="bg-orb orb-3"></div>
    <div class="grid-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="#">Elite Academy Admin Portal</a>
            <div class="d-flex align-items-center">
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
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Total Users</h5>
                    <div class="stat-value">${totalUsers}</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Total Revenue</h5>
                    <div class="stat-value text-success">&#8377;${totalRevenue}</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Platform Health</h5>
                    <div class="stat-value text-info">100%</div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12">
                <div class="dashboard-card">
                    <h4>System Administration Shortcuts</h4>
                    <hr>
                    <div class="d-grid gap-3 d-md-flex mt-4">
                        <button class="btn btn-primary px-4">Manage Users</button>
                        <a href="/admin/courses" class="btn btn-secondary px-4">Review Courses</a>
                        <a href="/admin/instructors" class="btn btn-primary px-4">Manage Instructors</a>
                        <button class="btn btn-danger px-4">System Settings</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
