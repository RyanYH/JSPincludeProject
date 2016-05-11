<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.databoard.dao.*"%>
<jsp:useBean id="dao" class="com.sist.databoard.dao.DataBoardDAO"/>
<%
    // main.jsp?mode=8&no=10 
    // main.jsp(mode) update.jsp(no)
    String no=request.getParameter("no");
    DataBoardDTO d=dao.boardContentData(Integer.parseInt(no), 2);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../databoard/form.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	$('#btnSub').click(function(){
		$('#writeForm').submit();
	})
});
</script>
</head>
<body>
 <div id="wrapper">
  <form method=post action="../databoard/update_ok.jsp" enctype="multipart/form-data" id="writeForm">
   <p>
   <label for="username">이름</label>
   <input type=text name=name id=username value="<%=d.getName()%>">
   <input type=hidden name=no value="<%=d.getNo()%>">
   </p>
   <p>
   <label for="usersub">제목</label>
   <span class="cellStyle">
   <input type=text name=subject id=usersub value="<%=d.getSubject()%>">
   </span>
   </p>
   <p>
   <label for="usercont">내용</label>
   <span class="cellStyle">
   <textarea name=content id=usercont><%=d.getContent() %></textarea>
   </span>
   </p>
   <%
     if(d.getFilesize()>0)
     {
   %>
   <p>
   <label for="old_upload">첨부파일 여부</label>
    <input type=text name=old_upload value="<%=d.getFilename()%>">
   </p>
   <%
     }
   %>
   <p>
   <p>
   <label for="upload">첨부파일</label>
    <input type=file name=upload id=upload>
   </p>
   <p>
    <label for="userpwd">비밀번호</label>
    <input type="password" name=pwd id=userpwd>
   </p>
   <p class="btnSubmit">
      <input type=button id="btnSub" value="수정">
      <input type=button id="btnCancel" value="취소"
      onclick="javascript:history.back()">
   </p>
  </form>
 </div>
</body>
</html>
