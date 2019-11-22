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
		<%--<li>年度计划</li>--%>
		<%--<li class="active">查看</li>--%>
	<%--</ol>--%>
<%--</div>--%>
<div id="outside">
	<h4 name="scheme-title" style="text-align:center;font-size:2em;">${plans[0].year }年度基建项目投资计划表</h4>
	<div id="data-view">
		<table class="layui-table">
			<thead>
				<tr>
					<td rowspan="2">序号</td>
					<td rowspan="2">项目名称</td>
					<td rowspan="2">建设内容</td>
					<td rowspan="2">建设起止年限</td>
					<td rowspan="2">建设性质</td>
					<td rowspan="2">总投资(万元)</td>
					<td rowspan="2">资金来源</td>
					<td colspan="2">上年底累计完成</td>
					<td colspan="3">本年计划</td>
					<td rowspan="2">备注</td>
				</tr>
				<tr>
					<td>财务支出(万元)</td>
					<td>投资额(万元)</td>
					<td>财务支出(万元)</td>
					<td>投资额(万元)</td>
					<td>形象进度</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${plans }" var="plan">
				<tr>
					<td colspan="14" style="text-align:left;">${plan.projectUnit }</td>
				</tr>
				<c:forEach items="${plan.planDetail }" var="item">
				<tr>
					<td style="text-align: right"  name="serial">
						${item.serial }
					</td>
					<td style="text-align: left" name='projectName'>
						${item.projectName}
					</td>
					<td style="text-align: left" name='constructionContent'>
						${item.constructionContent}
					</td>
					<td style="text-align: center" name='constructionStart'>
						${fn:split(item.constructionStart,"-")[0]}-${fn:split(item.constructionEnd,"-")[0]}
					</td>
					<td style="text-align: left" name='constructionNature'>
						${item.constructionNature}
					</td>
					<td style="text-align: right" name='investment'>
						${item.investment }
					</td>
					<td style="text-align: left" name='fundsProvid'>
						${item.fundsProvid }
					</td>
					<td style="text-align: right" name='lastExpend'>
						${item.lastExpend }
					</td>
					<td style="text-align: right" name='lastInvestment'>
						${item.lastInvestment }
					</td>
					<td style="text-align: right" name='currentExpend'>
						${item.currentExpend }
					</td>
					<td style="text-align: right" name='currentInvestment'>
						${item.currentInvestment }
					</td>
					<td style="text-align: left" name='currentProgress'>
						${item.currentProgress }
					</td>
					<td style="text-align: left" name='remark'>
						<%-- <div class="layui-btn layui-btn-primary layui-btn layui-btn-mini">备注</div>
						<textarea style="display:none;">${item.remark }</textarea> --%>
						${item.remark }
					</td>
				</tr>
				</c:forEach>
				<tr>
					<td colspan="3">小计</td>
					<td></td>
					<td></td>
					<td style="text-align: right"><fmt:formatNumber type="number" value="${plan.investmentSubtotal}" pattern="0.00" maxFractionDigits="2"/></td>
					<td></td>
					<td style="text-align: right">${plan.lastExpendSubtotal }</td>
					<td style="text-align: right">${plan.lastInvestmentSubtotal }</td>
					<td style="text-align: right">${plan.currentExpendSubtotal }</td>
					<td style="text-align: right">${plan.currentInvestmentSubtotal }</td>
					<td></td>
					<td></td>
				</tr>
				</c:forEach>
				<c:if test="${collect }">
				<tr>
					<td colspan="3">合计</td>
					<td></td>
					<td></td>
					<td style="text-align: right">${investmentTotal }</td>
					<td></td>
					<td style="text-align: right">${lastExpendTotal }</td>
					<td style="text-align: right">${lastInvestmentTotal }</td>
					<td style="text-align: right">${currentExpendTotal }</td>
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
		<a class="buttonArea" href="${ctx }/Construction/Plan/ExportExcel.shtml?id=${plans[0].id}<c:if test="${collect}">&collect=${plans[0].year }</c:if>">导出</a>
	</div>
</div>
<script>
	$("td[name='remark']>.layui-btn layui-btn-mini").click(function(){
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