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
		<h3>机械通风记录</h3>
	</div>
	<table class="layui-table">
		<tbody>
			<tr>
				<td colspan="5">填制日期:<fmt:formatDate value="${t.reportTime}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td style="text-align:center">粮食品种</td>
				<td>${t.grainType}</td>
				<td colspan="2"  style="text-align:center">实际数量(t)</td>
				<td style="text-align:right">${t.realQuantity}</td>
			</tr>
			<tr>
				<td style="text-align:center">通风目的</td>
				<td><textarea readonly rows='3' cols='30'style="text-align:left">${t.airAim}</textarea></td>
				<td colspan="2" style="text-align:center">粮堆高度(m)</td>
				<td  style="text-align:right">${t.grainBulkHeight}</td>
			</tr>
			<tr>
				<td style="text-align:center">粮堆体积(m³)</td>
				<td style="text-align:right">${t.grainBulkVolume}</td>
				<td colspan="2" style="text-align:center">风机型号</td>
				<td style="text-align:left">${t.fanVersion}</td>
			</tr>
			<tr>
				<td style="text-align:center">风机功率(KW)</td>
				<td  style="text-align:right">${t.fanPower}</td>
				<td colspan="2" style="text-align:center">风机数量(台)</td>
				<td  style="text-align:right">${t.fanQuantity}</td>
			</tr>
			<tr>
				<td style="text-align:center">总风量(m³/h)</td>
				<td style="text-align:right">${t.totalAirVolume}</td>
				<td colspan="2" style="text-align:center">风道类型</td>
				<td style="text-align:left">${t.airDuctType}</td>
			</tr>
			<tr>
				<td style="text-align:center">风网布置</td>
				<td style="text-align:left">${t.airNetLayout}</td>
				<td colspan="2" style="text-align:center">风道数量(条)</td>
				<td style="text-align:right">${t.airDuctQuantity}</td>
			</tr>
			<tr>
				<td style="text-align:center">风道间距(m)</td>
				<td style="text-align:right">${t.airDuctGap}</td>
				<td colspan="2" style="text-align:center">单位通风量(m³/h.t)</td>
				<td style="text-align:right">${t.averageAirVolume}</td>
			</tr>
			<tr>
				<td style="text-align:center">通风方式(吸/压)</td>
				<td style="text-align:left">${t.airType}</td>
				<td colspan="2" style="text-align:center">空气途径比</td>
				<td style="text-align:right">${t.airPathRatio}</td>
			</tr>
			<tr>
				<td style="text-align:center">开始通风时间</td>
				<td style="text-align:center"><fmt:formatDate value="${t.airStartTime}" pattern="yyyy-MM-dd"/></td>
				<td colspan="2" style="text-align:center">停止通风时间</td>
				<td  style="text-align:center"><fmt:formatDate value="${t.airEndTime}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td style="text-align:center">累计通风时间(h):</td>
				<td style="text-align:center" colspan="4">${t.totalAirTime}</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center">通风期间参数:</td>
				<td style="text-align:center">最高值</td>
				<td style="text-align:center">最低值</td>
				<td style="text-align:center">平均值</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center">大气温度(℃):</td>
				<td style="text-align:right">${t.maxAirTemperature}</td>
				<td style="text-align:right">${t.minAirTemperature}</td>
				<td style="text-align:right">${t.averageAirTemperature}</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center">大气湿度(RH%):</td>
				<td style="text-align:right">${t.maxAirHumidity}</td>
				<td style="text-align:right">${t.minAirHumidity}</td>
				<td style="text-align:right">${t.averageAirHumidity}</td>
			</tr>
			<tr>
				<td rowspan="2" style="text-align:center">粮食温度(℃):</td>
				<td  style="text-align:center">通风前</td>
				<td style="text-align:right">${t.maxGrainTemperature}</td>
				<td style="text-align:right">${t.minGrainTemperature}</td>
				<td style="text-align:right">${t.averageGrainTemperature}</td>
			</tr>
			<tr>
				<td style="text-align:center">通风后</td>
				<td style="text-align:right">${t.maxGrainTemperatureNew}</td>
				<td style="text-align:right">${t.minGrainTemperatureNew}</td>
				<td style="text-align:right">${t.averageGrainTemperatureNew}</td>
			</tr>
			<tr>
				<td style="text-align:center" rowspan="2">粮食水分(%):</td>
				<td style="text-align:center">通风前</td>
				<td style="text-align:right">${t.maxGrainDew}</td>
				<td style="text-align:right">${t.minGrainDew}</td>
				<td style="text-align:right">${t.averageGrainDew}</td>
			</tr>
			<tr>
				<td style="text-align:center">通风后</td>
				<td style="text-align:right">${t.maxGrainDewNew}</td>
				<td style="text-align:right">${t.minGrainDewNew}</td>
				<td style="text-align:right">${t.averageGrainDewNew}</td>
			</tr>
			<tr>
				<td style="text-align:center">总电耗(kW•h)</td>
				<td style="text-align:right" colspan="2">${t.totalPowerConsumption}</td>
				<td style="text-align:center">单位能耗(kW•h/℃•t或kW•h/1%水分•t)</td>
				<td style="text-align:right">${t.averagePowerConsumption}</td>
			</tr>
			<tr>
				<td style="text-align:center">备注</td>
				<td colspan="4">
					<textarea readonly rows='3' cols='75'>${t.remark}</textarea></td>
			</tr>
			<tr>
				<td style="text-align:center">审核人:</td>
				<%--仓储部负责人改为--审核人--%>
				<td style="text-align:left" colspan="2">${t.chargeMan}</td>
				<td colspan="2" style="text-align:center">操作人:${t.operator}</td>
				<%--<td colspan="2">保管员:${t.storeMan}</td>--%>
			</tr>
		</tbody>
	</table>
	<div class="layui-row text-center" id="btn">
	<shiro:hasPermission name="StorageMachineAir:exportDetail">
		<a href="../StorageMachineAir/exportExcelOfDetail.shtml?id=${t.id}" class="layui-btn layui-btn-small" id="exportExcel">导出</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="StorageMachineAir:print">
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