package com.example.todo.DAO;

import com.example.todo.model.User;
import com.example.todo.model.enums.Role;
import com.example.todo.util.DBUtil;

import java.sql.*;

public class AuthDAO {
    public static User findByUsernameAndPassword(String username, String passwordHash) throws Exception {
        Connection conn = DBUtil.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password_hash = ?");
        ps.setString(1, username);
        ps.setString(2, passwordHash);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new User(
                rs.getInt("id"),
                rs.getString("username"),
                rs.getString("email"),
                rs.getString("password_hash"),
                Role.valueOf(rs.getString("role")),
                rs.getString("full_name"),
                rs.getString("phone"),
                rs.getTimestamp("created_at")
            );
        }
        conn.close();
        return null;
    }

    public static boolean existsByUsernameOrEmail(String username, String email) throws Exception {
        Connection conn = DBUtil.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT 1 FROM users WHERE username = ? OR email = ?");
        ps.setString(1, username);
        ps.setString(2, email);
        ResultSet rs = ps.executeQuery();
        boolean exists = rs.next();
        conn.close();
        return exists;
    }

    public static void register(String username, String email, String passwordHash) throws Exception {
        Connection conn = DBUtil.getConnection();
        PreparedStatement ps = conn.prepareStatement("INSERT INTO users (username, email, password_hash, role) VALUES (?, ?, ?, 'USER')");
        ps.setString(1, username);
        ps.setString(2, email);
        ps.setString(3, passwordHash);
        ps.executeUpdate();
        conn.close();
    }
}