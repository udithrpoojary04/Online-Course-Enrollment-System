<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Elite Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <script src="/js/theme-toggle.js"></script>
</head>
<body class="admin-login-body">
    <!-- Theme Toggle -->
    <button id="themeToggleBtn" class="theme-toggle" onclick="toggleTheme()" title="Toggle theme" style="position:fixed; top:1.5rem; right:1.5rem; z-index:1000;">☀️</button>
    <!-- Admin Animated Orbs -->
    <div class="bg-orb admin-orb-1"></div>
    <div class="bg-orb admin-orb-2"></div>
    <div class="bg-orb admin-orb-3"></div>

    <!-- Grid Overlay -->
    <div class="admin-grid-overlay"></div>

    <div class="auth-wrapper">
        <div class="container d-flex justify-content-center">
            <div class="col-md-5">
                <div class="admin-glass-panel text-center fade-up">
                    <!-- Admin Shield Icon -->
                    <div class="admin-icon-wrapper fade-up delay-1">
                        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="url(#adminGrad)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                            <defs>
                                <linearGradient id="adminGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                                    <stop offset="0%" style="stop-color:#ffb066"/>
                                    <stop offset="100%" style="stop-color:#ef4444"/>
                                </linearGradient>
                            </defs>
                            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                            <path d="M9 12l2 2 4-4"/>
                        </svg>
                    </div>

                    <h1 class="admin-auth-title fade-up delay-1">Admin Portal</h1>
                    <p class="admin-auth-subtitle fade-up delay-1">Restricted access. Authorized personnel only.</p>
                    
                    <c:if test="${param.error != null}">
                        <div class="alert alert-danger fade show fade-up delay-2" role="alert">
                            Invalid Admin Credentials!
                        </div>
                    </c:if>
                    <c:if test="${param.logout != null}">
                        <div class="alert alert-success fade show fade-up delay-2" role="alert">
                            You have been logged out successfully.
                        </div>
                    </c:if>

                    <form action="/admin/login" method="post" class="text-start">
                        <div class="mb-3 fade-up delay-2">
                            <label for="username" class="form-label admin-label">Admin Username</label>
                            <input type="text" class="form-control admin-input" id="username" name="username" required placeholder="Enter admin username">
                        </div>
                        <div class="mb-4 fade-up delay-3">
                            <label for="password" class="form-label admin-label">Password</label>
                            <input type="password" class="form-control admin-input" id="password" name="password" required placeholder="Enter admin password">
                        </div>
                        <!-- CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        
                        <div class="d-grid gap-2 fade-up delay-4">
                            <button type="submit" class="btn admin-btn-primary btn-lg">Access Dashboard</button>
                        </div>
                    </form>
                    
                    <div class="mt-4 fade-up delay-4" style="font-weight: 500;">
                        <a href="/login" class="admin-back-link">&larr; Back to User Login</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
