
<%@page import="java.sql.ResultSet"%>
<%@page import="com.DanMuSafetyMonitor.bean.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	if(request.getSession().getAttribute("Uname") == null)
	{
	        response.sendRedirect("login.jsp");        
	}
	else if(request.getSession().getAttribute("Ugrant") == null)
	{
		response.sendRedirect("login.jsp");  
	}
	else{
 %>
 
 <!DOCTYPE html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<!-- profile-page.html -->
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
        <meta name="format-detection" content="telephone=no">
        <meta charset="UTF-8">

        <meta name="description" content="Violate Responsive Admin Template">
        <meta name="keywords" content="Super Admin, Admin, Template, Bootstrap">

        <title>监控弹幕信息</title>
            
       <!-- CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/animate.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/form.css" rel="stylesheet">
        <link href="css/calendar.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/icons.css" rel="stylesheet">
        <link href="css/generics.css" rel="stylesheet"> 
		
		
		<script src="js/echarts/echarts.min.js"></script> 
		<script src="js/echarts/china.js"></script> 
		
		<script>
			window.onload=function(){InsertIndex();}
		</script>
		
    </head>
    <body id="skin-blur-violate">

        <header id="header" class="media">
            <a href="" id="menu-toggle"></a> 
            <a class="logo pull-left" href="index.html">直播平台监控系统</a>
            
            <div class="media-body">
                <div class="media" id="top-menu">
                    <div class="pull-left tm-icon">
                        <a data-drawer="messages" class="drawer-toggle" href=""><!---->
                            <font color="#ffff00" size="6em"><i class="fa fa-exclamation-triangle" aria-hidden="true" ></i></font>
							<i class="sa-top-message" aria-hidden="true" ></i>
                            <i class="n-count animated" id="alertNumber">0</i>
                            <span>系统警报</span>
                        </a>
                    </div>
                    <div class="pull-left tm-icon">
                        <a data-drawer="notifications" class="drawer-toggle" href=""><!---->
							<font color="#ff0000" size="6em"><i class="fa fa-question-circle" aria-hidden="true" ></i></font>
							<i class="sa-top-updates" aria-hidden="true" ></i>
                            <i class="n-count animated" id="reportNumber">0</i>
                            <span>举报投诉</span>
                        </a>
                    </div>

                    

                    <div id="time" class="pull-right">
                        <span id="hours"></span>
                        :
                        <span id="min"></span>
                        :
                        <span id="sec"></span>
                    </div>
                    
                    <div class="media-body">
                        <input type="text" class="main-search" id="indexSearch"><!--全局搜索栏-->
                    </div>
                </div>
            </div>
        </header>
        
        <div class="clearfix"></div>
        
		
		
        <section id="main" class="p-relative" role="main">
            
            <!-- Sidebar -->
            <aside id="sidebar">
                
                <!-- Sidbar Widgets -->
                <div class="side-widgets overflow">
                    <!-- Profile Menu -->
                    <div class="text-center s-widget m-b-25 dropdown" id="profile-menu">
                        <a href="" data-toggle="dropdown" id="theimg">
                            <img class="profile-pic animated" src="img/profile-pic2.jpg" alt="">
                        </a>
                        <ul class="dropdown-menu profile-menu">
                        	
                            <li><a href="">个人中心</a> <i class="icon left">&#61903;</i><i class="icon right">&#61815;</i></li>
                        	<li id="usermanager"><!-- <a href="">管理用户</a> <i class="icon left">&#61903;</i><i class="icon right">&#61815;</i>--></li> 
                          
                            <li><a href="${pageContext.request.contextPath}/LoginOutServlet">退出登录</a> <i class="icon left">&#61903;</i><i class="icon right">&#61815;</i></li>
                        </ul>
                        <h4 class="m-0"><%=request.getSession().getAttribute("Uname")%></h4>
                        <h5 id="userIdentity">管理员</h5>
                        
                        <%if((int)request.getSession().getAttribute("Ugrant")==1){ %>
			                <script>
			                	var umg=document.getElementById("usermanager").innerHTML='<a href="AddAdmin.jsp">添加管理用户</a> <i class="icon left">&#61903;</i><i class="icon right">&#61815;</i>';
			                	var umt=document.getElementById("userIdentity").innerHTML='经理';
			                	var umi=document.getElementById("theimg").innerHTML='<img class="profile-pic animated" src="img/profile-pic.jpg" alt="">';
			                	
			                </script>
			             <%}%>
                    </div>
                    
                    <!-- Calendar -->
                    <div class="s-widget m-b-25">
                        <div id="sidebar-calendar"></div>
                    </div>
                    
                    <!-- Feeds 
                    <div class="s-widget m-b-25">
                        <h2 class="tile-title">
                           News Feeds
                        </h2>
                        
                        <div class="s-widget-body">
                            <div id="news-feed"></div>
                        </div>
                    </div>-->
                    
                      
                    <!-- Projects -->
                    <div class="s-widget m-b-25">
                        <h2 class="tile-title">
                            	系统监控主播列表
                        </h2>
                         
                        
                       <div class="s-widget-body">
                       		<%
                            	matableDao mtd=new matableDao(); 
                            	ResultSet rs_a=null;
                            	if(request.getAttribute("searchAnchorRs") == null)
                 		 		{
                 		 			rs_a=mtd.ALLSelect();
 				   				}
 				   				else{
 				   					rs_a= (ResultSet)request.getAttribute("searchAnchorRs"); 
 				   				}
                            	while(rs_a.next()){ 
                            	String room=(String)rs_a.getString("MAroom"); 

                            	%>
                            <div class="side-border">
                                <small><%=rs_a.getString("MAname") %></small>
                                <div class="progress progress-small">
                                     <a href="${pageContext.request.contextPath}/AnchorProDanMuServlet?listMAname=<%=rs_a.getString("MAname") %>" data-toggle="tooltip" title="" class="tooltips progress-bar progress-bar-info" style="width: 60%;" data-original-title="60%">
                                          <span class="sr-only">60% Complete</span>
                                     </a>
                                </div>
                            </div>
                            <%} %>
							<!--progress-bar tooltips progress-bar-danger-->
							<!--tooltips progress-bar progress-bar-warning -->
							<!--tooltips progress-bar progress-bar-info -->
							<!--tooltips progress-bar progress-bar-success -->
                        </div>
                    </div>
                </div>
                
               <!-- Side Menu -->
                <ul class="list-unstyled side-menu">
                    <li class="active">
                        <a class="sa-side-home" href="index.jsp">
                            <span class="menu-item">主页</span>
                        </a>
                    </li>
                    <li>
                        <a class="sa-side-typography" href="list_anchor.jsp">
                            <span class="menu-item">监控主播列表</span>
                        </a>
                    </li>
                    <li>
                        <a class="sa-side-widget" href="list_video.jsp">
                            <span class="menu-item">监控主播视频列表</span>
                        </a>
                    </li>
                    <li>
                        <a class="sa-side-table" href="list_BanAnchor.jsp">
                            <span class="menu-item">禁播列表</span>
                        </a>
                    </li>
                    
                    <li>
                        <a class="sa-side-chart" href="list_DMinfo.jsp">
                            <span class="menu-item">弹幕信息</span>
                        </a>
                    </li>
                    <li>
                        <a class="sa-side-folder" href="SysReport.jsp">
                            <span class="menu-item">系统报告</span>
                        </a>
                    </li>
                    <li>
                        <a class="sa-side-calendar" href="calendar.html">
                            <span class="menu-item">安全日志</span>
                        </a>
                    </li>
                    <li class="dropdown">
                        <a class="sa-side-page" href="">
                            <span class="menu-item">警报/投诉</span>
                        </a>
                        <ul class="list-unstyled menu-item">
                            <li><a data-drawer="messages"  href="#">警报列表</a></li>
                            <li><a data-drawer="notifications" href="#">投诉列表</a></li>
                        </ul>
                    </li>
                </ul>
				<!--END menu-->

            </aside>
        
            <!-- Content -->
            <section id="content" class="container">
            
                <!-- Messages Drawer -->
                <div id="messages" class="tile drawer animated">
                    <div class="listview narrow">
                        <div class="media">
                            <a href="">系统对于主播行为的警告</a>
                            <span class="drawer-close">&times;</span>
                            
                        </div>
                        <div class="overflow" style="height: 20em">
                            <div class="media">
                                <div class="pull-left">
                                   <!-- <img width="40" src="img/profile-pics/1.jpg" alt="">-->
								   <font color="#ffff00"><i class="fa fa-exclamation-triangle fa-2x" aria-hidden="true" ></i></font>
                                </div> 
								<div class="media-body">
                                    <small class="text-muted">AC绅士向</small><br>
                                    <a class="t-overflow" href="">类型：侮辱谩骂<span style="color:red">你妈逼的</span></a>
                                </div>
                            </div>
							
							
                        </div>
                        <div class="media text-center whiter l-100">
                            <a href=""><small>显示全部</small></a><!--链接到投诉和警报列表上-->
                        </div>
                    </div>
                </div>
				<!--Messages link-->
                
                <!-- Notification Drawer -->
                <div id="notifications" class="tile drawer animated">
                    <div class="listview narrow">
                        <div class="media">
                            <a href="">用户对于主播的举报列表</a>
                            <span class="drawer-close">&times;</span>
                        </div>
                        <div class="overflow" style="height: 20em">
                            <div class="media">
                                <div class="pull-left">
                                    <!--<img width="40" src="img/profile-pics/1.jpg" alt="">-->
									<font color="#ff0000"><i class="fa fa-question-circle fa-2x" aria-hidden="true" ></i></font>
                                </div>
                                <div class="media-body">
                                    <small class="text-muted">被举报用户</small><br>
                                    <a class="t-overflow" href="">举报内容</a>
                                </div>
                            </div>
                        </div>
                        <div class="media text-center whiter l-100">
                            <a href=""><small>显示全部</small></a>
                        </div>
                    </div>
                </div>
				<!--report end-->
                
                <!-- Notification Drawer -->
                <div id="notifications" class="tile drawer animated">
                    <div class="listview narrow">
                        <div class="media">
                            <a href="">用户对于主播的举报列表</a>
                            <span class="drawer-close">&times;</span>
                        </div>
                        <div class="overflow" style="height: 20em">
                            <div class="media">
                                <div class="pull-left">
                                    <!--<img width="40" src="img/profile-pics/1.jpg" alt="">-->
									<font color="#ff0000"><i class="fa fa-question-circle fa-2x" aria-hidden="true" ></i></font>
                                </div>
                                <div class="media-body">
                                    <small class="text-muted">被举报用户</small><br>
                                    <a class="t-overflow" href="">举报内容</a>
                                </div>
                            </div>
                        </div>
                        <div class="media text-center whiter l-100">
                            <a href=""><small>显示全部</small></a>
                        </div>
                    </div>
                </div>
				<!--report end-->
                
                <!-- Breadcrumb -->
                <ol class="breadcrumb hidden-xs">
                    <li><a href="#">主页</a></li>
                    <li class="active">弹幕信息</li>
                </ol>
                
                <h4 class="page-title">系统本周弹幕信息</h4>
                                
<div  class="main-chart" style="height: 30.1em; width:60.1em;">
                            <jsp:include page="js/echarts/DM_barcharts.jsp"></jsp:include>
                                  </div>
				
<div  class="main-chart" style="height: 32.1em; width:66.1em;">
                            <jsp:include page="js/echarts/DM_lincharts.jsp"></jsp:include>
                                  </div>
                
                <hr class="whiter" />
                
				<!--monitor table-->
				 <!-- Responsive Table -->
                <div class="block-area" id="responsiveTable">
                <div id="theButton">
				</div>
				<header class="listview-header media">
                        <!-- <ul class="list-inline pull-right m-t-5 m-b-0"> -->
                            <!-- <button class="btn m-r-5">搜索</button> -->
                        <!-- </ul> -->
                            
                        
                        <ul class="list-inline list-mass-actions pull-left">
                            <li>
                                <a href="javascript:viod(0)" onclick="InsertIndex()" title="刷新" class="tooltips">
                                    <i class="fa fa-refresh fa-2x" aria-hidden="true"></i>刷新
                                </a>
                            </li>
							<h4>关键词信息</h4>
                        </ul>
						
						 <script>
                        	function InsertIndex(){
                        	var theButton=$("#theButton").html(); 
                        	var theIndex=$("#theIndex").val();
                        	$.post("DanMuInfoServlet",
                        		{
                        			theIndex:theIndex
                        		},
                        		function(data){
                        			var json=eval(data);
                        			var tabletbody=document.getElementById("TableTbody").innerHTML;
									var i=0,j=0;
									var contentStr="";
									$.each(json,function(){
										contentStr+="<tr>"+
										"<td>"+json[i].theIndex+"</td>"+
										"<td>"+json[i].Times+"</td>"+
										"<td>"+json[i].negTimes+"</td>"+
										"<td>"+json[i].neg+"%</td>"+
// 										'<td><div class="pie-chart-tiny" data-percent="'+json[i].neg+'">'+
//                                         '<span class="percent"></span><span class="pie-title">消极指数</div></td>'+
										"<td>"+
										$.each(json[i].content,function(){
											var str="";
											str+='<h4>'+json[i].content[j]+'</h4>';
											j++;
											return str;
										})
										+"</td></tr>";
										i++;
									});
									document.getElementById("TableTbody").innerHTML=contentStr;
                        		}
                        		,"json");

                        	}
                        	
                        	
                        </script>
						
						<!--搜索主播-->
						<input class="input-sm col-md-4 pull-right message-search" type="text" placeholder="输入需要监控的关键词" id="theIndex">
                        <button class="btn m-r-5 pull-right" onclick="InsertIndex()">插入监控关键词</button>
                        
                        <%
                        	imtableDao itd=new imtableDao();
                        	ResultSet rsim=itd.ALLSelect();
							
                        	int i=0;
                        	while(rsim.next()){
                        	%>
                        		<input type="hidden" name="indexTime<%=i %>" id="indexTime<%=i %>" value="<%=rsim.getInt("Times") %>">
                        		<input type="hidden" name="indexNegTime<%=i %>" id="indexNegTime<%=i %>" value="<%=rsim.getInt("negtimes") %>">
                        		<input type="hidden" name="neg<%=i %>" id="neg<%=i %>" value="<%=rsim.getFloat("neg") %>">
                        	<%
                        		i++;
                        	}
                         %>
                        
                       
						
                        <div class="clearfix"></div>
                    </header>
					
					
					
					
					
                    <div class="table-responsive overflow">
                        <table class="table tile">
						
                            <thead>
                                <tr>
									<th>关键词</th>
                                    <th>出现频率</th>
                                    <th>消极词出现频率</th>
									<th>消极率占比</th>
									<th>出现语句</th>
                                   
                                </tr>
                            </thead>
                            <tbody id="TableTbody"></tbody>
                        </table>
                    </div>
                </div>
				

               
            <!--[endif]-->
        </section>
        
        <!-- Javascript Libraries -->
        <!-- jQuery -->
        <script src="js/jquery.min.js"></script> <!-- jQuery Library -->
        <script src="js/jquery-ui.min.js"></script> <!-- jQuery UI -->
        <script src="js/jquery.easing.1.3.js"></script> <!-- jQuery Easing - Requirred for Lightbox + Pie Charts-->

        <!-- Bootstrap -->
        <script src="js/bootstrap.min.js"></script>

        <!-- Charts -->
        <script src="js/charts/jquery.flot.js"></script> <!-- Flot Main -->
        <script src="js/charts/jquery.flot.time.js"></script> <!-- Flot sub -->
        <script src="js/charts/jquery.flot.animator.min.js"></script> <!-- Flot sub -->
        <script src="js/charts/jquery.flot.resize.min.js"></script> <!-- Flot sub - for repaint when resizing the screen -->
		<script src="js/echarts/echarts.min.js"></script> 

        <script src="js/sparkline.min.js"></script> <!-- Sparkline - Tiny charts -->
        <script src="js/easypiechart.js"></script> <!-- EasyPieChart - Animated Pie Charts -->
        <script src="js/charts.js"></script> <!-- All the above chart related functions -->

        <!-- Map -->
        <script src="js/maps/jvectormap.min.js"></script> <!-- jVectorMap main library -->
        <script src="js/maps/usa.js"></script> <!-- USA Map for jVectorMap -->

        <!--  Form Related -->
        <script src="js/icheck.js"></script> <!-- Custom Checkbox + Radio -->

        <!-- UX -->
        <script src="js/scroll.min.js"></script> <!-- Custom Scrollbar -->

        <!-- Other -->
        <script src="js/calendar.min.js"></script> <!-- Calendar -->
        <script src="js/feeds.min.js"></script> <!-- News Feeds -->

		
        <!-- All JS functions -->
        <script src="js/functions.js"></script>
		<script src="js/myScript.js"></script>
    </body>
</html>
 <%}%>