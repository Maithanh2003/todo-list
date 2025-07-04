<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.todo.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    String message = (String) request.getAttribute("message");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa thông tin cá nhân</title>
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
                <h2 class="mb-0">Chỉnh sửa thông tin cá nhân</h2>
            </div>
            <div class="card-body">
                <% if (message != null && !message.isEmpty()) { %>
                    <div class="alert alert-success" role="alert">
                        <%= message %>
                    </div>
                <% } %>
                <div class="text-center mb-4">
                    <img src="https://ui-avatars.com/api/?name=<%= currentUser.getUsername().replace(" ", "+") %>&background=random&color=fff"
                         alt="User Avatar"
                         class="rounded-circle"
                         style="width: 120px; height: 120px; border: 4px solid #fff;">
                    <h3 class="mt-3"><%= currentUser.getUsername() %></h3>
                </div>
                <form method="post" action="profile">
                    <input type="hidden" name="redirect" value="index.jsp">
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="fullName" name="fullName"
                               value="<%= currentUser.getFullName() != null ? currentUser.getFullName() : "" %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control" id="phone" name="phone"
                               value="<%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %>"
                               pattern="[0-9]{10}" placeholder="VD: 0901234567">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email"
                               value="<%= currentUser.getEmail() %>" readonly>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>