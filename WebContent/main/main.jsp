<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.jsp.change.*"%>
<%
   //../main/main.jsp?mode=1
   String id=(String)session.getAttribute("id");
   String log_jsp="";
   if(id==null)
	   log_jsp="../member/login.jsp";
   else
	   log_jsp="../member/logout.jsp";
   String req_jsp="";
   String mode=request.getParameter("mode");
   
   //main.jsp?mode=1
   if(mode==null)
	   mode="0";
   req_jsp=JspChange.jspChange(Integer.parseInt(mode));
   
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
  td{
   font-family: 맑은 고딕;
   font-size : 9pt;
  }
</style>
</head>
<body>
   <center>
     <table border=1 bordercolor="black" width=900 height=700 cellspacing="0" cellpadding="0">
      <tr>
       <td width="100%" height=100 colspan="2">
      
       </td>
      </tr>
       <tr>
       <td width="200" height=500 valign="top" align="center">
         <jsp:include page="<%=log_jsp %>"></jsp:include>
         <jsp:include page="menu.jsp"></jsp:include>
       </td>
       <td width="700" height=500 align="center" style="margin-top: 15px">
         <jsp:include page="<%=req_jsp %>"></jsp:include>
       </td>
      </tr>
     
     </table>
   </center>
</body>
</html>