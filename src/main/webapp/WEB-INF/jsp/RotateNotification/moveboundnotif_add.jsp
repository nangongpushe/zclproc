<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<style type="text/css">
    #outSide {
        width: 94%;
        margin-left: 2%;
        padding: 1%;
        background: #fff;
        border-top: 2px solid #23b7e5;
    }

    .infoArea {
        width: 100%;
        padding: 20px 0;
        border-bottom: 2px solid #e2e2e2;
    }

    .title {
        color: #23b7e5;
        font-weight: bold;
    }

    #infoArea {
        margin-top: 20px;
        margin-left: 4%;
    }

    #infoArea span {
        padding-right: 100px;
    }

    .requiredData {
        color: red;
    }

    #mainInfo {
        margin-top: 20px;
        margin-left: 2.5%;
    }

    #mainInfo > div {
        padding: 10px 0;
        width: 100%;
    }

    #mainInfo > div span {
        width: 10%;
        display: inline-block;
        text-align: center;
    }

    .inputArea {
        width: 89%;
        padding: 5px;
        outline: none;
        border: 1px solid #ccc;
        resize: none;
    }

    .buttonArea {
        padding: 5px 15px;
        background: #009688;
        border: none;
        color: #fff;
        cursor: pointer;
        display: inline;
    }

    #listArea {
        padding: 20px 0;
        width: 100%;
    }

    table {
        margin-top: 20px;
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }

    thead {
        background: #eee;
    }

    table tr td {
        width: 9%;
        border: 1px solid #e2e2e2;
        padding: 10px 0;
    }

    tbody tr {
        border-bottom: 1px solid #ccc;
    }

    #bottom-button {
        text-align: right;
        padding-right: 20px;
        margin-top: 20px;
    }

    #bottom-button > div {
        margin-right: 10px;
    }

    #template-tr {
        display: none;
    }

    #float-alert {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: RGBA(0, 0, 0, 0.75);
        z-index: 2;
        display: none;
    }

    #table-wapper {
        display: none;
        margin: 0 auto;
        margin-top: 150px;
        background: #fff;
        border-top: 1px solid RGB(42, 180, 168);
        padding: 1%;
        width: 75%;
        height: 550px;
    }

    #table-wapper table {
        margin: 0;
    }

    #table-wapper table td:first-child {
        width: 3%;
    }

    #close-float-alert {
        position: relative;
        left: 88.5%;
        font-size: 30px;
        color: RGB(42, 180, 168);
        cursor: pointer;
    }

    #schemeDetail-data-list input[type=checkbox] {
        width: 30%;
        outline: none;
    }

    #out-table {
        height: 310px;
        overflow: auto;
        margin-top: 20px;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>通知书管理</li>
        <li>移库通知书</li>
        <li class="active">${notice.id ne null?'编辑':'新增' }移库通知书</li>
    </ol>
