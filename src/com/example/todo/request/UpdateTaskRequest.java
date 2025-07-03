package com.example.todo.request;

import jakarta.servlet.http.HttpServletRequest;
import java.sql.Date;

public class UpdateTaskRequest {
	private int id;
	private String task;
	private boolean completed;
	private String categoryName;
	private Date deadline;

	public UpdateTaskRequest(HttpServletRequest req) {
		this.id = Integer.parseInt(req.getParameter("id"));
		this.task = req.getParameter("task");
		this.completed = req.getParameter("completed") != null;
		this.categoryName = req.getParameter("categoryName");

		String deadlineStr = req.getParameter("deadline");
		if (deadlineStr != null && !deadlineStr.isEmpty()) {
			this.deadline = Date.valueOf(deadlineStr);
		}
	}

	public int getId() {
		return id;
	}

	public String getTask() {
		return task;
	}

	public boolean isCompleted() {
		return completed;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public Date getDeadline() {
		return deadline;
	}

	public boolean isValid() {
		return task != null && !task.trim().isEmpty() && deadline != null;
	}
}
