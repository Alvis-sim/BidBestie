<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Password</title>
    <!-- Include your CSS and JS files here -->
</head>
<body>

<section class="page-section portfolio" id="portfolio">
    <div class="container">
        <!-- Portfolio Section Heading-->
        <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">Update Password</h2>

        <form action="${pageContext.request.contextPath}/UpdateUserPasswordServlet" method="post">
    		<input type="hidden" name="accountID" value="${accountID}" />

    		<div class="form-group">
        		<label for="oldPassword"><i class="zmdi zmdi-lock"></i> Old Password</label>
        		<input type="password" name="oldPassword" id="oldPassword" required />
    		</div>

    		<div class="form-group">
        		<label for="newPassword"><i class="zmdi zmdi-lock-outline"></i> New Password</label>
        		<input type="password" name="newPassword" id="newPassword" required />
    		</div>

    		<div class="form-group">
        		<label for="confirmPassword"><i class="zmdi zmdi-lock-outline"></i> Confirm New Password</label>
        		<input type="password" name="confirmPassword" id="confirmPassword" required />
    		</div>

    		<button type="submit" class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded">
        		Update Password <i class="fas fa-bars"></i>
    		</button>
		</form>

    </div>
</section>

</body>
</html>
