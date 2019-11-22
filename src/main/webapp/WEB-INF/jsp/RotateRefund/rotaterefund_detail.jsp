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
		font-family: SimSun;
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
		font-size: 1em;
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
		<li>竞标管理</li>
		<li>保证金退还</li>
		<li class="active">
			查看</li>
	</ol>
</div>
<div id="outside">
	<div>
		<p></p>
		<p></p><p></p>
		<span style="font-size:1.25em;">编号：${modelMain.serial}</span>
		<p></p><p></p>
		<h1 id="title" style="text-align:center;font-size:34px !important;font-weight: bolder;font-family:'Microsoft YaHei'" >省级储备粮竞价履约保证金退还联系单</h1>
		<p></p> <p></p>
		<p></p>
		<p style="font-size:1.25em !important;">浙江省粮油交易信息中心：</p>
		<p>
		<span style="font-size:1.25em !important;line-height:3em; ">
			&nbsp;&nbsp;&nbsp;请将下列单位的履约保证金退还：
		</span>
		</p>
		<p align="right" style="font-size:1.25em !important;">单位：元</p>
	</div>
	<div id="data-view">
		<table class="layui-table">
			<thead>
				<tr>
					<td >单位</td>
					<td style="min-width: 150px">交易时间</td>
					<%--<td>粮食单价(元/吨)</td>
					<td>存储方式</td>
					<td>接收单位</td>
					<td>联系方式</td>--%>
					<td>销售或采购</td>
					<td style="min-width: 200px">标的</td>
					<td style="min-width: 100px">数量</td>
					<td style="min-width: 100px">金额</td>
					<td>备注</td>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${model }" var="item">
				<tr class="data-tr">
					<td name="clientName" align="center">${item.company}</td>
					<td name="dealDate" align="center">${item.dealDates}</td>
					<td name="type" align="center">${item.dealType}</td>
					<td name="bidSerial" align="center" >
							${item.bidSerial }
					</td>
					<td name="number" align="center">${item.dealNumber}</td>
					<td name="refundAmount" align="center">${item.refundAmount}
					</td>
					<td name="remark">${item.remark}
					</td>
			</c:forEach>
				<tr>
					<td align="center">合计</td>
				    <td></td>
				    <td></td>
				    <td></td>
				    <td align="center">${totalNumber}</td>
					<td align="center">${totalAmount}</td>
				    <td></td>
				</tr>
			</tbody>
		</table>
	</div>
<p></p>
<p></p>
	<div style="font-size:1.25em;margin:120px 80px;text-align:center; position:relative;">
		<img src="${ctx}/images/tihuo.png" alt="需要盖章" style="opacity: 0.6;z-index: 1;position: absolute;right: 10px;bottom: -45px;width: 12em;">
		<div style="text-align:right;margin-top:50px;">浙江省储备粮管理有限公司</div>
		<div style="text-align:right;margin-right:92px;margin-top:25px;">业务部</div>
		<div style="text-align:right;margin-right:50px;margin-top:25px;">
            <fmt:formatDate value="${modelMain.handleTime}" pattern="yyyy年M月dd日" />
        </div>
	</div>
	<div id="btn-area">
	<%--<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" href="${ctx }/RotateNotif/Take/ExportExcel.shtml?id=${take.id}">导出</a>--%>
	<%--<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" href="${ctx }/RotateNotif/Take/ExportExcelByTemplate.shtml?id=${take.id}">导出</a>--%>
	<span class="layui-btn layui-btn-primary layui-btn layui-btn-mini" id="print">打印</span>
	</div>
	<div align="center">
		<a style="align-content: center" id="closeBtn" href="${ctx }/rotateRefund/main.shtml" class="layui-btn">关闭</a>
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
