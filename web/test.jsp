<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.DanMuSafetyMonitor.bean.DBTool"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	DBTool db=new DBTool();
	Connection conn=db.getConnection();
	ResultSet rs=null;
	
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <table>
    <%
    int num=0;
    String sql="select level,id from ceshi";// where 'a'='a' and limit 0,10		
    rs=db.executeQuery(sql);
    
    	while(rs.next()){ 
    		num++;
    		if(rs.next()){
    	%>
    		<tr>
    			<td id="num"><%=num %></td>
    			<td id="level"><%=rs.getString("level") %></td>
    			<td id="id"><%=rs.getString("id") %></td>
    		</tr>
    		
    	
    <%	
	    	} 
    		else{
    		   	continue;
    		   	%>
    		   	 <script>
    		   		window.setTimeout(page_list,5000);  //表示延时5秒执行page_list()函数
    		   	</script>
    		   	<%
    		}
	    }
    %>
    <script>
    	function startread(){
    		location.replace(location.href);
    	}
    </script>
    </table>
  </body>
</html>
