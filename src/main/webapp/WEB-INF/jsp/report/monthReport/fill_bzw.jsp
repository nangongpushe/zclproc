<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<input type="hidden" name="id" value="${reportMain.id}">
<div class="content_right tab-content">
    <div class="text-left time" style="margin: 10px">
        <table width="100%">
            <tr>
                <td width="20%" id="sumMonth">
                    填报时间：<span id="nowMonth"><fmt:formatDate value="${fillTime}" pattern="yyyy年MM月dd日"/></span>
                </td>
                <td width="30%">
                    <div class="layui-inline">
                        <label class="layui-form-label">统计负责人：</label>
                        <input class="layui-input" autocomplete="off" id="manager" name="manager" style="width: 100px"
                               value="${manager}">
                    </div>
                </td>
                <td width="30%"><span><font color="#6495ed" id="status">【${status}】</font></i>包装物库存月报表</span></td>
                <td width="20%">
                    <div class="text-right time" style="right: 30px;" id="name-unite">计量单位：<span id="unite">条</span>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div class="con_box">
        <div class="table_box tab-pane slide_table" id="panel-06">
            <!-- 左上角头部固定-->
            <div class="public1" style="width: 200px;height: 28px;">
                <table class="table table-bordered nav_left" style="background-color: white;height: 57px">
                    <tr>
                        <th rowspan="2" class="td_first text-center"
                            style="min-width: 147px;height: 43px !important;background-color: #e7f3f7;">操作
                        </th>
                        <th rowspan="2" class="td_first text-center"
                            style="min-width: 147px;height: 43px !important;background-color: #e7f3f7;">储存库点名称
                        </th>
                    </tr>
                </table>
            </div>
            <!-- 侧列固定-->
            <div class="public" style="width: 200px;height: 100%;padding-bottom: 17px;top:-1px;">
                <table class="table table-bordered nav_left" style="background-color: white;" id="leftTable">
                    <tr>
                        <th class="td_first text-center"
                            style="width: 200px;height: 56px !important;background-color: #e7f3f7;"></th>
                    </tr>
                    <%--<th rowspan="2" class="td_first text-center" style="min-width: 147px;height: 43px !important;background-color: #e7f3f7;">操作</th>
                    <th rowspan="2" class="td_first text-center" style="min-width: 147px;height: 43px !important;background-color: #e7f3f7;">储存库点名称</th>--%>

                    <c:forEach items="${bzwList}" var="o" varStatus="i">
                        <tr class="text-center row${i.index}">
                            <td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow(${i.index})">删除</a>
                            </td>
                            <td class="active">
                                <select name="reportWarehouse" id="reportWarehouse" style="width: 140px">
                                    <c:forEach items="${extendsWarehouse}" var="warehouse">
                                        <c:if test="${warehouse.warehouseShort != null}">
                                            <option
                                                    <c:if test="${warehouse.warehouseShort eq o.reportWarehouse }">selected</c:if> value="${warehouse.id}">${warehouse.warehouseShort}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <!-- 头部固定-->
            <div class="public2" style="height: 57px; border-left: 295px solid white;">
                <table class="table table-bordered header" style="border-bottom: 1px solid #7e9bb0;">
                    <thead>
                    <%--<tr><th class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;"></th></tr>--%>
                    <tr>
                        <th rowspan="2">仓号<br>(货位)</th>
                        <th rowspan="2">包装物用途</th>
                        <th rowspan="2">管理属性</th>
                        <th rowspan="2">数量</th>
                        <th colspan="4">包装物性质</th>
                        <%--<th>标新</th><th>标旧</th><th>杂袋</th><th>废袋</th>--%>
                        <th rowspan="2">备注</th>
                    </tr>
                    <tr>
                        <th>标新</th>
                        <th>标旧</th>
                        <th>杂袋</th>
                        <th>废袋</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <!-- 表格-->
            <div class="table_tab" style="border-left: 295px solid white;">
                <table class="table table-bordered slide_table" style="..">
                    <!-- 表格内容 start -->
                    <tbody id="sumTbody">
                    <c:forEach items="${bzwList}" var="o" varStatus="i">
                        <tr class="text-center row${i.index}">
                            <td><input name="storehouse" value="${o.storehouse}"></td>
                            <td>
                                <select name="packageProperty" class="validate[required]">
                                    <option value="">-请选择-</option>
                                    <option value="空麻袋" <c:if test="${o.packageProperty=='空麻袋'}">selected</c:if>>空麻袋
                                    </option>
                                    <option value="调运麻袋" <c:if test="${o.packageProperty=='调运麻袋'}">selected</c:if>>
                                        调运麻袋
                                    </option>
                                    <option value="装粮麻袋" <c:if test="${o.packageProperty=='装粮麻袋'}">selected</c:if>>
                                        装粮麻袋
                                    </option>
                                    <option value="其他用途" <c:if test="${o.packageProperty=='其他用途'}">selected</c:if>>
                                        其他用途
                                    </option>
                                </select>
                            </td>
                                <%--<td class="active"><input name="manageProperty" value="公司直管" readonly></td>--%>
                            <td class="active">
                                <select name="manageProperty" class="validate[required]">
                                    <option value="">-请选择-</option>
                                    <option value="公司直管" <c:if test="${o.manageProperty=='公司直管'}">selected</c:if>>公司直管
                                    </option>
                                    <option value="库所属" <c:if test="${o.manageProperty=='库所属'}">selected</c:if>>库所属
                                    </option>
                                </select>
                            </td>
                            <td class="active"><input name="subtotal" class="number"  value="${o.subtotal}">
                            </td>
                            <td><input name="biaoxin" oninput="jiSuanTotal(this)" class="number" value="${o.biaoxin}"></td>
                            <td><input name="biaojiu" oninput="jiSuanTotal(this)" class="number" value="${o.biaojiu}">
                            <td><input name="zadai" oninput="jiSuanTotal(this)" class="number" value="${o.zadai}">
                            <td><input name="feidai" oninput="jiSuanTotal(this)" class="number" value="${o.feidai}">
                            </td>
                            <td><input name="remark" value="${o.remark}"></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <!-- 表格内容 end -->
                </table>
            </div>
        </div>
        <button type="button" class="layui-btn layui-btn-small addRow" style="display: none" onclick="addRow()">增加一行
        </button>
        <button type="button" class="layui-btn layui-btn-small addRow" style="display: none" onclick="parseAllData()">导入上月数据</button>
    </div>
