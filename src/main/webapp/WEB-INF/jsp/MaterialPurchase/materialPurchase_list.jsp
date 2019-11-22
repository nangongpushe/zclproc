<%@ page language="java" contentType="text/html; charset=UTF-8" %>


<%@include file="../common/AdminHeader.jsp" %>
<style type="text/css">

    #mytable + .layui-form .layui-table-body td[data-field="purchaseSerial"] {
        text-align: right;
    }

    #mytable + .layui-form .layui-table-body td[data-field="purchaseDept"] {
        text-align: left;
    }

    #mytable + .layui-form .layui-table-body td[data-field="totalAmount2"] {
        text-align: right;
    }

    #mytable + .layui-form .layui-table-body td[data-field="purchaseMan"] {
        text-align: left;
    }

    .layui-inline {
        width: 45%;
    }

    .layui-form-item .layui-form-label {
        text-align: right;
        width: 30%;
        max-width: 120px;
    }

    .layui-form-item .layui-input-inline {
        width: 65%;
    }

    .layui-form-item {
        margin-bottom: 1px;
    }

</style>

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>物资管理</li>
        <li class="active">采购管理</li>
    </ol>
</div>
<style>
    .dialogsCont- {
        padding-top: 10px;
        padding: 0 15px 12px;
        pointer-events: auto;
        user-select: none;
        -webkit-user-select: none;
    }

    .cancalButtons {
        height: 28px;
        display: inline-block;
        line-height: 28px;
        margin: 5px 5px 0;
        padding: 0 15px;
        border: 1px solid #dedede;
        background-color: #fff;
        color: #333;
        position: absolute;
        border-radius: 2px;
        font-weight: 400;
        top: 0;
        right: 16px;
        cursor: pointer;
        text-decoration: none;
    }

    #self-cover-grain {
        z-index: 3;
        overflow: scroll;
        min-width: 260px;
        top: 0;
        margin: 0;
        width: 100%;
        height: 100%;
        padding: 0;
        display: none;
        background-color: #fff;
        position: fixed;
        -webkit-background-clip: content;
        border-radius: 2px;
        box-shadow: 1px 1px 50px rgba(0, 0, 0, .3);
    }
</style>
<div class="" id="self-cover-grain" style="">
    <div class="dialogsCont-" style="">
        <div class="grain-cont-detail"></div>
        <a class="cancalButtons" onclick="displayNone()" style="">返回</a>
    </div>
</div>

<script>
    //点击弹框取消按钮
    function displayNone() {
        $('#self-cover-grain').css({'display': 'none'})
        $('#self-grain-cover').css({'display': 'none'})
        $('.grain-cont-detail').html('')
        //searchReload()
    }
</script>

<div class="container-box clearfix" style="padding: 10px">
    <shiro:hasPermission name="MaterialPurchase:search">
        <div class="layui-form" id="search" lay-filter="search">
            <div class="layui-form-item">

                <div class="layui-inline">
                    <label class="layui-form-label ">申购部门:</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="purchaseDept" id="purchaseDept" autocomplete="off">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">申购日期起:</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" name="timeStart" id="timeStart"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label layui-col-md2">申购日期止:</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" name="timeEnd" id="timeEnd"
                               autocomplete="off">
                    </div>
                </div>

                <div class="layui-inline">
                    <button class="layui-btn layui-btn-primary layui-btn-small " id="searchBtn" data-type="reload">查询
                    </button>
                </div>
            </div>
        </div>
    </shiro:hasPermission>

    <div class="manage">
        <shiro:hasPermission name="MaterialPurchase:add">
            <p class="btn-box" style="padding-top:0px;margin-left:10px;">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                        onclick="window.location.href='${ctx }/MaterialPurchase/add.shtml?'">新增
                </button>
            </p>
        </shiro:hasPermission>
        <!-- layui表格 -->
        <table lay-filter="test" id="mytable"></table>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
            <shiro:hasPermission name="MaterialPurchase:edit">
                <a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
            </shiro:hasPermission>
            <shiro:lacksPermission name="MaterialPurchase:edit">
                <a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="edit">编辑</a>
            </shiro:lacksPermission>
            <shiro:hasPermission name="MaterialPurchase:delete">
                <a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
            </shiro:hasPermission>
            <shiro:lacksPermission name="MaterialPurchase:delete">
                <a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
            </shiro:lacksPermission>

        </script>
    </div>
</div>


<script>
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#timeStart'
            , format: 'yyyy-MM-dd' //可任意组合
        });
        laydate.render({
            elem: '#timeEnd'
            , format: 'yyyy-MM-dd' //可任意组合
        });
    });

    var table = layui.table;
    table.render();

    //执行渲染
    table.render({
        elem: '#mytable',
        url: '${ctx}/MaterialPurchase/list.shtml',
        method: 'POST',
        cols: [[
            {align: 'center', field: 'purchaseSerial', title: '申购编号', width: 250},
            {align: 'center', field: 'purchaseDept', title: '申购部门', width: 200},
            {align: 'center', field: 'totalAmount2', title: '预计总金额(元)', width: 200},
            {align: 'center', field: 'purchaseDate', title: '申购日期', width: 200},
            {align: 'center', field: 'purchaseMan', title: '申购人', width: 250},
            {align: 'center', toolbar: '#barDemo', title: '操作', width: 450},


        ]],//设置表头

        page: true,//开启分页

        id: 'myTableID',
        done: function (res, curr, count) {
        },
    });

    //监听工具条

    table.on('tool(test)', function (obj) {
        var data = obj.data;
        console.log(data);
        if (obj.event === 'detail') {
            layer.load(2, {time: 6000});
            $('#self-cover-grain').css({'display': 'block'})
            $('#self-grain-cover').css({'display': 'block'})
            $('.grain-cont-detail').load("${ctx}/MaterialPurchase/view.shtml",
                {id: data.id})
            <%--location.href = "${ctx}/MaterialPurchase/view.shtml?id="--%>
            <%--+ data.id;--%>
        } else if (obj.event === 'del') {
            layer.confirm('确定删除吗？', function (index) {
                $.post("${ctx}/MaterialPurchase/remove.shtml", {
                    id: data.id
                }, function (result) {
                    layer.closeAll(); //疯狂模式，关闭所有层
                    layer.msg("删除成功", {icon: 1}, function () {
                        table.reload("myTableID", {
                            method: 'post', //如果无需自定义HTTP类型，可不加该参数
                            where: {
                                purchaseDept: $('#search #purchaseDept').val(),
                                timeEnd: $('#search #timeEnd').val(),
                                timeStart: $('#search #timeStart').val()

                            }
                        });
                    })

                });
            });
        } else if (obj.event === 'edit') {
            location.href = "${ctx}/MaterialPurchase/edit.shtml?id="
                + data.id;
        }

    });


    //搜索
    $('#search button').click(function () {
        var beginDate = $("#timeStart").val();
        var endDate = $("#timeEnd").val();
        var d1 = new Date(beginDate.replace(/\-/g, "\/"));
        var d2 = new Date(endDate.replace(/\-/g, "\/"));

        if (beginDate != "" && endDate != "" && d1 > d2) {
            alert("申购日期起不能大于申购日期止！");
            return;
        }
        table.reload("myTableID", {
            method: 'post' //如果无需自定义HTTP类型，可不加该参数
            , where: {
                purchaseDept: $('#search #purchaseDept').val(),
                timeEnd: $('#search #timeEnd').val(),
                timeStart: $('#search #timeStart').val()

            }
        });
    });
</script>
<%@include file="../common/AdminFooter.jsp" %>
