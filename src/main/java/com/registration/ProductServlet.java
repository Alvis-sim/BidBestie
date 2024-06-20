package com.registration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

@WebServlet("/Product")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Product> products = new ArrayList<>();

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidbestie?serverTimezone=UTC", "root", "root")) {
            System.out.println("Database connection successful");

            String sql = "SELECT productName, buyoutPrice, imageUrl FROM products ORDER BY RAND() LIMIT 3";
            try (PreparedStatement statement = con.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        String name = resultSet.getString("productName");
                        double price = resultSet.getDouble("buyoutPrice");
                        String imagePath = resultSet.getString("imageUrl");
                        products.add(new Product(name, price, imagePath));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Optionally, redirect to an error page or show a message to the user
            // request.getRequestDispatcher("error.jsp").forward(request, response);
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("Landingpage.jsp").forward(request, response);
    }
}
