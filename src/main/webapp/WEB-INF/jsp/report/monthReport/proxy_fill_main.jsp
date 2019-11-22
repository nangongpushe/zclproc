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
            <input type="hidden" name="reportName" id="reportName" value="${reportName}">
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
                        </td>
                        <td align="right">
                            <div class="layui-inline">
                                <input type="hidden" name="reportWarehouse" id="reportWarehouse" value="${reportWarehouse}">
                                <input type="text" style="height: 27px;margin-top: 0;margin-left: 10px;" class="TextField laydate-icon pull-left top-time validate[required]" id="month" placeholder="请先择报表月份..." name="reportMonth" readonly/>
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

<%@include file="common_script.jsp"%>
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
            if($('#reportName').val() == '粮油库存实物台账月报表'){
                $('.addRow').show();
            }
        }

        if(status=='草稿' || status.indexOf('驳回')>0){
            $('.send').btnDisabled(false);
        }

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
        }
    });

    function saveSwtz() {
        var jsonlist = new Array();
        var i = 1;
        $("#sumTbody tr").each(function() {
            if(i>1){
                var obj = $(this).find('input,select').serializeObject();
                obj.storehouse = $('#leftTable tr:eq('+i+') input').val();
                obj.extendsWarehouseId = $('#leftTable tr:eq('+i+') select').val();
                obj.extendsWarehouse = $('#leftTable tr:eq('+i+') select').find("option:selected").text();
                obj.variety = $(this).find("select[name='variety']").val();
                jsonlist.push(obj);
            }
            i++;
        });
        if(jsonlist.length>0){
            $('#jsonlist').val(JSON.stringify(jsonlist));

            saveForm("form-active-add",'${ctx}'+saveUrl,function(data){
                $("#reportId").val(data.msg);//回填报表ID
                $('.send,.export').btnDisabled(false);
                $('#status').html('【草稿】');
            })
        }else{
            layer.alert("请增加记录!");
        }
    }

    function saveSply() {
        var jsonlist = new Array();
        $("#sumTbody tr").each(function() {
            var obj = $(this).find('input,select').serializeObject();
            jsonlist.push(obj);
        });
        if(jsonlist.length>0){
            $('#jsonlist').val(JSON.stringify(jsonlist));

            saveForm("form-active-add",'${ctx}'+saveUrl,function(data){
                $("#reportId").val(data.msg);//回填报表ID
                $('.send,.export').btnDisabled(false);
                $('#status').html('【草稿】');
            })
        }
    }

    //提交审核
    $(".submit").click(function(){
        saveForm("form-active-add","${ctx}/reportMonth/submitReport.shtml",function(){
            $('.save,.submit').btnDisabled(true);
            $('#status').html('【待审核】');
            $('input').attr('readOnly',true);
            if($('#reportName').val() == '粮油库存实物台账月报表'){
                $('.addRow').hide();
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
</script>



