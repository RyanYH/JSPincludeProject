package com.sist.exercise;

import java.sql.*;

public class MyDAO {
	private Connection conn;
	private PreparedStatement ps;
	public void getConnection()
	{
	  try{
		  Context c = new Context();
		  MyDataSource ms = (MyDataSource)c.lookup("jdbc/Oracle");
		  ms.driverLoading();
		  conn = ms.getConnection();
	  }catch(Exception ex){}
	}
	public void deptAllData()
	{
		try{
			getConnection();
			String sql = "SELECT * FROM dept";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				System.out.println(rs.getInt(1)+" "+rs.getString(2)+" "+rs.getString(3));
			}
			rs.close();
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}
	}
}
