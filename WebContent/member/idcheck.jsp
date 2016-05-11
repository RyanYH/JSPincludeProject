<%@page import="java.lang.reflect.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="com.sist.member.dao.*"%>
<%
	String id = request.getParameter("id");
    MemberDAO dao=new MemberDAO();
    int count=dao.idCheck(id);
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
	function idcheck() {
		var f = document.idfrm; //$('#idfrm')
		if (f.id.value == "") {
			alert("ID를 입력하세요.");
			f.id.focus();
			return;
		}
		f.submit();
	}
	function ok(){
		opener.frm.id.value=document.idfrm.id.value;
		self.close();
	}
</script>
</head>
<body>
	<center>
		<h3>ID 중복체크</h3>
		<form name=idfrm method=post action="idcheck.jsp">
			ID:<input type=text name=id size=10 id="id"
				value="<%=id == null ? "" : id%>"> <input type=button
				value=체크 onclick="idcheck()">
		</form>
		<br>
		<table border=0 width=200>
			<tr>
				<td align=center>
					<%
				   if(count==0&&id!=null)
				   {
			    %> <font color=blue> <%=id %>는(은)<br> 사용가능한 ID입니다.
				</font> <% 		    
				   }
				   else if(count>0 && id!=null)
				   {
				%> <font color=red> <%=id %>는(은) <br>이미 사용 중인 ID입니다.
				</font> <script type="text/javascript">
					document.idfrm.id.value = "";
					document.idrm.id.focus();
				</script> <%	   
				   }
				 %>
				</td>
			</tr>
			<%
				   if(count==0&&id!=null)
				   {
			%>
			         <tr>
			          <td align="center">
			            <input type=button value=확인 onclick="ok()">
			          </td>
			         </tr>
			<%
				   }
			%>
		</table>
	</center>
</body>
</html>