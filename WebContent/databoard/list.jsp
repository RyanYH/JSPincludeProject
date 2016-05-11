<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.databoard.dao.*,java.util.*"%>
<jsp:useBean id="dao" class="com.sist.databoard.dao.DataBoardDAO" scope="page"/>
<%--DataBoardDAO dao=new DataBoardDAO() --%>
<%
    String strPage=request.getParameter("page");
	if(strPage==null)
	{
		strPage="1";
	}
	int curpage=Integer.parseInt(strPage);
	List<DataBoardDTO> list = dao.boardAllData(curpage);
	int totalpage = dao.boardTotal();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../databoard/table.css">
</head>
<body>
  <center>
    <h1>자료실</h1>
    <table id="table_content">
      <tr>
       <td align=left>
      	<a href="main.jsp?mode=10">등록</a>
      </td>
      </tr> 
      <tr>
       <th width=10%>번호</th>
       <th width=45%>제목</th>
       <th width=15%>이름</th>
       <th width=20%>작성일</th>
       <th width=10%>조회수</th>
      </tr>
      <%
      	for(DataBoardDTO d:list)
      	{
      %>
         <tr id="dataTr">
           <td width=10% class="tdcenter"><%=d.getNo() %></td>
           <td width=45% class="tdleft">
           <a href="main.jsp?mode=11&no=<%=d.getNo()%>"><%=d.getSubject() %></a></td>
           <td width=15% class="tdcenter"><%=d.getName() %></td>
           <td width=20% class="tdcenter"><%=d.getRegdate().toString() %></td>
           <td width=10% class="tdcenter"><%=d.getHit() %></td>
         </tr>
      <%
      	}
      %>
    </table>
    <table border=0 width=600>
     <tr>
      <td align=right>
       <a href="main.jsp?mode=9&page=<%=curpage>1?curpage-1:curpage%>">
       <img src="../board/image/prev.gif"></a>&nbsp;
       <a href="main.jsp?mode=9&page=<%=curpage<totalpage?curpage+1:curpage%>">
       <img src="../board/image/next.gif"></a>&nbsp;&nbsp;
       <%=curpage %> page/<%=totalpage %> pages
      </td>
     </tr>
    </table>
  </center>
</body>
</html>