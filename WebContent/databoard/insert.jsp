<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
	<form action="../databoard/insert_ok.jsp" method="post" enctype="multipart/form-data" id="writeForm">
     <p>
      <label for="username">이름</label>
      <input type=text name=name id=username>
     </p>
     <p>
      <label for="usersub">제목</label>
      <span class="cellStyle">
      <input type=text name=subject id=usersub>
      </span>
     </p>
     <p>
      <label for="usercont">내용</label>
       <span class="cellStyle">
      <textarea name="content" id=usercont></textarea>
      </span>
     </p>     
      <p>
      <label for="upload">첨부파일</label>
      <input type="file" name=upload id=upload>
     </p>  
      <p>
      <label for="userpwd">비밀번호</label>
     <input type=password name=pwd id=userpwd>
     </p>  
     <p>
     <p class="btnSubmit">
       <input type=button id="btnSub" value="등록">
       <input type=button id="btnCancel" value="취소"
        onclick="javascript:history.back()">
     </p>     
     </form>
	</div>     
</body>
</html>