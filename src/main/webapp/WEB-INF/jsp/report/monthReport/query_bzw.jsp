<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<input type="hidden" name="id" value="${reportMain.id}">
<div class="content_right tab-content">
    <div class="layui-tab" lay-filter="test">
    <ul class="layui-tab-title">
        <li class="layui-this" data-type="库汇总">库汇总</li>
        <li data-type="库里详表">库详表</li>
    </ul>
    </div>
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
        <div class="table_box tab-pane slide_table" id="panel-06" >
            <!-- 库汇总-->
            <div class="" style="width: 100%;height: 100%;padding-bottom: 17px;top:-1px;">
                <table class="table table-bordered nav_left" style="background-color: white;" id="leftTable1">
                    <tr>
                        <th class="td_first text-center" rowspan="2">包装物性质</th><th class="td_first text-center" colspan="5">期 末 实 际 库 存</th><th class="td_first text-center" rowspan="2">备注</th>
                    </tr>
                    <tr>
                        <th class="td_first text-center">装粮麻袋</th><th class="td_first text-center">调运麻袋</th><th class="td_first text-center">空 麻 袋</th><th class="td_first text-center">其他用途</th><th class="td_first text-center">小  计</th>
                    </tr>
                    <tr class="text-center">
                        <td>标 新 袋</td><td>${bzwList[0].biaoxin}</td><td>${bzwList[1].biaoxin}</td><td>${bzwList[2].biaoxin}</td><td>${bzwList[3].biaoxin}</td><td>${bzwList[0].biaoxin+bzwList[1].biaoxin+bzwList[2].biaoxin}</td><td></td>
                    </tr>
                    <tr class="text-center">
                        <td>标 旧 袋</td><td>${bzwList[0].biaojiu}</td><td>${bzwList[1].biaojiu}</td><td>${bzwList[2].biaojiu}</td><td>${bzwList[3].biaojiu}</td><td>${bzwList[0].biaojiu+bzwList[1].biaojiu+bzwList[2].biaojiu}</td><td></td>
                    </tr>
                    <tr class="text-center">
                        <td>杂  袋</td><td>${bzwList[0].zadai}</td><td>${bzwList[1].zadai}</td><td>${bzwList[2].zadai}</td><td>${bzwList[3].zadai}</td><td>${bzwList[0].zadai+bzwList[1].zadai+bzwList[2].zadai}</td><td></td>
                    </tr>
                    <tr class="text-center">
                        <td>废  袋</td><td>${bzwList[0].feidai}</td><td>${bzwList[1].feidai}</td><td>${bzwList[2].feidai}</td><td>${bzwList[3].feidai}</td><td>${bzwList[0].feidai+bzwList[1].feidai+bzwList[2].feidai}</td><td></td>
                    </tr>

                    <tr class="text-center">
                        <td>总     计</td><td>${bzwList[0].subtotal}</td><td>${bzwList[1].subtotal}</td><td>${bzwList[2].subtotal}</td><td>${bzwList[3].subtotal}</td><td>${bzwList[0].subtotal+bzwList[1].subtotal+bzwList[2].subtotal}</td><td></td>
                    </tr>
                    <tr class="text-center">
                        <td>备     注</td><td colspan="6"></td>
                    </tr>
                </table>

                <%--库详请--%>
                <table class="table table-bordered nav_left" style="background-color: white;display: none" id="leftTable2">
                    <tr>
                        <th class="td_first text-center" rowspan="2">储存库点名称</th><th class="td_first text-center">仓号</th><th class="td_first text-center" rowspan="2">包装物用途</th><th class="td_first text-center" rowspan="2">管理属性</th><th class="td_first text-center" rowspan="2">数量</th><th class="td_first text-center" rowspan="2">标新</th><th class="td_first text-center" rowspan="2">标旧</th><th class="td_first text-center" rowspan="2">杂袋</th><th class="td_first text-center" rowspan="2">废袋</th><th class="td_first text-center" rowspan="2">备注</th>
                    </tr>
                    <tr><th class="td_first text-center">(货位)</th></tr>
                    <c:forEach items="${list}" var="o" varStatus="i">
                        <tr class="text-center row${i.index}">
                            <td>${o.reportWarehouse}</td>
                            <td>${o.storehouse}</td>
                            <td>${o.packageProperty}</td>
                            <td>${o.manageProperty}</td>
                            <td>${o.subtotal}</td>
                            <td>${o.biaoxin}</td>
                            <td>${o.biaojiu}</td>
                            <td>${o.zadai}</td>
                            <td>${o.feidai}</td>
                            <td>${o.remark}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>
<script language="javascript" type="text/javascript">
    var status = '${status}'; //报表状态
    var monthStatus = '${reportMain.reportStatus}'; //月报状态
    $("#reportId").val('${reportId}');
    var saveUrl = "${ctx}/reportBzw/saveBzw.shtml";
    var exportUrl='${ctx}/reportBzw/exportQueryBzw.shtml';
    var dataList = '${bzwList}';

    var bzwReportType="sum";//报表类型
    layui.element.on('tab(test)', function(data){
        var type = $(this).attr('data-type');
        if(type=='库汇总'){
            bzwReportType = "sum";
            $('#leftTable1').show();
            $('#leftTable2').hide();
        }else{
            bzwReportType = "detail";
            $('#leftTable1').hide();
            $('#leftTable2').show();
        }
    });
</script>