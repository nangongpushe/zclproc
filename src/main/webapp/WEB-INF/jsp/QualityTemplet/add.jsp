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
            </c:if>粮油模板
        </li>
    </ol>
    <div class="container-box clearfix" style="padding: 10px">
        <!--检验结果表-->
        <form class="form_input" action="save.shtml" method="post" enctype="multipart/form-data">
            <input type="hidden" name="auvp" value="${auvp}">
            <input type="hidden" name="id" value="${entity.id }"/>
            <table class="table table-bordered">
                <!-- 表格内容 start -->
                <tbody>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>模板编号:</b></td>
                    <td><input maxlength="10" type="text" name="templetNo" id="templetNo" onchange="check();"
                               value='${entity.templetNo }' class="form-control validate[required]" placeholder=""
                               maxlength="10"/></td>
                    <td class="text-right"><span class="red">*</span><b>模板名称:</b></td>
                    <td><input maxlength="20" type="text" name="templetName " value='${entity.templetName }'
                               class="form-control validate[required]" placeholder="" maxlength="20"/></td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>粮油品类:</b></td>
                    <td>
                        <select lay-verify="required" class="form-control validate[required]" name="type" id="type">
                            <option value="">--请选择--</option>
                            <c:forEach items="${type}" var="type">
                                <option value="${type.value}"
                                        <c:if test="${type.value eq entity.type }">selected="selected"</c:if> >${type.value}</option>
                            </c:forEach>
                        </select>
                    </td>

                    <%--<td class="text-right"><span class="red">*</span><b> 检验类型:</b></td>--%>
                    <%--<td>--%>
                        <%--<select lay-verify="required" class="form-control validate[required]"  name="checkType" id="validType">--%>
                            <%--<option value="">--请选择--</option>--%>
                            <%--<c:forEach items="${validTypes}" var="item">--%>
                                <%--<option value="${item.value}" <c:if test="${item.value eq entity.checkType }">selected="selected"</c:if> >${item.value}</option>--%>
                            <%--</c:forEach>--%>
                        <%--</select>--%>
                    <%--</td>--%>
                </tr>
                <!-- 表格内容 end -->
                </tbody>
            </table>
            <div class="manage">
                <p class="layui-tab-content">
                    <button type="button" class="layui-btn layui-btn-small" id="btnNew" onclick="addList();">新增检测项明细
                    </button>

                </p>
                <table class="layui-table" id="in">
                    <thead>
                    <tr>
                        <td align="center">检测项目</td>
                        <td align="center">等级</td>
                        <td align="center">最低指标</td>
                        <td align="center">序号</td>
                        <td align="center">操作</td>
                    </tr>
                    </thead>
                    <!-- 表格内容start -->
                    <tbody id="Detail" class="text-center">
                    <c:forEach items="${entityItem}" var="entityItem" varStatus="status">
                        <tr>
                            <td colspan="1"><input maxlength="20" type="text" value='${entityItem.itemName }'
                                                   name="itemName"
                                                   class="form-control validate[required] " placeholder=""/></td>
                            <td colspan="1">
                                <select lay-verify="required" class="form-control validate[required]" name="grade"
                                        id="grade" <c:if test="${auvp=='v' }">disabled="disabled"</c:if>>
                                    <option value="">--请选择--</option>
                                    <c:forEach items="${grade}" var="grade">

                                        <option value="${grade.value}"
                                                <c:if test="${grade.value eq entityItem.grade }">selected="selected"</c:if> >${grade.value}</option>
                                    </c:forEach>
                                </select>
                            <td colspan="1"><input maxlength="20" type="text" value='${entityItem.standard }'
                                                   name="standard"
                                                   class="form-control validate[required] " placeholder=""/></td>
                            <td colspan="1"><input maxlength="20" type="text" value='${entityItem.orderNo }'
                                                   name="orderNo" class="form-control validate[required] "
                                                   placeholder=""/></td>
                            <td colspan="1"><input type="hidden" value='${entityItem.templetId }'
                                                   name="templetId" style="width:0px;"/><a href="javascript:void(0);"
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
    function check() {

        var templetNo = document.getElementById("templetNo").value;
        $.post("${ctx}/QualityTemplet/check.shtml?str=one", {
            templetNo: templetNo
        }, function (result) {
            if (!result.success) {
                layer.closeAll(); //疯狂模式，关闭所有层
                layer.open({
                    title: '提示信息'
                    , content: '模板编号已存在'
                });
                document.getElementById("templetNo").value = "";
            }
        });
    }

    $(function () {

        var auvp = '${auvp}';
        if (auvp == 'v') {
            $("#cancel").text("返回");
        } else {
            $("#cancel").text("取消");
        }
        if (auvp == 'v') {
            $("#btnNew").attr({"disabled": "disabled"});
            //下拉框禁用
            $("select").each(function () {
                $("#" + this.id).attr("disabled", "disabled");
            });
            $("form").find("input,textarea,select,button").prop("readonly", true);
            $('#btnSave').hide();
        } else if (auvp == 'u') {
            $("#templetNo").attr("disabled", true);
            /* $("#type").attr("disabled", true); */
            $('#id').prop("readonly", true);
        } else if (auvp == 'a') {
//            addList();
        }

    });
    $("#add-list").click(function () {
        $("#float-alert").slideToggle(500, function () {
            $("#table-wapper").slideToggle(500);
        });
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
        var tr = '<tr id="kin">'
            + '<td colspan="1">' +
            '<input maxlength="20" type="text"  name="itemName" class="form-control validate[required]" placeholder="--请输入--" maxlength="20" /></td>'
            + '<td colspan="1">'
            + '<select lay-verify="required" class="form-control validate[required]"  name="grade"  >'
            + '   		<option value="">--请选择--</option>'
            + '          <c:forEach items="${grade}" var="grade"> '
            + '			<option value="${grade.value}">${grade.value}</option>'
            + '		 </c:forEach>'
            + '	</select>'
            + '<td colspan="1"><input maxlength="20" type="text"  name="standard" class="form-control validate[required]"    placeholder="" maxlength="50"/></td>'
            + '<td colspan="1"><input maxlength="20" type="text"  name="orderNo" class="form-control validate[required] "  placeholder=""/></td>'
            + '<td colspan="1"><input type="hidden" name="templetId" style="width:0px;"/><a href="javascript:void(0);" onclick="toDelete(this);" class="layui-btn layui-btn-small layui-bg-red" data-id="" id="delete">删除</a>	</td>'
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
    var saveFlag = 0;

    $("#btnSave").click(function(){
        // 判断是否填写成交明细
        if($("input[name='itemName']").length <= 0){
            layer.msg("请填写检测项明细");
            return;
        }

        var auvp = '${auvp}';
        if($(".form_input").validationEngine('validate')!=true){
            return;
        }
        if(saveFlag==0){
            saveFlag=1;
        }else {
            return;
        }

        $.post("${ctx}/QualityTemplet/check.shtml?str=two",
            {
                templetNo : $('#search #templetNo').val(),
                templetName : $('#search #templetName').val(),
                type : $('#search #type').val(),
            },

            function(result) {
                if (!result.success) {
                    saveFlag=0;
                    layer.closeAll(); //疯狂模式，关闭所有层
                    layer.open({
                        title: '提示信息'
                        ,content: '粮油品类已配置检测项目'
                    });
                }else{



                    $(".form_input").ajaxSubmit({
                        type:"post",

                        success:function(data){
                            if(data.success){
                                alert("保存成功");
                                location.href="${ctx}/QualityTemplet.shtml";
                            }else{
                                alert("保存失败");
                                saveFlag=0;
                            }
                        },

                    });
                    // }

                }
            }

        )});


    $("#cancel").click(function(){
        var auvp = '${auvp}';
        if(auvp=='v'){
            history.go(-1);
        }else{
            layer.confirm('您是否要放弃', function(index) {
                history.go(-1);
            });

        }

    });





</script>
