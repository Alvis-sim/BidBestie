<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Profile</title>
<!-- Include your CSS and JS files here -->
</head>
<body>
<section class="page-section portfolio" id="portfolio">
    <div class="container">
        <!-- Portfolio Section Heading-->
        <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">User Profile</h2>

        <form action="UpdateProfileServlet" method="post">
            <div class="form-group">
                <label for="fname"><i class="zmdi zmdi-account material-icons-name"></i></label>
                <input type="text" name="fname" id="fname" value="${fname}" readonly />
            </div>
            <div class="form-group">
                <label for="lname"><i class="zmdi zmdi-account material-icons-name"></i></label>
                <input type="text" name="lname" id="lname" value="${lname}" readonly/>
            </div>
            <div class="form-group">
                <label for="email"><i class="zmdi zmdi-email"></i></label>
                <input type="email" name="email" id="email" value="${email}" />
            </div>
            <div class="form-group">
                <label for="username"><i class="zmdi zmdi-email"></i></label>
                <input type="text" name="username" id="username" value="${username}" readonly />
            </div>
            <div class="form-group">
                <label for="contact"><i class="zmdi zmdi-lock-outline"></i></label>
                <input type="text" name="contact" id="contact" value="${mobile}" />
            </div>
            <button type="submit" class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded">
                Update Profile <i class="fas fa-bars"></i>
            </button>
        </form>
    </div>
</section>
</body>
</html>
