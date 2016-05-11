<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.member.dao.*"%>
<%
   String id = request.getParameter("id");
   String pwd = request.getParameter("pwd");
   MemberDAO dao = new MemberDAO();
   String result = dao.isLogin(id, pwd);
   if(result.equals("NOID"))
   {
%>
     <script>
      alert("ID가 존재하지 않습니다.");
      history.back();
     </script>
<%	   
	   
   }
   else if(result.equals("NOPWD"))
   {
	   %>
	     <script>
	      alert("비밀번호가 ㅇㅇ");
	      history.back();
	     </script>
	<%	   
   }
   else
   {
	   	dao.saveFile();
	   session.setAttribute("id", id);
	   session.setAttribute("name", result);
	   response.sendRedirect("../main/main.jsp");
   }
%>