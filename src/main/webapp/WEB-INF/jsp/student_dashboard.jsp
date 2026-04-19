<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Elite Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <script src="/js/theme-toggle.js"></script>
    <style>
        /* ---- Profile Sidebar Overlay ---- */
        .profile-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            z-index: 1040;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }
        .profile-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        .profile-sidebar {
            position: fixed;
            top: 0;
            right: -420px;
            width: 400px;
            max-width: 90vw;
            height: 100vh;
            background: var(--bg-surface);
            border-left: 1px solid rgba(255,255,255,0.06);
            box-shadow: -10px 0 40px rgba(0,0,0,0.5);
            z-index: 1050;
            transition: right 0.35s cubic-bezier(0.16, 1, 0.3, 1);
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }
        .profile-sidebar.active {
            right: 0;
        }

        .profile-sidebar-header {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid rgba(255,255,255,0.06);
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-shrink: 0;
        }
        .profile-sidebar-header h5 {
            margin: 0;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.15rem;
        }
        .profile-close-btn {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            border: 1px solid rgba(255,255,255,0.1);
            background: rgba(255,255,255,0.05);
            color: var(--text-muted);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 1.1rem;
        }
        .profile-close-btn:hover {
            background: rgba(239,68,68,0.15);
            border-color: rgba(239,68,68,0.3);
            color: #fca5a5;
        }

        .profile-sidebar-body {
            padding: 2rem;
            flex: 1;
        }

        /* Profile Card inside sidebar */
        .profile-card {
            position: relative;
            overflow: hidden;
        }
        .profile-card-banner {
            height: 90px;
            background: linear-gradient(135deg, rgba(255,176,102,0.25), rgba(239,68,68,0.18), rgba(167,139,250,0.12));
            border-radius: 16px 16px 0 0;
            margin: -2rem -2rem 0 -2rem;
        }
        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: 800;
            color: white;
            border: 4px solid var(--bg-surface);
            box-shadow: 0 8px 25px -5px rgba(255,176,102,0.3);
            margin-top: -40px;
            position: relative;
            z-index: 1;
        }
        .role-badge {
            display: inline-block;
            padding: 0.25rem 0.8rem;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            background: linear-gradient(135deg, rgba(34,197,94,0.15), rgba(34,197,94,0.08));
            color: #86efac;
            border: 1px solid rgba(34,197,94,0.2);
        }
        .profile-detail-row {
            display: flex;
            align-items: center;
            padding: 0.7rem 0.9rem;
            border-radius: 12px;
            background: rgba(255,255,255,0.03);
            border: 1px solid rgba(255,255,255,0.05);
            transition: all 0.2s ease;
        }
        .profile-detail-row:hover {
            background: rgba(255,255,255,0.06);
            border-color: rgba(255,176,102,0.15);
        }
        .profile-detail-icon {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            background: rgba(255,176,102,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.95rem;
            margin-right: 0.85rem;
            flex-shrink: 0;
        }
        .profile-detail-label {
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--text-muted);
            font-weight: 600;
        }
        .profile-detail-value {
            font-size: 0.9rem;
            color: var(--text-main);
            font-weight: 500;
        }
        .btn-edit-profile {
            background: linear-gradient(135deg, rgba(255,176,102,0.15), rgba(239,68,68,0.1));
            border: 1px solid rgba(255,176,102,0.25);
            color: var(--primary) !important;
            border-radius: 12px;
            padding: 0.6rem 1.5rem;
            font-weight: 600;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            width: 100%;
        }
        .btn-edit-profile:hover {
            background: linear-gradient(135deg, rgba(255,176,102,0.25), rgba(239,68,68,0.18));
            border-color: rgba(255,176,102,0.4);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px -5px rgba(255,176,102,0.2);
            color: white !important;
        }

        /* Navbar profile icon */
        .navbar-profile-btn {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.95rem;
            font-weight: 800;
            color: white;
            cursor: pointer;
            border: 2px solid rgba(255,255,255,0.15);
            transition: all 0.3s ease;
            text-decoration: none;
            margin-left: 0.75rem;
            flex-shrink: 0;
        }
        .navbar-profile-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 18px -3px rgba(255,176,102,0.4);
            border-color: rgba(255,255,255,0.3);
        }

        /* ---- Edit Profile Modal ---- */
        .modal-content {
            background: var(--bg-surface) !important;
            border: 1px solid var(--glass-border) !important;
            border-radius: 24px !important;
            box-shadow: 0 25px 60px -12px rgba(0,0,0,0.7) !important;
        }
        .modal-header {
            border-bottom: 1px solid rgba(255,255,255,0.06) !important;
            padding: 1.5rem 2rem;
        }
        .modal-header .modal-title {
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .modal-body {
            padding: 2rem;
        }
        .modal-footer {
            border-top: 1px solid rgba(255,255,255,0.06) !important;
            padding: 1.25rem 2rem;
        }
        .btn-close {
            filter: invert(1) grayscale(100%) brightness(200%);
        }
    </style>
</head>
<body>
    <!-- Background Orbs -->
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
    <div class="bg-orb orb-3"></div>
    <div class="grid-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="#">Elite Academy</a>
            <div class="d-flex align-items-center">
                <button id="themeToggleBtn" class="theme-toggle" onclick="toggleTheme()" title="Toggle theme">☀️</button>
                <span class="me-3" style="color: var(--text-main); font-weight: 600;">Welcome, ${user.fullName}</span>
                <form action="/logout" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-outline-light btn-sm">Logout</button>
                </form>
                <!-- Profile Icon -->
                <div class="navbar-profile-btn" id="profileToggleBtn" title="View Profile">
                    ${user.fullName.substring(0,1)}
                </div>
            </div>
        </div>
    </nav>

    <!-- ===== Profile Sidebar Overlay ===== -->
    <div class="profile-overlay" id="profileOverlay"></div>

    <!-- ===== Profile Sidebar ===== -->
    <div class="profile-sidebar" id="profileSidebar">
        <div class="profile-sidebar-header">
            <h5>My Profile</h5>
            <div class="profile-close-btn" id="profileCloseBtn">&times;</div>
        </div>
        <div class="profile-sidebar-body">
            <div class="profile-card">
                <div class="profile-card-banner"></div>
                <div class="d-flex flex-column align-items-center text-center">
                    <div class="profile-avatar">
                        ${user.fullName.substring(0,1)}
                    </div>
                    <h5 class="mt-2 mb-1" style="color: var(--text-main); font-weight: 700; font-size: 1.15rem;">${user.fullName}</h5>
                    <span class="role-badge mb-3">Student</span>
                </div>

                <div class="d-flex flex-column gap-2 mt-3">
                    <div class="profile-detail-row">
                        <div class="profile-detail-icon">👤</div>
                        <div>
                            <div class="profile-detail-label">Username</div>
                            <div class="profile-detail-value">${user.username}</div>
                        </div>
                    </div>
                    <div class="profile-detail-row">
                        <div class="profile-detail-icon">✉️</div>
                        <div>
                            <div class="profile-detail-label">Email</div>
                            <div class="profile-detail-value">${user.email}</div>
                        </div>
                    </div>
                    <div class="profile-detail-row">
                        <div class="profile-detail-icon">📚</div>
                        <div>
                            <div class="profile-detail-label">Enrolled Courses</div>
                            <div class="profile-detail-value">${activeCourseCount != null ? activeCourseCount : 0}</div>
                        </div>
                    </div>
                </div>

                <div class="mt-4">
                    <button class="btn btn-edit-profile" data-bs-toggle="modal" data-bs-target="#editProfileModal" onclick="closeProfile()">✏️ Edit Profile</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container mb-5">

        <!-- Alerts -->
        <c:if test="${param.enrolled != null}">
            <div class="alert alert-success">Successfully enrolled in course!</div>
        </c:if>
        <c:if test="${param.error != null}">
            <div class="alert alert-danger">Unable to enroll. You may already be registered.</div>
        </c:if>
        <c:if test="${param.profileUpdated != null}">
            <div class="alert alert-success">Profile updated successfully!</div>
        </c:if>

        <div class="row">
            <div class="col-md-12">
                <div class="dashboard-card text-center mb-4">
                    <h2>Your Progress Dashboard</h2>
                    <p>Track your enrolled courses and achievements.</p>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Active Courses</h5>
                    <div class="stat-value">${activeCourseCount != null ? activeCourseCount : 0}</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Completed</h5>
                    <div class="stat-value text-success">${completedCourseCount != null ? completedCourseCount : 0}</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <h5>Certificates</h5>
                    <div class="stat-value text-warning">${completedCourseCount != null ? completedCourseCount : 0}</div>
                </div>
            </div>
        </div>

        <!-- Enrolled Courses -->
        <div class="row mt-4">
            <div class="col-md-12">
                <div class="dashboard-card mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4>My Enrolled Courses</h4>
                    </div>
                    <c:if test="${empty enrollments}">
                        <div class="alert alert-secondary text-center py-4">
                            You have not enrolled in any courses yet.
                        </div>
                    </c:if>
                    <c:if test="${not empty enrollments}">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Course Title</th>
                                    <th>Instructor</th>
                                    <th>Progress</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="enrollment" items="${enrollments}">
                                    <tr>
                                        <td class="fw-bold" style="color: var(--text-main);">${enrollment.course.title}</td>
                                        <td>${enrollment.course.instructor.fullName}</td>
                                        <td>
                                            ${enrollment.progressPercentage}%
                                            <c:if test="${enrollment.completed}">
                                                <span class="badge bg-success ms-2">✓ Completed</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <a href="/student/course/${enrollment.course.id}" class="btn btn-sm btn-primary">${enrollment.completed ? 'Review' : 'Go to Course'}</a>
                                            <c:if test="${enrollment.completed}">
                                                <a href="/student/certificate/${enrollment.course.id}" class="btn btn-sm btn-warning ms-1" target="_blank">Certificate</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>

                <!-- Available Courses -->
                <div class="dashboard-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4>Available Courses</h4>
                    </div>
                    <c:if test="${empty availableCourses}">
                        <div class="alert alert-secondary text-center py-4">
                            No new courses available to enroll at this time.
                        </div>
                    </c:if>
                    <c:if test="${not empty availableCourses}">
                        <div class="row g-3">
                            <c:forEach var="course" items="${availableCourses}">
                                <div class="col-md-6">
                                    <div class="card bg-transparent border border-secondary h-100 p-3" style="border-radius: 14px;">
                                        <h5 class="card-title text-white fw-bold mb-1">${course.title}</h5>
                                        <p class="text-muted small mb-2">By Prof. ${course.instructor.fullName}</p>
                                        <p class="card-text mb-3" style="font-size: 0.9em; flex-grow: 1;">${course.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="text-white fw-bold">₹${course.price}</span>
                                            <form action="/student/enroll" method="post">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <input type="hidden" name="courseId" value="${course.id}"/>
                                                <button type="submit" class="btn btn-sm btn-primary">Enroll Now</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== Edit Profile Modal ===== -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProfileModalLabel">Edit Profile</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="/student/profile/update" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editFullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="editFullName" name="fullName" required value="${user.fullName}">
                        </div>
                        <div class="mb-3">
                            <label for="editEmail" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="editEmail" name="email" required value="${user.email}">
                        </div>
                        <div class="mb-3">
                            <label for="editPassword" class="form-label">New Password <span style="color: var(--text-muted); font-weight: 400; font-size: 0.8rem;">(leave blank to keep current)</span></label>
                            <input type="password" class="form-control" id="editPassword" name="newPassword" placeholder="Enter new password">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Spacer for fixed footer -->
    <div style="height: 240px;"></div>

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
    <script>
        const profileToggleBtn = document.getElementById('profileToggleBtn');
        const profileSidebar = document.getElementById('profileSidebar');
        const profileOverlay = document.getElementById('profileOverlay');
        const profileCloseBtn = document.getElementById('profileCloseBtn');

        function openProfile() {
            profileSidebar.classList.add('active');
            profileOverlay.classList.add('active');
        }
        function closeProfile() {
            profileSidebar.classList.remove('active');
            profileOverlay.classList.remove('active');
        }

        profileToggleBtn.addEventListener('click', openProfile);
        profileCloseBtn.addEventListener('click', closeProfile);
        profileOverlay.addEventListener('click', closeProfile);

        // Close on Escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') closeProfile();
        });
    </script>
</body>
</html>
