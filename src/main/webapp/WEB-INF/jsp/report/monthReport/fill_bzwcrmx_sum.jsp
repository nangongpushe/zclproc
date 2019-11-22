<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<input type="hidden" name="id" value="${reportMain.id}">
<div class="content_right tab-content">
    <div class="text-left time" style="margin: 10px">
        <table width="100%">
            <tr>
                <td width="33%" id="sumMonth">填报时间：<span id="nowMonth"><fmt:formatDate value="${ fillTime }"  pattern="yyyy年MM月dd日"/></span></td>
                <td align="center"><span><font color="#6495ed" id="status">【${status}】</font></i>库存包装物出入库明细表</span></td>
                <td width="33%"><div class="text-right time" style="right: 30px;" id="name-unite">计量单位：<span id="unite">条</span></div></td>
            </tr>
        </table>
    </div>

    <div class="con_box">
        <div class="table_box tab-pane slide_table" id="panel-06">
            <!-- 左上角头部固定-->
            <div class="public1" style="width: 200px;height: 28px;">
                <table class="table table-bordered nav_left" style="width: 200px;background-color: white;">
                    <tr>
                        <th class="td_first text-center" style="min-width: 147px;height: 56px !important;background-color: #e7f3f7;">库点名称</th>
                        <th class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;">日期</th>
                        <%--<th class="td_first text-center" style="min-width: 147px;height: 56px !important;background-color: #e7f3f7;">摘要</th>--%>
                    </tr>
                </table>
            </div>
            <!-- 侧列固定-->
            <div class="public" style="width: 200px;height: 100%;padding-bottom: 17px">
                <table class="table table-bordered nav_left swtzTable" style="width: 200px;background-color: white;" id="leftTable">
                    <tr><th class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;"></th></tr>

                    <c:forEach items="${bzwcrmxList}" var="o" varStatus="i">
                        <tr class="text-center row${i.index}">
                            <%--<td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow(${i.index})">删除</a></td>--%>
                            <td>
                                <input type="text" class="layui-input" lay-verify="required" name="reportWarehouse" id="reportWarehouse"  value="${o.reportWarehouse}"  autocomplete="off"/>
                            </td>
                            <td>
                                <input type="text" class="layui-input" lay-verify="required" name="detailDate" id="detailDate"  value="${o.detailDate}"  autocomplete="off" />
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
            <!-- 头部固定-->
            <div class="public2" style="height: 56px;border-left: 295px solid white;">
                <table class="table table-bordered header" style="border-bottom: 1px solid #7e9bb0">
                    <thead>
                    <tr>
                        <th colspan="4" class="text-center">上期库存</th><th colspan="4" class="text-center">收入</th><th colspan="4" class="text-center">支出</th><th colspan="4" class="text-center">结余库存</th><th rowspan="2" class="text-center">备注</th>
                    </tr>
                    <tr >
                        <th class="text-center">标新</th><th class="text-center">标旧</th><th class="text-center">杂袋</th><th class="text-center">废袋</th><th class="text-center">标新</th><th class="text-center">标旧</th><th class="text-center">杂袋</th><th class="text-center">废袋</th><th class="text-center">标新</th><th class="text-center">标旧</th><th class="text-center">杂袋</th><th class="text-center">废袋</th><th class="text-center">标新</th><th class="text-center">标旧</th><th class="text-center">杂袋</th><th class="text-center">废袋</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <!-- 表格-->
            <div class="table_tab" style="border-left: 295px solid white;">
                <table class="table table-bordered slide_table" style="..">
                    <!-- 表格内容 start -->
                    <tbody id="sumTbody">

                    <c:forEach items="${bzwcrmxList}" var="o" varStatus="i">
                        <tr class="text-center row${i.index}" name="${o}">
                            <td><input name="priorNew" class="number" value="${o.priorNew}"/></td>
                            <td><input name="priorOld" class="number" value="${o.priorOld}"/></td>
                            <td>
                                <input name="priorMixed" class="number" value="${o.priorMixed}"/>
                            </td>
                            <td>
                                <input name="priorWaste" class="number" value="${o.priorWaste}"/>
                            </td>
                            <td>
                                <input name="incomeNew" class="number" value="${o.incomeNew}"/>
                            </td>
                            <td>
                                <input name="incomeOld" class="number" value="${o.incomeOld}"/>
                            </td>
                            <td>
                                <input name="incomeMixed" class="number" value="${o.incomeMixed}"/>
                            </td>
                            <td>
                                <input name="incomeWaste" class="number" value="${o.incomeMixed}"/>
                            </td>
                            <td>
                                <input name="expendNew" class="number" value="${o.expendNew}"/>
                            </td>
                            <td>
                                <input name="expendOld" class="number" value="${o.expendOld}"/>
                            </td>
                            <td>
                                <input name="expendMixed" class="number" value="${o.expendMixed}"/>
                            </td>
                            <td>
                                <input name="expendWaste" class="number" value="${o.expendWaste}"/>
                            </td>
                            <td>
                                <input name="balanceNew" class="number" value="${o.balanceNew}"/>
                            </td>
                            <td>
                                <input name="balanceOld" class="number" value="${o.balanceOld}"/>
                            </td>
                            <td>
                                <input name="balanceMixed" class="number" value="${o.balanceMixed}"/>
                            </td>
                            <td>
                                <input name="balanceWaste" class="number" value="${o.balanceWaste}"/>
                            </td>

                            <td>
                                <textarea name="remark"  maxlength="500" style="width:148px;height:28px;">${o.remark}</textarea>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <!-- 表格内容 end -->
                </table>
            </div>
        </div>
        <%--<button type="button" style="display: none;margin-right: 32px" class="layui-btn layui-btn-small addRow"  onclick="addRow()">增加一行</button>
        备注：<textarea name="comments" id="comments"  rows="10" style="width:854px;height:60px;vertical-align: top">${reportMain.comments}</textarea>--%>
    </div>

</div>
<script language="javascript" type="text/javascript">
    var status = '${status}'; //报表状态
    var monthStatus = '${reportMain.reportStatus}'; //月报状态
    $("#reportId").val('${reportId}');
    var exportUrl='${ctx}/reportBzwcrmx/exportBzwcrmxSum.shtml';
    var dataList = '${bzwcrmxList}';

   /* function sumToFirst() {
        $('#sumTbody input[sumCol]').each(function () {
            var sumCol = $(this).attr('sumCol');
            console.log(sumCol);
            var sumTotal = 0;
            $('#sumTbody input[name='+sumCol+']').not($(this)).each(function () {
                sumTotal = accAdd(sumTotal,$(this).val())
            });
            $(this).val(sumTotal);
        });
    }

    $(function () {
        if(dataList)
            sumToFirst()
    });*/

</script>