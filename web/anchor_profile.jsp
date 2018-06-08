<%@page import="com.DanMuSafetyMonitor.bean.matable" %>
<%@page import="com.DanMuSafetyMonitor.bean.matableDao" %>
<%@ page language="java" import="java.sql.ResultSet" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<%
    if (request.getSession().getAttribute("Uname") == null) {
        response.sendRedirect("login.jsp");
    } else if (request.getSession().getAttribute("Ugrant") == null) {
        response.sendRedirect("login.jsp");
    } else {

%>
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<!-- profile-page.html -->
<html>
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <meta name="format-detection" content="telephone=no">
    <meta charset="UTF-8">

    <meta name="description" content="Violate Responsive Admin Template">
    <meta name="keywords" content="Super Admin, Admin, Template, Bootstrap">

    <title>监控主播个人界面</title>

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
    <!-- jQuery -->
    <script src="js/jquery-1.9.0.min.js"></script>

    <script>

        setInterval("doPost()", 3000);
        function doPost() {
            tableAjax();
            var MAname = $("#pageMAname").val();


            $.post("getDanMuServlet",
                {
                    listMAname: MAname
                },
                function (data, ststus) {
                    //lert(data);
                    var json = eval(data);
                    //alert(json);
                    $.each(json, function () {
                        $("#DM1").html(json.rows[0].DM);
                        $("#DM2").html(json.rows[1].DM);
                        $("#DM3").html(json.rows[2].DM);
                        $("#DM4").html(json.rows[3].DM);
                        $("#DM5").html(json.rows[4].DM);
                        $("#DM6").html(json.rows[5].DM);
                        $("#DM7").html(json.rows[6].DM);
                        $("#DM8").html(json.rows[7].DM);
                        $("#DM9").html(json.rows[8].DM);
                        $("#DM10").html(json.rows[9].DM);
                        $("#DM11").html(json.rows[10].DM);
                        $("#DM12").html(json.rows[11].DM);
                        $("#DM13").html(json.rows[12].DM);
                        $("#DM14").html(json.rows[13].DM);
                        $("#DM15").html(json.rows[14].DM);
                        $("#DM16").html(json.rows[15].DM);
                        $("#DM17").html(json.rows[16].DM);
                        $("#DM18").html(json.rows[17].DM);
                        $("#DM19").html(json.rows[18].DM);
                        $("#DM20").html(json.rows[19].DM);
                        $("#nowDMnumber").html(json.DMnumber);
                        $("#hisGrade").html(json.Hisnumber);
                        $("#nowGrade").html(json.Nownumber);
// 									$("#hisGrade").html(json.his);
// 						      		$("#nowGrade").html(json.now);
                    });
                },
                "json"//期望获得json格式
            );

        }


    </script>


</head>
<body id="skin-blur-violate">

<input type="hidden" id="path" value="${pageContext.request.contextPath}">

<header id="header" class="media">
    <a href="" id="menu-toggle"></a> <a class="logo pull-left"
                                        href="index.html">直播平台监控系统</a>

    <div class="media-body">
        <div class="media" id="top-menu">
            <div class="pull-left tm-icon">
                <a data-drawer="messages" class="drawer-toggle" href="">
                    <!----> <font color="#ffff00" size="6em"><i
                        class="fa fa-exclamation-triangle" aria-hidden="true"></i></font> <i
                        class="sa-top-message" aria-hidden="true"></i> <i
                        class="n-count animated" id="alertNumber">0</i> <span>系统警报</span>
                </a>
            </div>
            <div class="pull-left tm-icon">
                <a data-drawer="notifications" class="drawer-toggle" href="">
                    <!----> <font color="#ff0000" size="6em"><i
                        class="fa fa-question-circle" aria-hidden="true"></i></font> <i
                        class="sa-top-updates" aria-hidden="true"></i> <i
                        class="n-count animated" id="reportNumber">0</i> <span>举报投诉</span>
                </a>
            </div>


            <div id="time" class="pull-right">
                <span id="hours"></span> : <span id="min"></span> : <span id="sec"></span>
            </div>

            <div class="media-body">
                <input type="text" class="main-search" id="indexSearch">
                <!--全局搜索栏-->
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
                <a href="" data-toggle="dropdown" id="theimg"> <img
                        class="profile-pic animated" src="img/profile-pic2.jpg" alt="">
                </a>
                <ul class="dropdown-menu profile-menu">

                    <li><a href="">个人中心</a> <i class="icon left">&#61903;</i><i
                            class="icon right">&#61815;</i></li>
                    <li id="usermanager">
                        <!-- <a href="">管理用户</a> <i class="icon left">&#61903;</i><i class="icon right">&#61815;</i>-->
                    </li>

                    <li><a
                            href="${pageContext.request.contextPath}/LoginOutServlet">退出登录</a>
                        <i class="icon left">&#61903;</i><i class="icon right">&#61815;</i></li>
                </ul>
                <h4 class="m-0"><%=request.getSession().getAttribute("Uname")%>
                </h4>
                <h5 id="userIdentity">管理员</h5>
                <!--                         (int)request.getSession().getAttribute("Ugrant")==1 -->
                <%if ((int) request.getSession().getAttribute("Ugrant") == 1) { %>
                <script>
                    var umg = document.getElementById("usermanager").innerHTML = '<a href="AddAdmin.jsp">添加管理用户</a> <i class="icon left">&#61903;</i><i class="icon right">&#61815;</i>';
                    var umt = document.getElementById("userIdentity").innerHTML = '经理';
                    var umi = document.getElementById("theimg").innerHTML = '<img class="profile-pic animated" src="img/profile-pic.jpg" alt="">';

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
                <h2 class="tile-title">监控主播列表</h2>

                <div class="s-widget-body">
                    <%
                        matableDao mtd = new matableDao();
                        ResultSet rs_a = null;
                        if (request.getAttribute("searchAnchorRs") == null) {
                            rs_a = mtd.ALLSelect();
                        } else {
                            rs_a = (ResultSet) request.getAttribute("searchAnchorRs");
                        }

                        int i = 0;
                        String[] dataname = new String[50];
                        String[] datadmnum = new String[50];
                        while (rs_a.next()) {
                            dataname[i] = (String) rs_a.getString("MAname");
                            datadmnum[i] = (String) rs_a.getString("MAdmnum");
                    %>
                    <div class="side-border">
                        <small><%=rs_a.getString("MAname") %>
                        </small>
                        <div class="progress progress-small">
                            <a
                                    href="${pageContext.request.contextPath}/AnchorProDanMuServlet?listMAname=<%=rs_a.getString("MAname") %>"
                                    data-toggle="tooltip" title=""
                                    class="tooltips progress-bar progress-bar-info"
                                    style="width: 60%;" data-original-title="60%"> <span
                                    class="sr-only">60% Complete</span>
                            </a>
                        </div>
                    </div>
                    <%
                            i++;
                        }
                        rs_a.close(); %>
                    <!--progress-bar tooltips progress-bar-danger-->
                    <!--tooltips progress-bar progress-bar-warning -->
                    <!--tooltips progress-bar progress-bar-info -->
                    <!--tooltips progress-bar progress-bar-success -->
                </div>
            </div>
        </div>

        <!-- Side Menu -->
        <ul class="list-unstyled side-menu">
            <li class="active"><a class="sa-side-home" href="index.jsp">
                <span class="menu-item">主页</span>
            </a></li>
            <li><a class="sa-side-typography" href="list_anchor.jsp"> <span
                    class="menu-item">监控主播列表</span>
            </a></li>
            <li><a class="sa-side-widget" href="list_video.jsp"> <span
                    class="menu-item">监控主播视频列表</span>
            </a></li>
            <li><a class="sa-side-table" href="list_BanAnchor.jsp"> <span
                    class="menu-item">禁播列表</span>
            </a></li>

            <li><a class="sa-side-chart" href="list_DMinfo.jsp"> <span
                    class="menu-item">弹幕信息</span>
            </a></li>
            <li><a class="sa-side-folder" href="SysReport.jsp"> <span
                    class="menu-item">系统报告</span>
            </a></li>
            <li><a class="sa-side-calendar" href="calendar.html"> <span
                    class="menu-item">安全日志</span>
            </a></li>
            <li class="dropdown"><a class="sa-side-page" href=""> <span
                    class="menu-item">警报/投诉</span>
            </a>
                <ul class="list-unstyled menu-item">
                    <li><a data-drawer="messages" href="#">警报列表</a></li>
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
                    <a href="">系统对于主播行为的警告</a> <span class="drawer-close">&times;</span>

                </div>
                <div class="overflow" style="height: 20em">
                    <div class="media">
                        <div class="pull-left">
                            <!-- <img width="40" src="img/profile-pics/1.jpg" alt="">-->
                            <font color="#ffff00"><i
                                    class="fa fa-exclamation-triangle fa-2x" aria-hidden="true"></i></font>
                        </div>
                        <div class="media-body">
                            <small class="text-muted">用户名</small>
                            <br> <a
                                class="t-overflow" href="">警告类型、频繁出现关键词</a>
                        </div>
                    </div>
                </div>
                <div class="media text-center whiter l-100">
                    <a href="">
                        <small>显示全部</small>
                    </a>
                </div>
            </div>
        </div>
        <!--Messages link-->

        <!-- Notification Drawer -->
        <div id="notifications" class="tile drawer animated">
            <div class="listview narrow">
                <div class="media">
                    <a href="">用户对于主播的举报列表</a> <span class="drawer-close">&times;</span>
                </div>
                <div class="overflow" style="height: 20em">
                    <div class="media">
                        <div class="pull-left">
                            <!--<img width="40" src="img/profile-pics/1.jpg" alt="">-->
                            <font color="#ff0000"><i
                                    class="fa fa-question-circle fa-2x" aria-hidden="true"></i></font>
                        </div>
                        <div class="media-body">
                            <small class="text-muted">被举报用户</small>
                            <br> <a
                                class="t-overflow" href="">举报内容</a>
                        </div>
                    </div>
                </div>
                <div class="media text-center whiter l-100">
                    <a href="">
                        <small>显示全部</small>
                    </a>
                </div>
            </div>
        </div>
        <!--report end-->

        <!-- Breadcrumb -->
        <ol class="breadcrumb hidden-xs">
            <li><a href="#">主页</a></li>
            <li><a href="#">监控主播列表</a></li>
            <li class="active">主播个人状态</li>
        </ol>

        <%
            matable mt = new matable();
            if (request.getAttribute("mt") == null) {
                mt.setMAname("未能获取到");
                mt.setMAroom("未能获取到");
                mt.setMAstate("未能获取到");

            } else {
                mt = (matable) request.getAttribute("mt");
            }
        %>
        <input type="hidden" name="pageMAname" id="pageMAname"
               value="<%=mt.getMAname()%>">
        <h4 class="page-title"><%=mt.getMAname() %>主播的监控列表
        </h4>

        <div class="block-area">
            <div class="row">
                <div class="col-md-9">
                    <div class="tile-light p-5 m-b-15">
                        <div class="cover p-relative">
                            <!-- <img src="img/cover-bg.jpg" class="w-100" alt=""> -->
                            <div class="tile">
                                <h2 class="tile-title">主播弹幕数量实时数据</h2>
                                <div class="tile-config dropdown">
                                    <a data-toggle="dropdown" href="" class="tooltips tile-menu"
                                       title="Options"></a>
                                    <ul class="dropdown-menu pull-right text-right">
                                        <li><a href="">刷新</a></li>
                                        <li><a href="">设置</a></li>
                                    </ul>
                                </div>
                                <!-- 									<div class="p-10"> -->
                                <!-- 										<div id="dynamic-chart" class="main-chart" -->
                                <!-- 											style="height: 250px"></div> -->
                                <!-- 										<div class="main-chart" style="height: 30.1em"></div> -->
                                <%-- 										<jsp:include page="js/echarts/anchor_DongtaiData.jsp"></jsp:include> --%>
                                <!-- 									</div> -->
                                <div id="dynamicchart2" class="main-chart" style="height: 30em"></div>
                                <script src="js/echarts/anchor_DongtaiData2.js"></script>

                            </div>
                        </div>

                        <div class="profile-btn">
                            <button class="btn btn-alt btn-sm">
                                <a data-drawer="messages" class="drawer-toggle" href=""> <i
                                        class="icon-bubble"></i> <span>该主播今日系统报警数：0</span>
                                </a>
                            </button>
                            <button class="btn btn-alt btn-sm">
                                <a data-drawer="notifications" class="drawer-toggle" href="">
                                    <i class="icon-user-2"></i> <span>该主播今日用户举报数：0</span>
                                </a>
                            </button>
                        </div>
                    </div>
                    <div class="p-8 m-t-15">
                        <br> <span
                            style="font-size:1.5em">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;监控主播：<%=mt.getMAname() %></span>
                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span
                            style="font-size:1.5em">在线状态：<%=mt.getMAstate() %></span> <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span
                            style="font-size:1.5em">房间号：<%=mt.getMAroom() %></span>
                        <button class="btn btn-sm"
                                onclick="OpenAnchorPageOf('https://www.douyu.com//<%=mt.getMAroom() %>')">打开房间
                        </button>

                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span
                            style="font-size:1.5em">操作建议：</span><a href="" target="_blank">
                        <button
                                class="btn btn-sm">设置禁言
                        </button>
                    </a>
                    </div>

                    <div class="col-md-4 col-xs-6">
                        <div>
                            <br>
                        </div>
                        <div class="tile quick-stats media">

                            <div id="stats-line-4" class="pull-left"></div>

                            <div class="media-body">
                                <h2 id="nowDMnumber"><%=mt.getMAdmnum() %>
                                </h2>
                                <!--data-value="7.0"-->
                                <small>主播当前弹幕数量</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-xs-6">
                        <div>
                            <br>
                        </div>
                        <div class="tile quick-stats media">
                            <div id="stats-line" class="pull-left"></div>
                            <div class="media-body">
                                <h2 id="hisGrade"><%=mt.getMAhis() %>
                                </h2>
                                <small>主播当历史评分</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-xs-6">
                        <div>
                            <br>
                        </div>
                        <div class="tile quick-stats media">
                            <div id="stats-line" class="pull-left"></div>
                            <div class="media-body">
                                <h2 id="nowGrade"><%=mt.getMAnow() %>
                                </h2>
                                <small>主播当前消极评分</small>
                            </div>
                        </div>
                    </div>

                    <script>
                        function tableAjax() {
                            var path = $("#path").val();
                            theroom = <%=mt.getMAroom() %>;
                            $.ajax({
                                type: "POST",
                                url: path + "/GetAnchorPercentageServlet",
                                dataType: 'json',
                                data: {
                                    room : theroom
                                },
                                success: function (data) {
                                    $("#prefer").html(data.prefer);
                                    $("#sex").html(data.sex + "\%");
                                    $("#abuse").html(data.abuse + "\%");
                                    $("#react").html(data.react + "\%");
                                    $("#violence").html(data.violence + "\%");
                                    $("#other").html(data.other + "\%");
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {

                                }
                            });
                        }
                    </script>

                    <div class="col-md-12">

                        <h2 class="tile-title">该主播历史弹幕中出现的主要敏感词分类</h2>

                        <div class="table-responsive overflow">
                            <table class="table tile">

                                <thead>
                                <tr>
                                    <th>偏向</th>
                                    <th>色情淫秽</th>
                                    <th>侮辱谩骂</th>
                                    <th>反动言论</th>
                                    <th>血腥暴力</th>
                                    <th>其他犯罪</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td id="prefer">正常</td>
                                    <td id="sex">0%</td>
                                    <td id="abuse">0%</td>
                                    <td id="react">0%</td>
                                    <td id="violence">0%</td>
                                    <td id="other">0%</td>
                                </tr>
                                </tbody>
                            </table>

                        </div>
                    </div>
                    <!--col-md-12-->

                    <%--<div class="row">--%>


                        <%--<div class="col-md-12">--%>
                            <%--<div class="tile">--%>
                                <%--<h2 class="tile-title">该主播本周评分汇总</h2>--%>
                                <%--<div class="tile-config dropdown">--%>
                                    <%--<a data-toggle="dropdown" href="" class="tooltips tile-menu"--%>
                                       <%--title="" data-original-title="Options"></a>--%>
                                    <%--<ul class="dropdown-menu pull-right text-right">--%>
                                        <%--<li><a href="#" onclick="OpenAnchorPage()">刷新</a></li>--%>
                                        <%--<li><a href="#" onclick="CloseAnchorPage()">关闭</a></li>--%>
                                    <%--</ul>--%>
                                <%--</div>--%>

                                <%--<div class="p-10">--%>
                                    <%--<div style="width:60.1em; height: 28.1em">--%>
                                        <%--<jsp:include page="js/echarts/anchor_lincharts.jsp"></jsp:include>--%>
                                    <%--</div>--%>

                                    <%--<div class="media p-5 text-center l-100">--%>

                                        <%--<button class="btn btn-sm" onclick="changeEchartslin('lin')">查看本周评分走势</button>--%>
                                        <%--<button class="btn btn-sm" onclick="changeEchartsbar('bar')">查看各类敏感词占比</button>--%>
                                        <%--<!-- 											<script src="js/echarts/anchor_lincharts.js"></script> -->--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                            <%--</div>--%>

                        <%--</div>--%>


                    <%--</div>--%>

                </div>

                <div class="col-md-3">
                    <!-- pei-charts -->
                    <div class="tile">
                        <h2 class="tile-title">敏感词占比</h2>
                        <div class="listview narrow">
                            <div style="width:28.1em;height:28.1em" id="anchor_peicharts">
                                <jsp:include page="js/echarts/anchor_peichart.jsp"></jsp:include>
                            </div>
                        </div>
                    </div>
                    <!-- DanMu -->
                    <div class="tile">
                        <h2 class="tile-title">实时弹幕</h2>
                        <div class="tile-config dropdown">
                            <a data-toggle="dropdown" href="" class="tooltips tile-menu"
                               title="Options"></a>
                            <ul class="dropdown-menu pull-right text-right">
                                <li>
                                    <button class="btn" onclick="doPost()">刷新</button>
                                </li>
                            </ul>
                        </div>
                        <div class="listview icon-list" id="DMcontent">
                            <div class="media">
                                <div class="media-body" id="DM1">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM2">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM3">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM4">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM5">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM6">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM7">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM8">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM9">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM10">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM11">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM12">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM13">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM14">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM15">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM16">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM17">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM18">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM19">加载中···</div>
                            </div>

                            <div class="media">
                                <div class="media-body" id="DM20">加载中···</div>
                            </div>
                        </div>
                    </div>
                    <!-- DanMu -->


                </div>


            </div>
        </div>

        <br/>
        <br/>
        <br/>
        </div>
    </section>
</section>

<!-- Javascript Libraries -->

<!-- jQuery Library -->

<!-- Bootstrap -->
<script src="js/bootstrap.min.js"></script>

<!-- UX -->
<script src="js/scroll.min.js"></script>
<!-- Custom Scrollbar -->

<!-- Other -->
<script src="js/calendar.min.js"></script>
<!-- Calendar -->
<script src="js/weather.min.js"></script>
<!-- Weather -->
<script src="js/feeds.min.js"></script>
<!-- News Feeds -->

<!-- All JS functions -->
<script src="js/functions.js"></script>
<script src="js/myScript.js"></script>
</body>
</html>


<%} %>
