<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.7.js"></script>
<script type="text/javascript">
	// window.onload=function(){}
	// $(document).ready(function(){})
	/*
	 *  selector : 내장객체, 태그명, id명, class명
	 $(window),$(document) 내장객체
	 $('tr'), $('td')       태그
	 $('#id명')              id명 : 중복이 허용되지 않는다.!!!!!!! 매우중요!!
	 $('.class명')           CLASS  => 태그 제어(DOM))
	 자바스크립트 변수
	 var i=0 => 정수
	 var i=0.0 => 실수
	 var i=[]  => array
	 var i={}  => object
	 var i=""  => string
	 */
	$(function() {
		$('#sendBtn').click(function() {
			var name = $('#name').val();
			/*
			   $('#name').val() => get
			   $('#name').val("aaa") => set
			 */
			if (name.trim() == "") {
				$('#name').focus();
				return;
			}
			var subject = $('#subject').val();

			if (subject.trim() == "") {
				$('#subject').focus();
				return;
			}
			var cont = $('#content').val();

			if (cont.trim() == "") {
				$('#content').focus();
				return;
			}
			var pwd = $('#pwd').val();

			if (pwd.trim() == "") {
				$('#pwd').focus();
				return;
			}
			$('#frm').submit();
		});
	});
</script>
<link rel="stylesheet" type="text/css" href="board.css">
</head>
<body>
	<center>
		<img src="../board/image/qna.jpg" width=500 height=100>
		<p>
		<form method=post action="../board/insert_ok.jsp" id="frm">
			<table border=1 bordercolor="black" width=500 cellpadding="0"
				cellspacing="0">
				<tr>
					<td>
						<table border=0 width=500>
							<tr>
								<td width=15% align=right>이름</td>
								<td width=85% align=left><input type=text name=name size=12
									id="name"></td>
							</tr>
							<tr>
								<td width=15% align=right>제목</td>
								<td width=85% align=left><input type=text name=subject
									size=48 id="subject"></td>
							</tr>
							<tr>
								<td width=15% align=right valign="top">내용</td>
								<td width=85% align=left><textarea rows="10" cols="50"
										name=content id="content"></textarea></td>
							</tr>
							<tr>
								<td width=15% align=right>비밀번호</td>
								<td width=85% align=left><input type=password name="pwd"
									size=10 id="pwd"></td>
							</tr>
							<tr>
								<td colspan="2" align="center"><input type="button"
									value="전송" id="sendBtn"> <input type="button"
									value="취소" onclick="javascript:history.back()">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>