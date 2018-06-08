
var myChart = echarts.init(document.getElementById('dynamic-chart1'));
var option = {
	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['评分趋势', '实时弹幕数量']
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
	            data: XAxis1(),//在XAxis1（）中获取时间
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
	        {
	            type: 'category',
	            boundaryGap: true,
	            data: XAxis2(),
	            nameTextStyle: {  
	                color: ['#F25B3D'],
	                width:2
	            }, 
	            axisLine:{  
	            lineStyle:{  
	                color:'#ffffff',  
	                width:3
	            }  
	        } 
	        }
	    ],
	    yAxis: [
	        {
	            type: 'value',
	            scale: true,
	            name: '评分趋势',
	            boundaryGap: [0.2, 0.2],
	            nameTextStyle: {  
	                color: ['#F25B3D'],
	                width:1
	            },  
	            axisLine:{  
	            lineStyle:{  
	                color:'#F25B3D',  
	                width:3
	            }  
	        } 
	        },
	        {
	            type: 'value',
	            scale: true,
	            name: '弹幕数量',
	            boundaryGap: [0.2, 0.2],
	            nameTextStyle: {  
	                color: ['#FFF'],
	                width:1
	            },  
	            axisLine:{  
	            lineStyle:{  
	                color:'#FFF',  
	                width:3
	            }  
	        } 
	        }
	    ],
	    series: [
	        {
	            name:'实时弹幕数量',
	            type:'bar',
	            xAxisIndex: 1,
	            yAxisIndex: 1,
	            data:data1(),
	            itemStyle:{
					normal:{
						width:5,  //连线粗细
						color: "#FFF"  //连线颜色
					}
				},
	        },
	        {
	            name:'评分趋势',
	            type:'line',
	            data:data2(),
	            lineStyle:{
					normal:{
						width:5,  //连线粗细
						color: "#F25B3D"  //连线颜色
					}
				},
	        }
	    ]
	};
	var count = 1;
	setInterval(display, 10000);//每隔10秒执行一次dispaly
	function display(){
	    axisData = (new Date()).toLocaleTimeString().replace(/^\D*/,'');
	    var data0 = option.series[0].data;
	    var data1 = option.series[1].data;
	    data0.shift();
	    data0.push(Math.round(Math.random() * 10));
	    data1.shift();
	    data1.push((Math.random() * 10 + 5).toFixed(1) - 0);
	    option.xAxis[0].data.shift();
	    option.xAxis[0].data.push(axisData);
	    option.xAxis[1].data.shift();
	    option.xAxis[1].data.push(count);
	    myChart.setOption(option);

	}
	function XAxis1(){
		var now = new Date();
        var res = [];
        var len = 10;
        while (len--) {
            res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
            now = new Date(now - 2000);
        }
        return res;
	}
	function XAxis2(){
		var res = [];
        var len = 10;
        while (len--) {
            res.push(len + 1);
        }
        return res;
	}
	
	function getDongTaiData(){
		var allDMnum=15;
//		$.post("SysInfoServlet",{},
//			 function(data,status){
//			alert("allDMnum");
//			    var json=eval(data);
//				    $.each(json,function(){
//				       allDMnum=number(json.AllDMnum);
//				    });
//			    },
//			    "json");
		return allDMnum;
	}
	
	function data1(){
		var res = [];
        var len = 0;
        while (len < 10) {
            res.push((RandomNumBoth(1,20)).toFixed(1) - 0);
            len++;
        }
        return res;
	}
	function data2(){
		var res = [];
        var len = 0;
        while (len < 10) {
            res.push((RandomNumBoth(1,20)).toFixed(1) - 0);
            len++;
        }
        return res;
	}
	function RandomNumBoth(Min,Max){       
	    var Range = Max - Min;       
	    var Rand = Math.random();      
	    var num = Min + Math.round(Rand * Range); //四舍五入      
	    return num;
	 } 