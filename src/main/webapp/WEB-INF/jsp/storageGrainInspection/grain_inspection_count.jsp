<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../common/AdminHeader.jsp"%>

<style>
    #manage_table + .layui-form .layui-table-body td[data-field="reportDateStr"]{
        text-align: center;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="warehouse"]{
        text-align: left;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="encode"]{
        text-align: left;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="status"]{
        text-align: left;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="weather"]{
        text-align: left;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="quantity"]{
        text-align: right;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="storehouseTemp"]{
        text-align: right;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="temperature"]{
        text-align: right;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="storehouseWet"]{
        text-align: right;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="airWet"]{
        text-align: right;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="temperatureAvg"]{
        text-align: right;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="pestLevel"]{
        text-align: left;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="checkProperty"]{
        text-align:left;
    }
    #manage_table + .layui-form .layui-table-body td[data-field="checkCharge"]{
        text-align: left;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
            <li>仓储管理</li>
            <li>粮油情监测管理</li>
            <li>粮情检测记录统计</li>
    </ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
    <div class="layui-form" id="search">
        <div class="layui-form-item" style="height:25px; width:1000px">
            <div class="layui-inline">
                <label class="layui-form-label">填报日期：</label>
                <div class="layui-input-inline" style="width: 100px;">
                    <input type="text" id="startDate" name="startDate" placeholder="" autocomplete="off" class="layui-input date-need">
                </div>
                <div class="layui-form-mid">-</div>
                <div class="layui-input-inline" style="width: 100px;">
                    <input type="text" id="endDate" name="endDate" placeholder="" autocomplete="off" class="layui-input date-need">
                </div>
            </div>
            <div class="layui-inline">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="search_btn" onclick="searchReload()">查询</button>
                <button class="layui-btn layui-btn-primary layui-btn-small" id="excelBtn">导出</button>
            </div>
        </div>
    </div>
    <div class="manage">
        <br>

        <table lay-filter="operation" id="manage_table"></table>
    </div>
</div>

<script>
    var form = layui.form;
    form.render();
    //加载日历插件
    var laydate = layui.laydate;
    $('.date-need').each(function(){
        laydate.render({
            elem: this
        });
    });
    var table = layui.table;
    table.render();
    //执行渲染
    table.render({
        elem : '#manage_table',
        url : '${ctx }/storageGrainInspection/statistics.shtml',
        method : "POST",
        cols : [
            [
            /* {checkbox : true}, */
            {field : 'reportDateStr', title : '填报日期', width : 160, align:'center',templet:"<div>{{Date_format(d.reportDateStr,true)}}</div>"},
            <c:forEach items="${warehouseList}" var="warehouse" >
                {field : '${warehouse.id}', title : '${warehouse.warehouseShort}', width : 160, align : 'center'},
            </c:forEach>
        ]
        ],//设置表头
        request : {
            pageName : 'pageNum',
            limitName : 'pageSize',
        },
        page:true,//开启分页
        limit:10,
        id:'manage_tableId',

    });


    //搜索操作
    function searchReload(){
        let startDate = $('#search input[name="startDate"]').val();
        let endDate = $('#search input[name="endDate"]').val();


        if(startDate!=null && startDate!="" && endDate!=null && endDate!="" && (new Date(startDate)) > (new Date(endDate))){
            layer.msg("起始日期大于结束日起");
            return;
        }

        table.reload('manage_tableId', {
            method:"POST",
            where : {
                startDate : startDate,
                endDate : endDate,
            }
        });
    };

    $("#excelBtn").click(function () {
       let startDate = $('#search input[name="startDate"]').val();
       let endDate = $('#search input[name="endDate"]').val();
       location.href = "${ctx}/storageGrainInspection/excelStatistice.shtml?startDate="+startDate+"&endDate="+endDate;
    });
</script>
