<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>

<style>
	#mytable + .layui-form .layui-table-body td[data-field="payUnit"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="status"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="claimStatus"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="reporter"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="arriveAmount"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="balance"]{
		text-align: right;
	}

</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>货款管理</li>
		<li class="active">货款认领单</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">收款日期:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="arriveDate" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.reloadTable();}">查询</button>
			</div>
		</div>
	</div>

	<table class="layui-table" lay-filter="table" id="myTable"></table>
	<script type="text/html" id="barDemo">
		<shiro:hasPermission name="RotateClaim:view">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="view">查看(认领)</a>
			{{#  if(d.dealCount == 0){ }}
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="returnStatus">退回</a>
			{{#  } }}
		</shiro:hasPermission>
		<%--<shiro:hasPermission name="RotateClaim:view">--%>

		<%--</shiro:hasPermission>--%>

     <%--   <a href="../rotateClaim/returnStatus.shtml?id="+ data.id>退回</a>--%>

	</script>
	
</div>


<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotateclaim/main.js"></script>
<script type="text/html" id="reportDateFormat">
	{{Date_format(d.reportDate,true)}}
</script>
<script type="text/html" id="arriveDateFormat">
	{{Date_format(d.arriveDate,true)}}
</script>
<script>

	var vm = new Main();
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();

	function Format(datetime,fmt) {
		if(datetime == null){
			return "";
		}
		if (parseInt(datetime)==datetime) {
			if (datetime.length==10) {
				datetime=parseInt(datetime)*1000;
			} else if(datetime.length==13) {
				datetime=parseInt(datetime);
			}
		}
		datetime=new Date(datetime);
		var o = {
			"M+" : datetime.getMonth()+1,                 //月份
			"d+" : datetime.getDate(),                    //日
			"h+" : datetime.getHours(),                   //小时
			"m+" : datetime.getMinutes(),                 //分
			"s+" : datetime.getSeconds(),                 //秒
			"q+" : Math.floor((datetime.getMonth()+3)/3), //季度
			"S"  : datetime.getMilliseconds()             //毫秒
		};
		if(/(y+)/.test(fmt))
			fmt=fmt.replace(RegExp.$1, (datetime.getFullYear()+"").substr(4 - RegExp.$1.length));
		for(var k in o)
			if(new RegExp("("+ k +")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
		return fmt;
	}

</script>
<%@include file="../common/AdminFooter.jsp"%>