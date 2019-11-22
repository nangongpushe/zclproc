<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
    #storeHouseTable + .layui-form .layui-table-body td[data-field="warehouse"]{
        text-align: left;
    }
    #storeHouseTable + .layui-form .layui-table-body td[data-field="storehouseName"]{
        text-align: left;
    }
    #storeHouseTable + .layui-form .layui-table-body td[data-field="encode"]{
        text-align: left;
    }
    #storeHouseTable + .layui-form .layui-table-body td[data-field="type"]{
        text-align: left;
    }
    #storeHouseTable + .layui-form .layui-table-body td[data-field="enableDate"]{
        text-align: center;
    }
    #storeHouseTable + .layui-form .layui-table-body td[data-field="designedCapacity"]{
        text-align: right;
    }
    #storeHouseTable + .layui-form .layui-table-body td[data-field="status"]{
        text-align: left;
    }
</style>
<%--<c:if test="${flag!='dc' }">
    <div class="row clear-m">
        <ol class="breadcrumb">
            <li>仓储管理</li>
            <li>仓房管理</li>
            <li class="active">仓房信息管理</li>
        </ol>
    </div>
</c:if>--%>
    <div class="row clear-m">
        <ol class="breadcrumb">
            <li>代储监管</li>
            <li>企业信息</li>
            <li>[代储]仓房管理</li>
        </ol>
    </div>

<%--<input  type="hidden" id="flag" value="${flag }">--%>

<div class="container-box clearfix" style="padding: 10px">

    <div class="layui-form" id="search">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">企业：</label>
                <div class="layui-input-inline">
                    <input class="layui-input" autocomplete="off" id="enterpriseName" name="enterpriseName" onclick="selectEnterprise()">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">库点：</label>
                <div class="layui-input-inline">
                    <input class="layui-input" autocomplete="off" id="warehouse" name="warehouse">
                </div>
            </div>
            <div class="layui-inline" id="dataScope1">
                <label class="layui-form-label">库点类型：</label>
                <div class="layui-input-inline">
                    <select  id="dataScope" name="dataScope">
                        <option value="1">代储点</option>
                        <option value="2">所有</option>
                    </select>
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label">仓房：</label>
                <div class="layui-input-inline">
                    <input class="layui-input" autocomplete="off" id="encode" name="encode">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">仓房状态：</label>
                <div class="layui-input-inline">
                    <select  id="status" name="status">
                        <option value=""></option>
                        <c:forEach items="${statusDict }" var="item">
                            <option value="${item.value }">${item.value }</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">是否停用：</label>
                <%--<div class="layui-input-inline">
                    <input class="layui-input" autocomplete="off" id="enterpriseName" name="enterpriseName">
                </div>--%>
                <div class="layui-input-inline">
                    <select lay-verify="required" class="form-control"  name="isStop" id="isStop" lay-search lay-filter="isstop">
                        <option value="">--全部--</option>
                        <option value="Y" >是</option>
                        <option value="N" >否</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBt">查询</button>
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="clearBt">清空</button>
            </div>
        </div>
    </div>
    <br>

    <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="window.location.href='addProxyPage.shtml'">新增</button>

    <%--
    <p class="btn-box">
        <shiro:hasPermission name="StorageStorehouse:add">
        <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="window.location.href='storageStoreHouse/addPage.shtml'">新增</button>
        </shiro:hasPermission>
    </p> --%>
    <table lay-filter="operation" id="storeHouseTable"></table>

    <%-- <shiro:hasPermission name="StorageStorehouse:option">
        <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="option">维修记录</a>
    </shiro:hasPermission> --%>

    <script type="text/html" id="operationColId">

            <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="addOption">新建维修</a>

            <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>

            <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>

            <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="copy">复制</a>

            <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>



    </script>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog"  style="width:800px;">
        <div class="modal-content">
            <div class="modal-header"><!-- data-dismiss="modal"  -->
                <button type="button" class="close" aria-hidden="true" onclick="removeActiveClass()">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    选择公司
                </h4>
            </div>
            <div class="modal-body">
                <div class="layui-form" id="searchCompany">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">公司名字：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="companyName">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="enterpriseSearch">查询</button>
                        </div>
                    </div>

                </div>
                <table lay-filter="operation1" id="enterpriseTable"></table>
                <script type="text/html" id="bar">
                    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="choose">选择</a>
                </script>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="removeActiveClass()">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->

