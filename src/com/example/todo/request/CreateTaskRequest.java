package com.example.todo.request;

import jakarta.servlet.http.HttpServletRequest;
import java.sql.Date;

public class CreateTaskRequest {
	private String task;
	private String categoryName;
	private Date deadline;

	public CreateTaskRequest(HttpServletRequest req) {
		this.task = req.getParameter("task");
		this.categoryName = req.getParameter("categoryName");

		String deadlineStr = req.getParameter("deadline");
		if (deadlineStr != null && !deadlineStr.isEmpty()) {
			this.deadline = Date.valueOf(deadlineStr);
		}
	}

	public String getTask() {
		return task;
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
