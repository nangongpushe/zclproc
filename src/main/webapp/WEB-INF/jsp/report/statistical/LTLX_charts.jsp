<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!-- echarts Js -->
<script src="${ctx}/js/echarts.min.js"></script>



<div class="row clear-m">
	<ol class="breadcrumb">
		<li>报表台账</li>
		<li>统计分析</li>
		<li class="active">流通流向</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	<div class="layui-form">
			地区：
			<div class="layui-inline">
		          <select id="province" name="province" class="layui-select layui-input" style="width:165px">
		            	<option value="beijing" select>北京</option>
                        <option value="tianjin">天津</option>
                        <option value="hebei">河北</option>
                        <option value="shanxi">山西</option>
                        <option value="neimenggu">内蒙古</option>
                        <option value="liaoning">辽宁</option>
                        <option value="jinli">吉林</option>
                        <option value="heilongjian">黑龙江</option>
                        <option value="shanghai">上海</option>
                        <option value="jiangsu">江苏</option>
                        <option value="anhui">安徽</option>
                        <option value="fujian">福建</option>
                        <option value="jiangxi">江西</option>
                        <option value="shandong">山东</option>
                        <option value="henan">河南</option>
			            <option value="hubei">湖北</option>
                        <option value="hunan">湖南</option>
                        <option value="guangdong">广东</option>
                        <option value="guangxi">广西</option>
                        <option value="hainan">海南</option>
                        <option value="chongqing">重庆</option>
                        <option value="sichuan">四川</option>
                        <option value="guizhou">贵州</option>
                        <option value="yunnan">云南</option>
                        <option value="xizang">西藏</option>
                        <option value="shanXi">陕西</option>
                        <option value="jiangsu">甘肃</option>
                        <option value="qinghai">青海</option>
                        <option value="ningxia">宁夏</option>
                        <option value="xinjiang">新疆</option>
                        <option value="zhejiang">浙江</option>
		          </select>
			</div>

			统计方式：
            <div class="layui-inline">
              <input type="radio" name="time" value="year" title="年"  lay-filter="time">
              <input type="radio" name="time" value="month" title="月" checked="" lay-filter="time">
            </div>
         	开始时间：
			<div class="layui-inline" id="startTimeDiv">
				<input class="layui-input" name="startTime" id="startTime" autocomplete="off" lay-filter="rangTime">
			</div>
			结束时间：
			<div class="layui-inline" id="endTimeDiv">
				<input class="layui-input" name="endTime" id="endTime" autocomplete="off" lay-filter="rangTime">
			</div>
			<button class="layui-btn layui-btn-primary layui-btn-small" id="reloadcharts" onclick="reloadcharts();">查询</button>
	
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
	
	  <div class="layui-row layui-col-space5">
		    <div  class="layui-col-md6">
		      <div class="grid-demo" id="aa" style="height: 400px;border: 1px solid #ddd;"></div>
		    </div>
		    <div class="layui-col-md6">
		      <div class="grid-demo" id="bb" style="height: 400px; border: 1px solid #ddd;"></div>
		    </div>
	  </div>

<script>

layui.use(['form','laydate'], function(){
  var form = layui.form;
  var laydate = layui.laydate;
  form.render();
   	laydate.render({
	    elem: '#startTime'
	    ,type: 'month'
	    ,value:'2017-01'
	  });
 	  laydate.render({
	    elem: '#endTime'
	    ,type: 'month'
	    ,value:'2018-01'
	  });
	  
 //执行一个laydate实例

  //各种基于事件的操作，下面会有进一步介绍

    form.on('radio(time)', function(data){

        // 将input移除
        $("#startTimeDiv,#endTimeDiv").empty();


        // 重新渲染
        $("#startTimeDiv").append("<input class=\"layui-input\" name=\"startTime\" id=\"startTime\" autocomplete=\"off\" lay-filter=\"rangTime\">");
        $("#endTimeDiv").append("<input class=\"layui-input\" name=\"endTime\" id=\"endTime\" autocomplete=\"off\" lay-filter=\"rangTime\">");

        if(data.value=="month") {
            laydate.render({
                elem: '#startTime'
                , type: 'month'
                , value: '2017-01'
            });
            laydate.render({
                elem: '#endTime'
                , type: 'month'
                , value: '2018-01'
            });
        }else{
            laydate.render({
                elem: '#startTime'
                ,type: 'year'
                ,value:'2017'
            });
            laydate.render({
                elem: '#endTime'
                ,type: 'year'
                ,value:'2018'
            });
        }
        form.render();
        // console.log(data.elem); //得到radio原始DOM对象
        // console.log(data.value); //被点击的radio的value值
    });

});


