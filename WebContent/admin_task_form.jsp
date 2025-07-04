<!-- admin_task_form.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.example.todo.model.Todo, java.util.List, com.example.todo.model.Category, com.example.todo.model.User, java.text.SimpleDateFormat"%>
<%
    Todo task = (Todo) request.getAttribute("task");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    List<User> users = (List<User>) request.getAttribute("users");
    boolean isEdit = task != null;
    request.setAttribute("title", isEdit ? "Edit Task" : "Add New Task");
    request.setAttribute("activePage", "tasks");
    String deadlineValue = "";
    if (isEdit && task.getDeadline() != null) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        deadlineValue = sdf.format(task.getDeadline());
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="components/header.jsp" />
    <style>
        .header-actions {
            display: none; /* Ẩn header-actions trên các trang khác */
        }
    </style>
</head>
<body>
    <div class="d-flex vh-100">
        <jsp:include page="components/sidebar.jsp" />
        <main class="main-content p-4 flex-grow-1">
            <h1 class="h3 fw-bold mb-4"><%= isEdit ? "Edit Task" : "Add New Task" %></h1>
            <div class="card dashboard-card">
                <div class="card-body p-4">
                    <form method="post" action="task-management">
                        <% if (isEdit) { %>
                            <input type="hidden" name="action" value="update" />
                            <input type="hidden" name="id" value="<%= task.getId() %>" />
                        <% } else { %>
                            <input type="hidden" name="action" value="create" />
                        <% } %>

                        <div class="mb-3">
                            <label for="task" class="form-label">Task Title</label>
                            <input type="text" name="task" id="task" class="form-control" value="<%= isEdit ? task.getTask() : "" %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea name="description" id="description" class="form-control" rows="3"><%= isEdit && task.getDescription() != null ? task.getDescription() : "" %></textarea>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="userId" class="form-label">Assigned User</label>
                                <select name="userId" id="userId" class="form-select" required>
                                    <% if (users != null) for (User u : users) { %>
                                        <option value="<%= u.getId() %>" <%= isEdit && u.getId() == task.getUserId() ? "selected" : "" %>>
                                            <%= u.getUsername() %>
                                        </option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="categoryId" class="form-label">Category</label>
                                <select name="categoryId" id="categoryId" class="form-select" required>
                                    <% if (categories != null) for (Category c : categories) { %>
                                        <option value="<%= c.getId() %>" <%= isEdit && c.getName().equals(task.getCategoryName()) ? "selected" : "" %>>
                                            <%= c.getName() %>
                                        </option>
                                    <% } %>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="deadline" class="form-label">Deadline</label>
                            <input type="date" name="deadline" id="deadline" class="form-control" value="<%= deadlineValue %>">
                        </div>

                        <div class="mb-4">
                            <label for="completed" class="form-label">Status</label>
                            <select class="form-select" id="completed" name="completed" required>
                                <option value="todo" <%= isEdit && "todo".equals(task.getCompleted()) ? "selected" : "" %>>To Do</option>
                                <option value="inprogress" <%= isEdit && "inprogress".equals(task.getCompleted()) ? "selected" : "" %>>In Progress</option>
                                <option value="completed" <%= isEdit && "completed".equals(task.getCompleted()) ? "selected" : "" %>>Completed</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <a href="task-management" class="btn btn-secondary">Back</a>
                            <button type="submit" class="btn btn-primary"><%= isEdit ? "Update" : "Create" %></button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
        <jsp:include page="components/footer.jsp" />
    </div>
</body>
</html>