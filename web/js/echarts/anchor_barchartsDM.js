/*anchor_barcharts.js*/

var myChart5 = echarts.init(document.getElementById('weekOfanchor3'));
var option7 = {
    color: ['#ffffff'],
	title: {
        text: '本周各类敏感词次数',
        textStyle: {
			color:'#ffffff'
		}
    },
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
            data : ['淫秽色情', '侮辱谩骂', '反动言论', '血腥暴力', '其他违法'],
            axisTick: {
                alignWithLabel: true
            },
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
        }
    ],
    yAxis : [
        {
            type : 'value',
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
        }
    ],
    series : [
        {
            name:'词条数量',
            type:'bar',
            barWidth: '60%',
            data:[2548, 3552, 578, 878, 970]
        }
    ]
};
myChart5.setOption(option7);