<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../../common/AdminHeader.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${ctx}/css/commons.css"/>
<link rel="stylesheet" href="${ctx}/css/report_ku_add.css">
<style>
    .display_none_cs{
        display: none;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>报表台账</li>
        <li>报表管理</li>
        <li class="active">分库审核</li>
    </ol>
</div>
<div class="container-box" style="padding: 0;">
    <div class="page-container">
        <form class="form form-horizontal" id="form-active-add" method="post">
            <input type="hidden" id="judge" value="${judge}">
            <input type="hidden" name="reportId" id="reportId" value="${reportId}">
            <input type="hidden" name="sumManager" id="sumManager">
            <input type="hidden" name="remark" id="remark">
            <div class="clearfix">
                <table width="100%" style="border-collapse:separate; border-spacing:10px 10px;">
                    <thead>
                    <tr>
                        <td>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled sendPass" disabled>通过</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled sendBack" disabled>驳回</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled summary" disabled>汇总</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-disabled export" disabled>导出</button>
                            <div id="back" class="layui-btn d_isplay_n_o_n_e_cs_ layui-btn-small display_none_cs" name="cancelBtn" onclick="back1('${ctx}/reportMonth/appKuMain.shtml')">返回</div>
                        </td>
                        <td align="right">

                            <div class="layui-inline">
                                <input type="hidden" name="reportWarehouseId" id="reportWarehouseId">
                                <input class="layui-input" autocomplete="off" name="reportWarehouse" readonly id="reportWarehouse"
                                       placeholder="请选择报库点..." onclick="addActiveClass0(this)"/>
                            </div>
                            <div class="layui-inline">
                                <select name="reportName" class="form-control" id="reportName">
                                    <c:forEach items="${reportNameList}" var="reportName">
                                        <option>${reportName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="layui-inline">
                                <input type="text" style="height: 27px;margin-top: 0;margin-left: 10px;" class="TextField laydate-icon pull-left top-time validate[required]" id="month" placeholder="请选择报表月份..." name="reportMonth" readonly/>
                            </div>
                        </td>
                    </tr>
                    <tr id="huizongbohui" style="display: none"><td colspan="4" align="left"><span color="red" size="2">当月数据已汇总，重新汇总请到汇总审核驳回操作</span></td></tr>
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

<div class="modal fade" id="myModal0" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog"  style="width:800px;">
        <div class="modal-content">
            <div class="modal-header"><!-- data-dismiss="modal"  -->
                <button type="button" class="close" aria-hidden="true" onclick="removeActiveClass0()">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
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
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="removeActiveClass0()">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->

</div>

<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
    <div class="modal-dialog"  style="width:800px;">
        <div class="modal-content">
            <div class="modal-body" >
                <div class="layui-form-item">
                    <div class="" id="confirmContent">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">统计负责人：</label>
                    <div class="layui-input-block">
                        <input class="layui-input" autocomplete="off" id="fuzeren">
                    </div>
                </div>
                <div class="layui-form-item layui-form-text" id="div-remark" style="display: none;">
                    <label class="layui-form-label">备注:</label>
                    <div class="layui-input-block">
                        <textarea  class="layui-textarea" id="beizhu" ></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="confirmCommit()">确定</button>
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="removeActiveClass1()">取消
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->

</div>


<%@include file="../../common/AdminFooter.jsp"%>

<%@include file="common_script.jsp"%>
<script>
    var this_app_ku_mian_j = 'this_app_ku_mian_j';
    $('#qingkong').click(function () {
        $('select[name="warehouse_type"]').next().find('input[type="text"]').val('');
        $("#warehouseName").val("");
        $("#warehouseShort").val("");
        $("#enterpriseName").val("");
    });

    var toDo = "appKu";
    function back1(urls){ //点击返回按钮
        if(sessionStorage.getItem('app_ku_mian_back_')!=null)
            sessionStorage.setItem('app_ku_mian_back_','back')
        location.href = urls;
        $('.d_isplay_n_o_n_e_cs_').addClass('display_none_cs')
    }
    $("#fill_report").load("${ctx}/reportMonth/fillTableQuery.shtml");
    
    function init() {
        //根据报表状态控制

        if(status=='上报待审' || status=='汇总驳回'){
            $('.sendPass,.sendBack,.summary,.export').btnDisabled(false);

        }
        if(status=='上报通过'){
            $('.summary,.sendBack,.export').btnDisabled(false);

        }
            if (monthStatus == '汇总待审' || monthStatus == '汇总通过') {
                $('.summary').btnDisabled(true);
//                $('#status').html('【已汇总】');
                $('#huizongbohui').show();
            }
            if (monthStatus == '汇总待审') {
                $('.summary').btnDisabled(true);
//                $('#status').html('【已汇总】');
                $('#huizongbohui').show();
            }

    }

    //审核通过
    $(".sendPass").click(function(){
        layer.confirm('确定审核通过吗?', function() {
            saveForm("form-active-add","${ctx}/reportMonth/sendPass.shtml",function(data){
                $('.sendPass,.sendBack').btnDisabled(true)
                $('#status').html('【上报通过】');
            })
        });

    });

    //上报驳回
    $(".sendBack").click(function(){
        layer.confirm('确定驳回吗?', function() {
            saveForm("form-active-add","${ctx}/reportMonth/sendBack.shtml",function(){
                $('.sendPass,.sendBack,.summary').btnDisabled(true);
                $('#status').html('【上报驳回】');
            })
        });
    });

    //汇总
    $(".summary").click(function(){
        layer.load(2);
        $.ajax({
            type : 'POST',
            url : '${ctx}/reportMonth/checkSummary.shtml',
            data : $('#form-active-add').serialize(),
            success : function(result) {
                if (result.msg) {
                    var str = result.msg.split("；");
                    if(!str[2]){ //str[2]上报通过的库
                        layer.alert("所有库均未上报通过，请先审核");
                    }else{
                        addActiveClass1('<span style="color:blue">'+str[2]+'</span>' +
                            '</br><span style="color:red">'+str[1]+'</span></br>');
                    }
                }else{
                    addActiveClass1('');
                }
            },
            error : function() {
                layer.closeAll();
                layerMsgError("error:服务出错");
            },
            complete:function(){
                layer.closeAll('loading');
            }
        });
    });

    //为当前点击的行新增activeClass
    function addActiveClass0(obj) {
        // debugger;
        $('#myModal0').modal({backdrop: 'static'}).modal('show');
    }

    //移除activeClass
    function removeActiveClass0() {
        // debugger;
        $('#myModal0').modal('hide');
        $('.activeEnterprise').removeClass('activeEnterprise');
    }

    //为当前点击的行新增activeClass
    function addActiveClass1(msg) {
        $('#confirmContent').html(msg);
        if(reportName=='包装物库存月报表'){
            $('#div-remark').show();
        }
        $('#myModal1').modal({backdrop: 'static'}).modal('show');
    }

    //移除activeClass
    function removeActiveClass1(obj) {

        $('#myModal1').modal('hide');
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
                {field : 'enterpriseName',title : '所属企业名称(代储库点用)',width:150},
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
                    enterpriseName : $('#search #enterpriseName').val(),
                }
            });
        });

        table.on('tool(operation1)', function(obj) {
            var data = obj.data;
            if (obj.event === 'choose') {
                var warehouseShort = data.warehouseShort;

                $('#reportWarehouse').val(warehouseShort);
                $('#reportWarehouseId').val(data.id);

                $('#reportWarehouse').change();
            }
            $('#myModal0').modal('hide');
        });
        //监听FORM结束

    });

    function confirmCommit() {
        var fuzeren = $('#fuzeren').val();
        if(!fuzeren){
            layer.alert('请输入统计负责人');
            return;
        }
        $('#sumManager').val(fuzeren);
        $('#remark').val($('#beizhu').val());
        saveForm("form-active-add","${ctx}/reportMonth/summary.shtml",function(){
            $('.summary').btnDisabled(true);
            $('#status').html('【汇总待审】');
        })
        $('#myModal1').modal('hide');
    }
</script>



