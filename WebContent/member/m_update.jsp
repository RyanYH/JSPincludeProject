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
     font-family: ���� ���;
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
     <h3>ȸ������</h3>
     <form name=frm action="../member/m_update_ok.jsp">
     <table border=1 bordercolor=black width=500 cellspacing=0 cellpadding=0>
      <tr>
       <td>
         <table border=0 width=500 cellspacing=0 cellpadding=0>
           <tr height=27>
            <td width=15% align=right>ID</td>
            <td width=85% align=left>
             <input type="text" size=12 name=id required readonly value="<%=d.getId() %>">
             <input type=button value="ID�ߺ�üũ" onclick="idcheck()">
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>Password</td>
            <td width=85% align=left>
             <input type="password" size=10 name=pwd>
             &nbsp;&nbsp;���Է� &nbsp;
             <input type="password" size=10 name=pwd1>
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>�̸�</td>
            <td width=85% align=left>
             <input type="text" size=12 name=name value="<%=d.getName()%>">
 
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>����</td>
            <td width=85% align=left>
             <input type="radio" name=sex >����
             <input type="radio" name=sex >����
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>�������</td>
            <td width=85% align=left>
             <input type="date" size=12 name=birth value="<%=d.getBirth()%>">
            </td>
           </tr>
           
           <tr height=27>
            <td width=15% align=right>�̸���</td>
            <td width=85% align=left>
             <input type="email" size=45 name=email>
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>��ȭ��ȣ</td>
            <td width=85% align=left>
             <input type="text" size=10 value="">
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>�����ȣ</td>
            <td width=85% align=left>
             <input type="text" size=10 name=post value="<%=d.getPost() %>">
             <input type=button value=�����ȣ�˻� onclick="postfind()">
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>�ּ�</td>
            <td width=85% align=left>
             <input type="text" size=45 name=addr1 value="<%=d.getAddr1() %>" readonly>
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>���ּ�</td>
            <td width=85% align=left>
             <input type="text" size=45 name=addr2 value="<%=d.getAddr2() %>">
            </td>
           </tr>
           <tr height=27>
            <td width=15% align=right>�ڱ�Ұ�</td>
            <td width=85% align=left>
             <textarea rows="8" cols="50" name=content value="<%=d.getContent() %>"></textarea>
            </td>
           </tr>
           <tr height=27>
            <td colspan="2" align=center>
             <input type="submit" value=����>
             <input type="button" value=���>
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






