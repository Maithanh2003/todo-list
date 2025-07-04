<%-- admin_user.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.example.todo.model.User" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
    request.setAttribute("title", "User Management");
    request.setAttribute("activePage", "users");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="components/header.jsp" />
    <style>
        .header-actions {
            display: none;
        }
        .form-inline-group {
            display: flex;
            flex-direction: row;
            gap: 6px;
            align-items: center;
        }
        .form-inline-group input,
        .form-inline-group select {
            max-width: 160px;
        }
    </style>
</head>
<body>
<div class="d-flex vh-100">
    <jsp:include page="components/sidebar.jsp" />
    <main class="main-content p-4 flex-grow-1">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h3 fw-bold">👥 User Management</h1>
        </div>

        <div class="card dashboard-card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% if (users == null || users.isEmpty()) { %>
                            <tr>
                                <td colspan="5" class="text-center text-secondary py-4">No users found.</td>
                            </tr>
                        <% } else { for (User u : users) { %>
                            <tr>
                                <td><%= u.getId() %></td>
                                <td class="fw-semibold"><%= u.getUsername() %></td>
                                <td><%= u.getEmail() %></td>
                                <td>
                                    <span class="badge <%= "ADMIN".equals(u.getRole().name()) ? "bg-primary" : "bg-secondary" %>">
                                        <%= u.getRole().name() %>
                                    </span>
                                </td>
                                <td>
                                    <div class="d-flex justify-content-center gap-2 flex-wrap">

                                        <!-- Update username & email -->
                                        <form method="post" action="user-management" class="form-inline-group" title="Edit user info">
                                            <input type="hidden" name="id" value="<%= u.getId() %>" />
                                            <input type="hidden" name="action" value="update" />
                                            <input type="text" name="username" class="form-control form-control-sm" 
                                                   value="<%= u.getUsername() %>" required minlength="3" maxlength="50" />
                                            <input type="email" name="email" class="form-control form-control-sm"
                                                   value="<%= u.getEmail() %>" required maxlength="100"
                                                   pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$" />
                                            <button type="submit" class="btn btn-sm btn-outline-secondary" title="Save changes">
                                                <i class="bi bi-save"></i>
                                            </button>
                                        </form>

                                        <!-- Change role -->
                                        <form method="post" action="user-management" class="form-inline-group" title="Change role">
                                            <input type="hidden" name="id" value="<%= u.getId() %>" />
                                            <input type="hidden" name="action" value="changerole" />
                                            <select name="role" class="form-select form-select-sm">
                                                <option value="USER" <%= "USER".equals(u.getRole().name()) ? "selected" : "" %>>USER</option>
                                                <option value="ADMIN" <%= "ADMIN".equals(u.getRole().name()) ? "selected" : "" %>>ADMIN</option>
                                            </select>
                                            <button type="submit" class="btn btn-sm btn-outline-primary" title="Change role">
                                                <i class="bi bi-shield-lock"></i>
                                            </button>
                                        </form>

                                        <!-- Delete -->
                                        <form method="post" action="user-management"
                                              onsubmit="return confirm('Are you sure you want to delete this user?');"
                                              title="Delete user">
                                            <input type="hidden" name="action" value="delete" />
                                            <input type="hidden" name="id" value="<%= u.getId() %>" />
                                            <button type="submit" class="btn btn-sm btn-outline-danger">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>

                                    </div>
                                </td>
                            </tr>
                        <% }} %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="components/footer.jsp" />
</div>
</body>
</html>
