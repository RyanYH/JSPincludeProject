<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
 function mainSend()
 {
	// alert("회원가입이 완료되었습니다.");
	 location.href="main.jsp";
 }
 window.onload=function(){
	 setTimeout(mainSend,1000);
 }
</script>
</head>
<body>
  <center>
   <img src="../member/join.gif">
  </center>
</body>
</html>