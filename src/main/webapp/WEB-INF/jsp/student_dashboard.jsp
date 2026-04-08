<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard - Elite Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="#">Elite Academy</a>
            <div class="d-flex">
                <span class="text-white me-3 mt-2">Welcome, ${user.fullName}</span>
                <form action="/logout" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-outline-light btn-sm mt-1">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="row">
            <div class="col-md-12">
                <div class="dashboard-card text-center mb-4">
                    <h2>Your Progress Dashboard</h2>
                    <p class="text-muted">Track your enrolled courses and achievements.</p>
                </div>
            </div>
        </div>
        
        <div class="row g-4">
            <!-- Summary Stats -->
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5 class="text-muted mb-2">Active Courses</h5>
                    <div class="stat-value">0</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5 class="text-muted mb-2">Completed</h5>
                    <div class="stat-value text-success">0</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5 class="text-muted mb-2">Certificates</h5>
                    <div class="stat-value text-warning">0</div>
                </div>
            </div>
        </div>
        
        <div class="row mt-4">
            <div class="col-md-12">
                <div class="dashboard-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4>My Enrolled Courses</h4>
                        <button class="btn btn-primary">Browse New Courses</button>
                    </div>
                    <div class="alert alert-secondary bg-transparent border-secondary text-white text-center py-4">
                        You have not enrolled in any courses yet.
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
