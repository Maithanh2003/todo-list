<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.todo.model.Todo"%>
<%
List<Todo> tasks = (List<Todo>) request.getAttribute("todos");
%>

<h2>Danh sách Task</h2>

<a href="task-management?action=create">➕ Thêm Task mới</a>
<br />
<br />

<table border="1" cellpadding="5" cellspacing="0">
	<tr>
		<th>ID</th>
		<th>Nội dung</th>
		<th>Trạng thái</th>
		<th>Danh mục</th>
		<th>Hạn chót</th>
		<th>Thao tác</th>
	</tr>
	<%
	for (Todo todo : tasks) {
	%>
	<tr>
		<td><%=todo.getId()%></td>
		<td><%=todo.getTask()%></td>
		<td><%=todo.isCompleted() ? "✓ Hoàn thành" : "✗ Chưa xong"%></td>
		<td><%=todo.getCategoryName() != null ? todo.getCategoryName() : "Chưa có"%></td>
		<td><%=todo.getDeadline()%></td>
		<td><a href="task-management?action=edit&id=<%=todo.getId()%>">✏
				Sửa</a> |
			<form method="post" action="task-management" style="display: inline;"
				onsubmit="return confirm('Bạn có chắc muốn xoá task này?');">
				<input type="hidden" name="action" value="delete" /> <input
					type="hidden" name="id" value="<%=todo.getId()%>" />
				<button type="submit">🗑 Xoá</button>
			</form></td>
	</tr>
	<%
	}
	%>
</table>

<br />
<a href="admin_dashboard.jsp">⬅ Quay lại dashboard</a>
