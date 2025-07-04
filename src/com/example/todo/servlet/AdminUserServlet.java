package com.example.todo.servlet;

import com.example.todo.DAO.UserDAO;
import com.example.todo.model.User;
import com.example.todo.model.enums.Role;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.regex.Pattern;

public class AdminUserServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		List<User> users = null;
		try {
			users = UserDAO.getAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		req.setAttribute("users", users);
		req.getRequestDispatcher("admin_users.jsp").forward(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        int id = Integer.parseInt(req.getParameter("id"));

        try {
            if ("delete".equals(action)) {
                UserDAO.delete(id);
            } else if ("update".equals(action)) {
                String username = req.getParameter("username");
                String email = req.getParameter("email");

                if (!isValidEmail(email)) {
                    req.setAttribute("error", "Email không hợp lệ!");
                    doGet(req, res);
                    return;
                }

                User user = UserDAO.findById(id);
                if (user == null) throw new Exception("User not found");

                UserDAO.update(id, username, email, user.getRole());
            }
            res.sendRedirect("user-management");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
	

    private boolean isValidEmail(String email) {
        return email != null && Pattern.matches("^[A-Za-z0-9+_.-]+@(.+)$", email);
    }
}