<!DOCTYPE html>
<%@page import="com.DanMuSafetyMonitor.bean.matableDao"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% 
 String path = request.getContextPath();
 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	double value1=521;
	double value2=111;
	double value3=251;
	double value4=653;
	double value5=451;
	double value6=515;
%>

<meta http-equiv=Content-Type content=text/html;charset=utf-8>
<script type="text/javascript"  src="anchor_lincharts.js"></script> 

<body>
<div style="width:28em;height:28em" id="anchor_peicharts"></div>
<script type='text/javascript'>
/*anchor_lincharts.js*/

var value1=<%= value1 %>,value2=<%= value2 %>,value3=<%= value3 %>;
var value4=<%= value4 %>,value5=<%= value5 %>,value6=<%= value6 %>;

var myChart42 = echarts.init(document.getElementById('anchor_peicharts'));
var option112 = {
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },

    visualMap: {
        show: false,
        min: 80,
        max: 600,
        inRange: {
            colorLightness: [0, 1]
        }
    },
    series : [
        {
            name:'主播行为',
            type:'pie',
            radius : '55%',
            center: ['50%', '50%'],
            data:[
                {value:value1, name:'淫秽色情'},
                {value:value2, name:'侮辱谩骂'},
                {value:value3, name:'反动言论'},
                {value:value4, name:'血腥暴力'},
                {value:value5, name:'其他违法'},
                {value:value6, name:'正常'},
            ].sort(function (a, b) { return a.value - b.value; }),
            roseType: 'radius',
            label: {
                normal: {
                    textStyle: {
                        color: 'rgba(255, 255, 255, 0.3)'
                    }
                }
            },
            labelLine: {
                normal: {
                    lineStyle: {
                        color: 'rgba(255, 255, 255, 0.3)'
                    },
                    smooth: 0.2,
                    length: 10,
                    length2: 20
                }
            },
            itemStyle: {
                normal: {
                    color: '#c23531',
                    shadowBlur: 200,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            },

            animationType: 'scale',
            animationEasing: 'elasticOut',
            animationDelay: function (idx) {
                return Math.random() * 200;
            }
        }
    ]
};

myChart42.setOption(option112);

</script>
</body>