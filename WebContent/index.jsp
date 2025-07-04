<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.todo.model.Todo"%>
<%@ page import="com.example.todo.model.User"%>
<%@ page import="com.example.todo.model.Category"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
	response.sendRedirect("login.jsp");
	return;
}

List<Todo> todos = (List<Todo>) request.getAttribute("todos");
List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang chính - To-do App</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="user-styles.css" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=theme"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg mb-4">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">To-do App</a>
			<div class="ms-auto d-flex align-items-center">
				<span class="me-3">Hello <%=user.getUsername().toUpperCase()%>!
				</span> <a href="user-profile.jsp" class="btn btn-outline-primary me-2">Information</a>
				<a href="logout" class="btn btn-outline-danger">Logout</a>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="card mb-4">
			<div class="card-header">
				<h3 class="mb-0">TO DO LIST</h3>
			</div>
			<div class="card-body">
				<div class="alert alert-success mb-3" role="alert">List Task</div>
				<div class="mb-3 d-flex justify-content-between">
					<input type="text" class="form-control w-50"
						placeholder="Task Description">
					<button class="btn btn-secondary ms-2">Search</button>
				</div>
				<%
				if (todos != null && !todos.isEmpty()) {
				%>
				<div class="table-responsive">
					<table class="table table-borderless">
						<thead>
							<tr style="background-color: #4CAF50; color: #fff;">
								<th>Task <i class="fas fa-sort"></i></th>
								<th>Description <i class="fas fa-sort"></i></th>
								<th>Status <i class="fas fa-sort"></i></th>
								<th>Created Date <i class="fas fa-sort"></i></th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Todo todo : todos) {
							%>
							<tr
								class="todo-card <%="completed".equalsIgnoreCase(todo.getCompleted()) ? "completed" : ""%>">
								<td><%=todo.getTask()%></td>
								<td><%=todo.getDescription() != null ? todo.getDescription() : "-"%></td>
								<td>
									<%
									String status = todo.getCompleted();
									String icon = "";
									String label = "";
									String color = "";

									if ("todo".equalsIgnoreCase(status)) {
										icon = "fa-circle";
										label = "Chưa làm";
										color = "secondary";
									} else if ("inprogress".equalsIgnoreCase(status)) {
										icon = "fa-spinner";
										label = "Đang làm";
										color = "primary";
									} else if ("completed".equalsIgnoreCase(status)) {
										icon = "fa-check-circle";
										label = "Hoàn thành";
										color = "success";
									} else {
										icon = "fa-question-circle";
										label = status;
										color = "dark";
									}
									%> <span class="badge bg-<%=color%>"> <i
										class="fas <%=icon%> me-1"></i> <%=label%>
								</span>
								</td>
								<td><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(todo.getCreatedAt())%></td>
								<td class="actions">
									<%
									if (!"completed".equalsIgnoreCase(todo.getCompleted())) {
									%>  <%
 }
 %> <a
									href="todo?action=edit&id=<%=todo.getId()%>" title="Sửa"><i
										class="fas fa-edit text-primary"></i></a> <a
									href="todo?action=delete&id=<%=todo.getId()%>" title="Xoá"><i
										class="fas fa-trash-alt text-danger"></i></a> <a
									href="todo?action=view&id=<%=todo.getId()%>" title="Chi tiết"><i
										class="fas fa-eye text-info"></i></a>
								</td>
							</tr>
							<%
							}
							%>
						</tbody>

					</table>
				</div>
				<%
				} else {
				%>
				<div class="alert alert-info" role="alert">Chưa có công việc
					nào.</div>
				<%
				}
				%>
			</div>
		</div>

		<div class="card mb-4">
			<div class="card-header">
				<h3 class="mb-0">Thêm công việc mới</h3>
			</div>
			<div class="card-body">
				<form method="post" action="todo">
					<div class="mb-3">
						<label for="task" class="form-label">Nội dung công việc</label> <input
							type="text" class="form-control" id="task" name="task"
							placeholder="Nhập công việc" required>
					</div>
					<div class="mb-3">
						<label for="description" class="form-label">Mô tả</label>
						<textarea class="form-control" id="description" name="description"
							rows="3" placeholder="Nhập mô tả"></textarea>
					</div>
					<div class="mb-3">
						<label for="categoryName" class="form-label">Danh mục</label> <select
							class="form-select" id="categoryName" name="categoryName"
							required>
							<option value="">-- Chọn danh mục --</option>
							<%
							if (categories != null) {
								for (Category cat : categories) {
							%>
							<option value="<%=cat.getName()%>"><%=cat.getName()%></option>
							<%
							}
							}
							%>
						</select>
					</div>
					<div class="mb-3">
						<label for="deadline" class="form-label">Hạn chót</label> <input
							type="date" class="form-control" id="deadline" name="deadline"
							required>
					</div>
					<button type="submit" class="btn btn-primary">Thêm</button>
				</form>
			</div>
		</div>

		<div class="card">
			<div class="card-header">
				<h3 class="mb-0">Thêm danh mục mới</h3>
			</div>
			<div class="card-body">
				<form method="post" action="category">
					<div class="mb-3">
						<label for="name" class="form-label">Tên danh mục</label> <input
							type="text" class="form-control" id="name" name="name"
							placeholder="Nhập tên danh mục" required>
					</div>
					<button type="submit" class="btn btn-primary">Thêm</button>
				</form>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>