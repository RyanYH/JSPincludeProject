<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.databoard.dao.*,java.io.*"%>
<<jsp:useBean id="dao" class="com.sist.databoard.dao.DataBoardDAO"/>
<%
   String pwd=request.getParameter("pwd");
   String no=request.getParameter("no");
   DataBoardDTO d = dao.boardFileInfo(Integer.parseInt(no));
   // DB삭제
   boolean bCheck=dao.boardDelete(Integer.parseInt(no), pwd);
   // 이동
   if(bCheck==true)
   {   
	   try{
		 if(d.getFilesize()>0)
		 {
			 File file = new File("c:\\download\\"+d.getFilename());
			 file.delete();
		 }
	   }catch(Exception ex){		   
	   }
   	   response.sendRedirect("../main/main.jsp?mode=9");
   }
   else
   {
	   %>
	    <script>
	     alert("비밀번호가 틀립니다.");
	     history.back();
	    </script>
	   <%		   
   }
%>
