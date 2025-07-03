package com.example.todo.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.example.todo.DAO.CategoryDAO;
import com.example.todo.DAO.TodoDAO;
import com.example.todo.model.Category;
import com.example.todo.model.Todo;
import com.example.todo.model.User;
import com.example.todo.model.enums.Role;
import com.example.todo.request.CreateTaskRequest;
import com.example.todo.request.UpdateTaskRequest;

public class TodoServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		User user = (User) req.getSession().getAttribute("user");
		if (user == null) {
			res.sendRedirect("login.jsp");
			return;
		}

		try {
			String action = req.getParameter("action");
			String idStr = req.getParameter("id");

			boolean isAdmin = Role.ADMIN.equals(user.getRole());

			if (action != null && idStr != null) {
				int id = Integer.parseInt(idStr);

				if ("complete".equals(action)) {
					if (isAdmin) {
						TodoDAO.complete(id);
					} else {
						TodoDAO.complete(id, user.getId());
					}
					res.sendRedirect("todo");
					return;

				} else if ("delete".equals(action)) {
					if (isAdmin) {
						TodoDAO.delete(id);
					} else {
						TodoDAO.delete(id, user.getId());
					}
					res.sendRedirect("todo");
					return;

				} else if ("view".equals(action) || "edit".equals(action)) {
					Todo todo = isAdmin ? TodoDAO.findById(id) : TodoDAO.findById(id, user.getId());
					if (todo == null) {
						res.sendRedirect("todo?error=not_found");
						return;
					}

					List<Category> categories = CategoryDAO.getAll();
					req.setAttribute("todo", todo);
					req.setAttribute("categories", categories);

					req.getRequestDispatcher("/" + action + ".jsp").forward(req, res);
					return;
				}
			}

			// Mặc định: hiển thị danh sách todo
			List<Todo> todos = isAdmin ? TodoDAO.getAll() : TodoDAO.getAllByUser(user.getId());

			List<Category> categories = CategoryDAO.getAll();
			req.setAttribute("todos", todos);
			req.setAttribute("categories", categories);

			req.getRequestDispatcher("/index.jsp").forward(req, res);

		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		User user = (User) req.getSession().getAttribute("user");
		if (user == null) {
			res.sendRedirect("login.jsp");
			return;
		}

		try {
			String idStr = req.getParameter("id");

			if (idStr != null && !idStr.isEmpty()) {
				// Cập nhật task
				UpdateTaskRequest updateReq = new UpdateTaskRequest(req);
				if (!updateReq.isValid()) {
					res.sendRedirect("todo?error=invalid_input");
					return;
				}

				int categoryId = CategoryDAO.findIdByName(updateReq.getCategoryName());
				if (categoryId == -1) {
					res.sendRedirect("todo?error=invalid_category");
					return;
				}

				TodoDAO.update(updateReq.getId(), user.getId(), updateReq.getTask(), updateReq.isCompleted(),
						categoryId, updateReq.getDeadline());

			} else {
				// Tạo task mới
				CreateTaskRequest createReq = new CreateTaskRequest(req);
				if (!createReq.isValid()) {
					res.sendRedirect("todo?error=invalid_input");
					return;
				}

				int categoryId = CategoryDAO.findIdByName(createReq.getCategoryName());
				if (categoryId == -1) {
					res.sendRedirect("todo?error=invalid_category");
					return;
				}

				TodoDAO.insert(user.getId(), createReq.getTask(), categoryId, createReq.getDeadline());
			}

			res.sendRedirect("todo");

		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
