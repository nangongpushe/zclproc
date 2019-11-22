<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<%@include file="../common/AdminHeader.jsp" %>

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>质量管理</li>
        <li>质量档案</li>
        <li class="active"><c:if test="${auvp=='a'}">
            新增
        </c:if>
            <c:if test="${auvp=='u'}">
                编辑
            </c:if>
            <c:if test="${auvp=='v'}">
                查看
            </c:if>
            等级指标管理
        </li>
    </ol>
    <div class="container-box clearfix" style="padding: 10px">
        <!--检验结果表-->
        <form class="form_input" action="save.shtml" method="post" enctype="multipart/form-data">
            <input type="hidden" name="auvp" value="${auvp}">
            <input type="hidden" name="id" value="${entity.id }"/>
            <table class="table table-bordered" lay-filter="test">
                <!-- 表格内容 start -->
                <tbody>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>指标编号:</b></td>
                    <td><input maxlength="32" type="text" name="quotaNo" id="quotaNo" value='${entity.quotaNo }'
                               class="form-control validate[required]" placeholder="" onchange="quotaNoCheck();"/></td>
                    <td class="text-right"><span class="red">*</span><b>指标名称:</b></td>
                    <td><input maxlength="50" type="text" name="quotaName " value='${entity.quotaName }'
                               class="form-control validate[required]" placeholder=""/></td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>粮油品类:</b></td>
                    <td>
                        <select lay-verify="required" class="form-control validate[required]" name="type" id="type" onchange="changeStyle(this.value)" onclick="clean()">
                            <option value="">--请选择--</option>
                            <c:forEach items="${type}" var="type">
                                <option value="${type.value}"
                                        <c:if test="${type.value eq entity.type }">selected="selected"</c:if> >${type.value}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td class="text-right"><span class="red">*</span><b>等级:</b></td>
                    <td>
                        <select lay-verify="required" class="form-control validate[required]" name="grade" id="grade">
                            <option value="" id="cleanOption">--请选择--</option>
                            <c:forEach items="${grade}" var="grade">
                                <option value="${grade.value}"
                                        <c:if test="${grade.value eq entity.grade }">selected="selected"</c:if>
                                        <c:if test="${fn:contains(grade.value,'等')==true}">class="grain" </c:if>
                                        <c:if test="${fn:contains(grade.value,'等')==false}">class="oil" </c:if>>${grade.value}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <!-- 表格内容 end -->
                </tbody>
            </table>
            <div class="manage">
                <p class="layui-tab-content">
                    <button type="button" id="btnNew" class="layui-btn layui-btn-small" onclick="addList();">新增检测项明细
                    </button>

                </p>
                <table class="layui-table" id="in">
                    <thead>
                    <tr>
                        <td align="center">检测项目</td>
                        <td align="center">标准值</td>
                        <td align="center">操作</td>
                    </tr>
                    </thead>
                    <!-- 表格内容start -->
                    <tbody id="Detail" class="text-center">
                    <c:forEach items="${entityItem}" var="entityItem">
                        <tr>
                            <td colspan="1"><input type="text" value='${entityItem.itemName }' id="itemName"
                                                   name="itemName" class="form-control validate[required] "
                                                   placeholder=""/></td>
                            <td colspan="1"><input maxlength="50" type="text" value='${entityItem.standard }'
                                                   id="standard" name="standard"
                                                   class="form-control validate[required] " placeholder=""/></td>
                            <td colspan="1"><input type="hidden" value='${entityItem.quotaId }' id="quotaId"
                                                   name="quotaId" style="width:0px;"/><a href="javascript:void(0);"
                                                                                         onclick="toDelete(this);"
                                                                                         class="layui-btn layui-btn-small layui-bg-red"
                                                                                         data-id="">删除</a></td>

                        </tr>
                    </c:forEach>
                    </tbody>
                    <!-- 表格内容 end -->
                </table>
            </div>
            <p>备注：带有<span class="red">*</span>为必填项！</p>
            <p class="btn-box text-center">
                <button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">返回</button>
                <button type="button" id="btnSave" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
            </p>


        </form>
        <div class="jumpPage" id="displayPage"></div>
    </div>
</div>

