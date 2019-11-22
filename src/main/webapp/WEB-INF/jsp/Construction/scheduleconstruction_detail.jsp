<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/AdminHeader.jsp" %>
<style type="text/css">
	@media print{
		input,.noprint{
			display:none
		}
		.printonly{
			display:block;
			width:100%
		}
	}
	@page {
		size: auto;  /* auto is the initial value */
		margin: 0mm; /* this affects the margin in the printer settings */
	}
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
		text-align: center;
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
		<%--<li>工程进度</li>--%>
		<%--<li class="active">查看</li>--%>
	<%--</ol>--%>
<%--</div>--%>
<div id="outside">
	<div id="data-view">
		<table class="layui-table">
			<thead>
				<tr>
					<td colspan="7">
						<h4 name="scheme-title" style="text-align:center;font-size:1.25em;">浙江省储备粮管理有限公司所属库</h4>
						<h4 name="scheme-title" style="text-align:center;font-size:1.25em;">基建项目完成情况报表</h4>
					</td>
				</tr>
				<tr>
					<td colspan="7">	
						<h4 name="scheme-title" style="text-align:center;font-size:1.05em;">${schedules[0].yearMonth }</h4>
					</td>
				</tr>
				<tr>
					<td colspan="7">	
						<h4 name="scheme-title" style="text-align:right;font-size:1em;">投资单位：万元</h4>
					</td>
				</tr>
				<tr>
					<td>序号</td>
					<td>项目名称</td>
					<td>批准投资</td>
					<td>本月完成投资</td>
					<td>累计完成投资</td>
					<td>形象进度</td>
					<td>备注</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${schedules }" var="schedule">
				<tr>
					<td colspan="7" style="text-align:left;">项目单位：${schedule.projectUnit }</td>
				</tr>
				<c:forEach items="${schedule.scheduleDetail }" var="item">
				<tr>
					<td style="text-align: right" name="serial">
						${item.serial }
					</td>
					<td style="text-align: left" name='projectName'>
						${item.projectName}
					</td>
					<td style="text-align: right" name='approvedInvestment'>
						${item.approvedInvestment}
					</td>
					<td style="text-align: right" name='currentInvestment'>
						${item.currentInvestment}
					</td>
					<td style="text-align: right" name='accumulateInvestment'>
						${item.accumulateInvestment}
					</td>
					<td style="text-align: left" name='progress'>
						${item.progress }
					</td>
					<td style="text-align: left" name='remark'>
					<!-- 	<div class="buttonArea">备注</div>
						<textarea style="display:none;">${item.remark }</textarea> -->
						${item.remark }
					</td>
				</tr>
				</c:forEach>
				<tr>
					<td colspan="2">小计</td>
					<td style="text-align: right">${schedule.approvedInvestmentSubtotal }</td>
					<td style="text-align: right">${schedule.currentInvestmentSubtotal }</td>
					<td style="text-align: right">${schedule.accumulateInvestmentSubtotal }</td>
					<td></td>
					<td></td>
				</tr>
				</c:forEach>
				<c:if test="${collect }">
				<tr>
					<td colspan="2">合计</td>
					<td style="text-align: right">${approvedInvestmentTotal }</td>
					<td style="text-align: right">${accumulateInvestmentTotal }</td>
					<td style="text-align: right">${currentInvestmentTotal }</td>
					<td></td>
					<td></td>
				</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<div id="button-tool">
		<div id="print" class="buttonArea">打印</div>
		<a href="${ctx }/Construction/Schedule/ExprotExcel.shtml?id=${schedules[0].id}${collect ? '&collect=':''}${collect ? schedules[0].yearMonth : ''}${needreported ne null?'&needreported=':''}${needreported ne null?needreported:''}" class="buttonArea">导出</a>
	</div>
</div>
<script>
	$("td[name='remark']>.buttonArea").click(function(){
		layer.open({
			  title:false,
			  area: ['500px', '300px'],
			  type: 1,
			  content:"<textarea readonly style='width:95%;height:95%;border:none;resize:none;padding:5%'>"+$(this).next("textarea").val()+"</textarea>"
		});  
	});
	
	$("#print").click(function(){
		$(".buttonArea,.breadcrumb").hide();
		window.print();
		$(".buttonArea,.breadcrumb").show();
	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>