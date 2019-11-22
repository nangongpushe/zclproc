<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List" %>
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
                <td width="30%"><span><font color="#6495ed" id="status">【${status}】</font>${reportName}</span></td>
                <td width="20%"><div class="text-right time" style="right: 30px;" id="name-unite">计量单位：<span id="unite">吨</span></div></td>
            </tr>
        </table>
    </div>
    <div class="con_box">
        <div class="table_box tab-pane slide_table active" id="panel-01">
            <div class="public1" style="width: 200px;height: 57px;">
                <table class="table table-bordered nav_left" style="width: 200px;background-color: white;">
                    <tr><th class="td_first text-center" style="width: 200px;height: 57px !important;background-color: #e7f3f7;">品种指标</th></tr>
                </table>
            </div>
            <div class="public" style="width: 200px;height: 100%;padding-bottom: 17px">
                <table class="table table-bordered nav_left" id="nav_left01" style="width: 200px;background-color: white;">
                    <tr><th class="td_first text-center" style="width: 200px;height: 57px !important;background-color: #e7f3f7;">品种指标</th></tr>
                    <c:if test="${empty xwswList}">
                        <c:forEach items="${list}" var="type" varStatus="i">
                            <tr <c:if test='${fn:split(type,"-")[2] }'>class="active"</c:if>><td class="${fn:split(type,"-")[1] } active">${fn:split(type,"-")[0] }</td></tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${!empty xwswList}">
                        <c:forEach items="${xwswList}" var="xwsw" varStatus="i">
                            <tr <c:if test='${fn:split(xwsw.cssClass,"-")[1] }'>class="active"</c:if>><td class="${fn:split(xwsw.cssClass,"-")[0] } active">${xwsw.grainType}</td></tr>
                        </c:forEach>
                    </c:if>
                </table>
            </div>
            <div class="public2" style="height: 57px">
                <table class="table table-bordered header" style="border-bottom: 1px solid #7e9bb0">
                    <thead>
                    <tr ><td colspan="32" style="font-weight: bold;">${reportName}分省合计</td></tr>
                    <tr>
                        <th>小计</th><th>${fix}北京</th><th>${fix}天津</th><th>${fix}河北 </th><th>${fix}山西</th><th>${fix}内蒙古</th>
                        <th>${fix}辽宁</th><th>${fix}吉林</th><th>${fix}黑龙江</th><th>${fix}上海</th><th>${fix}江苏</th><th>${fix}浙江</th><th>${fix}安徽</th>
                        <th>${fix}福建</th><th>${fix}江西</th><th>${fix}山东</th><th>${fix}河南</th><th>${fix}湖北</th><th>${fix}湖南</th><th>${fix}广东</th>
                        <th>${fix}广西</th><th>${fix}海南</th><th>${fix}重庆</th><th>${fix}四川</th><th>${fix}贵州</th><th>${fix}云南</th><th>${fix}西藏</th>
                        <th>${fix}陕西</th><th>${fix}甘肃</th><th>${fix}青海</th><th>${fix}宁夏</th><th>${fix}新疆</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="table_tab">
                <table class="table table-bordered" style="..">
                    <!-- 表格内容 start -->
                    <tbody id="sumTbody">
                    <c:if test="${empty xwswList}">
                        <c:forEach items="${list}" var="type" varStatus="i">
                            <tr class="text-center <c:if test='${fn:split(type,"-")[2] }'>active</c:if>" name="${fn:split(type,"-")[0] }" id="tr-${i.count}">
                                <td class="active"><input name="subtotal" class="readOnly" sumCol="1-31"/></td><td><input name="beijing" class="number"/></td><td><input name="tianjin" class="number"/></td><td><input name="hebei" class="number"></td><td><input name="shanxi" class="number"/></td><td><input name="neimenggu" class="number"></td><td><input name="liaoning" class="number"/></td><td><input name="jinli" class="number"></td><td><input name="heilongjian" class="number"></td><td><input name="shanghai" class="number"/></td>
                                <td><input name="jiangsu" class="number"/></td><td><input name="zhejiang" class="number"/></td><td><input name="anhui" class="number"/></td><td><input name="fujian" class="number"/></td><td><input name="jiangxi" class="number"/></td><td><input name="shandong" class="number"/></td><td><input name="henan" class="number"/></td><td><input name="hubei" class="number"/></td><td><input name="hunan" class="number"/></td><td><input name="guangdong" class="number"/></td><td><input name="guangxi" class="number"/></td>
                                <td><input name="hainan" class="number"/></td><td><input name="chongqing" class="number"/></td><td><input name="sichuan" class="number"/></td><td><input name="guizhou" class="number"/></td><td><input name="yunnan" class="number"/></td><td><input name="xizang" class="number"/></td><td><input name="shanXi" class="number"/></td><td><input name="gansu" class="number"/></td><td><input name="qinghai" class="number"/></td><td><input name="ningxia" class="number"/></td>
                                <td><input name="xinjiang" class="number"/></td>
                                <input name="grainType" value="${fn:split(type,"-")[0] }" type="hidden">
                                <input name="ordernum" value="${i.count}" type="hidden">
                                <input name="cssClass" value="${fn:split(type,"-")[1] }-${fn:split(type,"-")[2] }" type="hidden">
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${!empty xwswList}">
                        <c:forEach items="${xwswList}" var="xwsw" varStatus="i">
                            <tr class="text-center <c:if test='${fn:split(xwsw.cssClass,"-")[1] }'>active</c:if>" name="${xwsw.grainType}" id="tr-${i.count}">
                                <td class="active"><input name="subtotal" class="readOnly" value="${xwsw.subtotal}" sumCol="1-31"/></td><td><input name="beijing" class="number" value="${xwsw.beijing}"/></td>
                                <td><input name="tianjin" class="number" value="${xwsw.tianjin}"/></td><td><input name="hebei" class="number" value="${xwsw.hebei}"></td>
                                <td><input name="shanxi" class="number" value="${xwsw.shanxi}"/></td><td><input name="neimenggu" class="number" value="${xwsw.neimenggu}"></td>
                                <td><input name="liaoning" class="number" value="${xwsw.liaoning}"/></td><td><input name="jinli" class="number" value="${xwsw.jinli}"></td>
                                <td><input name="heilongjian" class="number" value="${xwsw.heilongjian}"></td><td><input name="shanghai" class="number" value="${xwsw.shanghai}"/></td>
                                <td><input name="jiangsu" class="number" value="${xwsw.jiangsu}"/></td><td><input name="zhejiang" class="number" value="${xwsw.zhejiang}"/></td><td><input name="anhui" class="number" value="${xwsw.anhui}"/></td>
                                <td><input name="fujian" class="number" value="${xwsw.fujian}"/></td><td><input name="jiangxi" class="number" value="${xwsw.jiangxi}"/></td>
                                <td><input name="shandong" class="number" value="${xwsw.shandong}"/></td><td><input name="henan" class="number" value="${xwsw.henan}"/></td>
                                <td><input name="hubei" class="number" value="${xwsw.hubei}"/></td><td><input name="hunan" class="number" value="${xwsw.hunan}"/></td>
                                <td><input name="guangdong" class="number" value="${xwsw.guangdong}"/></td><td><input name="guangxi" class="number" value="${xwsw.guangxi}"/></td>
                                <td><input name="hainan" class="number" value="${xwsw.hainan}"/></td><td><input name="chongqing" class="number" value="${xwsw.chongqing}"/></td>
                                <td><input name="sichuan" class="number" value="${xwsw.sichuan}"/></td><td><input name="guizhou" class="number" value="${xwsw.guizhou}"/></td>
                                <td><input name="yunnan" class="number" value="${xwsw.yunnan}"/></td><td><input name="xizang" class="number" value="${xwsw.xizang}"/></td>
                                <td><input name="shanXi" class="number" value="${xwsw.shanXi}"/></td><td><input name="gansu" class="number" value="${xwsw.gansu}"/></td>
                                <td><input name="qinghai" class="number" value="${xwsw.qinghai}"/></td><td><input name="ningxia" class="number" value="${xwsw.ningxia}"/></td>
                                <td><input name="xinjiang" class="number" value="${xwsw.xinjiang}"/></td>
                                <input name="grainType" value="${xwsw.grainType}" type="hidden">
                                <input name="ordernum" value="${i.count}" type="hidden">
                                <input name="cssClass" value="${xwsw.cssClass}" type="hidden">
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
    var saveUrl = "${ctx}/reportXwsw/saveXwsw.shtml";
    var saveProxyUrl = "/reportXwsw/saveProxyXwsw.shtml";
    var exportUrl='${ctx}/reportXwsw/exportXwsw.shtml';
    var dataList = '${xwswList}';
</script>