<%@ page import="com.dhc.fastersoft.common.shrio.token.manager.TokenManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<input type="hidden" name="id" value="${reportMain.id}">
<div class="content_right tab-content">
    <div class="text-left time" style="margin: 10px">
        <table width="100%">
            <tr>
                <td colspan="2">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">统计负责人：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input validate[required]" autocomplete="off" id="manager" name="manager" style="width: 100px" value="${manager}">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">填报单位：</label>
                            <div class="layui-input-inline">
                                <input type="text" class="layui-input" readonly autocomplete="off" id="warehouseName" name="warehouseName"  style="width: 100px" value="${reportWarehouse}">
                            </div>

                        </div>
                    </div>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td width="33%" id="sumMonth">填报时间：<span id="nowMonth"><fmt:formatDate value="${ fillTime }"  pattern="yyyy年MM月dd日"/></span></td>
                <td width="33%"><span><font color="#6495ed" id="status">【${status}】</font></i>库存包装物出入库明细表</span></td>
                <td width="33%"><div class="text-right time" style="right: 30px;" id="name-unite">单位：<span id="unite">条</span></div></td>
            </tr>
        </table>
    </div>
    <div class="con_box">
        <div class="table_box tab-pane slide_table" id="panel-06">
            <!-- 左上角头部固定-->
            <div class="public1" style="width: 200px;height: 28px;">
                <table class="table table-bordered nav_left" style="width: 200px;background-color: white;">
                    <tr>
                        <th class="td_first text-center" style="min-width: 147px;height: 56px !important;background-color: #e7f3f7;">操作</th>
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
                            <td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow(${i.index})">删除</a></td>
                            <td>
                                <input type="text" class="layui-input" lay-verify="required" name="detailDate" id="detailDate"  value="${o.detailDate}"  autocomplete="off" placeholder="--请选择时间--"/>
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
                                <textarea name="remark" placeholder="--请输入--" maxlength="500" style="width:148px;height:28px;">${o.remark}</textarea>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <!-- 表格内容 end -->
                </table>
            </div>
        </div>
        <button type="button" style="display: none;margin-right: 32px" class="layui-btn layui-btn-small addRow"  onclick="addRow()">增加一行</button>
        备注：<textarea name="comments" id="comments"  rows="10" style="width:854px;height:60px;vertical-align: top">${comments}</textarea>
    </div>
</div>

