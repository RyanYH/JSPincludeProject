<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.databoard.dao.*,java.io.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
 <%
 	request.setCharacterEncoding("EUC-KR");
	String enctype = "EUC-KR";
	int size = 1024*1024*100;
	String path ="c://download";
	MultipartRequest mr = new MultipartRequest(request,path,size,enctype,
			                          new DefaultFileRenamePolicy());	
	String no =mr.getParameter("no");
	String name=mr.getParameter("name");
	String subject=mr.getParameter("subject");
	String content=mr.getParameter("content");
	String pwd=mr.getParameter("pwd");
	String filename=mr.getOriginalFileName("upload");
	DataBoardDTO d = new DataBoardDTO(); 
	d.setNo(Integer.parseInt(no));
	d.setName(name);
	d.setSubject(subject);
	d.setContent(content);
	d.setPwd(pwd);
	DataBoardDAO dao = DataBoardDAO.newInstance();
	DataBoardDTO info = dao.boardFileInfo(Integer.parseInt(no));
	if(filename==null)
	{    
		 //File file = new File("c:\\download\\"+info.getFilename());
		 d.setFilename(info.getFilename());
		 d.setFilesize(info.getFilesize());
       
	}
	else
	{
		 File file = new File("c:\\download\\"+filename);
		 d.setFilename(filename);
		 d.setFilesize((int)file.length());
	}

	//insert
	boolean bCheck = dao.boardUpdate(d);
	if(bCheck==true)
	{
		if(filename!=null)
		{
			try{
				File file = new File("c:\\download\\"+info.getFilename());
				file.delete();
			}catch(Exception ex){
				
			}
		}
		response.sendRedirect("../main/main.jsp?mode=9");
	}
	else
	{
%>		
		<script>
		  alert("비밀번호가 틀립니다.");
		  history.back();
		</script>
<%
	}
%>