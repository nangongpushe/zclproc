<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../../common/AdminHeader.jsp" %>
<link rel="stylesheet" href="${ctx}/css/commons.css"/>
<link rel="stylesheet" href="${ctx}/css/report_ku_add.css">
<link rel="stylesheet" href="${ctx}/css/report_ku_add.css">
<link rel="stylesheet" type="text/css" href="${ctx}/js/paging/paging.css">
<script type="text/javascript" src="${ctx}/js/paging/query.js"></script>
<script type="text/javascript" src="${ctx}/js/paging/paging.js"></script>
<style>
    #LAY_table_permission + .layui-form .layui-table-body td[data-field="enterpriseName"] {
        text-align: left;
    }

    #LAY_table_permission + .layui-form .layui-table-body td[data-field="shortName"] {
        text-align: left;
    }

    #LAY_table_permission1 + .layui-form .layui-table-body td[data-field="reportName"] {
        text-align: left;
    }

    #LAY_table_permission1 + .layui-form .layui-table-body td[data-field="reportMonth"] {
        text-align: center;
    }

    #LAY_table_permission1 + .layui-form .layui-table-body td[data-field="reportStatus"] {
        text-align: left;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>报表台账</li>
        <li>填报管理</li>
        <li class="active">[代储]报表填报</li>
    </ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

    <div class="demoTable">
        公司名称:
        <input type="hidden" name="clickEnterpriseName" id="clickEnterpriseName" value="">
        <input type="hidden" name="shortName" id="shortName" value="">
        <div class="layui-input-inline">
            <input class="layui-input" name="enterpriseName" id="enterpriseName" autocomplete="off">
        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%-- 查询范围:
         <div class="layui-input-inline">
             <select  id="selectScope" name="selectScope">
                 <option value="1">代储点公司</option>
                 <option value="2">所有公司</option>
             </select>
         </div>--%>
        报表月度:
        <div class="layui-input-inline">
            <input class="layui-input" name="reportMonth" id="reportMonth" autocomplete="off">
        </div>

        <button class="layui-btn layui-btn-primary layui-btn-small" id="serch_reload" data-type="reload">查询</button>
        <button class="layui-btn layui-btn-primary layui-btn-small" id="serch_reload1" data-type="reload1">查询</button>
    </div>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
    <div class="row">
        <div class="col-md-5" id="">
            <%-- <ul id="tree" class="ztree"></ul>--%>
            <%--<table class="layui-hide" id="LAY_table_permission" lay-filter="demoEvent"></table>--%>

            <table id="LAY_table_permission" lay-filter="demoEvent">
                <thead class="LAY_table_permission_thead">

                </thead>
                <tbody class="LAY_table_permission_body">

                </tbody>
            </table>
            <div id="pageListPlg"></div>
        </div>
        <div class="col-md-7">
            <%--<table class="layui-hide" id="LAY_table_permission" lay-filter="demoEvent"></table>--%>
            <table class="layui-hide" id="LAY_table_permission1" lay-filter="demoEvent1"></table>
        </div>
    </div>


</div>


<%@include file="../../common/AdminFooter.jsp" %>

<%@include file="common_script.jsp" %>
<style>
    .bg-red {
        background: red !important;
    }
</style>
<script>
    var pageNum = 1
