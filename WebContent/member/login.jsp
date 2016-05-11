<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script>
$(function(){
	$('#joinBtn').click(function(){
		location.href="../main/main.jsp?mode=1";
	});
	$('#logBtn').click(function(){
		var id = $('#id').val();
		if(id.trim()==""){
			$('#id').focus();
			return;
		}
		var pwd=$('#pwd').val();
		if(id.trim()==""){
			$('#pwd').focus();
			return;
		}
		$('#logfrm').submit();
	});
});
</script>
</head>
<body>
<form method=post action="../member/login_ok.jsp" id="logfrm">
  <table border=0 width=200 style="margin-top: 30px">
    <tr>
     <td width=30% align="right">ID</td>
     <td width="70%" align="left">
       <input type="text" name=id size=20 id="id">
     </td>
    </tr>
    <tr>
     <td width=30% align="right">PW</td>
     <td width="70%" align="left">
       <input type="password" name=pwd size=20 id="pwd">
     </td>
    </tr>
    <tr>
     <td colspan="2" align="right">
       <input type="button" value="로그인" id="logBtn">
       <input type="button" value="회원가입" id="joinBtn">
     </td>
    </tr>
  </table>
  </form>
</body>
</html>