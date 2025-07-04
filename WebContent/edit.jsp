<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.todo.model.Todo, java.util.List, com.example.todo.model.Category, java.text.SimpleDateFormat" %>

<%
    Todo todo = (Todo) request.getAttribute("todo");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa công việc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="user-styles.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=theme" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg mb-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="todo">To-do App</a>
            <div class="ms-auto">
                <a href="todo" class="btn btn-secondary">Quay lại</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h2 class="mb-0">Sửa công việc</h2>
            </div>
            <div class="card-body">
                <form action="todo" method="post">
                    <input type="hidden" name="id" value="<%= todo.getId() %>">
                    <div class="mb-3">
                        <label for="task" class="form-label">Công việc</label>
                        <input type="text" class="form-control" id="task" name="task" value="<%= todo.getTask() %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Mô tả</label>
                        <textarea class="form-control" id="description" name="description" rows="3"><%= todo.getDescription() != null ? todo.getDescription() : "" %></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Danh mục</label>
                        <select class="form-select" id="categoryName" name="categoryName" required>
                            <% for (Category cat : categories) {
                                String selected = cat.getName().equals(todo.getCategoryName()) ? "selected" : "";
                            %>
                                <option value="<%= cat.getName() %>" <%= selected %>><%= cat.getName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="deadline" class="form-label">Hạn chót</label>
                        <input type="date" class="form-control" id="deadline" name="deadline" value="<%= todo.getDeadline() != null ? sdf.format(todo.getDeadline()) : "" %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="completed" class="form-label">Trạng thái</label>
                        <select class="form-select" id="completed" name="completed">
                            <option value="todo" <%= "todo".equals(todo.getCompleted()) ? "selected" : "" %>>Chưa làm</option>
                            <option value="inprogress" <%= "inprogress".equals(todo.getCompleted()) ? "selected" : "" %>>Đang làm</option>
                            <option value="completed" <%= "completed".equals(todo.getCompleted()) ? "selected" : "" %>>Hoàn thành</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>