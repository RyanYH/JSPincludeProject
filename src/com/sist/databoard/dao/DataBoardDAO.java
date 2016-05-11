package com.sist.databoard.dao;
import java.util.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class DataBoardDAO {
	private Connection conn;
	private PreparedStatement ps;
	private static DataBoardDAO dao;
	// Ǯ�� �̸� Connection��ü ���� �Ŀ� ���
	// Connection��ü�� ������ ���� ������ �ִ�.
	// �̸� ���� �� ��� => ���ῡ �ҿ�Ǵ� �ð��� ���� �� �ִ�.
	// �̸� ������ ��ü �ּҸ� ���´�.
	// ==> ��ü�� ����Ǿ� �ִ� ��� ==> JNDI
	// �ּ� ==> lookup ==> RMI("����",��ü)
	// ==> lookup("jdbc/oracle")
    // DBCP ==> ���� (Connection)
	public void getConnection()
	{
	    try{
	    	Context init = new InitialContext();
	    	// JNDI �ʱ�ȭ(Ž���⸦ ����)
	    	Context c = (Context)init.lookup("java://comp/env");
	    	DataSource ds = (DataSource)c.lookup("jdbc/oracle");
	    	conn=ds.getConnection();
	    }catch(Exception ex)
	    {
	    	System.out.println(ex.getMessage());
	    }
	}
	public void disConnection()
	{
		try{
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}catch(Exception ex){
			
		}
	}
	public static DataBoardDAO newInstance()
	{
		if(dao==null)
			dao=new DataBoardDAO();
		return dao;
	}
	public List<DataBoardDTO> boardAllData(int page){
		List<DataBoardDTO> list =
				new ArrayList<DataBoardDTO>();
		try{
			getConnection();
			int rowSize=10;
			int start=(page*rowSize)-(rowSize-1);
			int end=(page*rowSize);
			String sql = "SELECT no,subject,name,regdate,hit,num "
					    +"FROM (SELECT no,subject,name,regdate,hit,rownum as num "
					    +"FROM (SELECT no,subject,name,regdate,hit "
					    +"FROM databoard ORDER BY no DESC)) "
					    +"WHERE num BETWEEN "+start+"AND "+end;
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				DataBoardDTO d = new DataBoardDTO();
				d.setNo(rs.getInt(1));
				d.setSubject(rs.getString(2));
				d.setName(rs.getString(3));
				d.setRegdate(rs.getDate(4));
				d.setHit(rs.getInt(5));
				list.add(d);
			}
			rs.close();
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}finally{
			disConnection();
		}
		return list;
	}
   public int boardTotal()
   {
	   int total=0;
	   try{
		   getConnection();
		   String sql = "SELECT CEIL(COUNT(*)/10) FROM databoard";
		   ps = conn.prepareStatement(sql);
		   ResultSet rs =ps.executeQuery();
		   rs.next();
		   total = rs.getInt(1);
		   rs.close();
	   }catch(Exception ex){
		   System.out.println(ex.getMessage());
	   }
	   finally{
		   disConnection();
	   }
	   return total;
	   
   }
   public void boardInsert(DataBoardDTO d)
   {
	   try{
		   getConnection();
            String sql ="INSERT INTO databoard VALUES("
            		   +"db_no_seq.nextval,?,?,?,?,SYSDATE,0,?,?)";
            ps=conn.prepareStatement(sql);
            ps.setString(1, d.getName());
            ps.setString(2, d.getSubject());
            ps.setString(3, d.getContent());
            ps.setString(4, d.getPwd());
            ps.setString(5, d.getFilename());
    		ps.setInt(6, d.getFilesize());
    		ps.executeUpdate();
    		ps.close();
	   }catch(Exception ex){
		   System.out.println(ex.getMessage());
	   }
	   finally{
		   disConnection();
	   }
   }
   //���뺸��
   /*
    *  �� ==> ����(X) db����
    *       �帧(������ �̵�)
    */
   public DataBoardDTO boardContentData(int no,int mode)
   {
   	DataBoardDTO d=new DataBoardDTO();
   	try
   	{
   		getConnection();
   		String sql="";
   		if(mode==1)
   		{
	    		sql="UPDATE databoard SET "
	    				  +"hit=hit+1 "
	    				  +"WHERE no=?";
	    		// ��ȸ�� ���� 
	    		ps=conn.prepareStatement(sql);
	    		ps.setInt(1, no);
	    		ps.executeUpdate();
	    		ps.close();
   		}
   		//�����͸� ������ �´� 
   		sql="SELECT no,name,subject,content,"
   		   +"regdate,hit,filename,filesize "
   		   +"FROM databoard "
   		   +"WHERE no=?";
   		ps=conn.prepareStatement(sql);
   		ps.setInt(1, no);
   		ResultSet rs=ps.executeQuery();
   		rs.next();
   		d.setNo(rs.getInt(1));
   		d.setName(rs.getString(2));
   		d.setSubject(rs.getString(3));
   		d.setContent(rs.getString(4));
   		d.setRegdate(rs.getDate(5));
   		d.setHit(rs.getInt(6));
   		d.setFilename(rs.getString(7));
   		d.setFilesize(rs.getInt(8));
   		rs.close();
   		
   	}catch(Exception ex)
   	{
   		System.out.println(ex.getMessage());
   	}
   	finally
   	{
   		disConnection();
   	}
   	return d;
   }
   public DataBoardDTO boardFileInfo(int no)
   {
	   DataBoardDTO d = new DataBoardDTO();
	   try{
		   getConnection();
		   String sql = "SELECT filename,filesize "
				        +"FROM databoard "
				        +"WHERE no=?";
		   ps = conn.prepareStatement(sql);
		   ps.setInt(1, no);
		   ps.executeUpdate();
		   ps.close();
		   // �����͸� ������ �´�.
		   sql = "SELECT no,name,subject,content,"
				 +"regdate,hit,filename,filesize "
				 +"FROM databoard "
				 +"WHERE no=?";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, no);
		   ResultSet rs = ps.executeQuery();
		   rs.next();
		   d.setFilename(rs.getString(1));
		   d.setFilesize(rs.getInt(2));
		   rs.close();
		   
	   }catch(Exception ex){
		   System.out.println(ex.getMessage());
	   }finally{
		   disConnection();
	   }
	   return d;   
   }
   // ����
   public boolean boardDelete(int no,String pwd)
   {
	   boolean bCheck=false;
	   try{
		   getConnection();
		   String sql="SELECT pwd FROM databoard "
				   +"WHERE no=?";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, no);
		   ResultSet rs = ps.executeQuery();
		   rs.next();
		   String db_pwd=rs.getString(1);
		   rs.close();
		   ps.close();
		   if(db_pwd.equals(pwd))
		   {
			   bCheck=true;   
		       sql = "DELETE FROM databoard "
		    		 +"WHERE no=?";
		       ps=conn.prepareStatement(sql);
		       ps.setInt(1, no);
		       ps.executeUpdate();
		   }
		   else
		   {
			   bCheck=false;
		   }
	   }catch(Exception ex){
		   System.out.println(ex.getMessage());
	   }finally{
		   disConnection();
	   }
	   return bCheck;
   }
   public boolean boardUpdate(DataBoardDTO d)
   {
	   boolean bCheck=false;
	   try{
		   getConnection();
		   String sql="SELECT pwd FROM databoard "
				   +"WHERE no=?";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, d.getNo());
		   ResultSet rs = ps.executeQuery();
		   rs.next();
		   String db_pwd=rs.getString(1);
		   rs.close();
		   ps.close();
		   if(db_pwd.equals(d.getPwd()))
		   {
			   bCheck=true;   
		       sql = "UPDATE databoard SET "
		    		 +"name=?,subject=?,content=? "
		    		 +"filename=?,filesize=? "
		    		 +"WHERE no=?";
		       ps=conn.prepareStatement(sql);
		       ps.setString(1, d.getName());
		       ps.setString(2, d.getSubject());
		       ps.setString(3, d.getContent());
		       ps.setString(4, d.getFilename());
		       ps.setInt(5, d.getFilesize());
		       ps.setInt(6, d.getNo());
		       ps.executeUpdate();
		   }
		   else
		   {
			   bCheck=false;
		   }
	   }catch(Exception ex){
		   System.out.println(ex.getMessage());
	   }finally{
		   disConnection();
	   }
	   return bCheck;
   }
}

