<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="com.sist.dao.*"%>
	
<%
	String strNo = request.getParameter("no");
	String strPage = request.getParameter("page");
	BoardDAO dao = BoardDAO.newInstance();
	BoardDTO d = dao.boardContentData(Integer.parseInt(strNo));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="board.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.7.js"></script>
<script type="text/javascript"> 
var i = 0;
/*
      tag=>DOM(Document Object Model)
      $(SELECTOR)=>tag명('tr') ,id명('#id') ,class명('.class명')
      input, select => val(), val("")
      td,th,a => text(),text("")
      <td>aa</td> $('td').text() : 텍스트 문자열을 읽어옴
      <td><a>aaa</a></td> $('td').text() => aaa
                          $('td').html() => <a>aaa</a> 
                          
      <a href="aaa"> $('a').attr("href") => aaa
                     $('a').attr("href","설정값")
      document.getElementById("del"); => $('#del')
      img.src="";  ====> attr("src","값")
 */
$(function(){
	$('#del').click(function(){
		if(i==0)
		{
			$('#delTr').show();
			$('#del').attr("src","../board/image/btn_cancel.gif");
			i=1;
		}
		else
	    {
			$('#delTr').hide();
			$('#del').attr("src","../board/image/btn_delete.gif");
			i=0;
	    }
	});
$('#delBtn').click(function(){
	/* var pwd=$('input[type="password"]').val(); */
	var pwd=$('#pwd').val();
	if(pwd.trim()=="")
	{
		$('#pwd').show();
		$('#pwd').focus();
		return;
	}
	$('#delFrm').submit();
});	
});
</script>
</head>
<body>
	<center>
		<img src="../board/image/qna.jpg" width=700 height=100>
		<p>
		<table border=1 bordercolor="#ccccff" width=700 cellpadding="0"
			cellspacing="0">
			<tr height=27>
				<td width=20% align=center bgcolor="#ccccff">번호</td>
				<td width=30% align=center><%=d.getNo()%></td>
				<td width=20% align=center bgcolor="#ccccff">작성일</td>
				<td width=30% align=center><%=d.getStrDay()%></td>
			</tr>
			<tr height=27>
				<td width=20% align=center bgcolor="#ccccff">이름</td>
				<td width=30% align=center><%=d.getName()%></td>
				<td width=20% align=center bgcolor="#ccccff">조회수</td>
				<td width=30% align=center><%=d.getHit()%></td>
			</tr>
			<tr height=27>
				<td width=20% align=center bgcolor="#ccccff">제목</td>
				<td colspan="3" align=left><%=d.getSubject()%></td>
			</tr>
			<tr>
				<td colspan="4" align=left valign="top" height=200><pre><%=d.getContent()%></pre>
				</td>
			</tr>
		</table>
		<table border=0 width=700>
			<tr>
				<td align=right><a
					href="../main/main.jsp?mode=6&no=<%=strNo%>&page=<%=strPage%>"> <img
						src="../board/image/btn_reply.gif"></a> <a
					href="../main/main.jsp?mode=5&no=<%=strNo%>&page=<%=strPage%>"> <img
						src="../board/image/btn_modify.gif"></a> <img src="../board/image/btn_delete.gif"
					id="del"> <a href="../main/main.jsp?mode=2&page=<%=strPage%>"> <img
						src="../board/image/btn_list.gif" border=0></a></td>
			</tr>
			<tr style="display: none" id="delTr">
				<td align=right>
					<form method=post action="../board/delete.jsp" id="delFrm">
						비밀번호 : <input type="password" name=pwd size=10 id="pwd">
						       <input type="hidden" name=no value="<%=strNo%>">
						       <input type="hidden" name=page value="<%=strPage%>"> 
						<input type=button value=삭제 id="delBtn">
					</form>
				</td>
			</tr>
		</table>
	</center>
</body>
</html>





