<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.dao.*"%>
    
<%
    String pwd=request.getParameter("pwd");
    String no = request.getParameter("no");
    String strPage = request.getParameter("page");
    
     //DB연동
     BoardDAO dao=BoardDAO.newInstance();
     boolean bCheck=dao.boardDelete(Integer.parseInt(no), pwd);
     if(bCheck==true){
    	 response.sendRedirect("../main/main.jsp?mode=2&page="+strPage);
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