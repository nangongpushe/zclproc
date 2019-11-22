<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
    .table_box th, .table_box td {
        font-size: 12px;
        height: 29px !important;
        word-wrap: normal !important;
        min-width: 97px;
    }
</style>
<input type="hidden" name="id" value="${reportMain.id}">
<div class="content_right tab-content">
    <div class="text-left time" style="margin: 10px">
        <table width="100%">
            <tr>
                <td width="33%" id="sumMonth">填报时间：<span id="nowMonth"><fmt:formatDate value="${ fillTime }"  pattern="yyyy年MM月dd日"/></span></td>
                <td align="center"><span><font color="#6495ed" id="status">【${status}】</font></i>包装物库存月报表</span></td>
                <td width="33%"><div class="text-right time" style="right: 30px;" id="name-unite">计量单位：<span id="unite">条</span></div></td>
            </tr>
        </table>
    </div>
    <div class="con_box">
        <div class="table_box tab-pane slide_table" id="panel-06">
            <!-- 左上角头部固定-->
            <div class="public1" style="width: 200px;height: 29px;">
                <table class="table table-bordered nav_left" style="background-color: white;">
                    <tr>
                        <th rowspan="2" colspan="2" class="td_first text-center" style="min-width: 97px;height: 58px !important;background-color: #e7f3f7;">包装物名称</th>
                    </tr>
                </table>
            </div>
            <!-- 侧列固定   style="position: relative;top: 60px;"-->
            
            <div class="public" style="width: 150px;height: 100%;padding-bottom: 17px;top:0px;">
				<!-- 占位 别删 -->
				<span style="display: inline-block;height: 59px;">noShow</span> 
                <!-- 占位 别删 -->
                <table class="table table-bordered nav_left" style="background-color: white;">
                        <%--<th rowspan="1" colspan="1" class="td_first text-center" style="min-width: 97px;height: 58px !important;background-color: #e7f3f7;">包装物名称</th>--%>
                    <tr class="text-center">
                        <td rowspan="5">标新袋</td>
                        <td>装粮麻袋</td>
                    </tr>
                    <tr class="text-center">
                        <td>调运麻袋</td>
                    </tr>
                    <tr class="text-center">
                        <td>其他用途</td>
                    </tr>
                    <tr class="text-center">
                        <td>空麻袋</td>
                    </tr>
                    <tr class="text-center">
                        <td>小计</td>
                    </tr>

                    <tr class="text-center">
                        <td rowspan="5">标旧袋</td>
                        <td>装粮麻袋</td>
                    </tr>
                    <tr class="text-center">
                        <td>调运麻袋</td>
                    </tr>
                    <tr class="text-center">
                        <td>其他用途</td>
                    </tr>
                    <tr class="text-center">
                        <td>空麻袋</td>
                    </tr>
                    <tr class="text-center">
                        <td>小计</td>
                    </tr>

                    <tr class="text-center">
                        <td rowspan="5">杂袋</td>
                        <td>装粮麻袋</td>
                    </tr>
                    <tr class="text-center">
                        <td>调运麻袋</td>
                    </tr>
                    <tr class="text-center">
                        <td>其他用途</td>
                    </tr>
                    <tr class="text-center">
                        <td>空麻袋</td>
                    </tr>
                    <tr class="text-center">
                        <td>小计</td>
                    </tr>



                    <tr class="text-center">
                        <td>废袋</td>
                        <td>空麻袋</td>
                    </tr>

                    <tr class="text-center">
                        <td colspan="2">总计</td>
                    </tr>
                </table>
            </div>
            <!-- 头部固定-->
            <div class="public2" style="height: 58px; border-left: 200px solid white;">
                <table class="table table-bordered header" style="border-bottom: 1px solid #7e9bb0">
                    <thead>
                    <tr>
                        <th colspan="${fn:length(reportWarehouses)}">单位名称</th>
                        <th rowspan="2">公司合计</th>
                    </tr>
                    <tr>
                        <c:forEach var="o" items="${reportWarehouses}">
                            <th>${o}</th>
                        </c:forEach>
                    </tr>
                    </thead>
                </table>
            </div>
            <!-- 表格-->
            <div class="table_tab" style="border-left: 200px solid white;">
                <table class="table table-bordered slide_table" style="border-left: 540px" id="bzwData">
                    <!-- 表格内容 start -->
                    <tbody>

                    <tr class="text-center">
                        <c:forEach var="o" items="${list1_1}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list1_2}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list1_3}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list1_4}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list1_5}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list2_1}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list2_2}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list2_3}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list2_4}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list2_5}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list3_1}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list3_2}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list3_3}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list3_4}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list3_5}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list4_1}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>
                    <tr class="text-center">
                        <c:forEach var="o" items="${list5_1}">
                            <td>${o}</td>
                        </c:forEach>
                    </tr>

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
    var exportUrl='${ctx}/reportBzw/exportBzwSum.shtml';
    var dataList = '${bzwList}';
    $(function () {
        //总计
        $('#bzwData td[sumRow]').each(function () {
            var tdName = $(this).attr('sumRow');
            var sumTotal = 0;
            $('#bzwData td[name='+tdName+']').not($(this)).each(function () {
                sumTotal = accAdd(sumTotal,$(this).text())
            });
            $(this).text(sumTotal);
        });

        //统计公司小计
        $('#bzwData tr:not(.remark)').each(function () {
            var sumTotal = 0;
            $(this).find(".sumCol").siblings().each(function () {
                sumTotal = accAdd(sumTotal,$(this).text());
            });
            $(this).find(".sumCol").text(sumTotal);
        });
    });

</script>