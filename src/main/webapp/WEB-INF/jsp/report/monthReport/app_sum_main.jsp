<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../../common/AdminHeader.jsp"%>
<link rel="stylesheet" href="${ctx}/css/commons.css"/>
<link rel="stylesheet" href="${ctx}/css/report_ku_add.css">

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>报表台账</li>
        <li>报表管理</li>
        <li class="active">汇总审核</li>
    </ol>
</div>
<div class="container-box" style="padding: 0;">
    <div class="page-container">
        <form class="form form-horizontal" id="form-active-add" method="post">
            <input type="hidden" name="reportId" id="reportId" value="${reportId}">
            <div class="clearfix">
                <table width="100%" style="border-collapse:separate; border-spacing:10px 10px;">
                    <thead>
                    <tr>
                        <td>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled sumOA" disabled>OA汇总送审</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled sumPass" disabled>通过</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled sumBack" disabled>驳回</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled export" disabled>导出</button>
                        </td>
                        <td align="right">
                            <input type="hidden" name="reportWarehouse" id="reportWarehouse" value="${reportWarehouse}">
                            <div class="layui-inline">
                                <select name="reportName" class="form-control" id="reportName">
                                    <c:forEach items="${reportNameList}" var="o">
                                        <option>${o}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="layui-inline">
                                <input type="text" style="height: 27px;margin-top: 0;margin-left: 10px;" class="TextField laydate-icon pull-left top-time validate[required]" id="month" placeholder="请选择报表月份..." name="reportMonth" readonly/>
                            </div>
                        </td>
                    </tr>
                    </thead>
                </table>
            </div>
            <div style="height: 100%" id="fill_report">
                <div class="content_right tab-content">
                    <div class="text-left time" style="margin: 10px">
                        <span><i style="font-style: normal;margin-left: 34%"></i></span>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<%@include file="../../common/AdminFooter.jsp"%>
<%@include file="common_script.jsp"%>

<script>
    var toDo = 'appSum';
    function init() {
        //根据报表状态控制
        if(status=='汇总待审'){
            if(reportName=='粮油库存实物台账月报表' || reportName=='包装物库存月报表'|| reportName=='库存包装物出入库明细表')
                $('.sumPass,.sumBack,.export').btnDisabled(false);
            else
                $('.sumOA,.sumBack,.export').btnDisabled(false);
        }
        if(status=='OA汇总送审'){
            $('.sumBack,.export').btnDisabled(false);
        }
        $('#sumMonth').html('汇总月份：<span>'+$('#month').val()+'</span>');
    }


    var now = new Date();
    now.setMonth(now.getMonth() - 1);
    var initVal;

    if(now.getDate()>=10){
        initVal = now.getFullYear().toString() + '-' + (now.getMonth() + 1).toString();
    }else{
//        now.setMonth(now.getMonth() - 1);
        initVal = now.getFullYear().toString() + '-' + (now.getMonth() + 1).toString();
    }

    if(initVal.split('-')[1].length < 2){
        var a = initVal.split('-')
        //initVal = initVal.replace(initVal.split('-')[1], '0' + initVal.split('-')[1]);
        var f = a[1];
        a.splice(1, 1, f < 10 ? '0' + f : f);
        initVal = a[0] + '-' + a[1];
    }
    layui.laydate.render({
        elem: $("#month")[0],
        type: 'month',
        value: initVal
    });


    //汇总通过
    $(".sumPass").click(function(){
        layer.confirm('确定通过吗?', function() {
            saveForm("form-active-add","${ctx}/reportMonth/appSumPass.shtml",function(data){
                $('.sumPass,.sumBack').btnDisabled(true);
                $('#status').html('【汇总通过】');
            })
        });
    });

    //汇总通过
    $(".sumOA").click(function(){
        layer.confirm('确定OA汇总送审吗?', function() {
            saveForm("form-active-add","${ctx}/reportMonth/sumOA.shtml",function(data){
                $('.sumOA').btnDisabled(true);
                $('.sumBack').btnDisabled(false);
                $('#status').html('【OA汇总送审】');
            })
        });
    });

    //汇总驳回
    $(".sumBack").click(function(){
        layer.confirm('确定驳回吗?', function() {
            saveForm("form-active-add","${ctx}/reportMonth/appSumBack.shtml",function(){
                $('.sumOA,.sumPass,.sumBack').btnDisabled(true);
                $('#status').html('【汇总驳回】');
            })
        });
    });

    $('#reportName').change();

</script>



