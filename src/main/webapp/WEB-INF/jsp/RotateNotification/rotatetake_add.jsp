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
        width: 17%;
        display: inline-block;
        text-align: left;
    }

    .inputArea {
        width: 80%;
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
        text-align: center;
    }

    thead {
        background: #f2f2f2;
    }

    table tr td {
        width: 9%;
        border: 1px solid #e2e2e2;
        padding: 10px 0;
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
        border-bottom: none;
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
            <span>经办人：${take.creater }</span>
            <span name='createDate'>经办时间：<span><fmt:formatDate value="${take.createDate }" pattern="yyyy-MM-dd"/></span></span>
        </div>
    </div>
    <form action="Add.shtml" method="Post" enctype="multipart/form-data">
        <div id="dataArea" class="infoArea">
            <span class="title">提货单信息</span>
            <div id="mainInfo">
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>提货单编号：</span>
                    <input name="serial" class="inputArea" value="${take.serial }"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>所属成交结果子明细号：</span>
                    <input name="dealSerial" class="inputArea" style="width:73%" value="${take.dealSerial }" readonly/>
                    <div class="buttonArea" id="choose-deal">请选择</div>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>接收库点：</span>
                    <input name="reserveUnit" class="inputArea" value="${take.reserveUnit }" readonly
                           placeholder="自动带出"/>
                    <input name="reserveId" type="hidden" value="${take.reserveId}"/>
                </div>

                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>承储单位联系方式：</span>
                    <input name="reserveTel" class="inputArea" value="${take.reserveTel }"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>仓号：</span>
                    <input name="storeEncode" class="inputArea" value="${take.storeEncode }" readonly
                           placeholder="自动带出"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>粮食品种：</span>
                    <input name="variety" class="inputArea" value="${take.variety }" readonly placeholder="自动带出"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>粮食单价(元/吨)：</span>
                    <input name="unitPrice" class="inputArea" readonly="readonly" value="${take.unitPrice }"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>存储方式：</span>

                    <select name="storageMode" id="filter-storageMode" style="width:80%;" class="inputArea">
                        <option value="">--请选择--</option>
                        <c:forEach items="${storeType }" var="item">
                            <%--<option value="${item.value }"<c:if test = "${take.storageMode eq item }">selected</c:if>>${item.value }</option>--%>
                            <c:if test="${item.value eq take.storageMode }">
                                <option value="${item.value}" selected="selected">${item.value}</option>
                            </c:if>
                            <c:if test="${item.value ne take.storageMode }">
                                <option value="${item.value}">${item.value}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>接收单位：</span>
                    <input name="acceptanceUnit" class="inputArea" value="${take.acceptanceUnit }"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>联系方式：</span>
                    <input name="telephone" class="inputArea" value="${take.telephone }" lay-verify="customPhone1"
                           onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]"
                           min="0"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>合同数量(吨)：</span>
                    <input name="contract" class="inputArea" value="${take.contract }" readonly placeholder="自动带出"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>已开提货单(吨)：</span>
                    <input name="ladingBills" class="inputArea" value="${take.ladingBills }" type="number" readonly
                           placeholder="自动带出"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>本次出货(吨)：</span>
                    <input name="thisShipment" class="inputArea" value="${take.thisShipment }" type="number"
                           onchange="numberFixed(this,3)"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>累计开出提货单(吨)：</span>
                    <input name="accumulatedBills" class="inputArea" value="${take.accumulatedBills }" type="number"
                           readonly placeholder="自动带出"/>
                </div>
                <div>
                    <span style="text-align:right">库点联系人：</span>
                    <input name="contacts" class="inputArea" value="${take.contacts }" type="text" placeholder="自动带出"/>
                </div>
                <div>
                    <span style="text-align:right">库点联系电话：</span>
                    <input name="contactNumber" class="inputArea" value="${take.contactNumber }" type="text"
                           placeholder="自动带出"/>
                </div>
                <div style="display:none">
                    <input name="takeEnd" class="inputArea" value="${take.takeEnd }" readonly/>
                    <input name="buyer" class="inputArea" value="${take.buyer }"/>
                </div>

            </div>
        </div>
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
    </form>
