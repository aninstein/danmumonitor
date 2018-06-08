
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
<!-- index.html -->
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
        <meta name="format-detection" content="telephone=no">
        <meta charset="UTF-8">

        <meta name="description" content="Violate Responsive Admin Template">
        <meta name="keywords" content="Super Admin, Admin, Template, Bootstrap">

        <title>直播平台安全监控系统</title>
            
        <!-- CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/animate.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/form.css" rel="stylesheet">
        <link href="css/calendar.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/icons.css" rel="stylesheet">
        <link href="css/generics.css" rel="stylesheet"> 
        
        <!-- 图标 -->
        <link rel="icon" type="image/png" sizes="32x32" href="img/timg.png">
		
		
		<script src="js/echarts/echarts.min.js"></script> 
		<script src="js/echarts/china.js"></script> 
		
    </head>
    <body id="skin-blur-violate">

        <header id="header" class="media">
            <a href="" id="menu-toggle"></a> 
            <a class="logo pull-left" href="index.jsp">直播平台监控系统</a>
            
            <div class="media-body">
                <div class="media" id="top-menu">
                    <div class="pull-left tm-icon">
                        <a data-drawer="messages" class="drawer-toggle" href="">
                            <font color="#ffff00" size="6em"><i class="fa fa-exclamation-triangle" aria-hidden="true" ></i></font>
							<i class="sa-top-message" aria-hidden="true" ></i>
                            <i class="n-count animated" id="alertNumber">0</i>
                            <span>系统警报</span>
                        </a>
                    </div>
                    <div class="pull-left tm-icon">
                        <a data-drawer="notifications" class="drawer-toggle" href="">
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
                                    <small class="text-muted">用户名</small><br>
                                    <a class="t-overflow" href="">警告类型、频繁出现关键词</a>
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
                            <a href=""><small>显示全部</small></a><!--链接到投诉和警报列表上-->
                        </div>
                    </div>
                </div>
				<!--report end-->
                
                <!-- Breadcrumb -->
                <ol class="breadcrumb hidden-xs">
                    <li><a href="#" class="active">主页</a></li>
                </ol>
                
                <h4 class="page-title">功能列表</h4>
                                
                <!-- Shortcuts -->
                <div class="block-area shortcut-area">
                    <a class="shortcut tile" href="list_anchor.jsp">
                        <i class="fa fa-users" aria-hidden="true"></i>
                        <small class="t-overflow">监控主播</small>
                    </a>
                    <a class="shortcut tile" href="list_video.jsp">
                        <i class="fa fa-video-camera" aria-hidden="true"></i>
                        <small class="t-overflow">视频列表</small>
                    </a>
                    <a class="shortcut tile" href="list_BanAnchor.jsp">
					<span class="fa-stack fa-2x">
						<i class="fa fa-bell fa-stack-1x"></i>
						<i class="fa fa-ban fa-stack-2x text-danger"></i>
					</span>
                        <!-- <i class="fa fa-ban no fa-comment text-danger" aria-hidden="true"></i> -->
                        <small class="t-overflow">禁播列表</small>
                    </a>
                    <a class="shortcut tile" href="list_DMinfo.jsp">
                        <i class="fa fa-sort-amount-asc" aria-hidden="true"></i>
                        <small class="t-overflow">弹幕信息</small>
                    </a>
                    <a class="shortcut tile" href="SysReport.jsp">
                        <i class="fa fa-bar-chart" aria-hidden="true"></i>
                        <small class="t-overflow">系统信息</small>
                    </a>
                    <a class="shortcut tile" href="list_Incivilizer.jsp">
                        <i class="fa fa-user-times" aria-hidden="true"></i>
                        <small class="t-overflow">不文明</small>
                    </a>
                </div>
                
                <hr class="whiter" />
                
				
				
				
				<div class="tile col-md-8">
				   <h2 class="tile-title">添加管理员用户</h2>
				   <!-- <div class="tile-config dropdown"> -->
					   <!-- <a data-toggle="dropdown" href="" class="tooltips tile-menu" title="" data-original-title="Options"></a> -->
				   <!-- </div> -->
               
               <div class="p-10" id="login">
					

				<div class="tile animated active" id="box-register">
					<h2 class="m-t-0 m-b-15">请确保信息准确</h2>
					<h5>真实姓名：</h5><input type="text" class="login-control m-b-10" id="realname" placeholder="请输入管理员真实姓名">
					<h5>登录名：</h5><input type="text" class="login-control m-b-10" id="username" placeholder="请输入用于登录的登录名">
					<h5>请输入昵称：</h5><input type="text" class="login-control m-b-10" id="nicheng" placeholder="请输入用于显示的昵称">
					<h5>Email：</h5><input type="email" class="login-control m-b-10" id="email" placeholder="请输入电子邮箱">  
					<h5>电话号码：</h5><input type="text" class="login-control m-b-10" id="utel" placeholder="请输入手机号码（务必准确，以便紧急情况联系）">    
					<h5>密码：</h5><input type="password" class="login-control m-b-10" id="password" placeholder="请输入密码">
					<h5>确认密码：</h5><input type="password" class="login-control m-b-20" id="repassword" placeholder="两次密码输入必须一致">
					<button class="btn btn-block m-b-10" onclick="addAdministor()">添加</button>
					
				</div>
				
               </div>
           </div>
			
			<script>
				function addAdministor(){
					var realname=$("#realname").val();
					var nicheng=$("#nicheng").val();
					var username=$("#username").val();
					var email=$("#email").val();
					var utel=$("#utel").val();
					var password=$("#password").val();
					var repassword=$("#repassword").val();
					
					$.post("AddAdministorServlet",
					{
						realname:realname,
						username:username,
						nicheng:nicheng,
						email:email,
						utel:utel,
						password:password,
						repassword:repassword
					},
					function(data,status){
						if(data==1){
							alert("添加成功！");
						}
						else{
							alert("密码格式有误！");
						}
					}
					);
				}
			</script>
				
				
				
		<div><br><br><br></div>
            <!-- Register -->
			
     
				
				
				
                
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
    </body>
</html>
<%} %>