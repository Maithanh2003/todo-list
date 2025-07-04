<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.todo.model.Todo" %>

<%
    Todo todo = (Todo) request.getAttribute("todo");
    if (todo == null) {
        response.sendRedirect("todo?error=not_found");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết công việc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="user-styles.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=theme" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg mb-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="todo">To-do App</a>
            <div class="ms-auto">
                <a href="todo" class="btn btn-primary">Quay lại</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h2 class="mb-0">Chi tiết công việc</h2>
            </div>
            <div class="card-body">
                <h5 class="card-title"><%= todo.getTask() %></h5>
                <p class="card-text">
                    <strong>Mô tả:</strong> <%= todo.getDescription() != null ? todo.getDescription() : "Không có" %>
                </p>
                <p class="card-text">
                    <strong>Danh mục:</strong> <%= todo.getCategoryName() %>
                </p>
                <p class="card-text">
                    <strong>Hạn chót:</strong> <%= todo.getDeadline() %>
                </p>
                <div class="mb-3">
                    <label for="completed" class="form-label"><strong>Trạng thái:</strong></label>
                    <select class="form-select" id="completed" name="completed" disabled>
                        <option value="todo" <%= "todo".equals(todo.getCompleted()) ? "selected" : "" %>>Chưa làm</option>
                        <option value="inprogress" <%= "inprogress".equals(todo.getCompleted()) ? "selected" : "" %>>Đang làm</option>
                        <option value="completed" <%= "completed".equals(todo.getCompleted()) ? "selected" : "" %>>Hoàn thành</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>