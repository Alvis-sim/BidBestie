<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sell your product</title>
    <link rel="stylesheet" type="text/css" href="css/sellProductStyle.css">
</head>
<body>
    <div class="container">
        <h2>Product Listing</h2>
        <form action="processSellProduct" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="productName">Name of Product:</label>
                <input type="text" id="productName" name="productName" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="5" cols="30" required></textarea>
            </div>
            <div class="form-group">
                <label for="category">Category:</label>
                <select id="category" name="category" required>
                    <option value="electronics">Electronics</option>
                    <option value="fashion">Fashion</option>
                    <option value="home">Home</option>
                    <option value="books">Books</option>
                    <option value="other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="buyoutPrice">Buy it now price:</label>
                <input type="number" id="buyoutPrice" name="buyoutPrice" step="1.00" required>
            </div>
            <div class="form-group">
                <label for="startingPrice">Starting bid price:</label>
                <input type="number" id="startingPrice" name="startingPrice" step="1.00" required>
            </div>
             <div class="form-group">
                <label for="productImage">Product Image:</label>
                <input type="file" id="productImage" name="productImage" accept="image/*" onchange="previewImage(event)">
                <img id="preview" src="#" alt="Image Preview" style="display: none; max-width: 100%; height: auto; margin-top: 10px;">
            </div>
            <div class="form-group text-center">
                <button type="submit">Submit</button>
            </div>
        </form>
    </div>
        <script>
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function() {
                var output = document.getElementById('preview');
                output.src = reader.result;
                output.style.display = 'block';
            }
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</body>
</html>
