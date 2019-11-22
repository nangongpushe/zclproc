<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
</head>
</html>
<body  style="background-color:#fff;overflow:auto!important;">
<!-- 正文 -->
<div id="page-wrapper" style="margin:0;top:0;min-height: 100%;">
<div class="row clear-m">
	<ol class="breadcrumb">
		<c:if test="${type==''}">
			<li>仓储管理</li>
			<li>粮油情监测管理</li>
			<li><a href="${ctx }/storageGrainInspection.shtml">粮情检测记录</a></li>
		</c:if>
		<c:if test="${type=='dc'}">
			<li>代储监管</li>
			<li>报表台账</li>
			<li><a href="${ctx }/storageGrainInspection.shtml">粮情检测记录</a></li>
		</c:if>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
   	<input type="hidden" name="id" value="${grainInspection.id }"/>
   	<div class="layui-row ">
	   	<div class="layui-col-md6">
			<span>所属库点：</span>
			<span>${grainInspection.warehouse }</span>
		</div>
		<div class="layui-col-md6">
	   		<span>仓房编号：</span>
			<span>${grainInspection.encode }</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
           	<span>填报日期：</span>
           	<span>
				${grainInspection.reportDateStr }
				<%--<fmt:formatDate value='${grainInspection.reportDate }' type='date' pattern='yyyy-MM-dd'/>--%>
			</span>
		</div>
		<div class="layui-col-md6">
           	<span>天气：</span>
           	<span>${grainInspection.weather }</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
	    	<span>实际数量（吨）：</span>
	    	<span>${grainInspection.quantity }</span>
	   	</div>
		<%--<div class="layui-col-md6">
		    <span>水分（%）：</span>
		    	<span>${grainInspection.dew }</span>
		</div>--%>
		<div class="layui-col-md6">
			<span>仓温（℃）：</span>
			<span>${grainInspection.storehouseTemp }</span>
		</div>
	</div>
	<%--<div class="layui-row ">
		<div class="layui-col-md6">
        	<span>杂质（%）：</span>
         	<span>${grainInspection.impurity }</span>
		</div>
		<div class="layui-col-md6">
			<span>仓温（℃）：</span>
            <span>${grainInspection.storehouseTemp }</span>
		</div>
	</div>--%>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>气温（℃）：</span>
			<span>${grainInspection.temperature }</span>
		</div>
        <div class="layui-col-md6">
        	<span>仓湿（RH%）：</span>
        	<span>${grainInspection.storehouseWet }</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
	    	<span>气湿（RH%）：</span>
	    	<span>${grainInspection.airWet }</span>
	   	</div>
		<div class="layui-col-md6">
			<span>粮食品种：</span>
			<span>${grainInspection.grainType }</span>
		</div>
	</div>
	<div class="layui-row title">
		<h5>粮温检查情况：</h5>
	</div>
	<table class="layui-table">
		<thead>
		<tr>
			<th style="width:10%;text-align: center">层数</th>
			<th style="text-align: center">最高(℃)</th>
			<th style="text-align: center">最低(℃)</th>
			<th style="text-align: center">平均(℃)</th>
		</tr>
		</thead>
		<!-- 表格内容start -->
		<tbody id="materialDetail" class="text-center">
		<%--['${idxStatus.count}']--%>
			<c:forEach items="${storageGrainInspectionTemps}" var="storageGrainInspectionTemp" varStatus="idxStatus">

		<tr><td style="width:6%" ><input type="hidden" name="storageGrainInspectionTemp[${idxStatus.index}].placeId" value="${storageGrainInspectionTemp.placeId}" style="width:0px;"/>第${idxStatus.count}层</td>
			<td ><input disabled type="text" name="storageGrainInspectionTemp[${idxStatus.index}].topMax" value="${storageGrainInspectionTemp.topMax}" lay-verify="" class="layui-input" placeholder="--请输入--"/></td>
			<td ><input disabled type="text" name="storageGrainInspectionTemp[${idxStatus.index}].topMin" value="${storageGrainInspectionTemp.topMin}" lay-verify="" class="layui-input" placeholder=""/></td>
			<td ><input disabled type="text" name="storageGrainInspectionTemp[${idxStatus.index}].topAvg" value="${storageGrainInspectionTemp.topAvg}" lay-verify="" class="layui-input" placeholder=""/></td> </tr>

			</c:forEach>
		</tbody>
		<!-- 表格内容 end -->
		<td>整仓平均(℃)</td>
		<td colspan="3"><input disabled type="text" name="temperatureAvg" value="${grainInspection.temperatureAvg}" lay-verify="" class="layui-input"   placeholder="--请输入--"/></td>
	</table>
	<div class="layui-row title">
		<h5>气体浓度：</h5>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md2">
		氧气(%)
		</div>
		<div class="layui-col-md5">
			<span>空间：</span>
			<span>${grainInspection.spaceOxy }</span>
		</div>
		<div class="layui-col-md5">
			<span>粮堆：</span>
			<span>${grainInspection.grainBulkOxy }</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md2">
			磷化氢(ppm)
		</div>
		<div class="layui-col-md5">
			<span>空间：</span>
			<span>${grainInspection.spacePhosphine }</span>
		</div>
		<div class="layui-col-md5">
			<span>粮堆：</span>
			<span>${grainInspection.grainBulkPhosphine }</span>
		</div>
	</div>
	<div class="layui-row title"></div>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>虫害检测方式：</span>
			<span>
				<c:forEach var="item" items="${grainInspection.pestCheckTypeList}">
					${item }
				</c:forEach>
			</span>
		</div>
	</div>
	<div class="layui-row">
		<span>虫害采样部位：</span>
		<span>
		<c:forEach var="item" items="${grainInspection.pestSampleSiteList }">
			${item }
		</c:forEach>
		</span>
	</div>
	<div class="layui-row ">
	    <div class="layui-col-md6">
	    	<span>检测点数（个）：</span>
	    	<span>${grainInspection.checkNum }</span>
		</div>
		<div class="layui-col-md6">
			<span>其中有害虫点数（个）：</span>
			<span>${grainInspection.pestSpot }</span>
		</div>
	</div>
    <div class="layui-row ">
		<div class="layui-col-md6">
			<span>发现虫害位置：</span>
		   	<span>${grainInspection.pestInsect }</span>
		</div>
      	<div class="layui-col-md6">
      		<span>虫害名称：</span>
      		<span>${grainInspection.pestNames }</span>
      	</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
	        <span>最高害虫密度（头/kg）：</span>
	    	<span>${grainInspection.pestDensity }</span>
		</div>
		<div class="layui-col-md6">
           	<span>其中主要害虫密度（头/kg）：</span>
           	<span>${grainInspection.majorPestDensity }</span>
		</div>
	</div>
    <div class="layui-row ">
		<div class="layui-col-md6">
			<span>判定虫粮等级：</span>
			<span>${grainInspection.pestLevel }</span>
		</div>
	</div>
	<div class="layui-row title">
		<h5>仓房安全情况：</h5>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>仓房设施方面：</span>
			<span>
				<c:if test="${grainInspection.shedLeakage eq '1' }">有</c:if>
              	<c:if test="${grainInspection.shedLeakage eq '0' }">无</c:if>
			</span>
		</div>
		<div class="layui-col-md6">
        	<span>漏雨防潮方面：</span>
        	<span>
				<c:if test="${grainInspection.wallLeakage eq '1' }">有</c:if>
              	<c:if test="${grainInspection.wallLeakage eq '0' }">无</c:if>
			</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>防火安全方面：</span>
			<span>
				<c:if test="${grainInspection.doorLeakage eq '1' }">有</c:if>
				<c:if test="${grainInspection.doorLeakage eq '0' }">无</c:if>
			</span>
		</div>
	    <div class="layui-col-md6">
	    	<span>用电安全方面：</span>
	        <span>
	        	<c:if test="${grainInspection.shedCrack eq '1' }">有</c:if>
				<c:if test="${grainInspection.shedCrack eq '0' }">无</c:if>
	    	</span>
		</div>
	</div>
	<div class="layui-row title">
		<h5>鼠雀卫生情况：</h5>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
		<span>仓内有无发现鼠雀：</span>
		<span>
			<c:if test="${grainInspection.mouse eq '1' }">有</c:if>
			<c:if test="${grainInspection.mouse eq '0' }">无</c:if>
		</span>
		</div>
	</div>
	<div class="layui-row ">
    	<div class="layui-col-md6">
			<span>仓内卫生情况：</span>
           	<span>
           		<c:if test="${grainInspection.hygiene eq '1' }">好</c:if>
           		<c:if test="${grainInspection.hygiene eq '0' }">差</c:if>
           	</span>
  		</div>
	</div>
	<div class="layui-row title"></div>	
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>检查情况评估：</span>
			<span>
				<c:if test="${grainInspection.checkSituation eq '1' }">粮情稳定，储存安全</c:if>
				<c:if test="${grainInspection.checkSituation eq '0' }">存在隐患，处理意见：
					<span>${grainInspection.advice}</span></c:if>
			</span>
		</div>
	</div>
	<div class="layui-row ">
       	<div class="layui-col-md6">
       		<span>检查性质：</span>
			<span>${grainInspection.checkProperty }</span>
		</div>
		<div class="layui-col-md6">
			<span>检查负责人：</span>
          	<span>${grainInspection.checkCharge }</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>检查人员：</span>
            <span>${grainInspection.checker }</span>             	
		</div>
		<div class="layui-col-md6">
			<span>保管员：</span>
			<span>${grainInspection.keeper }</span>
		</div>
	</div>
	<div class="layui-row ">
		<span>备注：</span>
		<p>
			${grainInspection.remark }
		</p>
	</div>
