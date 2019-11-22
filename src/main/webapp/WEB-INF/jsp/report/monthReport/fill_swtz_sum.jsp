<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .redBole{
        color:red;
        font-weight:bold;
    }
</style>
<input type="hidden" name="id" value="${reportMain.id}">
<div class="content_right tab-content">
    <div class="text-left time" style="margin: 10px">
        <table width="100%">
            <tr>
                <td width="33%" id="sumMonth">填报时间：<span id="nowMonth"><fmt:formatDate value="${ fillTime }"  pattern="yyyy年MM月dd日"/></span></td>
                <td align="center"><span><font color="#6495ed" id="status">【${status}】</font></i>粮油库存实物台账月报表</span></td>
                <td width="33%"><div class="text-right time" style="right: 30px;" id="name-unite">计量单位：<span id="unite">吨</span></div></td>
            </tr>
        </table>
    </div>
    <div class="con_box">
        <div class="table_box tab-pane slide_table" id="panel-05">
            <!-- 左上角头部固定-->
            <div class="public1" style="width: 200px;height: 28px;">
                <table class="table table-bordered nav_left" style="width: 200px;background-color: white;">
                    <tr>
                        <th class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;">储存库点名称</th>
                    </tr>
                </table>
            </div>
            <!-- 侧列固定-->
            <div class="public" style="width: 200px;height: 100%;padding-bottom: 17px">
                <table class="table table-bordered nav_left" style="width: 200px;background-color: white;" id="leftTable">
                    <tr><th class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;"></th></tr>
                    <tr class="active redBole"><td class="text-center list_2 thick">粮食合计</td></tr>

                    <c:forEach items="${swtzList}" var="o" varStatus="i">
                        <tr class="text-center"><td class="list_4 ">${o.reportWarehouse}</td></tr>
                    </c:forEach>

                </table>
            </div>
            <!-- 头部固定-->
            <div class="public2" style="height: 56px;border-left: 201px solid white;">
                <table class="table table-bordered header" style="border-bottom: 1px solid #7e9bb0">
                    <thead>
                    <tr>
                        <th rowspan="2" class="text-center">品种</th><th rowspan="2" class="text-center">数量</th><th rowspan="2" class="text-center">产地</th><th rowspan="2" class="text-center">收获年份</th><th colspan="3" class="text-center">储存品质情况</th><th colspan="3" class="text-center">存储方式</th><
                    </tr>
                    <tr >
                        <th class="text-center">宜存数量</th><th class="text-center">轻度不宜存数量</th><th class="text-center">重度不宜存数量</th><th class="text-center">包装</th><th class="text-center">散装</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <!-- 表格-->
            <div class="table_tab" style="border-left: 201px solid white;">
                <table class="table table-bordered slide_table" style="..">
                    <!-- 表格内容 start -->
                    <tbody id="sumTbody">
                    <tr class="active redBole" name="粮食合计">
                        <td></td><td><input sumCol="quantity"  readonly/></td><td></td><td></td><td><input sumCol="advisedDeposit" readonly /></td><td><input sumCol="slightlyUnsuitable" readonly /></td></td><td><input sumCol="severeUnsuitable" readonly /></td><td><input sumCol="packing" readonly /></td><td><input sumCol="bulk" readonly /></td>
                    </tr>
                    <c:forEach items="${swtzList}" var="o">
                        <tr class="text-center" name="${o}">
                            <td><input name="variety" value="${o.variety}"/></td><td><input name="quantity" value="${o.quantity}"/></td><td><input name="origin" value="${o.origin}"/></td><td><input name="harvestYear" value="${o.harvestYear}"/></td>
                            <td><input name="advisedDeposit" value="${o.advisedDeposit}"/></td><td><input name="slightlyUnsuitable" value="${o.slightlyUnsuitable}"/></td></td><td><input name="severeUnsuitable" value="${o.severeUnsuitable}"/></td><td><input name="packing" value="${o.packing}"/></td><td><input name="bulk" value="${o.bulk}"/></td>
                        </tr>
                    </c:forEach>
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
    var exportUrl='${ctx}/reportSwtz/exportSwtzSum.shtml';
    var dataList = '${swtzList}';

    function sumToFirst() {
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
    });

</script>