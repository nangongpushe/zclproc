<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>质量管理</li>
		<li>检验任务</li>
		<li class="active">检验任务</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-form" id="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">任务编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="taskSerial" id="taskSerial"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">任务名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="taskName"
						id="taskName" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">样品编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="sampleNo"
						id="sampleNo" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">库点名称:</label>
				<div class="layui-input-inline">
				<select   name="wearhouse" id="wearhouse"  >
                    		<option value="">--请选择--</option>
		                 <c:forEach items="${distinctList}" var="distinctList">  
		        			<option value="${distinctList.company}">${distinctList.company}</option>
		   				 </c:forEach>
   					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">检验类型:</label>
				<div class="layui-input-inline">
					<select lay-verify="required" name="inspectionType" id="inspectionType" class="form-control">
					<option value="">--请选择--</option>
                    <option value="出库">出库</option>
                    <option value="入库">入库</option>
                    <option value="春秋季检查">春秋季检查</option>
				</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">实际检验日期:</label>
				<div class="layui-input-inline">
					<input type="text" id="actualInspectionTime" name="actualInspectionTime"  class="form-control "  placeholder=""/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">任务状态:</label>
				<div class="layui-input-inline">
					<select lay-verify="required" name="taskStatus" id="taskStatus" class="form-control ">
					<option value="">--请选择--</option>
                    <option value="未开始">未开始</option>
                    <option value="进行中">进行中</option>
                    <option value="已完成">已完成</option>
				</select> 
				</div>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
			</div>
		</div>
	</div>
		<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" lay-event="add" onclick="add();">新增</button>
				<button class="layui-btn layui-btn-primary layui-btn-small" onclick="exportExcel();">导出</button>
				<button class="layui-btn layui-btn-primary layui-btn-small" id="delete" onclick="todelete();">删除</button>
			</div>

	<!-- layui表格 -->
	<table lay-filter="test" id="mytable"></table>
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="print">打印</a>
	</script>
</div>

			

<script>
	var form=layui.form;
	form.render();
	
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/QualityTask/list.shtml',
		/*  width:1180, */ 
		method:'post',
		cols : [[
			{checkbox:true,width:69,align : 'center',fixed: true},
 			{field:'taskSerial',title: '任务编号',width:150,fixed: true}, 
			{field:'taskName',title: '任务名称',width:150}, 
			{field:'wearhouse',title: '库点名称',width:150}, 
			{field:'sampleNo',title: '样品编号',width:150}, 
			{field:'inspectionType',title: '检验类型',width:150}, 
			{field:'taskPriority',title: '优先级',width:150}, 
			{field:'taskExecutor',title: '执行人',width:150}, 
			{field:'plannedInspectionTime',title: '计划检验时间',width:150}, 
			{field:'actualInspectionTime',title: '实际检验时间',width:150}, 
			{field:'taskStatus',title: '任务状态',width:150}, 
			{field:'creator',title: '创建人',width:150}, 
			{field:'createDate',title: '创建时间',width:150}, 
			{width : 160,align : 'center',toolbar : '#barDemo',title: '操作',width:290,fixed: 'right'}, 
			
		]],//设置表头
/* 		request : {
		
			pageName : 'page', 
			limitName : 'pageSize'
		}, */
		page:true,//开启分页
/* 		limit:10, */
		id:'myTableID',
		done:function(res,curr,count){
		},
	});
	
function add(){
location.href = "${ctx}/QualityTask/addPage.shtml";
}
function exportExcel(){
location.href = "${ctx}/QualityTask/exportExcel.shtml?taskSerial=" +encodeURI(encodeURI($('#search #taskSerial').val())) +
								"&taskName=" + encodeURI(encodeURI($('#search #taskName').val()))+
								"&sampleNo=" + encodeURI(encodeURI($('#search #sampleNo').val()))+
								"&wearhouse=" + encodeURI(encodeURI($('#search #wearhouse').val()))+
								"&inspectionType=" + encodeURI(encodeURI($('#search #inspectionType').val()))+
								"&actualInspectionTime=" + encodeURI(encodeURI($('#search #actualInspectionTime').val()))+
								"&taskStatus=" + encodeURI(encodeURI($('#search #taskStatus').val()));
}
table.on('tool(test)', function(obj) {
		var data = obj.data;
		if (obj.event === 'detail') {
		
			location.href = "${ctx}/QualityTask/detailPage.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确认要删除该任务么 ?', function(index) {
				$.post("${ctx}/QualityTask/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					layer.open({
					  title: '提示信息'
					  ,content: result.msg
					}); 
						table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
								taskSerial : $('#search #taskSerial').val(),
								taskName : $('#search #taskName').val(),
								sampleNo : $('#search #sampleNo').val(),
								wearhouse : $('#search #wearhouse').val(),
								inspectionType : $('#search #inspectionType').val(),
								actualInspectionTime : $('#search #actualInspectionTime').val(),
								taskStatus : $('#search #taskStatus').val(),
							}
						});
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/QualityTask/editPage.shtml?id="
					+ data.id;
		}else  if(obj.event === 'print'){
			location.href = "${ctx}/QualityTask/print.shtml?id="
					+ data.id;
		}
		
	});
	

	//搜索
	$('#search button').click(function() {
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				taskSerial : $('#search #taskSerial').val(),
				taskName : $('#search #taskName').val(),
				sampleNo : $('#search #sampleNo').val(),
				wearhouse : $('#search #wearhouse').val(),
				inspectionType : $('#search #inspectionType').val(),
				actualInspectionTime : $('#search #actualInspectionTime').val(),
				taskStatus : $('#search #taskStatus').val(),
			}
		});
	});
 layui.use('laydate', function(){
  var laydate = layui.laydate;
  laydate.render({ 
	  elem: '#actualInspectionTime'
	  ,format: 'yyyy-MM-dd' //可任意组合
	});
});
function todelete(){
 layer.confirm('确认删除选择记录吗？', function(index) {
 var checkStatus = table.checkStatus('myTableID');
	var data = checkStatus.data;
	var ids="";
	if(data.length>0){
	var list = new Array();
	for (var i = 0; i < data.length; i++) {
		 if(ids==""){
            ids=data[i].id;
            }else{
            ids+="-"+data[i].id;
            }
	}
	$.post("${ctx}/QualityTask/remove.shtml?ids="+ids,{
				}, function(result) {  
	if (result.success) {
		alert("记录删除成功");
	}else{
		alert("记录删除失败");
	}
});
	location.href="${ctx}/QualityTask.shtml";
	}else{
	layer.open({
		title: '提示信息'
		,content: '请勾选记录'
	});
	}
 });
}
</script>
<script type="text/html" id="dateTemplate">
 {{ parseDate(d.plannedInspectionTime)}}
 {{ parseDate(d.actualInspectionTime)}}
 {{ parseDate(d.createDate)}}
</script>
<%@include file="../common/AdminFooter.jsp"%>