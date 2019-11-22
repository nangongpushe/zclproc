<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
    #mytable + .layui-form .layui-table-body td[data-field="sampleNo"]{
        text-align: left;
    }
    #mytable + .layui-form .layui-table-body td[data-field="reportUnit"]{
        text-align: left;
    }
    #mytable + .layui-form .layui-table-body td[data-field="variety"]{
        text-align: left;
    }
    #mytable + .layui-form .layui-table-body td[data-field="storeEncode"]{
        text-align: left;
    }
    #mytable + .layui-form .layui-table-body td[data-field="quantity"]{
        text-align: right;
    }
    #mytable + .layui-form .layui-table-body td[data-field="harvestYear"]{
        text-align: center;
    }
    #mytable + .layui-form .layui-table-body td[data-field="testDate"]{
        text-align: center;
    }
    #mytable + .layui-form .layui-table-body td[data-field="testEndDate"]{
        text-align: center;
    }
    #mytable + .layui-form .layui-table-body td[data-field="status"]{
        text-align: left;
    }
    #mytable + .layui-form .layui-table-body td[data-field="mainTester"]{
        text-align: left;
    }

</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>轮换方案</li>
        <li class="active">
            子方案列表</li>
    </ol>
</div>
<div class="" id="self-cover-grain" style="">
    <div class="dialogsCont-" style="">
        <div class="grain-cont-detail"></div>
        <a class="cancalButtons" onclick="displayNone()" style="">返回</a>
    </div>
</div>

<style>
    .dialogsCont-{
        padding-top: 10px;
        padding: 0 15px 12px;
        pointer-events: auto;
        user-select: none;
        -webkit-user-select: none;
    }
    .cancalButtons{
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
<script>
    //点击弹框取消按钮
    function displayNone() {
        $('#self-cover-grain').css({'display':'none'})
        $('#self-grain-cover').css({'display':'none'})
        $('.grain-cont-detail').html('')
        //searchReload()
    }
</script>

<div class="container-box clearfix" style="padding: 10px">

    <div class="layui-form noprint" id="search">

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="text-align: right">方案名称</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="schemeName" id="schemeName" autocomplete="off"/>
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">计划年份:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="year" id="year"
                           autocomplete="off">
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">所属计划:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="originId"
                           id="originId" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">轮换类别:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="schemeType"
                           id="schemeType" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">轮换方式:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="rotateType"
                           id="rotateType" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">分发时间:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="completeDate"
                           id="completeDate" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">执行状态:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="executeState"
                           id="executeState" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">企业:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="enterpriseName"
                           id="enterpriseName" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">库点:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="libraryId"
                           id="libraryId" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">仓房:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="branNumber"
                           id="branNumber" autocomplete="off">
                </div>
            </div>
            <%--<div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">粮食品种:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="foodType"
                           id="foodType" autocomplete="off">
                </div>
            </div>--%>
            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">粮油品种:</label>
                <div class="layui-input-inline">
                    <select name="foodType" id="foodType">
                        <option></option>
                        <c:forEach items="${varietyList }" var="item">
                            <option value="${item.value }">${item.value }</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">收获年份:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="yieldTime"
                           id="yieldTime" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label " style="text-align:right">产地:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="ogirin"
                           id="ogirin" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
            </div>
        </div>

    </div>
    <!-- layui表格 -->
    <table lay-filter="test" id="mytable"></table>
    <script type="text/html" id="barDemo">

        <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>

    </script>
</div>
<script>
    var form=layui.form;
    form.render();

    var table = layui.table;
    table.render();
    //执行渲染
    table.render({
        elem : '#mytable',
        url : '${ctx}/RotateScheme/getDetailList.shtml',
        method:'post',
        cols : [[
            {field:'schemeName',title: '方案名称',width:200,fixed: true,align : 'center'},
            {field:'year',title:'计划年份',width:200,align:'center'},
            {field:'originId',title: '所属计划',width:150,align : 'center'},
            {field:'schemeType',title: '轮换类别',width:150,align : 'center'},
            {field:'rotateType',title: '轮换方式',width:150,align : 'center'},
            {field:'rotateNumber',title: '入库/出库数量',width:150,align : 'center'},
            {field:'completeDate',title: '分发时间',width:150,align : 'center'},
            {field:'executeState',title: '执行状态',width:150,align : 'center'},
            {field:'schemeBatch',title: '批次',width:150,align : 'center'},
            {field:'biddingTime',title: '竞价时间',width:150,align : 'center'},
            {field:'startTime',title:'轮换开始时间',width:150,align : 'center'},
            {field:'enterpriseName',title: '企业',width:150,align : 'center'},
            {field:'libraryId',title: '库点',width:150,align : 'center'},
            {field:'branNumber',title: '仓房',width:150,align : 'center'},
            {field:'foodType',title: '粮食品种',width:150,align : 'center'},
            {field:'yieldTime',title: '收获年份',width:150,align : 'center'},
            {field:'ogirin',title: '产地',width:150,align : 'center'},
            {field:'storeType',title: '存储方式',width:150,align : 'center'},
            {field:'qualityDetail',title: '质量详情',width:150,align : 'center'},
            {field:'overdueTime',title: '允许逾期天数',width:150,align : 'center'},
            {width : 160,align : 'center',toolbar : '#barDemo',title: '操作',width:450},

        ]],//设置表头
        /* 		request : {

                    pageName : 'page',
                    limitName : 'pageSize'
                }, */
        page:true,//开启分页
        /* 		limit:10, */
        id:'myTableID',
        done:function(res,curr,count){

        },
    });


    table.on('tool(test)', function(obj) {
        var data = obj.data;
         if (obj.event === 'edit') {
             layer.open({
                 type: 2,
                 area: ['700px', '450px'],
                 fixed: false, //不固定
                 maxmin: true,
                 content: '../RotateScheme/childIframe.jsp',
                 success:function(){
                     debugger
                     //$datagrid.bootstrapTable('refresh');//关闭时的动作
                     var iframe = window['layui-layer-iframe'];
                     iframe.child('我是父布局传到子布局的值')
                 }
             });
        }
    });


    //搜索
    $('#search button').click(function() {
        table.reload("myTableID", {
            method: 'post' //如果无需自定义HTTP类型，可不加该参数
            ,where : {
                schemeName : $('#search #schemeName').val(),
                year : $('#search #year').val(),
                originId : $("#search #originId").val(),
                schemeType : $('#search #schemeType').val(),
                rotateType : $('#search #rotateType').val(),
                completeDate : $('#search #completeDate').val(),
                executeState : $('#search #executeState').val(),
                enterpriseName : $('#search #enterpriseName').val(),
                libraryId : $('#search #libraryId').val(),
                branNumber : $('#search #branNumber').val(),
                foodType : $('#search #foodType').val(),
                yieldTime : $('#search #yieldTime').val(),
                ogirin : $('#search #ogirin').val(),
            }
        });
    });
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#testDate',
            range: true,
            done: function(value,date,endDate){
                console.log(value);
            }
        });
    });
    layui.laydate.render({
        elem:$('[name="year"]')[0],
        type:"year",
        format:"yyyy",

    });
    layui.laydate.render({
        elem:$('[name="completeDate"]')[0],
        /*type:"year",*/
        format:"yyyy-MM-dd",

    });
    layui.laydate.render({
        elem:$('[name="yieldTime"]')[0],
        type:"year",
        format:"yyyy",

    });

</script>
<%@include file="../common/AdminFooter.jsp"%>