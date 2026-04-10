<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Elite Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Animated Orbs -->
    <div class="bg-orb orb-1" style="animation-delay: -3s;"></div>
    <div class="bg-orb orb-2" style="animation-delay: -7s;"></div>
    <div class="bg-orb orb-3" style="animation-delay: -12s;"></div>

    <div class="auth-wrapper py-5">
        <div class="container d-flex justify-content-center">
            <div class="col-md-6">
                <div class="glass-panel text-center fade-up">
                    <h1 class="auth-title fade-up delay-1">Create Account</h1>
                    <p class="auth-subtitle fade-up delay-1">Join the elite learning platform today.</p>
                    
                    <c:if test="${error != null}">
                        <div class="alert alert-danger fade show fade-up delay-1" role="alert" style="border-radius: 12px;">
                            ${error}
                        </div>
                    </c:if>

                    <form action="/register" method="post" class="text-start">
                        <div class="row fade-up delay-2">
                            <div class="col-md-12 mb-3">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" required placeholder="John Doe" value="${user.fullName}">
                            </div>
                        </div>
                        <div class="mb-3 fade-up delay-2">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" required placeholder="john@example.com" value="${user.email}">
                        </div>
                        <div class="mb-3 fade-up delay-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required placeholder="johndoe123" value="${user.username}">
                        </div>
                        <div class="mb-4 fade-up delay-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required placeholder="Create a strong password">
                        </div>
                        
                        <!-- CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        
                        <div class="d-grid gap-2 fade-up delay-4">
                            <button type="submit" class="btn btn-primary btn-lg">Create Account</button>
                        </div>
                    </form>
                    
                    <div class="mt-4 text-muted fade-up delay-4" style="font-weight: 500;">
                        Already have an account? <a href="/login" class="custom-link">Sign In</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
