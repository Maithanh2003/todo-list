<!-- admin_task.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page
	import="java.util.List, com.example.todo.model.Todo, java.text.SimpleDateFormat"%>
<%@ page import="com.example.todo.model.Category"%>

<%
List<Todo> tasks = (List<Todo>) request.getAttribute("todos");
List<String> categories = (List<String>) request.getAttribute("categories");
request.setAttribute("title", "Task Management");
request.setAttribute("activePage", "tasks");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
<jsp:include page="components/header.jsp" />
<style>
.header-actions {
	display: none;
}
</style>
</head>
<body>
	<div class="d-flex vh-100">
		<jsp:include page="components/sidebar.jsp" />
		<main class="main-content p-4 flex-grow-1">
			<div class="d-flex justify-content-between align-items-center mb-4">
				<h1 class="h3 fw-bold">All Tasks</h1>
				<a href="task-management?action=create"
					class="btn btn-primary fw-semibold"> <i
					class="bi bi-plus-lg me-1"></i> Add New Task
				</a>
			</div>

			<!-- FILTER FORM -->
			<div class="card mb-3">
				<div class="card-body p-3">
					<form method="get" action="task-management"
						class="d-flex gap-3 flex-wrap align-items-center">
						<input type="text" name="search" class="form-control"
							placeholder="Search tasks..."
							value="<%=request.getParameter("search") != null ? request.getParameter("search") : ""%>">

						<select name="category" class="form-select w-auto">
							<option value="">All Categories</option>
							<%
							List<Category> categoryList = (List<Category>) request.getAttribute("categories");
							if (categoryList != null) {
								for (Category cat : categoryList) {
									String catName = cat.getName();
							%>
							<option value="<%=catName%>"
								<%=catName.equals(request.getParameter("category")) ? "selected" : ""%>>
								<%=catName%>
							</option>
							<%
							}
							}
							%>
						</select> <select name="status" class="form-select w-auto">
							<option value="">All Status</option>
							<option value="completed"
								<%="completed".equals(request.getParameter("status")) ? "selected" : ""%>>Completed</option>
							<option value="inprogress"
								<%="inprogress".equals(request.getParameter("status")) ? "selected" : ""%>>In
								Progress</option>
							<option value="todo"
								<%="todo".equals(request.getParameter("status")) ? "selected" : ""%>>To
								Do</option>
						</select>

						<button type="submit" class="btn btn-primary">Apply
							Filters</button>
					</form>
				</div>
			</div>

			<!-- TASK LIST -->
			<div class="d-flex flex-column gap-3">
				<%
				if (tasks == null || tasks.isEmpty()) {
				%>
				<div class="card task-card p-4 text-center text-secondary">No
					tasks to display.</div>
				<%
				} else {
				for (Todo todo : tasks) {
				%>
				<div class="card task-card p-3">
					<div class="card-body d-flex align-items-start gap-3">
						<input type="checkbox" class="form-check-input" disabled
							<%="completed".equals(todo.getCompleted()) ? "checked" : ""%>>
						<div class="flex-grow-1">
							<div class="d-flex justify-content-between align-items-center">
								<p
									class="fw-semibold mb-1 <%="completed".equals(todo.getCompleted()) ? "text-decoration-line-through" : ""%>"><%=todo.getTask()%></p>
								<span class="badge bg-light border text-dark"><%=todo.getCategoryName() != null ? todo.getCategoryName() : "N/A"%></span>
							</div>
							<p class="text-secondary small mb-1"><%=todo.getDescription() != null ? todo.getDescription() : "(No description)"%></p>
							<div class="d-flex align-items-center gap-2 small text-secondary">
								<span><i class="bi bi-calendar-event me-1"></i> Due: <%=todo.getDeadline() != null ? new SimpleDateFormat("yyyy-MM-dd").format(todo.getDeadline()) : "N/A"%></span>
								<%
								String status = todo.getCompleted();
								String statusLabel = "N/A";
								String statusClass = "text-secondary";
								if ("completed".equalsIgnoreCase(status)) {
									statusLabel = "Completed";
									statusClass = "text-success";
								} else if ("inprogress".equalsIgnoreCase(status)) {
									statusLabel = "In Progress";
									statusClass = "text-primary";
								} else if ("todo".equalsIgnoreCase(status)) {
									statusLabel = "To Do";
									statusClass = "text-warning";
								}
								%>
								<span class="<%=statusClass%> fw-medium"> <i
									class="bi bi-check-circle-fill me-1"></i> <%=statusLabel%>
								</span>
							</div>
						</div>
						<div class="d-flex align-items-center gap-2">
							<a href="task-management?action=edit&id=<%=todo.getId()%>"
								class="text-muted"><i class="bi bi-pencil-square fs-5"></i></a>
							<form method="post" action="task-management" class="d-inline"
								onsubmit="return confirm('Are you sure you want to delete this task?');">
								<input type="hidden" name="action" value="delete" /> <input
									type="hidden" name="id" value="<%=todo.getId()%>" />
								<button type="submit" class="btn btn-sm btn-outline-danger">
									<i class="bi bi-trash3 fs-5"></i>
								</button>
							</form>
						</div>
					</div>
				</div>
				<%
				}
				}
				%>
			</div>
			<!-- Pagination -->
			<%
Integer currentPage = (Integer) request.getAttribute("currentPage");
Integer totalPages = (Integer) request.getAttribute("totalPages");

String baseUrl = "task-management?";
String searchParam = request.getParameter("search");
String categoryParam = request.getParameter("category");
String statusParam = request.getParameter("status");

if (searchParam != null && !searchParam.isEmpty())
	baseUrl += "search=" + searchParam + "&";
if (categoryParam != null && !categoryParam.isEmpty())
	baseUrl += "category=" + categoryParam + "&";
if (statusParam != null && !statusParam.isEmpty())
	baseUrl += "status=" + statusParam + "&";
%>

			<%
			if (totalPages > 1) {
			%>
			<nav aria-label="Page navigation" class="mt-4">
				<ul class="pagination justify-content-center">
					<%
					for (int i = 1; i <= totalPages; i++) {
					%>
					<li class="page-item <%=(i == currentPage) ? "active" : ""%>">
						<a class="page-link" href="<%=baseUrl + "page=" + i%>"><%=i%></a>
					</li>
					<%
					}
					%>
				</ul>
			</nav>
			<%
			}
			%>

		</main>
		<jsp:include page="components/footer.jsp" />
	</div>
</body>
</html>
