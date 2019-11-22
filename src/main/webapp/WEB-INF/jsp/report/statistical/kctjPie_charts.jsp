<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!-- echarts Js -->
<script src="${ctx}/js/echarts.min.js"></script>
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
        <li>统计分析</li>
        <li class="active">库存汇总统计</li>
    </ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
    <input type="hidden"  id="userId" name="userId" value="${userId}">
    <div id="tab1">
        <div class="demoTable">
            月份:
            <div class="layui-inline" style="width:5%">
                <input class="layui-input" id="month" autocomplete="off">
            </div>
            <div class="layui-inline">
                库点类别:
                <select name="warehouseType" id="warehouseType">
                    <option value="">全部</option>
                    <option value="储备库">直属单位</option>
                    <option value="代储库">代储点</option>
                </select>
            </div>
            库点:
            <div class="layui-inline">
                <input type="hidden" name="reportWarehouseId" id="reportWarehouseId">
                <input class="layui-input" autocomplete="off" readonly id="reportWarehouse"
                       placeholder="请选择报库点..." onclick="addActiveClass(this)"/>
            </div>
            <div class="layui-inline">
                粮油品种:
                <select name="variety" id="variety">
                    <option value="">全部</option>
                    <c:forEach items="${varietyList }" var="item">
                        <option value="${item.value }">${item.value }</option>
                    </c:forEach>
                </select>
            </div>
            收获年份:
            <div class="layui-inline" style="width:5%">
                <select name="harvestYear" id="harvestYear">
                    <option value="">全部</option>
                </select>
            </div>
            <%--产地:
            <div class="layui-inline" style="width:5%">
                <input class="layui-input" id="origin"/>
            </div>--%>
            <div class="layui-inline">
                <label class="layui-form-label" style="width:110px">企业行政区划:</label>
                <div id="distpicker" class="form-inline" style="width:450px">
                    <select class="form-control  pull-left change-filter" style="width: 100px" id="province"
                            name="province"></select>
                    <select class="form-control  pull-left change-filter" style="width: 100px" id="city"
                            name="city"></select>
                    <select class="form-control  pull-left change-filter" style="width: 100px" id="district"
                            name="area"></select>
                </div>
            </div>
            <button class="layui-btn layui-btn-primary layui-btn-small" id="reloadcharts" onclick="reloadcharts();">查询
            </button>
            <button class="layui-btn layui-btn-primary layui-btn-small" id="clear" onclick="clearin();">重置</button>
        </div>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">

        </fieldset>

        <div class="layui-row layui-col-space5">
            <div class="layui-col-md6" style="width: 100%">
                <span style="font-weight:bold;">
					库存总量统计:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<b class="tion">统计方式:</b>
						<select name="grouping" id="grouping" class="tion" onchange="switchingGrouping()">
							<option value="品种" selected="true">按粮油品种</option>
							<option value="年份">按收获年份</option>
							<option value="品质">按品质</option>
						</select>
				</span>
                <div class="grid-demo" id="bb" style="height: 670px; border: 1px solid #ddd;">1/3</div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width:800px;">
            <div class="modal-content">
                <div class="modal-header"><!-- data-dismiss="modal"  -->
                    <button type="button" class="close" aria-hidden="true" onclick="removeActiveClass()">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        选择库点
                    </h4>
                </div>
                <div class="modal-body">
                    <div id="search">
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
                                <label class="layui-form-label">库点名称:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" autocomplete="off" id="warehouseName"
                                           name="warehouseName">
                                </div>
                                <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                                        id="enterpriseSearch">查询
                                </button>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">库点简称:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" autocomplete="off" id="warehouseShort"
                                           name="warehouseShort">
                                </div>
                                <label class="layui-form-label">企业名称:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" autocomplete="off" id="enterpriseName"
                                           name="enterpriseName">
                                </div>
                                <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                                        id="clearcondition">重置
                                </button>
                            </div>
                        </div>
                    </div>
                    <table lay-filter="operation" id="enterpriseTable"></table>
                    <script type="text/html" id="bar">
                        <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="choose">选择</a>
                    </script>
                </div>
                <div class="modal-footer">
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            onclick="removeActiveClass()">关闭
                    </button>
                </div>
            </div>
        </div>

    </div>


    <script>
        $('#distpicker').distpicker({
            autoSelect: false
        });
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({
            elem: '#month' //指定元素
            , type: 'month'
            ,btns: ['now', 'confirm']
        });

        $(document).ready(function (e) {
            reloadcharts('init')
        })

        //年份下拉框
        var myDate= new Date();
        var startYear=myDate.getFullYear()-10;//起始年份
        var endYear=myDate.getFullYear();//结束年份
        var obj=document.getElementById('harvestYear');
        for (var i=startYear;i<=endYear;i++)
        {
            obj.options.add(new Option(i,i));
        }

        //取得总数量
        var sumQuantity = 0;
        //取得粮油品种分类查询总数量
        var sumQuantityByVariety = 0;
        //取得收获年份分类查询总数量
        var sumQuantityByHarvestYear = 0;
        //取得品质分类查询总数量
        var sumQuantityPinzhi = 0;
        var pieCount = [];
        var pieLegend = [];
        function reloadcharts(val) {
            $('#grouping').val('品种');
            $.ajax({
                type: "POST",
                url: "${ctx}/charts/getKCTJPie.shtml",
                data: {
                    month: $("#month").val(),
                    reportWarehouseId: $("#reportWarehouseId").val(),
                    variety: $('#variety').val(),
                    harvestYear: $('#harvestYear').val(),
                    origin: $('#origin').val(),
                    warehouseType: $('#warehouseType').val(),
                    province: $('#province').val(),
                    city: $('#city').val(),
                    district: $('#district').val(),
                    type: val
                },
                dataType: "json",
                success: function (data) {
                    //回显月份
                    if (val == "init") {
                        $("#month").val(data.reportMonth);
                    }
                    //取得粮油品种分类查询总数量
                    sumQuantityByVariety = 0;
                    pieCount = [];
                    pieLegend = [];
                    if (data.sumQuantity != null) {
                        sumQuantity = data.sumQuantity;
                    }else{
                        sumQuantity=0;
                    }
                    sumQuantityByVariety = data.sumQuantityByVariety;
                    sumQuantityByHarvestYear = data.sumQuantityByHarvestYear;
                    sumQuantityPinzhi = data.sumQuantityPinzhi;
                    //-----------------渲染饼图数据--------------
                    if(data.sumQuantityByVariety) {
                        $.each(data.sumQuantityByVariety, function (commentIndex, comment) {
                            var obj = new Object();
                            obj.name = comment.variety;
                            obj.value = comment.quantityTotal;
                            pieCount.push(obj);
                            var obj = new Object();
                            obj.name = comment.variety;
                            pieLegend.push(obj);
                        });
                    }
// -----------------------------------------------饼图数据填充--------------------------------
                    // 指定图表的配置项和数据
                    optionpie = getoptionpie(sumQuantity,pieLegend,pieCount);

                    var myChartpie = echarts.init(document.getElementById('bb'));
                    // 使用刚指定的配置项和数据显示图表。
                    myChartpie.setOption(optionpie);
//------------------------------------------饼图填充完毕-------------------------------
                }
            })
        }

        //为当前点击的行新增activeClass
        function addActiveClass(obj) {
            $('#myModal').modal({backdrop: 'static'}).modal('show');
        }

        //移除activeClass
        function removeActiveClass(obj) {
            $('#myModal').modal('hide');
            $('.activeEnterprise').removeClass('activeEnterprise');
        }

        layui.use(['table'], function () {
            var table = layui.table;
            table.render({
                elem: '#enterpriseTable',
                url: '${ctx}/storageWarehouse/limitPageList.shtml',
                method: "POST",
                cols: [[
                    {fixed: 'left', title: '操作', width: 100, align: 'center', toolbar: '#bar', align: 'center'},
                    {field: 'warehouseName', title: '库点名称', width: 150, align: 'center'},
                    {field: 'warehouseShort', title: '库点简称', width: 150, align: 'center'},
                    {field: 'enterpriseName', title: '企业名称(代储库点用)', width: 200, align: 'center'}
                ]],//设置表头
                request: {
                    pageName: 'page',
                    limitName: 'pageSize'
                },
                page: true,//开启分页
                limit: 10,
                id: 'enterpriseTableId',
                done: function (res, curr, count) {
                },
            });

            //搜索
            $('#enterpriseSearch').click(function () {
                table.reload("enterpriseTableId", {
                    method: 'post', //如果无需自定义HTTP类型，可不加该参数
                    where: {
                        warehouse_type: $('#search #warehouse_type').val(),
                        warehouseName: $('#search #warehouseName').val(),
                        warehouseShort: $('#search #warehouseShort').val(),
                        enterpriseName: $('#search #enterpriseName').val(),
                        userId: $('#userId').val()
                    }
                });
            });

            table.reload("enterpriseTableId", {
                method: 'post', //如果无需自定义HTTP类型，可不加该参数
                where: {
                    warehouse_type: $('#search #warehouse_type').val(),
                    warehouseName: $('#search #warehouseName').val(),
                    warehouseShort: $('#search #warehouseShort').val(),
                    enterpriseName: $('#search #enterpriseName').val(),
                    userId: $('#userId').val()
                }
            });
            //清除查询条件
            $('#clearcondition').click(function () {
                $('#warehouse_type').val("");
                $('#warehouseName').val("");
                $('#warehouseShort').val("");
                $('#enterpriseName').val("");
            });

            table.on('tool(operation)', function (obj) {
                var data = obj.data;
                if (obj.event === 'choose') {
                    $('#reportWarehouse').val(data.warehouseShort);
                    $('#reportWarehouseId').val(data.id);
                }
                $('#myModal').modal('hide');
            });
            //监听FORM结束

        });

        function clearin() {
            /*var laydate = layui.laydate;
            laydate.render({
                elem: '#month' //指定元素
                , type: 'month'
                , value: t2
            });*/
            $('#reportWarehouseId').val("");
            $('#reportWarehouse').val("");
            $('#variety').val("");
            $('#harvestYear').val("");
            $('#origin').val("");
            $('#warehouseType').val("");
            $('#province').val("");
            $('#city').val("");
            $('#district').val("");
            var form = layui.form;
            form.render();
        }
        //切换分组条件触发时间
        function switchingGrouping() {
            var grouping = $("#grouping").val();
            if (grouping == '品种') {
                pieCount=[];
                pieLegend=[];
                $.each(sumQuantityByVariety, function (commentIndex, comment) {
                    var obj = new Object();
                    obj.name = comment.variety;
                    obj.value = comment.quantityTotal;
                    pieCount.push(obj);
                    var obj = new Object();
                    obj.name = comment.variety;
                    pieLegend.push(obj);
                });
            }else if (grouping == '年份') {
                pieCount=[];
                pieLegend=[];
                $.each(sumQuantityByHarvestYear, function (commentIndex, comment) {
                    var obj = new Object();
                    obj.name = comment.harvestYear;
                    obj.value = comment.quantity;
                    pieCount.push(obj);
                    var obj = new Object();
                    obj.name = comment.harvestYear;
                    pieLegend.push(obj);
                });
            } else if (grouping == '品质') {
                pieCount=[];
                pieLegend=[];
                $.each(sumQuantityPinzhi, function (commentIndex, comment) {
                    var obj = new Object();
                    obj.name = comment.reportWarehouse;
                    obj.value = comment.quantityTotal;
                    pieCount.push(obj);
                    var obj = new Object();
                    obj.name = comment.reportWarehouse;
                    pieLegend.push(obj);
                });
            }
// -----------------------------------------------饼图数据填充--------------------------------
            // 指定图表的配置项和数据
            optionpie = getoptionpie(sumQuantity,pieLegend,pieCount);

            var myChartpie = echarts.init(document.getElementById('bb'));
            // 使用刚指定的配置项和数据显示图表。
            myChartpie.setOption(optionpie);
//------------------------------------------饼图填充完毕-------------------------------
        }
        function getoptionpie (sumQuantity,pieLegend,pieCount) {
            var a= new Number(sumQuantity)
            var a = a.toFixed(2).replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
            //alert(a)
            optionpie = {
                title: {
                    text: '储备粮油库存总量:' + a + '吨',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c}吨 ({d}%)"
                },
                toolbox: {
                    show: true,
                    feature: {
                        saveAsImage: {show: true}
                    }
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: pieLegend,
                    itemHeight: 25,
                    itemWidth: 25
                },
                series: [
                    {
                        name: '总数量',
                        type: 'pie',
                        radius: '80%',
                        center: ['50%', '50%'],
                        /*label: {
                            normal:{
                                show : true,
                                formatter: function (p) {
                                    return p.name+":"+formatNum(p.value)+"吨";
                                }
                            }

                        },*/
                        data: pieCount,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            return optionpie;
        }


        function formatNum(strNum) {
            if(strNum.length <= 3) {
                return strNum;
            }
            if(!/^(\+|-)?(\d+)(\.\d+)?$/.test(strNum)) {
                return strNum;
            }
            var a = RegExp.$1,
                b = RegExp.$2,
                c = RegExp.$3;
            var re = new RegExp();
            re.compile("(\\d)(\\d{3})(,|$)");
            while(re.test(b)) {
                b = b.replace(re, "$1,$2$3");
            }
            return a + "" + b + "" + c;
        }
    </script>
<%@ include file="../../common/AdminFooter.jsp" %>