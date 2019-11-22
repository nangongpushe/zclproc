<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="itemName"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="one"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="two"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="sum"]{
		text-align: right;
	}
</style>
<html>
<head>
<meta charset="UTF-8">
<title>浙江粮储生产管理系统</title>





<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css"/>
<link rel="stylesheet" href="${ctx }/css/basis_info.css"/>


<!-- JS Scripts-->
<!-- layui Js -->
<script src="${ctx}/assets/layui/layui.all.js"></script>















</head>



<div class="container-box clearfix" style="padding: 10px">
<input type="hidden" name="auvp" id="ids" value="${auvp}">
<input type="hidden" name="val" id="val" value="${val}">
		  <div class="manage">
		  <table lay-filter="test" id="mytable"></table>
	      
    </div>
    <div class="jumpPage" id="displayPage"></div>
</div>
<script type="text/javascript">
  var table = layui.table;
	table.render();
	//执行渲染
	var ids=document.getElementById("ids").value;
	var val=document.getElementById("val").value;
	var one=val.split("-")[0];
	var two=val.split("-")[1];
	table.render({
		elem : '#mytable',
		url : '${ctx}/QualityFileInfo/listCon.shtml?ids='+ids,
		cols : [[
 			{field : 'itemName', title: '检测项目', width : 100,align : 'center'},
			{field : 'one', title : one, width : 200,align : 'center'},
			{field : 'two', title : two, width : 200,align : 'center'},
			{field : 'sum', title : '对比值', width : 175,align : 'center'},
		]],//设置表头
		request : {
			pageName : 'page', 
			limitName : 'pageSize'
		},
		
	}); 
    
  
	table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'select') {
		window.parent.selectToDataStorageOilcan(data);
		window.parent.$.colorbox.close();
		} 
		
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>
