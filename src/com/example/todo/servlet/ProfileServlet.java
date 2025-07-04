package com.example.todo.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.example.todo.DAO.UserDAO;
import com.example.todo.model.User;

public class ProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        req.setAttribute("title", "My Profile");
        req.setAttribute("activePage", "profile");
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            User currentUser = (User) req.getSession().getAttribute("user");
            if (currentUser == null) {
                resp.sendRedirect("login.jsp");
                return;
            }
            String fullName = req.getParameter("fullName");
            String phone = req.getParameter("phone");
            String email = req.getParameter("email");

            UserDAO.updateProfile(currentUser.getId(), fullName, phone, email);

            currentUser.setFullName(fullName);
            currentUser.setPhone(phone);
            currentUser.setEmail(email);
            req.getSession().setAttribute("user", currentUser);

            req.setAttribute("message", "Profile updated successfully.");
            doGet(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
