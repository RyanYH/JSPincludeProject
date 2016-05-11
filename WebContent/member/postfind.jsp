<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.member.dao.*,java.util.*"%>
<%
     int curpage=0;
     int total=0;
     
     request.setCharacterEncoding("EUC-KR");
     String dong=request.getParameter("dong");
     String strPage=request.getParameter("page");
     if(strPage==null)
    	 strPage="1";
     curpage=Integer.parseInt(strPage);
     MemberDAO dao=MemberDAO.newInstance();
     List<ZipcodeDTO> list=null;
     if(dong!=null)
     {
    	 list=dao.postFind(curpage,dong);
     }
     String old = dao.postOld();
     total=dao.postFindCount(dong);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	$('#postBtn').click(function()
	{
		var dong=$('#dong').val();
		if(dong.trim()=="")
		{
			$('#dong').focus();
			return;
		}
		$('#postfrm').submit();
	});
});
function ok(zip,addr)
{
	opener.frm.post1.value=zip.substring(0,3);
	opener.frm.post2.value=zip.substring(4,7);
	opener.frm.addr1.value=addr;
	self.close();
}
</script>
<style type="text/css">
th,td{
   font-family: 맑은 고딕;
   font-size: 9pt;
}
th{
      font-size: 10pt;
}
a{
   text-decoration: none;
   color: black;
}
a:HOVER {
	text-decoration: underline;
	color:#ccccff;
}
</style>
</head>
<body>
   <center>
     <table border=0 width=430>
       <tr>
         <td align=left>
         <form method=post action="../member/postfind.jsp" id="postfrm" name="postfrm">
           입력:<input type=text name=dong size=13 id="dong" <%-- value="<%=dong%>" --%> name="dong">
        <input type=button value="찾기" id="postBtn">
         </form>
         </td>
       </tr>
       
     </table>
     <table border=0 width=430>
       <tr bgcolor=#ccccff>
        <th width=20%>우편번호</th>
        <th width=80%>주소</th>
       </tr>
       <%
           if(list!=null && list.size()>0)
           {
        	   for(ZipcodeDTO d:list)
        	   {
        		   String zip=d.getZipcode();
        		   String addr=d.getSido()+" "
        				      +d.getGugun()+" "
        				      +d.getDong()+" "
        				      +d.getBunji();
       %>
                    <tr>
                     <td width=20% align=center><%=zip %></td>
                     <td width=80% align="left">
                     <a href="javascript:ok('<%=zip %>','<%=addr %>')"><%=addr %></a>
                     </td>
                    </tr>
       <%
        	   }
           }
           else
           {
       %>
             <tr>
               <td colspan="2" align=center>
                <font color=red>검색된 결과가 없습니다</font>
               </td>
             </tr>
       <%
           }
       %>
     </table>
     <hr width=430>
     <table border=0 width=430>
      <tr>
        <td align="right">
         <a href="../member/postfind.jsp?page=<%=curpage>1?curpage-1:curpage%>&dong=<%=old%>">이전</a>&nbsp;
         <a href="../member/postfind.jsp?page=<%=curpage<total?curpage+1:curpage%>&dong=<%=old%>">다음</a>&nbsp;&nbsp;
         <%=curpage %> page / <%=total %> pages
        </td>
      </tr>
     </table>
   </center>
</body>
</html>







