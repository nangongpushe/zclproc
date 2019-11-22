<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../../common/AdminHeader.jsp"%>
<link rel="stylesheet" href="${ctx}/css/commons.css"/>
<link rel="stylesheet" href="${ctx}/css/report_ku_add.css">
<style>
    #enterpriseTable + .layui-form .layui-table-body td[data-field="warehouseName"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="warehouseShort"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="enterpriseName"]{
        text-align: left;
    }
</style>

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>报表台账</li>
        <li>报表管理</li>
        <li class="active">分库查询</li>
    </ol>
</div>
<div class="container-box" style="padding: 0;">
    <div class="page-container">
        <form class="form form-horizontal" id="form-active-add" method="post">
            <input type="hidden" id="judge" value="${judge}">
            <input type="hidden" name="reportId" id="reportId" value="${reportId}">
            <div class="clearfix">
                <table width="100%" style="border-collapse:separate; border-spacing:10px 10px;">
                    <thead>
                    <tr>
                        <td>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled export" disabled>导出</button>
                            <button type="button" class="layui-btn layui-btn-small search" data-toggle="modal" data-target=".bs-example-modal-lg" style="display: none" id="swtzSearch">高级查询</button>
                        </td>
                        <td align="right">
                            <div class="layui-inline">
                                <input type="hidden" name="reportWarehouseId" id="reportWarehouseId">
                                <input class="layui-input" autocomplete="off" name="reportWarehouse" readonly id="reportWarehouse"
                                       placeholder="请选择报库点..." onclick="addActiveClass(this)"/>
                            </div>
                            <div class="layui-inline">
                                <select name="reportName" class="form-control" id="reportName">
                                    <c:forEach items="${reportNameList }" var="o">
                                        <option>${o }</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="layui-inline">
                                <input type="text" style="margin-left: 10px;" class="TextField laydate-icon pull-left top-time validate[required]" id="month" placeholder="请选择报表月份..." name="reportMonth" readonly/>
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

