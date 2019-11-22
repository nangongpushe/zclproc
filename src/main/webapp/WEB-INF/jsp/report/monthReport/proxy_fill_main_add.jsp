<%@ page import="com.dhc.fastersoft.entity.enumdata.ReportNameEnum" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../../common/AdminHeader.jsp"%>
<link rel="stylesheet" href="${ctx}/css/commons.css"/>
<link rel="stylesheet" href="${ctx}/css/report_ku_add.css">

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>代储监管</li>
        <li>报表台账</li>
        <li class="active">${title}</li>
    </ol>
</div>
<div class="container-box" style="padding: 0;">
    <div class="page-container">
        <form class="form form-horizontal" id="form-active-add" method="post">
            <input type="hidden" name="reportId" id="reportId" value="${reportId}">
            <%--<input type="hidden" name="reportName" id="reportName" value="${reportName}">--%>
            <input type="hidden" name="title" value="${title}">
            <input type="hidden" name="jsonlist" id="jsonlist">
            <div class="clearfix">
                <table width="100%" style="border-collapse:separate; border-spacing:10px 10px;">
                    <thead>
                    <tr>
                        <td>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled save" disabled>保存草稿</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled send" data-href="##" disabled>上报公司</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled export" disabled>导出</button>
                            <button type="button" id="back" class="layui-btn layui-btn-small" name="cancelBtn" disabled="false"
                                    onclick="back1('${ctx}/reportMonth/proxyFillMainList.shtml')">返回</button>
                        </td>
                        <td align="right">
                            ${enterpriseName}
                            <div class="layui-inline">
                                <select name="reportType" class="form-control" id="reportType">
                                    <option <c:if test="${'储备粮油收支月报表' eq reportName || '商品粮油收支月报表' eq reportName || '销往省外' eq reportName || '省外购进' eq reportName}">selected</c:if>>月报</option>
                                    <option <c:if test="${'粮油库存实物台账月报表' eq reportName || '库存包装物出入库明细表' eq reportName || '包装物库存月报表' eq reportName}">selected</c:if>>台账</option>
                                </select>
                            </div>
                            <div class="layui-inline">
                                <c:if test="${'储备粮油收支月报表' eq reportName || '商品粮油收支月报表' eq reportName || '销往省外' eq reportName || '省外购进' eq reportName}">
                                    <select name="reportName" class="form-control" id="reportName">
                                        <option <c:if test="${'储备粮油收支月报表' eq reportName}">selected</c:if>>储备粮油收支月报表</option>
                                        <option <c:if test="${'商品粮油收支月报表' eq reportName}">selected</c:if>>商品粮油收支月报表</option>
                                        <option <c:if test="${'销往省外' eq reportName}">selected</c:if>>销往省外</option>
                                        <option <c:if test="${'省外购进' eq reportName}">selected</c:if>>省外购进</option>
                                    </select>
                                </c:if>
                                <c:if test="${'粮油库存实物台账月报表' eq reportName || '库存包装物出入库明细表' eq reportName || '包装物库存月报表' eq reportName}">
                                    <select name="reportName" class="form-control" id="reportName">
                                        <option <c:if test="${'粮油库存实物台账月报表' eq reportName}">selected</c:if>>粮油库存实物台账月报表</option>
                                        <option <c:if test="${'包装物库存月报表' eq reportName}">selected</c:if>>包装物库存月报表</option>
                                        <option <c:if test="${'库存包装物出入库明细表' eq reportName}">selected</c:if>>库存包装物出入库明细表</option>
                                    </select>
                                </c:if>
                            </div>
                            <div class="layui-inline">
                                <input type="hidden" name="reportWarehouse" id="reportWarehouse" value="${reportWarehouse}">
                                <input type="hidden" name="reportWarehouseId" id="reportWarehouseId" value="${reportWarehouseId}">
                                <input type="hidden" name="enterpriseName" id="enterpriseName" value="${enterpriseName}">
                                <%--是否动态轮换标识--%>
                                <input type="hidden" name="isInput" id="isInput" value="${storeEnterprise.isInput}">
                                <input type="text" style="height: 27px;margin-top: 0;margin-left: 10px;" class="TextField laydate-icon pull-left top-time validate[required]" id="month" placeholder="请先择报表月份..." name="reportMonth" value="${reportMonth}" readonly/>
                            </div>
                        </td>
                    </tr>
                    </thead>
                </table>
            </div>
            <div style="height: 100%" id="fill_report">
                <div class="content_right tab-content">
                    <div class="text-left time" style="margin: 10px">
                        <span><i style="font-style: normal;margin-left: 34%" id="message"></i></span>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<%@include file="../../common/AdminFooter.jsp"%>
