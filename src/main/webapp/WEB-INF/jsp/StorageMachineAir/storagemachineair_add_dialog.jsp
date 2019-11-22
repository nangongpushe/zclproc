<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/12 0012
  Time: 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
</head>
<body>
<script src="../js/jquery.min.js"></script>
<script type="text/javascript">

    $(document).ready(function(){
        $(".yinchang .hide").click(function(){
            $(this).parents(".yinchang").hide("slow");
        });
    });

</script>
<style>
    .title1{
        margin-left:55px;
        color: #23b7e5;
        border-bottom: 1px solid #23b7e5;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>仓储管理</li>
        <li>粮油情检测管理</li>
        <li>机械通风记录</li>
        <c:if test="${isEdit}">
            <li class="active">机械通风记录编辑</li>
        </c:if>
        <c:if test="${!isEdit}">
            <li class="active">机械通风记录新增</li>
        </c:if>
    </ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

    <div class="layui-row title">
        <h5>机械通风记录信息</h5>
    </div>

    <form class="layui-form" lay-filter="form">
        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称:</label>
                <div class="layui-input-inline">
                    <input class="layui-input form-control" name="warehouse" lay-verify="required"
                           autocomplete="off" value="${model.warehouse}" readonly>
                    <input type="hidden" name="warehouseId" value="${model.warehouseId}"/>
                </div>
            </div>

            <div class="layui-inline layui-col-md5" id="notice">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>仓号:</label>
                <div class="layui-input-inline">
                    <select name="storehouse" lay-verify="required" lay-filter="storehouse">
                        <option value="">--请选择--</option>
                        <c:forEach items="${storehouses}" var="item">
                            <option value="${item.encode }">${item.encode}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮食品种:</label>
                <div class="layui-input-inline">
                    <select name="grainType" lay-verify="required" lay-filter="grainType">
                        <option value="">--请选择--</option>
                        <c:forEach var="item" items="${grainTypes}">
                            <option value="${item.value}">${item.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>实际数量(吨):</label>
                <div class="layui-input-inline">
                    <input maxlength="15" class="layui-input form-control" name="realQuantity" onkeyup="clearNoNum(this) " onblur="checkAmounts(this);"
                           autocomplete="off" value="${model.realQuantity}">
                </div>
            </div>
        </div>

        <div class="layui-form-item layui-form-text layui-col-md5">
            <label class="layui-form-label" style="text-align:right"><span class="red">*</span>通风目的:</label>
            <div class="layui-input-inline">
                <textarea placeholder="最多200字符" lay-verify="required" class="layui-textarea" name="airAim" maxlength="200">${model.airAim}</textarea>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">粮堆高度(m):</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="6" name="grainBulkHeight" onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" lay-verify="grainBulkHeight" type="text"
                           autocomplete="off" value="${model.grainBulkHeight}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">粮堆体积(m³):</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="6" name="grainBulkVolume" lay-verify="grainBulkVolume" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.grainBulkVolume}">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">风机型号:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="15" name="fanVersion"
                           autocomplete="off" value="${model.fanVersion}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">风机功率(KW):</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="6" name="fanPower" lay-verify="fanPower" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.fanPower}">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>风机数量(台) :</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="5" name="fanQuantity" lay-verify="required|fanQuantity" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.fanQuantity}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>总风量(m³/h):</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="6" name="totalAirVolume" lay-verify="required|totalAirVolume" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.totalAirVolume}"
                           data-bind="event:{change:function(){$root.calculateAverageAirVolume();}}">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">风道类型:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="15" name="airDuctType"
                           autocomplete="off" value="${model.airDuctType}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">风网布置:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="15" name="airNetLayout"
                           autocomplete="off" value="${model.airNetLayout}">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">风道数量(条):</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="5" name="airDuctQuantity" lay-verify="airDuctQuantity" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.airDuctQuantity}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">风道间距(m):</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="airDuctGap" lay-verify="airDuctGap" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.airDuctGap}">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>单位通风量(m³/h·t):</label>
                <div class="layui-input-inline">
                    <input class="layui-input form-control" maxlength="6" name="averageAirVolume" lay-verify="required|averageAirVolume" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.averageAirVolume}" readonly>
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>通风方式:</label>
                <div class="layui-input-inline">
                    <select name="airType" lay-verify="required">
                        <option value="">--请选择--</option>
                        <option value="吸风">吸风</option>
                        <option value="压风">压风</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">通风途径比:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="6" name="airPathRatio" lay-verify="airPathRatio" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.airPathRatio}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"> <span class="red">*</span>开始通风时间:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="airStartTime" lay-verify="required"
                           autocomplete="off" value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
            value="${model.airStartTime}" />'>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>停止通风时间 :</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="airEndTime" lay-verify="required"
                           autocomplete="off" value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
            value="${model.airEndTime}" />'>
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>累积通风时间(h):</label>
                <div class="layui-input-inline">
                    <input class="layui-input form-control" name="totalAirTime" lay-verify="required"
                           autocomplete="off" value="${model.totalAirTime}" readonly>
                </div>
            </div>
        </div>


        <div class="layui-row  title1">
            <h5>大气温度</h5>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值(℃) :</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="maxAirTemperature" lay-verify="required|maxAirTemperature" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.maxAirTemperature}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值(℃):</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="minAirTemperature" lay-verify="required|minAirTemperature" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.minAirTemperature}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值(℃):</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="averageAirTemperature" lay-verify="required|minAirTemperature" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.averageAirTemperature}">
                </div>
            </div>
        </div>

        <div class="layui-row  title1">
            <h5>大气湿度</h5>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值(RH%) :</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="maxAirHumidity" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.maxAirHumidity}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值(RH%):</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="minAirHumidity" lay-verify="required|minAirHumidity" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.minAirHumidity}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值(RH%):</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="6" name="averageAirHumidity" lay-verify="required|averageAirHumidity" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.averageAirHumidity}">
                </div>
            </div>
        </div>

        <div class="layui-row  title1">
            <h5>粮食温度(通风前)</h5>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值(℃) :</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="maxGrainTemperature" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.maxGrainTemperature}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值(℃):</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="minGrainTemperature" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.minGrainTemperature}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值(℃):</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="averageGrainTemperature" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.averageGrainTemperature}">
                </div>
            </div>
        </div>

        <div class="layui-row  title1">
            <h5>粮食温度(通风后)</h5>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值(℃) :</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="maxGrainTemperatureNew" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.maxGrainTemperatureNew}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值(℃):</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="6" name="minGrainTemperatureNew" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.minGrainTemperatureNew}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值(℃):</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="6" name="averageGrainTemperatureNew" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.averageGrainTemperatureNew}">
                </div>
            </div>
        </div>

        <div class="layui-row  title1">
            <h5>粮食水分(通风前)</h5>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值(%) :</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="maxGrainDew" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.maxGrainDew}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值(%):</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="minGrainDew" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.minGrainDew}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值(%):</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="averageGrainDew" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.averageGrainDew}">
                </div>
            </div>
        </div>

        <div class="layui-row  title1">
            <h5>粮食水分(通风后)</h5>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值(%) :</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="maxGrainDewNew" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.maxGrainDewNew}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值(%):</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="minGrainDewNew" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.minGrainDewNew}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值(%):</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  maxlength="6" name="averageGrainDewNew" lay-verify="required" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.averageGrainDewNew}">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>总电耗(KW·h):</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="6" name="totalPowerConsumption" lay-verify="required|totalPowerConsumption" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.totalPowerConsumption}">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">单位能耗(kw·h/℃·t或kw·h/1%水分·t):</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="6"  name="averagePowerConsumption" lay-verify="averagePowerConsumption" type="text"
                           onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.averagePowerConsumption}">
                </div>
            </div>
        </div>
        <div class="yinchang">

            <div class="hide">
                <label >保管员 :</label>
                <div>
                    <input  name="storeMan"
                            value="${model.storeMan}" >
                </div>
            </div>
        </div>

        <div class="layui-form-item">

            <%--<div class="hide">
                <label class="layui-form-label">保管员 :</label>
                <div class="layui-input-inline">
                    <input class="layui-input form-control" name="storeMan" lay-verify="required"
                           autocomplete="off" value="0" >
                </div>
            </div>--%>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>操作人:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" maxlength="5"  name="operator" lay-verify="required"
                           autocomplete="off" value="${model.operator}" readonly>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>审核人 :</label>
                <div class="layui-input-inline">
                    <input class="layui-input form-control" maxlength="5"  name="chargeMan" lay-verify="required"
                           autocomplete="off" value="${model.chargeMan}" >
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>上报日期  :</label>
                <div class="layui-input-inline">
                    <input class="layui-input form-control" name="reportTime" lay-verify="required"
                           autocomplete="off" value='<fmt:formatDate value="${model.reportTime}" pattern="yyyy-MM-dd" />' readonly>
                </div>
            </div>
        </div>

        <div class="layui-form-item layui-form-text layui-col-md5">
            <label class="layui-form-label" style="text-align:right">备注:</label>
            <div class="layui-input-inline">
                <textarea placeholder="最多500字符" class="layui-textarea" name="remark" maxlength="500">${model.remark}</textarea>
            </div>
        </div>

        <div class="layui-form-item text-center">
            <button type="button" class=" layui-btn layui-btn-primary layui-btn-small"
                    lay-submit="" lay-filter="save">保存</button>
            <%--<button type="button"
                    class=" layui-btn layui-btn-primary layui-btn-small" id="cancel" data-bind="click:function(){$root.cancel();}">取消</button>--%>
        </div>
    </form>

</div>
<script src="../js/knockout-3.4.0.js"></script>

<script src="../js/app/storagemachineair/add.js"></script>
<script>
    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
        if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
            obj.value= parseFloat(obj.value);
        }
    }
    function checkAmounts(obj) {
        var reg = /[A-Za-z]+/;
        var optionNum = $(obj).val();
        if (reg.test(optionNum)) {
            alert("只能输入数字");
            $(obj).val("");
        }
    }

    var isedit=${isEdit};
    var id = '${model.id}'||0;
    var storehouses = ${cf:toJSON(storehouses)};
    if(isedit){
        $('[name="storehouse"]').val('${model.storehouse}');
        $('[name="grainType"]').val('${model.grainType}');
        $('[name="airType"]').val('${model.airType}');
    }else{
        $('[name="storehouse"]').val('${model.storehouse}');
        $('[name="grainType"]').val('${model.grainType}');
        $('[name="airType"]').val('${model.airType}');
    }
    var vm = new Add(isedit,id,storehouses);
    ko.applyBindings(vm,$(".container-box")[0]);
    vm.initPage();

</script>
</body>
</html>
