package com.example.todo.servlet;

import com.example.todo.DAO.AuthDAO;
import com.example.todo.model.User;
import com.example.todo.model.enums.Role;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");

		if ("login".equals(action)) {
			String username = req.getParameter("username");
			String password = req.getParameter("password");
			User user = null;
			try {
				user = AuthDAO.findByUsernameAndPassword(username, password);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (user != null) {
				req.getSession().setAttribute("user", user);
				if (Role.ADMIN.equals(user.getRole())) {
					res.sendRedirect("admin_dashboard.jsp");
				} else {
					res.sendRedirect("todo");
				}
			} else {
				req.setAttribute("error", "Invalid credentials");
				req.getRequestDispatcher("login.jsp").forward(req, res);
			}
		} else if ("register".equals(action)) {
			String username = req.getParameter("username");
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			try {
				if (AuthDAO.existsByUsernameOrEmail(username, email)) {
					req.setAttribute("error", "Username or email already exists");
					req.getRequestDispatcher("register.jsp").forward(req, res);
					return;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				AuthDAO.register(username, email, password);
			} catch (Exception e) {
				e.printStackTrace();
			}
			res.sendRedirect("login.jsp");
		}
	}
}