</div>
<div id="outSide">
    <form action="${ctx }/RotateNotif/Add.shtml" method="Post" enctype="multipart/form-data" class="layui-form">
        <div id="dataArea" class="infoArea">
            <span class="title">移库通知书信息</span>
            <div id="mainInfo">
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>轮换类别：</span>
                    <div class="layui-input-inline inputArea" style="border: 0">
                    <select class="inputArea" id="rotate-type" name="rotateType">
                        <option <c:if test="${notice.rotateType eq '常规轮换'}">selected="selected"</c:if>>常规轮换</option>
                        <option <c:if test="${notice.rotateType eq '因灾受损'}">selected="selected"</c:if>>因灾受损</option>
                    </select>
                    </div>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>文号：</span>
                    <input name="documentNumber" autocomplete="off" class="inputArea" value="${notice.documentNumber }" maxlength="45">
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>通知书编号：</span>
                    <input class="inputArea" autocomplete="off" type="text" value="${notice.noticeSerial }"
                           placeholder="格式:年份-编号  例：2018-1" name="noticeSerial" maxlength="15" readonly="readonly">

                </div>
                <div>

                    <span style="text-align:right"><b class="requiredData">*</b>接收单位：</span>
                    <div class="layui-input-inline inputArea" style="border: 0">
                    <select class="inputArea" id="accepte-unit" name="storeEnterprise.id" lay-search onchange="searchJiaoyi(this)">

                        <option value="">--请选择--</option>
                        <c:forEach items="${basepoint }" var="point">
                            <option
                                    <c:if test="${notice.storeEnterprise.id eq point.id }">selected</c:if>
                                    enterpriseId="${point.id}" value="${point.id}"
                                <%--warehouseId="${point.id}"--%>
                            >${point.enterpriseName }</option>
                        </c:forEach>
                    </select>
                    </div>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>移库截止时间：</span>
                    <input id="storage-date" name="storageDate" autocomplete="off" class="inputArea" type="text"
                           value="<fmt:formatDate value="${notice.storageDate }" pattern="yyyy-MM-dd"/>"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>签发单位负责人：</span>
                    <input id="sender" name="sender" class="inputArea"
                           <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if> type="text"
                           value="${notice.sender }" maxlength="10"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>审核：</span>
                    <input id="audit" name="audit" class="inputArea"
                           <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if> type="text"
                           value="${notice.audit }" maxlength="10"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>经办人：</span>
                    <input id="creater" name="creater" class="inputArea" type="text" value="${notice.creater }"
                           disabled="disabled"/>
                </div>
            </div>
        </div>
        <div id="listArea">
            <div class="buttonArea" id="add-list">新增</div>
            <table>
                <thead>
                <tr>
                    <td>品种</td>
                    <td>移出单位</td>
                    <td>移入单位</td>
                    <td>储存库点</td>
                    <td>计划数(吨)</td>
                    <td>实际数(吨)</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody id="data-result">
                <tr id="template-tr">
                    <td name="variety">
                        <select class="inputArea" disabled>
                            <c:forEach items="${varietyList }" var="varietyList">
                                <option>${varietyList.value }</option>
                            </c:forEach>
                        </select>
                        <%--<input style="width: 80%" class="inputArea"/>--%>
                    </td>
                    <td name="removalUnit">
                        <input style="width: 80%" class="inputArea" maxlength="25"/>
                    </td>
                    <td name="immigrationUnit">
                        <input style="width: 80%" class="harvestYear-input inputArea" maxlength="25"/>
                    </td>
                    <td name="storageWarehouse">
                        <select class="inputArea">
                            <c:forEach items="${warehouse }" var="point">
                                <option>${point.warehouseShort}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td name="planNumber">
                        <input style="width: 80%" type="number" class="inputArea" oninput="if(value.length>15)value=value.slice(0,15)"
                               onchange="numberFixed(this,3)"/>
                    </td>
                    <td name="actualNumber">
                        <input style="width: 80%" type="number" class="inputArea" oninput="if(value.length>15)value=value.slice(0,15)"
                               onchange="numberFixed(this,3)"/>
                    </td>
                    </td>
                    <td>
                        <div class="buttonArea remove-detail">删除</div>
                    </td>
                </tr>
                <c:forEach items="${notice.noticeDetail }" var="item">
                    <tr class="data-tr" tag="${item.dealSerial }">
                        <td name="variety">
                            <select class="inputArea" readonly="readonly" disabled>
                                <c:forEach items="${varietyList }" var="varietyList">
                                    <option
                                            <c:if test="${item.variety eq varietyList.value}">selected</c:if>>${varietyList.value }</option>
                                </c:forEach>
                            </select>
                                <%--<input style="width: 80%" class="inputArea" value="${item.variety}"/>--%>
                        </td>
                        <td name="removalUnit"><input style="width: 80%" class="inputArea" value="${item.removalUnit }" maxlength="25">
                        </td>
                        <td name="immigrationUnit"><input style="width: 80%"
                                                          class="inputArea" value="${item.immigrationUnit }" maxlength="25"></td>
                        <td name="storageWarehouse" warehouseId="${item.warehouse.id}">
                            <select class="inputArea">
                                <c:forEach items="${warehouse }" var="point">
                                    <option
                                            <c:if test="${item.warehouse.id eq point.id}">selected</c:if>>${point.warehouseShort }</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td name="planNumber">
                            <input style="width: 80%" type="number" class="inputArea" value="${item.planNumber }"
                                   onchange="numberFixed(this,3)" oninput="if(value.length>15)value=value.slice(0,15)">
                        </td>
                        <td name="actualNumber">
                            <input style="width: 80%" type="number" class="inputArea" value="${item.actualNumber }"
                                   onchange="numberFixed(this,3)" oninput="if(value.length>15)value=value.slice(0,15)">
                        </td>
                        <c:if test="${notice.status ne '已完成' }">
                            <td>
                                <div class="buttonArea remove-detail">删除</div>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div id="bottom-button">
                <div class="buttonArea" id="save">
                    <c:choose>
                        <c:when test="${notice.id != null }">
                            编辑
                        </c:when>
                        <c:otherwise>
                            保存
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="buttonArea" id="submit">提交</div>
                <div class="buttonArea" id="cancel">取消</div>
            </div>
        </div>
    </form>
