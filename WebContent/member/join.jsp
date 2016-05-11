<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
</script>
</head>
<body>
   <center>
     <h3>회원가입</h3>
     <form name=frm action="../member/join_ok.jsp">
     <table border=1 bordercolor=black width=500 cellspacing=0 cellpadding=0>
      <tr>
       <td>
         <table border=0 width=500 cellspacing=0 cellpadding=0>
           <tr height=27>
            <td width=15% align=right>ID</td>
            <td width=85% align=left>
             <input type="text" size=12 name=id required readonly>
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
             <input type="text" size=12 name=name>
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>성별</td>
            <td width=85% align=left>
             <input type="radio" name=sex checked value=남자>남자
             <input type="radio" name=sex value=여자>여자
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>생년월일</td>
            <td width=85% align=left>
             <input type="date" size=12 name=birth>
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
             <select name=tel1>
              <option>010</option>
              <option>011</option>
              <option>017</option>
             </select>
             <input type="text" size=5 name=tel2>-<input type="text" size=5 name=tel3>
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>우편번호</td>
            <td width=85% align=left>
             <input type="text" size=5 name=post1 readonly>-<input type="text" size=5 name=post2 readonly>
             <input type=button value=우편번호검색 onclick="postfind()">
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>주소</td>
            <td width=85% align=left>
             <input type="text" size=45 name=addr1 readonly>
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>상세주소</td>
            <td width=85% align=left>
             <input type="text" size=45 name=addr2>
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>자기소개</td>
            <td width=85% align=left>
             <textarea rows="8" cols="50" name=content></textarea>
            </td>
           </tr>
           <tr height=27>
            <td colspan="2" align=center>
             <input type="submit" value=가입>
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






