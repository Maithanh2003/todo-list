<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
</html> --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.todo.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    String message = (String) request.getAttribute("message");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("title", "My Profile");
    request.setAttribute("activePage", "profile");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="components/header.jsp" />
    <title>My Profile</title>
</head>
<body>
<div class="d-flex vh-100">
    <jsp:include page="components/sidebar.jsp" />
    <main class="main-content w-100">
        <div class="container" style="max-width: 800px; margin: auto;">
            <h1 class="mb-4" style="color: var(--text-dark); font-weight: 600;">My Profile</h1>

            <!-- Alert nếu có message -->
            <% if (message != null && !message.isEmpty()) { %>
                <div class="alert alert-success mb-4" style="background-color: var(--success-color); color: white; border-radius: 8px; padding: 1rem;">
                    <%= message %>
                </div>
            <% } %>

            <!-- Avatar -->
            <div class="text-center mb-4">
                <img src="https://ui-avatars.com/api/?name=<%= currentUser.getUsername().replace(" ", "+") %>&background=random&color=fff"
                     alt="User Avatar"
                     class="rounded-circle"
                     style="width: 120px; height: 120px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); border: 4px solid #fff;">
                <h3 class="mt-3" style="color: var(--primary-color);"><%= currentUser.getUsername() %></h3>
            </div>

            <!-- Form -->
            <form method="post" action="profile">
                <div class="mb-3">
                    <label class="form-label" for="fullName" style="font-weight: 500;">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName"
                           value="<%= currentUser.getFullName() != null ? currentUser.getFullName() : "" %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="phone" style="font-weight: 500;">Phone</label>
                    <input type="tel" class="form-control" id="phone" name="phone"
                           value="<%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %>"
                           pattern="[0-9]{10}" placeholder="e.g., 0901234567">
                </div>

                <div class="mb-3">
                    <label class="form-label" for="email" style="font-weight: 500;">Email</label>
                    <input type="email" class="form-control" id="email" name="email"
                           value="<%= currentUser.getEmail() %>" readonly>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary" style="background-color: var(--primary-color); color: white; padding: 0.6rem 2rem; border-radius: 25px;">Save Changes</button>
                </div>
            </form>
        </div>
    </main>
    <jsp:include page="components/footer.jsp" />
</div>
</body>
</html>