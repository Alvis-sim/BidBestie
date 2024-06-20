<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Purchases</title>
    <link href="css/viewfeedback.css" rel="stylesheet" />
    </head>
    
    <body>
        <div class="top">
            <div class="logo">
                <h1>BidBestie</h1>
            </div>
            <div class="search">
                <select id="category">
                    <option value="">Search by Category</option>
                    <option value="electronics">Electronics</option>
                    <option value="women-fashion">Women Fashion</option>
                    <option value="men-fashion">Men Fashion</option>
                    <option value="living">Living</option>
                    <option value="accessories">Accessories</option>
                    <option value="beauty-health">Beauty & Health</option>
                    <option value="travel">Travel</option>
                    <option value="sporting-goods">Sporting Goods</option>
                    <option value="pet-supplies">Pet Supplies</option>
                </select>
                <input type="text" placeholder="Search...">
                <button type="submit">Search</button>
                <button type="submit">Advanced Search</button>
            </div>
        </div>

        <div class="user-info">
            <span>User!</span>
            <div class="links">
                <a href="viewaccount.jsp">My Account</a>
                <a href="register.jsp">Register</a>
                <a href="#" id="logoutLink">Logout</a>
                <a href="#"><i class="fa fa-bell"></i></a>
                <a href="#"><i class="fa fa-heart"></i></a>
                <a href="#"><i class="fa fa-shopping-cart"></i></a>
            </div>  
        </div>
        
        <div class="main-container">
            <div class="sidenav">
                <a href="viewaccount.jsp">Profile</a>
                <a href="viewpurchases.jsp">Purchases</a>
                <button class="dropdown-btn">Selling 
                    <i class="fa fa-caret-down" style="font-size:24px"></i>
                </button>
                <div class="dropdown-container">
                    <a href="viewlisting.jsp">Active</a>
                    <a href="#">Inventory</a>
                    <a href="#">Analytics</a>
                </div>
                <a href="viewmessages.jsp">Messages</a>
                <a href="viewfeedback.jsp">Feedback</a>
            </div>
            <main>
                <div class="content">
                    <h1>View Feedback</h1>
                    <div class="feedback-table">
                        <div class="summary">
                            <p>Average rating: 4.5/5</p>
                            <br>
                            <p>Total feedback: 2</p>
                            <br>
                        </div>
                        <table>
                            <tr>
                                <th>Buyer</th>
                                <th>Product Name</th>
                                <th>Feedback</th>
                                <th>Rating</th>
                                <th>Time</th>
                            </tr>
                            <tr>
                                <td>Smmad1</td>
                                <td>Product A</td>
                                <td>Good quality, I am very satisfied. Quick delivery!</td>
                                <td>★★★★☆</td>
                                <td>08/05/2024</td>
                            </tr>
                            <tr>
                                <td>Dole12</td>
                                <td>Product C</td>
                                <td>It's good, but there is a slight error in color.</td>
                                <td>★★★☆☆</td>
                                <td>21/04/2024</td>
                            </tr>
                        </table>
                        <p class="feedback-link">Need help? <a href="#" id="leave-feedback-link">Leave us a feedback!</a></p>
                    </div>
                </div>
            </main>
        </div>

        <!-- The Modal -->
        <div id="feedbackModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h2>Leave a Feedback</h2>
                <br>
                <form>
                    <label for="feedback-text">Tell us your issue:</label>
                    <textarea id="feedback-text" rows="5" cols="46"></textarea>
                    <div class="modal-buttons">
                        <button type="submit">Submit</button>
                        <button type="button" class="cancel">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        
        <script>
            var modal = document.getElementById("feedbackModal");
            var btn = document.getElementById("leave-feedback-link");
            var span = document.getElementsByClassName("close")[0];
            var cancelBtn = document.getElementsByClassName("cancel")[0];

            btn.onclick = function() {
                modal.style.display = "block";
            }

            span.onclick = function() {
                modal.style.display = "none";
            }

            cancelBtn.onclick = function() {
                modal.style.display = "none";
            }

            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
            
        </script>
    </body>
</html>
