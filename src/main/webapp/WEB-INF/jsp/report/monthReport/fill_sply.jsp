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
                <td width="30%"><span><font color="#6495ed" id="status">【${status}】</font></i>商品粮油收支平衡月报表</span></td>
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
                    <c:if test="${empty splyList}">
                        <c:forEach items="${list}" var="type" varStatus="i">
                            <tr <c:if test='${fn:split(type,"-")[2] }'>class="active"</c:if>><td class="${fn:split(type,"-")[1] } active">${fn:split(type,"-")[0] }</td></tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${!empty splyList}">
                        <c:forEach items="${splyList}" var="sply" varStatus="i">
                            <tr <c:if test='${fn:split(sply.cssClass,"-")[1] }'>class="active"</c:if>><td class="${fn:split(sply.cssClass,"-")[0] } active">${sply.grainType}</td></tr>
                        </c:forEach>
                    </c:if>
                </table>
            </div>
            <div class="public2" style="height: 84px">
                <table class="table table-bordered header" style="border-bottom: 1px solid #7e9bb0">
                    <thead>
                    <tr class="text-center">
                        <th rowspan="3" >期初库存</th><th colspan="12">收入合计</th><th colspan="9">支出合计</th><th colspan="2" >期末库存</th>
                    </tr>
                    <tr>
                        <th rowspan="2">小计</th><th colspan="3">从生产者购进</th><th colspan="5">从企业购进</th><th rowspan="2" >进口</th><th rowspan="2" >储备粮油转入</th><th rowspan="2" >其他收入</th>
                        <th rowspan="2">小计</th><th colspan="5">销售</th><th rowspan="2">出口</th><th rowspan="2">转作储备粮油</th><th rowspan="2" >其他支出</th><th rowspan="2" >小计</th><th rowspan="2" >省外储存</th>
                    </tr>
                    <tr >
                        <th>小计</th><th>其中：省外</th><th>省内订单收购</th><th>小计</th><th>其中：省外</th><th>省内县外</th><th>县内</th><th>从国有粮食企业购进</th>
                        <th>小计</th><th>其中：省外</th><th>省内县外</th><th>县内</th><th>对国有粮食企业销售</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="table_tab">
                <table class="table table-bordered" style="..">
                    <!-- 表格内容 start -->
                    <tbody id="sumTbody">
                    <c:if test="${empty splyList}">
                        <c:forEach items="${list}" var="type" varStatus="i">
                            <tr class="text-center <c:if test='${fn:split(type,"-")[2] }'>active</c:if>" name="${fn:split(type,"-")[0] }" id="tr-${i.count}">
                                <td class="active"><input name="preStock" value="${preSplyList[i.index].inventorySubtotal}"/></td>
                                <td class="active"><input name="totalIncomeSubtotal" sumCol="2,5,10-12"/></td>
                                <td><input name="productorInSubtotal" class="number"/></td>
                                <td><input name="productorInSw" class="number"></td>
                                <td><input name="productorInSn" class="number"/></td>
                                <td><input name="enterpriseInSubtotal" class="number"></td>
                                <td><input name="enterpriseInSw" class="number"/></td>
                                <td><input name="enterpriseInSnxw" class="number"></td>
                                <td><input name="enterpriseInXn" class="number"></td>
                                <td><input name="enterpriseInGy" class="number"/></td>
                                <td><input name="importedIn" class="number"/></td>
                                <td><input name="reserveIn" class="number"/></td>
                                <td><input name="otherIncome" class="number"/></td>
                                <td class="active"><input name="otherExpendSubtotal" sumCol="14,19-21"/></td>
                                <td><input name="saleSubtotal" class="number"/></td>
                                <td><input name="saleSw" class="number"/></td>
                                <td><input name="saleSnxw" class="number"/></td>
                                <td class="active"><input name="saleXn" deSumCol="14,15,16"/></td>
                                <td><input name="saleGy" class="number"/></td>
                                <td><input name="exportOut" class="number"/></td>
                                <td><input name="transferReserveOil" class="number"/></td>
                                <td><input name="otherExpend" class="number"/></td>
                                <td><input name="inventorySubtotal" class="number"/></td>
                                <td><input name="inventorySwStore" class="number"/></td>
                                <input name="grainType" value="${fn:split(type,"-")[0] }" type="hidden">
                                <input name="ordernum" value="${i.count}" type="hidden">
                                <input name="cssClass" value="${fn:split(type,"-")[1] }-${fn:split(type,"-")[2] }" type="hidden">
                            </tr>
                            <%----%>
                        </c:forEach>
                    </c:if>
                    <c:if test="${!empty splyList}">
                        <c:forEach items="${splyList}" var="sply" varStatus="i">
                            <tr class="text-center <c:if test='${fn:split(sply.cssClass,"-")[1] }'>active</c:if>" name="${sply.grainType}" id="tr-${i.count}">
                                <td class="active"><input name="preStock" value="${sply.preStock}"/></td>
                                <td class="active"><input name="totalIncomeSubtotal" value="${sply.totalIncomeSubtotal}" sumCol="2,5,10-12"/></td>
                                <td><input name="productorInSubtotal" class="number" value="${sply.productorInSubtotal}"/></td>
                                <td><input name="productorInSw" class="number" value="${sply.productorInSw}"></td>
                                <td><input name="productorInSn" class="number" value="${sply.productorInSn}"/></td>
                                <td><input name="enterpriseInSubtotal" class="number" value="${sply.enterpriseInSubtotal}"></td>
                                <td><input name="enterpriseInSw" class="number" value="${sply.enterpriseInSw}"/></td>
                                <td><input name="enterpriseInSnxw" class="number" value="${sply.enterpriseInSnxw}"></td>
                                <td><input name="enterpriseInXn" class="number" value="${sply.enterpriseInXn}"></td>
                                <td><input name="enterpriseInGy" class="number" value="${sply.enterpriseInGy}"/></td>
                                <td><input name="importedIn" class="number" value="${sply.importedIn}"/></td>
                                <td><input name="reserveIn" class="number" value="${sply.reserveIn}"/></td>
                                <td><input name="otherIncome" class="number" value="${sply.otherIncome}"/></td>
                                <td class="active"><input name="otherExpendSubtotal" value="${sply.otherExpendSubtotal}" sumCol="14,19-21"/></td>
                                <td><input name="saleSubtotal" class="number" value="${sply.saleSubtotal}"/></td>
                                <td><input name="saleSw" class="number" value="${sply.saleSw}"/></td>
                                <td><input name="saleSnxw" class="number" value="${sply.saleSnxw}"/></td>
                                <td class="active"><input name="saleXn" value="${sply.saleXn}" deSumCol="14,15,16"/></td>
                                <td><input name="saleGy" class="number" value="${sply.saleGy}"/></td>
                                <td><input name="exportOut" class="number" value="${sply.exportOut}"/></td>
                                <td><input name="transferReserveOil" class="number" value="${sply.transferReserveOil}"/></td>
                                <td><input name="otherExpend" class="number" value="${sply.otherExpend}"/></td>
                                <td><input name="inventorySubtotal" class="number" value="${sply.inventorySubtotal}"/></td>
                                <td><input name="inventorySwStore" class="number" value="${sply.inventorySwStore}"/></td>
                                <input name="grainType" value="${sply.grainType}" type="hidden">
                                <input name="ordernum" value="${i.count}" type="hidden">
                                <input name="cssClass" value="${sply.cssClass}" type="hidden">
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
    var monthStatus = '${reportMain.reportStatus}'; //月报状态
    $("#reportId").val('${reportId}');
    var saveUrl = "${ctx}/reportSply/saveSply.shtml";
    var saveProxyUrl = "/reportSply/saveProxySply.shtml";
    var exportUrl='${ctx}/reportSply/exportSply.shtml';
    var dataList = '${splyList}';
</script>