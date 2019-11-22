<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%-- <%@include file="../common/AdminHeader.jsp"%> --%>

<style>
	table tr td{
	width:150px;
	}
	h3{
	font-size: 18px;
    font-weight: bold;
	}
</style>
<div class="container clearfix" style="padding: 10px" id="printDiv">
	<div class="layui-row text-center">
		<h3>谷物冷却记录</h3>
	</div>
	<table class="layui-table">
		<tbody>
			<tr>
				<td colspan="8">日期:<fmt:formatDate value="${t.recordDate}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td>仓房类型</td>
				<td>${t.type}</td>
				<td>跨度*长度(直径m)</td>
				<td>${t.diameter}</td>
				<td>粮堆高度(m)</td>
				<td>${t.bulkHeight}</td>
				<td>粮堆体积(m)</td>
				<td>${t.bulkCubage}</td>
			</tr>
			<tr>
				<td>粮食品种</td>
				<td>${t.grainVariety}</td>
				<td>水分%</td>
				<td>${t.dew}</td>
				<td>杂质%</td>
				<td>${t.impurity}</td>
				<td>实际数量(t)</td>
				<td>${t.realQuantity}</td>
			</tr>
			<tr>
				<td>谷冷却机型号</td>
				<td>${t.valleyCoolerModel}</td>
				<td>数量(台)</td>
				<td>${t.valleyCoolerNum}</td>
				<td>总功率KW</td>
				<td>${t.kw}</td>
				<td>单位通风量[m³/(h.t)</td>
				<td>${t.mht}</td>
			</tr>
			<tr>
				<td>风网类型</td>
				<td colspan="3">${t.aspirationType}</td>
				<td>总风量(m³/h)</td>
				<td colspan="3">${t.mh}</td>
			</tr>
			<tr>
				<td>冷却目的</td>
				<td colspan="7">${t.purpose}</td>
				
			</tr>
			
			<tr>
				<td>通风时间</td>
				<td colspan="2">开始:<fmt:formatDate value="${t.startTime}" pattern="yyyy-MM-dd HH:mm" type="both"/></td>
				<td colspan="2">结束:<fmt:formatDate value="${t.endTime}" pattern="yyyy-MM-dd HH:mm" type="both"/></td>
				<td colspan="2">制冷量（KW）</td>
				<td>${t.totalTime}</td>
			</tr>
			<tr>
				<td colspan="2">冷却通风期间参数</td>
				<td colspan="2">平均值</td>
				<td colspan="2">最高值</td>
				<td colspan="2">最低值</td>
			</tr>
			<tr>
				<td colspan="2">气温(℃)</td>
				<td colspan="2">${t.tempAvg}</td>
				<td colspan="2">${t.tempMax}</td>
				<td colspan="2">${t.tempMin}</td>
			</tr>
			<tr>
				<td colspan="2">气湿(RH%)</td>
				<td colspan="2">${t.rhAvg}</td>
				<td colspan="2">${t.rhMax}</td>
				<td colspan="2">${t.rhMin}</td>
			</tr>
			<tr>
				<td colspan="2">冷通前粮温(℃)</td>
				<td colspan="2">${t.beforeAvg}</td>
				<td colspan="2">${t.beforeMax}</td>
				<td colspan="2">${t.beforeMin}</td>
			</tr>
			<tr>
				<td colspan="2">冷通后粮温(℃)</td>
				<td colspan="2">${t.afterAvg}</td>
				<td colspan="2">${t.afterMax}</td>
				<td colspan="2">${t.afterMin}</td>
			</tr>
			<tr>
				<td colspan="2">粮层温度梯度(℃/m)</td>
				<td colspan="2">${t.gradAvg}</td>
				<td colspan="2">${t.gradMax}</td>
				<td colspan="2">${t.gradMin}</td>
			</tr>
			<tr>
				<td colspan="2">粮层水分梯度(%/m)</td>
				<td colspan="2">${t.dewAvg}</td>
				<td colspan="2">${t.dewMax}</td>
				<td colspan="2">${t.dewMin}</td>
			</tr>
			<tr>
				<td colspan="2">冷却风温度(设定值/检测值)℃</td>
				<td colspan="6">${t.coolingAirTemp}</td>
			</tr>
			<tr>
				<td colspan="2">冷却风湿度(设定值/检测值)RH%</td>
				<td colspan="6">${t.coolingAirRh}</td>
			</tr>
			<tr>
				<td colspan="2">实际冷却处理能力(t/24h)</td>
				<td>${t.ability}</td>
				<td>总电耗KW.h</td>
				<td colspan="4">${t.totalPower}</td>
			</tr>
			<tr>
				<td>单位能耗(KW.h/℃.t)</td>
				<td>${t.energyConsum}</td>
				<td>电价(¥/(KW/h))</td>
				<td>${t.electrovalency}</td>
				<td colspan="2">单位耗资(¥/t)</td>
				<td colspan="2">${t.cost}</td>
			</tr>

			<tr>
				<td colspan="3">分管领导:${t.leader}</td>
				<td colspan="2">操作人:${t.operator}</td>
				<td colspan="3">保管员:${t.custodian}</td>
			</tr>
		</tbody>
	</table>
	<div class="layui-row text-center" id="btn">
		<shiro:hasPermission name="StorageCooling:exportDetail">
		<a href="../StorageCooling/exportExcelOfDetail.shtml?id=${t.id}" class="layui-btn layui-btn-small" id="exportExcel">导出</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="StorageCooling:print">
		<a href="javascript:void(0);" class="layui-btn layui-btn-small" id="print">打印</a>
		</shiro:hasPermission>
	</div>
</div>

<script>
$("#print").click(function(){
	
 	$("#btn").hide();
 	$("#printDiv").printArea();
 	$("#btn").show();

});
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>