$(document).ready(function(e){
 	$('#reloadcharts').click(); //触发AJAX事件
  } ) 


function reloadcharts(){
var barCount = [];
var pieCount = [];
var pieLegend = [];
	$.ajax({
		  type: "POST",
             url: "${ctx}/charts/getLTLXCharts.shtml",
             data: {province:$("#province").val(),startTime:$("#startTime").val(),endTime:$("#endTime").val(),time:$('input:radio:checked').val()},
             dataType: "json",
             success: function(data){   
             	  var province = $("#province").val();
             	  var startTime = $("#startTime").val();
             	  var endTime = $("#endTime").val();
             	  var provinceChinese = $("#province").find("option:selected").text();
                   var form = layui.form;
                  var type =  $('input:radio:checked').val();
                  var xAxisData = [];
                  var title = provinceChinese+"地区流通流向统计分析"
                  var goujinObj = new Object();
                   goujinObj.name = '省外购进';
                   goujinObj.type = 'line';
                   goujinObj.data = [];
                  var xiaowangObj = new Object();
                   xiaowangObj.name = '销往省外';
                   xiaowangObj.type = 'line';
         	       xiaowangObj.data = [];
         	       
         	       
         	       
//---------------------折线图数据------------------------------------
             	 $.each(data.reportXwsws, function(commentIndex, comment){
				      if($.inArray(comment.support, xAxisData)!=-1){  			      		                		 	
                  		}else{
                  			xAxisData.push(comment.support)
                  		}
                  		
        		        if(comment.reportName=='销往省外'){
        		        	if(comment[province]==null||comment[province]==""){
        		        		xiaowangObj.data.push("0");
        		        	}else{
        		        		xiaowangObj.data.push(comment[province]);
        		        	}            	 			
             	 		}if(comment.reportName=='省外购进'){
             	 			if(comment[province]==null||comment[province]==""){
        		        		goujinObj.data.push("0");
        		        	}else{
        		        		goujinObj.data.push(comment[province]);
        		        	}
             	 		}if(comment.reportName==''||comment.reportName==null){
             	 			xiaowangObj.data.push("0");
             	 			goujinObj.data.push("0");
             	 		}
             	 })
             	 
 //-----------------------------------------------右边柱状图填充-----------------------------------      	 
                 var xw_data =[];
                 var gj_data = [];
                 var bar_xAxisData =[];
                 var gj_name=[];
                 var zj_xw_data="";
                 var zj_gj_data="";

                 $.each(data.reportXwswResultVOs, function(commentIndex, comment){
                     console.log(bar_xAxisData)
                     if(!$.inArray(dict_city[comment.city], bar_xAxisData)!=-1&&bar_xAxisData.length<5){
                         if(comment.city!="ZHEJIANG"){
                             bar_xAxisData.push(dict_city[comment.city]);
                             gj_name.push(comment.city);
                         }

                     }
                     if($.inArray(dict_city[comment.city], bar_xAxisData)!=-1&&comment.reportName == '省外购进'){
                         gj_data.push(comment.total)
                     }

                     if($.inArray(dict_city[comment.city], bar_xAxisData)!=-1&&comment.reportName == '销往省外'){
                         if(gj_name[0]==comment.city) xw_data[0]=comment.total;
                         if(gj_name[1]==comment.city) xw_data[1]=comment.total;
                         if(gj_name[2]==comment.city) xw_data[2]=comment.total;
                         if(gj_name[3]==comment.city) xw_data[3]=comment.total;
                         if(gj_name[4]==comment.city) xw_data[4]=comment.total;
                         if(gj_name[5]==comment.city) xw_data[5]=comment.total;
                     }

                     if(comment.city=="ZHEJIANG"){
                         if(comment.reportName == '销往省外')
                             zj_xw_data =  comment.total;
                         if(comment.reportName == '省外购进')
                             zj_gj_data = comment.total;
                     }
                 })
                 bar_xAxisData.push("浙江");
                 xw_data.push(zj_xw_data);
                 gj_data.push(zj_gj_data);


// -----------------------------------------------折线图数据填充--------------------------------
	 			option = {
		 			title: {
		 				left: 'center',
				        text: title
				    },
				    tooltip: {
				        trigger: 'axis'
				    },
				    legend: {
				     	 x : 'center',
    		 			 y : 'bottom',
				        data:['销往省外','省外购进']
				    },
				    grid: {
	                    left: '3%',
	                    right: '6%',
	                    bottom: '10%',
	                    top: '10%',
	                    containLabel: true
	                },
				    toolbox: {
				        show: true
				    },
				    xAxis:  {
				        type: 'category',
				        boundaryGap: false,
				        data: xAxisData
				    },
				    yAxis: {
				        type: 'value',
				        axisLabel: {
				            formatter: '{value}'
				        }
				    },
				    series: [
				        xiaowangObj,goujinObj
				    ]
				};
				var myChartbar = echarts.init(document.getElementById('aa'));
		        // 使用刚指定的配置项和数据显示图表。
				 myChartbar.setOption(option);
// -----------------------------------------------折线图数据填充完成--------------------------------


// -----------------------------------------------柱状图数据填充--------------------------------
   // 指定图表的配置项和数据
              var optionbar = {
                tooltip: {},
                title: {
                		x:'center',
                		y:'top',
				        text: "流通流向统计排行前五位地区"
				    },
                legend: {
                	x:'center',
                	y : 'bottom',
                    data: ['销往省外','省外购进']
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '10%',
                    top: '10%',
                    containLabel: true
                },
                yAxis: {
                    type: "category",
                    data: bar_xAxisData,
                    axisLabel: {
                        interval: 0,
                    }
                },
                xAxis: {
                    type: 'value',
                    rotate:20,
                    splitNumber : 5,
                },
                series: [{
                    name: '销往省外',
                    itemStyle: {
                        normal: {},
                    },
                    type: 'bar',
                    barMaxWidth: '30%',
                    data: xw_data
                },{
                    name: '省外购进',
                    itemStyle: {
                        normal: {},
                    },
                    type: 'bar',
                    barMaxWidth: '30%',
                    data: gj_data
                }]
            };
	
	var myChartpie = echarts.init(document.getElementById('bb'));
        // 使用刚指定的配置项和数据显示图表。
        myChartpie.setOption(optionbar);
//------------------------------------------饼图填充完毕-------------------------------
              }
	})
}

var dict_city={
    "BEIJING":"北京",
    "TIANJIN":"天津",
    "HEBEI":"河北",
    "SHANXI":"山西",
    "NEIMENGGU":"内蒙古",
    "LIAONING":"辽宁",
    "JINLI":"吉林",
    "HEILONGJIAN":"黑龙江",
    "SHANGHAI":"上海",
    "JIANGSU":"江苏",
    "ANHUI":"安徽",
    "FUJIAN":"福建",
    "JIANGXI":"江西",
    "SHANDONG":"山东",
    "HENAN":"河南",
    "HUBEI":"湖北",
    "HUNAN":"湖南",
    "GUANGDONG":"广东",
    "GUANGXI":"广西",
    "HAINAN":"海南",
    "CHONGQING":"重庆",
    "SICHUAN":"四川",
    "GUIZHOU":"贵州",
    "YUNNAN":"云南",
    "XIZANG":"西藏",
    "SHAN_XI":"陕西",
    "GANSU":"甘肃",
    "QINGHAI":"青海",
    "NINGXIA":"宁夏",
    "XINJIANG":"新疆",
    "ZHEJIANG":"浙江",
}       
         

</script>
<%@ include file="../../common/AdminFooter.jsp" %>