// TodoDAO.java
package com.example.todo.DAO;

import com.example.todo.model.Todo;
import com.example.todo.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class TodoDAO {
	public static List<Todo> getAll() throws Exception {
		List<Todo> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"SELECT t.*, c.name AS category_name FROM todos t LEFT JOIN categories c ON t.category_id = c.id ORDER BY t.id DESC");
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			list.add(new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getString("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline"), rs.getString("description")));
		}

		conn.close();
		return list;
	}

	public static List<Todo> getAllByUser(int userId) throws Exception {
		List<Todo> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"SELECT t.*, c.name AS category_name FROM todos t LEFT JOIN categories c ON t.category_id = c.id WHERE t.user_id = ? ORDER BY t.id DESC");
		ps.setInt(1, userId);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			list.add(new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getString("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline"), rs.getString("description")));
		}
		conn.close();
		return list;
	}

	public static void insert(int userId, String task, String completed, int categoryId, Date deadline,
			String description) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"INSERT INTO todos (user_id, task, completed, category_id, deadline, description) VALUES (?, ?, ?, ?, ?, ?)");
		ps.setInt(1, userId);
		ps.setString(2, task);
		ps.setString(3, completed);
		ps.setInt(4, categoryId);
		ps.setDate(5, deadline);
		ps.setString(6, description);
		ps.executeUpdate();
		conn.close();
	}

	public static void update(int id, int userId, String task, String completed, int categoryId, Date deadline,
			String description) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"UPDATE todos SET task = ?, completed = ?, category_id = ?, deadline = ?, description = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ? AND user_id = ?");
		ps.setString(1, task);
		ps.setString(2, completed);
		ps.setInt(3, categoryId);
		ps.setDate(4, deadline);
		ps.setString(5, description);
		ps.setInt(6, id);
		ps.setInt(7, userId);
		ps.executeUpdate();
		conn.close();
	}

	public static void delete(int id, int userId) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement("DELETE FROM todos WHERE id = ? AND user_id = ?");
		ps.setInt(1, id);
		ps.setInt(2, userId);
		ps.executeUpdate();
		conn.close();
	}

	public static void delete(int id) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement("DELETE FROM todos WHERE id = ?");
		ps.setInt(1, id);
		ps.executeUpdate();
		conn.close();
	}

	public static void complete(int id, int userId) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"UPDATE todos SET completed = TRUE, updated_at = CURRENT_TIMESTAMP WHERE id = ? AND user_id = ?");
		ps.setInt(1, id);
		ps.setInt(2, userId);
		ps.executeUpdate();
		conn.close();
	}

	public static void complete(int id) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn
				.prepareStatement("UPDATE todos SET completed = TRUE, updated_at = CURRENT_TIMESTAMP WHERE id = ?");
		ps.setInt(1, id);
		ps.executeUpdate();
		conn.close();
	}

	public static Todo findById(int id, int userId) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"SELECT t.*, c.name AS category_name FROM todos t LEFT JOIN categories c ON t.category_id = c.id WHERE t.id = ? AND t.user_id = ?");
		ps.setInt(1, id);
		ps.setInt(2, userId);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			return new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getString("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline"), rs.getString("description"));
		}
		conn.close();
		return null;
	}

	public static Todo findById(int id) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"SELECT t.*, c.name AS category_name FROM todos t LEFT JOIN categories c ON t.category_id = c.id WHERE t.id = ?");
		ps.setInt(1, id);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			return new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getString("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline"), rs.getString("description"));
		}
		conn.close();
		return null;
	}

	public static int getLastInsertedId() throws Exception {
		Connection conn = DBUtil.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT MAX(id) AS last_id FROM todos");
		if (rs.next()) {
			return rs.getInt("last_id");
		}
		conn.close();
		return -1;
	}

	public static List<Todo> filterTasks(String search, String category, String status) throws Exception {
		List<Todo> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();

		StringBuilder query = new StringBuilder(
				"SELECT t.*, c.name AS category_name FROM todos t LEFT JOIN categories c ON t.category_id = c.id WHERE 1=1");

		List<Object> params = new ArrayList<>();

		if (search != null && !search.isEmpty()) {
			query.append(" AND t.task ILIKE ?");
			params.add("%" + search + "%");
		}

		if (category != null && !category.isEmpty()) {
			query.append(" AND c.name = ?");
			params.add(category);
		}

		if (status != null && !status.isEmpty()) {
			query.append(" AND t.completed = ?");
			params.add(status);
		}

		query.append(" ORDER BY t.id DESC");

		PreparedStatement ps = conn.prepareStatement(query.toString());

		for (int i = 0; i < params.size(); i++) {
			ps.setObject(i + 1, params.get(i));
		}

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			list.add(new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getString("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline"), rs.getString("description")));
		}

		conn.close();
		return list;
	}

	public static List<Todo> filterTasksWithPagination(String search, String category, String status, int offset,
			int limit) throws Exception {
		List<Todo> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();

		StringBuilder query = new StringBuilder("SELECT t.*, c.name AS category_name "
				+ "FROM todos t LEFT JOIN categories c ON t.category_id = c.id WHERE 1=1");

		List<Object> params = new ArrayList<>();

		if (search != null && !search.isEmpty()) {
			query.append(" AND t.task ILIKE ?");
			params.add("%" + search + "%");
		}

		if (category != null && !category.isEmpty()) {
			query.append(" AND c.name = ?");
			params.add(category);
		}

		if (status != null && !status.isEmpty()) {
			query.append(" AND t.completed = ?");
			params.add(status);
		}

		query.append(" ORDER BY t.created_at DESC LIMIT ? OFFSET ?");
		params.add(limit);
		params.add(offset);

		PreparedStatement ps = conn.prepareStatement(query.toString());
		for (int i = 0; i < params.size(); i++) {
			ps.setObject(i + 1, params.get(i));
		}

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			list.add(new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getString("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline"), rs.getString("description")));
		}

		conn.close();
		return list;
	}

	public static int countFilteredTasks(String search, String category, String status) throws Exception {
		Connection conn = DBUtil.getConnection();

		StringBuilder query = new StringBuilder(
				"SELECT COUNT(*) FROM todos t LEFT JOIN categories c ON t.category_id = c.id WHERE 1=1");

		List<Object> params = new ArrayList<>();

		if (search != null && !search.isEmpty()) {
			query.append(" AND t.task ILIKE ?");
			params.add("%" + search + "%");
		}

		if (category != null && !category.isEmpty()) {
			query.append(" AND c.name = ?");
			params.add(category);
		}

		if (status != null && !status.isEmpty()) {
			query.append(" AND t.completed = ?");
			params.add(status);
		}

		PreparedStatement ps = conn.prepareStatement(query.toString());
		for (int i = 0; i < params.size(); i++) {
			ps.setObject(i + 1, params.get(i));
		}

		ResultSet rs = ps.executeQuery();
		int count = 0;
		if (rs.next()) {
			count = rs.getInt(1);
		}
		conn.close();
		return count;
	}

	public static List<Todo> getPaginated(int offset, int limit) throws Exception {
		List<Todo> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();

		String query = "SELECT t.*, c.name AS category_name FROM todos t "
				+ "LEFT JOIN categories c ON t.category_id = c.id " + "ORDER BY t.created_at DESC LIMIT ? OFFSET ?";

		PreparedStatement ps = conn.prepareStatement(query);
		ps.setInt(1, limit);
		ps.setInt(2, offset);

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			list.add(new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getString("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline"), rs.getString("description")));
		}
		conn.close();
		return list;
	}

	public static int countAllTasks() throws Exception {
		Connection conn = DBUtil.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM todos");
		if (rs.next())
			return rs.getInt(1);
		conn.close();
		return 0;
	}

	public static List<Todo> getRecentTasks(int limit) throws Exception {
		List<Todo> tasks = new ArrayList<>();
		String sql = """
				    SELECT t.*, c.name AS category_name
				    FROM todos t
				    LEFT JOIN categories c ON t.category_id = c.id
				    ORDER BY t.created_at DESC
				    LIMIT ?
				""";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, limit);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Todo task = new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"),
							rs.getString("completed"), rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"),
							rs.getString("category_name"), rs.getDate("deadline"), rs.getString("description"));
					tasks.add(task);

				}
			}
		}

		return tasks;
	}
	public static int countByStatus(String status) throws Exception {
	    String sql = "SELECT COUNT(*) FROM todos WHERE completed = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, status);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) return rs.getInt(1);
	    }
	    return 0;
	}
	public static Map<String, Integer> countTasksPerDay(int limitDays) throws Exception {
	    Map<String, Integer> map = new LinkedHashMap<>();
	    String sql = "SELECT TO_CHAR(created_at, 'YYYY-MM-DD') AS date, COUNT(*) AS count " +
	                 "FROM todos GROUP BY date ORDER BY date DESC LIMIT ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, limitDays);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            map.put(rs.getString("date"), rs.getInt("count"));
	        }
	    }
	    return map;
	}
	public static Map<String, Integer> countTasksByCategory() throws Exception {
	    Map<String, Integer> map = new HashMap<>();
	    String sql = "SELECT c.name AS category, COUNT(*) AS count FROM todos t " +
	                 "LEFT JOIN categories c ON t.category_id = c.id GROUP BY c.name";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            String cat = rs.getString("category");
	            map.put(cat != null ? cat : "Uncategorized", rs.getInt("count"));
	        }
	    }
	    return map;
	}
	public static int countAll() throws Exception {
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM todos")) {
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) return rs.getInt(1);
	        return 0;
	    }
	}

	public static int countCompleted() throws Exception {
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM todos WHERE completed = 'completed'")) {
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) return rs.getInt(1);
	        return 0;
	    }
	}

	public static int countInProgress() throws Exception {
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM todos WHERE completed = 'inprogress'")) {
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) return rs.getInt(1);
	        return 0;
	    }
	}


}