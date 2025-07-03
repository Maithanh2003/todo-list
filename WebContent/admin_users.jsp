<!-- admin_users.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.todo.model.User"%>
<%
List<User> users = (List<User>) request.getAttribute("users");
%>
<h2>Quản lý Người dùng</h2>
<table border="1">
	<tr>
		<th>ID</th>
		<th>Username</th>
		<th>Email</th>
		<th>Vai trò</th>
		<th>Hành động</th>
	</tr>
	<%
	for (User u : users) {
	%>
	<tr>
		<td><%=u.getId()%></td>
		<td><%=u.getUsername()%></td>
		<td><%=u.getEmail()%></td>
		<td><%=u.getRole().name()%></td>
		<td>
			<form method="post" action="user-management" style="display: inline;">
				<input type="hidden" name="id" value="<%=u.getId()%>" /> <input
					type="hidden" name="action" value="delete" />
				<button type="submit">Xoá</button>
			</form>
			<form method="post" action="user-management" style="display: inline;">
				<input type="hidden" name="id" value="<%=u.getId()%>" /> <input
					type="hidden" name="action" value="changerole" /> <select
					name="role">
					<option value="USER">USER</option>
					<option value="ADMIN">ADMIN</option>
				</select>
				<button type="submit">Đổi vai trò</button>
			</form>
			<form method="post" action="user-management" style="display: inline;">
				<input type="hidden" name="id" value="<%=u.getId()%>" /> <input
					type="hidden" name="action" value="update" /> <input type="text"
					name="username" value="<%=u.getUsername()%>" maxlength="50"
					required /> <input type="email" name="email"
					value="<%=u.getEmail()%>" maxlength="100" required />
				<button type="submit">Cập nhật</button>
			</form>

		</td>
	</tr>
	<%
	}
	%>
</table>
<a href="admin_dashboard.jsp">⬅ Quay lại dashboard</a>