<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style type="text/css">
    #outSide {
        width:94%;
        margin-left:2%;
        padding:1%;
        background:#fff;
        border-top:2px solid #23b7e5;
    }

    .infoArea {
        width: 100%;
        padding: 20px 0;
        border-bottom: 2px solid #e2e2e2;
    }

    .title{
        color: #23b7e5;
        font-weight: bold;
    }

    #infoArea {
        margin-top: 20px;
    }

    .selectArea {
        width: 15%;
        padding: 5px;
        outline: none;
        border: 1px solid #ccc;
        resize: none;
    }

    .inputArea {
        width: 50%;
        padding: 5px;
        outline: none;
        border: 1px solid #ccc;
        resize: none;
    }

    .buttonArea {
        color: #fff;
        background-color: #009688;
        border: 1px solid #d2d2d2;
        padding:5px 30px;
        cursor: pointer;
        display:inline-block;
    }

    #listArea {
        padding: 20px 0;
        width: 100%;
        clear: both;
    }

    #listArea table {
        margin-top: 20px;
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }

    #listArea thead {
        background: #eee;
    }

    #listArea table tr td {
        font-size:0.9em;
        padding: 10px 0;
    }

    #listArea tbody tr {
        border-bottom: 1px solid #ccc;
    }

    #jockerLay{
        background:#f2f2f2;
        border: 1px solid #e2e2e2;
        border-top:none;
        font-size:0.9em;
    }

    #pagination {
        text-align: left;
        float: inherit !important;
        display:inline-block;
    }

    .layui-laypage {
        display: inline-block;
        vertical-align: middle;
        font-size: 0px;
        margin:0;
        margin:5px 0;
    }

    .layui-table {
        width: 100%;
        margin:0;
        background-color: #fff;
    }

    .layui-laypage a, .layui-laypage span {
        display: inline-block;
        vertical-align: middle;
        padding: 0 12px;
        height: 28px;
        line-height: 28px;
        background-color: #f2f2f2;
        color: #333;
        margin:0;
        font-size: 12px;
        border:none;
    }

    #pageSelecter{
        display:inline-block;
        width:152px;
        height:28px;
    }

    .pageSelecter-disable{
        color:#999;
    }

    .pageSelecter-disable input,select{
        background:RGB(255,255,255)
    }

    #pageNumber{
        height:24px;
        width:40px;
        border-radius:2px;
        border:1px #ccc solid;
    }

    #page-in{
        width:46px;
        height:26px;
        text-align:center;
        display:inline-block;
        cursor:pointer;
        border-radius:2px;
        border:1px #ccc solid;
        line-height:1.7;
        background:#fff;
        padding:1px
    }

    #template{
        display:none
    }

    a {
        text-decoration: none;
    }
    .PageButton-UnSelect{
        padding: 5px 15px;
        background:#fff;
        border:1px solid #009688;
        color:#009688;
        cursor: pointer;
        display: inline;
    }

    .PageButton-Select{
        padding: 5px 15px;
        background: #009688;
        border: none;
        color: #fff;
        cursor: pointer;
        display: inline;
    }
    #select-parm{
        width:80%;
        display:inline-block;
    }

    #select-parm>table{
        width:100%;
    }

    #select-parm table td{
        font-size:14px;
        width:25%;
        padding-bottom:5px;
        text-align: center;
    }

    #select-parm table td>div{
        width:40%;
        display:inline-block;
        text-align:left;
    }

    #total-search{
        width:100%;
        display:none;
    }

    #search-button-area{
        display:inline;
        position: absolute;
    }

    #search-button-area div{
        margin-right:5px;
    }

</style>

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>通知书管理</li>
        <li class="active">提货单汇总</li>
    </ol>
</div>

