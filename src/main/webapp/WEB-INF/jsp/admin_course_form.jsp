<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit Course' : 'Add New Course'} - Elite Academy Admin</title>
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
                        <a class="nav-link active" href="/admin/courses">Courses</a>
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

    <div class="container mb-5 d-flex justify-content-center">
        <div class="col-md-8">
            <div class="dashboard-card fade-up">
                <h4 class="mb-2">${isEdit ? 'Edit Course' : 'Add New Course'}</h4>
                <p class="mb-4" style="color: var(--text-muted);">${isEdit ? 'Update the course details below.' : 'Create a new course and assign an instructor.'}</p>
                
                <c:if test="${error != null}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="/admin/courses/${isEdit ? 'edit/'.concat(course.id) : 'new'}" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    
                    <div class="mb-3">
                        <label for="title" class="form-label">Course Title</label>
                        <input type="text" class="form-control" id="title" name="title" required value="${course.title}" placeholder="e.g., Advanced JavaScript">
                    </div>
                    
                    <div class="mb-3">
                        <label for="description" class="form-label">Course Description</label>
                        <textarea class="form-control" id="description" name="description" rows="4" placeholder="Detailed description of the course content...">${course.description}</textarea>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="durationInWeeks" class="form-label">Duration (in weeks)</label>
                            <input type="number" class="form-control" id="durationInWeeks" name="durationInWeeks" required min="1" value="${course.durationInWeeks}">
                        </div>
                        <div class="col-md-6">
                            <label for="price" class="form-label">Price (₹)</label>
                            <input type="number" step="0.01" class="form-control" id="price" name="price" required min="0" value="${course.price}">
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="instructorId" class="form-label">Assign Instructor</label>
                        <c:if test="${empty instructors}">
                            <div class="alert alert-warning p-2 mt-2" style="font-size: 0.9em;">
                                No instructors available. Please register an instructor first.
                            </div>
                        </c:if>
                        <select class="form-control" id="instructorId" name="instructorId" required ${empty instructors ? 'disabled' : ''}>
                            <option value="" disabled ${isEdit ? '' : 'selected'}>Select an Instructor...</option>
                            <c:forEach var="inst" items="${instructors}">
                                <option value="${inst.id}" ${isEdit && course.instructor != null && course.instructor.id == inst.id ? 'selected' : ''}>Prof. ${inst.fullName} (${inst.email})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <hr>
                    
                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0">Study materials (Videos/Links)</h5>
                            <button type="button" class="btn btn-sm btn-outline-info" onclick="addMaterial()">+ Add Material</button>
                        </div>
                        <div id="materials-container">
                            <c:choose>
                                <c:when test="${isEdit && not empty course.materials}">
                                    <c:forEach var="mat" items="${course.materials}">
                                        <div class="row g-2 mb-2 material-row">
                                            <div class="col-md-5">
                                                <input type="text" name="materialTitle" class="form-control form-control-sm" placeholder="Material Title" value="${mat.title}">
                                            </div>
                                            <div class="col-md-6">
                                                <input type="text" name="materialUrl" class="form-control form-control-sm" placeholder="Material URL" value="${mat.contentUrl}">
                                            </div>
                                            <div class="col-md-1">
                                                <button type="button" class="btn btn-sm btn-danger w-100" onclick="removeMaterial(this)">&times;</button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="row g-2 mb-2 material-row">
                                        <div class="col-md-5">
                                            <input type="text" name="materialTitle" class="form-control form-control-sm" placeholder="Material Title (e.g., Intro Video)">
                                        </div>
                                        <div class="col-md-6">
                                            <input type="text" name="materialUrl" class="form-control form-control-sm" placeholder="Material URL (e.g., https://youtube.com/...)">
                                        </div>
                                        <div class="col-md-1">
                                            <button type="button" class="btn btn-sm btn-danger w-100" onclick="removeMaterial(this)">&times;</button>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <hr>

                    <script>
                        function addMaterial() {
                            const container = document.getElementById('materials-container');
                            const row = document.createElement('div');
                            row.className = 'row g-2 mb-2 material-row';
                            row.innerHTML = `
                                <div class="col-md-5">
                                    <input type="text" name="materialTitle" class="form-control form-control-sm" placeholder="Material Title">
                                </div>
                                <div class="col-md-6">
                                    <input type="text" name="materialUrl" class="form-control form-control-sm" placeholder="Material URL">
                                </div>
                                <div class="col-md-1">
                                    <button type="button" class="btn btn-sm btn-danger w-100" onclick="removeMaterial(this)">&times;</button>
                                </div>
                            `;
                            container.appendChild(row);
                        }

                        function removeMaterial(btn) {
                            const row = btn.closest('.material-row');
                            if (document.querySelectorAll('.material-row').length > 1) {
                                row.remove();
                            } else {
                                row.querySelectorAll('input').forEach(input => input.value = '');
                            }
                        }
                    </script>
                        <a href="/admin/courses" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary px-4" ${empty instructors ? 'disabled' : ''}>${isEdit ? 'Update Course' : 'Save Course'}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
