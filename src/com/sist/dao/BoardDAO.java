package com.sist.dao;
// 이전  다음     < << [1][2][3][4][5] >> > <% %>
import java.sql.*;
import java.util.*;

import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;
public class BoardDAO {
   private Connection conn;
   private PreparedStatement ps;
   private final String URL="jdbc:oracle:thin:@211.238.142.25:1521:ORCL";
   private static BoardDAO dao;
   // Driver 등록
   public BoardDAO()
   {
	   try
	   {
		   Class.forName("oracle.jdbc.driver.OracleDriver");
		   // ==> DriverManager
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   // (+) DB2
   }
   // 연결
   public void getConnection()
   {
	   try
	   {
		   conn=DriverManager.getConnection(URL,"scott","tiger");
	   }catch(Exception ex){}
   }
   // 연결 해제
   public void disConnection()
   {
	   try
	   {
		   if(ps!=null) ps.close();
		   if(conn!=null) conn.close();
	   }catch(Exception ex){}
   }
   // 싱글턴 
   public static BoardDAO newInstance()
   {
	   if(dao==null)
		   dao=new BoardDAO();
	   return dao;
   }
   // 기능...
   // 1. 목록 
   public List<BoardDTO> boardListData(int page)
   {
	   List<BoardDTO> list=new ArrayList<BoardDTO>();
	   try
	   {
		   // 연결
		   getConnection();
		   int rowSize=10;
		   int start=(rowSize*page)-(rowSize-1);
		   int end=rowSize*page;
		   // 1~10 , 11~20
		   String sql="SELECT no,subject,name,regdate,hit,group_tab,num "
				     +"FROM (SELECT no,subject,name,regdate,hit,group_tab,rownum as num "
				     +"FROM (SELECT no,subject,name,regdate,hit,group_tab "
				     +"FROM board ORDER BY group_id DESC,group_step ASC))"
				     +"WHERE num BETWEEN "+start+" AND "+end;
		   ps=conn.prepareStatement(sql);
		   ResultSet rs=ps.executeQuery();
		   while(rs.next())
		   {
			   BoardDTO d=new BoardDTO();
			   d.setNo(rs.getInt(1));
			   d.setSubject(rs.getString(2));
			   d.setName(rs.getString(3));
			   d.setRegdate(rs.getDate(4));
			   d.setHit(rs.getInt(5));
			   d.setGroup_tab(rs.getInt(6));
			   list.add(d);
		   }
		   rs.close();
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   finally
	   {
		   disConnection();
	   }
	   return list;
   }
   // 총페이지
   public int boardTotal()
   {
	   int total=0;
	   try
	   {
		   getConnection();
		   String sql="SELECT CEIL(COUNT(*)/10) FROM board";
		   ps=conn.prepareStatement(sql);
		   ResultSet rs=ps.executeQuery();
		   rs.next();
		   total=rs.getInt(1);
		   rs.close();
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   finally
	   {
		   disConnection();
	   }
	   return total;
   }
   // 총갯수(번호)
   public int boardCount()
   {
	   int total=0;
	   try
	   {
		   getConnection();
		   String sql="SELECT COUNT(*) FROM board";
		   ps=conn.prepareStatement(sql);
		   ResultSet rs=ps.executeQuery();
		   rs.next();
		   total=rs.getInt(1);
		   rs.close();
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   finally
	   {
		   disConnection();
	   }
	   return total;
   }
   // 내용보기
   public BoardDTO boardContentData(int no)
   {
	   BoardDTO d=new BoardDTO();
	   try
	   {
		   getConnection();
		   String sql="UPDATE board SET "
				     +"hit=hit+1 "
				     +"WHERE no=?";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, no);
		   ps.executeUpdate();
		   ps.close();
		   
		   sql="SELECT no,name,subject,content,hit,TO_CHAR(regdate,'YYYY-MM-DD (HH24\"시\" MI\"분\" SS\"초\")') "
			  +"FROM board "
			  +"WHERE no=?";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, no);
		   ResultSet rs=ps.executeQuery();
		   rs.next();
		   d.setNo(rs.getInt(1));
		   d.setName(rs.getString(2));
		   d.setSubject(rs.getString(3));
		   d.setContent(rs.getString(4));
		   d.setHit(rs.getInt(5));
		   d.setStrDay(rs.getString(6));
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
   // 데이터 추가
   public void boardInsert(BoardDTO d)
   {
	   try
	   {
		   // 연결
		   getConnection();
		   String sql="INSERT INTO board(no,name,subject,content,pwd,group_id) "
				     +"VALUES((SELECT NVL(MAX(no)+1,1) FROM board),"
				     +"?,?,?,?,"
				     +"(SELECT NVL(MAX(group_id)+1,1) FROM board))";
		   ps=conn.prepareStatement(sql);
		   ps.setString(1, d.getName());
		   ps.setString(2, d.getSubject());
		   ps.setString(3, d.getContent());
		   ps.setString(4, d.getPwd());
		   ps.executeUpdate();
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   finally
	   {
		   disConnection();
	   }
   }
   /*
    *   INSERT INTO board(no,name,subject,content,pwd,group_id,group_step,group_tab,root,depth)
         VALUES((SELECT NVL(MAX(no)+1,1) FROM board),'홍길동',
         '답변형 게시판 제작','답변형 게시판...','1234',
         26,1,1,26,1);
         
         ==> SELECT gi,gs,gt FROM board => pno
         ==> UPDATE 
         AAAA
          ->DDDD 1
          ->BBBB 2
            ->CCCC 3
          
    */
   public void boardReply(int pno,BoardDTO d)
   {
	   try
	   {
		   getConnection();
		   String sql="SELECT group_id,group_step,group_tab "
				     +"FROM board "
				     +"WHERE no=?";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, pno);
		   ResultSet rs=ps.executeQuery();
		   rs.next();
		   int gi=rs.getInt(1);
		   int gs=rs.getInt(2);
		   int gt=rs.getInt(3);
		   rs.close();
		   ps.close();
		   System.out.println(1);
		   // UPDATE(group_step)
		   sql="UPDATE board set "
			  +"group_step=group_step+1 "
			  +"WHERE group_id=? AND group_step>?";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, gi);
		   ps.setInt(2, gs);
		   ps.executeUpdate();
		   ps.close();
		   System.out.println(2);
		   // UPDATE(depth)
		   sql="UPDATE board SET "
			  +"depth=depth+1 "
			  +"WHERE no=?";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, pno);
		   ps.executeUpdate();
		   ps.close();
		   System.out.println(3);
		   // INSERT
		   sql="INSERT INTO board(no,name,subject,content,pwd,group_id,group_step,group_tab,root) "
		      +"VALUES((SELECT NVL(MAX(no)+1,1) FROM board),"
			  +"?,?,?,?,?,?,?,?)";
		   ps=conn.prepareStatement(sql);
		   ps.setString(1, d.getName());
		   ps.setString(2, d.getSubject());
		   ps.setString(3, d.getContent());
		   ps.setString(4, d.getPwd());
		   ps.setInt(5,gi);
		   ps.setInt(6, gs+1);
		   ps.setInt(7, gt+1);
		   ps.setInt(8, pno);
		   ps.executeUpdate();
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   finally
	   {
		   disConnection();
	   }
   }
   // 업데이트
   public BoardDTO boardUpdateData(int no)
   {
	   BoardDTO d=new BoardDTO();
	   try
	   {
		   getConnection();
		  
		   String sql="SELECT name,subject,content "
			  +"FROM board "
			  +"WHERE no=?";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, no);
		   ResultSet rs=ps.executeQuery();
		   rs.next();
		   
		   d.setName(rs.getString(1));
		   d.setSubject(rs.getString(2));
		   d.setContent(rs.getString(3));
		   
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
   public boolean boardUpdate(BoardDTO d)
   {
	   boolean bCheck=false;
	   try
	   {
		   getConnection();
		   String sql="SELECT pwd FROM board "
				     +"WHERE no=?";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, d.getNo());
		   ResultSet rs=ps.executeQuery();
		   rs.next();
		   String pwd=rs.getString(1);
		   rs.close();
		   ps.close();
		   if(pwd.equals(d.getPwd()))
		   {
			   bCheck=true;
			   sql="UPDATE board SET "
				  +"name=?,subject=?,"
				  +"content=? "
				  +"WHERE no=?";
			   ps=conn.prepareStatement(sql);
			   ps.setString(1, d.getName());
			   ps.setString(2, d.getSubject());
			   ps.setString(3, d.getContent());
			   ps.setInt(4, d.getNo());
			   ps.executeUpdate();
		   }
		   else
		   {
			   bCheck=false;
		   }
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   finally
	   {
		   disConnection();
	   }
	   return bCheck;
   }
   
   public List<BoardDTO> boardSearchData(int page, String col, String data)
   {
	   List<BoardDTO> list=new ArrayList<BoardDTO>();
	   try
	   {
		   // 연결
		   getConnection();
		   int rowSize=10;
		   int start=(rowSize*page)-(rowSize-1);
		   int end=rowSize*page;
		   // 1~10 , 11~20
/*		   String sql="SELECT no,subject,name,regdate,hit,group_tab,num,content "
				     +"FROM (SELECT no,subject,name,regdate,hit,group_tab,rownum AS num "
				     +"FROM (SELECT no,subject,name,regdate,hit,group_tab "
				     +"FROM board ORDER BY group_id DESC,group_step ASC))"
				     +"WHERE num BETWEEN "+start+"AND "+end+" AND "+col+" LIKE '%"+data+"%'";*/
		   String sql = "SELECT no, subject, name, regdate, hit, group_tab, content, num "
	               + "FROM (SELECT no, subject, name, regdate, hit, group_tab, content, rownum AS num "
	               + "FROM (SELECT no, subject, name, regdate, hit, group_tab, content FROM board "
	               + " where " + col +  " like '%" + data + "%' ORDER BY group_id DESC, group_step ASC)) "
	               + "WHERE num BETWEEN "+start+" AND "+end;
		   
/*		   String sql = "SELECT no,subject,name,regdate,hit,group_tab from board where " 
				     + col+ " like '%" + data+ "%'";*/

		   ps=conn.prepareStatement(sql);
		   ResultSet rs=ps.executeQuery();
		   while(rs.next())
		   {
			   BoardDTO d=new BoardDTO();
			   d.setNo(rs.getInt(1));
			   d.setSubject(rs.getString(2));
			   d.setName(rs.getString(3));
			   d.setRegdate(rs.getDate(4));
			   d.setHit(rs.getInt(5));
			   d.setGroup_tab(rs.getInt(6));
			   list.add(d);
		   }
		   rs.close();
		   System.out.println(col+","+data);
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   finally
	   {
		   disConnection();
	   }
	   return list;
   }
   
   public int boardTotalpage(){
	   int total=0;
	   
	   try{
		   getConnection();
		   String sql="SELECT CEIL(COUNT(*)/10) "
				    +"FROM board";
		   ps=conn.prepareStatement(sql);
		   ResultSet rs = ps.executeQuery();
		   rs.next();
		   total=rs.getInt(1);
		   rs.close();
	   }catch(Exception ex){
		   System.out.println(ex.getMessage());
	   }finally{
		   disConnection();
	   }
	   return total;
   }
   public int boardSearchPage(String col, String data)
   {
	   int boardCount=0;
	   try{
		   getConnection();
		   String sql="SELECT ceil(COUNT(*)/10) "
				   +"FROM board "
				   +"WHERE "+col+" LIKE '%"+data+"%'";
		   ps=conn.prepareStatement(sql);
		   ResultSet rs=ps.executeQuery();
		   rs.next();
		   boardCount=rs.getInt(1);
		   rs.close();
	   }catch(Exception ex){
		   System.out.println(ex.getMessage());
	   }finally{
		   disConnection();
	   }
	   return boardCount;
   }
   public boolean boardDelete(int no,String pwd)
   {
	   boolean bCheck=false;
	   try{
		   getConnection();
		   // 비밀번호 
		   String sql="SELECT pwd FROM board "
				   +"WHERE no=?";
		   ps = conn.prepareStatement(sql);
		   ps.setInt(1, no);
		   ResultSet rs = ps.executeQuery();
		   rs.next();
		   String db_pwd=rs.getString(1);
		   rs.close();
		   ps.close();
		   if(pwd.equals(db_pwd)){
			   bCheck=true;
			   sql="SELECT depth,root FROM board "
				  +"WHERE no=?";
			   ps=conn.prepareStatement(sql);
			   ps.setInt(1, no);
			   rs=ps.executeQuery();
			   rs.next();
			   int depth=rs.getInt(1);
			   int root=rs.getInt(2);
			   rs.close();
			   ps.close();
			   
			   if(depth==0){
				   sql="DELETE FROM board "
					  +"WHERE no=?";
				   ps=conn.prepareStatement(sql);
				   ps.setInt(1, no);
				   ps.executeUpdate();
				   ps.close();
			   }else{
				   sql="UPDATE board SET "
					  +"subject=?,content=? "
					  +"WHERE no=?";
				   String msg="관리자가 삭제한 게시글 입니다.";
				   ps=conn.prepareStatement(sql);
				   ps.setString(1, msg);
				   ps.setString(2, msg);
				   ps.setInt(3, no);
				   ps.executeUpdate();
				   ps.close();
			   }
			   sql="UPDATE board SET "
				   +"depth=depth-1 "
				   +"WHERE no=?";
			   ps=conn.prepareStatement(sql);
			   ps.setInt(1, root);
			   ps.executeUpdate();
			   ps.close();
		   }else{
			   bCheck=false;
			   
		   }
		   // depth==0(delete), >0(update)
		   // root에 depth감소
	   }catch(Exception ex){
		   System.out.println(ex.getMessage());
	   }finally{
		   disConnection();
	   }
	   return bCheck;
   }
   
}





