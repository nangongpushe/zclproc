<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../../common/AdminHeader.jsp"%>
<link rel="stylesheet" href="${ctx}/css/commons.css"/>
<link rel="stylesheet" href="${ctx}/css/report_ku_add.css">

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>报表台账</li>
        <li>报表管理</li>
        <li class="active">查询</li>
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
                                <button type="button" class="layui-btn layui-btn-small layui-btn-disabled export" disabled>导出</button>
                                <button type="button" class="layui-btn layui-btn-small search" data-toggle="modal" data-target=".bs-example-modal-lg" style="display: none" id="swtzSearch">高级查询</button>
                            </td>
                            <td align="right">
                                <input type="hidden" name="reportWarehouse" id="reportWarehouse" value="${reportWarehouse}">
                                <div class="layui-inline">
                                    <select name="reportName" class="form-control" id="reportName">
                                        <c:forEach items="${reportNameList }" var="o">
                                            <option>${o }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="layui-inline">
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
                            <label class="layui-form-label">月份</label>
                            <div class="layui-input-inline">
                                <input type="text" name="reportMonth" id="reportMonth" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                        	<c:if test="${companyUser }">
							<label class="layui-form-label">区域</label>
							<div class="layui-input-inline">
                                <div id="distpicker" class="form-inline" style="width:300px">
									<select lay-ignore class="form-control  pull-left change-filter" style="width: 100px" id="province" name="province"></select>
									<select lay-ignore class="form-control  pull-left change-filter" style="width: 100px" id="city" name="city"></select>
									<select lay-ignore class="form-control  pull-left change-filter" style="width: 100px" id="district" name="area"></select>
							    </div>
                            </div>
                            </c:if>
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
                                <select name="variety" id="variety">
                                    <option value="">全部</option>
                                <c:forEach items="${variety}" var="item">
                                    <option value="${item.value}">${item.value}</option>
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

<%@include file="../../common/AdminFooter.jsp"%>

<%@include file="common_script.jsp"%>
<script src="${ctx }/js/cities.data.js"></script>
<script>
	$('#distpicker').distpicker({
		autoSelect: false
	});

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
	
    var toDo = "query";
    function init() {
//        //根据报表状态控制
        if('审核通过,上报待审,上报通过,汇总待审,汇总通过'.indexOf(status)>=0){
            $('.export').attr('disabled',false);
        }
    }

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
        if(!$('#reportMonth').val()){
            layer.alert('请选择月份');
            return;
        }

        if($('#minHarvestYear').val()>$('#maxHarvestYear').val()){
            layer.alert('收获开始年份不能大于收获结束年份！');
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
        $('#fill_report').load("${ctx}/reportSwtz/querySwtzSearch.shtml",
        	$('#searchForm').serializeArray(),
            function (responseText,textStatus) {
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
</script>



