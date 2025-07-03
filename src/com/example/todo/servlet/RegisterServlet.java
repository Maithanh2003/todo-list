package com.example.todo.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.example.todo.DAO.AuthDAO;
import com.example.todo.DAO.UserDAO;

public class RegisterServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			String username = req.getParameter("username");
			String email = req.getParameter("email");
			String password = req.getParameter("password");

			if (!AuthDAO.existsByUsernameOrEmail(username, email)) {
			    AuthDAO.register(username, email, password);
			    res.sendRedirect("login.jsp");
			} else {
			    req.setAttribute("error", "Username or email already exists");
			    req.getRequestDispatcher("/register.jsp").forward(req, res);
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
