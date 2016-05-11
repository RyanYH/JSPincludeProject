<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
  session.invalidate(); // 세션해지
  response.sendRedirect("../main/main.jsp");
%>