</div>
<div id="float-alert">
    <div id="table-wapper">
        <span class="title">明细选择</span>
        <i id="close-float-alert" class="layui-icon">&#x1006;</i>
        <div style="margin-top:2%;padding-bottom:2%;border-bottom:1px solid #ccc">
            <form id="concluteForm" action="${ctx }/rotateConclute/ListDetail.shtml" method="POST">
                <input type="hidden" name="noticeType" value="出库">
                <%--成交明细号：--%>
                <%--<select name="sid" style="width:50%;" class="inputArea">--%>
                <%--<c:forEach items="${concluteList}" var="conclute">--%>
                <%--<option value="${conclute.id }">${conclute.dealSerial }</option>--%>
                <%--</c:forEach>--%>
                <%--</select>--%>
                <%--<div id="concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div> --%>
                <%--</div>--%>
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
                库点：
                <select name="deliveryPlace" id="filter-receivePlace" style="width:15%;" class="inputArea"
                        style="display:none">
                    <option value="">全部</option>
                    <c:forEach items="${basepoint }" var="point">
                        <option value="${point }">${point }</option>
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
                <input name="storehouse" id="filter-storehouse" style="width:15%;" class="inputArea"/>

                <%--<br>--%>
                <%--计划数：--%>
                <%--<input name="quantity" id="filter-quantity" style="width:15%;" class="inputArea"/>--%>
                <div id="concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div>
                <div class="buttonArea" id="select-button1" onclick="chongzi();">重置</div>

            </form>
            <%--<div style="margin:10px 0">--%>
            <%--粮食品种：--%>
            <%--&lt;%&ndash;<input id="filter-grainType" style="width:15%;" class="inputArea"/>&ndash;%&gt;--%>
            <%--<select name="variety" id="filter-grainType" style="width:15%;" class="inputArea">--%>
            <%--<option></option>--%>
            <%--<c:forEach items="${varietyList }" var="item">--%>
            <%--<option value="${item.value }">${item.value }</option>--%>
            <%--</c:forEach>--%>
            <%--</select>--%>
            <%--库点：--%>
            <%--<select id="filter-receivePlace" style="width:15%;" class="inputArea">--%>
            <%--<option value="">全部</option>--%>
            <%--<c:forEach items="${basepoint }" var="point">--%>
            <%--<option>${point }</option>--%>
            <%--</c:forEach>--%>
            <%--</select>		--%>
            <%--<div id="filter-concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div> --%>
            <%--</div>--%>
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
                        <td align="left" name="dealUnit"></td>
                        <td name="takeEnd"></td>
                        <td name="dealPrice" style="display: none;"></td>
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

        var laydate = layui.laydate;
        laydate.render({
            elem: "#filter-warehoueYear",
            type: "year",
            format: "yyyy",
        });
        $("input[name='dealSerial']").change(function () {
            var value = $(this).val();
            $.ajax({
                url: "${ctx}/RotateNotif/Take/WareHouse.shtml",
                type: "post",
                data: {
                    "dealSerial": value,
                    "status": "已完成",
                    "pageindex": 1,
                    "pagesize": 1
                },
                success: function (data) {
                    var ladingBills = 0;
                    if (data.result.length > 0)
                        ladingBills = data.result[0].accumulatedBills;
                    $("input[name='ladingBills']").val(ladingBills);
                    $("input[name='accumulatedBills']").val(Number(ladingBills) + Number($("input[name='thisShipment']").val()));
                }
            })
        });

        $("input[name='thisShipment']").blur(function () {
            var number = Number($(this).val()) + Number($("input[name='ladingBills']").val());
            if (Number($("input[name='contract']").val()) >= number) {
                $("input[name='accumulatedBills']").val(number);
            } else {
                layer.msg("不能大于剩余数量!", {icon: 0});
                $("input[name='accumulatedBills']").val("");
            }
        });

        $("#save,#submit").click(function () {
            var patchAll = true;
            $(".requiredData").parent().parent().find("input,select").each(function () {
                if ($(this).val() == "") {
                    alert("*项为必填项,请补全相关信息");
                    patchAll = false;
                    return false;
                }
            });
            if (!patchAll)
                return;
            if ($(this).html().indexOf('保存') != -1) {
                $("form").ajaxSubmit({
                    type: "post",
                    data: {
                        "createDate": $("span[name='createDate']>span").html(),
                        "status": "待提交"
                    },
                    success: function (data) {
                        if (data.success) {
                            layer.msg("信息保存成功", {icon: 1}, function () {
                                window.location.href = "${ctx}/RotateNotif/Take.shtml?type=Warehouse";
                            });
                        }
                    }
                });
            } else if ($(this).html().indexOf('提交') != -1) {
                var way = $("#save").html().indexOf("保存") != -1 ? "Add.shtml" : "Edit.shtml";
                $("form").ajaxSubmit({
                    url: way,
                    type: "post",
                    data: {
                        "createDate": $("span[name='createDate']>span").html(),
                        "status": "待审核",
                        "id": "${take.id }"
                    },
                    success: function (data) {
                        if (data.success) {
                            layer.msg("信息保存成功", {icon: 1}, function () {
                                window.location.href = "${ctx}/RotateNotif/Take.shtml?type=Warehouse";
                            })
                        }
                    }
                });
            } else if ($(this).html().indexOf('编辑') != -1) {
                $("form").ajaxSubmit({
                    url: "Edit.shtml",
                    type: "post",
                    data: {
                        "createDate": $("span[name='createDate']>span").html(),
                        "id": "${take.id }"
                    },
                    success: function (data) {
                        if (data.success) {
                            layer.msg("信息保存成功", {icon: 1}, function () {
                                window.location.href = "${ctx}/RotateNotif/Take.shtml?type=Warehouse";
                            });
                        }
                    }
                });
            } else {
                return false;
            }
        });

        $("#choose-deal").click(function () {
            $("#float-alert").slideToggle(500, function () {
                $("#table-wapper").slideToggle(500);
            });
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
            var trdata = $(soucedata).parent().parent();
            $("input[name='dealSerial']").val($(trdata).find("td[name='dealSerial']").html());
            $("input[name='variety']").val($(trdata).find("td[name='grainType']").html());
            $("input[name='reserveUnit']").val($(trdata).find("td[name='deliveryPlace']").html());
            $("input[name='reserveId']").val($(trdata).find("td[name='deliveryPlace']").attr("warehouseId"));
            $("input[name='storeEncode']").val($(trdata).find("td[name='storehouse']").html());
            $("input[name='contract']").val($(trdata).find("td[name='quantity']").html());
            $("input[name='takeEnd']").val($(trdata).find("td[name='takeEnd']").html());
            $("input[name='buyer']").val($(trdata).find("td[name='dealUnit']").html());
            let dealPrice = Number($(trdata).find("td[name='dealPrice']").html());
            $("input[name='unitPrice']").val(dealPrice.toFixed(2));
            $("#close-float-alert").click();
            findConnector($(trdata).find("td[name='deliveryPlace']").html());
            $("input[name='dealSerial']").change();
            // layui.form.render();
        });

        $("#concluteButton").click(function () {
            $("#concluteForm").ajaxSubmit({
                success: function (data) {
                    $("#schemeDetail-data-list").find("tr").remove();
                    for (var i = 0; i < data.length; i++) {
                        var dataMode = $("#conclute-template").clone(true);
                        $(dataMode).find("td[name='dealSerial']").html(data[i]["dealSerial"]);
                        $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
                        $(dataMode).find("td[name='deliveryPlace']").html(data[i]["deliveryPlace"]).attr("warehouseId",data[i]["deliveryId"]);
                        $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);
                        $(dataMode).find("td[name='quantity']").html(data[i]["quantity"]);
                        $(dataMode).find("td[name='takeEnd']").html(data[i]["takeEnd"]);
                        $(dataMode).find("td[name='dealUnit']").html(data[i]["dealUnit"]);
                        $(dataMode).find("td[name='dealPrice']").html(data[i]["dealAmount"]);
                        $("#schemeDetail-data-list").append($(dataMode));
                        $(dataMode).show();
                    }
                }
            });
        });

        $("#filter-concluteButton").click(function () {
            var grainType = $("#filter-grainType").val();
            var receivePlace = $("#filter-receivePlace").val();
            $("#schemeDetail-data-list").find("tr").each(function () {
                var trdata = $(this);
                var tempgrain = $(trdata).find("td[name='grainType']").html();
                var tempreceive = $(trdata).find("td[name='deliveryPlace']").html()
                if (tempgrain.indexOf(grainType) == -1) {
                    $(trdata).hide();
                    return;
                } else if (tempreceive.indexOf(receivePlace) == -1) {
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
                window.location.href = "${ctx}/RotateNotif/Take.shtml?type=Warehouse";
            }, function () {

            });
        });

        function chongzi() {
            $("#filter-grainType option:selected").removeAttr("selected");
            $("#filter-grainType option").eq(0).attr("selected", true);

            $("#filter-receivePlace option:selected").removeAttr("selected");
            $("#filter-receivePlace option").eq(0).attr("selected", true);

            $("#filter-warehoueYear").val("");
            $("#filter-storehouse").val("");
        }

        function findConnector(val) {
            $.ajax({
                url: "${ctx}/storageWarehouse/findConnectorByShortName.shtml",
                type: "post",
                data: {
                    "warehouseShort": val
                },
                success: function (data) {
                    //console.log(data);
                    $("input[name='contacts']").val(data.contacts);
                    $("input[name='contactNumber']").val(data.contactNumber);
                    /*var ladingBills = 0;
                    if(data.result.length > 0)
                        ladingBills = data.result[0].accumulatedBills;
                    $("input[name='ladingBills']").val(ladingBills);
                    $("input[name='accumulatedBills']").val(Number(ladingBills) + Number($("input[name='thisShipment']").val()));*/
                }
            })
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