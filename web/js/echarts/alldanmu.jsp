	<!DOCTYPE html>
	<%@page import="com.DanMuSafetyMonitor.bean.matableDao"%>
	<%@page import="java.sql.ResultSet"%>
	<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
	<%
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
				+ path + "/";
	%>
	
	<%
		// 	double[] data=new double[5];
		// 	data[0]=124;
		// 	data[1]=115;
		// 	data[2]=54;
		// 	data[3]=5;
		// 	data[4]=12;
	%>
	
	<meta http-equiv=Content-Type content=text/html;charset=utf-8>
	<script type="text/javascript" src="alldanmu.js"></script>
	<!-- jQuery -->
	<script src="../jquery.min.js"></script>
	<!-- jQuery Library -->
	<script src="../jquery-ui.min.js"></script>
	<!-- jQuery UI -->
	<script src="../jquery.easing.1.3.js"></script>
	<!-- jQuery Easing - Requirred for Lightbox + Pie Charts-->
	
	<body>
		<div id="bar-chart1" class="main-chart"
			style="height: 26em; width:auto;"></div>
		<script type='text/javascript'>
	/*anchor_lincharts.js*/
	
	
	
	<%-- var myData=[<%=data[0] %>,<%=data[1] %>,<%=data[2] %>,<%=data[3] %>,<%=data[4] %>]; --%>
	var myData=new Array(5);
	
	window.onload=function(){
		doAlarm()
		doPost();
		getTheData();
		setInterval("getTheData()",10000);
  		setInterval("doPost()", 10000);
	}
	
	function doAlarm(){
		var alertNumber=$("#alertNumber"); 
		var alarm=$("#alarm");
		$.post("AlarmServlet",
   			function(data,status){
    			var json=eval(data);
    			alertNumber.html(json.alarNum);
    			var arr=new Array();
	    		$.each(json,function(){
	    			arr.push('<small class="text-muted">'+json.alarList[0].theAname+'</small><br>');
	    			arr.push('<h4 id="alarType"><a class="t-overflow" href="http://localhost:8080/DanMuSafetyMonitor2/AnchorProDanMuServlet?listMAname='+json.alarList[0].theAname+'" >警告类型：'+json.alarList[0].theType+'</a></h4>');
	    		});
	    		alarm.append(arr.jion(""));
    		},"json");
	} 
	
                
   function getTheData(){
     $.post("SysInfoServlet",
   	function(data,status){
    var json=eval(data);
    $.each(json,function(){
    	
       $("#todayDanmu").html(json.AllDMnum);
       $("#todayIndex").html(json.indexDMnum);
    });
    },"json");
    }
	
	function doPost(){
		$.post("GetDanmuFenLeiServlet",
		{},
		function(data){
			var json=eval(data);
			myData[0]=json[0].sex;
			myData[1]=json[0].abuse;
			myData[2]=json[0].react;
			myData[3]=json[0].vio;
			myData[4]=json[0].other;
			myChart41.setOption(option111);
		});
	}
	
	var myChart41 = echarts.init(document.getElementById('bar-chart1'));
	// 指定图表的配置项和数据
	var option111 = {
	    color: ['#ffffff'],
	    tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    xAxis : [
	        {
	            type : 'category',
	            data : ['淫秽色情', '侮辱谩骂', '反动言论','血腥暴力', '其他犯罪'],
	            axisTick: {
	                alignWithLabel: true
	            },
				nameTextStyle: {  
	                color: ['#ffffff']  
	            }, 
				axisLine:{  
	                lineStyle:{  
	                    color:'#ffffff',  
	                    width:1.5
	                }  
	            }  
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
				nameTextStyle: {  
	                color: ['#ffffff']  
	            },  
	            axisLine:{  
	                lineStyle:{  
	                    color:'#ffffff',  
	                    width:1.5
	                }  
	            }  
	        }
	    ],
	    series : [
	        {
	            name:'出现次数',
	            type:'bar',
	            barWidth: '60%',
	            data:myData//[myData[0], myData[1], myData[2],myData[3], myData[4]]
	        }
	    ]
	};
	
	</script>
	</body>