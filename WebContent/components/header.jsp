<%-- /webapp/components/header.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.todo.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    String activePage = (String) request.getAttribute("activePage");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("title") != null ? request.getAttribute("title") : "TaskFlow Admin" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Header cố định và căn trái-phải -->
    <header class="header d-flex justify-content-between align-items-center px-4 py-2 shadow-sm bg-white sticky-top">
        <div class="logo d-flex align-items-center gap-2">
            <span class="bg-primary text-white p-2 rounded-circle">
                <i class="bi bi-kanban-fill fs-5"></i>
            </span>
            <span class="fs-4 fw-bold">TaskFlow</span>
        </div>
        
        <%-- Chỉ hiện khi ở trang dashboard --%>
        <div class="header-actions d-flex align-items-center gap-2 <%= !"dashboard".equals(activePage) ? "d-none" : "" %>">
            <a href="task-management?action=create" class="btn btn-primary fw-semibold">
                <i class="bi bi-plus-lg me-1"></i> New Task
            </a>
            <button class="btn btn-outline-secondary">
                <i class="bi bi-download me-1"></i> Export
            </button>
        </div>
    </header>
</body>
</html>
