package com.sist.exercise;

import java.sql.Connection;
import java.sql.DriverManager;

public class MyDataSource {
	private String driverClassName;
	private String url;
	private String username;
	private String password;
	private int maxActive;
	private int maxIdle;
	private int maxWait; //-1(¹«ÇÑÁ¤)
	public String getDriverClassName() {
		return driverClassName;
	}
	public void setDriverClassName(String driverClassName) {
		this.driverClassName = driverClassName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getMaxActive() {
		return maxActive;
	}
	public void setMaxActive(int maxActive) {
		this.maxActive = maxActive;
	}
	public int getMaxIdle() {
		return maxIdle;
	}
	public void setMaxIdle(int maxIdle) {
		this.maxIdle = maxIdle;
	}
	public int getMaxWait() {
		return maxWait;
	}
	public void setMaxWait(int maxWait) {
		this.maxWait = maxWait;
	}
	public void driverLoading()
	{ 
		try{
           Class.forName(driverClassName);			
		}catch(Exception ex){
			
		}
	}
	public Connection getConnection()
	{
		Connection conn=null;
		try{
			conn=DriverManager.getConnection(url,username,password);
		}catch(Exception ex){
			
		}
		return conn;
	}
}
