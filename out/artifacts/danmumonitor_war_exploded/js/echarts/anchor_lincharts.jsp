<!DOCTYPE html>
<%@page import="com.DanMuSafetyMonitor.bean.matableDao"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% 
 String path = request.getContextPath();
 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	double[] data=new double[7];
	data[0]=0.39;
	data[1]=0.74;
	data[2]=0.58;
	data[3]=0.45;
	data[4]=0.65;
	data[5]=0.66;
	data[6]=0.69;
	
%>

<meta http-equiv=Content-Type content=text/html;charset=utf-8>
<script type="text/javascript"  src="echarts.min.js"></script> 

<body>
<div id="weekOfanchor1" style="width=60em; height: 28em"></div>
<script type='text/javascript'>
/*anchor_lincharts.js*/

var myData=[<%=data[0] %>,<%=data[1] %>,<%=data[2] %>,<%=data[3] %>,<%=data[4] %>,<%=data[5] %>,<%=data[6] %>];

var myChart40 = echarts.init(document.getElementById('weekOfanchor1'));
var option110 = {
	title: {
        text: '本周评分走势',
        textStyle: {
			color:'#ffffff'
		}
    },
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        data:['最高评分','最低评分']
    },
    xAxis:  {
        type: 'category',
        boundaryGap: false,
        data: ['周一','周二','周三','周四','周五','周六','周日'],
		nameTextStyle: {  
                color: ['#ffffff'],
                width:2
            }, 
        axisLine:{  
            lineStyle:{  
                color:'#ffffff',  
                width:3
            }  
        } 
    },
    yAxis: {
        type: 'value',
        axisLabel: {
            formatter: '{value}'
        },
		nameTextStyle: {  
                color: ['#ffffff'],
                width:1
            },  
        axisLine:{  
            lineStyle:{  
                color:'#ffffff',  
                width:3
            }  
        } 
    },
    series: [
        {
			lineStyle:{
				normal:{
					width:5,  //连线粗细
					color: "#fff"  //连线颜色
				}
			},
            name:'本周评分走势',
            type:'line',
            data:myData,
            markPoint: {
                data: [
                    {type: 'max', name: '最大值'},
                    {type: 'min', name: '最小值'},
                ],
                itemStyle:{
    				normal:{
    					width:3,  //连线粗细
    					color: "#fff"  //连线颜色
    				}
			    }
            },
            markLine: {
                data: [
                    {type: 'average', name: '平均值'}
                ],
                lineStyle:{
    				normal:{
    					width:3,  //连线粗细
    					color: "#fff"  //连线颜色
    				}
			    }
            }
        }
    ]
};

myChart40.setOption(option110);

</script>
</body>