<div id="outSide">
    <div class="layui-form" id="search" lay-filter="search">
        <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">分发时间:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input class="layui-input" name="beginDistributionDate" autocomplete="off">
                    </div>
                    <div class="layui-form-mid">-</div>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input class="layui-input" name="endDistributionDate" autocomplete="off">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">库点名称:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input class="layui-input" name="wareHouseShort" autocomplete="off">
                    </div>
                </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btn-primary layui-btn-small" id="findData">查询</button>
            </div>
            <div class="layui-inline">
                <input type="button" class="layui-btn layui-btn-primary layui-btn-small" id="clearAll" value="清空"/>
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btn-primary layui-btn-small" onclick="exportExcel()">导出</button>
            </div>
        </div>

    </div>

    <div id="listArea">
        <table style="display:none">
            <tr id="template">
                <td name="wareHouseShort" align="center"></td>
                <td name="variety" align="center"></td>
                <td name="wareHouseYear" align="center"></td>
                <td name="shipment" align="center"></td>
            </tr>
        </table>

        <table class="layui-table sort-table">
            <thead>
                <tr>
                    <td>库点名称</td>
                    <td>粮食品种</td>
                    <td>年份</td>
                    <td>数量</td>
                </tr>
            </thead>
            <tbody id="data-list">
             <c:forEach items="${takeTotalList}" var="take">
                <tr>
                    <td align="center">${take.wareHouseShort}</td>
                    <td align="center">${take.variety}</td>
                    <td align="center">${take.wareHouseYear}</td>
                    <td align="center">${take.shipment}</td>
                </tr>
             </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>

    layui.use('form', function(){
        var form = layui.form;
        form.render();
    });

    layui.laydate.render({
        elem : $('[name="beginDistributionDate"]')[0],
        type : "date",
        format : "yyyy-MM-dd"
    });
    layui.laydate.render({
        elem : $('[name="endDistributionDate"]')[0],
        type : "date",
        format : "yyyy-MM-dd"
    });

    $("#clearAll").click(function () {
        $("input[name='beginDistributionDate']").val("");
        $("input[name='endDistributionDate']").val("");
        $("input[name='wareHouseShort']").val("");

        layui.form.render();
    });

    $("#findData").click(function () {
        var beginDistributionDate = $('input[name="beginDistributionDate"]').val();
        var endDistributionDate = $('input[name="endDistributionDate"]').val();

        var oDate1 = new Date(beginDistributionDate);
        var oDate2 = new Date(endDistributionDate);
        if(oDate1>oDate2){
            layerMsgError("分发时间有误");
            return;
        }
        FormSubmit(true);
    });

    function FormSubmit(NeedDrawPage){
        $.ajax({
            url:"${ctx}/RotateNotif/TakeTotal/Index.shtml",
            type:"post",
            contentType:"application/json",
            data: JSON.stringify({
                "beginDistributionDate": $("#search input[name='beginDistributionDate']").val(),
                "endDistributionDate": $("#search input[name='endDistributionDate']").val(),
                "wareHouseShort": $("#search input[name='wareHouseShort']").val(),
            }),
            success:function(data){
                $("#data-list").empty();
                if(data.length > 0){
                    for(var i = 0;i < data.length; i++){
                        var template = $("#template").clone(true);
                        template.find("td[name='wareHouseShort']").html(data[i].wareHouseShort)
                        template.find("td[name='variety']").html(data[i].variety);
                        template.find("td[name='wareHouseYear']").html(data[i].wareHouseYear);
                        template.find("td[name='shipment']").html(data[i].shipment);
                        $("#data-list").append($(template));
                        $(template).show();
                        $(".sort-table").trigger("update");
                    }
                }else{
                    $("#data-list").empty();
                    $("#data-list").append("<tr><td colspan='9'>搜索目标无结果</td></tr>");
                }
            }
        })
    }
    function exportExcel(){
        window.location.href = "${ctx}/RotateNotif/exportExcel.shtml?beginDistributionDate="+$("#search input[name='beginDistributionDate']").val()+
            "&endDistributionDate=" +$("#search input[name='endDistributionDate']").val()+
            "&wareHouseShort=" +$("#search input[name='wareHouseShort']").val();
    }
</script>
<%@ include file="../common/AdminFooter.jsp" %>