</div>
<script language="javascript" type="text/javascript">
    var status = '${status}'; //报表状态
    var monthStatus = '${reportMain.reportStatus}'; //月报状态
    $("#reportId").val('${reportId}');
    var saveUrl = "${ctx}/reportBzw/saveBzw.shtml";
    var saveProxyUrl = "${ctx}/reportBzw/saveProxyBzw.shtml";
    var exportUrl = '${ctx}/reportBzw/exportBzw.shtml';
    var dataList = '${bzwList}';
    var i = '${fn:length(bzwList)}';

    function addRow() {
        $('#leftTable').append('<tr class="text-center row' + i + '"><td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow(' + i + ')">删除</a></td><td class="active">' +
            '<select name="reportWarehouse" style="width: 140px">\n' +
            '\n' +
            '    \t<c:forEach items="${extendsWarehouse}" var="warehouse">\n' +
            '    \t\t<c:if test="${warehouse.warehouseShort != null}">\n' +
            '   \t\t<option <c:if test="${warehouse.warehouseShort eq o.extendsWarehouse }">selected</c:if> value="${warehouse.id}">${warehouse.warehouseShort}</option>\n' +
            '    \t\t</c:if>\n' +
            '     \t</c:forEach>\n' +
            '    \t\t</select></td></tr>');
        $('#sumTbody').append('<tr class="text-center row' + i + '">\n' +
            '                            <td><input name="storehouse"></td>\n' +
            '                            <td>\n' +
            '                                <select name="packageProperty" class=" validate[required]">\n' +
            '                                    <option value="">-请选择-</option>\n' +
            '                                    <option value="空麻袋">空麻袋</option>\n' +
            '                                    <option value="调运麻袋">调运麻袋</option>\n' +
            '                                    <option value="装粮麻袋">装粮麻袋</option>\n' +
            '                                   <option value="其他用途">其他用途</option>\n' +
            '                                </select>\n' +
            '                            </td>\n' +
            '                            <td class="active"><select name="manageProperty" class="validate[required]">\n' +
            '                                        <option value="">-请选择-</option>\n' +
            '                                        <option value="公司直管" >公司直管</option>\n' +
            '                                        <option value="库所属" >库所属</option>\n' +
            '                                    </select><!--<input name="manageProperty" value="公司直管" readonly>-->' +
            '</td>' +
            '<td class="active">' +
            '<input name="subtotal"  readonly>' +
            '</td>' +
            '<td>' +
            '<input name="biaoxin" oninput="jiSuanTotal(this)" class="number">' +
            '</td>' +
            '<td>' +
            '<input name="biaojiu" oninput="jiSuanTotal(this)" class="number">' +
            '</td>' +
            '<td>' +
            '<input name="zadai" oninput="jiSuanTotal(this)" class="number">' +
            '</td>' +
            '<td>' +
            '<input name="feidai" oninput="jiSuanTotal(this)" class="number">' +
            '</td>' +
            '<td><input name="remark">' +
            '</td>\n' +
            '                        </tr>');
        i++;

        //限制数字输入
        $(".number").keyup(function () {
            onlyNumber(this);
            sum(this);
        }).blur(function () {
            onlyNumber(this);
            sum(this);
        });
    }

    function delRow(row) {
        $('.row' + row).remove();
    }
    function jiSuanTotal(that) {
        //alert(111)
        //debugger
        var oParent = $(that).parents('tr');
        var biaoxinVal = Number(oParent.find('input[name="biaoxin"]').val());
        var biaojiuVal = Number(oParent.find('input[name="biaojiu"]').val());
        var zadaiVal = Number(oParent.find('input[name="zadai"]').val());
        var feidaiVal = Number(oParent.find('input[name="feidai"]').val());
        var sum = biaoxinVal+biaojiuVal+zadaiVal+feidaiVal;
        var subtotalEle = oParent.find('input[name="subtotal"]');
        //console.log(oParent)
        //console.log(subtotalEle)
        //console.log(sum)
        //subtotalEle.attr("value",sum);
        subtotalEle.val(sum);
    }

    function  parseAllData() {
        let reportDate = $("#month").val().split("-");
        reportDate[0] = Number(reportDate[1]) - 1 == 0 ? Number(reportDate[0]) - 1 : reportDate[0];
        reportDate[1] = Number(reportDate[1]) - 1 == 0 ? 12 : Number(reportDate[1]) - 1;
        let url = "${pageContext.request.contextPath}/reportBzw/GetLastMonthData.shtml";
        let data = {
            "reportWarehouseId":"${reportWarehouseId}",
            "reportDate": reportDate[0].toString() + '-' + (reportDate[1] < 10 ? '0'+reportDate[1]:reportDate[1]),
        };
        $.post(url,data,function (data) {
            exportLastMonthData(data);
        });
    }


    //缓存库点公司对应的库点信息
    var warehouseList = {};
    if('${extendsWarehouseJson}'){
        warehouseList = JSON.parse('${extendsWarehouseJson}');
    }
    function exportLastMonthData(data){
        if(data.success){
            $("#manager").val(data.manager);
            var copyData = data.data;
            for(var j = 0;j<copyData.length;j++){
                // 将null值变成 ''
                for(var item in copyData[j])
                    copyData[j][item] = copyData[j][item] == null ? '': copyData[j][item];

                debugger
                let leftTableInfo = '<tr class="text-center row' + i + '"><td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow(' + i + ')">删除</a></td><td class="active">' +
                    '<select name="reportWarehouse" style="width: 140px">';

                for(var n in warehouseList){
                    var warehouse = warehouseList[n];
                    if(warehouse.warehouseShort != null && warehouse.warehouseShort != ''){
                        leftTableInfo += '<option value="' + warehouse.id + '" ';
                        if(warehouse.id == copyData[j].reportWarehouseId){
                            leftTableInfo += ' selected '
                        }
                        leftTableInfo += '>' + warehouse.warehouseShort + '</option>'
                    }
                }

                leftTableInfo += '</select>' +
                    '</td>' +
                    '<td>' +
                $('#leftTable').append(leftTableInfo);

                $('#sumTbody').append('<tr class="text-center row' + i + '">\n' +
                    '                            <td><input name="storehouse" value="'+copyData[j].storehouse+'"></td>\n' +
                    '                            <td>\n' +
                    '                                <select name="packageProperty" class=" validate[required]">\n' +
                    '                                    <option value="">-请选择-</option>\n' +
                    '                                    <option value="空麻袋">空麻袋</option>\n' +
                    '                                    <option value="调运麻袋">调运麻袋</option>\n' +
                    '                                    <option value="装粮麻袋">装粮麻袋</option>\n' +
                    '                                   <option value="其他用途">其他用途</option>\n' +
                    '                                </select>\n' +
                    '                            </td>\n' +
                    '                            <td class="active"><select name="manageProperty" class="validate[required]">\n' +
                    '                                        <option value="">-请选择-</option>\n' +
                    '                                        <option value="公司直管" >公司直管</option>\n' +
                    '                                        <option value="库所属" >库所属</option>\n' +
                    '                                    </select><!--<input name="manageProperty" value="公司直管" readonly>-->' +
                    '</td>' +
                    '<td class="active">' +
                    '<input name="subtotal" value="'+copyData[j].subtotal+'"  readonly>' +
                    '</td>' +
                    '<td>' +
                    '<input name="biaoxin" oninput="jiSuanTotal(this)" class="number" value="'+copyData[j].biaoxin+'">' +
                    '</td>' +
                    '<td>' +
                    '<input name="biaojiu" oninput="jiSuanTotal(this)" class="number" value="'+copyData[j].biaojiu+'">' +
                    '</td>' +
                    '<td>' +
                    '<input name="zadai" oninput="jiSuanTotal(this)" class="number" value="'+copyData[j].zadai+'">' +
                    '</td>' +
                    '<td>' +
                    '<input name="feidai" oninput="jiSuanTotal(this)" class="number" value="'+copyData[j].feidai+'">' +
                    '</td>' +
                    '<td><input name="remark" value="'+copyData[j].remark+'">' +
                    '</td>\n' +
                    '                        </tr>');

                $("#sumTbody .row"+i+" select[name='packageProperty']").val(copyData[j].packageProperty);
                $("#sumTbody .row"+i+" select[name='manageProperty']").val(copyData[j].manageProperty);

                i++;
            }
                //限制数字输入
                $(".number").keyup(function () {
                    onlyNumber(this);
                    sum(this);
                }).blur(function () {
                    onlyNumber(this);
                    sum(this);
                });
        }else
            layer.msg('上月内无数据');
    }
</script>