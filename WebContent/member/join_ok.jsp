<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.member.dao.*"%>
<%
    request.setCharacterEncoding("EUC-KR");
%>
<jsp:useBean id="dao" class="com.sist.member.dao.MemberDAO">
</jsp:useBean>
<jsp:useBean id="dto" class="com.sist.member.dao.MemberDTO">
  <jsp:setProperty name="dto" property="*"/>
</jsp:useBean>
<%
  dao.MemberJoin(dto);
  response.sendRedirect("../main/main.jsp?mode=8");
%>