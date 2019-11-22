<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/AdminHeader.jsp" %>
<style type="text/css">

	div#outside.print *{
		font-size: 20px !important;
		letter-spacing: 3.5px;
	}

	#outside {
		width: 94%;
		margin-left: 2%;
		padding: 1%;
		background: #fff;
	}

	#userInfo{
		/* margin-left:10%; */
		padding:10px 0;
	}
	
	#userInfo>span{
		display: inline-block;
	    width: 25%;
	    margin: 2px 0;
	}
	
	#data-view table{
		width:100%;
		text-align: center;
	}

	table.layui-table * {
		border: 2px solid;
	}

	#data-view table td{
		height: 65px;
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
		<li>轮换业务</li>
		<li>通知书管理</li>
		<li>提货单</li>
		<li class="active">
			查看</li>
	</ol>
</div>
<div id="outside">
	<c:if test="${take.status eq '已完成' }">
	<div>
		<p></p>
		<span style="font-size:1.25em;">编号：${take.serial}</span>
		<p></p><p></p>
		<h1 id="title" style="text-align:center;font-size:29px !important;font-weight: bolder">提货单</h1>
		<p></p> <p></p>
		<p style="font-size:1.25em">${storeEnterprise.enterpriseName }：</p>
		<p>
		<span style="font-size:1.25em;line-height:3em;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请发给${title}仓库汽车板交货，
			其他费用按照《买卖合同》和《浙江省省级储备粮网上公开竞价销售规则》等有关规定执行。
		</span>
		</p>
	</div>
	</c:if>
	<div id="data-view">
		<table class="layui-table">
			<thead>
				<tr>
					<td>仓号</td>
					<td>品种</td>
					<%--<td>粮食单价(元/吨)</td>
					<td>存储方式</td>
					<td>接收单位</td>
					<td>联系方式</td>--%>
					<td>合同数量</td>
					<td>已开提货单</td>
					<td>本次发货</td>
					<td>累计已开提货单</td>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${take.rotateTakes }" var="item">
				<tr>
					<td >${item.storeEncode }</td>
					<td >${item.variety }</td>
					<td >${item.contract }</td>
					<td >${item.ladingBills }</td>
					<td >${item.thisShipment }</td>
					<td >${item.accumulatedBills }</td>
				</tr>
			</c:forEach>
				<tr>
					<td align="left" colspan="3">承储单位联系方式：${take.enterpriseTel }</td>
					<td align="left" colspan="3">公司业务部联系方式：85773087</td>
				</tr>
			</tbody>
		</table>
		<div>
			<p>
				<span style="font-size:1em; line-height:3em;">
					注：本单一式三联，第一联公司存档，第二联交货单位记账，第三联提货凭证。竞价销售公告、
					标的物明细表、规则、合同等资料请从www.zjlyjy.com上下载。
				</span>
			</p>
		</div>
	</div>
	<c:if test="${take.status eq '已完成'}">
	<div style="font-size:1.25em;margin:30px 0;text-align:center; position:relative;">
		<img src="${ctx}/images/tihuo.png" alt="需要盖章" style="opacity: 0.6;z-index: 1;position: absolute;right: -12px;bottom: -45px;width: 12em;">
		<div style="text-align:right;margin-top:50px;">浙江省储备粮管理有限公司</div>
		<div style="text-align:right;margin-right:92px;margin-top:25px;">业务部</div>
		<div style="text-align:right;margin-right:50px;margin-top:25px;">
            <fmt:formatDate value="${take.completeDate}" pattern="yyyy年MM月dd日" />
        </div>
	</div>
	<div id="btn-area">
	<%--<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" href="${ctx }/RotateNotif/Take/ExportExcel.shtml?id=${take.id}">导出</a>--%>
	<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" href="${ctx }/RotateNotif/Take/ExportExcelByTemplate.shtml?id=${take.id}">导出</a>
	<span class="layui-btn layui-btn-primary layui-btn layui-btn-mini" id="print">打印</span>
	</div>
	</c:if>
	<div align="center">
		<a style="align-content: center" id="closeBtn" href="${ctx }/RotateNotif/Take.shtml?type=Warehouse" class="layui-btn">关闭</a>
	</div>
</div>
<script>
	$("#print").click(function(){
		$(".breadcrumb").hide();
		$("#btn-area").hide();
		$("#closeBtn").hide();
		document.getElementsByTagName("title")[0].text = "."
		$("#outside").addClass("print")
		window.print();
		$("#outside").removeClass("print")
		document.getElementsByTagName("title")[0].text = "生产管理系统首页"
		$("#btn-area").show();
		$(".breadcrumb").show();
		$("#closeBtn").show();

	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>
