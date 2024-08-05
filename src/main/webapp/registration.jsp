<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>BidBestie | Sign up</title>

<!-- Font Icon -->
<link rel="stylesheet"
    href="fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
    <div class="main">

        <!-- Sign up form -->
        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Sign up</h2>
                    
                        <form method="post" action="register" class="register-form"
                            id="register-form">
                            <div class="form-group">
                                <label for="fname"><i class="zmdi zmdi-account material-icons-name"></i></label> 
                                <input type="text" name="fname" id="fname" placeholder="First name"/>
                            </div>
                            <div class="form-group">
                                <label for="lname"><i class="zmdi zmdi-account material-icons-name"></i></label> 
                                <input type="text" name="lname" id="lname" placeholder="Last name"/>
                            </div>
                            <div class="form-group">
                                <label for="username"><i class="zmdi zmdi-account material-icons-name"></i></label> 
                                <input type="text" name="username" id="username" placeholder="Username"/>
                            </div>
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label> 
                                <input type="email" name="email" id="email" placeholder="Your Email" />
                            </div>
                            <div class="form-group">
                                <label for="pass"><i class="zmdi zmdi-lock"></i></label> 
                                <input type="password" name="pass" id="pass" placeholder="Password" />
                            </div>
                            <div class="form-group">
                                <label for="re_pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                <input type="password" name="re_pass" id="re_pass"
                                    placeholder="Re-enter your password" />
                            </div>
                            <div class="form-group">
                                <label for="contact"><i class="zmdi zmdi-phone"></i></label>
                                <input type="text" name="contact" id="contact"
                                    placeholder="Contact no" />
                            </div>
                            <div class="form-group">
                                <input type="checkbox" name="agree-term" id="agree-term"
                                    class="agree-term" /> 
                                <label for="agree-term"
                                    class="label-agree-term"><span><span></span></span>I
                                    agree all statements in <a href="#" class="term-service">Terms
                                        of service</a></label>
                            </div>
                            <div class="form-group form-button">
                                <input type="submit" name="signup" id="signup"
                                    class="form-submit" value="Register" />
                            </div>
                        </form>
                    </div>
                    <div class="signup-image">
                        <figure>
                            <img src="images/signup-image.jpg" alt="sign up image">
                        </figure>
                        <a href="login.jsp" class="signup-image-link">I am already
                            a member</a>
                    </div>
                </div>
            </div>
        </section>

    </div>
    <!-- JS -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="alert/dist/sweetalert.css">

<script type="text/javascript">
    var status = document.getElementById("status").value;
    if(status == "success"){
        swal("Congratulations", "Account created successfully", "success");
    }
    if(status == "invalidUsernameLength"){
        swal("Sorry", "Username must be between 4 and 15 characters", "error");
    }
    if(status == "invalidPasswordLength"){
        swal("Sorry", "Password must be between 3 and 20 characters", "error");
    }
    if(status == "passwordMismatch"){
        swal("Sorry", "Passwords do not match", "error");
    }
    if(status == "invalidEmail"){
        swal("Sorry", "Please enter a valid email address", "error");
    }
    if(status == "invalidMobile"){
        swal("Sorry", "Please enter a valid mobile number", "error");
    }
    if(status == "mobileExists"){
        swal("Sorry", "Mobile number is already in use", "error");
    }
    if(status == "usernameExists"){
        swal("Sorry", "Username is already in use", "error");
    }
    if(status == "emailExists"){
        swal("Sorry", "Email is already in use", "error");
    }
</script>
</body>
</html>
