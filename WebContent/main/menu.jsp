<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
    String id=(String)session.getAttribute("id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
  <center>
    <table border=0 width=200 style="margin-top: 70px">
      <tr height=30>
       <td align=left><a href="main.jsp">Ȩ</a></td>
      </tr>
      <tr height=30>
       <td align=left>
       <% 
          if(id==null)
          {
       %>
       <a href="main.jsp?mode=1">ȸ������</a>
       <%
          }
          else
          {
       %>
       <a href="main.jsp?mode=12">ȸ������</a>  
       <%
          }
       %>
       </td>
      </tr>
      <%
        if(id!=null)
        {
      %>
      <tr height=30>
       <td align=left><a href="main.jsp?mode=2">�����Խ���</a></td>
      </tr>
      <tr height=30>
       <td align=left><a href="main.jsp?mode=9">�ڷ��</a></td>
      </tr>
      <tr height=30>
       <td align=left><a href="main.jsp?mode=14">��ȭ����</a></td>
      </tr>
      <%
        }
      %>
    </table>
  </center>
</body>
</html>


