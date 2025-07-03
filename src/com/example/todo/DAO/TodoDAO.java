// TodoDAO.java
package com.example.todo.DAO;

import com.example.todo.model.Todo;
import com.example.todo.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TodoDAO {
	public static List<Todo> getAll() throws Exception {
		List<Todo> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"SELECT t.*, c.name AS category_name FROM todos t LEFT JOIN categories c ON t.category_id = c.id ORDER BY t.id DESC");
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			list.add(new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getBoolean("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline")));
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
			list.add(new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getBoolean("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline")));
		}
		conn.close();
		return list;
	}

	public static void insert(int userId, String task, int categoryId, Date deadline) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn
				.prepareStatement("INSERT INTO todos (user_id, task, category_id, deadline) VALUES (?, ?, ?, ?)");
		ps.setInt(1, userId);
		ps.setString(2, task);
		ps.setInt(3, categoryId);
		ps.setDate(4, deadline);
		ps.executeUpdate();
		conn.close();
	}

	public static void update(int id, int userId, String task, boolean completed, int categoryId, Date deadline)
			throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"UPDATE todos SET task = ?, completed = ?, category_id = ?, deadline = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ? AND user_id = ?");
		ps.setString(1, task);
		ps.setBoolean(2, completed);
		ps.setInt(3, categoryId);
		ps.setDate(4, deadline);
		ps.setInt(5, id);
		ps.setInt(6, userId);
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
			return new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getBoolean("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline"));
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
			return new Todo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("task"), rs.getBoolean("completed"),
					rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getString("category_name"),
					rs.getDate("deadline"));
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

}