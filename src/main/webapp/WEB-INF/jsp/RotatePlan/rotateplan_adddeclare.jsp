<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../common/AdminHeader.jsp" %>

<style>
    select[name="planType"], .layui-form select.block {
        display: inline-block;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>轮换计划</li>
        <li class="active">计划申报</li>
    </ol>
</div>


<div class="container-box clearfix" style="padding: 10px">
    <input hidden="hidden" value="${rotatePlan.id}" id="sid">

    <form class="layui-form" lay-filter="form">
        <div class="layui-row title">
            <h5>填报人信息</h5>

        </div>
        <div class="layui-row" id="edit_info">
            <div class="layui-col-md2">
                <span>经办部门：</span>
                <span data-field="department" name="department">${rotatePlan.department}</span>
            </div>
            <div class="layui-col-md2">
                <span>经办人：</span>
                <span data-field="colletor" name="colletor">${rotatePlan.colletor}</span>
            </div>
            <div class="layui-col-md2">
                <span>经办时间：</span>
                <span name="colletorDate"><fmt:formatDate value="${rotatePlan.colletorDate}"
                                                          pattern="yyyy-MM-dd"/></span>
            </div>
            <div class="layui-col-md2">
                <span>修改人：</span>
                <span data-field="modifier" name="modifier">${rotatePlan.modifier}</span>
            </div>
            <div class="layui-col-md2">
                <span>修改时间：</span>
                <span name="modifyDate"><fmt:formatDate value="${rotatePlan.modifyDate}" pattern="yyyy-MM-dd"/></span>
            </div>
        </div>

        <div class="layui-row title">
            <h5>轮换计划信息</h5>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="text-align: right"><span class="red">*</span>计划年份:</label>
                <div class="layui-input-inline">
                    <input type="text" name="year" lay-verify="required" id="date" lay-filter="year"
                           autocomplete="off" placeholder="请输入年份" class="layui-input form-control"
                           value="${rotatePlan.year}">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" style="text-align: right"><span class="red">*</span>计划类别:</label>
                <div class="layui-input-inline">
                    <select lay-verify="required" id="planType" name="planType" class="layui-select"
                            onchange="updatePlanName()">
                        <option value="01">年度计划</option>
                        <option value="02">超标粮食处置计划</option>
                        <option value="03">补充计划</option>
                    </select>
                </div>
            </div>
        </div>


        <div class="layui-form-item">

            <label class="layui-form-label" style="text-align: right"><span class="red">*</span>计划名称:</label>
            <div class="layui-input-inline">
                <input type="text" name="planName" id="planName" lay-verify="required|textMaxLength" readonly
                       autocomplete="off" placeholder="请输入计划名称" class="layui-input form-control"
                       value="${rotatePlan.planName}">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label" style="text-align: right">计划文件:</label>
            <div class="layui-input-inline">
                <button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="uploadFile" name="file">
                    <i class="layui-icon"></i>上传
                    <%--<c:choose>
                        <c:when test="${rotatePlan.attachment!=null and rotatePlan.attachment!=''}">
                           &lt;%&ndash; ${myFile.fileName}&ndash;%&gt;
                        </c:when>
                        <c:otherwise>
                            <i class="layui-icon"></i>上传
                        </c:otherwise>
                    </c:choose>--%>
                </button>
                <div class="layui-input-inline" id="fileName">
                    <a  href="${ctx }/sysFile/download.shtml?fileId=${myFile.id}"
                       style="color:red;margin:0;">${myFile.fileName }</a>
                </div>
                <div class="layui-input-inline">
                    <a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
                        预览
                    </a>
                    <a href="javascript:openAnnex('${myFile.id}')" id="openFile" style="display: none">
                        预览
                    </a>
                    <%--<button type="button" style="display: none" class="layui-btn layui-btn-primary layui-btn-small" id="openFile" name="File" onclick="openAnnex('${myFile.id}')">预览</button>--%>
                    <input id="clearFileBtn" style="display: none" type="button" value="删除"
                           class="layui-btn layui-btn-primary layui-btn-small"/>
                </div>
            </div>
            <div class="layui-input-inline">
                <input type="text" name="attachment" readonly style="display:none;" id="fileId"
                       autocomplete="off" class="layui-input form-control" value="${rotatePlan.attachment}">
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label" style="text-align: right">备注:</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入内容,最多200个字符" class="layui-textarea" name="description"
                          maxlength="200">${rotatePlan.description}</textarea>
            </div>
        </div>

        <div class="layui-row title">
            <h5>出入库计划明细</h5>
        </div>

        <%--轮入轮出换为页签--%>
        <div class="layui-tab" lay-filter="tab1">
            <ul class="layui-tab-title">
                <li class="layui-this">轮入</li>
                <li>轮出</li>
            </ul>
            <!-- 轮入 -->
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">

                    <table class="layui-table" id="in">
                        <thead>
                            <tr>
                                <td class="layui-col-md1" align="center">轮换类别</td>
                                <td class="layui-col-md1" align="center">粮食品种</td>
                                <td class="layui-col-md1" align="center">收获年份</td>
                                <td class="layui-col-md1" align="center">产地</td>
                                <td class="layui-col-md1" align="center">轮换数量(吨)</td>
                                <td class="layui-col-md1" align="center">等级</td>
                                <td class="layui-col-md1" align="center">操作</td>
                            </tr>
                        </thead>
                        <tbody data-bind="foreach:detailList">
                            <!-- ko if:rotateType() =='轮入' -->
                            <tr data-bind="attr:{'data-index':$index()}">
                                <td data-field="rotateType" class="field" data-bind="text:rotateType" align="left">

                                <span style="color:red" data-bind="text:rotateType"></span>
                                </td>
                                <td data-field="foodType" class="field" align="left">
                                    <select class="layui-select block" data-bind="options:$root.grainTypes,optionsCaption:'--请选择--',
                                                                    value:foodType" lay-verify="required">
                                    </select>
                                </td>
                                <td data-field="yieldTime" class="field" align="left">
                                    <input type="text" lay-verify="required" class="yieldTime"
                                           autocomplete="off" class="layui-input" data-bind="value:yieldTime"
                                           style="width:100px">
                                </td>
                                <td data-field="orign" class="field" align="left">
                                    <input type="text"
                                           autocomplete="off" class="layui-input" oninput="if(value.length>30)value=value.slice(0,30)" data-bind="value:orign">
                                </td>
                                <td data-field="rotateNumber" class="field" align="left">
                                    <input type="number" lay-verify="required|number" autocomplete="off" step="0.001" oninput="if(value.length>10)value=value.slice(0,10)"
                                                         class="layui-input" data-bind="value:rotateNumber" maxlength="10" onchange = "numberFixed(this,3)">
                                </td>
                                <td data-field="qualityId" class="field" align="left">
                                    <select class="layui-select block"
                                            data-bind="options:quotas,optionsCaption:'--请选择--',
                                                       optionsText:'value',optionsValue:'id',
                                                       value:qualityId" style="width:100px">
                                    </select>
                                </td>
                                <td><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini"
                                       data-bind="click:function(){$root.remove($data,$index())}">删除</a></td>
                            </tr>
                            <!-- /ko -->
                        </tbody>
                    </table>
                    <button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="inBtn"
                            data-bind="click:function(){$root.add('轮入')}">
                        <i class="layui-icon">&#xe608;</i> 新增
                    </button>
                </div>

                <div class="layui-tab-item">
                    <table class="layui-table" id="out">
                        <thead>
                            <tr>
                                <td class="layui-col-md1" align="center">轮换类别</td>
                                <td class="layui-col-md1" align="center">粮食品种</td>
                                <td class="layui-col-md1" align="center">收获年份</td>
                                <td class="layui-col-md1" align="center">产地</td>
                                <td class="layui-col-md1" align="center">轮换数量(吨)</td>
                                <td class="layui-col-md1" align="center">操作</td>
                            </tr>
                        </thead>
                        <tbody data-bind="foreach:detailList">
                            <!-- ko if:rotateType() =='轮出' -->
                            <tr data-bind="attr:{'data-index':$index()}">
                                <td data-field="rotateType" class="field" data-bind="text:rotateType" align="left">
                                </td>
                                <td data-field="foodType" class="field" align="left">
                                    <select class="layui-select block" data-bind="options:$root.grainTypes,optionsCaption:'--请选择--',
                                                                    value:foodType" lay-verify="required">
                                    </select>
                                </td>
                                <td data-field="yieldTime" class="field" align="left">
                                    <input type="text" lay-verify="required" class="yieldTime"
                                           autocomplete="off" class="layui-input" data-bind="value:yieldTime"
                                           style="width:100px">
                                </td>
                                <td data-field="orign" class="field" align="left">
                                    <input type="text"
                                           autocomplete="off" class="layui-input" oninput="if(value.length>30)value=value.slice(0,30)" data-bind="value:orign">
                                </td>
                                <td align="left" data-field="rotateNumber">
                                    <input type="number" lay-verify="required|number" autocomplete="off" step="0.001" oninput="if(value.length>10)value=value.slice(0,10)"
                                                         class="layui-input" data-bind="value:rotateNumber" maxlength="10" onchange = "numberFixed(this,3)">
                                </td>
                                <td><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini"
                                       data-bind="click:function(){$root.remove($data,$index())}">删除</a></td>
                            </tr>
                            <!-- /ko -->
                        </tbody>
                    </table>
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="outBtn"
                            data-bind="click:function(){$root.add('轮出')}">
                        <i class="layui-icon">&#xe608;</i> 新增
                    </button>
                </div>
            </div>
        </div>



        <div class="layui-row text-center">
            <c:if test="${!isEdit }">
                <div class="layui-col-md12" id="operation">
                    <button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small "
                            lay-filter="save" data-status="未提交">保存
                    </button>
                    <%--<button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small "
                            lay-filter=save data-status="OA流程">提交
                    </button>--%>
                    <button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small "
                            lay-filter=save data-status="待审核">提交
                    </button>
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.cancel('取消');}">取消
                    </button>
                </div>
            </c:if>
            <c:if test="${isEdit}">
                <div class="layui-col-md12" id="operation">
                    <button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small "
                            lay-filter="save">保存
                    </button>
                    <!-- 				<button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small " lay-filter=save data-status="审核通过">通过</button> -->
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.cancel('返回');}">返回
                    </button>
                </div>
            </c:if>
        </div>

    </form>

