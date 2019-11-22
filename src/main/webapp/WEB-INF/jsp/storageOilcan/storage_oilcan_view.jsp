<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp"%>
<style>
	#repairTable + .layui-form .layui-table-body td[data-field="repairDate"]{
		text-align: center;
	}
	#repairTable + .layui-form .layui-table-body td[data-field="projectName"]{
		text-align: left;
	}
	#repairTable + .layui-form .layui-table-body td[data-field="construction"]{
		text-align: left;
	}
	#repairTable + .layui-form .layui-table-body td[data-field="effect"]{
		text-align: left;
	}
	#repairTable + .layui-form .layui-table-body td[data-field="remark"]{
		text-align: left;
	}
</style>
<style type="text/css">
	.layui-form-label{
		text-align:right;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>仓房管理</li>
		<li><a href="${ctx }/storageOilcan.shtml">油罐信息管理</a></li>
		<li class="activity">油罐信息表</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	<input name="id" value="${oilcan.id }" type="hidden">
	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>所属库点：</span>
			<span>${oilcan.warehouse }</span>
		</div>
		<div class="layui-col-md6">
			<span>油罐编号：</span>
			<span>${oilcan.oilcanSerial }</span>
		</div>
	</div>
	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>油罐类型：</span>
			<span>${oilcan.oilcanType }</span>
		</div>
		<div class="layui-col-md6">
			<span>油罐状态：</span>
			<span>${oilcan.oilcanStatus }</span>
		</div>
	</div>
	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>油罐名称：</span>
			<span>${oilcan.oilcanName }</span>
		</div>
		<div class="layui-col-md6">
			<span>交付使用日期：</span>
			<span>${oilcan.deliverDate }</span>
		</div>
	</div>
	
	<!-- <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>结构</legend>
	</fieldset> -->
	<div class="layui-row title">
		<h5>结构</h5>
	</div>
	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>罐体：</span>
			<span>${oilcan.oilcanBody }</span>
		</div>
		<div class="layui-col-md6">
			<span>灌顶：</span>
			<span>${oilcan.oilcanTop }</span>
		</div>
	</div>
	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>地面：</span>
			<span>${oilcan.oilcanFloor }</span>
		</div>
		
			<div class="layui-col-md6">
				<span>设计容量(t)：</span>
				<span>${oilcan.designedCapacity }</span>
			</div>
	</div>
	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>核定容量(t)：</span>
			<span>${oilcan.authorizedCapacity }</span>
		</div>
	</div>
	<!-- <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>罐外</legend>
	</fieldset> -->
	<div class="layui-row title">
		<h5>罐外</h5>
	</div>
	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>罐高(m)：</span>
			<span>${oilcan.oilcanHeigh }</span>
		</div>
		<div class="layui-col-md6">
			<span>罐内径(m)：</span>
			<span>${oilcan.oilcanInnerDiameter }</span>
		</div>
	</div>

	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>罐外径(m)：</span>
			<span>${oilcan.oilcanOuterDiameter }</span>
		</div>

		<div class="layui-col-md6">
			<span>设计装油线高(m)：</span>
			<span>${oilcan.designedOilLine }</span>
		</div>
	</div>
	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>实际装油线高(m)：</span>
			<span>${oilcan.authorizedOilLine }</span>
		</div>
	</div>
	<!-- <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
				<legend>其他</legend>
	</fieldset> -->
	<div class="layui-row title">
		<h5>其他</h5>
	</div>
	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>油罐经度：</span>
			<span>${oilcan.longitude }</span>
		</div>

		<div class="layui-col-md6">
			<span>油罐维度：</span>
			<span>${oilcan.latitude }</span>
		</div>
	</div>
	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>隔热措施：</span>
			<span>${oilcan.heatInsulation }</span>
		</div>
		<div class="layui-col-md6">
			<span>是否停用：</span>
			<span>
				<c:if test="${oilcan.isStop=='N'}">否</c:if>
				<c:if test="${oilcan.isStop=='Y'}">是</c:if>
			</span>
		</div>
	</div>

	<div class="layui-row layui-col-space1">
		<div class="layui-col-md6">
			<span>排序号：</span>
			<span>${oilcan.orderNo }</span>
		</div>
	</div>

	<table lay-filter="operation" id="repairTable"></table>
	
		

	<p class="btn-box text-center">
			<button type="button" class="layui-btn layui-btn-primary layui-btn-small"
				onclick="cancelOperate('${auvp }', '${ctx}/storageOilcan.shtml')" name="cancelBtn">返回</button>
	</p>
</div>
<script src="${ctx}/js/app/storage/common.js"></script>
<script>
$(function() {

		var table = layui.table;
		//执行渲染
		table.render({
			elem : '#repairTable',
			url : '${ctx}/storageOilcanRepair/list.shtml?oilcanId=${oilcan.id }',
			method : "POST",
			cols : [ [
				{
                    fixed : 'left',
					field : 'repairDate',
					title : '日期',
					width : 200,
                    align:'center'
				},
				{
					field : 'projectName',
					title : '项目',
					width : 200,
                    align:'center'
				},
				{
					field : 'construction',
					title : '检查维修情况摘要',
					width : 300,
                    align:'center'
				},
				{
					field : 'effect',
					title : '效果',
					width : 300,
                    align:'center'
				},
				{
					field : 'remark',
					title : '记事',
					width : 500,
                    align:'center'
				}
				<c:if test="${auvp} != 'v'">,

				{
					fixed : 'right',
					width : 160,
					align : 'center',
					toolbar : '#operationColId',
					title : '操作'
				}
				</c:if>
			] ], //设置表头
			request : {
				pageName : 'page',
				limitName : 'pageSize'
			},
			page : true, //开启分页
			limit : 10,
			done : function(res, curr, count) {},
		});
	
});
</script>