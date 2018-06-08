<!DOCTYPE html>
<%@page import="com.DanMuSafetyMonitor.bean.matableDao"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% 
 String path = request.getContextPath();
 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<meta http-equiv=Content-Type content=text/html;charset=utf-8>
<script type="text/javascript"  src="anchor_lincharts.js"></script>
<script  type="text/javascript" src="echarts.min.js"></script>  

<body>
<div id="anchor_DongtaiData" class="main-chart" style="height: 30em"></div>
<script type='text/javascript'>

var dynamicchart2 = echarts.init(document.getElementById('anchor_DongtaiData'));

var option50 = {
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        data: '弹幕数量'
    },
    dataZoom: {
        show: false,
        start: 0,
        end: 100
    },
    xAxis: [
        {
            type: 'category',
            boundaryGap: true,
            data: (function (){
                var now = new Date();
                var res = [];
                var len = 10;
                while (len--) {
                    res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
                    now = new Date(now - 2000);
                }
                return res;
            })()
        },
        {
            type: 'category',
            boundaryGap: true,
            data: (function (){
                var res = [];
                var len = 10;
                while (len--) {
                    res.push(len + 1);
                }
                return res;
            })()
        }
    ],
    yAxis: [
        {
            type: 'value',
            scale: true,
            name: '弹幕数量',
            boundaryGap: [0.2, 0.2]
        },
        {
            type: 'value',
            scale: true,
            name: '评分趋势',
            boundaryGap: [0.2, 0.2]
        }
    ],
    series: [
        {
            name:'弹幕数量',
            type:'bar',
            itemStyle:{
				normal:{
					width:5,  //连线粗细
					color: "#FFF"  //连线颜色
				}
			},
            xAxisIndex: 1,
            yAxisIndex: 1,
            data:(function (){
                var res = [];
                var len = 10;
                while (len--) {
                    res.push(Math.round(Math.random() * 1000));
                }
                return res;
            })()
        },
        {
            name:'最平均评分情况',
            type:'line',
            lineStyle:{
				normal:{
					width:5,  //连线粗细
					color: "#F25B3D"  //连线颜色
				}
			},
            data:(function (){
                var res = [];
                var len = 0;
                while (len < 10) {
                    res.push((Math.random()*10 + 5).toFixed(1) - 0);
                    len++;
                }
                return res;
            })()
        }
    ]
};
app.count = 11;
setInterval(function (){
    axisData = (new Date()).toLocaleTimeString().replace(/^\D*/,'');

    var data0 = option.series[0].data;
    var data1 = option.series[1].data;
    data0.shift();
    data0.push(Math.round(Math.random() * 1000));
    data1.shift();
    data1.push((Math.random() * 10 + 5).toFixed(1) - 0);

    option.xAxis[0].data.shift();
    option.xAxis[0].data.push(axisData);
    option.xAxis[1].data.shift();
    option.xAxis[1].data.push(app.count++);

    dynamicchart2.setOption(option50);
    
    
}, 3000);



</script>
</body>