<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp" %>

<style>

    .btn:hover, .btn:link, .btn:active, .btn:visited {
        background-color: #fff;
        color: #23527c;
        border-color: #fff;
    }

    #freightDetails td > select {
        display: inline-block;
    }

    #detailList thead td {
        text-align: center;
    }

    #detailList tbody td[data-field="price"] {
        text-align: right;
    }

    #detailList tbody td[data-field="amount"] {
        text-align: right;
    }

    #detailList tbody td[data-field="clear"] {
        text-align: center;
    }

    #myTable1 + .layui-form .layui-table-body td[data-field="dealSerial"] {
        text-align: left;
    }

    #myTable1 + .layui-form .layui-table-body td[data-field="grainType"] {
        text-align: left;
    }

    #myTable1 + .layui-form .layui-table-body td[data-field="quantity"] {
        text-align: right;
    }

    #myTable1 + .layui-form .layui-table-body td[data-field="dealPrice"] {
        text-align: right;
    }

    #myTable1 + .layui-form .layui-table-body td[data-field="dealUnit"] {
        text-align: left;
    }


</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>商务处理</li>
        <c:if test="${!isEdit }">
            <li class="active">货款支付新增</li>
        </c:if>
        <c:if test="${isEdit }">
            <li class="active">货款支付编辑</li>
        </c:if>
    </ol>
</div>