</script>
<script>
    function setPages(opt) {
        $('#pageListPlg').html('')
        $('#pageListPlg').Paging({
            current: opt.current, pagesize: opt.pagesize, count: opt.count, toolbar: true,
            prevTpl: "",
            nextTpl: '',
            callback: function (t) {
                init({page: t})
            }
        });
    }

    function init(getOpt) {
        layer.load(2, {time: 2000});
        var getEnterpriseName = $('#enterpriseName').val();
        var getReportMonth = $('#reportMonth').val();
        pageNum = getOpt.page;
        var clickEnterpriseName = '';

        if (localStorage.getItem('back') == 'back') { //点击返回按钮
            getEnterpriseName = localStorage.getItem('enterpriseName') ? localStorage.getItem('enterpriseName') : $('#enterpriseName').val()
            getReportMonth = localStorage.getItem('reportMonth') ? localStorage.getItem('reportMonth') : $('#reportMonth').val()
            pageNum = localStorage.getItem('pageNum') ? localStorage.getItem('pageNum') : getOpt.page
            clickEnterpriseName = localStorage.getItem('clickEnterpriseName')
            shortName  = localStorage.getItem('shortName')
        }
        $('#enterpriseName').val(getEnterpriseName);
        $('#reportMonth').val(getReportMonth);
        $.post("${ctx}/reportMonth/enterpriseList.shtml", {
            enterpriseName: getEnterpriseName,
            reportMonth: getReportMonth,
            page: pageNum,
            pageSize: 10
        }, function (result) {
            var html = '';
            // console.log(result)
            $('.LAY_table_permission_thead').html(
                '<tr>' +
                '<th lay-data="{field:\'enterpriseName\', width:200}">公司名称</th>' +
                '<th lay-data="{field:\'shortName\', width:150}">公司简称</th>' +
                '</tr>'
            );
            for (var s in result.data) {
                html +=
                    '<tr class="">' +
                    '<td><input type="hidden" value="'+result.data[s].wareHouseId+'">' + result.data[s].enterpriseName + '</td>' +
                    '<td>' + result.data[s].shortName + '</td>' +
                    '</tr>'
            }

            $('.LAY_table_permission_body').html(html);
            //设置分页
            setPages({
                current: pageNum, pagesize: '10', count: result.count
            });

            layui.use('table', function () {
                var table = layui.table;
                table.render({});
                active = {
                    parseTable: function () {
                        table.init('demoEvent', { //转化静态表格
                            height: 449,
                            even: true, //开启隔行背景
                            done: function (res, curr, count) {
                                //console.log(result.data)
                                for (var r = 0; r < result.data.length; r++) {
                                    if (result.data[r].isStop == 'Y') {// 被禁用
                                        $('#LAY_table_permission + .layui-form .layui-table-body tr').eq(r).addClass('bg-red');
                                    }
                                }
                                for (var i = 0; i < res.data.length; i++) {
                                    if (res.data[i].shortName == shortName) {
                                        $('#LAY_table_permission + .layui-form .layui-table-body tr').eq(i).css('background', '#B0E0E6');
                                        if(clickEnterpriseName == ''){
                                            clickEnterpriseName = result.data[0].wareHouseId;
                                        }
                                        $('#clickEnterpriseName').val(clickEnterpriseName);
                                        $('#shortName').val(shortName);

                                        document.getElementById("serch_reload1").click();
                                    }
                                }
                                if (clickEnterpriseName == '') { //如果 没有点击 还有就是第一次进来
                                    $('#LAY_table_permission + .layui-form .layui-table-body tr').eq(0).css('background', '#B0E0E6');
                                    $('#clickEnterpriseName').val(result.data[0].wareHouseId);
                                    $('#shortName').val(res.data[0].shortName);
                                    document.getElementById("serch_reload1").click();
                                }
                                $('#LAY_table_permission + .layui-form .layui-table-body').on('click', 'tr', function () {
                                    $("#clickEnterpriseName").val($(this).find('td[data-field = "enterpriseName"]').find("input").val());
                                    $("#shortName").val($(this).find('td[data-field = "shortName"]').text());
                                    $(this).css('background', '#B0E0E6').siblings().css('background', 'none');
                                    //触发查询按钮
                                    document.getElementById("serch_reload1").click();
                                })
                                //cleanLocal()
                                // $('#clickEnterpriseName').val($('#LAY_table_permission + .layui-form .layui-table-body tr').eq(0).find('td[data-field="enterpriseName"]').text());
                            }
                        });
                    }
                };
                active['parseTable'].call(this);
            });
        });
    }

    init({page: 1});

    $('.demoTable .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });


    layui.use('table', function () {
        var table = layui.table;
        //render初始化参数
        table.render({
            elem: '#LAY_table_permission1',
            url: '${ctx}/reportMonth/reportMonthlist.shtml',
            method: 'POST'

            , cols: [[
                /* ,{field:'id',title:'ID',width:200,sort:true} */
                /* ,{field:'parentid',title:'上级',width:200} */
                {field: 'reportName', title: '报表名称', width: 200, align: 'center'}
                , {field: 'reportMonth', title: '报表月度', width: 200, align: 'center'}
                , {field: 'reportStatus', title: '状态', width: 100, align: 'center'}
                , {width: 150, title: '操作', align: 'center', fixed: 'right', toolbar: '#barDemo1'} //这里的toolbar值是模板元素的选择器
            ]]
            , id: 'testReload1'
            , page: true
            , even: true //开启隔行背景
            , height: 490
        });

        //监听工具条
        table.on('tool(demoEvent1)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            var tr = obj.tr; //获得当前行 tr 的DOM对象

            if (layEvent === 'addReportMonthList') { //添加报告
                var enterpriseName = $("#enterpriseName").val();
                var clickEnterpriseName = $('#clickEnterpriseName').val();
                localStorage.setItem('enterpriseName', enterpriseName)
                localStorage.setItem('reportMonth', $('#reportMonth').val())
                localStorage.setItem('clickEnterpriseName', $("#clickEnterpriseName").val())
                localStorage.setItem('shortName', $("#shortName").val())
                localStorage.setItem('pageNum', pageNum)
                $.post("${ctx}/reportMonth/maintainReportMonth.shtml", {
                    warehouseId: clickEnterpriseName,
                    reportMonth: data.reportMonth,
                    reportName: data.reportName
                }, function (result) {
                    if (result.indexOf('对不起，无此库') > -1) {
                        layer.msg('对不起，无此库');
                    } else {
                        window.location.href = '${ctx}/reportMonth/maintainReportMonth.shtml?warehouseId=' + clickEnterpriseName + '&reportMonth=' + data.reportMonth + '&reportName=' + data.reportName;
                    }
                })
            }
        });

        active1 = {
            reload1: function () {
                var clickEnterpriseName = $('#clickEnterpriseName');
                var reportMonth = $('#reportMonth');
                table.reload('testReload1', {
                    where: { //设定异步数据接口的额外参数
                        reportWarehouseId: clickEnterpriseName.val(),
                        reportMonth: reportMonth.val()
                        //clickEnterpriseName:clickEnterpriseName.val()
                    }
                });
            }
        };
        $('#serch_reload1').on('click', function () {
            var clickEnterpriseName = $('#clickEnterpriseName').val();
            if (clickEnterpriseName) {
                var type = $(this).data('type');
                active1[type] ? active1[type].call(this) : '';
            } else {
                layer.open({
                    title: '提示:',
                    content: '请输入公司名称！'
                });
                return false;
            }
        });
        //点击查询按钮
        $('#serch_reload').on('click', function () {
            var clickEnterpriseName = $('#enterpriseName').val();
            cleanLocal()
            init({page: 1})
        });
    });

    function cleanLocal() {
        localStorage.setItem('enterpriseName', '')
        localStorage.setItem('reportMonth', '')
    }

    $(function () {
        //initVal 时间值
        $("#serch_reload1").hide();
        var form = layui.form;
        form.render();
        form.on('select(test_s)', function (data) {
            $("#search_sum #reportName").val(data.value);
        });

        var now = new Date();
        now.setMonth(now.getMonth() - 1);
        var initVal;

        if (now.getDate() >= 10) {
            initVal = now.getFullYear().toString() + '-' + (now.getMonth() + 1).toString();
        } else {

            initVal = now.getFullYear().toString() + '-' + (now.getMonth() + 1).toString();
        }

        if (initVal.split('-')[1].length < 2){
            var a = initVal.split('-')
            //initVal = initVal.replace(initVal.split('-')[1], '0' + initVal.split('-')[1]);
            var f = a[1];
            a.splice(1, 1, f < 10 ? '0' + f : f);
            initVal = a[0] + '-' + a[1];
        }
        if (localStorage.getItem('back')) {
            initVal = localStorage.getItem('reportMonth') ? localStorage.getItem('reportMonth') : initVal
            localStorage.setItem('back', '');
        }
        layui.laydate.render({
            elem: $("#reportMonth")[0],
            type: 'month',
            value: initVal
        });
    });

</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="viewReportMonthList">查看报表</a>
</script>
<script type="text/html" id="barDemo1">
    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="addReportMonthList">维护报表</a>
</script>