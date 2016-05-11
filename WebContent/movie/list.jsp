<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.util.*,com.sist.movie.data.*,com.sist.smovie.data.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MoiveDataManager m = new MoiveDataManager();
	SMoiveDataManager sm = new SMoiveDataManager();
	List<MoiveDTO> list = m.moiveAllData();
	List<SMoiveDTO> sList = sm.moiveAllData();
%>
<c:set var="list" value="<%=list %>"/>
<c:set var="sList" value="<%=sList %>"/>
<%--
      request.setAttribute("list",list)
 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="../databoard/table.css" rel="stylesheet">
<title>Insert title here</title>
<style type="text/css">
img {
	height: 150px;
	width: 100px;
}
</style>
  
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
    	 var data = google.visualization.arrayToDataTable([
    	   ["영화명", "예매율", { role: "style" } ],   	                                                   
    	   <c:forEach var="dto" items="${list}">   	                                                   
    	   ['<c:out value="${dto.title}"/>', <c:out value="${dto.percent}"/>, "#b87333"],   	                                                   
    	   </c:forEach>  	                                                 
    	   ]);
      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
        title: "영화별 예매율",
        width: 300,
        height: 200,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
      chart.draw(view, options);
      
      google.charts.setOnLoadCallback(drawChart1);
      function drawChart1() {
    	 var data = google.visualization.arrayToDataTable([    	                                                      
    	 ['영화명', '별점'],    	                                                      
    	  <c:forEach var="dto" items="${list}">
    	  ['<c:out value="${dto.title}"/>',<c:out value="${dto.reserve}"/>],
    	  </c:forEach>
    	 ]);
      var options = {
        title: '영화별 별점',
        is3D: true,
      };
      var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
      chart.draw(data, options);
    }   
    }
 </script>
  <script type="text/javascript">
 
    </script>
  </head>
</head>
<body>
		<center>
			<h1>CGV</h1>
			<table border=0 width=600 id="table_content">
				<tr>
					<%

						for (MoiveDTO d : list) {
					%>
					<td>
					<a href="main.jsp?mode=15&no=<%=d.getNo()%>">
					<img src="<%=d.getImage()%>" border=0></a></td>
					<%
						}
					%>
				</tr>
				<tr>
					<%
						for (MoiveDTO d : list) {
					%>
					<td>
						<h4><%=d.getTitle()%></h4>
					</td>
					<%
						}
					%>
				</tr>
				<tr>
					<%
						for (MoiveDTO d : list) {
					%>
					<td><%=d.getRegdate()%></td>
					<%
						}
					%>
				</tr>
			</table>
			<table border=0 width=600>
			<tr>
			 <td>
			 <div id="columnchart_values" style="width: 300px; height: 200px;"></div></td>
			 <td>
			 <div id="piechart_3d" style="width: 400px; height: 200px;"></div></td>
			</tr>		
		    </table>
			<h1>서울시네마</h1>
			<table border=0 id="table_content">
				<tr>
					<%
						for (int i = 0; i < list.size(); i++){
					%>

					<%
						SMoiveDTO sd = sList.get(i);
					%>
					<td><img src="<%=sd.getImage()%>"></td>
					<%
						}
					%>
				</tr>
				<tr>
					<%
						for (int i = 0; i < list.size(); i++) {
							SMoiveDTO sd = sList.get(i);
					%>
					<td>
						<h4><%=i+1%>위
						</h4>
						<h4><%=sd.getTitle()%></h4>
					</td>
					<%
						}
					%>
				</tr>
			</table>
		</center>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>