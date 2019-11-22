<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/10 0010
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
</head>
<body>

<div id="page-wrapper" style="margin:0;top:0;min-height: 100%;">
<div class="row clear-m">
    <ol class="breadcrumb">


        <c:if test="${type==''}">
            <li>仓储管理</li>
            <li>粮油情监测管理</li>
            <li><a href="${ctx }/ngasOperaRecord.shtml">充氮气调作业记录</a></li>

        </c:if>
        <c:if test="${type=='dc'}">
            <li>代储监管</li>
            <li>报表台账</li>
            <li><a href="${ctx }/ngasOperaRecord.shtml">充氮气调作业记录</a></li>
        </c:if>
    </ol>
</div>

<style>
    .layui-form-label{
        width:200px;
        text-align:right;
    }
</style>

<div class="container-box clearfix" style="padding: 10px">
    <!--检验结果表-->

    <input type="hidden" name="id" value="${ngasOperaRecord.id }"/>
    <input type="hidden" value="${type}" id="type" name="type">

    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>所属库点：</span>
            <span>${ngasOperaRecord.warehouse }</span>
        </div>
        <div class="layui-col-md4">
            <span>填报日期：</span>
            <span><fmt:formatDate value='${ngasOperaRecord.reportDate }' type='date' pattern='yyyy-MM-dd'/></span>
        </div>
        <div class="layui-col-md4">
            <span>天气：</span>
            <span>${ngasOperaRecord.weather }</span>
        </div>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>气温（℃）：</span>
            <span>${ngasOperaRecord.temperature }</span>
        </div>
        <div class="layui-col-md4">
            <span>气湿（RH%）：</span>
            <span>${ngasOperaRecord.airWet }</span>
        </div>
        <div class="layui-col-md4">
            <span>风道类型：</span>
            <span>${ngasOperaRecord.windTunnelType }</span>
        </div>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>充气方式：</span>
            <span>${ngasOperaRecord.gasChargeType }</span>
        </div>
        <div class="layui-col-md4">
            <span>制氮装置：</span>
            <span>${ngasOperaRecord.nmakePlant }</span>
        </div>
        <div class="layui-col-md4">
            <span>散气日期：</span>
            <span>
            <fmt:formatDate value='${ngasOperaRecord.degasDate }' type='date' pattern='yyyy-MM-dd'/>
            </span>
        </div>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>散气方式：</span>
            <span>${ngasOperaRecord.degasType }</span>
        </div>
        <div class="layui-col-md4">
            <span>散气时间(h)：</span>
            <span>${ngasOperaRecord.degasTime }</span>
        </div>
    </div>

    <div class="layui-row title">
        <h5>仓情：</h5>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>仓房类型：</span>
            <span>${ngasOperaRecord.storehouseType }</span>
        </div>
        <div class="layui-col-md4">
            <span>仓房编号：</span>
            <span>${ngasOperaRecord.encode }</span>
        </div>
        <div class="layui-col-md4">
            <span>密封方法：</span>
            <span>${ngasOperaRecord.sealMethod }</span>
        </div>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>仓房结构：</span>
            <span>${ngasOperaRecord.storehouseStructure }</span>
        </div>
        <div class="layui-col-md4">
            <span>气密性(s)：</span>
            <span>${ngasOperaRecord.airTightness }</span>
        </div>
        <div class="layui-col-md4">
            <span>入库时间：</span>
            <span>
                <fmt:formatDate value='${ngasOperaRecord.instoreTime }' type='date' pattern='yyyy-MM-dd'/>
                </span>
        </div>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>仓房总体积(m³)：</span>
            <span>${ngasOperaRecord.storehouseVolume }</span>
        </div>
        <div class="layui-col-md4">
            <span>粮堆体积(m³)：</span>
            <span>${ngasOperaRecord.grainBulkVolume }</span>
        </div>
        <div class="layui-col-md4">
            <span>空间体积(m³)：</span>
            <span>${ngasOperaRecord.spaceVolume }</span>
        </div>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>堆放形式：</span>
            <span>${ngasOperaRecord.stackForm }</span>
        </div>
        <div class="layui-col-md4">
            <span>粮堆高度(m)：</span>
            <span>${ngasOperaRecord.grainHeight }</span>
        </div>
        <div class="layui-col-md4">
            <span>上年度是否熏蒸：</span>
            <span>${ngasOperaRecord.isfumigated }</span>
        </div>
    </div>

    <div class="layui-row title">
        <h5>粮情：</h5>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>粮食品种：</span>
            <span>${ngasOperaRecord.grainType }</span>
        </div>
        <div class="layui-col-md4">
            <span>数量(t)：</span>
            <span>${ngasOperaRecord.quantity }</span>
        </div>
        <div class="layui-col-md4">
            <span>杂质(%)：</span>
            <span>${ngasOperaRecord.impurity }</span>
        </div>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>仓温(℃)：</span>
            <span>${ngasOperaRecord.storehouseTemp }</span>
        </div>
        <div class="layui-col-md4">
            <span>仓湿(RH%)：</span>
            <span>${ngasOperaRecord.storehouseWet }</span>
        </div>
        <div class="layui-col-md4">
            <span>水分(%)：</span>
            <span>${ngasOperaRecord.dew }</span>
        </div>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>最高粮温(℃)：</span>
            <span>${ngasOperaRecord.maxGraintemp }</span>
        </div>
        <div class="layui-col-md4">
            <span>最低粮温(℃)：</span>
            <span>${ngasOperaRecord.minGrainTemp }</span>
        </div>
        <div class="layui-col-md4">
            <span>平均粮温(℃)：</span>
            <span>${ngasOperaRecord.avgGraintemp }</span>
        </div>
    </div>

    <div class="layui-row title">
        <h5>虫情：</h5>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>虫粮等级：</span>
            <span>${ngasOperaRecord.pestLevel }</span>
        </div>
        <div class="layui-col-md4">
            <span>虫害名称：</span>
            <span>${ngasOperaRecord.pestNames }</span>
        </div>
        <div class="layui-col-md4">
            <span>虫害密度(头/kg)：</span>
            <span>${ngasOperaRecord.pestDensity }</span>
        </div>
    </div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>发生部位：</span>
            <span>${ngasOperaRecord.pestInsect }</span>
        </div>
        <div class="layui-col-md4">
            <span>发现虫害时间：</span>
            <span>
                    <fmt:formatDate value='${ngasOperaRecord.findPestTime }' type='date' pattern='yyyy-MM-dd'/>
                </span>
        </div>
    </div>

    <div class="layui-row title">
        <h5>作业情况：</h5>
    </div>
    <table class="layui-table" id="temp">
        <thead>
        <tr>
            <th style="width:10%;text-align: center">阶段</th>
            <th style="text-align:center">目标浓度(%)</th>
            <th style="text-align:center">开始时间</th>
            <th style="text-align:center">结束时间</th>
            <th style="text-align:center">作业用时(h)</th>
            <th style="text-align:center">最高浓度(%)</th>
            <th style="text-align:center">最低浓度(%)</th>
            <th style="text-align:center">平均浓度(%)</th>
        </tr>
        </thead>
        <!-- 表格内容start -->
        <tbody id="materialDetail" class="text-center">

        <c:forEach items="${ngasOperaSituations}" var="ngasOperaSituation" varStatus="idxStatus">
            <tr>
                <input type="hidden" name="ngasOperaSituation[${idxStatus.index}].orderNo" value="${ngasOperaSituation.orderNo}"lay-verify="" style="width:0px;"/>
                <td ><input type="text" step="0.1" name="ngasOperaSituation[${idxStatus.index}].period" value="${ngasOperaSituation.period}"  class="layui-input" placeholder="--请输入--"/></td>
                <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].targetThickness" value="${ngasOperaSituation.targetThickness}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
                <td ><input type="text" step="0.1" name="ngasOperaSituation[${idxStatus.index}].startTime" value="<fmt:formatDate value='${ngasOperaSituation.startTime }' type='date' pattern='yyyy-MM-dd'/>"   class="layui-input" placeholder="--请输入--"/></td>
                <td ><input type="text" step="0.1" name="ngasOperaSituation[${idxStatus.index}].endTime" value="<fmt:formatDate value='${ngasOperaSituation.endTime }' type='date' pattern='yyyy-MM-dd'/>"  class="layui-input" placeholder="--请输入--"/></td>
                <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].duringTime" value="${ngasOperaSituation.duringTime}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
                <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].maxThickness" value="${ngasOperaSituation.maxThickness}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
                <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].minThickness" value="${ngasOperaSituation.minThickness}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
                <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].avgThickness" value="${ngasOperaSituation.avgThickness}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
            </tr>
        </c:forEach>
        </tbody>
        <!-- 表格内容 end -->
    </table>
    <div class="layui-row title"></div>
    <div class="layui-row ">
        <div class="layui-col-md4">
            <span>效果判断：</span>
            <span>${ngasOperaRecord.resultJudge }</span>
        </div>
        <div class="layui-col-md4">
            <span>总能耗（kW.h）：</span>
            <span>${ngasOperaRecord.sumEnergy }</span>
        </div>
        <div class="layui-col-md4">
            <span>吨粮能耗（kW.h/T）：</span>
            <span>${ngasOperaRecord.avgEnergy }</span>
        </div>
    </div>
    <div class="layui-row ">
        <span>备注：</span>
        <p>
            ${ngasOperaRecord.remark }
        </p>
    </div>


</div>
</div>
<%--<script src="${ctx}/js/app/storage/common.js"></script>--%>

<script>


    function calculateAverage() {
        var lowAvg = Number($('input[name="lowAvg"]').val());
        var lowMiddleAvg = Number($('input[name="lowMiddleAvg"]').val());
        var topMiddleAvg = Number($('input[name="topMiddleAvg"]').val());
        var topAvg = Number($('input[name="topAvg"]').val());
        var avg = ((lowAvg + lowMiddleAvg + topMiddleAvg + topAvg)/4).toFixed(2);
        $('input[name="temperatureAvg"]').val(avg);
    }



    var index = $("#temp>tbody").children("tr").length;




</script>
</body>
</html>