<script language="javascript" type="text/javascript">
    var selectRow; //选择成交明细号的行号；
    var form = layui.form;
    form.render();
    var status = '${status}'; //报表状态
    var monthStatus = '${reportMain.reportStatus}'; //月报状态
    $("#reportId").val('${reportId}');
    var saveUrl = "${ctx}/reportBzwcrmx/saveBzwcrmx.shtml";
    var saveProxyUrl = "${ctx}/reportBzwcrmx/saveProxyBzwcrmx.shtml";
    var exportUrl='${ctx}/reportBzwcrmx/exportBzwcrmx.shtml';
    var dataList = '${bzwcrmxList}';
    var i = '${fn:length(bzwcrmxList)}';
    var laydate = layui.laydate;
    $("#sumTbody .date-year").each(function(){
        laydate.render({
            elem:$(this)[0],
            type:"year",
            format:"yyyy"
        });
    });
    $("#leftTable").find('[name="detailDate"]').each(function(){
        layui.laydate.render({
            elem : $(this)[0],
            type : "date",
            format : "yyyy-MM-dd",
        });
    });

   /* function sumToFirst() {
        $('#sumTbody input[sumRow]').each(function () {
            var sumRow = $(this).attr('sumRow');
            console.log(sumRow);
            var sumTotal = 0;
            $('#sumTbody input[name='+sumRow+']').not($(this)).each(function () {
                sumTotal = accAdd(sumTotal,$(this).val())
            });
            $(this).val(sumTotal);
        });
    }*/

    /*$(function () {
        /!* $(".number").keyup(function(){
            onlyNumber(this);
            sum(this);
        }).blur(function(){
            onlyNumber(this);
            sum(this);
        }); *!/
        if(dataList)
            sumToFirst()
    });*/

    /**
     * 含sumRow属性的自动合计所有name为该属性值的input
     * @param obj
     */
    /*function sum(obj){
        //处理行合计
        var name = $(obj).attr('name');
        $('#sumTbody input[sumRow='+name+']').each(function () {
            var sumTotal = 0;
            $('#sumTbody input[name='+name+']').not($(this)).each(function () {
                sumTotal = accAdd(sumTotal,$(this).val())
            });
            $(this).val(sumTotal);
        });
    }*/

    function addRow() {
        $('#leftTable').append('<tr class="text-center row'+i+'"><td>' +
            '<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow('+i+')">删除</a>' +
            '</td>' +
            '<td>' +
            '<input type="text" lay-verify="required" name="detailDate" id="detailDate" value=""  autocomplete="off" placeholder="--请选择时间--"/>' +
            '</td>' +
            '</tr>');
        var html = '<tr class="text-center row'+i+'">' +
            '<td><input name="priorNew" class="number"/></td>' +
            '<td>'
        html += '<input name="priorOld" class="number"/></td>' +
            '<td><input name="priorMixed" class="number"/></td>' +
            '<td><input name="priorWaste" class="number"/></td>' +
            '<td><input name="incomeNew" class="number"/></td>' +
            '<td><input name="incomeOld" class="number"/></td>' +
            '<td><input name="incomeMixed" class="number"/></td>' +
            '<td><input name="incomeWaste" class="number"/></td>' +
            '<td><input name="expendNew" class="number"/></td>' +
            '<td><input name="expendOld" class="number"/>' +
            '</td><td><input name="expendMixed" class="number"/></td>' +
            '<td><input name="expendWaste" class="number"/></td>' +
            '<td><input name="balanceNew" class="number"/></td>' +
            '<td><input name="balanceOld" class="number"/></td>' +
            '<td><input name="balanceMixed" class="number"/></td>' +
            '<td><input name="balanceWaste" class="number"/></td>' +
            '<td><textarea name="remark" class="form-control" placeholder="--请输入--" maxlength="500" style="width:148px;height:28px;"></textarea></td>' +
            '</tr>'
        $('#sumTbody').append(html);
        i++;
        $(".number").keyup(function(){
            onlyNumber(this);
            //sum(this);
        }).blur(function(){
            onlyNumber(this);
            //sum(this);
        });
        $("#leftTable").find('[name="detailDate"]').each(function(){
            layui.laydate.render({
                elem : $(this)[0],
                type : "date",
                format : "yyyy-MM-dd",
            });
        });
        /*var laydate = layui.laydate;
        $("#sumTbody .date-year").each(function(){
            laydate.render({
                elem:$(this)[0],
                type:"year",
                format:"yyyy"
            });
        });*/
        /*layui.laydate.render({
            elem: $("#detailDate"),
            type: 'date'
        });*/
    }

    function copyAllRow(){
        var jsonlist = new Array();
        var i = 1;
        $("#sumTbody tr").each(function() {
            if(i>1){
                var obj = $(this).find('input,select').serializeObject();
                obj.variety = $(this).find("select[name='variety']").val();
                obj.detailDate = $('#leftTable tr:eq('+i+') input').val();
                obj.extendsWarehouse = $('#leftTable tr:eq('+i+') select').val()
                jsonlist.push(obj);
            }
            i++;
        });

        sessionStorage.setItem('swtzCopyData',JSON.stringify(jsonlist));
        layer.msg('已将数据复制到剪切板');
    }

    function parseAllData(){
        var reportMonth = $("#month").val().split('-');
        reportMonth[1] = Number(reportMonth[1]) - 1 == 0?12: Number(reportMonth[1]) - 1;
        reportMonth[0] = Number(reportMonth[1]) - 1 == 0? Number(reportMonth[0]) - 1:reportMonth[0];
        $.ajax({
            url:"${pageContext.request.contextPath}/reportSwtz/GetLastMonthData.shtml",
            type:"post",
            data:{
                "reportWarehouse":"${reportWarehouse}",
                "reportMonth": reportMonth[0].toString() + '-' + (reportMonth[1] < 10 ? '0'+reportMonth[1]:reportMonth[1])
            },
            success:function(data){
                exportLastMonthData(data);
            }
        });
    }

    function exportLastMonthData(data){
        if(data.success){
            var copyData = data.data;
            for(var j = 0;j<copyData.length;j++){
                for(var item in copyData[j])
                    copyData[j][item] = copyData[j][item] == null ? '': copyData[j][item];
                $('#leftTable').append('<tr class="text-center row'+i+'"><td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow('+i+')">删除</a></td><td><select name="extendsWarehouse"><c:forEach items="${extendsWarehouse}" var="warehouse"><c:if test="${warehouse.warehouseShort != null}"><option <c:if test="warehouse.warehouseShort eq 'copyData[j].extendsWarehouse'">selected</c:if>>${warehouse.warehouseShort}</option></c:if></c:forEach></select></td><td><input name="storehouse" value="'+copyData[j].storehouse+'"></td></tr>');
                var html = '<tr class="text-center row'+i+'">' +
                    '<td><input name="dealSerial"  readonly id="dealSerial'+i+'" onclick="selectSerial('+i+')" value="'+copyData[j].dealSerial+'"/></td>' +
                    '<td><select class="validate[required]" name="variety"><option value="">--请选择--</option>';
                $.each( eval("("+'${grainTypes}'+")"), function(index,grain){
                    if(grain.value != copyData[j].variety)
                        html += '<option value="'+grain.value+'" >'+grain.value+'</option>';
                    else
                        html += '<option value="'+grain.value+'" selected>'+grain.value+'</option>';
                });
                html += '</select></td>' +
                    '<td><input name="quantity" class="number" value="'+copyData[j].quantity+'"/></td>' +
                    '<td><input name="origin" value="'+copyData[j].origin+'"/></td>' +
                    '<td><input name="harvestYear" class="date-year" value="'+copyData[j].harvestYear+'"/></td>' +
                    '<td><input name="brown"  value="'+copyData[j].brown+'"/></td>' +
                    '<td><input name="unitWeight" value="'+copyData[j].unitWeight+'"/></td>' +
                    '<td><input name="impurity" value="'+copyData[j].impurity+'"/></td>' +
                    '<td><input name="dew" value="'+copyData[j].dew+'"/></td>' +
                    '<td><input name="yellowRice" value="'+copyData[j].yellowRice+'"/>' +
                    '</td><td><input name="unsoundGrain" value="'+copyData[j].unsoundGrain+'"/></td>' +
                    '<td><input name="wetGluten" value="'+copyData[j].wetGluten+'"/></td>' +
                    '<td><input name="koh" value="'+copyData[j].koh+'"/></td>' +
                    '<td><input name="mmol" value="'+copyData[j].mmol+'"/></td>' +
                    '<td><input name="advisedDeposit" class="number" value="'+copyData[j].advisedDeposit+'"/></td>' +
                    '<td><input name="slightlyUnsuitable" class="number" value="'+copyData[j].slightlyUnsuitable+'"/></td>' +
                    '<td><input name="severeUnsuitable" class="number" value="'+copyData[j].severeUnsuitable+'"/></td>' +
                    '<td><input name="packing" class="number" value="'+copyData[j].packing+'"/></td>' +
                    '<td><input name="bulk" class="number" value="'+copyData[j].bulk+'"/></td>' +
                    '</tr>'
                $('#sumTbody').append(html);
                i++;
            }
            $(".number").keyup(function(){
                onlyNumber(this);
                //sum(this);
            }).blur(function(){
                onlyNumber(this);
                //sum(this);
            });
            var laydate = layui.laydate;
            $("#sumTbody .date-year").each(function(){
                laydate.render({
                    elem:$(this)[0],
                    type:"year",
                    format:"yyyy"
                });
            });
            //sumToFirst();
        }else
            layer.msg('上月内无数据');
    }

    function delRow(row) {
        $('.row'+row).remove();
    }

   /* function selectSerial(row) {
        selectRow = row;
        $('#myModal').modal({backdrop: 'static'}).modal('show');
    }*/

    function removeActiveClass(obj) {
        $('#myModal').modal('hide');
    }

    var isInit = true;

    /*layui.use(['table'], function() {
        var table = layui.table;
        table.render({
            elem : '#enterpriseTable',
            url : '${pageContext.request.contextPath}/QualitySample/pageQuery.shtml?fillReport=true&nResult=true',
            method : "POST",
            cols : [[
                {fixed : 'left', title : '操作', width : 100, align : 'center', toolbar : '#bar'},
                {field : 'dealSerial',title : '成交子明细号',width:200},
                {field : 'sampleNo',title : '样品编号',width:150},
                {field : 'storehouse',title : '仓/罐号',width:150},
                {field : 'variety',title : '粮食品种',width:150},
                {field : 'harvestYear',title : '收获年份',width:100},
                {field : 'origin',title : '产地',width:150},
                {field:  'validType',title:'检验类型',width:150},
                {field:  'sampleSouce',title:'样品来源',width:150},
                {field:  'samplingDate',title: '扦样日期',width:150}
            ]],//设置表头
            request : {
                pageName : 'page',
                limitName : 'pageSize'
            },
            page:true,//开启分页
            limit:10,
            id:'enterpriseTableId',
            done:function(res,curr,count){
                if(isInit){
                    isInit = false;
                    $('#enterpriseSearch').click();
                }
            },
        });

        //搜索
        $('#enterpriseSearch').click(function() {
            table.reload("enterpriseTableId", {
                method: 'post', //如果无需自定义HTTP类型，可不加该参数
                where : {
                    sampleNo : $('#search #sampleNo').val(),
                    dealSerial : $('#search #dealSerial').val(),
                    storehouse : $('#search #storehouse').val(),
                    variety : $('#search #variety').val(),
                    harvestYear : $('#search #harvestYear').val(),
                    origin : $('#search #origin').val(),
                    validType:$('#search #validType').val(),
                    sampleSouce:$('#search #sampleSouce').val()
                }
            });
        });

        table.on('tool(operation)', function(obj) {
            var data = obj.data;
            if (obj.event === 'choose') {
                var tr = $('#dealSerial'+selectRow).parent().parent();
                $('#dealSerial'+selectRow).val(data.dealSerial);
                $(tr).find("input[name='origin']").val(data.origin);
                $(tr).find("select[name='variety']").val(data.variety);
                $(tr).find("select[name='variety']").attr('disabled',true);
                $(tr).find("input[name='quantity']").val(data.quantity);
                $(tr).find("input[name='harvestYear']").val(data.harvestYear);
                if($('#search #sampleSouce').val() == '${currentPoint}'){
                    $('#leftTable').find('.row'+selectRow).find("input[name='storehouse']").val(data.storehouse);
                }
                if(data.qualityThird != null){
                    var detail = data.qualityThird.qualityThirdItems;
                    $.each(detail,function(index,ele){
                        if(ele.itemName == '出糙率(%)'){
                            $(tr).find("input[name='brown']").val(ele.result);
                        }else if(ele.itemName == '容重(g/l)'){
                            $(tr).find("input[name='unitWeight']").val(ele.result);
                        }else if(ele.itemName == '杂质(%)'){
                            $(tr).find("input[name='impurity']").val(ele.result);
                        }else if(ele.itemName == '水分(%)'){
                            $(tr).find("input[name='dew']").val(ele.result);
                        }else if(ele.itemName == '黄粒米(%)'){
                            $(tr).find("input[name='yellowRice']").val(ele.result);
                        }else if(ele.itemName == '不完善粒(%)'){
                            $(tr).find("input[name='unsoundGrain']").val(ele.result);
                        }else if(ele.itemName == '小麦湿面筋(%)'){
                            $(tr).find("input[name='wetGluten']").val(ele.result);
                        }else if(ele.itemName == '酸价(KOH)(mg/g)'){
                            $(tr).find("input[name='koh']").val(ele.result);
                        }else if(ele.itemName == '过氧化值(mmol/kg)'){
                            $(tr).find("input[name='mmol']").val(ele.result);
                        }
                    });
                }
            }
            $('#myModal').modal('hide');
        });
        //监听FORM结束

    });*/

</script>