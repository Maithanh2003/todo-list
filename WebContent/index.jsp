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
<html>
<head>
<meta charset="UTF-8">
<title>Trang chính - To-do App</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="container">
		<h2>
			Chào
			<%=user.getUsername()%>!
		</h2>
		<a href="logout">Đăng xuất</a>

		<h3>Danh sách công việc</h3>
		<ul class="todo-list">
			<%
			if (todos != null && !todos.isEmpty()) {
				for (Todo todo : todos) {
			%>
			<li><strong><%=todo.getTask()%></strong>
				<div class="actions">
					<%=todo.isCompleted() ? "[✔ Hoàn thành]"
		: "<a href='todo?action=complete&id=" + todo.getId() + "'>Hoàn Thành</a>"%>
					<a href="todo?action=edit&id=<%=todo.getId()%>">Sửa</a> <a
						href="todo?action=delete&id=<%=todo.getId()%>">Xoá</a> <a
						href="todo?action=view&id=<%=todo.getId()%>">Chi tiết</a>
				</div> <small> Danh mục: <%=todo.getCategoryName()%> | Hết hạn: <%=todo.getDeadline()%>
					<br> Tạo lúc: <%=new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm").format(todo.getCreatedAt())%>
					| Cập nhật: <%=new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm").format(todo.getUpdatedAt())%>
			</small></li>
			<%
			}
			} else {
			%>
			<li>Chưa có công việc nào.</li>
			<%
			}
			%>
		</ul>

		<h3>Thêm công việc mới</h3>
		<form method="post" action="todo">
			<input type="text" name="task" placeholder="Nội dung công việc"
				required> <select name="categoryName" required>
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
			</select> <input type="date" name="deadline" required>
			<button type="submit">Thêm</button>
		</form>
		<h3>Thêm danh mục mới</h3>
		<form method="post" action="category">
			<input type="text" name="name" placeholder="Tên danh mục" required>
			<button type="submit">Thêm</button>
		</form>

	</div>
</body>
</html>
