<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.example.todo.model.Todo"%>
<%
Todo todo = (Todo) request.getAttribute("todo");
if (todo == null) {
	response.sendRedirect("todo?error=not_found");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Chi tiết công việc</title>
</head>
<body>
	<h2>Chi tiết công việc</h2>
	<p>
		<strong>Công việc:</strong>
		<%=todo.getTask()%></p>
	<p>
		<strong>Danh mục:</strong>
		<%=todo.getCategoryName()%></p>
	<p>
		<strong>Hết hạn:</strong>
		<%=todo.getDeadline()%></p>
	<p>
		<strong>Hoàn thành:</strong>
		<%=todo.isCompleted() ? "Đã hoàn thành" : "Chưa hoàn thành"%></p>
	<a href="todo">Quay lại</a>
</body>
</html>
