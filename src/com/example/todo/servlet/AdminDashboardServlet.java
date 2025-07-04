package com.example.todo.servlet;

import com.example.todo.DAO.TodoDAO;
import com.example.todo.model.User;
import com.example.todo.model.Todo;
import com.example.todo.model.enums.Role;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class AdminDashboardServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		User currentUser = (User) req.getSession().getAttribute("user");

		if (currentUser == null || currentUser.getRole() != Role.ADMIN) {
			res.sendRedirect("login.jsp");
			return;
		}

		try {
			List<Todo> recentTasks = TodoDAO.getRecentTasks(3);
			int totalTasks = TodoDAO.countAll();
			int completedTasks = TodoDAO.countCompleted();
			int inProgressTasks = TodoDAO.countInProgress();
			int notStartedTasks = TodoDAO.countByStatus("todo"); 

			Map<String, Integer> tasksPerDay = TodoDAO.countTasksPerDay(7);  
			Map<String, Integer> tasksByCategory = TodoDAO.countTasksByCategory();

			int productivity = (totalTasks > 0) ? (completedTasks * 100 / totalTasks) : 0;

			req.setAttribute("totalTasks", totalTasks);
			req.setAttribute("completedTasks", completedTasks);
			req.setAttribute("inProgressTasks", inProgressTasks);
			req.setAttribute("notStartedTasks", notStartedTasks);
			req.setAttribute("tasksPerDay", tasksPerDay);
			req.setAttribute("tasksByCategory", tasksByCategory);
			req.setAttribute("recentTasks", recentTasks);
			req.setAttribute("productivity", productivity);

		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("recentTasks", null);
		}

		req.getRequestDispatcher("/WEB-INF/views/admin_dashboard.jsp").forward(req, res);
	}
}
