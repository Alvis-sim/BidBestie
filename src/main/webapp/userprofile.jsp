<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<!-- Include your CSS and JS files here -->
</head>
<body>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand" href="#page-top">BidBestie</a>
        <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
                type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
                aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menu <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="UserLanding.jsp">Home</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="logout">Logout</a></li>                
            </ul>
        </div>
    </div>
</nav>

<section class="page-section portfolio" id="portfolio">
    <div class="container">
        <!-- Portfolio Section Heading-->
        <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">User Profile</h2>

        <div class="form-group">
            <label for="fname"><i class="zmdi zmdi-account material-icons-name"></i></label>
            <input type="text" name="fname" id="fname" value="${fname}" readonly/>
        </div>
        <div class="form-group">
            <label for="lname"><i class="zmdi zmdi-account material-icons-name"></i></label>
            <input type="text" name="lname" id="lname" value="${lname}" readonly/>
        </div>
        <div class="form-group">
            <label for="email"><i class="zmdi zmdi-email"></i></label>
            <input type="email" name="email" id="email" value="${email}" readonly/>
        </div>
        <div class="form-group">
            <label for="mobile"><i class="zmdi zmdi-lock-outline"></i></label>
            <input type="number" name="mobile" id="mobile" value="${mobile}" readonly/>
        </div>
        <a href="updateprofile.jsp">Update Profile</a>
        <a href="changepass.jsp">Reset Password</a>
    
</button>
</a>

    </div>
</section>
</body>
</html>
