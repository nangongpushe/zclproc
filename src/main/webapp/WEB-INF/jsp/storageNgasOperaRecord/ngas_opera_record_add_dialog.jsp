<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/11 0011
  Time: 13:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
</head>
<body>
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
    <form class="layui-form" id="form" lay-filter="form">
        <input type="hidden" name="id" value="${ngasOperaRecord.id }"/>
        <input type="hidden" value="${type}" id="type" name="type">
        <div class="layui-form-item">
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red">*</span>所属库点：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" class="layui-input" autocomplete="off" name="warehouse" readonly
                           <c:if test="${auvp eq 'a' }">value="${user.shortName }"</c:if>
                           <c:if test="${auvp ne 'a' }">value="${ngasOperaRecord.warehouse }"</c:if>>
                    <input type="hidden" name="warehouseId" value="${ngasOperaRecord.warehouseId}" />
                </div>
            </div>

            <%--<div class=" layui-inline">
                <label class="layui-form-label"><span class="red">*</span>仓房编号：</label>
                <div class="layui-input-inline">
                    <select name="encode"class="layui-input" lay-verify="required" lay-filter="encode">
                        <option value=""></option>
                        <c:forEach items="${storehouseEncodeArray }" var="item">
                            <option value="${item }" <c:if test = "${ngasOperaRecord.encode eq item }">selected</c:if>>${item }</option>
                        </c:forEach>
                    </select>
                </div>
            </div>--%>
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red">*</span>填报日期：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="text" class="layui-input date-need"
                           placeholder="&#45;&#45;请选择&#45;&#45;" name="reportDate" value="<fmt:formatDate value='${ngasOperaRecord.reportDate }'
            		type='date' pattern='yyyy-MM-dd'/>" readonly/>
                </div>
            </div>
        </div>
        <div class=" layui-form-item">

            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red">*</span>天气：</label>
                <div class="layui-input-inline">
                    <select name="weather" lay-verify="required">
                        <option value=""></option>
                        <option value="阴" <c:if test = "${ngasOperaRecord.weather eq '阴' }">selected</c:if>>阴</option>
                        <option value="晴" <c:if test = "${ngasOperaRecord.weather eq '晴' }">selected</c:if>>晴</option>
                    </select>
                </div>
            </div>
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red">*</span>气温（℃）：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--"
                           name="temperature" value="${ngasOperaRecord.temperature }"/>
                </div>
            </div>
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red">*</span>气湿（RH%）：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                           name="airWet" value="${ngasOperaRecord.airWet }"/>
                </div>
            </div>
        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red">*</span>风道类型：</label>
                <div class="layui-input-inline">
                    <input  type="text" lay-verify="required" class="layui-input" name="windTunnelType" value="${ngasOperaRecord.windTunnelType }" placeholder="--请输入--"/>
                </div>
            </div>
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red"></span>充气方式：</label>
                <div class="layui-input-inline">
                    <input type="text" step="0.1" class="layui-input" placeholder="--请输入--"
                           name="gasChargeType" value="${ngasOperaRecord.gasChargeType }"/>
                </div>
            </div>
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red"></span>制氮装置：</label>
                <div class="layui-input-inline">
                    <%--<input type="text" step="0.1" class="layui-input" placeholder="--请输入--"
                           name="nmakePlant" value="${ngasOperaRecord.nmakePlant }"/>--%>
                    <select name="nmakePlant" lay-verify="required">
                        <option value=""></option>
                        <option value="移动" <c:if test = "${ngasOperaRecord.nmakePlant eq '移动' }">selected</c:if>>移动</option>
                        <option value="固定" <c:if test = "${ngasOperaRecord.nmakePlant eq '固定' }">selected</c:if>>固定</option>
                    </select>
                </div>
            </div>
        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red"></span>散气日期：</label>
                <div class="layui-input-inline">
                    <input type="text"   placeholder="--请输入--" class="layui-input date-need"
                           name="degasDate" value="<fmt:formatDate value='${ngasOperaRecord.degasDate }' type='date' pattern='yyyy-MM-dd'/>"/>
                </div>
            </div>
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red">*</span>散气方式：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="text"  class="layui-input" placeholder="--请输入--"
                           name="degasType" value="${ngasOperaRecord.degasType }"/>
                </div>
            </div>
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red">*</span>散气时间(h)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number"  step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                           name="degasTime" value="${ngasOperaRecord.degasTime }"/>
                </div>
            </div>

        </div>
        <div class=" layui-form-item">

        </div>
        <div class=" layui-form-item">
        </div>
        <div class="layui-row title">
            <h5>仓情：</h5>
        </div>
        <div class=" layui-form-item">

            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>仓房编号：</label>
                <div class="layui-input-inline">
                    <select name="encode"class="layui-input" lay-verify="required" lay-filter="encode">
                        <option value=""></option>
                        <c:forEach items="${storehouses }" var="item">
                            <option value="${item.encode }" <c:if test = "${ngasOperaRecord.encode eq item.encode }">selected</c:if>>${item.encode }</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>仓房类型：</label>
                <div class="layui-input-inline">
                    <%-- <input lay-verify="required" type="text"  class="layui-input" placeholder="--请输入--"
                            name="storehouseType" value="${ngasOperaRecord.storehouseType }"/>--%>
                    <select name="storehouseType" lay-verify="required" lay-filter="storehouseType">
                        <option value=""></option>
                        <c:forEach items="${storehouseTypes}" var="item">
                            <option value="${item.value }"<c:if test="${ngasOperaRecord.storehouseType eq item.value }">selected</c:if>>${item.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>密封方法：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="text"  class="layui-input" placeholder="--请输入--"
                           name="sealMethod" value="${ngasOperaRecord.sealMethod }"/>
                </div>
            </div>

        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>仓房结构：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="text"  class="layui-input" placeholder="--请输入--"
                           name="storehouseStructure" value="${ngasOperaRecord.storehouseStructure }"/>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>气密性(s)：</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline">
                        <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                               name="airTightness" value="${ngasOperaRecord.airTightness }"/>
                    </div>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>入库时间：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="text"  class="layui-input date-need" placeholder="--请输入--"
                           name="instoreTime" value="<fmt:formatDate value='${ngasOperaRecord.instoreTime }' type='date' pattern='yyyy-MM-dd'/>"/>
                </div>
            </div>
        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>仓房总体积(m³)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                           name="storehouseVolume" value="${ngasOperaRecord.storehouseVolume }"/>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>粮堆体积(m³)：</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline">
                        <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                               name="grainBulkVolume" value="${ngasOperaRecord.grainBulkVolume }"/>
                    </div>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>空间体积(m³)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                           name="spaceVolume" value="${ngasOperaRecord.spaceVolume }"/>
                </div>
            </div>
        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>堆放形式：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="text"  class="layui-input" placeholder="--请输入--"
                           name="stackForm" value="${ngasOperaRecord.stackForm }"/>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>粮堆高度(m)：</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline">
                        <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                               name="grainHeight" value="${ngasOperaRecord.grainHeight }"/>
                    </div>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>上年度是否熏蒸：</label>
                <div class="layui-input-inline">
                    <%--<input lay-verify="required" type="text"  class="layui-input" placeholder="--请输入--"
                           name="isfumigated" value="${ngasOperaRecord.isfumigated }"/>--%>
                    <select name="isfumigated" lay-verify="required">
                        <option value=""></option>
                        <option value="是" <c:if test = "${ngasOperaRecord.isfumigated eq '是' }">selected</c:if>>是</option>
                        <option value="否" <c:if test = "${ngasOperaRecord.isfumigated eq '否' }">selected</c:if>>否</option>
                    </select>

                </div>
            </div>
        </div>
        <div class="layui-row title">
            <h5>粮情：</h5>
        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>粮食品种：</label>
                <div class="layui-input-inline">
                    <%-- <input lay-verify="required" type="text"  class="layui-input" placeholder="--请输入--"
                            name="grainType" value="${ngasOperaRecord.grainType }"/>--%>
                    <select name="grainType" id="grainType" lay-filter="grainType">
                        <option></option>
                        <c:forEach items="${varietyList }" var="item">
                            <option value="${item.value }"<c:if test="${ngasOperaRecord.grainType eq item.value }">selected</c:if>>${item.value }</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>数量(t)：</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline">
                        <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                               name="quantity" value="${ngasOperaRecord.quantity }"/>
                    </div>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>杂质(%)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                           name="impurity" value="${ngasOperaRecord.impurity }"/>
                </div>
            </div>
        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>仓温(℃)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--"
                           name="storehouseTemp" value="${ngasOperaRecord.storehouseTemp }" onkeyup="checkNum(this,this.value)"/>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>仓湿(RH%)：</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline">
                        <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                               name="storehouseWet" value="${ngasOperaRecord.storehouseWet }"/>
                    </div>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>水分(%)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                           name="dew" value="${ngasOperaRecord.dew }"/>
                </div>
            </div>
        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>最高粮温(℃)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number" step="0.1"  class="layui-input" placeholder="--请输入--"
                           name="maxGraintemp" value="${ngasOperaRecord.maxGraintemp }"/>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>最低粮温(℃)：</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline">
                        <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--"
                               name="minGrainTemp" value="${ngasOperaRecord.minGrainTemp }"/>
                    </div>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>平均粮温(℃)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--"
                           name="avgGraintemp" value="${ngasOperaRecord.avgGraintemp }"/>
                </div>
            </div>
        </div>
        <div class="layui-row title">
            <h5>虫情：</h5>
        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>虫粮等级：</label>
                <div class="layui-input-inline">
                    <%--<input lay-verify="required" type="text"  class="layui-input" placeholder="--请输入--"
                           name="pestLevel" value="${ngasOperaRecord.pestLevel }"/>--%>
                    <select name="pestLevel" lay-verify="required">
                        <option value=""></option>
                        <option value="基本无虫粮" <c:if test = "${ngasOperaRecord.pestLevel eq '基本无虫粮' }">selected</c:if>>基本无虫粮</option>
                        <option value="一般虫粮" <c:if test = "${ngasOperaRecord.pestLevel eq '一般虫粮' }">selected</c:if>>一般虫粮</option>
                        <option value="严重虫粮" <c:if test = "${ngasOperaRecord.pestLevel eq '严重虫粮' }">selected</c:if>>严重虫粮</option>
                        <option value="危险虫粮" <c:if test = "${ngasOperaRecord.pestLevel eq '危险虫粮' }">selected</c:if>>危险虫粮</option>
                    </select>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>虫害名称：</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline">
                        <input lay-verify="required" type="text"  class="layui-input" placeholder="--请输入--"
                               name="pestNames" value="${ngasOperaRecord.pestNames }"/>
                    </div>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>虫害密度(头/kg)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="number" step="0.1" class="layui-input" placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                           name="pestDensity" value="${ngasOperaRecord.pestDensity }"/>
                </div>
            </div>
        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>发生部位：</label>
                <div class="layui-input-inline">
                    <input lay-verify="required" type="text"  class="layui-input" placeholder="--请输入--"
                           name="pestInsect" value="${ngasOperaRecord.pestInsect }"/>
                </div>
            </div>
            <div class=" layui-inline" style="height: 5%">
                <label class="layui-form-label" style="width:200px"><span class="red">*</span>发现虫害时间：</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline">
                        <input lay-verify="required" type="text"  class="layui-input date-need" placeholder="--请输入--"
                               name="findPestTime" value="<fmt:formatDate value='${ngasOperaRecord.findPestTime }' type='date' pattern='yyyy-MM-dd'/>"/>
                    </div>
                </div>
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
            <c:if test="${auvp ne 'a' }">
                <c:forEach items="${ngasOperaSituations}" var="ngasOperaSituation" varStatus="idxStatus">
                    <tr>
                        <input type="hidden" name="ngasOperaSituation[${idxStatus.index}].orderNo" value="${ngasOperaSituation.orderNo}" lay-verify="" style="width:0px;"/>
                        <td ><input type="text" step="0.1" name="ngasOperaSituation[${idxStatus.index}].period" value="${ngasOperaSituation.period}"  class="layui-input" readonly placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].targetThickness" value="${ngasOperaSituation.targetThickness}"  class="layui-input" placeholder="--请输入--"/></td>
                        <td ><input type="text" step="0.1" id="ngasOperaSituation[${idxStatus.index}].startTime" name="ngasOperaSituation[${idxStatus.index}].startTime" value="<fmt:formatDate value='${ngasOperaSituation.startTime }' pattern='yyyy-MM-dd'/>"  class="layui-input" placeholder="--请输入--"/></td>
                        <td ><input type="text" step="0.1" id="ngasOperaSituation[${idxStatus.index}].endTime" name="ngasOperaSituation[${idxStatus.index}].endTime" value="<fmt:formatDate value='${ngasOperaSituation.endTime }'  pattern='yyyy-MM-dd'/>"  class="layui-input" placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].duringTime" value="${ngasOperaSituation.duringTime}"  class="layui-input"  placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].maxThickness" value="${ngasOperaSituation.maxThickness}"  class="layui-input"  placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].minThickness" value="${ngasOperaSituation.minThickness}"  class="layui-input"  placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].avgThickness" value="${ngasOperaSituation.avgThickness}"  class="layui-input"  placeholder="--请输入--"/></td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${auvp eq 'a' }">
                <c:forEach items="${periods}" var="period" varStatus="idxStatus">
                    <tr>
                        <input type="hidden" name="ngasOperaSituation[${idxStatus.index}].orderNo" value="${period.sort}"lay-verify="" style="width:0px;"/>
                        <td ><input type="text" step="0.1" name="ngasOperaSituation[${idxStatus.index}].period" value="${period.value}"  class="layui-input" readonly placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].targetThickness" value=""  class="layui-input"  placeholder="--请输入--" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"/></td>
                        <td ><input type="text" step="0.1" id="ngasOperaSituation[${idxStatus.index}].startTime" name="ngasOperaSituation[${idxStatus.index}].startTime" value=""  class="layui-input " placeholder="--请输入--"/></td>
                        <td ><input type="text" step="0.1" id="ngasOperaSituation[${idxStatus.index}].endTime" name="ngasOperaSituation[${idxStatus.index}].endTime" value=""  class="layui-input " placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].duringTime" value=""  class="layui-input"  placeholder="--请输入--"onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].maxThickness" value=""  class="layui-input"  placeholder="--请输入--"onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].minThickness" value=""  class="layui-input"  placeholder="--请输入--"onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].avgThickness" value=""  class="layui-input"  placeholder="--请输入--"onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"/></td>
                    </tr>
                </c:forEach>
            </c:if>
            </tbody>
            <!-- 表格内容 end -->
        </table>
        <%-- <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="addMaterialName();">增加一层</button>
         <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="lessMaterialName();">删除最后一层</button>--%>
        <div class="layui-row title">
        </div>
        <div class=" layui-form-item">
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red"></span>效果判断：</label>
                <div class="layui-input-inline">
                    <input lay-verify="" type="text"  class="layui-input" placeholder="--请输入--"
                           name="resultJudge" value="${ngasOperaRecord.resultJudge }"/>
                </div>
            </div>
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red"></span>总能耗(kW.h)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="" type="number" step="0.1" class="layui-input" placeholder="--请输入--"onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                           name="sumEnergy" value="${ngasOperaRecord.sumEnergy }"/>
                </div>
            </div>
            <div class=" layui-inline">
                <label class="layui-form-label"><span class="red"></span>吨粮能耗(kW.h/T)：</label>
                <div class="layui-input-inline">
                    <input lay-verify="" type="number" step="0.1" class="layui-input" placeholder="--请输入--"onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                           name="avgEnergy" value="${ngasOperaRecord.avgEnergy }"/>
                </div>
            </div>
        </div>
        <div class=" layui-form-item">
            <label class="layui-form-label" style="width:200px">备注：</label>
            <div class="layui-input-inline">
                <textarea class="layui-textarea" placeholder="--限500字--" name="remark"  style="width:800px" maxlength="400">${ngasOperaRecord.remark }</textarea>
            </div>
        </div>

        <p name="prompt">备注：带有<span class="red">*</span>为必填项！</p>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: center;">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="submit_btn" lay-submit lay-filter="submit_btn" id ="submit">保存<c:if test="${auvp eq 'u' }">更改</c:if></button>
                <%--<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="cancel_btn"
                        onclick="cancelOperate('${auvp }', '${ctx }/ngasOperaRecord.shtml')">取消</button>--%>
            </div>
        </div>
    </form>
