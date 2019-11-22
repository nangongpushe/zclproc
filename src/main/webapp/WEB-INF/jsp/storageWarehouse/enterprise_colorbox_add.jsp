<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>浙江粮储生产管理系统</title>

<link rel="stylesheet" href="${ctx }/plugins/bootstrap-3.3.5-dist/css/bootstrap.min.css"/>
<link rel="stylesheet" href="${ctx }/plugins/jQueryValidationEngine-2.6.2/validationEngine.jquery.css">
<link rel="StyleSheet" href="${ctx }/plugins/colorbox/colorbox.css"/>
<link rel="StyleSheet" href="${ctx }/plugins/jQueryDropdown/jquery.dropdown.min.css"/>
<link rel="stylesheet" href="${ctx }/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">

<!-- FontAwesome Styles-->
<link href="${ctx}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- Morris Chart Styles-->
<link href="${ctx}/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />

<link rel="stylesheet" href="${ctx }/css/commons.css"/>
<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css"/>
<!-- Custom Styles-->
<link href="${ctx}/assets/css/custom-styles.css" rel="stylesheet" />

<link href="${ctx}/css/index.css" rel="stylesheet" /> 

<!-- JS Scripts-->
<!-- layui Js -->
<script src="${ctx}/assets/layui/layui.all.js"></script>

<!-- jQuery Js -->
<script src="${ctx}/assets/js/jquery-1.10.2.js"></script>

<!-- Bootstrap Js -->
<script src="${ctx}/assets/js/bootstrap.min.js"></script>

<!-- Jquery form Js -->
<script src="${ctx}/assets/js/jquery.form.js"></script>
<script src="${ctx }/plugins/colorbox/jquery.colorbox.js"></script>
<!-- commons Js -->
<script src="${ctx}/js/commons.js"></script>

<script src="${ctx}/js/laytool.js"></script>
<script src="${ctx}/js/dateformat.js"></script>
<script src="${ctx}/js/app/DateFormat.js"></script>

<script src="${ctx }/plugins/jQueryValidationEngine-2.6.2/jquery.validationEngine.js"></script>
<script src="${ctx }/plugins/jQueryValidationEngine-2.6.2/jquery.validationEngine-zh_CN.js"></script>


<%-- <script src="${ctx }/plugins/colorbox/jquery.colorbox.js"></script> --%>

<script src="${ctx }/js/cities.data.js"></script>
<!-- <script type="text/javascript" src="https://janking.github.io/dropdown/mock.js"></script> -->
<script src="${ctx }/plugins/jQueryDropdown/jquery.dropdown.min.js"></script>

<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.exedit.js"></script>

<script type="text/javascript" src="${ctx }/js/jquery.tablesorter.min.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery.tablesorter.widgets.min.js"></script>


<script src="${ctx}/js/jquery.nicescroll.min.js"></script>
<script src="${ctx }/plugins/colorbox/jquery.colorbox.js"></script>

</head>
<style type="text/css">
.layui-form-label {
    width: 150px ;
}
</style>

<div class="container-box">
    <div class="demoTable" id="search">
    	<div class="layui-form" id="search">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">代储企业编号：</label>
					<div class="layui-input-inline">
						<input class="layui-input" autocomplete="off" id="enterpriseSerial" name="enterpriseSerial">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">企业名称：</label>
					<div class="layui-input-inline">
						<input class="layui-input" autocomplete="off" id="enterpriseName" name="enterpriseName">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">统一社会信用代码：</label>
					<div class="layui-input-inline">
						<input class="layui-input" autocomplete="off" id="socialCreditCode" name="socialCreditCode">
					</div>
				</div>
				<!-- <div class="layui-inline">
					<label class="layui-form-label">统一社会信用代码：</label>
					<div class="layui-input-inline">
						<input class="layui-input" autocomplete="off" id="socialCreditCode" name="socialCreditCode">
					</div>
				</div> -->
				<div class="layui-inline">
					<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBt">查询</button>
				</div>
			</div>
		</div>
	</div>
    <div class="manage">
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="select">选择</a>
		</script>
    </div>
</div>


<script>
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx }/StoreEnterprise/list.shtml',
		method : 'POST',
		cols : [[
			{width : 80, align : 'center',toolbar : '#barDemo', title:'选择'}, 
 			{field : 'enterpriseSerial', title: '代储企业编号',width:150}, 
			{field : 'enterpriseName', title : '企业名称',width:200},
			{field : 'socialCreditCode', title : '统一社会信用代码',width:150},

		]],//设置表头
		request : {
			pageName : 'page', 
			limitName : 'pageSize'
		},
		page:true,//开启分页
		limit:10,
		id:'myTableID',
		done:function(res,curr,count){
		},
	});
	
	//监听工具条
	table.on('tool(test)', function(obj) {
		var data = obj.data;
		//console.log(data);
		if (obj.event === 'select') {
			window.parent.callAddEnterprise(data);
			window.parent.$.colorbox.close();
		}
		
	});

	//搜索
	$('#search button').click(function() {
		table.reload("myTableID", {
			where : {
				enterpriseSerial : $('#search #enterpriseSerial').val(),
				enterpriseName : $('#search #enterpriseName').val(),
				organizationCode : $('#search #organizationCode').val(),
				socialCreditCode : $('#search #socialCreditCode').val(),
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>






















