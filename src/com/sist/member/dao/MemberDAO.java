package com.sist.member.dao;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.sql.*;// Database占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙 => DataSource

import com.sist.dao.BoardDTO;

import javax.naming.*;// Context
public class MemberDAO {
   private Connection conn;
   private PreparedStatement ps;
   private static MemberDAO dao;
   // 占싱뱄옙 占쏙옙占쏙옙占쏙옙 connection占쏙옙 풀占쏙옙占쏙옙 占쏙옙占승댐옙 
   String post;
   public void getConnection()
   {
	   try
	   {
		   Context init=new InitialContext();
		   Context c=(Context)init.lookup("java://comp/env");
		   DataSource ds=(DataSource)c.lookup("jdbc/oracle");
		   conn=ds.getConnection();
		   /*
		    *   ================
		    *    java://comp/env
		    *    =============
		    *     conn jdbc/oracle
		    *    =============
		    *   
		    *   ================
		    */
		   
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
   }
   // 占쏙옙占쏙옙커占� 占쏙옙환 (占쏙옙占쏙옙)
   public void disConnection()
   {
	   try
	   {
		   if(ps!=null) ps.close();
		   if(conn!=null) conn.close();
	   }catch(Exception ex){}
   }
   public static MemberDAO newInstance()
   {
	   if(dao==null)
		   dao=new MemberDAO();
	   return dao;
   }
   public String postOld()
   {
	   return post;
   }
   public List<ZipcodeDTO> postFind(int page,String dong)
   {
	   post=dong;
	   List<ZipcodeDTO> list=
			   new ArrayList<ZipcodeDTO>();
	   // DAO => NONPOOLED , DBCP => POOLED
	   // Transaction => JDBC , MANAGED
	   try
	   {
		   getConnection();// 占싱뱄옙 占쏙옙占쏙옙占쏙옙 Connection占쏙옙체 占쏙옙占�
		   // maxIdle => 10
		   String sql="SELECT zipcode,sido,gugun,dong,"
				     +"NVL(bunji,' ') "
				     +"FROM zipcode "
				     +"WHERE dong LIKE '%'||?||'%'";
		   ps=conn.prepareStatement(sql);
		   ps.setString(1, dong);
		   ResultSet rs=ps.executeQuery();
		   int i=0;
		   int j=0;
		   int pagecnt=(page*10)-10;
		   while(rs.next())
		   {
			   if(i<10 && j>=pagecnt)
			   {
			   ZipcodeDTO d=new ZipcodeDTO();
			   d.setZipcode(rs.getString(1));
			   d.setSido(rs.getString(2));
			   d.setGugun(rs.getString(3));
			   d.setDong(rs.getString(4));
			   d.setBunji(rs.getString(5));
			   list.add(d);
		       i++;
			   }
			   j++;
		  }
		   rs.close();
		   
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   finally
	   {
		   // 占쏙옙환 
		   disConnection();
	   }
	   return list;
   }
   public int postFindCount(String dong)
   {
	   int count=0;
	   // DAO => NONPOOLED , DBCP => POOLED
	   // Transaction => JDBC , MANAGED
	   try
	   {
		   getConnection();// 占싱뱄옙 占쏙옙占쏙옙占쏙옙 Connection占쏙옙체 占쏙옙占�
		   // maxIdle => 10
		   String sql="SELECT CEIL(COUNT(*)/10) "
				     +"FROM zipcode "
				     +"WHERE dong LIKE '%'||?||'%'";
		   ps=conn.prepareStatement(sql);
		   ps.setString(1, dong);
		   ResultSet rs=ps.executeQuery();
		   rs.next();
		   count=rs.getInt(1);
		   rs.close();
		   
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   finally
	   {
		   // 占쏙옙환 
		   disConnection();
	   }
	   return count;
   }
   //Login
   public String isLogin(String id,String pwd)
   {
	   String result="";
	   try{
		   getConnection();
		   String sql="SELECT COUNT(*) FROM member "
				     +"WHERE id=?";
		   ps=conn.prepareStatement(sql);
		   ps.setString(1, id);
		   ResultSet rs= ps.executeQuery();
		   rs.next();
		   int count=rs.getInt(1);
		   rs.close();
		   ps.close();
		   if(count==0){
			result="NOID";   
		   }else{
			   sql="SELECT pwd,name FROM member "
					   +"WHERE id=?";
		        ps=conn.prepareStatement(sql);
		        ps.setString(1, id);
		        rs=ps.executeQuery();
		        rs.next();
		        String db_pwd=rs.getString(1);
		        String db_name=rs.getString(2);
		        rs.close();
		        ps.close();
		        if(pwd.equals(db_pwd)){
		        	//Login
		        	result=db_name;
		        	sql="UPDATE member SET "
		        			+"logcount=logcount+1 "
		        			+"WHERE id=?";
		        	ps=conn.prepareStatement(sql);
		        	ps.setString(1, id);
		        	ps.executeUpdate();
		        }
		        else{
		        	//pwd媛� �ㅻⅤ��.
		        	result="NOPWD";
		        }   
		   }
	   }catch(Exception ex){
		   
	   }finally{
		   disConnection();
	   }
	   return result;
   }
   // ID 以�蹂듭껜��
   public int idCheck(String id)
   {
	   int count=0;
	   try{
		   getConnection();
		   String sql="SELECT COUNT(*) FROM member "
				   +"WHERE id=?";
		   ps=conn.prepareStatement(sql);
		   ps.setString(1, id);
		   ResultSet rs=ps.executeQuery();
		   rs.next();
		   count=rs.getInt(1);
		   rs.close();
	   }catch(Exception ex){
		   System.out.println(ex.getMessage());
	   }finally{
		   disConnection();
	   }
	   return count;
   }
   /*
    * INSERT INTO member VALUES('hong','1234','��湲몃��','�⑥��','2000-10-12','010-1111-1111'
                                ,'000-000','���몄�� 留��ш뎄 諛깅�濡�','','������源� 泥�異��대��.',SYSDATE);
    */
   public void MemberJoin(MemberDTO d){
	   try{
		   getConnection();
		   String sql="INSERT INTO member VALUES("
				      +"?,?,?,?,?,?,?,?,?,?,SYSDATE)";
		   ps=conn.prepareStatement(sql);
		   ps.setString(1, d.getId());
		   ps.setString(2, d.getPwd());
		   ps.setString(3, d.getName());
		   ps.setString(4, d.getSex());
		   ps.setString(5, d.getBirth());
/*		   ps.setString(6, d.getEmail());*/
		   ps.setString(6, d.getTel());
		   ps.setString(7, d.getPost());
		   ps.setString(8, d.getAddr1());
		   ps.setString(9, d.getAddr2());
		   ps.setString(10, d.getContent());
           ps.executeUpdate();
	   }catch(Exception ex){
		   System.out.println(ex.getMessage());
	   }finally{
		   disConnection();
	   }
   }
   //C:\webDev\webStudy2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPincludeProject\main
  public void saveFile()
  {
	  try{
		  String path="C:\\webDev\\webStudy2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\JSPincludeProject\\main\\log.csv";
	      File file=new File(path);
	       if(!file.exists())
	       {
	    	   file.createNewFile();
	       }
	       String data="name,count\n";
	       getConnection();
	       String sql="SELECT name,logcount FROM member";
	       ps=conn.prepareStatement(sql);
	       ResultSet rs = ps.executeQuery();
	       while(rs.next())
	       {
	    	   data+=rs.getString(1)+","+rs.getInt(2)+"\n";
	       }
	       rs.close();
	       FileWriter fw = new FileWriter(file);
	       fw.write(data);
	       fw.close();
	       FileInputStream fis=
	    		   new FileInputStream(file);
	       int i=0;
	       byte[] buffer=new byte[1024];
	       String str="C:\\webDev\\webStudy2\\JSPincludeProject\\WebContent\\main\\log.csv";
	       FileOutputStream fos= new FileOutputStream(str);
	       while((i=fis.read(buffer,0,1024))!=-1)
	       {
	    	   fos.write(buffer,0,i);
	       }
	       fis.close();
	       fos.close();
	  }catch(Exception ex){
		  System.out.println(ex.getMessage());
	  }finally{
		  disConnection();
	  }
  }
  /*
   * ID
	 PWD
	 NAME
	 SEX
	 BIRTH
	 PHONE
	 POST
	 ADDR1
	 ADDR2
	 CONTENT
	 REGDATE
	 LOGCOUNT
   */
  public MemberDTO MemberUpdateData(String id)
  {
	   MemberDTO d=new MemberDTO();
	   try
	   {
		   getConnection();		  
		   String sql="SELECT id,name,sex,birth,post,addr1,addr2,content "
			  +"FROM member "
			  +"WHERE id=?";
		   ps=conn.prepareStatement(sql);
		   ps.setString(1, id);
		   ResultSet rs=ps.executeQuery();
		   rs.next();
		   
		   d.setId(rs.getString(1));
		   d.setName(rs.getString(2));
		   d.setSex(rs.getString(3));
		   d.setBirth(rs.getString(4));
		   d.setPost(rs.getString(5));
		   d.setAddr1(rs.getString(6));
		   d.setAddr2(rs.getString(7));
		   d.setContent(rs.getString(8));		   
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
}