</div>

<script src="${ctx}/js/app/storage/common.js"></script>

<script>


    if ('${auvp }' === 'v') {
        $('input').attr('disabled','disabled');
        $('select').attr('disabled','disabled');
        $('#cancel_btn').text('返回');//取消按钮
        $('#submit_btn').css('display','none');//提交按钮
        $('p[name=prompt]').css('display','none');//备注文字
        $("textarea[name=remark]").attr("disabled","disabled");
    }

    layui.use(['form', 'laydate'], function(){
        var laydate = layui.laydate,
            form = layui.form;

        $('.date-need').each(function(){
            laydate.render({
                elem: this
            });
        });
        <c:if test="${auvp ne 'a' }">
        <c:forEach items="${ngasOperaSituations}" var="ngasOperaSituation" varStatus="idxStatus">
        var endDate${idxStatus.index}= laydate.render({
            elem: $('[name="ngasOperaSituation[${idxStatus.index}].endTime"]')[0],//选择器结束时间name="ngasOperaSituation[${idxStatus.index}].startTime"
            type: 'date',
            min:"1970-1-1",//设置min默认最小值
            done: function(value,date){
                startDate${idxStatus.index}.config.max={
                    year:date.year,
                    month:date.month-1,//关键
                    date: date.date,
                    hours: 0,
                    minutes: 0,
                    seconds : 0
                }
            }
        });
        //日期范围
        var startDate${idxStatus.index}=laydate.render({
            elem: $('[name="ngasOperaSituation[${idxStatus.index}].startTime"]')[0],
            type: 'date',
            max:"2099-12-31",//设置一个默认最大值
            done: function(value, date){
                endDate${idxStatus.index}.config.min ={
                    year:date.year,
                    month:date.month-1, //关键
                    date: date.date,
                    hours: 0,
                    minutes: 0,
                    seconds : 0
                };
            }
        });
        </c:forEach>
        </c:if>

        <c:if test="${auvp eq 'a' }">
        <c:forEach items="${periods}" var="period" varStatus="idxStatus">
        var endDate${idxStatus.index}= laydate.render({
            elem: $('[name="ngasOperaSituation[${idxStatus.index}].endTime"]')[0],//选择器结束时间name="ngasOperaSituation[${idxStatus.index}].startTime"
            type: 'date',
            min:"1970-1-1",//设置min默认最小值
            done: function(value,date){
                startDate${idxStatus.index}.config.max={
                    year:date.year,
                    month:date.month-1,//关键
                    date: date.date,
                    hours: 0,
                    minutes: 0,
                    seconds : 0
                }
            }
        });
        //日期范围
        var startDate${idxStatus.index}=laydate.render({
            elem: $('[name="ngasOperaSituation[${idxStatus.index}].startTime"]')[0],
            type: 'date',
            max:"2099-12-31",//设置一个默认最大值
            done: function(value, date){
                endDate${idxStatus.index}.config.min ={
                    year:date.year,
                    month:date.month-1, //关键
                    date: date.date,
                    hours: 0,
                    minutes: 0,
                    seconds : 0
                };
            }
        });
        </c:forEach>
        </c:if>


        form.render();

        form.on('submit(submit_btn)', function(){
            var form = $('#form');
            var tempForm = form.serializeObject();
            var ngasOperaSituation = [];

            for (var i = 0;i< index; i++){
                ngasOperaSituation.push({
                    orderNo : $("[name='ngasOperaSituation["+i+"].orderNo']").val(),
                    period : $("[name='ngasOperaSituation["+i+"].period']").val(),
                    targetThickness : $("[name='ngasOperaSituation["+i+"].targetThickness']").val(),
                    startTime : $("[name='ngasOperaSituation["+i+"].startTime']").val(),
                    endTime : $("[name='ngasOperaSituation["+i+"].endTime']").val(),
                    duringTime : $("[name='ngasOperaSituation["+i+"].duringTime']").val(),
                    maxThickness : $("[name='ngasOperaSituation["+i+"].maxThickness']").val(),
                    minThickness : $("[name='ngasOperaSituation["+i+"].minThickness']").val(),
                    avgThickness : $("[name='ngasOperaSituation["+i+"].avgThickness']").val()
                })
            }
            tempForm["ngasOperaSituation"] = ngasOperaSituation;
            console.info(tempForm);
            var json = JSON.stringify(tempForm);
            //form.serializeObject();
            //console.log(json);
            $.ajax({
                type : 'POST',
                url : '${ctx }/ngasOperaRecord/save.shtml?auvp=${auvp}',
                dataType : "json",
                contentType : "application/json",
                data : json,
                error: function(request) {
                    if(request.responseText){
                        layer.open({
                            type: 1,
                            area: ['700px', '430px'],
                            fix: false,
                            content: request.responseText
                        });
                    }
                },
                success : function(result) {
                    if (!result.success) {
                        layer.alert(result.msg, {icon:2});
                        return;
                    } else {
                        layer.msg(result.msg,{time:1000,icon:1},function(){
                            location.href = '${ctx }/ngasOperaRecord.shtml?type='+$("#type").val();
                        });
                    }
                }
            });
        });
        /*form.on('submit(submit_btn)', function(){
       /!* $("#submit").click(function(){*!/

            $("#form").ajaxSubmit({
                <%--url:"${ctx }/ngasOperaRecord/save.shtml?auvp=${auvp}'",--%>
                type:"post",

                success:function(data){
                    if(data.success){
                        layer.msg("保存成功！",{icon:1},function(){
                            <%--location.href = "${ctx}/ngasOperaRecord/view.shtml";--%>
                        });
                    }else{
                        layer.msg("保存失败！",{icon:2});
                    }
                },
                error:function(){
                    layer.msg("系统异常！",{icon:2});
                }
            });
        });*/






        form.on('checkbox(radioFilter)', function(){
            var domName = $(this).attr("name");//获取当前单选框控件name 属性值
            var checkedState = $(this).attr("checked");//记录当前选中状态
            if(checkedState!="checked"){
                var ch = $("input:checkbox[name='" + domName + "']");
                for(var i=0;i<ch.length;i++){
                    var checked1 = $(ch[i]).attr("checked");
                    if(checked1=="checked"){
                        $(ch[i]).attr("checked",false);
                        var div = ch[i].nextSibling;
                        $(div).attr("class","layui-unselect layui-form-checkbox");
                    }
                }
                $(this).attr("checked",true);
                var div = this.nextSibling;
                $(div).attr("class","layui-unselect layui-form-checkbox layui-form-checked");
            }else{
                $(this).attr("checked",false);
                var div = this.nextSibling;
                $(div).attr("class","layui-unselect layui-form-checkbox");
            }
        });
    });

    function calculateAverage() {
        var lowAvg = Number($('input[name="lowAvg"]').val());
        var lowMiddleAvg = Number($('input[name="lowMiddleAvg"]').val());
        var topMiddleAvg = Number($('input[name="topMiddleAvg"]').val())
        var topAvg = Number($('input[name="topAvg"]').val());
        var avg = ((lowAvg + lowMiddleAvg + topMiddleAvg + topAvg)/4).toFixed(2);
        $('input[name="temperatureAvg"]').val(avg);
    }



    var index = $("#temp>tbody").children("tr").length;
    var storehouses = ${cf:toJSON(storehouses)};
    //仓房下拉框
    layui.form.on('select(encode)',function(data){
        if(!data.value){
            $('select[name="storehouseType"]').val('');
        }else{
            //alert(11)
            for(var i=0;i<storehouses.length;i++){
                if(data.value==storehouses[i].encode){
                    //alert(storehouses[i].type);
                    $('select[name="storehouseType"]').val(storehouses[i].type);
                    break;
                }
            }
            //self.findType();
        }
        layui.form.render('select','form');

        if(!data.value||!$('[name="grainType"]').val()){
            $('[name="quantity"]').val('');
            return;
        }
        else{
            if(!$('[name="warehouse"]').val()){
                layer.msg('请选择库点',{icon:0});
                return;
            }else{
                getRealQuantity();
            }
        }

    });

    //粮食下拉框
    layui.form.on('select(grainType)',function(data){
        //alert(1);
        if(!data.value||!$('[name="encode"]').val()){
            $('[name="quantity"]').val('');
            return;
        }
        else{
            if(!$('[name="warehouse"]').val()){
                layer.msg('请选择库点',{icon:0});
                return;
            }else{
                getRealQuantity();
            }
        }
    });

    function getRealQuantity() {
        layer.load();
        $.ajax({
            type : 'POST',
            url : '../reportSwtz/getLastestQuantity.shtml',
            data : {
                reportWarehouse:$('[name="warehouse"]').val(),
                storehouse:$('[name="encode"]').val(),
                variety:$('[name="grainType"]').val()
            },
            success : function(result) {
                layerMsgSuccess("实际数量读取成功!");
                $('[name="quantity"]').val(result.toFixed(3));
                // alert(result.toFixed(3))
            },
            error : function() {
                layer.closeAll();
                layerMsgError("实际数量读取失败!");
            },
            complete:function(){
                layer.closeAll('loading');
            }
        });
    }

    function checkNum(e,pnumber){
        if (!/^\d+[.]?\d*$/.test(pnumber)){
            $(e).val(/^\d+[.]?\d*/.exec($(e).val()));
        }
    }
</script>
</body>
</html>