</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>
<script src="${ctx}/js/app/rotateplan/addPlandeclare.js"></script>
<script type="text/html" id="enableDate">
    {{Date_format(d.enableDate,true)}}
</script>
<script>

    layui.use("form",function () {
        let form = layui.form;

        form.verify({

            numberMaxLength:function (value) {
                if(value.length > 10){
                    return "请输入10位以下数字";
                }
            },

            textMaxLenght:function (value) {
                if(value.length > 30){
                    return "请输入30位以下数字";
                }
            }

        });

    });

    if ("${rotatePlan.attachment}" != "") {
        $("#clearFileBtn").css("display", "");
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}' == 'docx'||'${suffix}' == 'doc'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }


    }
    $("#clearFileBtn").click(function () {
        $("input#fileId").val("");
        $("#fileName").html("");
        $("#uploadFile").html("<i class=\"layui-icon\"></i>上传");
        $("#clearFileBtn").css("display", "none").parent().find("a").html("");
        $("#openFile").css("display", "none").parent().find("a").html("");
        $("#openExcel").css("display", "none").parent().find("a").html("");
    });

    var isedit =${isEdit};
    var id = '${rotatePlan.id}' || 0;
    var grainTypes = ${cf:toJSON(grainTypes)};
    var quotas = ${cf:toJSON(quotas)};
    var grainLevel = ${cf:toJSON(grainLevel)};
    var oilLevel = ${cf:toJSON(oilLevel)};

    var detailList = null;
    if('${detailList}' != ''){
        detailList = JSON.parse('${detailList}');
    }

    //alert(JSON.stringify(detailList));
    if (isedit) {
        $('.layui-form-item [name="planType"]').val("${rotatePlan.planType}");

    }
    var vm = new Add(isedit, id, detailList, quotas,grainTypes,grainLevel,oilLevel);

    ko.applyBindings(vm, $(".container-box")[0]);
    vm.initPage();
    UploadFile();

    function updatePlanName() {
        var year = $("#date").val();
        if ($('#planType').val() == '01') {
            $('#planName').attr("readonly", true);
            $('#planName').val(year + "年度轮换计划");
        } else if($('#planType').val() == '02'){
            $('#planName').attr("readonly", false);
            $('#planName').val(year + "超标粮食处置计划");
        } else if($('#planType').val() == '03'){
            $('#planName').attr("readonly", false);
            $('#planName').val(year + "补充计划");
        }
    }
    function numberFixed(obj,op){
        number = $(obj).val();
        if(number==null ||number =="" ){
            return
        }
        number = parseFloat(number).toFixed(op);
        $(obj).val(number);
    }



</script>
<%@include file="../common/AdminFooter.jsp" %>