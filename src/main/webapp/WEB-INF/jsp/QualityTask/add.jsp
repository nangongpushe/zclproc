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
            </c:if>检验任务
        </li>
    </ol>
    <div class="container-box clearfix" style="padding: 10px">
        <!--检验结果表-->
        <form class="form_input layui-form" action="save.shtml" method="post" enctype="multipart/form-data"
              lay-filter="form1">
            <input type="hidden" name="auvp" value="${auvp}">
            <input type="hidden" name="id" value="${entity.id }"/>
            <table class="table table-bordered">
                <!-- 表格内容 start -->
                <tbody>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>任务编号:</b></td>
                    <td><input maxlength="20" type="text" id="taskSerial" name="taskSerial"
                               value='${entity.taskSerial }' class="form-control validate[required]" placeholder=""
                               onchange="checkRate();"/></td>
                    <td class="text-right"><span class="red">*</span><b>任务名称:</b></td>
                    <td><input maxlength="20" type="text" name="taskName " value='${entity.taskName }'
                               class="form-control validate[required]" placeholder=""/></td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>样品编号:</b></td>
                    <td>
                        <select lay-verify="required" class="form-control" name="sampleNo" id="sampleNo" lay-search=""
                                lay-filter="sampleNo">
                            <option value="">--搜索选择--</option>
                            <c:forEach items="${qualitySamples}" var="qualitySamples">
                                <option tag="${qualitySamples.validType }"
                                        value="${qualitySamples.sampleNo}">${qualitySamples.sampleNo}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td class="text-right"><span class="red">*</span><b>库点名称:</b></td>
                    <td><input type="text" name=" wearhouse" value='${entity.wearhouse }' readonly="readonly"
                               class="form-control validate[required]" placeholder=""/></td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>任务优先级:</b></td>
                    <td>
                        <select lay-verify="required" class="form-control validate[required]" name="taskPriority"
                                id="taskPriority">
                            <option value="">--请选择--</option>
                            <option value="高">高</option>
                            <option value="中">中</option>
                            <option value="低">低</option>
                        </select>
                    </td>
                    <td class="text-right"><span class="red">*</span><b>任务执行人:</b></td>
                    <td><input maxlength="20" type="text" name="taskExecutor " value='${entity.taskExecutor }'
                               class="form-control validate[required]" placeholder=""/></td>
                </tr>
                <tr>
                    <!--  <td class="text-right"><span class="red">*</span><b>检验类型:</b></td>
                     <td>
                     <select lay-verify="required" name="inspectionType" id="inspectionType" class="form-control validate[required]">
                         <option value="">--请选择--</option>
                         <option value="出库">出库</option>
                         <option value="入库">入库</option>
                         <option value="春秋季检查">春秋季检查</option>
                     </select>
                     </td> -->
                    <td class="text-right"><span class="red">*</span><b>计划检验时间:</b></td>
                    <td><input type="text" id="plannedInspectionTime" name="plannedInspectionTime "
                               value='${entity.plannedInspectionTime }' class="form-control " placeholder=""/></td>
                    <td class="text-right"><span class="red"></span><b>实际检验时间:</b></td>
                    <td><input type="text" id="actualInspectionTime" name="actualInspectionTime"
                               value='${entity.actualInspectionTime }' class="form-control " placeholder=""/></td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>任务状态:</b></td>
                    <td>
                        <select name="taskStatus" id="taskStatus" lay-filter="taskStatus"
                                class="form-control validate[required]">
                            <option value="">--请选择--</option>
                            <option value="未开始">未开始</option>
                            <option value="进行中">进行中</option>
                            <option value="已完成">已完成</option>
                        </select>
                    </td>
                    <td class="text-right"><span class="red"></span><b>检验类型:</b></td>
                    <td><input type="text" id="validType" name="validType" value='${entity.validType }'
                               class="form-control " placeholder="" readonly/></td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>任务创建人:</b></td>
                    <td>
                        <input type="text" id="creator" name="creator" value='${entity.creator }' readonly="readonly"
                               class="form-control " placeholder=""/>
                    </td>
                    <td class="text-right"><span class="red">*</span><b>任务创建时间:</b></td>
                    <td>
                        <input type="text" id="createDate" name="createDate" value='${entity.createDate}'
                               readonly="readonly" class="form-control " placeholder=""/>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><span>&nbsp;&nbsp;</span><b>备注：</b></td>
                    <td colspan="3"><textarea maxlength="500" rows="4" name="remark" class="form-control"
                                              placeholder="--请输入--" maxlength="500">${entity.remark }</textarea></td>
                </tr>
                <!-- 表格内容 end -->
                </tbody>
            </table>
            <p>备注：带有<span class="red">*</span>为必填项！</p>
            <p class="btn-box text-center">
                <button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">返回</button>
                <button type="button" id="btnSave" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
                <button type="button" id="btnPrint" onclick="javascript:window.print();"
                        class="layui-btn layui-btn-primary layui-btn-small ">打印
                </button>
            </p>


        </form>
        <div class="jumpPage" id="displayPage"></div>
    </div>

