var myChart = echarts.init(document.getElementById('bar-chart1'));
// 指定图表的配置项和数据
var option = {
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
            data : ['淫秽色情', '侮辱谩骂', '反动言论','血腥暴力','诱导诈骗', '自杀虐待', '其他犯罪'],
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
            data:[10, 52, 200, 334, 390, 330, 220]
        }
    ]
};
myChart.setOption(option);