<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.title} - Content - Elite Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <script src="/js/theme-toggle.js"></script>
    <style>
        .material-card {
            background: rgba(30, 30, 50, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        .material-card:hover {
            background: rgba(40, 40, 65, 0.6);
            border-color: rgba(255, 176, 102, 0.2);
        }
        .completed-badge {
            background: rgba(34, 197, 94, 0.15);
            color: #4ade80;
            border: 1px solid rgba(34, 197, 94, 0.3);
            border-radius: 20px;
            padding: 2px 12px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .progress-bar-custom {
            height: 10px;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.05);
            overflow: hidden;
        }
        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            transition: width 0.5s ease;
        }
    </style>
</head>
<body>
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
    <div class="bg-orb orb-3"></div>
    <div class="grid-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="/student/dashboard">Elite Academy</a>
            <div class="d-flex align-items-center">
                <button id="themeToggleBtn" class="theme-toggle" onclick="toggleTheme()" title="Toggle theme">☀️</button>
                <a href="/student/dashboard" class="btn btn-outline-light btn-sm me-3">Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container mb-5 flex-grow-1 d-flex flex-column">
        <div class="row">
            <div class="col-md-9 mx-auto">
                <div class="dashboard-card mb-4">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div>
                            <h2 class="auth-title" style="font-size: 2.2rem; margin-bottom: 0;">${course.title}</h2>
                            <p class="text-muted">Instructor: Prof. ${course.instructor.fullName}</p>
                        </div>
                        <div class="text-end">
                            <div class="h4 mb-0" style="color: var(--primary); font-weight: 800;">${enrollment.progressPercentage}%</div>
                            <small class="text-muted">Course Completion</small>
                        </div>
                    </div>
                    
                    <div class="progress-bar-custom mb-4">
                        <div class="progress-fill" style="width: ${enrollment.progressPercentage}%"></div>
                    </div>

                    <p class="lead" style="color: var(--text-main); line-height: 1.7;">${course.description}</p>
                </div>

                <h4 class="mb-3" style="font-weight: 700;">Study Materials</h4>
                
                <c:if test="${empty course.materials}">
                    <div class="alert alert-secondary text-center">
                        No study materials have been uploaded for this course yet.
                    </div>
                </c:if>

                <c:forEach var="material" items="${course.materials}" varStatus="status">
                    <div class="material-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <div class="me-3" style="width: 40px; height: 40px; border-radius: 10px; background: rgba(255, 176, 102, 0.1); display: flex; align-items: center; justify-content: center; color: var(--primary); font-weight: 800;">
                                    ${status.index + 1}
                                </div>
                                <div>
                                    <h5 class="mb-1" style="font-weight: 600;">${material.title}</h5>
                                    <a href="${material.contentUrl}" target="_blank" class="custom-link" style="font-size: 0.9rem;">View Material &rarr;</a>
                                </div>
                            </div>
                            
                            <div>
                                <c:set var="isCompleted" value="false" />
                                <c:forEach var="done" items="${enrollment.completedMaterials}">
                                    <c:if test="${done.id == material.id}">
                                        <c:set var="isCompleted" value="true" />
                                    </c:if>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${isCompleted}">
                                        <span class="completed-badge">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="me-1"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                            Completed
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="/student/course/${course.id}/complete/${material.id}" method="post">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button type="submit" class="btn btn-sm btn-outline-primary">Mark as Complete</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </div>
    </div>


    <footer class="frontend-footer">
        <div class="container">
            <div class="row mb-4">
                <div class="col-md-4 mb-3 mb-md-0">
                    <h5 class="footer-heading">Elite Academy</h5>
                    <p class="small text-muted mb-0">Empowering your future with premium online education. Learn from the best instructors around the globe.</p>
                </div>
                <div class="col-md-4 mb-3 mb-md-0">
                    <h5 class="footer-heading">Quick Links</h5>
                    <a href="/student/dashboard" class="footer-link">My Dashboard</a>
                    <a href="#" class="footer-link">Available Courses</a>
                    <a href="#" class="footer-link">Certificates</a>
                    <a href="#" class="footer-link">About Us</a>
                    <a href="#" class="footer-link">Blog</a>
                </div>
                <div class="col-md-4">
                    <h5 class="footer-heading">Support</h5>
                    <a href="#" class="footer-link">Help Center</a>
                    <a href="#" class="footer-link">Terms of Service</a>
                    <a href="#" class="footer-link">Privacy Policy</a>
                    <a href="#" class="footer-link">Contact Us</a>
                    <a href="#" class="footer-link">FAQ</a>
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
