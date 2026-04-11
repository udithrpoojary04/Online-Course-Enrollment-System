<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Elite Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Animated Orbs -->
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
    <div class="bg-orb orb-3"></div>

    <!-- Grid Overlay -->
    <div class="grid-overlay"></div>

    <div class="auth-wrapper">
        <div class="container d-flex justify-content-center">
            <div class="col-md-5">
                <div class="glass-panel text-center fade-up">
                    <!-- User Icon -->
                    <div class="fade-up delay-1" style="margin-bottom: 1.5rem;">
                        <div style="display: inline-flex; align-items: center; justify-content: center; width: 80px; height: 80px; border-radius: 22px; background: linear-gradient(135deg, rgba(255, 176, 102, 0.1), rgba(167, 139, 250, 0.1)); border: 1px solid rgba(255, 176, 102, 0.15);">
                            <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="url(#userGrad)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                <defs>
                                    <linearGradient id="userGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                                        <stop offset="0%" style="stop-color:#ffb066"/>
                                        <stop offset="100%" style="stop-color:#a78bfa"/>
                                    </linearGradient>
                                </defs>
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                                <circle cx="12" cy="7" r="4"/>
                            </svg>
                        </div>
                    </div>

                    <h1 class="auth-title fade-up delay-1">Welcome Back</h1>
                    <p class="auth-subtitle fade-up delay-1">Login to access your courses and dashboard.</p>
                    
                    <c:if test="${param.error != null}">
                        <div class="alert alert-danger fade show fade-up delay-2" role="alert">
                            Invalid Username or Password!
                        </div>
                    </c:if>
                    <c:if test="${param.logout != null}">
                        <div class="alert alert-success fade show fade-up delay-2" role="alert">
                            You have been logged out successfully.
                        </div>
                    </c:if>
                    <c:if test="${param.registered != null}">
                        <div class="alert alert-success fade show fade-up delay-2" role="alert">
                            Registration successful! Please login.
                        </div>
                    </c:if>

                    <form action="/login" method="post" class="text-start">
                        <div class="mb-3 fade-up delay-2">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required placeholder="Enter your username">
                        </div>
                        <div class="mb-4 fade-up delay-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required placeholder="Enter your password">
                        </div>
                        <!-- CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        
                        <div class="d-grid gap-2 fade-up delay-4">
                            <button type="submit" class="btn btn-primary btn-lg">Sign In</button>
                        </div>
                    </form>
                    
                    <div class="mt-4 fade-up delay-4" style="font-weight: 500; color: var(--text-muted);">
                        Don't have an account? <a href="/register" class="custom-link">Register here</a>
                    </div>
                    <div class="mt-2 fade-up delay-4" style="font-weight: 500;">
                        <a href="/admin/login" class="custom-link" style="font-size: 0.9rem; opacity: 0.6;">Admin? Login here &rarr;</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
