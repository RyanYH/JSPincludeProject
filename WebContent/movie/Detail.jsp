<%@page import="com.sist.member.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.movie.data.*"%>
<%@ page import="java.util.*" %>
<%
   String no = request.getParameter("no");
   MoiveDataManager md = new MoiveDataManager();
   List<MoiveDTO> list = md.moiveAllData();
   MoiveDTO d = new MoiveDTO();
   for(MoiveDTO dd:list)
   {
	   if(dd.getNo()==Integer.parseInt(no))
	   {
		   d=dd;
		   break;
	   }
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link href="../databoard/table.css" rel="stylesheet">
</head>
<body>
	<center>
	  <h3><%=d.getTitle()%> 상세보기</h3>
	  <table id="table_content">
	   <tr>
	    <td width=30% align=center rowspan="5">
	     <img src="<%=d.getImage() %>">
	    </td>
	    <td colspan="2" align=center><%=d.getTitle() %></td>
	   </tr>
	   <tr>
	    <td width=20% align=center>예매율</td>
	    <td width=50% align=center><%=d.getPercent() %></td>
	   </tr>
	   <tr>
	    <td width=20% align=center>별점</td>
	    <td width=50% align=center><%=d.getReserve() %></td>
	   </tr>
	   <tr>
	    <td width=20% align=center>개봉일</td>
	    <td width=50% align=center><%=d.getRegdate() %></td>
	   </tr>
	   <tr>
	    <td width=20% align=center>LIKE</td>
	    <td width=50% align=center><%=d.getLike() %></td>
	   </tr>
	  </table>
	  <p>
	   <img src="../image/feel.png">
	  </p>
	</center>
</body>
</html>