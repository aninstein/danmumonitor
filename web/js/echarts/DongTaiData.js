var myChart = echarts.init(document.getElementById('dynamic-chart1'));
function randomData() {
    now = new Date(+now + oneDay);
    value = value + Math.random() * 21 - 10;
    return {
        name: now.toString(),
        value: [
            [now.getFullYear(), now.getMonth() + 1, now.getDate()].join('/'),
            Math.round(value)
        ]
    }
}

var data = [];
var now = +new Date(1997, 9, 3);
var oneDay = 24 * 3600 * 1000;
var value = Math.random() * 1000;
for (var i = 0; i < 1000; i++) {
    data.push(randomData());
}

option = {
    tooltip: {
        trigger: 'axis',
        formatter: function (params) {
            params = params[0];
            var date = new Date(params.name);
            return date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear() + ' : ' + params.value[1];
        },
        axisPointer: {
            animation: false
        }
    },
   xAxis: {
        type: 'time',
        splitLine: {
            show: false
        },
		nameTextStyle: {  
                color: ['#ffffff'],
                width:2
            }, 
        axisLine:{  
            lineStyle:{  
                color:'#ffffff',  
                width:2
            }  
        } 
    },
    yAxis: {
        type: 'value',
        boundaryGap: [0, '100%'],
        splitLine: {
            show: false
        },
		nameTextStyle: {  
                color: ['#ffffff'],
                width:1
            },  
        axisLine:{  
            lineStyle:{  
                color:'#ffffff',  
                width:1
            }  
        } 
    },
    series: [{
        lineStyle:{
            normal:{
                width:2,  //连线粗细
                color: "#fff"  //连线颜色
            }
        },
        name: '弹幕数量',
        type: 'line',
        showSymbol: false,
        hoverAnimation: false,
        data: data
    }]
};

setInterval(function () {

    for (var i = 0; i < 5; i++) {
        data.shift();
        data.push(randomData());
    }

    myChart.setOption({
        series: [{
            data: data
        }]
    });
}, 10000);
myChart.setOption(option);