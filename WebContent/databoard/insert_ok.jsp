<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*, com.sist.databoard.dao.*" %>   
<%
   request.setCharacterEncoding("EUC-KR");
   String enctype = "EUC-KR";
   int size = 1024*1024*100;
   String path ="c://download";
   MultipartRequest mr = new MultipartRequest(request,path,size,enctype,
		                          new DefaultFileRenamePolicy());
   
   String name=mr.getParameter("name");
   String subject=mr.getParameter("subject");
   String content=mr.getParameter("content");
   String pwd=mr.getParameter("pwd");
   String filename=mr.getOriginalFileName("upload");
   DataBoardDTO d = new DataBoardDTO(); 
   d.setName(name);
   d.setSubject(subject);
   d.setContent(content);
   d.setPwd(pwd);
   if(filename==null)
   {
	 d.setFilename("");
	 d.setFilesize(0);
	}
   else
   {
	 File file = new File("c:\\download\\"+filename);
	 d.setFilename(filename);
	 d.setFilesize((int)file.length());
   }
   DataBoardDAO dao = DataBoardDAO.newInstance();
   //insert
   dao.boardInsert(d);
   response.sendRedirect("../main/main.jsp?mode=9");
%>