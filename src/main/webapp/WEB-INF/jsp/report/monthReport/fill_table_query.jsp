<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" type="text/css" href="${ctx}/js/paging/paging.css">
<script type="text/javascript" src="${ctx}/js/paging/query.js"></script>
<script type="text/javascript" src="${ctx}/js/paging/paging.js"></script>
<style>
    #mytable + .layui-form .layui-table-body td[data-field="reportWarehouse"] {
        text-align: left;
    }

    #mytable + .layui-form .layui-table-body td[data-field="reportStatus"] {
        text-align: left;
    }

    #mytable + .layui-form .layui-table-body td[data-field="reportMonthStatus"] {
        text-align: left;
    }

</style>
<div style="padding: 10px">
    <div class="layui-form" id="search_sum">
        <div class="layui-form-item">
            <div class="layui-inline layui-col-md4">
                <label class="layui-form-label ">报表月度:</label>
                <div class="layui-input-inline">
                    <input class="layui-input reportMonthTemp" name="reportMonth" id="reportMonth" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline layui-col-md4">
                <label class="layui-form-label ">报表类别:</label>
                <div class="layui-input-inline">
                    <select class="reportNameTemp layui-input" lay-filter="test_s" name="reportName" id="reportName"
                            autocomplete="off">
                        <c:forEach items="${reportNameList}" var="reportName">
                            <option>${reportName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-inline layui-col-md4">
                <label class="layui-form-label ">报表状态:</label>
                <div class="layui-input-inline">
                    <select class="layui-input" name="reportStatus" id="reportStatus" autocomplete="off">
                        <option>全部</option>
                        <option>未做</option>
                        <option>草稿</option>
                        <option>待审核</option>
                        <option>审核通过</option>
                        <option>上报待审</option>
                        <option>上报通过</option>
                        <option>汇总待审</option>
                        <option>汇总驳回</option>
                        <option>汇总通过</option>
                    </select>
                </div>
            </div>
            <shiro:hasPermission name="AppKu:batchAudit">
                <div class="layui-inline layui-col-md4">
                    <div class="layui-btn" id="approval" data-type="getCheckData" style="margin-left:35px;height: 36px">
                        批量审核
                    </div>
                </div>
            </shiro:hasPermission>
            <div class="layui-inline">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
            </div>

        </div>
    </div>
    <table lay-filter="test_t" id="mytable" lay-data="{id:'mytable'}">
        <thead class="LAY_table_permission_thead">

        </thead>
        <tbody class="LAY_table_permission_body">

        </tbody>
    </table>
    <div id="pageListPlg"></div>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
    </script>
</div>
<script>
    var pageNum = 1
</script>
<script type="text/javascript">
    // $("#approval").click(function () {
    //     layer.confirm('确定审批选中数据吗?', function() {
    //         var $ = layui.$, active = {
    //             getCheckData: function () { //获取选中数据
    //                 var checkStatus = table.checkStatus('mytable')
    //                     , data = checkStatus.data;
    //                 layer.alert(JSON.stringify(data));
    //             }
    //         }
    //     });
    // });


    $(function () {
        function saveSessionLocal() {
            sessionStorage.setItem('app_ku_main_reportName_', $("#search_sum #reportName").val());
            sessionStorage.setItem('app_ku_main_month_', $('#search_sum #reportMonth').val()); //月份
            sessionStorage.setItem('app_ku_mian_reportStatus_', $('#search_sum #reportStatus').val());
            sessionStorage.setItem('app_ku_main_pageIndex_', pageNum); //页数保持
            sessionStorage.setItem('app_ku_mian_back_', 't');
        }

        var form = layui.form;
        var table = layui.table;
        var dataLi = '';
        form.render();

        form.on('select(test_s)', function (data) {
            $("#search_sum #reportName").val(data.value);
        });
        // 日期
        var now = new Date();
        now.setMonth(now.getMonth() - 1);
        var initVal;

        if (now.getDate() >= 10) {
            initVal = now.getFullYear().toString() + '-' + (now.getMonth() + 1).toString();
        } else {
            initVal = now.getFullYear().toString() + '-' + (now.getMonth() + 1).toString();
        }

        if (initVal.split('-')[1].length < 2) {
            var a = initVal.split('-')
            //initVal = initVal.replace(initVal.split('-')[1], '0' + initVal.split('-')[1]);
            var f = a[1];
            a.splice(1, 1, f < 10 ? '0' + f : f);
            initVal = a[0] + '-' + a[1];
        }
        // 日期
        //设置分页
        function setPages(opt) {
            $('#pageListPlg').html('')
            $('#pageListPlg').Paging({
                current: opt.current, pagesize: opt.pagesize, count: opt.count, toolbar: true,
                prevTpl: "",
                nextTpl: '',
                callback: function (t) {
                    initDataPage({page: t})
                }
            });
        }

        /*
            页面初始化 Settings :{page: t}
         */
        function initDataPage(Settings) {
            pageNum = Settings.page;
            layer.load(2, {time: 2000});
            if (sessionStorage.getItem('app_ku_mian_back_') == 'back') { //点击返回按钮
                $("#search_sum #reportName").val(sessionStorage.getItem('app_ku_main_reportName_'));
                $('#search_sum #reportMonth').val(sessionStorage.getItem('app_ku_main_month_'));
                $('#search_sum #reportStatus').val(sessionStorage.getItem('app_ku_main_reportStatus_'));
                pageNum = sessionStorage.getItem('app_ku_main_pageIndex_'); //页数保持
                sessionStorage.removeItem('app_ku_mian_back_');
                form.render();
            }

            $('.LAY_table_permission_body').html('');
            $.post("${ctx}/reportMonth/fillTableQuerylist.shtml", {
                reportMonth: $('#search_sum #reportMonth').val(),
                reportName: $('#search_sum #reportName').val(),
                reportStatus: $('#search_sum #reportStatus').val(),
                pageIndex: pageNum,
                pageSize: 10
            }, function (result) {
                var html = '';
                dataLi = result.data
                $('.LAY_table_permission_thead').html(
                    '<tr>                                                            ' +
                    '<th lay-data="{checkbox:\'true\',width:50}">' +
                    '<th lay-data="{field:\'id\'}" ></th>' +
                    '<th lay-data="{field:\'enterpriseShortName\', width:350}">单位名称</th>    ' +
                    '<th lay-data="{field:\'reportStatus\', width:250}">报表状态</th>     ' +
                    /* '<th lay-data="{field:\'reportMonthStatus\', width:1100}">月报状态</th>     ' +*/
                    '<th lay-data="{width : 160,align : \'center\',toolbar : \'#barDemo\',title: \'操作\',fixed: \'right\'}"></th>     ' +
                    '</tr>'
                );
                for (var s in result.data) {
                    // if(result.data[s].reportStatus==上报待审){
                    //    html+='<tr class="" lay>'
                    // }
                    html +=
                        '<tr class="">' +
                        '<td> </td>' +
                        '<td >' + result.data[s].id + '</td>' +
                        '<td>' +
                        result.data[s].enterpriseShortName + '</td>  ' +
                        '<td>' + result.data[s].reportStatus + '</td>  ' +
                        '</tr>'
                }
                $('.LAY_table_permission_body').html(html)
                //设置分页
                setPages({
                    current: pageNum, pagesize: '10', count: result.count
                });

                layui.use('table', function () {
                    table.render({});
                    // table.on('checkbox(test_t)', function(obj){
                    //     console.log(obj)
                    // });
                    active = {
                        parseTable: function () {
                            table.init('test_t', { //转化静态表格
                                //height: 449,
                                even: true, //开启隔行背景
                                done: function (res, curr, count) {
                                    data = res.data;
                                    $("#mytable").next().find(".layui-table-body.layui-table-main table")
                                        .find("tbody tr").each(function (index) {
                                        $("#mytable").next().find(".layui-table-body.layui-table-main table")
                                            .find("tbody tr").find("td:eq(1)").hide();
                                        $("#mytable").next().find(".layui-table-header")
                                            .find("thead tr").find("th:eq(1)").hide();
                                        if (data[index].reportStatus == '未做') {
                                            $(this).attr("style", "background:#FF6A6A");//红色
                                        }

                                        if (data[index].reportStatus == '草稿'
                                            || data[index].reportStatus == '待审核'
                                            || data[index].reportStatus == '审核通过') {

                                            $(this).attr("style", "background:#FFF3A0");//黄色
                                        }

                                        if (data[index].reportStatus == '上报待审'
                                            || data[index].reportStatus == '汇总驳回') {

                                            $(this).attr("style", "background:#ffffff");//白色
                                        }

                                        if (data[index].reportStatus == '上报通过'
                                            || data[index].reportStatus == '汇总待审'
                                            || data[index].reportStatus == '汇总通过') {

                                            $(this).attr("style", "background:#499C54;");//绿色
                                        }
                                        if (data[index].reportStatus != '上报待审') {
                                            $(this).find("input[type='checkbox']").attr("disabled", true);//设置禁用
                                        }

                                        if ($("#judge")[0].value == "2") {//判断分库查询页面，隐藏按钮
                                            $("#search_sum").find("#approval").hide();
                                            $("#mytable").next().find(".layui-table-header table").find("thead tr th:eq(0)").hide();
                                            $("#mytable").next().find(".layui-table-body.layui-table-main table")
                                                .find("tbody tr").each(function (index) {
                                                $(this).find("td:eq(0)").hide();
                                            })
                                        }

                                        $(this).find("td").last().attr("style", "background:#fff");
                                    });
                                },
                            });
                        },
                        getCheckData: function () { //获取选中数据
                            // var checkStatus = table.checkStatus('mytable')
                            //     ,data = checkStatus.data;
                            var ids = [];
                            var child = $("#mytable").next().find(".layui-table-body.layui-table-main table").find('.layui-table-cell.laytable-cell-checkbox')
                                .find('.layui-unselect.layui-form-checkbox.layui-form-checked');
                            child.each(function (index) {
                                ids.push($(this).parent().parent().next().children()[0].innerHTML);
                            });
                            if (ids.length < 1) {
                                layer.msg('无选中项');
                                return false;
                            }
                            ids = ids.join(",");
                            //layer.alert(JSON.stringify(ids));

                            layer.confirm('确定审核选中数据吗?', function () {
                                $.ajax({
                                    type: "post",
                                    // dataType: 'json',
                                    url: "${ctx }/reportMonth/sendPassMultiple.shtml",
                                    //contentType: 'application/json',
                                    // traditional:true,
                                    data: {ids: ids},
                                    success: function (data) {
                                        if (data.success == true) {
                                            layer.alert("审核成功!");
                                        }
                                        else if(data.success==false){
                                            layer.alert("审核失败!");
                                        }
                                        initDataPage({page: 1});
                                    }
                                })
                            })
                        }
                    };
                    active['parseTable'].call(this);
                    $('.layui-inline.layui-col-md4 .layui-btn').on('click', function () {
                        var type = $(this).data('type');
                        active[type] ? active[type].call(this) : '';
                    });
                });
            });
        }

        form.on('checkbox(layTableAllChoose)', function () {
            var child = $("#mytable").next().find(".layui-table-body.layui-table-main table").find('tbody input[type="checkbox"]');
            child.each(function (index, item) {
                if (data[index].reportStatus == '上报待审') {
                    item.checked = $("#mytable").next().find(".layui-table-header table").find('thead input[type="checkbox"]')[0].checked;
                }
            });
            form.render('checkbox');
        });

        layui.laydate.render({
            elem: $("#reportMonth")[0],
            type: 'month',
            value: initVal
        });

        //点击查询按钮
        $('#search_sum button').click(function () {
            initDataPage({page: 1});
        });

        table.on('tool(test_t)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') { //点击查看按钮
                for (var i = 0; i < dataLi.length; i++) {
                    if (data.enterpriseShortName == dataLi[i].enterpriseShortName
                        && dataLi[i].reportStatus == data.reportStatus) {
                        $("#form-active-add #reportWarehouseId").val(dataLi[i].reportWarehouseId);
                        $("#form-active-add #reportWarehouse").val(dataLi[i].reportWarehouse);
                        $("#form-active-add #reportName").val($('#search_sum #reportName').val());
                        $("#form-active-add #month").val($('#search_sum #reportMonth').val());
                    }
                }

                saveSessionLocal();
                $('.d_isplay_n_o_n_e_cs_').removeClass('display_none_cs')
                reportName = $('#search_sum #reportName').val();
                loadReport($('#search_sum #reportMonth').val());
            }
        });

        initDataPage({page: 1}); //页面初始化
    });
</script>