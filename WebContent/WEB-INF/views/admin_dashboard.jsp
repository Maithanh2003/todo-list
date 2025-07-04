<!-- admin_dashboard.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.example.todo.model.User"%>
<%@ page import="com.example.todo.model.Todo"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.stream.Collectors"%>

<%
User currentUser = (User) session.getAttribute("user");
if (currentUser == null || !"ADMIN".equals(currentUser.getRole().name())) {
	response.sendRedirect("login.jsp");
	return;
}

List<Todo> recentTasks = (List<Todo>) request.getAttribute("recentTasks");
Map<String, Integer> tasksPerDay = (Map<String, Integer>) request.getAttribute("tasksPerDay");
Map<String, Integer> tasksByCategory = (Map<String, Integer>) request.getAttribute("tasksByCategory");

String taskDates = tasksPerDay != null
		? tasksPerDay.keySet().stream().map(date -> "\"" + date + "\"").collect(Collectors.joining(","))
		: "";
String taskCounts = tasksPerDay != null
		? tasksPerDay.values().stream().map(String::valueOf).collect(Collectors.joining(","))
		: "";

String categoryLabels = tasksByCategory != null
		? tasksByCategory.keySet().stream().map(cat -> "\"" + cat + "\"").collect(Collectors.joining(","))
		: "";
String categoryCounts = tasksByCategory != null
		? tasksByCategory.values().stream().map(String::valueOf).collect(Collectors.joining(","))
		: "";
%>
<%
    request.setAttribute("title", "Dashboard");
    request.setAttribute("activePage", "dashboard");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
	<jsp:include page="../../components/header.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<div class="d-flex vh-100">
		<jsp:include page="../../components/sidebar.jsp" />
		<main class="main-content p-4 flex-grow-1">
			<div class="d-flex justify-content-between align-items-center mb-4">
				<div>
					<h1 class="h3 fw-bold">Dashboard</h1>
					<p class="text-secondary">
						Welcome, Admin <%=currentUser.getUsername()%>! Last updated:
						<%=new SimpleDateFormat("hh:mm a, MMMM dd, yyyy").format(new Date())%>
					</p>
				</div>
			</div>

			<!-- Stats Cards -->
			<div class="row g-4 mb-4">
				<div class="col-md-6 col-xl-3">
					<div class="card dashboard-card text-center p-3">
						<div class="card-body">
							<p class="text-secondary mb-2">Total Tasks</p>
							<h2 class="fw-bold display-6 mb-1"><%=request.getAttribute("totalTasks")%></h2>
						</div>
					</div>
				</div>
				<div class="col-md-6 col-xl-3">
					<div class="card dashboard-card text-center p-3">
						<div class="card-body">
							<p class="text-secondary mb-2">Completed</p>
							<h2 class="fw-bold display-6 mb-1"><%=request.getAttribute("completedTasks")%></h2>
						</div>
					</div>
				</div>
				<div class="col-md-6 col-xl-3">
					<div class="card dashboard-card text-center p-3">
						<div class="card-body">
							<p class="text-secondary mb-2">In Progress</p>
							<h2 class="fw-bold display-6 mb-1"><%=request.getAttribute("inProgressTasks")%></h2>
						</div>
					</div>
				</div>
				<div class="col-md-6 col-xl-3">
					<div class="card dashboard-card text-center p-3">
						<div class="card-body">
							<p class="text-secondary mb-2">Productivity</p>
							<h2 class="fw-bold display-6 mb-1"><%=request.getAttribute("productivity")%>%</h2>
						</div>
					</div>
				</div>
			</div>

			<!-- Charts Section -->
			<div class="row mb-4">
				<!-- Line Chart -->
				<div class="col-md-6">
					<div class="card h-100">
						<div class="card-body p-4">
							<h2 class="h5 fw-bold mb-3">📈 Productivity Trends</h2>
							<canvas id="taskChart" height="200"></canvas>
						</div>
					</div>
				</div>

				<!-- Pie Chart -->
				<div class="col-md-6">
					<div class="card h-100">
						<div class="card-body p-4">
							<h2 class="h5 fw-bold mb-3">🧩 Tasks by Category</h2>
							<canvas id="categoryChart" height="200"></canvas>
						</div>
					</div>
				</div>
			</div>

			<!-- Recent Tasks -->
			<div class="card">
				<div class="card-body p-4">
					<h2 class="h4 fw-bold mb-3">Recent Tasks</h2>
					<div class="d-flex flex-column gap-3">
						<%
						if (recentTasks != null && !recentTasks.isEmpty()) {
							for (Todo task : recentTasks) {
						%>
						<div class="card task-card p-3">
							<div class="card-body d-flex align-items-start gap-3">
								<input type="checkbox" class="form-check-input" 
									<%="completed".equalsIgnoreCase(task.getCompleted()) ? "checked" : ""%> disabled>
								<div class="flex-grow-1">
									<div class="d-flex justify-content-between align-items-center">
										<p class="fw-semibold mb-1 
											<%="completed".equalsIgnoreCase(task.getCompleted()) ? "text-decoration-line-through" : ""%>">
											<%=task.getTask()%>
										</p>
										<span class="badge bg-light border text-dark">
											<%=task.getCategoryName() != null ? task.getCategoryName() : "No Category"%>
										</span>
									</div>
									<p class="text-secondary small mb-1">
										<%=task.getDescription() != null ? task.getDescription() : "No description"%>
									</p>
									<div class="d-flex align-items-center gap-2 small text-secondary">
										<% if (task.getDeadline() != null) { %>
											<span><i class="bi bi-calendar-event me-1"></i> Due: <%=task.getDeadline()%></span>
										<% } %>
										<span><i class="bi bi-person me-1"></i> User ID: <%=task.getUserId()%></span>
										<span><i class="bi 
											<%="completed".equalsIgnoreCase(task.getCompleted()) ? "bi-check-circle-fill text-success"
												: "inprogress".equalsIgnoreCase(task.getCompleted()) ? "bi-hourglass-split text-primary"
												: "bi-circle text-muted"%> me-1"></i>
											Status: <%=task.getCompleted()%>
										</span>
									</div>
								</div>
								<div class="d-flex align-items-center gap-2">
									<a href="task-management?action=edit&id=<%=task.getId()%>" class="text-muted">
										<i class="bi bi-pencil-square fs-5"></i>
									</a>
									<a href="delete-task?id=<%=task.getId()%>" class="text-muted"
										onclick="return confirm('Are you sure you want to delete this task?');">
										<i class="bi bi-trash3 fs-5"></i>
									</a>
								</div>
							</div>
						</div>
						<% }
						} else { %>
							<p class="text-muted">No recent tasks available.</p>
						<% } %>
					</div>
				</div>
			</div>
		</main>
		<jsp:include page="../../components/footer.jsp" />
	</div>

	<!-- Chart.js Config -->
	<script>
		new Chart(document.getElementById('taskChart'), {
			type: 'line',
			data: {
				labels: [<%=taskDates%>],
				datasets: [{
					label: 'Tasks per day',
					data: [<%=taskCounts%>],
					borderColor: '#36A2EB',
					backgroundColor: '#9BD0F5',
					tension: 0.3
				}]
			},
			options: {
				responsive: true,
				plugins: {
					legend: { display: true }
				}
			}
		});

		new Chart(document.getElementById('categoryChart'), {
			type: 'pie',
			data: {
				labels: [<%=categoryLabels%>],
				datasets: [{
					data: [<%=categoryCounts%>],
					backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40']
				}]
			},
			options: { responsive: true }
		});
	</script>
</body>
</html>