<script>
    function clean() {
        $('#grade').val("");
    }
    function quotaNoCheck() {
        var quotaNo = document.getElementById("quotaNo").value;
        $.post("${ctx}/QualityQuota/check.shtml?str=one", {
            quotaNo: quotaNo
        }, function (result) {
            if (!result.success) {
                layer.closeAll(); //疯狂模式，关闭所有层
                layer.open({
                    title: '提示信息'
                    , content: '指标编号已存在'
                });
                document.getElementById("quotaNo").value = "";
            }
        });
    }

    $(function () {
        var auvp = '${auvp}';
        if(auvp == 'a'){
            $('.oil').hide();
            $('.grain').show();
        }else if(auvp == 'u'||auvp == 'v'||auvp == 'p'){
            var grainType = '${entity.type}';
            changeStyle(grainType);
        }

        if (auvp == 'v') {
            $("#cancel").text("返回");
        } else {
            $("#cancel").text("取消");
        }
        if (auvp == 'v') {
            $("#btnNew").attr({"disabled": "disabled"});
            //下拉框禁用
            $("select").each(function () {
                $("#" + this.id).attr("disabled", true);
            });
            $("form").find("input,textarea,select").prop("readonly", true);
            $('#btnSave').hide();
        } else if (auvp == 'u') {
            $("#quotaNo").attr("disabled", true);
            $('#id').prop("readonly", true);
        }

    });
    layui.use('laydate', function () {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#purchaseDate' //指定元素
        });
    });
    //自定义错误显示位置
    $('.form_input').validationEngine({
        promptPosition: 'bottomRight',
        addPromptClass: 'formError-white'
    });

    function addList() {
        var tr = '<tr>'
            + '<td colspan="1"><input type="text" id="itemName" name="itemName" class="form-control validate[required] "placeholder="--请输入--"/></td>'
            + '<td colspan="1"><input maxlength="50" type="text" id="standard" name="standard" class="form-control validate[required]   placeholder=""/></td>'
            + '<td colspan="1"><input type="hidden" id="quotaId" name="quotaId" style="width:0px;"/><a href="javascript:void(0);" onclick="toDelete(this);" class="layui-btn layui-btn-small layui-bg-red" data-id="">删除</a>	</td>'
            + '</tr>'
        $("#Detail").append(tr);

    }

    function toDelete(ob) {
        var auvp = '${auvp}';
        if (auvp != 'v') {
            $(ob).parent().parent().remove();
        }
    }

    var lastClickTime = 0;
    var DELAY = 20000;
    $("#btnSave").click(function () {
        var auvp = '${auvp}';

        var grade = document.getElementById("grade").value;
        var type = document.getElementById("type").value;
        $.post("${ctx}/QualityQuota/check.shtml?str=two", {
            quotaNo: $('#search #quotaNo').val(),
            quotaName: $('#search #quotaName').val(),
            type: $('#search #type').val(),
            grade: $('#search #grade').val()
        }, function (result) {
            if (!result.success) {
                layer.closeAll(); //疯狂模式，关闭所有层
                layer.open({
                    title: '提示信息'
                    , content: '粮油品类已配置等级指标'
                });
            } else {
                if ($(".form_input").validationEngine('validate') == true) {
                    var currentTime = Date.parse(new Date());
                    if (currentTime - lastClickTime > DELAY) {
                        lastClickTime = currentTime;
                        $("#btnSave").attr("disabled", true);
                        $(".form_input").ajaxSubmit({
                            type: "post",
                            success: function (data) {
                                if (data.success) {
                                    alert("保存成功");
                                    location.href = "${ctx}/QualityQuota.shtml";
                                } else {
                                    alert("保存失败");
                                    $("#btnSave").attr("disabled", false);
                                }
                            }
                        });
                    }
                }
            }
        });


    });

    $("#cancel").click(function () {
        var auvp = '${auvp}';
        if (auvp == 'v') {
            history.go(-1);
        } else {
            layer.confirm('您是否要放弃', function (index) {
                history.go(-1);
            });

        }
    });
    function changeStyle(val) {
        var grainType = val;
        if(grainType.indexOf("油") != -1 ){
            $('.oil').show();
            $('.grain').hide();
        }else{
            $('.oil').hide();
            $('.grain').show();
        }
    }

</script>
