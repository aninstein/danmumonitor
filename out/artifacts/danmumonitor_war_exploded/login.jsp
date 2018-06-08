<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
        <meta name="format-detection" content="telephone=no">
        <meta charset="UTF-8">

        <meta name="description" content="Violate Responsive Admin Template">
        <meta name="keywords" content="Super Admin, Admin, Template, Bootstrap">

        <title>登录直播平台安全检测系统</title>
            
        <!-- CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/form.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/animate.css" rel="stylesheet">
        <link href="css/generics.css" rel="stylesheet"> 
    </head>
    <body id="skin-blur-violate">
        <section id="login">
            <header>
                <h1>直播弹幕和主播行为分析系统</h1>
                <h4>本系统通过直播平台用户的大量评论数据、弹幕数据进行挖掘，对主播直播行为进行判断，是否有违法行为或者不健康因素存在。</h4>
            </header>
        
            <div class="clearfix"></div>
            
            <!-- Login -->
            <form class="box tile animated active" id="box-login" action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <h2 class="m-t-0 m-b-15">用户登录</h2>
                <input type="text" class="login-control m-b-10" name="username" id="username" placeholder="请输入管理员用户名">
                <input type="password" class="login-control" name="password" id="password" placeholder="请输入密码">
                <div class="checkbox m-b-20">
					<label>
                        <input type="checkbox" name="manager" value="1">
                        经理登陆
                    </label>
                </div>
                <input class="btn btn-block m-b-10" type="submit" value="登陆">
<!--                 <button class="btn btn-block m-b-10">登录</button> -->
                
            </form>
        </section>                      
        
        <!-- Javascript Libraries -->
        <!-- jQuery -->
        <script src="js/jquery.min.js"></script> <!-- jQuery Library -->
        
        <!-- Bootstrap -->
        <script src="js/bootstrap.min.js"></script>
        
        <!--  Form Related -->
        <script src="js/icheck.js"></script> <!-- Custom Checkbox + Radio -->
        
        <!-- All JS functions -->
        <script src="js/functions.js"></script>
    </body>
</html>
