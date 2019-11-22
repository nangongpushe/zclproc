<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/AdminHeader.jsp" %>
<style type="text/css">

	#data-list tr td[data-field="column1"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[data-field="column2"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[data-field="column4"]{
		padding-right: 1%;
		text-align: right;
	}
	#data-list tr td[data-field="column5"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[data-field="column6"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[data-field="column7"]{
		padding-right: 1%;
		text-align: right;
	}
	#data-list tr td[data-field="column8"]{
		padding-right: 1%;
		text-align: right;
	}
	#data-list tr td[data-field="column9"]{
		padding-right: 1%;
		text-align: right;
	}

#outside {
	width: 94%;
	margin-left: 2%;
	padding: 1%;
	background: #fff;
}

#userInfo{
	margin-left:5%;
	padding:25px 0;
}

#userInfo>span{
	padding-right:5%;
}

#data-view table{
	width:100%;
	text-align: center;
}

#data-view thead{
	background:#aaa;
}

#data-view td{
	padding:10px 5px;
}

#data-view tbody tr:hover{
	background:#eee;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>中转业务</li>
		<li>中转业务记录</li>
		<li class="active">中转业务详情</li>
	</ol>
</div>
<div id="outside">
	<h4 name="scheme-title" style="text-align:center;font-size:2em">中转业务详情</h4>
	<div id="userInfo">
	<table style="width:90%">
		<tr>
			<td>单位名称：${transfer.unitName }</td>
			<td>经办人：${transfer.creator }</td>
			<td>填报时间：<fmt:formatDate value="${transfer.reportTime }" pattern="yyyy年MM月dd日"/></td>
			<td>中转时间：<fmt:formatDate value="${transfer.transferDate }" pattern="yyyy年MM月dd日"/></td>
		</tr>
		<tr>
			<td>中转总收入(万元)：${transfer.totalIncome }</td>
			<td>中转总支出(万元)：${transfer.totalExpend }</td>
			<td>中转总利润(万元)：${transfer.totalProfits }</td>
			<td>中转总数：${transfer.totalCount }</td>
		</tr>
	</table>
	</div>
	<div id="data-view">
		<table class="layui-table">
			<thead>
				<tr>
					<td>货主名称</td>
					<td>货物名称</td>
					<td>到港日期</td>
					<td>中转数量(吨)</td>
					<td>中转去向</td>
					<td>运输方式</td>
					<td>中转收入(万元)</td>
					<td>中转支出(万元)</td>
					<td>中转利润(万元)</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${transfer.transferDetail }" var="item">
				<tr>
					<td data-field="column1">${item.shipperName }</td>
					<td data-field="column2">${item.goodsName }</td>
					<td data-field="column3">${item.arrivalDate }</td>
					<td data-field="column4">${item.quantity }</td>
					<td data-field="column5">${item.destination }</td>
					<td data-field="column6">${item.shipType }</td>
					<td data-field="column7">${item.income }</td>
					<td data-field="column8">${item.expend }</td>
					<td data-field="column9">${item.profits }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div id="btn-area">
		<a href="${ctx }/Transfer/ExportExcel.shtml?id=${transfer.id}" class="layui-btn layui-btn-primary layui-btn layui-btn-mini">导出</a>
		<div class="layui-btn layui-btn-primary layui-btn layui-btn-mini" id="print">打印</div>
	</div>
</div>
<div class="layui-col-md12" style="text-align: center">
	<input class="layui-btn layui-btn-small layui-btn-primary" id="backBtn" type="button" value="返回">
</div>
<script>
	$("#print").click(function(){
		$(".clear-m").hide();
		$("#btn-area").hide();
		window.print();
		$("#btn-area").show();
		$(".clear-m").show();
	});
	$("#backBtn").click(function () {

        location.href = "${ctx }/Transfer.shtml";
    })
</script>
<%@ include file="../common/AdminFooter.jsp" %>