</div>
<script>

    layui.use('laydate', function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#actualInspectionTime'
            , type: 'datetime'
            , format: 'yyyy-MM-dd HH:mm:ss' //可任意组合
        });
    });
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#plannedInspectionTime'
            , type: 'datetime'
            , format: 'yyyy-MM-dd HH:mm:ss' //可任意组合
        });
    });
    $(function () {
        document.getElementById("createDate").value = today();

        document.getElementById("sampleNo").value = '${entity.sampleNo}';
        document.getElementById("taskPriority").value = '${entity.taskPriority}';
// 	document.getElementById("inspectionType").value='${entity.inspectionType}';
        document.getElementById("taskStatus").value = '${entity.taskStatus}';

        var auvp = '${auvp}';
        if (auvp == 'v') {
            $("#cancel").text("返回");
        } else {
            $("#cancel").text("取消");
        }
        if (auvp == 'v') {
            $('#plannedInspectionTime').attr('disabled', true);
            $('#actualInspectionTime').attr('disabled', true);
            //下拉框禁用
            $("select").attr({"disabled": "disabled"});
            $("form").find("input,textarea,select").prop("readonly", true);
            $('#btnSave').hide();
            $('#btnPrint').hide();
            $('form select').show();
        } else if (auvp == 'u') {
            $("#taskSerial").attr("disabled", true);
            $('#id').prop("readonly", true);
            $('#btnPrint').hide();
            layui.form.render('select', 'form1');
        } else if (auvp == 'p') {
            $("form").find("input,textarea,select").prop("readonly", true);
            $('#btnSave').hide();
            $('form select').show();
        } else if (auvp == 'a') {
            $('#btnPrint').hide();
            layui.form.render('select', 'form1');
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
    $("#taskStatus").change(function () {
        var taskStatus = document.getElementById("taskStatus").value;
        if (taskStatus == "未开始") {
            $('#actualInspectionTime').attr('disabled', true);
            document.getElementById("actualInspectionTime").value = "";
        } else {
            $('#actualInspectionTime').attr('disabled', false);
        }
    });

    layui.form.on('select(sampleNo)', function (data) {
        $("#validType").val($(data.elem[data.elem.selectedIndex]).attr("tag"));
    });
    var lastClickTime = 0;
    var DELAY = 20000;
    $("#btnSave").click(function () {
        //var actualInspectionTime=document.getElementById("actualInspectionTime").value;
        var plannedInspectionTime = document.getElementById("plannedInspectionTime").value;
        var str = "";
        /*   if(actualInspectionTime==""){
           if(str==""){
                      str+="实际检验时间不能为空";
                      }else{
                      str+=",实际检验时间不能为空";
                      }
          } */
        if (plannedInspectionTime == "") {
            if (str == "") {
                str += "计划检验时间不能为空";
            } else {
                str += ",计划检验时间不能为空";
            }
        }
        if (str == "") {
            if ($(".form_input").validationEngine('validate') == true) {
                var currentTime = Date.parse(new Date());
                if (currentTime - lastClickTime > DELAY) {
                    lastClickTime = currentTime;
                    $("#btnSave").attr("disabled", true);
                $(".form_input").ajaxSubmit({
                    type: "post",
                    success: function (data) {
                        if (data.success) {

                                layerMsgSuccess("保存成功", function () {
                                    location.href = "${ctx}/QualityTask.shtml"
                                });


                        } else {
                            layerMsgError("保存失败");
                            $("#btnSave").attr("disabled", false);
                        }
                    }
                });
                }
            }
        } else {
            layer.closeAll(); //疯狂模式，关闭所有层
            layer.open({
                title: '提示信息'
                , content: str
            });
        }

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

    function today() {//构建方法
        var today = new Date();//new 出当前时间
        var h = today.getFullYear();//获取年
        var m = today.getMonth() + 1;//获取月
        var d = today.getDate();//获取日
        var H = today.getHours();//获取时
        var M = today.getMinutes();//获取分
        var S = today.getSeconds();//获取秒
        return h + "-" + m + "-" + d + " " + H + ":" + M + ":" + S; //返回 年-月-日 时:分:秒
    }

    function checkRate() {
        var taskSerial = document.getElementById("taskSerial").value
        var re = new RegExp(/[A-Za-z].*[0-9]|[0-9].*[A-Za-z]/);  //判断字符串是否为数字和字母组合     //判断正整数 /^[1-9]+[0-9]*]*$/
        var b = re.test(taskSerial);

        if (!b) {
            layer.closeAll(); //疯狂模式，关闭所有层
            layer.open({
                title: '提示信息'
                , content: '任务编号由数字和字母组成'
            });
            document.getElementById("taskSerial").value = "";
        } else {
            check();
        }
    }

    function check() {

        var taskSerial = document.getElementById("taskSerial").value;
        $.post("${ctx}/QualityTask/check.shtml", {
            taskSerial: taskSerial
        }, function (result) {
            if (!result.success) {
                layer.closeAll(); //疯狂模式，关闭所有层
                layer.open({
                    title: '提示信息'
                    , content: '任务编号已存在'
                });
                document.getElementById("taskSerial").value = "";
            }
        });
    }

</script>
