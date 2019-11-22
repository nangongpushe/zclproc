<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<input type="hidden" name="id" value="${reportMain.id}">
<div class="content_right tab-content">
    <div class="text-left time" style="margin: 10px">
        <table width="100%">
            <tr>
                <td width="20%" id="sumMonth">填报时间：<span id="nowMonth"><fmt:formatDate value="${ fillTime }"  pattern="yyyy年MM月dd日"/></span></td>
                <td width="30%">
                    <div class="layui-inline">
                        <label class="layui-form-label">统计负责人：</label>
                        <input class="layui-input" autocomplete="off" id="manager" name="manager" style="width: 100px" value="${manager}">
                    </div>
                </td>
                <td width="30%"><span><font color="#6495ed" id="status">【${status}】</font></i>储备粮油收支平衡月报表</span></td>
                <td width="20%"><div class="text-right time" style="right: 30px;" id="name-unite">计量单位：<span id="unite">吨</span></div></td>
            </tr>
        </table>
    </div>
    <div class="con_box">
        <div class="table_box tab-pane slide_table active" id="panel-01">
            <div class="public1" style="width: 200px;height: 84px;">
                <table class="table table-bordered nav_left" style="width: 200px;background-color: white;">
                    <tr><th class="td_first text-center" style="width: 200px;height: 84px !important;background-color: #e7f3f7;">品种指标</th></tr>
                </table>
            </div>
            <div class="public" style="width: 200px;height: 100%;padding-bottom: 17px">
                <table class="table table-bordered nav_left" id="nav_left01" style="width: 200px;background-color: white;">
                    <tr><th class="td_first text-center" style="width: 200px;height: 84px !important;background-color: #e7f3f7;">品种指标</th></tr>
                    <c:if test="${empty cblyList}">
                        <c:forEach items="${list}" var="type" varStatus="i">
                            <tr <c:if test='${fn:split(type,"-")[2] }'>class="active"</c:if>><td class="${fn:split(type,"-")[1] } active">${fn:split(type,"-")[0] }</td></tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${!empty cblyList}">
                        <c:forEach items="${cblyList}" var="cbly" varStatus="i">
                            <tr <c:if test='${fn:split(cbly.cssClass,"-")[1] }'>class="active"</c:if>><td class="${fn:split(cbly.cssClass,"-")[0] } active">${cbly.grainType}</td></tr>
                        </c:forEach>
                    </c:if>
                </table>
            </div>
            <div class="public2" style="height: 84px">
                <table class="table table-bordered header" style="border-bottom: 1px solid #7e9bb0; margin: 0 0px">
                    <thead>
                    <tr>
                        <th rowspan="3">期初库存</th><th colspan="11">收入合计</th><th colspan="9">支出合计</th><th colspan="11">期末库存</th><th rowspan="3">动态储备</th>
                    </tr>

                    <tr>
                        <th rowspan="2">小计</th><th colspan="2">从生产者购进</th><th colspan="2">从企业购进</th><th colspan="2">商品粮油转入</th><th rowspan="2">进口</th><th colspan="3">其他收入</th>
                        <th rowspan="2">小计</th><th colspan="2">销售</th><th colspan="2">转作商品粮油</th><th rowspan="2">出口</th><th colspan="3">其他支出</th><th rowspan="2">小计</th><th colspan="8">按收获年份划分</th><th rowspan="2">小包装</th><th rowspan="2">省外储存</th>
                    </tr>
                    <tr>
                        <th>小计</th><th>省外</th><th>小计</th><th>省外</th><th>小计</th><th>轮换收入</th>
                        <th>小计</th><th>省内调入</th><th>加工成品收回</th><th>小计</th><th>省外</th><th>小计</th><th>轮换支出</th><th>小计</th><th>省内调出</th><th>加工原料付出</th><th>小计</th><th class="year1">2011年及以前</th><th class="year2">2012年</th><th class="year3">2013年</th>
                        <th class="year4">2014年</th><th class="year5">2015年</th><th class="year6">2016年</th><th class="year">2017年</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="table_tab">
                <table class="table table-bordered" style="..">
                    <!-- 表格内容 start -->
                    <tbody id="sumTbody">
                    <c:if test="${empty cblyList}">
                        <c:forEach items="${list}" var="type" varStatus="i">
                            <tr class="text-center <c:if test='${fn:split(type,"-")[2] }'>active</c:if>" name="${fn:split(type,"-")[0] }" id="tr-${i.count}">
                                <td class="active"><input name="preStock" value="${preCblyList[i.index].inventorySubtotal}"/></td>
                                <td class="active"><input name="totalIncomeSubtotal" sumCol="2,4,6,8,9"/></td>
                                <td><input name="productorInSubtotal" class="number"/></td>
                                <td><input name="productorIn" class="number"></td>
                                <td><input name="enterpriseInSubtotal" class="number"/></td>
                                <td><input name="enterpriseIn" class="number"></td>
                                <td><input name="changeInSubtotal" class="number"/></td>
                                <td><input name="changeIn" class="number"></td>
                                <td><input name="importedIn" class="number"></td>
                                <td><input name="otherIncomeSubtotal" class="number"/></td>
                                <td><input name="provinceIn" class="number"/></td>
                                <td><input name="recoveryIn" class="number"/></td>
                                <td class="active"><input name="totalExpendSubtotal" sumCol="13,15,17,18"/></td>
                                <td><input name="otherProvinceOutSubtotal" class="number"/></td>
                                <td><input name="otherProvinceOut" class="number"/></td>
                                <td><input name="changeOutSubtotal" class="number"/></td>
                                <td><input name="changeOut" class="number"/></td>
                                <td><input name="exportOut" class="number out_reportsum"/></td>
                                <td><input name="otherExpendSubtotal" class="number"/></td>
                                <td><input name="provinceOut" class="number"/></td>
                                <td><input name="materialOut" class="number"/></td>
                                <td class="active"><input name="inventorySubtotal" sumCol="23-29"/></td>
                                <td><input name="yearSubtotal" class="number"/></td>
                                <td><input name="year6Stock" class="number"/></td>
                                <td><input name="year5Stock" class="number"/></td>
                                <td><input name="year4Stock" class="number"/></td>
                                <td><input name="year3Stock" class="number"/></td>
                                <td><input name="year2Stock" class="number"/></td>
                                <td><input name="year1Stock" class="number"/></td>
                                <td><input name="year0Stock" class="number"/></td>
                                <td><input name="smallPackageStock" class="number"/></td>
                                <td><input name="otherProvinceStock" class="number"/></td>
                                <td><input name="dynamicsStock" class="number"/></td>
                                <input name="grainType" value="${fn:split(type,"-")[0] }" type="hidden">
                                <input name="ordernum" value="${i.count}" type="hidden">
                                <input name="cssClass" value="${fn:split(type,"-")[1] }-${fn:split(type,"-")[2] }" type="hidden">
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${!empty cblyList}">
                        <c:forEach items="${cblyList}" var="cbly" varStatus="i">
                            <tr class="text-center <c:if test='${fn:split(cbly.cssClass,"-")[1] }'>active</c:if>" name="${cbly.grainType}" id="tr-${i.count}">
                                <td class="active"><input name="preStock" value="${cbly.preStock}"/></td>
                                <td class="active"><input name="totalIncomeSubtotal" value="${cbly.totalIncomeSubtotal}" sumCol="2,4,6,8,9"/></td>
                                <td><input name="productorInSubtotal" value="${cbly.productorInSubtotal}" class="number"/></td>
                                <td><input name="productorIn" value="${cbly.productorIn}" class="number"></td>
                                <td><input name="enterpriseInSubtotal" value="${cbly.enterpriseInSubtotal}" class="number"/></td>
                                <td><input name="enterpriseIn" value="${cbly.enterpriseIn}" class="number"></td>
                                <td><input name="changeInSubtotal" value="${cbly.changeInSubtotal}" class="number"/></td>
                                <td><input name="changeIn" value="${cbly.changeIn}" class="number"></td>
                                <td><input name="importedIn" value="${cbly.importedIn}" class="number"></td>
                                <td><input name="otherIncomeSubtotal" value="${cbly.otherIncomeSubtotal}" class="number"/></td>
                                <td><input name="provinceIn" value="${cbly.provinceIn}" class="number"/></td>
                                <td><input name="recoveryIn" value="${cbly.recoveryIn}" class="number"/></td>
                                <td class="active"><input name="totalExpendSubtotal" value="${cbly.totalExpendSubtotal}" sumCol="13,15,17,18"/></td>
                                <td><input name="otherProvinceOutSubtotal" value="${cbly.otherProvinceOutSubtotal}" class="number"/></td>
                                <td><input name="otherProvinceOut" value="${cbly.otherProvinceOut}" class="number"/></td>
                                <td><input name="changeOutSubtotal" value="${cbly.changeOutSubtotal}" class="number"/></td>
                                <td><input name="changeOut" value="${cbly.changeOut}" class="number"/></td>
                                <td><input name="exportOut" value="${cbly.exportOut}" class="number"/></td>
                                <td><input name="otherExpendSubtotal" value="${cbly.otherExpendSubtotal}" class="number"/></td>
                                <td><input name="provinceOut" value="${cbly.provinceOut}" class="number"/></td>
                                <td><input name="materialOut" value="${cbly.materialOut}" class="number"/></td>
                                <td class="active"><input name="inventorySubtotal" value="${cbly.inventorySubtotal}" sumCol="23-29"/></td>
                                <td><input name="yearSubtotal" value="${cbly.yearSubtotal}" class="number"/></td>
                                <td><input name="year6Stock" value="${cbly.year6Stock}" class="number"/></td>
                                <td><input name="year5Stock" value="${cbly.year5Stock}" class="number"/></td>
                                <td><input name="year4Stock" value="${cbly.year4Stock}" class="number"/></td>
                                <td><input name="year3Stock" value="${cbly.year3Stock}" class="number"/></td>
                                <td><input name="year2Stock" value="${cbly.year2Stock}" class="number"/></td>
                                <td><input name="year1Stock" value="${cbly.year1Stock}" class="number"/></td>
                                <td><input name="year0Stock" value="${cbly.year0Stock}" class="number"/></td>
                                <td><input name="smallPackageStock" value="${cbly.smallPackageStock}" class="number"/></td>
                                <td><input name="otherProvinceStock" value="${cbly.otherProvinceStock}" class="number"/></td>
                                <td><input name="dynamicsStock" value="${cbly.dynamicsStock}" class="number"/></td>
                                <input name="grainType" value="${cbly.grainType}" type="hidden">
                                <input name="ordernum" value="${i.count}" type="hidden">
                                <input name="cssClass" value="${cbly.cssClass}" type="hidden">
                            </tr>
                        </c:forEach>
                    </c:if>
                    </tbody>
                    <!-- 表格内容 end -->
                </table>
            </div>
        </div>
    </div>
</div>
<script language="javascript" type="text/javascript">
    var status = '${status}'; //报表状态
    var monthStatus = '${reportMain.reportStatus}'; //汇总月报状态
    $("#reportId").val('${reportId}');
    var saveUrl = "/reportCbly/saveCbly.shtml";
    var saveProxyUrl = "/reportCbly/saveProxyCbly.shtml";
    var exportUrl='/reportCbly/exportCbly.shtml';
    fill5Year();
    var dataList = '${cblyList}';

</script>