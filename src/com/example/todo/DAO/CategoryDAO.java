// CategoryDAO.java
package com.example.todo.DAO;

import com.example.todo.model.Category;
import com.example.todo.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public static List<Category> getAll() throws Exception {
        List<Category> list = new ArrayList<>();
        Connection conn = DBUtil.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM categories ORDER BY name ASC");

        while (rs.next()) {
            list.add(new Category(rs.getInt("id"), rs.getString("name")));
        }
        conn.close();
        return list;
    }

    public static int findIdByName(String name) throws Exception {
        Connection conn = DBUtil.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT id FROM categories WHERE name = ?");
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("id");
        }
        conn.close();
        return -1;
    }

    public static void insert(String name) throws Exception {
        Connection conn = DBUtil.getConnection();
        PreparedStatement ps = conn.prepareStatement("INSERT INTO categories(name) VALUES(?)");
        ps.setString(1, name);
        ps.executeUpdate();
        conn.close();
    }

    public static void delete(int id) throws Exception {
        Connection conn = DBUtil.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM categories WHERE id = ?");
        ps.setInt(1, id);
        ps.executeUpdate();
        conn.close();
    }
}