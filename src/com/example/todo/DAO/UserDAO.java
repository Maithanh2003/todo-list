// UserDAO.java
package com.example.todo.DAO;

import com.example.todo.model.User;
import com.example.todo.model.enums.Role;
import com.example.todo.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	public static List<User> getAll() throws Exception {
		List<User> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM users ORDER BY id ASC");
		while (rs.next()) {
			User user = new User();
			user.setId(rs.getInt("id"));
			user.setUsername(rs.getString("username"));
			user.setEmail(rs.getString("email"));
			user.setRole(Role.valueOf(rs.getString("role")));
			list.add(user);
		}
		conn.close();
		return list;
	}

	public static User findById(int id) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
		ps.setInt(1, id);
		ResultSet rs = ps.executeQuery();

		User user = null;
		if (rs.next()) {
			user = new User();
			user.setId(rs.getInt("id"));
			user.setUsername(rs.getString("username"));
			user.setEmail(rs.getString("email"));
			user.setRole(Role.valueOf(rs.getString("role")));
		}

		conn.close();
		return user;
	}

	public static void delete(int id) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id = ?");
		ps.setInt(1, id);
		ps.executeUpdate();
		conn.close();
	}

	public static void update(int id, String username, String email, Role role) throws Exception {
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement("UPDATE users SET username = ?, email = ?, role = ? WHERE id = ?");
		ps.setString(1, username);
		ps.setString(2, email);
		ps.setString(3, role.name());
		ps.setInt(4, id);
		ps.executeUpdate();
		conn.close();
	}
	public static void updateProfile(int id, String fullName, String phone, String email) throws Exception {
	    Connection conn = DBUtil.getConnection();
	    PreparedStatement ps = conn.prepareStatement(
	        "UPDATE users SET full_name = ?, phone = ?, email = ? WHERE id = ?"
	    );
	    ps.setString(1, fullName);
	    ps.setString(2, phone);
	    ps.setString(3, email);
	    ps.setInt(4, id);
	    ps.executeUpdate();
	    conn.close();
	}
}