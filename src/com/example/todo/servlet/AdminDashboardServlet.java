package com.example.todo.servlet;

import com.example.todo.model.User;
import com.example.todo.model.enums.Role;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		User currentUser = (User) req.getSession().getAttribute("user");

		if (currentUser == null || currentUser.getRole() != Role.ADMIN) {
			res.sendRedirect("login.jsp");
			return;
		}

		req.getRequestDispatcher("admin_dashboard.jsp").forward(req, res);
	}
}
