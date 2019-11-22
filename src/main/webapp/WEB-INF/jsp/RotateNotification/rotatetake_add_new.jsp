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
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: RGBA(0, 0, 0, 0.75);
        z-index: 400;
        display: none;
    }

    #table-wapper {
        display: none;
        margin: 0 auto;
        margin-top: 100px;
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
        width: 50%;
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
        <li>提货单</li>
        <li class="active">
            <c:choose>
                <c:when test="${take.id != null }">编辑</c:when>
                <c:otherwise>新增</c:otherwise>
            </c:choose></li>
    </ol>
</div>
<div id="outSide">
    <div id="userInfo" class="infoArea">
        <span class="title">填报人信息</span>
        <div id="infoArea">
            <span>经办人：${name }</span>
            <span name='createDate'>经办时间：<span><fmt:formatDate value="${take.createDate }" pattern="yyyy-MM-dd"/></span></span>
        </div>
    </div>
    <form action="#" method="Post" enctype="multipart/form-data" class="layui-form">
        <div id="dataArea" class="infoArea">
            <span class="title">提货单信息</span>
            <div id="mainInfo">
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>提货单编号：</span>
                    <input name="serial" readonly class="inputArea" value="${take.serial }"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>接收库点：</span>
                    <div class="layui-input-inline inputArea" style="border: 0">
                        <select id="reserveUnit" lay-search name="receiveWarehouseId" lay-filter="warehouse">
                            <option value="">--请选择--</option>
                            <c:forEach items="${basepoint }" var="point">
                                <option
                                        <c:if test="${point.id == take.receiveWarehouseId}">selected</c:if>
                                        value="${point.id}">${point.warehouseShort }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div>
                    <span style="text-align:right">库点联系人：</span>
                    <input name="warehouseContactor" class="inputArea" value="${take.warehouseContactor }" type="text"
                           placeholder="自动带出"/>
                </div>
                <div>
                    <span style="text-align:right">库点联系电话：</span>
                    <input name="warehouseTel" class="inputArea" value="${take.warehouseTel }" type="text"
                           placeholder="自动带出"/>
                </div>
                <%--<div style="display:none">--%>
                <%--<input name="takeEnd" class="inputArea" value="${take.takeEnd }" readonly/>--%>
                <%--<input name="buyer" class="inputArea" value="${take.buyer }"/>--%>
                <%--</div>--%>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>承储单位联系方式：</span>
                    <input name="enterpriseTel" class="inputArea" value="${take.enterpriseTel }"/>
                </div>
                <%--<div>--%>
                <%--<span style="text-align:right"><b class="requiredData">*</b>接收单位：</span>--%>
                <%--<input name="customer" class="inputArea" value="${take.acceptanceUnit }"/>--%>
                <%--</div>--%>
                <%--<div>--%>
                <%--<span style="text-align:right"><b class="requiredData">*</b>联系方式：</span>--%>
                <%--<input name="customerTel" class="inputArea" value="${take.telephone }" lay-verify="customPhone1"--%>
                <%--onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]"--%>
                <%--min="0"/>--%>
                <%--</div>--%>
            </div>
        </div>
        <div id="listArea">
            <c:if test="${take.status ne '已完成' }">
                <div class="buttonArea" id="add-list">新增</div>
            </c:if>
            <table>
                <thead>
                <tr>
                    <td style="width: 8%">成交子明细号</td>
                    <td style="width: 8%">接受单位</td>
                    <td style="width: 8%">联系方式</td>
                    <td style="width: 8%">仓号</td>
                    <td style="width: 8%">品种</td>
                    <td style="width: 8%">粮食单价(元/吨)</td>
                    <td style="width: 8%">存储方式</td>
                    <td style="width: 8%">合同数量(吨)</td>
                    <td style="width: 8%">已开提货单(吨)</td>
                    <td style="width: 8%">本次发货（吨）</td>
                    <td style="width: 10%">累计已开提货单(吨)</td>
                    <td style="width: 8%">操作</td>
                </tr>
                </thead>
                <tbody id="data-result">
                <tr id="template-tr">
                    <td name="id" style="display: none"></td>
                    <td name="dealSerial" style="width: 8%"></td>
                    <td name="acceptanceUnit" style="width: 8%"></td>
                    <td name="telephone" style="width: 8%"></td>
                    <td name="storeEncode" style="width: 8%"></td>
                    <td name="variety" style="width: 8%"></td>
                    <td name="unitPrice" style="width: 8%"></td>
                    <td name="storageMode" style="width: 8%"></td>
                    <td name="contract" style="width: 8%"></td>
                    <td name="ladingBills" style="width: 8%"></td>
                    <td name="thisShipment" style="width: 8%"><input class="inputArea" type="number"
                                                                     onchange="calculate(this)"/></td>
                    <td name="accumulatedBills" style="width: 8%"></td>
                    <td><span class="buttonArea remove-detail" style="width: 8%">删除</span></td>
                </tr>
                <c:forEach items="${take.rotateTakes }" var="item">
                    <tr class="data-tr">
                        <td name="id" style="display: none">${item.id}</td>
                        <td name="dealSerial" style="width: 8%">${item.dealSerial}</td>
                        <td name="acceptanceUnit" tag="${item.acceptanceUnitId}"
                            style="width: 8%">${item.acceptanceUnit}</td>
                        <td name="telephone" style="width: 8%">${item.telephone}</td>
                        <td name="storeEncode" style="width: 8%">${item.storeEncode}</td>
                        <td name="variety" style="width: 8%">${item.variety}</td>
                        <td name="unitPrice" style="width: 8%">${item.unitPrice}</td>
                        <td name="storageMode" style="width: 8%">${item.storageMode}</td>
                        <td name="contract" style="width: 8%">${item.contract}</td>
                        <td name="ladingBills" style="width: 8%">${item.ladingBills}</td>
                        <td name="thisShipment" style="width: 8%"><input class="inputArea" type="number"
                                                                         value="${item.thisShipment}"
                                                                         onchange="calculate(this)"/></td>
                        <td name="accumulatedBills" style="width: 8%">${item.accumulatedBills}</td>
                        <td><span class="buttonArea remove-detail" style="width: 8%">删除</span></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div id="bottom-button">
                <div class="buttonArea" id="save">
                    <c:choose>
                        <c:when test="${take.id != null }">编辑</c:when>
                        <c:otherwise>保存</c:otherwise>
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
                <input type="hidden" name="noticeType" value="出库">
                粮食品种：
                <select name="grainType" id="filter-grainType" style="width:15%;" class="inputArea"
                        style="display:none">
                    <option value="">全部</option>
                    <c:forEach items="${varietyList }" var="item">
                        <option value="${item.value }">${item.value }</option>
                    </c:forEach>
                </select>

                <input name="isOut" type="hidden" value="1"/>
                <input name="noticeType" type="hidden" value="出库">
                <input name="isCompletionDeal" type="hidden" value="true"/>
                <input name="receivePlace" type="hidden"/>
                <input name="deliveryId" type="hidden">
                收获年份：
                <input name="warehoueYear" id="filter-warehoueYear" style="width:15%;" class="inputArea"/>
                仓号：
                <input name="storehouse" id="filter-storehouse" style="width:15%;" class="inputArea"/>
                <div id="concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div>
                <div class="buttonArea" id="select-button1" onclick="chongzi();">重置</div>
            </form>
            <form id="out-table">
                <table>
                    <thead>
                    <tr>
                        <td>选择</td>
                        <td>成交子明细号</td>
                        <td>库点</td>
                        <td>仓号</td>
                        <td>品种</td>
                        <td>数量</td>
                        <td>成交单位</td>
                        <td>提货截止时间</td>
                    </tr>
                    <tr id="conclute-template" style="display:none">
                        <td><input type="radio" name="conclute-radio"></td>
                        <td align="left" name="dealSerial"></td>
                        <td align="left" name="deliveryPlace"></td>
                        <td align="right" name="storehouse"></td>
                        <td align="left" name="grainType"></td>
                        <td align="right" name="quantity"></td>
                        <td align="left" name="receivePlace"></td>
                        <td name="takeEnd"></td>
                        <td name="dealPrice" style="display: none;"></td>
                        <td name="storageType" style="display:none;"></td>
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
</div>
<script>
    var warehouse =${cf:toJSON(basepoint)};
    layui.use('form', function () {
        var form = layui.form;
        form.render("select");

        form.on('select(warehouse)', function () {
            let deliveryPlace = $("#reserveUnit").val();
            $(".data-tr").remove();

            $("#concluteForm input[name=\"deliveryId\"]").val(deliveryPlace);
            for (let i = 0; i < warehouse.length; i++) {
                if (warehouse[i].id == deliveryPlace) {
                    $("input[name=\"warehouseContactor\"]").val(warehouse[i].creator);
                    $("input[name=\"warehouseTel\"]").val(warehouse[i].telphone);
                }
            }
        })
    });

    // $(function () {
    //     $(".data-tr").each(function () {
    //         let dom = $(this);
    //         let value =  $(this).find("[name='dealSerial']").html();
    //         $.ajax({
    //             url: "/RotateNotif/takecount/"+value+".shtml",
    //             type: "post",
    //             async: false,
    //             success: function (data) {
    //                 var ladingBills = data.data;
    //                 $(dom).find("[name='ladingBills']").html(ladingBills)
    //             }
    //         })
    //     });
    // })

    $("#save,#submit").click(function () {
        // 点击过后所有按键全部隐藏
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
        $(".data-tr").each(function () {
            if (!$(this).find("td[name='thisShipment']>input").val()) {
                patchAll = false
                return false;
            }

            detailData.push({
                "dealSerial": $(this).find("td[name='dealSerial']").html().trim(),
                "acceptanceUnit": $(this).find("td[name='acceptanceUnit']").html(),   // 接收单位
                "acceptanceUnitId": $(this).find("td[name='acceptanceUnit']").attr("tag"),
                "telephone": $(this).find("td[name='telephone']").html(),   // 联系电话
                "storeEncode": $(this).find("td[name='storeEncode']").html().trim(),
                "variety": $(this).find("td[name='variety']").html().trim(),
                "unitPrice": $(this).find("td[name='unitPrice']").html(),
                "storageMode": $(this).find("td[name='storageMode']").html(),
                "contract": $(this).find("td[name='contract']").html(),
                "ladingBills": $(this).find("td[name='ladingBills']").html(),
                "thisShipment": $(this).find("td[name='thisShipment']>input").val(),
                "accumulatedBills": $(this).find("td[name='accumulatedBills']").html(),
            });


        });



    if (!patchAll) {
        $("#save,#submit").show();
        layer.msg("本次发货数量不能为空")
        return;
    }

    if (detailData.length == 0) {
        layer.msg("提货单详情不能为空")
        $("#save,#submit").show();
        return
    }
    //
    // // 将所有disabled全部移除
    // let objs = $("input[disabled='disabled'],select[disabled='disabled']");
    // $(objs).each(function () {
    //     $(this).removeAttr("disabled");
    // });

    if ($(this).html().indexOf('保存') != -1) {
        $.ajax({
            url: "${ctx }/RotateNotif/Take/Add.shtml",
            type: "post",
            data: JSON.stringify({
                "serial": $("input[name='serial']").val(),
                "receiveWarehouseId": $("select[name='receiveWarehouseId']").val(),
                "warehouseContactor": $("input[name='warehouseContactor']").val(),
                "warehouseTel": $("input[name='warehouseTel']").val(),
                "enterpriseTel": $("input[name='enterpriseTel']").val(),
                "customer": $("input[name='customer']").val(),
                "customerTel": $("input[name='customerTel']").val(),
                "status": "待提交",
                "createDate": $("span[name='createDate']>span").html(),
                "rotateTakes": detailData,
            }),
            contentType: "application/json",
            success: function (data) {
                if (data.success) {
                    layer.msg("信息保存成功", {icon: 1}, function () {
                        window.location.href = "${ctx}/RotateNotif/Take.shtml?type=Warehouse";
                    });
                }
            }
        })
    } else if ($(this).html().indexOf('提交') != -1) {
        var way = $("#save").html().indexOf("保存") != -1 ? "Add.shtml" : "Edit.shtml";

        $.ajax({
            url: "${ctx }/RotateNotif/Take/" + way,
            type: "post",
            data: JSON.stringify({
                "id": "${take.id }",
                "serial": $("input[name='serial']").val(),
                "receiveWarehouseId": $("select[name='receiveWarehouseId']").val(),
                "warehouseContactor": $("input[name='warehouseContactor']").val(),
                "warehouseTel": $("input[name='warehouseTel']").val(),
                "enterpriseTel": $("input[name='enterpriseTel']").val(),
                "status": "待审核",
                "createDate": $("span[name='createDate']>span").html(),
                "rotateTakes": detailData,
            }),
            contentType: "application/json",
            success: function (data) {
                if (data.success) {
                    layer.msg("信息保存成功", {icon: 1}, function () {
                        window.location.href = "${ctx}/RotateNotif/Take.shtml?type=Warehouse";
                    });
                }
            }
        })
    } else if ($(this).html().indexOf('编辑') != -1) {
        $.ajax({
            url: "${ctx }/RotateNotif/Take/Edit.shtml",
            type: "post",
            data: JSON.stringify({
                "id": "${take.id }",
                "serial": $("input[name='serial']").val(),
                "receiveWarehouseId": $("select[name='receiveWarehouseId']").val(),
                "warehouseContactor": $("input[name='warehouseContactor']").val(),
                "warehouseTel": $("input[name='warehouseTel']").val(),
                "enterpriseTel": $("input[name='enterpriseTel']").val(),
                "createDate": $("span[name='createDate']>span").html(),
                "rotateTakes": detailData,
            }),
            contentType: "application/json",
            success: function (data) {
                if (data.success) {
                    layer.msg("信息保存成功", {icon: 1}, function () {
                        window.location.href = "${ctx}/RotateNotif/Take.shtml?type=Warehouse";
                    });
                }
            }
        })
    } else {
        return false;
    }
    })
    ;

    $("#add-list").click(function () {
        var warehouseId = $('#reserveUnit').val();
        if (!warehouseId) {
            layer.msg("请先选择接受库点");
            return;
        }
        var index = layer.load(1);

        $("#concluteButton").click();

        $("#float-alert").slideToggle(500, function () {
            $("#table-wapper").slideToggle(500);
        });
        layer.close(index);
    });

    $("#close-float-alert").click(function () {
        $("#table-wapper").slideToggle(500, function () {
            $("#float-alert").slideToggle(500, function () {
                $("#schemeDetail-data-list").find("tr").remove();
            });
        });
    });

    $("#add-tolist").click(function () {
        var soucedata = $("#schemeDetail-data-list").find("input[name='conclute-radio']:checked");
        if (soucedata.length == 0) {
            return
        }
        var trdata = $(soucedata).parent().parent();
        var template = $("#template-tr").clone(true);

        let flage = false
        $(".data-tr").each(function () {
            if ($(this).find("td[name='dealSerial']").html() == $(trdata).find("td[name='dealSerial']").html()) {
                layer.msg("成交子明细已存在")
                flage = true
                return false
            }
        });
        if (flage) {
            return
        }

        $(template).find("td[name='dealSerial']").html($(trdata).find("td[name='dealSerial']").html()); // 成交自明细号
        $(template).find("td[name='acceptanceUnit']").html($(trdata).find("td[name='receivePlace']").html()); // 接收单位
        $(template).find("td[name='acceptanceUnit']").attr("tag", $(trdata).find("td[name='receivePlace']").attr("tag")); // 接收单位Id
        // $(template).find("td[name='telephone']").html($(trdata).find("td[name='dealSerial']").html()); // 联系方式
        $(template).find("td[name='storeEncode']").html($(trdata).find("td[name='storehouse']").html());    // 仓号
        $(template).find("td[name='variety']").html($(trdata).find("td[name='grainType']").html()); // 品种
        $(template).find("td[name='unitPrice']").html($(trdata).find("td[name='dealPrice']").html()); // 粮食单价
        $(template).find("td[name='storageMode']").html($(trdata).find("td[name='storageType']").html()); // 存储方式
        $(template).find("td[name='contract']").html($(trdata).find("td[name='quantity']").html()); // 合同数量
        $(template).find("td[name='ladingBills']").html($(trdata).find("td[name='ladingBills']").html());   //
        $(template).find("td[name='accumulatedBills']").html($(trdata).find("td[name='accumulatedBills']").html());
        $(template).find("td[name='customer']").html($(trdata).find("td[name='dealSerial']").html());   // 接受单位
        $(template).find("td[name='customerTel']").html($(trdata).find("td[name='dealSerial']").html());    // 联系方式
        let value = $(trdata).find("td[name='dealSerial']").html()
        $.ajax({
            url: "${ctx}/RotateNotif/takecount/" + value + ".shtml",
            type: "post",
            async: false,
            success: function (data) {
                var ladingBills = data.data;
                $(template).find("td[name='ladingBills']").html(ladingBills);
            }
        })

        $.ajax({
            url: "${ctx}/CustomerInformation/search/" + $(trdata).find("td[name='receivePlace']").attr("tag") + ".shtml",
            success: function (result) {
                if (result.success) {
                    $(template).find("td[name='telephone']").html(result.data.contactTel)
                }
            }
        })

        $(template).addClass("data-tr");
        $("#data-result").append($(template));
        layui.form.render("select");
        $(template).slideToggle(500);
        $("#close-float-alert").click();
    });

    $("#concluteButton").click(function () {
        $("#concluteForm").ajaxSubmit({
            success: function (data) {
                $("#schemeDetail-data-list").find("tr").remove();
                for (var i = 0; i < data.length; i++) {
                    var dataMode = $("#conclute-template").clone(true);
                    $(dataMode).find("td[name='dealSerial']").html(data[i]["dealSerial"]);
                    $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
                    $(dataMode).find("td[name='deliveryPlace']").html(data[i]["deliveryPlace"]).attr("warehouseId", data[i]["deliveryId"]);
                    $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);
                    $(dataMode).find("td[name='quantity']").html(data[i]["quantity"]);
                    $(dataMode).find("td[name='takeEnd']").html(data[i]["takeEnd"]);
                    $(dataMode).find("td[name='receivePlace']").html(data[i]["receivePlace"]);
                    $(dataMode).find("td[name='receivePlace']").attr("tag", data[i]["receiveId"]);
                    $(dataMode).find("td[name='dealPrice']").html(data[i]["dealPrice"]);
                    $(dataMode).find("td[name='storageType']").html(data[i]["storageType"]);
                    $("#schemeDetail-data-list").append($(dataMode));
                    $(dataMode).show();
                }
            }
        });
    });

    $("#cancel").click(function () {
        layer.confirm('你确定要放弃编辑吗？', {
            btn: ['是', '否']
        }, function () {
            window.location.href = "${ctx}/RotateNotif/Take.shtml?type=Warehouse";
        }, function () {

        });
    });

    $(".remove-detail").click(function () {
        $(this).parent().parent().hide(500, function () {
            $(this).remove();
        });
    });

    function calculate(op) {
        let parents = $(op).parents("tr");
        var number = Number($(op).val()) + Number($(parents).find("td[name='ladingBills']").html());
        if (Number($(parents).find("td[name='contract']").html()) >= number) {
            $(parents).find("td[name='accumulatedBills']").html(number);
        } else {
            $(parents).find("td[name='accumulatedBills']").html("");
            $(op).val("")
            layer.msg("不能大于剩余数量!", {icon: 0});
        }
        $.ajax({
            type: "get",
            url: "${ctx }/RotateNotif/judge.shtml?deal_serial=" + $(parents).find("td[name='dealSerial']").html().trim() + "&number=" + ($(op).val())
            +"&id="+$(parents).find("td[name='id']").html().trim(),
            success: function (data) {
                if (data.success == false) {
                    $(parents).find("td[name='accumulatedBills']").html("");
                    $(op).val("")
                    layer.msg("本次发货吨数不可大于认领吨数!", {icon: 0});
                }
            }
        })
    }

    <%--$("#filter-concluteButton").click(function () {--%>
    <%--var grainType = $("#filter-grainType").val();--%>
    <%--var receivePlace = $("#filter-receivePlace").val();--%>
    <%--var warehoueYear = $("#filter-warehoueYear").val();--%>
    <%--var storehouse = $("#filter-storehouse").val();--%>
    <%--var quantity = $("#filter-quantity").val();--%>
    <%--$("#schemeDetail-data-list").find("input[type='checkbox']").each(function () {--%>
    <%--var trdata = $(this).parent().parent();--%>
    <%--var tempgrain = $(trdata).find("td[name='grainType']").html();--%>
    <%--var tempreceive = $(trdata).find("td[name='receivePlace']").html();--%>
    <%--var tempwarehoueYear = $(trdata).find("td[name='warehoueYear']").html();--%>
    <%--var tempstorehouse = $(trdata).find("td[name='storehouse']").html();--%>
    <%--var tempquantity = $(trdata).find("td[name='quantity']").html();--%>

    <%--if (tempgrain.indexOf(grainType) == -1) {--%>
    <%--$(trdata).hide();--%>
    <%--return;--%>
    <%--} else if (tempreceive.indexOf(receivePlace) == -1) {--%>
    <%--$(trdata).hide();--%>
    <%--return;--%>
    <%--} else if (tempwarehoueYear.indexOf(warehoueYear) == -1) {--%>
    <%--$(trdata).hide();--%>
    <%--return;--%>
    <%--} else if (tempstorehouse.indexOf(storehouse) == -1) {--%>
    <%--$(trdata).hide();--%>
    <%--return;--%>
    <%--} else if (tempquantity.indexOf(quantity) == -1) {--%>
    <%--$(trdata).hide();--%>
    <%--return;--%>
    <%--}--%>
    <%--$(trdata).show();--%>
    <%--});--%>
    <%--});--%>

    <%--$("#cancel").click(function () {--%>
    <%--layer.confirm('你确定要放弃编辑吗？', {--%>
    <%--btn: ['是', '否']--%>
    <%--}, function () {--%>
    <%--window.location.href = "${ctx}/RotateNotif/In.shtml?type=Warehouse";--%>
    <%--}, function () {--%>

    <%--});--%>
    <%--});--%>

    <%--$('input[name="noticeSerial"]').blur(function () {--%>
    <%--if ($(this).val() == '')--%>
    <%--return;--%>
    <%--var expressionOne = /\d{4}-\d/;--%>
    <%--var expressionTwo = /^〔\d{4}〕[0-9]{1,}号$/;--%>
    <%--if (!expressionOne.test($(this).val()) && !expressionTwo.test($(this).val())) {--%>
    <%--layer.msg("请按照格式输入，格式为：年份-编号");--%>
    <%--$(this).val('');--%>
    <%--return;--%>
    <%--} else if (!expressionTwo.test($(this).val())) {--%>
    <%--var formatStr = $(this).val().split('-');--%>
    <%--$(this).val('〔' + formatStr[0] + '〕' + formatStr[1] + '号');--%>
    <%--}--%>

    <%--// 判断通知书编号是否存在--%>
    <%--var noticeSerialVal = $(this).val();--%>
    <%--if (noticeSerialValue == noticeSerialVal)--%>
    <%--return;--%>
    <%--let url = "${ctx}/RotateNotif/isRotateNotif.shtml";--%>
    <%--$.ajax({--%>
    <%--url: url,--%>
    <%--contentType: "application/json",--%>
    <%--type: "post",--%>
    <%--data: '{"noticeSerial":"' + noticeSerialVal + '", "type":"in"}',--%>
    <%--success: function (data) {--%>
    <%--if (data.success) {--%>
    <%--if (!data.data) {--%>
    <%--// 如果存在--%>
    <%--layer.msg("通知书编号已存在");--%>
    <%--$("input[name=\"noticeSerial\"]").val('');--%>
    <%--return;--%>
    <%--}--%>
    <%--} else {--%>

    <%--}--%>
    <%--}--%>
    <%--});--%>
    <%--});--%>

    function chongzi() {
    document.getElementById("concluteForm").reset();
    // $("#concluteForm").ajaxSubmit({
    // success: function (data) {
    // $("#schemeDetail-data-list").find("tr").remove();
    // for (var i = 0; i < data.length; i++) {
    // var dataMode = $("#conclute-template").clone(true);
    // $(dataMode).attr("tag", data[i]["dealSerial"]);
    // $(dataMode).find("td[name='dealSerial']").html(data[i]["dealSerial"]);
    // $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
    // $(dataMode).find("td[name='dealPrice']").html(data[i]["dealPrice"]);
    // $(dataMode).find("td[name='warehoueYear']").html(data[i]["warehoueYear"]);
    // $(dataMode).find("td[name='receivePlace']").html(data[i]["receivePlace"]);
    // $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);
    // $(dataMode).find("td[name='quantity']").html(data[i]["quantity"]);
    // $("#schemeDetail-data-list").append($(dataMode));
    // $(dataMode).show();
    // }
    // }
    // });
        $("#concluteForm").ajaxSubmit({
            success: function (data) {
                $("#schemeDetail-data-list").find("tr").remove();
                for (var i = 0; i < data.length; i++) {
                    var dataMode = $("#conclute-template").clone(true);
                    $(dataMode).find("td[name='dealSerial']").html(data[i]["dealSerial"]);
                    $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
                    $(dataMode).find("td[name='deliveryPlace']").html(data[i]["deliveryPlace"]).attr("warehouseId", data[i]["deliveryId"]);
                    $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);
                    $(dataMode).find("td[name='quantity']").html(data[i]["quantity"]);
                    $(dataMode).find("td[name='takeEnd']").html(data[i]["takeEnd"]);
                    $(dataMode).find("td[name='receivePlace']").html(data[i]["receivePlace"]);
                    $(dataMode).find("td[name='receivePlace']").attr("tag", data[i]["receiveId"]);
                    $(dataMode).find("td[name='dealPrice']").html(data[i]["dealPrice"]);
                    $(dataMode).find("td[name='storageType']").html(data[i]["storageType"]);
                    $("#schemeDetail-data-list").append($(dataMode));
                    $(dataMode).show();
                }
            }
        });
    };

    <%--function searchJiaoyi(o) {--%>

    <%--}--%>

    <%--function numberFixed(obj, op) {--%>
    <%--number = $(obj).val();--%>
    <%--if (number == null || number == "") {--%>
    <%--return--%>
    <%--}--%>
    <%--number = parseFloat(number).toFixed(op);--%>
    <%--$(obj).val(number);--%>
    <%--}--%>

    <%--$("[name='actualNumber'] input").on("change",function () {--%>
    <%--if($(this).val()!=null) {--%>
    <%--let actualNumber = Number($(this).val());--%>
    <%--let planNumber = Number($(this).parent().prevAll("[name='planNumber']").find("input").val());--%>
    <%--if(actualNumber>planNumber){--%>
    <%--$(this).val("");--%>
    <%--layerMsgError("实际数大于计划数");--%>
    <%--}--%>

    <%--}--%>
    <%--});--%>
</script>
<%@ include file="../common/AdminFooter.jsp" %>