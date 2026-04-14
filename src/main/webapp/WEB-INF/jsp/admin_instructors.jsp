<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Management - Elite Academy Admin</title>
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
                        <a class="nav-link" href="/admin/courses">Courses</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/admin/instructors">Instructors</a>
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
        <div class="row">
            <div class="col-md-12">
                <div class="dashboard-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4>Instructor Directory</h4>
                        <a href="/admin/instructors/new" class="btn btn-primary">+ Add New Instructor</a>
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
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="instructor" items="${instructors}">
                                <tr>
                                    <td>${instructor.id}</td>
                                    <td class="fw-bold" style="color: var(--text-main);">Prof. ${instructor.fullName}</td>
                                    <td>${instructor.username}</td>
                                    <td>${instructor.email}</td>
                                    <td>
                                        <a href="/admin/instructors/edit/${instructor.id}" class="btn btn-sm btn-primary" style="padding: 0.5rem 1.2rem; font-size: 0.85rem; border-radius: 10px;">✏️ Edit</a>
                                        <form action="/admin/instructors/delete/${instructor.id}" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this instructor?');">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button type="submit" class="btn btn-sm btn-danger" style="padding: 0.5rem 1.2rem; font-size: 0.85rem; border-radius: 10px;">🗑️ Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty instructors}">
                                <tr>
                                    <td colspan="5" class="text-center py-4" style="color: var(--text-muted);">No instructors found. Click 'Add New Instructor' to begin.</td>
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