<script src="${ctx}/js/app/storage/common.js"></script>
<%@include file="proxy_common_script.jsp"%>
<script>
    var toDo = "fill";
    function init() {
        //限制数字输入
        $(".number").keyup(function(){
            onlyNumber(this);
            sum(this);
        }).blur(function(){
            onlyNumber(this);
            sum(this);
        });
        //根据报表状态控制
        $('.save,.submit,.send').attr('disabled',true);

        if(status=='未保存' || status=='草稿' || status.indexOf('驳回')>0){
            $('.save').btnDisabled(false);
            $('#fill_report input').attr('readOnly',false);
            $('#fill_report select').attr('disabled',false);
            $('#leftTable a').show();
            if($('#reportName').val() == '粮油库存实物台账月报表' || $('#reportName').val() == '包装物库存月报表'){
                $('.addRow').show();
                debugger
                var isInput = $('#isInput').val();
                if(isInput == '1'){
                    $('.importRow').show();
                }
            }
        }

        if(status=='草稿' || status.indexOf('驳回')>0){
            $('.send').btnDisabled(false);
        }

       // $('#back').attr("disabled", false);
    }

    //保存草稿
    $(".save").click(function(){
        if(!$('#month').val()){
            layer.alert('请选择报表月份');
            $('#month').blur();
            return;
        }
        if(!$('#manager').val()){
            layer.alert('请输入统计负责人');
            $('#manager').blur();
            return;
        }
        if($('#reportName').val()=='粮油库存实物台账月报表'){
            saveSwtz();
        }else if($('#reportName').val()=='商品粮油收支月报表' || $('#reportName').val()=='储备粮油收支月报表' ||
            $('#reportName').val()=='销往省外' || $('#reportName').val()=='省外购进'){
            saveSply();
        }else if($('#reportName').val()=='库存包装物出入库明细表'){
            saveBzwcrmx();
        }else if($('#reportName').val()=='包装物库存月报表'){
            saveBzw()
        }
    });

    function saveBzw(submit) {
        var jsonlist = new Array();
        var i = 1;
        $("#sumTbody tr").each(function() {
            if(i>=1) {
                var obj = $(this).find('input,select').serializeObject();
                obj.reportWarehouseId = $('#leftTable tr:eq(' + i + ') select').val();
                obj.reportWareHouse = $('#leftTable tr:eq(' + i + ') select').find("option:selected").text();
                jsonlist.push(obj);
            }
            i++;
        });
        if(jsonlist.length>0){
            $('#jsonlist').val(JSON.stringify(jsonlist));

            saveForm("form-active-add",'${ctx}'+saveProxyUrl,function(data){
                /*$("#reportId").val(data.msg);//回填报表ID
                $('.submit,.export').btnDisabled(false);
                $('#status').html('【草稿】');*/
                if(submit){
                    submitForm();
                }else{
                    $("#reportId").val(data.msg);//回填报表ID
                    $('.send,.export').btnDisabled(false);
                    $('#status').html('【草稿】');
                }
            })
        }else{
            layer.alert("请增加记录!");
        }
    }

    function saveBzwcrmx(submit) {
        var jsonlist = new Array();
        var i = 1;
        $("#sumTbody tr").each(function() {
            if(i>=1){
                var obj = $(this).find('input,select,textarea').serializeObject();
                obj.detailDate = $('#leftTable tr:eq('+i+') input').val();
                //obj.extendsWarehouse = $('#leftTable tr:eq('+i+') select').val()
                jsonlist.push(obj);
            }
            i++;
        });
        if(jsonlist.length>0){
            $('#jsonlist').val(JSON.stringify(jsonlist));

            saveForm("form-active-add",'${ctx}'+saveProxyUrl,function(data){
                /*$("#reportId").val(data.msg);//回填报表ID
                $('.send,.export').btnDisabled(false);
                $('#status').html('【草稿】');*/
                if(submit){
                    submitForm();
                }else{
                    $("#reportId").val(data.msg);//回填报表ID
                    $('.send,.export').btnDisabled(false);
                    $('#status').html('【草稿】');
                }
            })
        }else{
            layer.alert("请增加记录!");
        }
    }

    function saveSwtz(submit) {
        var jsonlist = new Array();
        var i = 1;
        let flag = false;
        $("#sumTbody tr").each(function() {
            if(i>1){
                var obj = $(this).find('input,select').serializeObject();
                obj.storehouse = $('#leftTable tr:eq('+i+') [name="storehouse"]').val();
                obj.extendsWarehouseId = $('#leftTable tr:eq('+i+') select[name="extendsWarehouseId"]').val();
                obj.extendsWarehouse = $('#leftTable tr:eq('+i+') select[name="extendsWarehouseId"]').find("option:selected").text();
                // obj.extendsWarehouse = $('#leftTable tr:eq('+i+') select').val()
                obj.variety = $(this).find("select[name='variety']").val();

                let num1 = Number(obj.quantity);
                let num2 = Number(obj.advisedDeposit) + Number(obj.slightlyUnsuitable) + Number(obj.severeUnsuitable)
                let num3 = Number(obj.packing) + Number(obj.bulk)

                if(num1 != num2 || num1 != num3) {
                    flag = true;
                    return false;
                }
                jsonlist.push(obj);
            }
            i++;
        });
        if(flag){
            layer.alert("第" + (i-1) + "行数量有误",{icon:2});
            return;
        }
        if(jsonlist.length>0){
            $('#jsonlist').val(JSON.stringify(jsonlist));

            saveForm("form-active-add","${ctx}/reportSwtz/saveProxySwtz.shtml",function(data){
               /* $("#reportId").val(data.msg);//回填报表ID
                $('.send,.export').btnDisabled(false);
                $('#status').html('【草稿】');*/
                if(submit){
                    submitForm();
                }else{
                    $("#reportId").val(data.msg);//回填报表ID
                    $('.send,.export').btnDisabled(false);
                    $('#status').html('【草稿】');
                }
            })
        }else{
            layer.alert("请增加记录!");
        }
    }

    function saveSply(submit) {
        var jsonlist = new Array();
        $("#sumTbody tr").each(function() {
            var obj = $(this).find('input,select').serializeObject();
            jsonlist.push(obj);
        });
        if(jsonlist.length>0){
            $('#jsonlist').val(JSON.stringify(jsonlist));

            saveForm("form-active-add",'${ctx}'+saveProxyUrl,function(data){
               /* $("#reportId").val(data.msg);//回填报表ID
                $('.send,.export').btnDisabled(false);
                $('#status').html('【草稿】');*/
                if(submit){
                    submitForm();
                }else{
                    $("#reportId").val(data.msg);//回填报表ID
                    $('.send,.export').btnDisabled(false);
                    $('#status').html('【草稿】');
                }
            })
        }
    }

    //提交审核
    $(".submit").click(function(){
        saveForm("form-active-add","${ctx}/reportMonth/submitReport.shtml",function(){
           /* $('.save,.submit').btnDisabled(true);
            $('#status').html('【待审核】');
            $('input').attr('readOnly',true);
            //$('textarea').attr('readOnly',true);
            if($('#reportName').val() == '粮油库存实物台账月报表'){
                $('.addRow').hide();
            }*/
            if(!$('#month').val()){
                layer.alert('请选择报表月份');
                $('#month').blur();
                return;
            }
            if(!$('#manager').val()){
                layer.alert('请输入统计负责人');
                $('#manager').blur();
                return;
            }
            if($('#reportName').val()=='粮油库存实物台账月报表'){
                saveSwtz(true);
            }else if($('#reportName').val()=='包装物库存月报表'){
                saveBzw(true);
            }else if($('#reportName').val()=='商品粮油收支月报表' || $('#reportName').val()=='储备粮油收支月报表' ||
                $('#reportName').val()=='销往省外' || $('#reportName').val()=='省外购进'){
                saveSply(true);
            }else if($('#reportName').val()=='库存包装物出入库明细表'){
                saveBzwcrmx(true);
            } else{
                saveForm("form-active-add",'${ctx}'+saveUrl,function(data){
                    $("#reportId").val(data.msg);//回填报表ID
                    $('.send,.export').btnDisabled(false);
                    $('#status').html('【草稿】');
                });
            }
        })
    });

    //上报公司
    $(".send").click(function(){
        saveForm("form-active-add","${ctx}/reportMonth/sendReport.shtml",function(){
            $('.send,.save').btnDisabled(true);
            $('#status').html('【上报待审】');
        })
    });

    $('#reportType').change(function () {
        if($(this).val()=='台账'){
            $('#reportName option').remove();
            $('#reportName').append("<option>粮油库存实物台账月报表</option><option>包装物库存月报表</option><option>库存包装物出入库明细表</option>");
        }else{
            $('#reportName option').remove();
            $('#reportName').append("<option>储备粮油收支月报表</option><option>商品粮油收支月报表</option><option>销往省外</option><option>省外购进</option>");
        }
        $('#reportName').change();
    });

    $('#reportName').change();

    function back1(url) {
        var status = $("#status").text();
        if(status == "" || status == "【草稿】" || status == "【未保存】" || status == "【汇总驳回】"){
            //alert(11);
            layer.confirm('您是否要放弃编辑', function(index) {
                location.href = url;
                localStorage.setItem('back','back')
            });
        }else{
            location.href = url;
            localStorage.setItem('back','back')
        }
    }

    function submitForm() {
        saveForm("form-active-add","${ctx}/reportMonth/submitReport.shtml",function(){
            $('.save,.send').btnDisabled(true);
            $('.appBack').btnDisabled(false);
            $('#status').html('【OA审核中】');
            $('.table_box table tr').addClass('active');
            $('#fill_report input').attr('readOnly',true);
            $('#fill_report select').attr('disabled',true);
            $('#leftTable a').hide();
            if($('#reportName').val() == '粮油库存实物台账月报表' || $('#reportName').val() == '包装物库存月报表' || $('#reportName').val() == '库存包装物出入库明细表'){
                $('.addRow').hide();
            }
        })
    }

    function saveForm(formId, serviceUrl, fnCallback) {
        layer.load(2);
        if (!$('#' + formId).validationEngine("validate")){
            layer.closeAll('loading');
            return false;
        }
        $.ajax({
            type: "POST",
            url:serviceUrl,
            data:$('#' + formId).serialize(),
            error: function(request) {
                layer.closeAll('loading');
                //layer.alert("保存失败，请与管理员联系！");
                if(request.responseText){
                    if(request.responseText.indexOf("违反唯一约束")>=0){
                        layer.alert("此月已填报，不能重复提交！");
                    }else{
                        layer.open({
                            type: 1,
                            area: ['700px', '430px'],
                            fix: false,
                            content: request.responseText
                        });
                    }
                }
            },
            success: function(data) {
                layer.closeAll('loading');
                if (!data.success) {
                    layer.alert('操作失败!' + data.msg, {icon:2});
                    return;
                } else {
                    layer.msg('操作成功',{time:1000,icon:1},function(){
                        if (typeof (fnCallback) != "undefined")
                            fnCallback(data);
                    });
                }
            }
        });
    }
</script>



