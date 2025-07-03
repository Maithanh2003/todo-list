package com.example.todo.servlet;

import com.example.todo.DAO.CategoryDAO;
import com.example.todo.DAO.TodoDAO;
import com.example.todo.DAO.UserDAO;
import com.example.todo.model.Todo;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

public class TaskManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Todo todo = TodoDAO.findById(id);
                req.setAttribute("task", todo);

                req.setAttribute("categories", CategoryDAO.getAll());
                req.setAttribute("users", UserDAO.getAll());

                req.getRequestDispatcher("admin_task_form.jsp").forward(req, res);

            } else if ("create".equals(action)) {
                // Load danh mục & user cho dropdown
                req.setAttribute("categories", CategoryDAO.getAll());
                req.setAttribute("users", UserDAO.getAll());

                req.getRequestDispatcher("admin_task_form.jsp").forward(req, res);

            } else {
                // Mặc định: hiển thị danh sách task
                List<Todo> todos = TodoDAO.getAll();
                req.setAttribute("todos", todos);
                req.getRequestDispatcher("admin_tasks.jsp").forward(req, res);
            }
        } catch (Exception e) {
            throw new ServletException("Lỗi khi xử lý GET admin task", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if ("create".equals(action)) {
                int userId = Integer.parseInt(req.getParameter("userId"));
                String task = req.getParameter("task");
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));
                Date deadline = Date.valueOf(req.getParameter("deadline"));
                
                TodoDAO.insert(userId, task, categoryId, deadline);
                res.sendRedirect("task-management");
                return;

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                int userId = Integer.parseInt(req.getParameter("userId"));
                String task = req.getParameter("task");
                boolean completed = req.getParameter("completed") != null;
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));
                Date deadline = Date.valueOf(req.getParameter("deadline"));

                TodoDAO.update(id, userId, task, completed, categoryId, deadline);
                res.sendRedirect("task-management");
                return;

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                TodoDAO.delete(id);
                res.sendRedirect("task-management");
                return;
            }

            res.sendRedirect("task-management");
        } catch (Exception e) {
            throw new ServletException("Lỗi khi xử lý POST admin task", e);
        }
    }

}
