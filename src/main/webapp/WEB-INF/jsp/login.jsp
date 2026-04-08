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
    <div class="auth-wrapper">
        <div class="container d-flex justify-content-center">
            <div class="col-md-5">
                <div class="glass-panel text-center">
                    <h1 class="auth-title">Welcome Back</h1>
                    <p class="auth-subtitle">Login to access your courses and dashboard.</p>
                    
                    <c:if test="${param.error != null}">
                        <div class="alert alert-danger fade show" role="alert">
                            Invalid Username or Password!
                        </div>
                    </c:if>
                    <c:if test="${param.logout != null}">
                        <div class="alert alert-success fade show" role="alert">
                            You have been logged out successfully.
                        </div>
                    </c:if>
                    <c:if test="${param.registered != null}">
                        <div class="alert alert-success fade show" role="alert">
                            Registration successful! Please login.
                        </div>
                    </c:if>

                    <form action="/login" method="post" class="text-start">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required placeholder="Enter your username">
                        </div>
                        <div class="mb-4">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required placeholder="Enter your password">
                        </div>
                        <!-- CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">Sign In</button>
                        </div>
                    </form>
                    
                    <div class="mt-4 text-muted">
                        Don't have an account? <a href="/register" class="text-white text-decoration-none fw-bold">Register here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