</div>
<%-- <script src="${ctx }/js/cities.data.js"></script> --%>
<script>
    var form = layui.form;
    form.render();
    var table = layui.table;
    //table.render();
    //执行渲染
    table.render({
        elem : '#storeHouseTable',
        url : '${ctx}/storageStoreHouse/proxyList.shtml',
        method : "POST",
        cols : [[
            {field : 'warehouse',title: '所属库点',width:200, align : 'center'},
            {field : 'storehouseName',title : '仓房名称',width:200, align : 'center'},
            {field : 'encode',title : '仓房编号',width:200, align : 'center'},
            {field : 'type',title : '仓房类型',width:200, align : 'center'},
            {field : 'enableDate',title : '启用日期',width:200, align : 'center'},
            {field : 'designedCapacity',title : '设计仓容(t)',width:200, align : 'center'},
            {field : 'status',title : '状态',width:200, align : 'center'},
            {field : 'isStop',title : '是否停用',width:200, align : 'center'},
            {fixed: 'right', title : '操作', align : 'center', toolbar : '#operationColId', width:300},
        ]],//设置表头
        request : {
            pageName : 'page',
            limitName : 'pageSize'
        },
        page:true,//开启分页
        id:'storeHouseTableId',
        done:function(res,curr,count){

            console.log(res);
            var originCode = res.msg;
            //alert(res.msg)
            if("CBL" !=originCode &&"ZSK" != originCode && "ZHI" != originCode && "DEQ" != originCode && "YUE" != originCode && "QUZ" != originCode && "ZHS" != originCode){
                   $("#dataScope1").attr("disabled", "true");
                    $("#dataScope1").hide();
            };
            $("[data-field='isStop']").children().each(function(){
                if($(this).text()=='Y'){
                    $(this).text("是")
                }else if($(this).text()=='N'){
                    $(this).text("否")
                }
            })
        },
    });

    //监听工具条
    table.on('tool(operation)', function(obj) {
        var data = obj.data;
        console.log(data);
        if (obj.event === 'detail') {
            location.href = "${ctx}/storageStoreHouse/proxyViewPage.shtml?id="
                + data.id;
        } else if (obj.event === 'del') {
            layer.confirm('确定删除吗？', function(index) {
                $.post("${ctx}/storageStoreHouse/proxyRemove.shtml", {
                    id : data.id
                }, function(result) {
                    if (result.success) {
                        obj.del();
                        layer.msg(result.msg,{time:1000,icon:1});
                        //layer.msg(result.msg,{icon:2});
                    } else {
                        layer.msg(result.msg,{icon:2});
                    }

                });
            });
        } else if (obj.event === 'edit') {
            //alert(1)
            location.href = "${ctx}/storageStoreHouse/proxyEditPage.shtml?id=" + data.id;
            console.log(data);
        } else if (obj.event === 'option') {
            location.href = "${ctx}/storageStoreHouseOption.shtml?storehouseId=" + data.id+"&flag="+$("#flag").val();
        } else if (obj.event === 'addOption') {
            location.href = "${ctx }/storageStoreHouse/proxyAddOptionPage.shtml?storehouseId=" + data.id;
        } else if (obj.event === 'copy'){
            location.href = "${ctx}/storageStoreHouse/proxyEditPage.shtml?id=" + data.id+"&isCopy=1";
            // alert("哈哈");
        };
    });

    //搜索
    $('#searchBt').click(function() {
        table.reload("storeHouseTableId", {
            where : {
                enterpriseName : $('#enterpriseName').val(),
                dataScope : $('#dataScope').val(),
                warehouse : $('#search #warehouse').val(),
                encode : $('#search #encode').val(),
                status : $('#search #status').val(),
                isStop : $('#search #isStop').val()
            }
        });
    });
    $('#clearBt').click(function() {
        $('#enterpriseName').val("");
        $('#dataScope').val("");
        $('#search #warehouse').val("");
        $('#search #encode').val("");
        $('#search #status').val("");
        $('#search #isStop').val("");
        var form = layui.form;
        form.render();
    });

    function removeActiveClass(obj) {
        $('#myModal').modal('hide');
    }
    function selectEnterprise() {
        //selectRow = row;
        $('#myModal').modal({backdrop: 'static'}).modal('show');
    }
    layui.use(['table'], function() {
        var table = layui.table;
        table.render({
            elem : '#enterpriseTable',
            url : '${pageContext.request.contextPath}/StoreEnterprise/enterpriseList.shtml?isEnterpriseType=Y',
            method : "POST",
            cols : [[
                {fixed : 'left', title : '操作', width : 100, align : 'center', toolbar : '#bar'},
                {field : 'enterpriseName',title : '企业名字',width:600}
            ]],//设置表头
            request : {
                pageName : 'page',
                limitName : 'pageSize'
            },
            page:true,//开启分页
            limit:10,
            id:'enterpriseTableId',
            done:function(res,curr,count){
               /* if(isInit){
                    isInit = false;
                    $('#enterpriseSearch').click();
                }*/
            },
        });

        //搜索
        $('#enterpriseSearch').click(function() {
            table.reload("enterpriseTableId", {
                method: 'post', //如果无需自定义HTTP类型，可不加该参数
                where : {
                    enterpriseName : $('#companyName').val()
                }
            });
        });

        table.on('tool(operation1)', function(obj) {
            var data = obj.data;
            if (obj.event === 'choose') {
                $('#enterpriseName').val(data.enterpriseName);

            }
            $('#myModal').modal('hide');
        });
        //监听FORM结束

    });

</script>
<%@include file="../common/AdminFooter.jsp"%>
