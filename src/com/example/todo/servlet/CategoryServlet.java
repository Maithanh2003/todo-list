package com.example.todo.servlet;

import java.io.IOException;

import com.example.todo.DAO.CategoryDAO;
import com.example.todo.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String name = req.getParameter("name");
        try {
            if (name != null && !name.trim().isEmpty()) {
                CategoryDAO.insert(name.trim());
            }
            res.sendRedirect("todo");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

