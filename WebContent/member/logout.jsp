<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form method=post action="../member/logout_ok.jsp" name="logfrm">
  <table border=0 width=200 style="margin-top: 30px">
    <tr>
     <td align="left">
       <%=session.getAttribute("name") %>�� ^^
     </td>
    </tr>
    <tr>
     <td align="left">
              �α��� �� �Դϴ�.
     </td>
    </tr>
    <tr>
     <td colspan="2" align="right">
       <input type="submit" value="�α׾ƿ�" id="logoutBtn">
     </td>
    </tr>
  </table>
  </form>
</body>
</html>