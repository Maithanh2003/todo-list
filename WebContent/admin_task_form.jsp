<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.example.todo.model.Todo"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.todo.model.Category"%>
<%@ page import="com.example.todo.model.User"%>
<%
Todo task = (Todo) request.getAttribute("task");
List<Category> categories = (List<Category>) request.getAttribute("categories");
List<User> users = (List<User>) request.getAttribute("users");
boolean isEdit = task != null;
%>

<h2><%=isEdit ? "Chỉnh sửa Task" : "Thêm Task mới"%></h2>

<form method="post" action="task-management">
	<%
	if (isEdit) {
	%>
	<input type="hidden" name="action" value="update" /> <input
		type="hidden" name="id" value="<%=task.getId()%>" />
	<%
	} else {
	%>
	<input type="hidden" name="action" value="create" />
	<%
	}
	%>

	<label>Nội dung:</label> <input type="text" name="task"
		value="<%=isEdit ? task.getTask() : ""%>" required /><br /> <label>Người
		dùng:</label> <select name="userId" required>
		<%
		for (User u : users) {
		%>
		<option value="<%=u.getId()%>"
			<%=isEdit && u.getId() == task.getUserId() ? "selected" : ""%>>
			<%=u.getUsername()%>
		</option>
		<%
		}
		%>
	</select><br /> <label>Danh mục:</label> <select name="categoryId" required>
		<%
		for (Category c : categories) {
		%>
		<option value="<%=c.getId()%>"
			<%=isEdit && c.getName().equals(task.getCategoryName()) ? "selected" : ""%>>
			<%=c.getName()%>
		</option>
		<%
		}
		%>
	</select><br /> <label>Hạn chót:</label> <input type="date" name="deadline"
		value="<%=isEdit && task.getDeadline() != null ? task.getDeadline().toString() : ""%>" /><br />

	<label>Hoàn thành:</label> <input type="checkbox" name="completed"
		<%=isEdit && task.isCompleted() ? "checked" : ""%> /><br />

	<button type="submit"><%=isEdit ? "Cập nhật" : "Tạo mới"%></button>
</form>

<a href="task-management">⬅ Quay lại</a>
