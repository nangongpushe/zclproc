<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/AdminHeader.jsp"%>
<style>
	#storeOilcanTable + .layui-form .layui-table-body td[data-field="warehouse"]{
		text-align: left;
	}
	#storeOilcanTable + .layui-form .layui-table-body td[data-field="oilcanSerial"]{
		text-align: left;
	}
	#storeOilcanTable + .layui-form .layui-table-body td[data-field="oilcanName"]{
		text-align: left;
	}
	#storeOilcanTable + .layui-form .layui-table-body td[data-field="oilcanType"]{
		text-align: left;
	}
	#storeOilcanTable + .layui-form .layui-table-body td[data-field="oilcanStatus"]{
		text-align: left;
	}
	#storeOilcanTable + .layui-form .layui-table-body td[data-field="designedCapacity"]{
		text-align: right;
	}
	#storeOilcanTable + .layui-form .layui-table-body td[data-field="authorizedCapacity"]{
		text-align: right;
	}
	#storeOilcanTable + .layui-form .layui-table-body td[data-field="designedOilLine"]{
		text-align: right;
	}
	#storeOilcanTable + .layui-form .layui-table-body td[data-field="authorizedOilLine"]{
		text-align: right;
	}
	#storeOilcanTable + .layui-form .layui-table-body td[data-field="deliverDate"]{
		text-align: center;
	}
</style>
<style>
.layui-form-label{
	width:150px;
}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>仓房管理</li>
		<li class="active">油罐信息管理</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	<div class="layui-form" id="search">
		<div class="layui-form-item">
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
		<!-- </div>
		<div class="layui-form-item"> -->
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
		<!-- </div>
		<div class="layui-form-item"> -->
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
			<div class="layui-inline">
				<label class="layui-form-label">是否停用：</label>
				<%--<div class="layui-input-inline">
                    <input class="layui-input" autocomplete="off" id="enterpriseName" name="enterpriseName">
                </div>--%>
				<div class="layui-input-inline">
					<select lay-verify="required" class="form-control"  name="isStop" id="isStop" lay-search lay-filter="isStop">
						<option value="">--全部--</option>
						<option value="Y" >是</option>
						<option value="N" >否</option>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn" onclick="searchReload()">查询</button>
			</div>
		</div>
	</div>
	<div class="manage">
	<br>
	<shiro:hasPermission name="StorageOilcan:add">
		<button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="window.location.href='storageOilcan/addPage.shtml'">新增</button>
	</shiro:hasPermission>
		<%-- <p class="btn-box">
			<shiro:hasPermission name="StorageOilcan:add">
			<button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="window.location.href='storageOilcan/addPage.shtml'">新增</button>
			</shiro:hasPermission>
		</p> --%>
		<table lay-filter="operation" id="storeOilcanTable"></table>
		<script type="text/html" id="operationColId">
			<shiro:hasPermission name="StorageOilcan:addRepair">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="addRepair">新建维修</a>
			</shiro:hasPermission>
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
			<shiro:hasPermission name="StorageOilcan:edit">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="StorageOilcan:del">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
			</shiro:hasPermission>  
		</script>
	</div>
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
 			{field : 'warehouse', title: '库点名称', width : 150,align:'center'},
			{field : 'oilcanSerial', title : '油罐编号', width : 150,align:'center'},
			{field : 'oilcanName', title : '油罐名称', width : 150,align:'center'},
			{field : 'oilcanType', title : '油罐类型', width : 150,align:'center'},
			{field : 'oilcanStatus', title : '油罐状态', width : 150,align:'center'},
			{field : 'designedCapacity', title : '设计容量(t)', width : 150,align:'center'},
			{field : 'authorizedCapacity', title : '核定容量(t)', width : 150,align:'center'},
			{field : 'designedOilLine', title : '设计装油线高(m)', width : 150,align:'center'},
			{field : 'authorizedOilLine', title : '实际装油线高(m)', width : 150,align:'center'},
			{field : 'deliverDate', title : '交付使用日期', width : 200,align:'center'},
			{field : 'isStop', title : '交付使用日期', width : 200,align:'center'},
			{fixed : 'right', align : 'center', toolbar : '#operationColId', width:320, title: '操作'},
		]],//设置表头
		request : {
			pageName : 'page', 
			limitName : 'pageSize'
		},
		page:true,//开启分页
		limit:10,
		id:'storeOilcanTableId',
		done:function(res,curr,count){
            $("[data-field='isStop']").children().each(function(){
                if($(this).text()=='Y'){
                    $(this).text("是")
                }else if($(this).text()=='N'){
                    $(this).text("否")
                }
            })
		},
	});	
	//监听工具条
	table.on('tool(operation)', function(obj) {
		var data = obj.data;
		//console.log(data);
		if (obj.event === 'detail') {
			location.href = "${ctx}/storageOilcan/viewPage.shtml?id="
				+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确认要删除吗？', function(index) {
				$.post("${ctx}/storageOilcan/remove.shtml", {
					id : data.id
				}, function(result) {
					if (result.success) {
						obj.del();
						layer.msg(result.msg,{icon:1});
						//layer.msg(result.msg,{icon:2});
					} else {
						layer.msg(result.msg,{icon:2});
					}
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/storageOilcan/editPage.shtml?id="
					+ data.id;
		} else if (obj.event === 'addRepair') {
			location.href = "${ctx}/storageOilcan/addRepairPage.shtml?oilcanId="
					+ data.id;
		};
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
		deliverDate : $('input[name="deliverDate"]').val(),
        isStop : $('#isStop').val()
	}
});
  }; 
</script>
</body>