<%@ page import="java.util.List"%>
<%@ page import="com.example.todo.model.Todo"%>
<%@ page import="com.example.todo.model.Category"%>

<%
Todo todo = (Todo) request.getAttribute("todo");
List<Category> categories = (List<Category>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
<title>Sửa công việc</title>
</head>
<body>
	<h2>Sửa công việc</h2>
	<form action="todo" method="post">
		<input type="hidden" name="id" value="<%=todo.getId()%>"> <label>Công
			việc:</label> <input type="text" name="task" value="<%=todo.getTask()%>"
			required><br> <label>Danh mục:</label> <select
			name="categoryName" required>
			<%
			for (Category cat : categories) {
				String selected = cat.getName().equals(todo.getCategoryName()) ? "selected" : "";
			%>
			<option value="<%=cat.getName()%>" <%=selected%>><%=cat.getName()%></option>
			<%
			}
			%>
		</select><br> <label>Hạn chót:</label> <input type="date" name="deadline"
			value="<%=todo.getDeadline()%>" required><br> <label>
			<input type="checkbox" name="completed" value="true"
			<%=todo.isCompleted() ? "checked" : ""%>> Đã hoàn thành
		</label><br>

		<button type="submit">Cập nhật</button>
	</form>
	<a href="todo">Quay lại</a>
</body>
</html>
