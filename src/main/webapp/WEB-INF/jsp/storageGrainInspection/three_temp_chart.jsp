<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<script src="${ctx}/js/echarts.min.js"></script>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>粮油情检测管理</li>
		<li class="active">粮情三温图</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
	<div class="layui-form">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">库点：</label>
				<div class="layui-input-inline">
					 <select lay-filter="warehouse" class="form-control"  name="warehouse" id="warehouse">
                    		<option value="">--请选择--</option>
		                 <c:forEach items="${warehouse}" var="warehouse">  
		        			<option value="${warehouse.id}"<c:if test="${warehouse.warehouseShort eq user.shortName}">selected</c:if>  >${warehouse.warehouseShort}</option>
		   				 </c:forEach>
   					</select> 
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" >仓房编号：</label>
				<div class="layui-input-inline">
					<select name="encode" lay-filter="encode" id="encode">
						<option value="">--请选择--</option>
						<c:forEach items="${storehouseArray }" var="item">
						     <option value="${item.encode }">${item.encode }</option>
						 </c:forEach>
					 </select>
				</div>
			</div>
		<!-- </div>
		<div class="layui-form-item"> -->
			<div class="layui-inline">
				<label class="layui-form-label">开始时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input date-need" lay-verify="required" name="statisticBeginDate" value="">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">结束时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input date-need" lay-verify="required" name="statisticEndDate" value="">
				</div>
			</div>
			<div class="layui-inline">
	        	<button class="layui-btn layui-btn-primary layui-btn-small" id="searchBtn" lay-submit lay-filter="searchBtn">查询</button>
	    	</div>
		</div>
	</div>
	<div id="main" style="width: 100%; height:70%;"></div>
</div>

<script type="text/javascript">
function setEncode(){
alert();
}
layui.use(['laydate','form'], function(){
	var layer = layui.layer,
	laydate = layui.laydate,
	form = layui.form;
	//加载日历
	$('.date-need').each(function(){
		laydate.render({
		elem : this
		});
	});
	form.render();
	form.on('select(warehouse)', function(data){
		$.ajax({
        	url : '${ctx }/storageStoreHouse/getEncodeByWarehouse.shtml?warehouse=' +encodeURI(encodeURI( data.value)),
			error: function(request) {
			    //layer.closeAll('loading');
			    //layer.alert("保存失败，请与管理员联系！");
				if(request.responseText){
				    layer.open({
				        type: 1,
				        area: ['700px', '430px'],
				        fix: false,
				        content: request.responseText
				    });
				}
			},
			success : function(result) {
				//layer.closeAll('loading');
				$("#encode").empty();
				for(i in result) {
				    $("#encode").append("<option value=" + result[i] +">" + result[i] +"</option>"); 
				}
				form.render();
			}
		});
	});
	form.on('submit(searchBtn)',function(){
		var warehouse = $('select[name="warehouse"]').val(),
		warehouseShort = $('select[name="warehouse"] option:selected').text(),
		encode = $('select[name="encode"]').val(),
		statisticBeginDate = $('input[name="statisticBeginDate"]').val(),
		statisticEndDate = $('input[name="statisticEndDate"]').val();
		asynEChartWithCond(warehouseShort,warehouse, encode, statisticBeginDate, statisticEndDate);
	});
});

$(function() {
	if ('${isFirstLoad}' === 'true') {
		var date = new Date();
		/* var warehouse = '直属库';
		var encode = '一号仓'; */
		var beginDate = getCurrentMonthFirst(date).Format("yyyy-MM-dd");
		$('input[name="statisticBeginDate"]').val(beginDate);
		var endDate = getCurrentMonthLast(date).Format("yyyy-MM-dd");
		$('input[name="statisticEndDate"]').val(endDate);
		/* asynEChartWithCond(warehouse, encode, beginDate, endDate); */
	};
});

function getCurrentMonthFirst(date){
	date.setDate(1);
	return date;
}

function getCurrentMonthLast(date){
	var currentMonth=date.getMonth();
	var nextMonth=++currentMonth;
	var nextMonthFirstDay=new Date(date.getFullYear(),nextMonth,1);
	var oneDay=1000*60*60*24;
	return new Date(nextMonthFirstDay-oneDay);
}

function asynEChartWithCond(warehouseShort,warehouse, encode, statisticBeginDate, statisticEndDate) {
	$.ajax({
		type: 'POST',
		url: '${ctx }/storageGrainInspection/getEChartData.shtml',
		data: {
			'warehouse':  warehouse,
			'encode': encode,
			'statisticBeginDate': statisticBeginDate,
			'statisticEndDate': statisticEndDate
		},
		success: function(data){
			if (data.isEmpty) {
				loadChart(null, null, null, null);
				layer.alert("暂无数据");
			} else {
				var subtext = '库点：' + warehouseShort + '，仓房编号：' + encode + '，区间开始时间：' + statisticBeginDate + '，区间结束时间：' + statisticEndDate;
				loadChart(subtext, data.xAxisData, data.storehouseTempArray, data.temperatureArray, data.temperatureAvgArray);
			}
		},
		error: function(request) {
			if(request.responseText){
				layer.open({
					type: 1,
					area: ['700px', '430px'],
					fix: false,
					content: request.responseText
				});
			}
		}
	});
};

function loadChart(subtext, xAxisData, storehouseTempArray,temperatureArray,temperatureAvgArray) {
	// 基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById('main'));
	var option = {
	    title : {
	        text: '粮情三温图',
	        subtext: subtext
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend : {
	        data:['仓温','粮温',"气温"]
	    },
	    toolbox : {
	        show : true,
	        feature : {
	            mark : {show: true},
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : xAxisData
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel : {
	                formatter: '{value} °C'
	            }
	        }
	    ],
	    series : [
	        {
	            name:'仓温',
	            type:'line',
	            itemStyle: {
	                normal: {
	                    color: 'blue'
	                }
            	},
	            data:storehouseTempArray,

	        },
	        {
	            name:'气温',
	            type:'line',
	            itemStyle: {
	                normal: {
	                    color: 'black'
	                }
            	},
	            data:temperatureArray,

	        },
	        {
	            name:'粮温',
	            type:'line',
	            itemStyle: {
	                normal: {
	                    color: 'red'
	                }
            	},
	            data:temperatureAvgArray,

	        }
	    ]
	};
	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
};
</script>
<%@ include file="../common/AdminFooter.jsp" %>


