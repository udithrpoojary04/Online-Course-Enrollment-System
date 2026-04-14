<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Settings - Elite Academy Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
</head>
<body class="admin-theme">
    <!-- Background Orbs -->
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
    <div class="bg-orb orb-3"></div>
    <div class="grid-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="/admin/dashboard">Elite Academy Admin Portal</a>
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
                        <a class="nav-link" href="/admin/instructors">Instructors</a>
                    </li>
                </ul>
            </div>
            <div class="d-flex align-items-center">
                <form action="/admin/logout" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-outline-light btn-sm">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mb-5">
        <!-- Platform Overview -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="dashboard-card text-center">
                    <h5>Total Users</h5>
                    <div class="stat-value">${totalUsers}</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card text-center">
                    <h5>Total Courses</h5>
                    <div class="stat-value text-info">${totalCourses}</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card text-center">
                    <h5>Enrollments</h5>
                    <div class="stat-value text-success">${totalEnrollments}</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card text-center">
                    <h5>Platform Health</h5>
                    <div class="stat-value text-success">100%</div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <!-- System Information -->
            <div class="col-md-6">
                <div class="dashboard-card">
                    <h4 class="mb-4">⚙️ System Information</h4>
                    <table class="table">
                        <tbody>
                            <tr>
                                <td style="color: var(--text-muted); font-weight: 600;">Application</td>
                                <td class="fw-bold">Elite Academy v${appVersion}</td>
                            </tr>
                            <tr>
                                <td style="color: var(--text-muted); font-weight: 600;">Framework</td>
                                <td>Spring Boot ${springBootVersion}</td>
                            </tr>
                            <tr>
                                <td style="color: var(--text-muted); font-weight: 600;">Java Version</td>
                                <td>${javaVersion}</td>
                            </tr>
                            <tr>
                                <td style="color: var(--text-muted); font-weight: 600;">Java Vendor</td>
                                <td>${javaVendor}</td>
                            </tr>
                            <tr>
                                <td style="color: var(--text-muted); font-weight: 600;">Operating System</td>
                                <td>${osName} ${osVersion}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Memory Usage -->
            <div class="col-md-6">
                <div class="dashboard-card">
                    <h4 class="mb-4">💾 Memory Usage</h4>
                    <table class="table">
                        <tbody>
                            <tr>
                                <td style="color: var(--text-muted); font-weight: 600;">Used Memory</td>
                                <td class="fw-bold">${usedMemory} MB</td>
                            </tr>
                            <tr>
                                <td style="color: var(--text-muted); font-weight: 600;">Free Memory</td>
                                <td>${freeMemory} MB</td>
                            </tr>
                            <tr>
                                <td style="color: var(--text-muted); font-weight: 600;">Max Memory</td>
                                <td>${maxMemory} MB</td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="mt-3">
                        <div style="background: rgba(255,255,255,0.06); border-radius: 10px; height: 12px; overflow: hidden;">
                            <div style="background: linear-gradient(135deg, var(--primary), var(--secondary)); height: 100%; border-radius: 10px; width: ${usedMemory * 100 / maxMemory}%; transition: width 0.5s ease;"></div>
                        </div>
                        <small style="color: var(--text-muted);" class="mt-1 d-block">${usedMemory} MB / ${maxMemory} MB used</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- User Breakdown -->
        <div class="row g-4">
            <div class="col-md-12">
                <div class="dashboard-card">
                    <h4 class="mb-4">👥 User Breakdown</h4>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <div style="background: rgba(34,197,94,0.08); border: 1px solid rgba(34,197,94,0.15); border-radius: 14px; padding: 1.5rem; text-align: center;">
                                <div style="font-size: 2rem; font-weight: 800; color: #86efac;">${totalStudents}</div>
                                <div style="color: var(--text-muted); font-weight: 600; font-size: 0.9rem;">Students</div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div style="background: rgba(167,139,250,0.08); border: 1px solid rgba(167,139,250,0.15); border-radius: 14px; padding: 1.5rem; text-align: center;">
                                <div style="font-size: 2rem; font-weight: 800; color: #c4b5fd;">${totalInstructors}</div>
                                <div style="color: var(--text-muted); font-weight: 600; font-size: 0.9rem;">Instructors</div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div style="background: rgba(255,176,102,0.08); border: 1px solid rgba(255,176,102,0.15); border-radius: 14px; padding: 1.5rem; text-align: center;">
                                <div style="font-size: 2rem; font-weight: 800; color: #ffb066;">${totalAdmins}</div>
                                <div style="color: var(--text-muted); font-weight: 600; font-size: 0.9rem;">Admins</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
