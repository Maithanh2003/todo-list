package com.example.todo.model;

import java.sql.Timestamp;
import java.sql.Date;

public class Todo {
    private int id;
    private int userId;
    private String task;
    private String completed;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String categoryName;
    private Date deadline;
    private String description;
    private String assignedTo;
    
    public Todo() {}

    public Todo(int id, int userId, String task, String completed,
                Timestamp createdAt, Timestamp updatedAt, String categoryName, Date deadline) {
        this.id = id;
        this.userId = userId;
        this.task = task;
        this.completed = completed;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.categoryName = categoryName;
        this.deadline = deadline;
    }
    
    public Todo(int id, int userId, String task, String completed,
            Timestamp createdAt, Timestamp updatedAt,
            String categoryName, Date deadline, String description) {
    this.id = id;
    this.userId = userId;
    this.task = task;
    this.completed = completed;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.categoryName = categoryName;
    this.deadline = deadline;
    this.description = description;
}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getTask() { return task; }
    public void setTask(String task) { this.task = task; }

    public String getCompleted() { return completed; }
    public void setCompleted(String completed) { this.completed = completed; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public Date getDeadline() { return deadline; }
    public void setDeadline(Date deadline) { this.deadline = deadline; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}