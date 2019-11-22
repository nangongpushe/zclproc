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
		<li class="active">人员统计</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

	<div class="demoTable">
			年份：
			<div class="layui-inline">
				<input class="layui-input" name="year" id="year" autocomplete="off">
			</div>
			<button class="layui-btn layui-btn-primary layui-btn-small" id="reloadcharts" onclick="reloadcharts();">搜索</button>
	</div>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			
	</fieldset>
	
	  <div class="layui-row layui-col-space5">
		    <div  class="layui-col-md6">
		      <div class="grid-demo" id="aa" style="height: 400px;border: 1px solid #ddd;"></div>
		    </div>
		    <div class="layui-col-md6">
		      <div class="grid-demo" id="bb" style="height: 400px; border: 1px solid #ddd;"></div>
		    </div>
	  </div>
	
 	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width: 600px;height:400px;"></div>
	</div>

<script>
var laydate = layui.laydate;
 //执行一个laydate实例
  laydate.render({
    elem: '#year' //指定元素
    ,type: 'year'
    ,value: '2017'
  });

 $(document).ready(function(e){ 
 	$('#reloadcharts').click(); //触发AJAX事件
  } ) 

function reloadcharts(){
var barCount = [];
var barLegend = [];
var booleanBarArr = ["正高级职称", "中级职称", "初级及以下职称", "高级技师", "技师", "高级工", "中级工", "初级工"];
var pieCount = [];
var pieLegend = [];
var booleanPieArr = ["研究生", "大学本科", "大学专科", "中专", "高中及以下"];
	$.ajax({
		  type: "GET",
             url: "${ctx}/charts/getPersonInfo.shtml",
             data: {year:$("#year").val()},
             dataType: "json",
             success: function(data){           	
             	if(data.code==1){
             		alert(data.msg)             		
             	}else {
                    $.each(data.data.personList, function(commentIndex, comment){
                        if($.inArray(comment.type.trim(), booleanBarArr)!=-1){
                            barCount.push(comment.thisYear);
                            barLegend.push(comment.type);
                        }

                        if($.inArray(comment.type.trim(), booleanPieArr)!=-1){
                            var obj=new Object();
                            obj.name = comment.type;
                            obj.value = comment.thisYear;
                            pieCount.push(obj);
                            pieLegend.push(comment.type);
                        }
                    })
				}
// -----------------------------------------------柱状图数据填充--------------------------------
	 			// 指定图表的配置项和数据
			 	optionbar = {
			 	    title: {
			 	     	left: 'center',
				        text: '人员岗位分类统计'
				    },
				    color: ['#3398DB'],
				    tooltip : {
				        trigger: 'axis',
				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				        }
				    },
				        toolbox: {
				        show : true,
				        feature : {
				            saveAsImage : {show: true}
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
				            data : barLegend,
				            axisTick: {
				                alignWithLabel: true
				            }
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:'人数',
				            type:'bar',
				            barWidth: '60%',
				            data:barCount
				        }
				    ]
				};	 
				var myChartbar = echarts.init(document.getElementById('aa'));
		        // 使用刚指定的配置项和数据显示图表。
				 myChartbar.setOption(optionbar);
// -----------------------------------------------柱状图数据填充完成--------------------------------


// -----------------------------------------------饼图数据填充--------------------------------
   // 指定图表的配置项和数据
       optionpie = {
	    title : {
	        text: '学历统计划分',
	        x:'center'
	    },
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	        toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType : {
		                show: true,
		                type: ['pie', 'funnel']
		            },
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
	    legend: {
	        orient: 'vertical',
	        left: 'left',
	        data: pieLegend
	    },
	    series : [
	        {
	            name: '访问来源',
	            type: 'pie',
	            radius : '55%',
	            center: ['50%', '60%'],
	            data:pieCount,
	            itemStyle: {
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        }
	    ]
	};
	
	var myChartpie = echarts.init(document.getElementById('bb'));
        // 使用刚指定的配置项和数据显示图表。
        myChartpie.setOption(optionpie);
//------------------------------------------饼图填充完毕-------------------------------
              }
	})
}

 
        
         

</script>
<%@ include file="../../common/AdminFooter.jsp" %>