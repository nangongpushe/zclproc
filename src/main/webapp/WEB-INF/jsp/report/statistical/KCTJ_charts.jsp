<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!-- echarts Js -->
<script src="${ctx}/js/echarts.min.js"></script>
<style>
    #enterpriseTable + .layui-form .layui-table-body td[data-field="warehouseName"] {
        text-align: left;
    }

    #enterpriseTable + .layui-form .layui-table-body td[data-field="warehouseShort"] {
        text-align: left;
    }

    #enterpriseTable + .layui-form .layui-table-body td[data-field="enterpriseName"] {
        text-align: left;
    }

</style>

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>报表台账</li>
        <li>统计分析</li>
        <li class="active">库存分库统计</li>
    </ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
    <input type="hidden" id="userId" name="userId" value="${userId}">
    <div id="tab1">
        <div class="demoTable">
            月份:
            <div class="layui-inline" style="width:5%">
                <input class="layui-input" id="month" autocomplete="off">
            </div>
            库点:
            <div class="layui-inline">
                <input type="hidden" name="reportWarehouseId" id="reportWarehouseId">
                <input class="layui-input" autocomplete="off" readonly id="reportWarehouse"
                       placeholder="请选择报库点..." onclick="addActiveClass(this)"/>
            </div>
            <div class="layui-inline">
                库点类型:
                <select name="warehouseType" id="warehouseType">
                    <option value="">全部</option>
                    <option value="储备库">直属单位</option>
                    <option value="代储库">代储点</option>
                </select>
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
                <%--<input class="layui-input" id="harvestYear"/>--%>
                <select name="harvestYear" id="harvestYear">
                    <option value="">全部</option>
                </select>
            </div>
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
            <div class="layui-inline">
                统计方式:
                <select name="enterprise" id="enterprise">
                    <option value="库点">库点</option>
                    <option value="所属企业">所属企业</option>
                </select>
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
					库存总量分布:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;单位:吨&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<b class="tion">显示方式:</b>
						<select name="grouping" id="grouping" class="tion" onchange="switchingGrouping()">
							<option value="总量">总数量</option>
							<option value="品种">粮油品种</option>
							<option value="年份">收获年份</option>
							<option value="品质">品质</option>
						</select>
				</span>
                <div class="grid-demo" id="aa" style="height: 670px;border: 1px solid #ddd;">1/3</div>
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
            elem: '#month',
            type: 'month',
            btns: ['now', 'confirm']
        });
        $(document).ready(function (e) {
            reloadcharts('init');
        })

        //年份下拉框
        var myDate = new Date();
        var startYear = myDate.getFullYear() - 10;//起始年份
        var endYear = myDate.getFullYear() + 10;//结束年份
        var obj = document.getElementById('harvestYear');
        for (var i = startYear; i <= endYear; i++) {
            obj.options.add(new Option(i, i));
        }

        var list = 0;
        var list1 = 0;
        var list4 = 0;
        var list2 = 0;
        var maxquantity = 0;
        var month = "";
        var reportWarehouseId = "";
        var variety = "";
        var harvestYear = "";
        var warehouseType = "";
        var province = "";
        var city = "";
        var district = "";
        var enterprise = "";

        function reloadcharts(val) {
            month = $("#month").val();
            reportWarehouseId = $("#reportWarehouseId").val();
            variety = $('#variety').val();
            harvestYear = $('#harvestYear').val();
            warehouseType = $('#warehouseType').val();
            province = $('#province').val();
            city = $('#city').val();
            district = $('#district').val();
            enterprise = $('#enterprise').val();
            $('#grouping').val('总量');
            list = 0;
            list1 = 0;
            list4 = 0;
            list2 = 0;
            var barLegend = [];
            var xAxisData = [];
            var quantityTotal = [];
            var series = [];
            var dataZoom = {
                show: true,
                realtime: true,
                y: 36,
                height: 20,
                start: 0,
                end: 60
            };
            $.ajax({
                type: "POST",
                url: "${ctx}/charts/getKCTJCharts.shtml",
                data: {
                    month: month,
                    reportWarehouseId: reportWarehouseId,
                    variety: variety,
                    harvestYear: harvestYear,
                    warehouseType: warehouseType,
                    province: province,
                    city: city,
                    district: district,
                    enterprise: enterprise,
                    grouping: "总量",
                    type: val
                },
                dataType: "json",
                success: function (data) {
                    //回显月份
                    if (val == "init") {
                        $("#month").val(data.reportMonth);
                        month = data.reportMonth;
                    }
                    maxquantity = data.maxquantity;
                    list1 = data.list1;
                    //-------------------渲染柱状图数据-------------------------------
                    $.each(list1, function (aIndex, a) {
                        xAxisData.push(a.reportWarehouse);
                        quantityTotal.push(a.quantityTotal);
                    });
                    if (xAxisData.length > 30) {
                        series.push({
                            name: '总数量',
                            type: 'bar',
                            stack: '总数量',
                            data: quantityTotal
                        });
                    } else {
                        series.push({
                            name: '总数量',
                            type: 'bar',
                            stack: '总数量',
                            barWidth: 30,
                            data: quantityTotal
                        });
                    }
                    if (xAxisData.length > 0) {
                        barLegend.push('总数量');
                    }
// -----------------------------------------------柱状图数据填充--------------------------------
                    // 指定图表的配置项和数据
                    optionbar = {
                        title: {
                            left: 'right',
                        },
                        tooltip: {
                            trigger: 'axis',
                            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                            }
                        },
                        legend: {
                            data: barLegend,
                            left: 'left'
                        },
                        toolbox: {
                            show: true,
                            feature: {
                                saveAsImage: {show: true}
                            }
                        },
                        grid: {
                            left: '3%',
                            right: '4%',
                            bottom: '10%',
                            containLabel: true
                        },
                        xAxis: {
                            type: 'category',
                            data: xAxisData,
                            axisTick: {
                                alignWithLabel: true
                            },
                            axisLabel: {
                                interval: 0,
                                rotate: 45
                            }
                        },
                        yAxis: {
                            type: 'value',
                            max: maxquantity
                        },
                        series: series,
                    };
                    if (xAxisData.length > 30) {
                        optionbar.dataZoom = dataZoom;
                    }
                    var myChartbar = echarts.init(document.getElementById('aa'));
                    // 使用刚指定的配置项和数据显示图表。
                    myChartbar.clear();
                    myChartbar.setOption(optionbar);
// -----------------------------------------------柱状图数据填充完成--------------------------------
                }
            })
        }

        function switchingGrouping(val) {
            var grouping = $("#grouping").val();
            if ((grouping == "品种" && list == 0) || (grouping == "年份" && list4 == 0) || (grouping == "品质" && list2 == 0)) {
                $.ajax({
                    type: "POST",
                    url: "${ctx}/charts/getKCTJCharts.shtml",
                    data: {
                        month: month,
                        reportWarehouseId: reportWarehouseId,
                        variety: variety,
                        harvestYear: harvestYear,
                        warehouseType: warehouseType,
                        province: province,
                        city: city,
                        district: district,
                        enterprise: enterprise,
                        grouping: grouping,
                        type: val
                    },
                    dataType: "json",
                    success: function (data) {
                        list1 = data.list1;
                        if (grouping == "品种") {
                            list = data.list;
                        } else if (grouping == "年份") {
                            list4 = data.list4;
                        } else if (grouping == "品质") {
                            list2 = data.list2;
                        }
                        inputdata(grouping);
                    }
                });
            } else {
                inputdata(grouping);
            }
        }

        function inputdata(grouping) {
            var barLegend = [];
            var xAxisData = [];
            var quantityTotal = [];
            var slightlyTotal = [];
            var severeTotal = [];
            var series = [];
            var dataZoom = {
                show: true,
                realtime: true,
                y: 36,
                height: 20,
                start: 0,
                end: 60
            };
            if (grouping == '总量') {
                $.each(list1, function (aIndex, a) {
                    xAxisData.push(a.reportWarehouse);
                    quantityTotal.push(a.quantityTotal);
                });
                if (xAxisData.length > 30) {
                    series.push({
                        name: '总数量',
                        type: 'bar',
                        stack: '总数量',
                        data: quantityTotal
                    });
                } else {
                    series.push({
                        name: '总数量',
                        type: 'bar',
                        stack: '总数量',
                        barWidth: 30,
                        data: quantityTotal
                    });
                }
                if (xAxisData.length > 0) {
                    barLegend.push('总数量');
                }
            } else if (grouping == '品种') {
                $.each(list1, function (aIndex, a) {
                    xAxisData.push(a.reportWarehouse);
                });
                $.each(list, function (bIndex, b) {
                    quantityTotal.push(b.list2);
                });
                $.each(list, function (cIndex, c) {
                    if (xAxisData.length > 30) {
                        series.push({
                            name: c.variety,
                            type: 'bar',
                            stack: '总数量',
                            data: quantityTotal[cIndex]
                        });
                    } else {
                        series.push({
                            name: c.variety,
                            type: 'bar',
                            stack: '总数量',
                            barWidth: 30,
                            data: quantityTotal[cIndex]
                        });
                    }
                    barLegend.push(c.variety);
                });
            } else if (grouping == '年份') {

                $.each(list1, function (aIndex, a) {
                    xAxisData.push(a.reportWarehouse);
                });
                $.each(list4, function (bIndex, b) {
                    quantityTotal.push(b.list3);
                });
                $.each(list4, function (cIndex, c) {
                    if (xAxisData.length > 30) {
                        series.push({
                            name: c.variety,
                            type: 'bar',
                            stack: '总数量',
                            data: quantityTotal[cIndex]
                        });
                    } else {
                        series.push({
                            name: c.variety,
                            type: 'bar',
                            stack: '总数量',
                            barWidth: 30,
                            data: quantityTotal[cIndex]
                        });
                    }
                    barLegend.push(c.variety);
                });
            } else if (grouping == '品质') {

                $.each(list2, function (aIndex, a) {
                    xAxisData.push(a.reportWarehouse);
                    if (a.advisedTotal != null) {
                        quantityTotal.push(a.advisedTotal);
                    } else {
                        quantityTotal.push(0);
                    }
                    if (a.slightlyTotal != null) {
                        slightlyTotal.push(a.slightlyTotal);
                    } else {
                        slightlyTotal.push(0);
                    }
                    if (a.severeTotal != null) {
                        severeTotal.push(a.severeTotal);
                    } else {
                        severeTotal.push(0);
                    }
                });
                if (xAxisData.length > 30) {
                    series.push({
                        name: '宜存数量',
                        type: 'bar',
                        stack: '总数量',
                        data: quantityTotal
                    });
                    series.push({
                        name: '轻度不宜存数量',
                        type: 'bar',
                        stack: '总数量',
                        data: slightlyTotal
                    });
                    series.push({
                        name: '重度不宜存数量',
                        type: 'bar',
                        stack: '总数量',
                        data: severeTotal
                    });
                } else {
                    series.push({
                        name: '宜存数量',
                        type: 'bar',
                        stack: '总数量',
                        barWidth: 30,
                        data: quantityTotal
                    });
                    series.push({
                        name: '轻度不宜存数量',
                        type: 'bar',
                        stack: '总数量',
                        barWidth: 30,
                        data: slightlyTotal
                    });
                    series.push({
                        name: '重度不宜存数量',
                        type: 'bar',
                        stack: '总数量',
                        barWidth: 30,
                        data: severeTotal
                    });
                }
                if (xAxisData.length > 0) {
                    barLegend = ['宜存数量', '轻度不宜存数量', '重度不宜存数量']
                }
            }

            // -----------------------------------------------柱状图数据填充--------------------------------
            // 指定图表的配置项和数据
            optionbar = {
                title: {
                    left: 'right',
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                legend: {
                    data: barLegend,
                    left: 'left'
                },
                toolbox: {
                    show: true,
                    feature: {
                        saveAsImage: {show: true}
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '10%',
                    containLabel: true
                },
                xAxis: {
                    type: 'category',
                    data: xAxisData,
                    axisLabel: {
                        interval: 0,
                        rotate: 45
                    }
                },
                yAxis: {
                    type: 'value',
                    max: maxquantity
                },
                series: series,
            };
            if (xAxisData.length > 30) {
                optionbar.dataZoom = dataZoom;
            }
            var myChartbar = echarts.init(document.getElementById('aa'));
            // 使用刚指定的配置项和数据显示图表。
            myChartbar.clear();
            myChartbar.setOption(optionbar);
// -----------------------------------------------柱状图数据填充完成--------------------------------
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
            $('#reportWarehouseId').val("");
            $('#reportWarehouse').val("");
            $('#variety').val("");
            $('#harvestYear').val("");
            $('#origin').val("");
            $('#warehouseType').val("");
            $('#province').val("");
            $('#city').val("");
            $('#district').val("");
        }

    </script>
<%@ include file="../../common/AdminFooter.jsp" %>