<div class="container-box clearfix" style="padding: 10px"
     id="rotateinvite_add">

    <div class="layui-row title">
        <h5>货款支付信息</h5>
    </div>

    <form class="layui-form" lay-filter="form">
        <input type="hidden" name="clientName"  id="clientName" value=""/>
        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>收款单位:</label>
                <div class="layui-input-inline">
                    <select name="clientId" lay-search lay-filter="clientId" id="clientId" lay-verify="required">
                        <option value="">--请选择--</option>
                        <c:forEach items="${customers}" var="custom">
                            <option  <c:if test="${custom.id==model.clientId}">selected</c:if>  value="${custom.id}">${custom.clientName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>开户行:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="depositBank" lay-verify="required"
                           autocomplete="off" placeholder=""
                           value="${model.depositBank}" maxlength="45">
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>账号:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="depositAccount" lay-verify="required"
                           autocomplete="off" placeholder=""
                           value="${model.depositAccount}" maxlength="19">
                </div>
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>付款方式:</label>
                <div class="layui-input-inline">
                    <select name="payType" lay-verify="required">
                        <option value="">--请选择--</option>
                        <c:forEach var="item" items="${payTypes}">
                            <option value="${item.value}">${item.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>货款类型:</label>
                <div class="layui-input-inline">
                    <select name="proceedType" lay-verify="required">
                        <option value="">--请选择--</option>
                        <c:forEach var="item" items="${proceedTypes}">
                            <option value="${item.value}">${item.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">附件:</label>
                <div class="layui-input-inline">
                    <button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="uploadFile"
                            name="file">
                        <c:choose>
                            <c:when test="${model.groupId!=null and model.groupId!=''}">
                                <i class="layui-icon"></i>上传
                            </c:when>
                            <c:otherwise>
                                <i class="layui-icon"></i>上传
                            </c:otherwise>

                        </c:choose>
                    </button>
                    <span id="fileName">
                            <a href="${ctx }/sysFile/download.shtml?fileId=${model.groupId}" style="margin:0 10px;">${filename.fileName}</a>
                    </span>
                    <%--<div id="afileName" style="display:inline-block;font-size:14px;">
                        <a href="${ctx }/sysFile/download.shtml?fileId=${model.groupId}" style="margin:0 10px;">${filename.fileName}</a>
                    </div>--%>
                    <div style="display:inline-block;font-size:20px;" id="openExce">
                        <a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${filename.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
                            预览
                        </a>
                        <a href="javascript:openAnnex('${model.groupId}')" id="openFile" style="display: none">
                            预览
                        </a>
                    </div>
                    <div style="display:inline-block;font-size:20px;">
                        <input type="button" id="delFileBtn" <c:if test="${empty filename.fileName}">style="display: none" </c:if>  onclick="resetFileInput();"  value="删除"/>
                    </div>
                </div>
                <div class="layui-input-inline">
                    <input type="text" name="groupId" readonly style="display:none;" id="fileId"
                           autocomplete="off" class="layui-input form-control" value="${model.groupId}">
                </div>
            </div>
        </div>


        <div class="layui-row title">
            <h5>货款支付明细</h5>
        </div>

        <button id="getAdd" type="button" class="layui-btn layui-btn-primary layui-btn-small"
                data-bind="click:function(){$root.showModal();}">
            <i class="layui-icon">&#xe608;</i> 新增
        </button>
        <table class="layui-table" id="detailList">
            <thead>
            <tr>
                <td>方案名称</td>
                <td>标的号</td>
                <td>品种</td>
                <td>数量(吨)</td>
                <td>单价(元/吨)</td>
                <td>金额(元)</td>
                <td>操作</td>
            </tr>
            </thead>
            <tbody data-bind="foreach:detailList">
            <tr>
                <td data-bind="text:concluteId" class="concluteId" style="display: none"></td>
                <td data-bind="text:schemeName" style="text-align:left"></td>
                <td data-bind="text:bidSerial" style="text-align:right"></td>
                <td data-bind="text:grainType" style="text-align:left"></td>
                <td style="text-align:right">
                    <input type="number" lay-verify="required" autocomplete="off"
                           class="layui-input quantity" data-bind="value:quantity" oninput="if(value.length>10)value=value.slice(0,10)" >
                </td>
                <td data-field="price" data-bind="text:price" style="text-align:right"></td>
                <td data-field="amount" data-bind="text:amount" style="text-align:right"></td>
                <td data-field="clear">
                    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini"
                       data-bind="click:function(){$root.remove($index())}">删除</a>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="layui-row text-center"
             data-bind="visible:detailList().length==0">暂无明细数据
        </div>

        <div class="layui-form-item text-center">
            <button class=" layui-btn layui-btn-primary layui-btn-small" lay-submit="" lay-filter="save"
                    data-status="待提交">保存
            </button>
            <button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small " lay-filter=save
                    data-status="审核中(业务部经理)">提交
            </button>
            <button type="button" class=" layui-btn layui-btn-primary layui-btn-small"
                    data-bind="click:function(){$root.cancel();}">取消
            </button>
        </div>
    </form>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                </div>
                <div class="modal-body">
                    <div class="layui-form" id="search2" lay-filter="search2">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">粮食种类:</label>
                                <div class="layui-input-inline">
                                    <select class="layui-input" name="grainType">
                                        <option value="">全部</option>
                                        <c:forEach items="${grainType}" var="type">
                                            <option value="${type.value}">${type.value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">成交单位:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" name="dealUnit"
                                           autocomplete="off" readonly>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">成交时间:</label>
                                <div class="layui-input-inline" style="width: 100px">
                                    <input class="date-need layui-input" name="startDealDate"
                                           autocomplete="off">
                                </div>
                                <div class="layui-form-mid">
                                    -
                                </div>
                                <div class="layui-input-inline" style="width: 100px">
                                    <input class="date-need layui-input" name="endDealDate"
                                           autocomplete="off">
                                </div>
                            </div>

                            <div class="layui-inline">
                                <button id="getDetail" class=" layui-btn layui-btn-primary layui-btn-small"
                                        data-type="reload"
                                        data-bind="click:function(){$root.reloadTable1();}">查询
                                </button>
                            </div>
                        </div>
                    </div>

                    <table class="layui-table" lay-filter="table1" id="myTable1"></table>
                </div>
                <div class="modal-footer">

                    <button type="button" class=" layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.confirm();}">确定
                    </button>
                    <button type="button" class=" layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.hideModal();}">取消
                    </button>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>


<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatepayment/add.js"></script>

<script>
    $(function () {
        $("#search2 [name='dealUnit']").val($("#clientId option:selected").html());

    })
    
    layui.use(['form', 'laydate'], function(){
        var form = layui.form;
        form.render();

        form.on('select(clientId)', function(data) {

            var options = $("#clientId option:selected"); //获取选中的项
            // $('.layui-input').val(options.text()); // 用法2 给input清空
            if (options.val() != null && options.val() != "") {
                $("input[name='dealUnit']").val(options.text());
                // $("input[name='keleyicom']").val(options.text()); // 用法2 给input清空
                $("#clientName").val(options.text());
            }

        })



    });
    function resetFileInput(){
        $("input[name='file']").val("");
        $("#fileId").val("");
        $("#uploadFile").html("<i class=\"layui-icon\"></i>上传");
        $("#fileName").html("");
        $("#delFileBtn").hide();
        $("#openExce a").html("");
    }
    if ("${model.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }

    $("#getAdd").click(function(){
        $("#getDetail").trigger("click");
    });

    var isedit = ${isEdit};
    if (isedit) {
        $('[name=clientName]').val("${model.clientName}");
        $('[name=payType]').val("${model.payType}");
        $('[name=proceedType]').val("${model.proceedType}");
    }
    var id = '${model.id}' || 0;
    var detailList =${cf:toJSON(model.detailList)};
    var customers =${cf:toJSON(customers)};
    var vm = new Add(isedit, id, detailList, customers);
    ko.applyBindings(vm, $(".container-box")[0]);
    vm.initPage();
    UploadFile();

    function numberFixed(obj, op) {
        number = $(obj).val();
        if (number == null || number == "") {
            return
        }
        number = parseFloat(number).toFixed(op);
        $(obj).val(number);
    }

    //  事件绑定
    $(document).on("change",".quantity",function () {
        // 判断是否大于成交明细中的数量
        debugger
        let quantity = Number($(this).val());
        let quantityTemp = Number(0);
        // 获取成交明细号ID
        let concluteId = $(this).parent().parent().find(".concluteId").html();

        $.ajaxSettings.async = false;
        $.get("${ctx}/rotateConclute/concluteDetail.shtml?id="+concluteId,function (data) {
            if(data.code=="success"){
                quantityTemp = Number(data.data.quantity);
            }
        });
        $.ajaxSettings.async = true;

        if (quantity > quantityTemp) {
            layui.layer.msg("输入吨数大于成交吨数");
            $(this).val("");
            return;
        }

        $(this).val(quantity.toFixed(3));  // 保留三位小数
    })
</script>
<%@include file="../common/AdminFooter.jsp" %>