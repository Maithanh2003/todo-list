<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.example.todo.model.User"%>
<%
User currentUser = (User) session.getAttribute("user");
if (currentUser == null || !"ADMIN".equals(currentUser.getRole().name())) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="container">
		<h2>
			Chào Admin
			<%=currentUser.getUsername()%>!
		</h2>
		<nav>
			<ul>
				<li><a href="user-management">👥 Quản lý người dùng</a></li>
				<li><a href="task-management">📋 Quản lý task</a></li>
				<li><a href="logout">🚪 Đăng xuất</a></li>
			</ul>
		</nav>
	</div>
</body>
</html> 