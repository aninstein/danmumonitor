function OpenAnchorPage(){//打开视频
	var iframe1=document.getElementById("OpenAnchorPage").innerHTML='<iframe src="https://v.6.cn/3330?" width="1200px" height="540px" name="iframe1" scrolling="no"/>'; 
	location.hash="#OpenAnchorPage";  
}
function CloseAnchorPage(){//关闭视频
	var iframe2=document.getElementById("OpenAnchorPage").innerHTML='当前没有视频'; 
	location.replace(location.href);
	location.hash="#OpenAnchorPage";  
}
/*
function OpenAnchorPageOf(divId,iframeUrl){//在本页面打开视频，斗鱼不行
	// alert("这是"+divId+"和"+iframeUrl);
	var iframe1=document.getElementById(divId).innerHTML='<iframe src='+iframeUrl+' width="1200px" height="540px" name="iframe1" scrolling="no"/>'; 
	location.hash="#"+divId;  
}
function CloseAnchorPageOf(divId){//关闭本页面视频，斗鱼不行
	var iframe2=document.getElementById(divId).innerHTML=' '; 
	location.replace(location.href);
	location.hash="#"+divId;    
}
*/

function OpenAnchorPageOf(iframeUrl){//新窗口打开视频，适合斗鱼
	window.open(iframeUrl,'_blank','width=1200px,height=640px,menubar=no,toolbar=no, status=no,scrollbars=yes') 
}

function changeEchartsLinToBar(type){//切换柱状图和线图
document.write('<script src="js/echarts/anchor_'+type+'charts.js"></script>'); 
}