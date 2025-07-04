package com.example.todo.request;

import jakarta.servlet.http.HttpServletRequest;
import java.sql.Date;

public class UpdateTaskRequest {
    private int id;
    private String task;
    private String categoryName;
    private Date deadline;
    private String completed;
    private String description;

    public UpdateTaskRequest(HttpServletRequest req) {
        // Lấy ID từ hidden input
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            this.id = Integer.parseInt(idStr);
        }

        this.task = req.getParameter("task");
        this.categoryName = req.getParameter("categoryName");

        String deadlineStr = req.getParameter("deadline");
        if (deadlineStr != null && !deadlineStr.isEmpty()) {
            this.deadline = Date.valueOf(deadlineStr);
        }

        this.completed = req.getParameter("completed");  // "todo", "inprogress", "completed"
        this.description = req.getParameter("description");
    }

    public int getId() {
        return id;
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
        return id > 0 && task != null && !task.trim().isEmpty()
            && categoryName != null && !categoryName.trim().isEmpty()
            && completed != null && !completed.trim().isEmpty()
            && deadline != null;
    }
}
