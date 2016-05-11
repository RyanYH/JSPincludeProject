<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.member.dao.*"%>
 <%
      String uid=(String)session.getAttribute("id");
	 MemberDAO dao=MemberDAO.newInstance();
	 MemberDTO d=dao.MemberUpdateData(uid);	 
	 String sex = d.getSex();
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
td{
     font-family: 맑은 고딕;
     font-size: 9pt;
}
</style>
<script type="text/javascript">
function idcheck()
{
	
   window.open("../member/idcheck.jsp","idcheck","width=250,height=200")
}
function postfind()
{
   window.open("../member/postfind.jsp","postfind","width=470,height=250,toolbar=no,statusbar=no,menubar=no,scrollbars=yes")
}
function sexChecked()
{
     return checked;
}

</script>
</head>
<body>
   <center>
     <h3>회원가입</h3>
     <form name=frm action="../member/m_update_ok.jsp">
     <table border=1 bordercolor=black width=500 cellspacing=0 cellpadding=0>
      <tr>
       <td>
         <table border=0 width=500 cellspacing=0 cellpadding=0>
           <tr height=27>
            <td width=15% align=right>ID</td>
            <td width=85% align=left>
             <input type="text" size=12 name=id required readonly value="<%=d.getId() %>">
             <input type=button value="ID중복체크" onclick="idcheck()">
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>Password</td>
            <td width=85% align=left>
             <input type="password" size=10 name=pwd>
             &nbsp;&nbsp;재입력 &nbsp;
             <input type="password" size=10 name=pwd1>
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>이름</td>
            <td width=85% align=left>
             <input type="text" size=12 name=name value="<%=d.getName()%>">
 
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>성별</td>
            <td width=85% align=left>
             <input type="radio" name=sex >남자
             <input type="radio" name=sex >여자
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>생년월일</td>
            <td width=85% align=left>
             <input type="date" size=12 name=birth value="<%=d.getBirth()%>">
            </td>
           </tr>
           
           <tr height=27>
            <td width=15% align=right>이메일</td>
            <td width=85% align=left>
             <input type="email" size=45 name=email>
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>전화번호</td>
            <td width=85% align=left>
             <input type="text" size=10 value="">
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>우편번호</td>
            <td width=85% align=left>
             <input type="text" size=10 name=post value="<%=d.getPost() %>">
             <input type=button value=우편번호검색 onclick="postfind()">
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>주소</td>
            <td width=85% align=left>
             <input type="text" size=45 name=addr1 value="<%=d.getAddr1() %>" readonly>
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>상세주소</td>
            <td width=85% align=left>
             <input type="text" size=45 name=addr2 value="<%=d.getAddr2() %>">
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>자기소개</td>
            <td width=85% align=left>
             <textarea rows="8" cols="50" name=content value="<%=d.getContent() %>"></textarea>
            </td>
           </tr>
           <tr height=27>
            <td colspan="2" align=center>
             <input type="submit" value=수정>
             <input type="button" value=취소>
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






