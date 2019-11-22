<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/AdminHeader.jsp"%>

<style>
.layui-form-label{
	width:150px;
}
</style>


<div class="container-box clearfix" style="padding: 10px">
	<div class="layui-form" id="search">
		<div class="layui-form-item"  style="height:25px">
			<div class="layui-inline">
				<label class="layui-form-label">库点名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="warehouse" name="warehouse">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">油罐编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="encode" name="oilcanSerial">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">油罐类型：</label>
				<div class="layui-input-inline">
					<select name="oilcanType">
						<option value=""></option>
						<c:forEach items="${oilcanTypeDict }" var="item">
							<option value="${item.value }">${item.value }</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
		<div class="layui-form-item"  style="height:25px">
			<div class="layui-inline">
				<label class="layui-form-label">油罐状态：</label>
				<div class="layui-input-inline">
					<select name="oilcanStatus">
						<option value=""></option>	
						<c:forEach items="${oilcanStatusDict }" var="item">
							<option value="${item.value }">${item.value }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">设计容量：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" name="designedCapacity">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">核定容量：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" name="authorizedCapacity">
				</div>
			</div>
			
		</div>
		<div class="layui-form-item"  style="height:25px">
			<div class="layui-inline">
				<label class="layui-form-label">设计装油线高：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="designedOilLine" name="designedOilLine">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">实际装油线高：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="authorizedOilLine" name="authorizedOilLine">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">交付使用日期：</label>
				<div class="layui-input-inline">
					<input class="layui-input date-need" autocomplete="off" id="deliverDate" name="deliverDate">
				</div>
			</div>
		</div>
	<div class="btn-box text-center"  style="height:25px">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn" onclick="searchReload()">查询</button>
	</div>
	<div class="btn-box text-center">
	</div>
	</div>
		<table lay-filter="operation" id="storeOilcanTable"></table>
		<script type="text/html" id="operationColId">
            <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="select">选择</a>
		</script>
</div>
<script type="text/javascript">
layui.use(['form', 'laydate'], function(){
	var table = layui.table,
	form = layui.form,
	laydate = layui.laydate;
	
	form.render();
	
	$('.date-need').each(function(){
		laydate.render({
			elem: this,
			format: 'yyyy年MM月dd日'
		});
	});

	table.render({
		elem : '#storeOilcanTable',
		url : '${ctx}/storageOilcan/list.shtml',
		method : "POST",
		cols : [[
			{width : 160,align : 'center',toolbar : '#operationColId',title: '操作'}, 
 			{field : 'warehouse', title: '库点名称', width : 150}, 
			{field : 'oilcanSerial', title : '油罐编号', width : 150},
			{field : 'oilcanType', title : '油罐类型', width : 150}, 
			{field : 'oilcanStatus', title : '油罐状态', width : 150},
			{field : 'designedCapacity', title : '设计容量', width : 150},
			{field : 'authorizedCapacity', title : '核定容量', width : 150},
			{field : 'designedOilLine', title : '设计装油线高', width : 150},
			{field : 'authorizedOilLine', title : '实际装油线高', width : 150},
			{field : 'deliverDate', title : '交付使用日期', width : 200},
		]],//设置表头
		request : {
			pageName : 'page', 
			limitName : 'pageSize'
		},
		page:true,//开启分页
		limit:10,
		id:'storeOilcanTableId',
		done:function(res,curr,count){
		},
	});	
	//监听工具条
	table.on('tool(operation)', function(obj) {
		var data = obj.data;
		//console.log(data);
		 if (obj.event === 'select') {
		window.parent.selectToDataStorageOilcan(data);
		window.parent.$.colorbox.close();
		} ;
	});
	
});
var table = layui.table;
//搜索操作
function searchReload(){
  	table.reload('storeOilcanTableId', {
	where : {
		warehouse : $('input[name="warehouse"]').val(),
		oilcanSerial : $('input[name="oilcanSerial"]').val(),
		oilcanType : $('select[name="oilcanType"]').val(),
		oilcanStatus : $('select[name="oilcanStatus"]').val(),
		designedCapacity : $('input[name="designedCapacity"]').val(),
		authorizedCapacity : $('input[name="authorizedCapacity"]').val(),
		designedOilLine : $('input[name="designedOilLine"]').val(),
		authorizedOilLine : $('input[name="authorizedOilLine"]').val(),
		deliverDate : $('input[name="deliverDate"]').val()
	}
});
  }; 
</script>
</body>