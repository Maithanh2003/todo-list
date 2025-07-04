<!-- components/sidebar.jsp -->
<%@ page import="com.example.todo.model.User"%>
<%
User sidebarUser = (User) session.getAttribute("user");
String activePage = (String) request.getAttribute("activePage");
%>
<aside class="sidebar">
	<div class="sidebar-brand">
		<a href="admin_dashboard.jsp"
			class="text-dark text-decoration-none d-flex align-items-center">
			<span class="bg-primary text-white p-2 rounded-circle me-3"> <i
				class="bi bi-kanban-fill fs-5"></i>
		</span> <span class="fs-4 fw-bold text-primary">TaskFlow</span>
		</a>
	</div>

	<ul class="nav-menu list-unstyled mt-4">
		<li class="nav-item mb-2"><a href="admin-dashboard"
			class="nav-link sidebar-link <%="dashboard".equals(activePage) ? "active" : ""%>">
				<i class="bi bi-grid-1x2-fill me-2"></i> Dashboard
		</a></li>
		<li class="nav-item mb-2"><a href="task-management"
			class="nav-link sidebar-link <%="tasks".equals(activePage) ? "active" : ""%>">
				<i class="bi bi-list-task me-2"></i> All Tasks
		</a></li>
		<li class="nav-item mb-2"><a href="user-management"
			class="nav-link sidebar-link <%="users".equals(activePage) ? "active" : ""%>">
				<i class="bi bi-people-fill me-2"></i> Users
		</a></li>
		<li class="nav-item mb-2"><a href="profile"
			class="nav-link sidebar-link <%="profile".equals(activePage) ? "active" : ""%>">
				<i class="bi bi-person-circle me-2"></i> My Profile
		</a></li>
	</ul>

	<%
	if (sidebarUser != null) {
	%>
	<div class="user-profile-container">
		<div class="user-profile">
			<img
				src="https://ui-avatars.com/api/?name=<%=sidebarUser.getUsername().replace(" ", "+")%>&background=random&color=fff"
				alt="User Avatar" width="40" height="40" class="rounded-circle me-3" />
			<div class="flex-grow-1">
				<p class="fw-bold mb-0 text-dark"><%=sidebarUser.getUsername()%></p>
				<p class="text-muted mb-0 small"><%=sidebarUser.getEmail()%></p>
			</div>
			<a href="logout" class="logout-icon ms-auto" title="Logout"> <i
				class="bi bi-box-arrow-right fs-5"></i>
			</a>
		</div>
	</div>
	<%
	}
	%>
</aside>