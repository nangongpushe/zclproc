<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <%@include file="../common/AdminHeader.jsp"%> --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!-- <div class="row clear-m"> -->
<!-- 	<ol class="breadcrumb"> -->
<!-- 		<li>轮换业务</li> -->
<!-- 		<li>竞标管理</li> -->
<!-- 		<li class="active">标的物明细</li> -->
<!-- 	</ol> -->
<!-- </div> -->

<div class="container-box clearfix" style="padding: 10px">
	

	<fieldset class="layui-elem-field layui-field-title text-center"
		style="margin-top: 20px;">
		<legend>${model.bidName}</legend>
	</fieldset>

	<div class="layui-row">
		<c:if test="${fn:contains(model.bidType,'采购')}">
			<div class="layui-col-md10">
				<span>招标人:${model.tenderee}</span>
			</div>
		</c:if>


	</div>
	<div class="layui-row">
		<c:if test="${!fn:contains(model.bidType,'采购')}">
			<div class="layui-col-md6">
				<span>卖出人:${model.saler}</span>
			</div>
			<div class="layui-col-md6">
				<span>卖出时间:<fmt:formatDate value="${model.saleDate}" pattern="yyyy-MM-dd" /></span>
			</div>
		</c:if>
		<br/><div class="layui-col-md10">
				<span>备注:</span>
				<textarea style="resize:none" readonly  placeholder="请输入内容" class="layui-textarea" name="remark" maxlength="200">${model.remark}</textarea>
			</div>
	</div>
	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
			<c:if test="${fn:contains(model.bidType,'采购')}">
				<tr>
					<td align="center">序号</td>
					<td align="center">标段</td>
					<td align="center">企业</td>
					<td align="center">库点</td>
					<td align="center">仓号</td>
					<td align="center">数量(吨)</td>
					<td align="center">产地</td>
					<td align="center">收获年份</td>
					<td align="center">包装方式</td>
					<td align="center">颗粒</td>
					<td align="center">交易开始日期</td>
					<td align="center">交易结束日期</td>
					<td align="center">日接受能力(吨)</td>
					<td align="center">运输类型</td>
					<td align="center">库点联系人</td>
					<td align="center">联系电话</td>
					<td align="center">质量等级</td>
					<td align="center">货款支付免息截止日期</td>
					<td align="center">容重（g/L）</td>
					<td align="center">不完善粒（%）</td>
					<td align="center">杂质总量（%）</td>
					<td align="center">其中：矿物质（%）</td>
					<td align="center">水分</td>
					<td align="center">硬度指数</td>
					<td align="center">色泽</td>
					<td align="center">气味</td>
					<td align="center">面筋吸水量（%）</td>
					<td align="center">品尝评分值（分）</td>
					<td align="center">黄曲霉毒素B1（μg/kg）</td>
					<td align="center">脱氧雪腐镰刀菌（μg/kg）</td>
					<td align="center">玉米赤霉烯酮（μg/kg）</td>
					<td align="center">出糙(%)</td>
					<td align="center">杂质(%)</td>
					<td align="center">黄粒米(%)</td>
					<td align="center">小麦湿面筋(%)</td>
					<td align="center">酸价(KOH)(mg/g)</td>
					<td align="center">过氧化值(mmol/kg)</td>
					<td align="center">三唑磷(mg/kg)</td>
					<td align="center">不溶性杂质(%)</td>
					<td align="center">乐果(mg/kg)</td>
					<td align="center">亚油酸（%）</td>
					<td align="center">亚麻酸（%）</td>
					<td align="center">加热试验(280℃)</td>
					<td align="center">呕吐毒素含量(μg/kg)</td>
					<td align="center">总汞(以Hg计)(mg/kg)</td>
					<td align="center">总砷(mg/kg)</td>
					<td align="center">整精米率(%)</td>
					<td align="center">无机砷(mg/kg)</td>
					<td align="center">棕桐酸（%）</td>
					<td align="center">棕榈酸（%）</td>
					<td align="center">毒死蜱(mg/kg)</td>
					<td align="center">比重（d2020）</td>
					<td align="center">气味、滋味</td>
					<td align="center">水分及不挥发物(%)</td>
					<td align="center">水分及挥发物(%)</td>
					<td align="center">水胺硫磷(mg/kg)</td>
					<td align="center">汞(mg/kg)</td>
					<td align="center">油酸（%）</td>
					<td align="center">溶剂残留量（mg/kg）</td>
					<td align="center">硬脂酸（%）</td>
					<td align="center">脂肪酸值（mgKOH/100g干基）</td>
					<td align="center">芥酸（%）</td>
					<td align="center">花生烯酸（%）</td>
					<td align="center">花生酸（%）</td>
					<td align="center">谷外糙米(%)</td>
					<td align="center">铅(以Pb计)(mg/kg)</td>
					<td align="center">镉(以Cd计)(mg/kg)</td>
					<td align="center">马拉硫磷(mg/kg)</td>

				</tr>
			</c:if>
			<c:if test="${!fn:contains(model.bidType,'采购')}">
				<tr>
					<td align="center">序号</td>
					<td align="center">标段</td>
					<td align="center">粮食品种</td>
					<td align="center">数量</td>
					<td align="center">产地</td>
					<td align="center">入库年度</td>
					<td align="center">存储方式</td>
					<td align="center">提货起始日期</td>
					<td align="center">提货截止日期</td>
					<td align="center">交货所属库点及仓库</td>
					<td align="center">容重（g/L）</td>
					<td align="center">不完善粒（%）</td>
					<td align="center">杂质总量（%）</td>
					<td align="center">其中：矿物质（%）</td>
					<td align="center">水分</td>
					<td align="center">硬度指数</td>
					<td align="center">色泽</td>
					<td align="center">气味</td>
					<td align="center">面筋吸水量（%）</td>
					<td align="center">品尝评分值（分）</td>
					<td align="center">黄曲霉毒素B1（μg/kg）</td>
					<td align="center">脱氧雪腐镰刀菌（μg/kg）</td>
					<td align="center">玉米赤霉烯酮（μg/kg）</td>


					<!-- update start -->
					<td align="center">铅(以Pb计)(mg/kg)</td>
					<td align="center">镉(以Cd计)(mg/kg)</td>
					<td align="center">汞(mg/kg)</td>
					<td align="center">总砷(mg/kg)</td>
					<td align="center">无机砷(mg/kg)</td>
					<td align="center">出糙(%)</td>
					<td align="center">杂质(%)</td>
					<td align="center">谷外糙米(%)</td>
					<td align="center">黄粒米(%)</td>
					<td align="center">整精米率(%)</td>
					<td align="center">脂肪酸值（mgKOH/100g干基）</td>
					<td align="center">乐果(mg/kg)</td>
					<td align="center">三唑磷(mg/kg)</td>
					<td align="center">毒死蜱(mg/kg)</td>
					<td align="center">水胺硫磷(mg/kg)</td>
					<td align="center">马拉硫磷(mg/kg)</td>
					<td align="center">气味、滋味</td>
					<td align="center">水分及挥发物(%)</td>
					<td align="center">不溶性杂质(%)</td>
					<td align="center">加热试验(280℃)</td>
					<td align="center">酸价(KOH)(mg/g)</td>
					<td align="center">过氧化值(mmol/kg)</td>
					<td align="center">溶剂残留量（mg/kg）</td>
					<td align="center">棕榈酸（%）</td>
					<td align="center">硬脂酸（%）</td>
					<td align="center">油酸（%）</td>
					<td align="center">亚油酸（%）</td>
					<td align="center">亚麻酸（%）</td>
					<td align="center">花生酸（%）</td>
					<td align="center">花生一烯酸（%）</td>
					<td align="center">芥酸（%）</td>
					<td align="center">比重（d2020）</td>
					<!-- update end -->

					<td align="center">存储品质判定</td>
					<td align="center">质量等级</td>
				</tr>
			</c:if>

		</thead>
		<tbody>
			<c:if test="${fn:contains(model.bidType,'采购')}">
				<c:forEach items="${model.purchaseList}" var="item"
					varStatus="status">
					<tr>
						<td align="right">${status.count}</td>
						<td align="right">${item.bidSerial}</td>
						<td align="left">${item.enterprise}</td>
						<td align="left">${item.company}</td>
						<td align="left">${item.storeHouse}</td>
						<td align="right">${item.quantity}</td>
						<td align="left">${item.produceArea}</td>
						<td align="center">${item.produceYear}</td>
						<td align="left">${item.packageType}</td>
						<td align="left">${item.grainShape}</td>
						<td align="center">${item.deliveryStart}</td>
						<td align="center">${item.deliveryEnd}</td>
						<td align="right">${item.dailyReceptivity}</td>
						<td align="left">${item.transportType}</td>
						<td align="left">${item.contact}</td>
						<td align="left">${item.contactNumber}</td>
						<td align="left">${item.planLevel}</td>
						<td align="left">${item.loanPaymentEndDate}</td>
						<td align="right">${item.unitWeight}</td>
						<td align="right">${item.unsoundGrain}</td>
						<td align="right">${item.impurity}</td>
						<td align="right">${item.mineral}</td>
						<td align="right">${item.dew}</td>
						<td align="right">${item.hardness}</td>
						<td align="right">${item.tincture}</td>
						<td align="left">${item.smell}</td>
						<td align="right">${item.waterAbsorption}</td>
						<td align="right">${item.tastingScore}</td>
						<td align="right">${item.AFB1}</td>
						<td align="right">${item.fusariumSolani}</td>
						<td align="right">${item.zearalenone}</td>
						<td align="right">${item.brownRiceRecovery}</td>
						<td align="right">${item.adulteration}</td>
						<td align="right">${item.yellowColouredRice}</td>
						<td align="right">${item.wetWheatGluten}</td>
						<td align="right">${item.acidValue}</td>
						<td align="right">${item.peroxideValue}</td>
						<td align="right">${item.triazophos}</td>
						<td align="right">${item.insolubleImpurities}</td>
						<td align="right">${item.dimethoate}</td>
						<td align="right">${item.linoleicAcid}</td>
						<td align="right">${item.linolenicAcid}</td>
						<td align="right">${item.heatingTest}</td>
						<td align="right">${item.vomitoxinContent}</td>
						<td align="right">${item.totalMercury}</td>
						<td align="right">${item.arsenic}</td>
						<td align="right">${item.headRice}</td>
						<td align="right">${item.inorganicArsenic}</td>
						<td align="right">${item.palmiticAcidP}</td>
						<td align="right">${item.palmiticAcid}</td>
						<td align="right">${item.dursban}</td>
						<td align="right">${item.specificGravity}</td>
						<td align="right">${item.odour}</td>
						<td align="right">${item.moistureAndNvolatileMatter}</td>
						<td align="right">${item.moistureAndVolatileMatter}</td>
						<td align="right">${item.isocarbophos}</td>
						<td align="right">${item.mercury}</td>
						<td align="right">${item.oleicAcid}</td>
						<td align="right">${item.residualSolvent}</td>
						<td align="right">${item.stearicAcid}</td>
						<td align="right">${item.fattyAcid}</td>
						<td align="right">${item.erucicAcid}</td>
						<td align="right">${item.arachidonicAcid}</td>
						<td align="right">${item.arachidicAcid}</td>
						<td align="right">${item.huskedRiceInPeddy}</td>
						<td align="right">${item.lead}</td>
						<td align="right">${item.chromium}</td>
						<td align="right">${item.malathion}</td>


					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${!fn:contains(model.bidType,'采购')}">
				<c:forEach items="${model.saleList}" var="item"
					varStatus="status">
					<tr>						
						<td align="right">${status.count}</td>
						<td align="right">${item.bidSerial}</td>
						<td align="left">${item.grainType}</td>
						<td align="right">${item.total}</td>
						<td align="left">${item.produceArea}</td>
						<td align="center">${item.warehouseYear}</td>
						<td align="left">${item.storageType}</td>
						<td align="center">${item.takeStart}</td>
						<td align="center">${item.takeEnd}</td>
						<td align="left">${item.deliveryPlace}${item.storehouse}</td>
						<td align="right">${item.unitWeight}</td>
						<td align="right">${item.unsoundGrain}</td>
						<td align="right">${item.impurity}</td>
						<td align="right">${item.mineral}</td>
						<td align="right">${item.dew}</td>
						<td align="right">${item.hardness}</td>
						<td align="right">${item.tincture}</td>
						<td align="left">${item.smell}</td>
						<td align="right">${item.waterAbsorption}</td>
						<td align="right">${item.tastingScore}</td>
						<td align="right">${item.AFB1}</td>
						<td align="right">${item.fusariumSolani}</td>
						<td align="right">${item.zearalenone}</td>

						<!-- update start -->
						<td align="right">${item.lead}</td>
						<td align="right">${item.chromium}</td>
						<td align="right">${item.mercury}</td>
						<td align="right">${item.arsenic}</td>
						<td align="right">${item.inorganicArsenic}</td>
						<td align="right">${item.brownRiceRecovery}</td>
						<td align="right">${item.adulteration}</td>
						<td align="right">${item.huskedRiceInPeddy}</td>
						<td align="right">${item.yellowColouredRice}</td>
						<td align="right">${item.headRice}</td>
						<td align="right">${item.fattyAcid}</td>
						<td align="right">${item.dimethoate}</td>
						<td align="right">${item.triazophos}</td>
						<td align="right">${item.dursban}</td>
						<td align="right">${item.isocarbophos}</td>
						<td align="right">${item.malathion}</td>
						<td align="right">${item.odour}</td>
						<td align="right">${item.moistureAndVolatileMatter}</td>
						<td align="right">${item.insolubleImpurities}</td>
						<td align="right">${item.heatingTest}</td>
						<td align="right">${item.acidValue}</td>
						<td align="right">${item.peroxideValue}</td>
						<td align="right">${item.residualSolvent}</td>
						<td align="right">${item.palmiticAcid}</td>
						<td align="right">${item.stearicAcid}</td>
						<td align="right">${item.oleicAcid}</td>
						<td align="right">${item.linoleicAcid}</td>
						<td align="right">${item.linolenicAcid}</td>
						<td align="right">${item.arachidicAcid}</td>
						<td align="right">${item.arachidicOneAcid}</td>
						<td align="right">${item.erucicAcid}</td>
						<td align="right">${item.specificGravity}</td>
						<!-- update end -->

						<td align="left">${item.storageQuality}</td>
						<td align="left">${item.planLevel}</td>
					</tr>
				</c:forEach>
			</c:if>

		</tbody>
	</table>


	<c:if test="${myFile!=null}">
		<div style="border: 1px #D8D8D8 solid; margin-top: 10px;">
			<div
				style="background-color: #f8f8f8; height: 40px; line-height: 40px">
				<label style="padding-left: 20px">附件</label>
			</div>
			<div class="opinion_list clearfix" style="margin-left: 20px;">
				<div class="pull-left"
					style="width: 43px; height: 43px; background-color: #f6f7f7; margin-top: 10px">
					<i class="layui-icon 21cake_list"
						style="font-size: 40px; color: #1E9FFF;"></i>
				</div>

				<div class="pull-left" style="margin-top:20px;">
					<span>${myFile.fileName }</span>
					<a href="../sysFile/download.shtml?fileId=${myFile.id}" style="color: #0000FF; margin-left: 20px">下载</a>
					<div style="display:inline-block;font-size:20px;" id="openExce">
						<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
							预览
						</a>
						<a href="javascript:openAnnex('${model.groupID}')" id="openFile" style="display: none">
							预览
						</a>
					</div>
				</div>
			</div>
		</div>
	</c:if>

</div>



<script>
    if ("${model.groupID}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
// 	$("button#print").click(function(){
// 		$("div#parent").hide();
// 		window.print();
// 		$("div#parent").show();
// 	});
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>