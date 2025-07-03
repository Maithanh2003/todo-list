package com.example.todo.request;

import jakarta.servlet.http.HttpServletRequest;

public class LoginRequest {
    private String username;
    private String password;

    public LoginRequest(HttpServletRequest req) {
        this.username = req.getParameter("username");
        this.password = req.getParameter("password");
    }

    public String getUsername() { return username; }
    public String getPassword() { return password; }
}
