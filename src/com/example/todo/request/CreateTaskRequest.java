package com.example.todo.request;

import jakarta.servlet.http.HttpServletRequest;
import java.sql.Date;

public class CreateTaskRequest {
    private String task;
    private String categoryName;
    private Date deadline;
    private String completed;
    private String description;

    public CreateTaskRequest(HttpServletRequest req) {
        this.task = req.getParameter("task");
        this.categoryName = req.getParameter("categoryName");

        String deadlineStr = req.getParameter("deadline");
        if (deadlineStr != null && !deadlineStr.isEmpty()) {
            this.deadline = Date.valueOf(deadlineStr);
        }

        this.completed = req.getParameter("completed");
        if (this.completed == null || this.completed.trim().isEmpty()) {
            this.completed = "todo";
        }

        this.description = req.getParameter("description");
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

    public String getCompleted() {
        return completed;
    }

    public String getDescription() {
        return description;
    }

    public boolean isValid() {
        return task != null && !task.trim().isEmpty()
            && categoryName != null && !categoryName.trim().isEmpty()
            && deadline != null;
    }
}