<%--高级查询框--%>
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="layui-form" method="post" id="searchForm">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">高级查询</h4>
                </div>
                <div class="modal-body">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <input type="hidden" name="reportWarehouse" id="reportWarehouseId2">
                            <input type="hidden" name="reportId" id="reportId2">


                            <label class="layui-form-label">月份</label>
                            <div class="layui-input-inline">
                                <input type="text" name="reportMonth" id="reportMonth" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">仓号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="storehouse" id="storehouse" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">收获年份</label>
                            <div class="layui-input-inline" style="width: 100px;">
                                <input type="text" name="minHarvestYear" id="minHarvestYear" autocomplete="off" class="layui-input">
                            </div>
                            <div class="layui-form-mid">至</div>
                            <div class="layui-input-inline" style="width: 100px;">
                                <input type="text" name="maxHarvestYear" id="maxHarvestYear" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">品种</label>
                            <div class="layui-input-inline">
                                <%--<input type="text" name="variety" id="variety" autocomplete="off" class="layui-input">--%>
                                <select class="layui-input" name="variety" >
                                    <option value="">全部</option>
                                    <c:forEach items="${dictType}" var="dict">
                                        <option value="${dict.value}">${dict.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">数量范围</label>
                            <div class="layui-input-inline" style="width: 100px;">
                                <input type="text" name="minQuantity" id="minQuantity" autocomplete="off" class="layui-input number">
                            </div>
                            <div class="layui-form-mid">至</div>
                            <div class="layui-input-inline" style="width: 100px;">
                                <input type="text" name="maxQuantity" id="maxQuantity" autocomplete="off" class="layui-input number">
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button class="layui-btn layui-btn-primary layui-btn-small" type="button" onclick="search();">确认</button>
                    <button class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
    <div class="modal-dialog"  style="width:800px;">
        <div class="modal-content">
            <div class="modal-header"><!-- data-dismiss="modal"  -->
                <button type="button" class="close" aria-hidden="true" onclick="removeActiveClass()">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel1">
                    选择库点
                </h4>
            </div>
            <div class="modal-body">
                <div class="layui-form" id="search">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">库点类型:</label>
                            <div class="layui-input-inline">
                                <select class="layui-input" name="warehouse_type" id="warehouse_type">
                                    <option value="">全部</option>
                                    <option value="储备库">直属单位</option>
                                    <option value="代储库">代储库</option>
                                </select>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">库点名称：</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" autocomplete="off" id="warehouseName" name="warehouseName">
                                </div>
                            </div>
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="enterpriseSearch">查询</button>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">库点简称：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="warehouseShort" name="warehouseShort">
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">企业名称：</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" autocomplete="off" id="enterpriseName" name="enterpriseName">
                                </div>
                            </div>
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="qingkong">清空</button>
                        </div>
                    </div>
                </div>
                <table lay-filter="operation1" id="enterpriseTable"></table>
                <script type="text/html" id="bar">
                    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="choose">选择</a>
                </script>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="removeActiveClass()">关闭
                </button>
                <!-- <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="selectBtn" onclick="selectEnterprise()">
                    选择
                </button> -->
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->

</div>

<%@include file="../../common/AdminFooter.jsp"%>

<%@include file="common_script.jsp"%>
<script>
    $('#qingkong').click(function () {
        $('select[name="warehouse_type"]').next().find('input[type="text"]').val('');
        $("#warehouseName").val("");
        $("#warehouseShort").val("");
        $("#enterpriseName").val("");
    });
    var toDo = "queryKu";

    $("#fill_report").load("${ctx}/reportMonth/fillTableQuery.shtml")

    function init() {
        //根据报表状态控制
        if('审核通过,上报待审,上报通过,汇总待审,汇总通过'.indexOf(status)>=0){
            $('.export').attr('disabled',false);
        }
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


    $('#myModal').on('show.bs.modal', function (event) {
        $('#reportMonth').val($('#month').val());
    })

    layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#reportMonth'
            ,type:'month'
            ,format: 'yyyy-MM'
            ,done: function(value, date, endDate){
                $('#month').val(value);
            }
        });
        laydate.render({
            elem: '#minHarvestYear'
            ,type:'year'
            ,format: 'yyyy'
        });
        laydate.render({
            elem: '#maxHarvestYear'
            ,type:'year'
            ,format: 'yyyy'
        });
    });

    function search() {
        $("#reportId2").val($("#reportId").val());
        if(!$('#reportMonth').val()){
            layer.alert('请选择月份');
            return;
        }

        if($('#minQuantity').val().length!=0){
            if(!(/^\d+(\.\d+)?$/.test($('#minQuantity').val()))){
                layer.alert('数量范围输入大于0的数字！');
                return;
            }
        }  if($('#maxQuantity').val().length!=0){
            if(!(/^\d+(\.\d+)?$/.test($('#maxQuantity').val()))){
                layer.alert('数量范围输入大于0的数字！');
                return;
            }
        }
        $('#myModal').modal('hide');
        layer.load(2);
        $('#fill_report').load("${ctx}/reportSwtz/querySwtzSearch.shtml",$('#searchForm').serializeArray()
            ,function (responseText,textStatus) {
                $('.clearfix button:not(".search")').btnDisabled(true);
                $('#fill_report input').attr('readOnly',true);
                $('#fill_report select').attr('disabled',true);
                $('#leftTable a').hide();
                if(textStatus == 'success'){
                    if(dataList){
                        init();
                        $('.export').btnDisabled(false);
                    }else{
                        $('#fill_report').html('<div style="padding-left: 20px">没有数据</div>');
                    }
                }else{
                    $('#fill_report').html(responseText);
                }
                scroll();
                layer.closeAll();
            }
        );
    }

    $(".number").keyup(function(){
        onlyNumber(this);
//            sum(this);
    }).blur(function(){
        onlyNumber(this);
//            sum(this);
    });


    //为当前点击的行新增activeClass
    function addActiveClass(obj) {
        $('#myModal1').modal({backdrop: 'static'}).modal('show');
    }

    //移除activeClass
    function removeActiveClass(obj) {
        $('#myModal1').modal('hide');
        $('.activeEnterprise').removeClass('activeEnterprise');
    }

    layui.use(['table'], function() {
        var table = layui.table;
        table.render({
            elem : '#enterpriseTable',
            url : '${ctx}/storageWarehouse/limitPageList.shtml',
            method : "POST",
            cols : [[
                {fixed : 'left', title : '操作', width : 100, align : 'center', toolbar : '#bar'},
                {field : 'warehouseName',title : '库点名称',width:150},
                {field : 'warehouseShort',title : '库点简称',width:150},
                {field : 'enterpriseName',title : '所属企业名称(代储库点用)',width:200}
            ]],//设置表头
            request : {
                pageName : 'page',
                limitName : 'pageSize'
            },
            page:true,//开启分页
            limit:10,
            id:'enterpriseTableId1',
            done:function(res,curr,count){
            },
        });

        //搜索
        $('#enterpriseSearch').click(function() {
            table.reload("enterpriseTableId1", {
                method: 'post', //如果无需自定义HTTP类型，可不加该参数
                where : {
                    warehouse_type: $('#search #warehouse_type').val(),
                    warehouseName : $('#search #warehouseName').val(),
                    warehouseShort : $('#search #warehouseShort').val(),
                    enterpriseName : $('#search #enterpriseName').val()
                }
            });
        });

        table.on('tool(operation1)', function(obj) {
            var data = obj.data;
            if (obj.event === 'choose') {
                var warehouseShort = data.warehouseShort;
                $('#reportWarehouse').val(warehouseShort);
                $('#reportWarehouse1').val(warehouseShort);
                $('#reportWarehouseId').val(data.id);
                $('#reportWarehouseId2').val(data.id);
                $('#reportWarehouse').change();
            }
            $('#myModal1').modal('hide');
        });
        //监听FORM结束

    });
</script>



