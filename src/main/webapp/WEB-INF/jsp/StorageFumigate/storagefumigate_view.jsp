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
		<h3>熏蒸记录</h3>
	</div>
	<table class="layui-table">
		<tbody>
			<tr>
				<td colspan="7">日期:<fmt:formatDate value="${t.reportTime}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td style="text-align:center">天气</td>
				<td style="text-align:left" colspan="2">${t.weather}</td>
				<td style="text-align:center">气温(℃)</td>
				<td style="text-align:right">${t.temperature}</td>
				<td style="text-align:center">气湿(RH%)</td>
				<td style="text-align:right">${t.humidity}</td>
			</tr>
			<tr>
				<td style="text-align:center" rowspan="4">仓情</td>
				<td style="text-align:center">仓房类型</td>
				<td style="text-align:left">${t.storehouseType}</td>
				<td style="text-align:center">仓房编号</td>
				<td style="text-align:left">${t.storehouse}</td>
				<td style="text-align:center">密封方法</td>
				<td style="text-align:left">${t.sealing}</td>
			</tr>
			<tr>
				<td style="text-align:center">仓房结构</td>
				<td style="text-align:left">${t.storehouseStructure}</td>
				<td style="text-align:center">气密性(s)</td>
				<td style="text-align:right">${t.gas}</td>
				<td style="text-align:center">入库时间</td>
				<td style="text-align:center"><fmt:formatDate value="${t.storeDate}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td style="text-align:center">仓房总体积(m³)</td>
				<td style="text-align:right">${t.storehouseVolume}</td>
				<td style="text-align:center">粮堆体积(m³)</td>
				<td style="text-align:right">${t.grainVolume}</td>
				<td style="text-align:center">空间体积(m³)</td>
				<td style="text-align:left">${t.spaceVolume}</td>
			</tr>
			<tr>
				<td style="text-align:center">堆放形式</td>
				<td style="text-align:left">${t.stack}</td>
				<td  style="text-align:center">粮堆高度(m)</td>
				<td style="text-align:right">${t.grainHeight}</td>
				<td style="text-align:center">上年度曾否熏蒸</td>
				<td style="text-align:left">${t.isFumigateLastYear}</td>
			</tr>
			
			<tr>
				<td style="text-align:center" rowspan="3">粮情</td>
				<td style="text-align:center">粮食品种</td>
				<td style="text-align:left">${t.grainType}</td>
				<td style="text-align:center">实际数量(t)</td>
				<td style="text-align:right">${t.realQuantity}</td>
				<td style="text-align:center">杂质(%)</td>
				<td style="text-align:right">${t.impurity}</td>
			</tr>
			<tr>
				<td style="text-align:center">仓温(℃)</td>
				<td style="text-align:right">${t.storageTemperature}</td>
				<td style="text-align:center">仓湿(RH%)</td>
				<td  style="text-align:right">${t.storageHumidity}</td>
				<td style="text-align:center">水分(%)</td>
				<td style="text-align:right">${t.dew}</td>
			</tr>
			<tr>
				<td style="text-align:center">最高粮温(℃)</td>
				<td style="text-align:right">${t.maxGrainTemperature}</td>
				<td style="text-align:center">最低粮温(℃)</td>
				<td style="text-align:right">${t.minGrainTemperature}</td>
				<td style="text-align:center">平均粮温(℃)</td>
				<td style="text-align:right">${t.averageGrainTemperature}</td>
			</tr>

			<tr>
				<td style="text-align:center" rowspan="3">虫情</td>
				<td colspan="6">虫粮等级:${t.maxPestDensity}</td>
			</tr>
			<tr>
				<td colspan="6">虫种及密度(头/kg):${t.among}</td>
			</tr>
			<tr>
				<td style="text-align:center">发现部位</td>
				<td style="text-align:left" colspan="2">${t.discoverySite}</td>
				<td  style="text-align:center">发现虫害时间</td>
				<td style="text-align:center" colspan="2"><fmt:formatDate value="${t.discoveryDate}" pattern="yyyy-MM-dd"/></td>
			</tr>


			<tr>
				<td style="text-align:center" rowspan="4">初次施药情况</td>
				<td style="text-align:center">药剂名称</td>
				<td style="text-align:left">${t.drugName}</td>
				<td  style="text-align:center">施药人数(人)</td>
				<td style="text-align:right">${t.personNumber}</td>
				<td style="text-align:center">施药方法</td>
				<td style="text-align:left">${t.drugMethod}</td>
			</tr>
			<tr>
				<td style="text-align:center">熏蒸方式</td>
				<td style="text-align:left" colspan="5">${t.fumigateType}</td>
			</tr>
			<tr>
				<td style="text-align:center" rowspan="2">单位用药量(g/m³)</td>
				<td style="text-align:right">空间:${t.unitDrugSpace}</td>
				<td style="text-align:center" rowspan="2">总用药量(g)</td>
				<td style="text-align:right">空间:${t.totalDrugSpace}</td>
				<td style="text-align:center" rowspan="2">施药时间(h)</td>
				<td style="text-align:center" rowspan="2">${t.applyDrugTime}</td>
			</tr>
			<tr>
				<td>粮堆:${t.unitDrugGrain}</td>
				<td>粮堆:${t.totalDrugGrain}</td>
			</tr>
			<tr>
				<td style="text-align:center" rowspan="3">补药情况</td>
				<td style="text-align:center">初次补药日期</td>
				<td style="text-align:center"><fmt:formatDate value="${t.firstSupplyDate}" pattern="yyyy-MM-dd"/></td>
				<td style="text-align:center">初次补药量(kg)</td>
				<td style="text-align:right">${t.firstSupplyQuantity}</td>
				<td style="text-align:center">初次补药操作时间(h)</td>
				<td style="text-align:center">${t.firstSupplyOperateTime}</td>
			</tr>
			<tr>
				<td style="text-align:center">补药方式</td>
				<td style="text-align:left" colspan="2">${t.supplyType}</td>
				<td  style="text-align:center">是否多次补药</td>
				<td style="text-align:left" colspan="2">${t.isMultiSupply}</td>
			</tr>
			<tr>
				<td style="text-align:center">总补药次数(次)</td>
				<td style="text-align:right">${t.totalSupplyCount}</td>
				<td style="text-align:center">总补药量(kg)</td>
				<td style="text-align:right" colspan="1">${t.totalSupplyQuantity}</td>
				<td style="text-align:center">总用药量(kg)</td>
				<td style="text-align:right" colspan="1">${t.totalSupplyDosage}</td>
			</tr>
			<tr>
				<td style="text-align:center">环流情况</td>
				<td style="text-align:center">环流模式</td>
				<td style="text-align:left">${t.circulationType}</td>
				<%--<td>累计环流时间(h)</td>
				<td>${t.totalCirculationTime}</td>--%>
				<td style="text-align:center">环流开始时间</td>
				<td style="text-align:center">${t.totalCirculationStarttime}</td>
				<td style="text-align:center">环流结束时间</td>
				<td style="text-align:center">${t.totalCirculationEndtime}</td>
			</tr>
			<tr>
				<td style="text-align:center">散气</td>
				<td style="text-align:center">散气日期</td>
				<td style="text-align:center"><fmt:formatDate value="${t.releaseGasDate}" pattern="yyyy-MM-dd"/></td>
				<td style="text-align:center">散气方式</td>
				<td style="text-align:left">${t.releaseGasType}</td>
				<td style="text-align:center">散气时间(d)</td>
				<td style="text-align:right">${t.releaseGasTime}</td>
			</tr>
			<tr>
				<td style="text-align:center">残渣处理</td>
				<td style="text-align:left" colspan="2">${t.draffDeal}</td>
				<td style="text-align:center" colspan="3">药剂包装物处理</td>
				<td style="text-align:left">${t.drugPackageDeal}</td>
			</tr>
			<tr>
				<td style="text-align:center">效果检查</td>
				<td style="text-align:left" colspan="6">${t.effectCheck}</td>
				
			</tr>
			<tr>
				<td style="text-align:center">备注</td>
				<td style="text-align:left" colspan="6">${t.remark}</td>
				
			</tr>
			<tr>
				<%--<td colspan="3">单位负责人:${t.unitChargeMan}</td>
				<td colspan="2">熏蒸指挥人:${t.fumigateCommander}</td>--%>
				<td style="text-align:center">审核人:</td>
				<td style="text-align:left" colspan="2">${t.storeMan}</td>
				<td style="text-align:center">填写人:</td>
				<td  style="text-align:left" colspan="3">${t.storeKeeper}</td>
			</tr>
			<%--<tr>
				&lt;%&ndash;<td colspan="3">安全监督员:${t.supervisor}</td>
				<td colspan="2">熏蒸操作员:${t.fumigateOperator}</td>&ndash;%&gt;

			</tr>--%>
		</tbody>
	</table>
	<div class="layui-row text-center" id="btn">
		<shiro:hasPermission name="StorageFumigate:exportDetail">
		<a href="../StorageFumigate/exportExcelOfDetail.shtml?id=${t.id}" class="layui-btn layui-btn-small" id="exportExcel">导出</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="StorageFumigate:print">
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