</div>
<div id="float-alert">
    <div id="table-wapper">
        <span class="title">明细选择</span>
        <i id="close-float-alert" class="layui-icon">&#x1006;</i>
        <div style="margin-top:2%;padding-bottom:2%;border-bottom:1px solid #ccc">
            <form id="concluteForm" action="${ctx }/rotateConclute/ListDetail.shtml" method="POST">
                <input type="hidden" name="noticeType" value="入库">
                <%--成交明细号：
                <select name="sid" style="width:50%;" class="inputArea">
                <c:forEach items="${concluteList}" var="conclute">
                    <option value="${conclute.id }">${conclute.dealSerial }</option>
                </c:forEach>
                </select>--%>
                粮食品种：
                <select name="grainType" id="filter-grainType" style="width:15%;" class="inputArea">
                    <option value="">全部</option>
                    <c:forEach items="${varietyList }" var="item">
                        <option value="${item.value }">${item.value }</option>
                    </c:forEach>
                </select>
                库点：
                <select name="receivePlace" id="filter-receivePlace" style="width:15%;" class="inputArea">
                    <option value="">全部</option>
                    <c:forEach items="${warehouse }" var="point">
                        <option value="${point.warehouseShort }" warehouseId="${point.id}">${point.warehouseShort }</option>
                    </c:forEach>
                </select>
                <%-- 库点类型：
                 <select id="filter-receivePlaceType" style="width:15%;" class="inputArea" style="display:none">
                     <option value="">全部</option>
                     <option value="直属单位">直属单位</option>
                     <option value="代储库">代储库</option>
                 </select>--%>
                收获年份：
                <input name="warehoueYear" id="filter-warehoueYear" style="width:15%;" class="inputArea"/>
                仓号：
                <input name="storehouse" id="filter-storehouse" style="width:15%;" class="inputArea"/><br/>
                <div><br>
                    计划数：
                    <input name="quantity" id="filter-quantity" style="width:15%;" class="inputArea"/>
                    <div id="concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div>
                    <div class="buttonArea" id="select-button1" onclick="chongzi();">重置</div>
                </div>
            </form>
            <%--<div style="margin:10px 0">
                粮食品种：
                &lt;%&ndash;<input id="filter-grainType" style="width:15%;" class="inputArea"/>&ndash;%&gt;
                <select name="variety" id="filter-grainType" style="width:15%;" class="inputArea" style="display:none">
                    <option></option>
                    <c:forEach items="${varietyList }" var="item">
                        <option value="${item.value }">${item.value }</option>
                    </c:forEach>
                </select>
                库点：
                <select id="filter-receivePlace" style="width:15%;" class="inputArea">
                    <option value="">全部</option>
                <c:forEach items="${basepoint }" var="point">
                    <option>${point }</option>
                </c:forEach>
                </select>
                收获年份：
                <input id="filter-warehoueYear" style="width:15%;" class="inputArea"/>
                仓号：
                <input id="filter-storehouse" style="width:15%;" class="inputArea"/>
                计划数：
                <input id="filter-quantity" style="width:15%;" class="inputArea"/>
                <div id="filter-concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div>
            </div>--%>
            <form id="out-table">
                <table>
                    <thead>
                    <tr>
                        <td>选择</td>
                        <td>成交明细号</td>
                        <td>品种</td>
                        <td>成交金额</td>
                        <td>收获年份</td>
                        <td>存储库点</td>
                        <td>仓号</td>
                        <td>计划数</td>
                    </tr>
                    <tr id="conclute-template" style="display:none">
                        <td><input type="checkbox" name=""></td>
                        <td align="left" name="dealSerial"></td>
                        <td align="left" name="grainType"></td>
                        <td align="right" name="dealPrice"></td>
                        <td name="warehoueYear"></td>
                        <td align="left" name="receivePlace"></td>
                        <td align="left" name="storehouse"></td>
                        <td align="right" name="quantity"></td>
                    </tr>
                    </thead>
                    <tbody id="schemeDetail-data-list">

                    </tbody>
                </table>
            </form>
            <div style="text-align:right;margin-top:20px;">
                <div class="buttonArea" id="add-tolist">添加</div>
            </div>
        </div>
    </div>
    <script>
        layui.form.render("select");

        var noticeSerialValue = "${notice.noticeSerial}";
        var laydate = layui.laydate;
        laydate.render({
            elem: "#storage-date",
            type: "date",
            format: "yyyy-MM-dd",
        });

        laydate.render({
            elem: ".harvestYear-input",
            type: "year",
            format: "yyyy",
        });
        laydate.render({
            elem: "#filter-warehoueYear",
            type: "year",
            format: "yyyy",
        });
        var lastClickTime = 0;
        var lastClickTime1 = 0;
        var DELAY = 20000;
        $("#save,#submit").click(function () {
            // 隐藏按键
            $("#save,#submit").hide();

            var patchAll = true;
            $(".requiredData").parent().parent().find("input,select").each(function () {
                if ($(this).val() == "") {
                    alert("*项为必填项,请补全相关信息");
                    patchAll = false;
                    return false;
                }
            });
            if (!patchAll) {
                $("#save,#submit").show();
                return;
            }
            var detailData = [];
            if ($(".data-tr").length == 0) {
                layer.msg("明细至少需要有一条", {icon: 0});
                $("#save,#submit").show();
                return;
            }
            var immigrationUnit = $(".data-tr").eq(0).find("td[name='immigrationUnit']").find("input").val();
            var canPass = true;
            $(".data-tr").each(function () {
                if (immigrationUnit != $(this).find("td[name='immigrationUnit']").find("input").val()) {
                    layer.msg("移入单位需保持一致", {icon: 0});
                    canPass = false;
                    return false;
                }
                detailData.push({
                    "dealSerial": $(this).attr("tag") == "" ? 0 : $(this).attr("tag"),
                    "variety": $(this).find("td[name='variety']").find("select").val().trim(),
                    "removalUnit": $(this).find("td[name='removalUnit']").find("input").val(),
                    "immigrationUnit": $(this).find("td[name='immigrationUnit']").find("input").val(),
                    "storageWarehouse": $(this).find("td[name='storageWarehouse']").find("select").val(),
                    "warehouse": {"id":$(this).find("td[name='storageWarehouse']").attr('warehouseId')},
                    "planNumber": $(this).find("td[name='planNumber']").find("input").val(),
                    "actualNumber": $(this).find("td[name='actualNumber']").find("input").val(),
                });
            });
            if (!canPass)
                return;
            if ($(this).html().indexOf('保存') != -1) {
                var currentTime = Date.parse(new Date());
                if (currentTime - lastClickTime > DELAY) {
                    lastClickTime = currentTime;
                    $("#save").hide()
                    $("form").ajaxSubmit({
                        type: "post",
                        data: {
                            "detailList": JSON.stringify(detailData),
                            "noticeType": "移库",
                            "status": "待提交"
                        },
                        success: function (data) {
                            if (data.success) {
                                layer.msg("保存成功", {icon: 1}, function () {
                                    window.location.href = "${ctx}/RotateNotif/Move.shtml?type=Warehouse";
                                });
                            } else {
                                layer.msg("保存失败", {icon: 2})
                                $("#save,#submit").show();
                            }
                        }
                    });
                }
            } else if ($(this).html().indexOf('提交') != -1) {
                var currentTime = Date.parse(new Date());
                if (currentTime - lastClickTime1 > DELAY) {
                    lastClickTime1 = currentTime;
                    $("#submit").hide();
                    var way = $("#save").html().indexOf("保存") != -1 ? "${ctx }/RotateNotif/Add.shtml" : "Edit.shtml";
                    $("form").ajaxSubmit({
                        url: way,
                        type: "post",
                        data: {
                            "id": "${notice.id }",
                            "noticeType": "移库",
                            "detailList": JSON.stringify(detailData),
                            "status": "待审核",
                        },
                        success: function (data) {
                            if (data.success) {
                                layer.msg("信息提交成功", {icon: 1}, function () {
                                    window.location.href = "${ctx}/RotateNotif/Move.shtml?type=Warehouse";
                                });
                            } else {
                                layer.msg("信息提交失败", {icon: 2})
                                $("#save,#submit").show();
                            }
                        }
                    });
                }
            } else if ($(this).html().indexOf('编辑') != -1) {
                var currentTime = Date.parse(new Date());
                if (currentTime - lastClickTime > DELAY) {
                    lastClickTime = currentTime;
                    $("#save").hide();
                    $("form").ajaxSubmit({
                        url: "Edit.shtml",
                        data: {
                            "detailList": JSON.stringify(detailData),
                            "id": "${notice.id}"
                        },
                        type: "post",
                        success: function (data) {
                            if (data.success) {
                                layer.msg("保存成功", {icon: 1}, function () {
                                    window.location.href = "${ctx}/RotateNotif/Move.shtml?type=Warehouse";
                                })
                            } else {
                                layer.msg("保存失败", {icon: 2})
                                $("#save,#submit").show();
                            }
                        }
                    });
                }
            } else {
                $("#save,#submit").show();
                return false;
            }
        });

        $("#add-list").click(function () {
            // var enterpriseId = $('#accepte-unit').find("option:selected").attr('enterpriseId');
            // var warehouseId = $('#accepte-unit').find("option:selected").attr('warehouseId');
            // var accepteUnit = $('#accepte-unit').find("option:selected").text();

            if ($("#rotate-type").val() == '因灾受损') {
                var template = $("#template-tr").clone(true);
                $(template).find("td[name='variety']").find("select").removeAttr("disabled");
                $(template).find("td[name='removalUnit']").find("input").val();

                let immigrationUnit;
                if ($("#accepte-unit option:selected").val() != null && $("#accepte-unit option:selected").val() != '')
                    immigrationUnit = $("#accepte-unit option:selected").html();
                $(template).find("td[name='immigrationUnit']").find("input").val(immigrationUnit);

                $(template).find("td[name='storageWarehouse']").find("select");
                $(template).addClass("data-tr");
                $("#data-result").append($(template));
                $(template).slideToggle(500);
            } else if ($("#rotate-type").val() == '常规轮换') {
                $("#float-alert").slideToggle(500, function () {
                    $("#table-wapper").slideToggle(500);
                });
            }
            layui.form.render("select");
            $("#concluteButton").click();
        });

        $(".remove-detail").click(function () {
            $(this).parent().parent().hide(500, function () {
                $(this).remove();
            });
        });

        $("#close-float-alert").click(function () {
            $("#table-wapper").slideToggle(500, function () {
                $("#float-alert").slideToggle(500, function () {
                    $("#schemeDetail-data-list").find("tr").remove();
                });
            });
        });

        $("#accepte-unit").change(function () {
            debugger
            let value = "";
            if ($(this).find("option:selected").val() != null && $(this).find("option:selected").val() != "")
                value = $(this).find("option:selected").html();

            $(".data-tr").each(function () {
                $(this).find("td[name='immigrationUnit']").find("input").val(value);
            });
        });

        $("#add-tolist").click(function () {
            $("#schemeDetail-data-list").find("input[type='checkbox']").each(function () {
                if ($(this).prop("checked")) {
                    var trdata = $(this).parent().parent();
                    if ($(".data-tr[tag='" + $(trdata).attr("tag") + "']").length > 0)
                        return;
                    var template = $("#template-tr").clone(true);
                    $(template).attr("tag", $(trdata).attr("tag"));
                    $(template).find("td[name='variety']").find("select").val($(trdata).find("td[name='grainType']").html());
                    $(template).find("td[name='variety']").find("select").attr("disabled", true);
                    $(template).find("td[name='removalUnit']").find("input").val($(trdata).find("td[name='receivePlace']").html());
                    $(template).find("td[name='immigrationUnit']").find("input").val($("#accepte-unit").val() == "" ? "" : $("#accepte-unit option:selected").html());
                    $(template).find("td[name='storageWarehouse']").find("select").find("option").remove();
                    $(template).find("td[name='storageWarehouse']").find("select").append("<option>" + $(trdata).find("td[name='receivePlace']").html() + "</option>");
                    $(template).find("td[name='storageWarehouse']").attr("warehouseId",$(trdata).find("td[name='receivePlace']").attr("warehouseId")).find("select").attr("readonly", "readonly");
                    $(template).find("td[name='planNumber']").find("input").val($(trdata).find("td[name='quantity']").html())
                    $(template).addClass("data-tr");
                    $("#data-result").append($(template));
                    $(template).slideToggle(500);
                    layui.form.render();
                }
            });
            $("#close-float-alert").click();
        });

        $("#concluteButton").click(function () {
            var index = layer.load(1);
            $("#concluteForm").ajaxSubmit({
                success: function (data) {
                    layer.close(index);
                    $("#schemeDetail-data-list").find("tr").remove();
                    for (var i = 0; i < data.length; i++) {
                        var dataMode = $("#conclute-template").clone(true);
                        $(dataMode).attr("tag", data[i]["dealSerial"]);
                        $(dataMode).find("td[name='dealSerial']").html(data[i]["dealSerial"]);
                        $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
                        $(dataMode).find("td[name='dealPrice']").html(data[i]["dealAmount"]);
                        $(dataMode).find("td[name='warehoueYear']").html(data[i]["warehoueYear"]);
                        $(dataMode).find("td[name='receivePlace']").html(data[i]["receivePlace"]).attr("warehouseId",data[i]["receiveId"]);
                        $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);
                        $(dataMode).find("td[name='quantity']").html(data[i]["quantity"]);
                        $("#schemeDetail-data-list").append($(dataMode));
                        $(dataMode).show();
                    }
                }
            });
        });

        $("#filter-concluteButton").click(function () {
            var grainType = $("#filter-grainType").val();
            var receivePlace = $("#filter-receivePlace").val();
            var warehoueYear = $("#filter-warehoueYear").val();
            var storehouse = $("#filter-storehouse").val();
            var quantity = $("#filter-quantity").val();
            $("#schemeDetail-data-list").find("input[type='checkbox']").each(function () {
                var trdata = $(this).parent().parent();
                var tempgrain = $(trdata).find("td[name='grainType']").html();
                var tempreceive = $(trdata).find("td[name='receivePlace']").html();
                var tempwarehoueYear = $(trdata).find("td[name='warehoueYear']").html();
                var tempstorehouse = $(trdata).find("td[name='storehouse']").html();
                var tempquantity = $(trdata).find("td[name='quantity']").html();
                if (tempgrain.indexOf(grainType) == -1) {
                    $(trdata).hide();
                    return;
                } else if (tempreceive.indexOf(receivePlace) == -1) {
                    $(trdata).hide();
                    return;
                } else if (tempwarehoueYear.indexOf(warehoueYear) == -1) {
                    $(trdata).hide();
                    return;
                } else if (tempstorehouse.indexOf(storehouse) == -1) {
                    $(trdata).hide();
                    return;
                } else if (tempquantity.indexOf(quantity) == -1) {
                    $(trdata).hide();
                    return;
                }
                $(trdata).show();
            });
        });

        $("#cancel").click(function () {
            layer.confirm('你确定要放弃编辑吗？', {
                btn: ['是', '否']
            }, function () {
                window.location.href = "${ctx}/RotateNotif/Move.shtml?type=Warehouse";
            }, function () {

            });
        });

        $('input[name="noticeSerial"]').blur(function () {
            if ($(this).val() == '')
                return;
            var expressionOne = /\d{4}-\d/;
            var expressionTwo = /^〔\d{4}〕[0-9]{1,}号$/;
            if (!expressionOne.test($(this).val()) && !expressionTwo.test($(this).val())) {
                layer.msg("请按照格式输入，格式为：年份-编号");
                $(this).val('');
                return;
            } else if (!expressionTwo.test($(this).val())) {
                var formatStr = $(this).val().split('-');
                $(this).val('〔' + formatStr[0] + '〕' + formatStr[1] + '号');
            }

            // 判断通知书编号是否存在
            var noticeSerialVal = $(this).val();
            if (noticeSerialValue == noticeSerialVal)
                return;
            let url = "${ctx}/RotateNotif/isRotateNotif.shtml";
            $.ajax({
                url: url,
                contentType: "application/json",
                type: "post",
                data: '{"noticeSerial":"' + noticeSerialVal + '", "type":"move"}',
                success: function (data) {
                    if (data.success) {
                        if (!data.data) {
                            // 如果存在
                            layer.msg("通知书编号已存在");
                            $("input[name=\"noticeSerial\"]").val('');
                            return;
                        }
                    } else {

                    }
                }
            });
        });

        function chongzi() {
            document.getElementById("concluteForm").reset();
            $("#concluteForm").ajaxSubmit({
                success: function (data) {
                    $("#schemeDetail-data-list").find("tr").remove();
                    for (var i = 0; i < data.length; i++) {
                        var dataMode = $("#conclute-template").clone(true);
                        $(dataMode).attr("tag", data[i]["dealSerial"]);
                        $(dataMode).find("td[name='dealSerial']").html(data[i]["dealSerial"]);
                        $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
                        $(dataMode).find("td[name='dealPrice']").html(data[i]["dealPrice"]);
                        $(dataMode).find("td[name='warehoueYear']").html(data[i]["warehoueYear"]);
                        $(dataMode).find("td[name='receivePlace']").html(data[i]["receivePlace"]);
                        $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);
                        $(dataMode).find("td[name='quantity']").html(data[i]["quantity"]);
                        $("#schemeDetail-data-list").append($(dataMode));
                        $(dataMode).show();
                    }
                }
            });
        };

        function searchJiaoyi(o) {

        }

        function numberFixed(obj, op) {
            number = $(obj).val();
            if (number == null || number == "") {
                return
            }
            number = parseFloat(number).toFixed(op);
            $(obj).val(number);
        }
    </script>
<%@ include file="../common/AdminFooter.jsp" %>