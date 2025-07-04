package com.example.todo.model;

import com.example.todo.model.enums.Role;
import java.sql.Timestamp;

public class User {
	private int id;
	private String username;
	private String email;
	private String passwordHash;
	private Role role;
	private String fullName;  
	private String phone;    
	private Timestamp createdAt;

	public User() {
	}

	public User(int id, String username, String email, String passwordHash, Role role, String fullName, String phone, Timestamp createdAt) {
		this.id = id;
		this.username = username;
		this.email = email;
		this.passwordHash = passwordHash;
		this.role = role;
		this.fullName = fullName;
		this.phone = phone;
		this.createdAt = createdAt;
	}

	public User(int id, String username, String email) {
		this.id = id;
		this.username = username;
		this.email = email;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}

	public Role getRole() {
		return role;
	}
	public String getFullName() { return fullName; }
	public void setFullName(String fullName) { this.fullName = fullName; }

	public String getPhone() { return phone; }
	public void setPhone(String phone) { this.phone = phone; }
	
	public void setRole(Role role) {
		this.role = role;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public boolean isAdmin() {
		return Role.ADMIN.equals(role);
	}
}
