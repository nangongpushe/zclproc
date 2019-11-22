<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/AdminHeader.jsp" %>
<style type="text/css">
	#outside {
		width: 94%;
		margin-left: 2%;
		padding: 1%;
		background: #fff;
	}
	
	#userInfo{
		margin-left:10%;
		padding-bottom:25px;
	}
	
	#userInfo>span{
		padding-right:5%;
	}
	
	#data-view table{
		width:100%;
		text-align: left;
	}
	
	#data-view thead{
		background:#aaa;
		color:#000;
	}
	
	#data-view td{
		padding:10px 5px;
	}
	
	#data-view tbody tr:hover{
		background:#eee;
	}
	
	.buttonArea{
		padding:5px 15px;
		background:#009688;
		color:#fff;
		cursor:pointer;
		display:inline;
	}
</style>
<%--<div class="row clear-m">--%>
	<%--<ol class="breadcrumb">--%>
		<%--<li>基建管理</li>--%>
		<%--<li>工程拨款</li>--%>
		<%--<li class="active">查看</li>--%>
	<%--</ol>--%>
<%--</div>--%>
<div id="outside">
	<h4 style="text-align:center;font-size:1.5em">浙江省储备粮管理有限公司</h4>
	<h4 style="text-align:center;font-size:1.5em;">基建工程拨款审批表</h4>
	<div style="display:inline-block;width:49%;text-align:left;">填报单位（盖章）：${funds.reportUnit }</div>
	<div style="display:inline-block;width:49%;text-align:right;">${funds.reportTime }</div>
	<div id="data-view">
		<table class="layui-table">
			<tr>
				<td rowspan="2">基建项目名称</td>
				<td rowspan="2" colspan="4">${funds.projectName }</td>
			</tr>
			<tr>
			</tr>
			<tr>
				<td rowspan="3">工程总投资额</td>
				<td colspan="2" rowspan="3">${funds.investmentTotal }</td>
			</tr>
			<tr>
				<td>已预拨数（万元）</td>
				<td>${funds.alreadyDialed }</td>
			</tr>
			<tr>
				<td>工程进度</td>
				<td>${funds.process }</td>
			</tr>
			<tr>
				<td>本次申请拨款额</td>
				<td colspan="4">${funds.thisAppropriation }</td>
			</tr>
		</table>
	</div>
	<a class="buttonArea" href="${ctx }/Construction/Funds/ExportExcel.shtml?id=${funds.id}">导出</a>
</div>
<script>
	$("data-view .buttonArea").click(function(){
		layer.open({
			  title:false,
			  area: ['500px', '300px'],
			  type: 1,
			  content:"<textarea readonly style='width:95%;height:95%;border:none;resize:none;padding:5%'>"+$(this).next("textarea").val()+"</textarea>"
		});  
	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>