</div>
</div>
</body>
<script>

if ('${auvp }' !== 'a') {
 	//为所有radio赋值
	$("input[name='heat'][value=${grainInspection.heat }]").attr("checked",true);
	$("input[name='temperatureAbnormal'][value=${grainInspection.temperatureAbnormal }]").attr("checked",true);
	$("input[name='rot'][value=${grainInspection.rot }]").attr("checked",true);
	$("input[name='shedLeakage'][value=${grainInspection.shedLeakage }]").attr("checked",true);
	$("input[name='wallLeakage'][value=${grainInspection.wallLeakage }]").attr("checked",true);
	$("input[name='doorLeakage'][value=${grainInspection.doorLeakage }]").attr("checked",true);
	$("input[name='shedCrack'][value=${grainInspection.shedCrack }]").attr("checked",true);
	$("input[name='wallCrack'][value=${grainInspection.wallCrack }]").attr("checked",true);
	$("input[name='doorCrack'][value=${grainInspection.doorCrack }]").attr("checked",true);
	$("input[name='stairs'][value=${grainInspection.stairs }]").attr("checked",true);
	$("input[name='facilities'][value=${grainInspection.facilities }]").attr("checked",true);
	$("input[name='mouse'][value=${grainInspection.mouse }]").attr("checked",true);
	$("input[name='light'][value=${grainInspection.light }]").attr("checked",true);
	$("input[name='cobweb'][value=${grainInspection.cobweb }]").attr("checked",true);
	$("input[name='hygiene'][value=${grainInspection.hygiene }]").attr("checked",true);
	$("input[name='checkSituation'][value=${grainInspection.checkSituation }]").attr("checked",true);

    //为所有checkbox赋值
	var arr = new Array();
 	<c:forEach items="${grainInspection.pestSampleSiteList }" var="t">  
		arr.push("${t}");
		//console.log("${t}");
	</c:forEach>
 	for (i in arr) {
 		$("input:checkbox[value=" + arr[i] + "]").attr('checked','true');
 	}

    //虫害检测方式
    var arr1 = new Array();
    <c:forEach items="${grainInspection.pestCheckTypeList}" var="u">
    arr1.push("${u}")
    </c:forEach>
    for (j in arr1) {
        $("input:checkbox[value=" + arr1[j] + "]").attr('checked','true');
    }
 	
 	/* $("textarea[name=remark]").val("${grainInspection.remark }"); */
} 

if ('${auvp }' === 'v') {
}
function calculateAverage() {
	var lowAvg = Number($('input[name="lowAvg"]').val());
	var lowMiddleAvg = Number($('input[name="lowMiddleAvg"]').val());
	var topMiddleAvg = Number($('input[name="topMiddleAvg"]').val());
	var topAvg = Number($('input[name="topAvg"]').val());
	var avg = ((lowAvg + lowMiddleAvg + topMiddleAvg + topAvg)/4).toFixed(2);
	$('input[name="temperatureAvg"]').val(avg);
}

</script>