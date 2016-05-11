<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*,com.sist.dao.*"%>
    
<%
    int curpage=0;
    int totalpage=0;
    BoardDAO dao=BoardDAO.newInstance();
    // 현재페이지 => 사용자로부터 받는다 
    String strPage=request.getParameter("page");
    if(strPage==null)
    	strPage="1";
    curpage=Integer.parseInt(strPage);
    totalpage=dao.boardTotal();
    List<BoardDTO> list=dao.boardListData(curpage);
    int count=dao.boardCount();
    count=count-((curpage*10)-10);
    
    String col=request.getParameter("fs");
    String data=request.getParameter("ss");
    boolean chkSearch = false;
    if(data==null){
    	data="";
    	chkSearch=false;
    }else{
    	chkSearch=true;
    }
    
    if(chkSearch==false){
    	list=dao.boardListData(curpage);
    }else{
    	list=dao.boardSearchData(curpage, col, data);
    	totalpage=dao.boardSearchPage(col, data);
    }
%>
<%
  request.setAttribute("curpage", curpage);
%>
<c:set var="curpage" value="<%=curpage %>"/>
${ curpage}<%=request.getAttribute("curpage") %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../board/board.css">
<script>
 function search(){
	 var col=frm.fs.value;
	 var data=frm.ss.value;
	 if(data==""){
		 alert("검색어를 입력하세요");
		 return;
	 }
   frm.submit();
 }
 function list(){
	 chkSearch=false;
	 history.forward();
 }
</script>
</head>
<body>
   <center>
     <img src="../board/image/qna.jpg" width=700 height=100>
     <p>
     <table border=0 width=700>
       <tr>
        <td align=left>
         <!-- <img src="../board/image/btn_write.gif"> -->
        </td>
       </tr>
     </table>
     <form action="../board/list.jsp" method=get name=frm>
     <table border=0 width=700>
      <tr bgcolor=#ccccff>
        <th width=10%>번호</th>
        <th width=45%>제목</th>
        <th width=15%>이름</th>
        <th width=20%>작성일</th>
        <th width=10%>조회수</th>
      </tr>
      <%
          int j=0;
          String color="white";
          for(BoardDTO d:list)
          {
        	if(j%2==0)
        	color="white";
        	else
        	color="smokewhite";
          
      %>
              <tr bgcolor=<%=color %>>
                <td width=10% align=center><%=count-- %></td>
		        <td width=45% align=left>
		         <%
		            if(d.getGroup_tab()>0)
		            {
		            	for(int i=0;i<d.getGroup_tab();i++)
		            	{
		         %>
		                     &nbsp;&nbsp;
		         <%
		            	}
		         %>
		                <img src="../board/image/icon_reply.gif">
		         <%
		            }
		         %>
		         <%
		         String msg="관리자가 삭제한 게시물입니다";
		          if(msg.equals(d.getSubject()))
		          {
		         %>
		          <font color=gray><%=d.getSubject() %></font>
		         <%
		          }
		          else
		          {
		         %>
		         <a href="../main/main.jsp?mode=3&no=<%=d.getNo() %>&page=<%=curpage%>">
		         <%=d.getSubject()%></a>
		         <%
		           }
		            String today=new SimpleDateFormat("yyyy-MM-dd").
		                        format(new Date());
		            String dbday=d.getRegdate().toString();
		            if(today.equals(dbday))
		            {
		         %>
		              &nbsp;<sup><img src="../board/image/icon_new (2).gif"></sup>
		         <%
		            }
		         %>
		        </td>
		        <td width=15% align=center><%=d.getName() %></td>
		        <td width=20% align=center><%=d.getRegdate().toString() %></td>
		        <td width=10% align=center><%=d.getHit() %></td>
              </tr>
      <%
             j++;
          }
      %>
     </table>
     <hr width=700>
     <table border=0 width=700>
      <tr>
       <td align=left>
        <a href="../main/main.jsp?mode=4">
        <img src="../board/image/btn_write.gif" border=0></a>
        <!-- 과제  -->
        <select name="fs">
         <option value="name">이름</option>
         <option value="subject">제목</option>
         <option value="content">내용</option>
        </select>
        <input type=text name="ss" size=12>
        <input type="image" src="../board/image/btn_search.gif" onclick="javascript:search()">
        <input type="image" src="../board/image/btn_list.gif" onclick="javascript:list()">
       </td>
       <td align="right">
        <a href="../main/main.jsp?mode=2&page=1">
        <img src="../board/image/begin.gif" border=0></a>
       <a href="../main/main.jsp?mode=2&page=<%=curpage>1? curpage-1 : curpage%>">
        <img src="../board/image/prev.gif" border=0></a>
              <%
					for(int i = 1; i <= totalpage; i++){
						%>
							<a href="../main/main.jsp?mode=2&page=<%=i%>">[<%=i %>]</a>
						<%
					}
				%>
				<a href="../main/main.jsp?mode=2&page=<%=curpage<totalpage? curpage+1 : curpage%>">
					<img src="../board/image/next.gif" border=0>
				</a>
				<a href="../main/main.jsp?mode=2&page=<%=totalpage%>">
					<img src="../board/image/end.gif" border=0>
				</a>
				&nbsp;&nbsp;
				<%=curpage %> page / <%=totalpage %> page
			</td>
		</tr>
	</table>
	</form>
	</center>
</body>
</html>