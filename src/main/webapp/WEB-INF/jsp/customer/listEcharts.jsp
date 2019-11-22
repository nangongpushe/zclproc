<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/AdminHeader.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!-- echarts Js -->
<script src="${ctx}/js/echarts.min.js"></script>



<div class="row clear-m">
	<ol class="breadcrumb">
		<li>客户管理</li>
		<li class="active">统计分析</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			<legend>统计分析</legend>
	</fieldset>
	<div class="demoTable">
			<div class="layui-inline"> 从事行业: </div>
             <div class="layui-inline">
		          <select id="industry" name="industry" class="layui-select layui-input" style="width:165px">
                            <option value="仓储类">仓储类</option>
                            <option value="加工类">加工类</option>
                            <option value="贸易类">贸易类</option>
		          </select>
			</div>
			<button class="layui-btn layui-btn-primary layui-btn-small" id="reloadcharts" onclick="reloadcharts();">查询</button>
	</div>
		 <div class="row">
            
            <div class="col-md-18" id="bb" style="height: 500px;    border: 1px solid #ddd;margin:1%;">
            </div>
            
        </div>
	
 	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width: 1200px;height:800px;"></div>
	</div>

<script>


 $(document).ready(function(e){ 
 	$('#reloadcharts').click(); //触发AJAX事件
  } ) 


function reloadcharts(){
var pieCount = [];
var pieLegend = [];
	$.ajax({
		  type: "POST",
             url: "${ctx}/CustomerInformation/getCharts.shtml",
             data: {industry:$("#industry").val()},
             dataType: "json",
             success: function(data){   
         	      //-----------------渲染饼图数据--------------
				
             	 $.each(data, function(commentIndex, comment){
             	 		var obj=new Object();
             	 		obj.name = comment.province/* +"-"+comment.industry */;
             	 		obj.value = comment.count;
             	 		pieCount.push(obj);
             	 		pieLegend.push(comment.province/* +"-"+comment.industry */);   
             	 })



// -----------------------------------------------饼图数据填充--------------------------------
   // 指定图表的配置项和数据
       optionpie = {
	    title : {
	        text: '客户信息统计分析',
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
              x : 'center',
    		  y : 'bottom',
	        data: pieLegend
	    },
	    series : [
	        {
	            name: '所占比列',
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
<%@ include file="../common/AdminFooter.jsp" %>