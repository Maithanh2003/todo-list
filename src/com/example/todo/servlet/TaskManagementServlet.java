package com.example.todo.servlet;

import com.example.todo.DAO.CategoryDAO;
import com.example.todo.DAO.TodoDAO;
import com.example.todo.DAO.UserDAO;
import com.example.todo.model.Todo;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

public class TaskManagementServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
	        throws ServletException, IOException {
	    String action = req.getParameter("action");

	    try {
	        if ("edit".equalsIgnoreCase(action)) {
	            int id = Integer.parseInt(req.getParameter("id"));
	            Todo todo = TodoDAO.findById(id);

	            req.setAttribute("task", todo);
	            req.setAttribute("categories", CategoryDAO.getAll());
	            req.setAttribute("users", UserDAO.getAll());
	            req.getRequestDispatcher("admin_task_form.jsp").forward(req, res);

	        } else if ("create".equalsIgnoreCase(action)) {
	            req.setAttribute("categories", CategoryDAO.getAll());
	            req.setAttribute("users", UserDAO.getAll());
	            req.getRequestDispatcher("admin_task_form.jsp").forward(req, res);

	        } else {
	            // Pagination setup
	            int page = 1;
	            int limit = 5;
	            String pageParam = req.getParameter("page");
	            if (pageParam != null) {
	                try {
	                    page = Integer.parseInt(pageParam);
	                } catch (NumberFormatException ignored) {}
	            }
	            int offset = (page - 1) * limit;

	            // Filters
	            String search = req.getParameter("search");
	            String category = req.getParameter("category");
	            String status = req.getParameter("status");

	            List<Todo> todos;
	            int totalTasks;

	            if ((search != null && !search.isEmpty()) || (category != null && !category.isEmpty()) || (status != null && !status.isEmpty())) {
	                todos = TodoDAO.filterTasksWithPagination(search, category, status, offset, limit);
	                totalTasks = TodoDAO.countFilteredTasks(search, category, status);
	            } else {
	                todos = TodoDAO.getPaginated(offset, limit);
	                totalTasks = TodoDAO.countAllTasks();
	            }

	            int totalPages = (int) Math.ceil((double) totalTasks / limit);

	            req.setAttribute("todos", todos);
	            req.setAttribute("currentPage", page);
	            req.setAttribute("totalPages", totalPages);
	            req.setAttribute("categories", CategoryDAO.getAll());
	            req.setAttribute("activePage", "tasks");

	            req.getRequestDispatcher("admin_tasks.jsp").forward(req, res);
	        }

	    } catch (Exception e) {
	        throw new ServletException("Lỗi khi xử lý GET TaskManagementServlet", e);
	    }
	}


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if ("create".equalsIgnoreCase(action)) {
                int userId = Integer.parseInt(req.getParameter("userId"));
                String task = req.getParameter("task");
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));
                String completed = req.getParameter("completed");
                Date deadline = parseDate(req.getParameter("deadline"));
                String description = req.getParameter("description");

                TodoDAO.insert(userId, task, completed, categoryId, deadline, description);
                res.sendRedirect("task-management");

            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                int userId = Integer.parseInt(req.getParameter("userId"));
                String task = req.getParameter("task");
                String completed = req.getParameter("completed");
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));
                Date deadline = parseDate(req.getParameter("deadline"));
                String description = req.getParameter("description");

                TodoDAO.update(id, userId, task, completed, categoryId, deadline, description);
                res.sendRedirect("task-management");

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                TodoDAO.delete(id);
                res.sendRedirect("task-management");

            } else {
                res.sendRedirect("task-management");
            }

        } catch (Exception e) {
            throw new ServletException("Lỗi khi xử lý POST TaskManagementServlet", e);
        }
    }

    private Date parseDate(String dateStr) {
        try {
            return (dateStr != null && !dateStr.isEmpty()) ? Date.valueOf(dateStr) : null;
        } catch (Exception e) {
            return null;
        }
    }
}
