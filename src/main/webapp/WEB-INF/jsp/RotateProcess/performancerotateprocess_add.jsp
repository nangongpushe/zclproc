<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<style type="text/css">

    #schemeDetail-data-list tr td[name="dealSerial"] {
        text-align: left;
        padding-left: 1%;
    }

    #schemeDetail-data-list tr td[name="bidSerial"] {
        text-align: left;
        padding-left: 1%;
    }

    #schemeDetail-data-list tr td[name="deliveryPlace"] {
        text-align: left;
        padding-left: 1%;
    }

    #schemeDetail-data-list tr td[name="storehouse"] {
        text-align: left;
        padding-left: 1%;
    }

    #schemeDetail-data-list tr td[name="grainType"] {
        text-align: left;
        padding-left: 1%;
    }

    #schemeDetail-data-list tr td[name="dealUnit"] {
        text-align: left;
        padding-left: 1%;
    }

    #schemeDetail-data-list tr td[name="quantity"] {
        text-align: right;
        padding-right: 1%;
    }

    #outSide {
        width: 94%;
        margin-left: 2%;
        padding: 1%;
        background: #fff;
        border-top: 2px solid #23b7e5;
    }

    .buttonArea {
        padding: 5px 15px;
        background: #009688;
        border: none;
        color: #fff;
        cursor: pointer;
        display: inline;
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
        left: 85.5%;
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
        <li>商务处理</li>
        <li>合同履约管理</li>
        <li class="active">
            <c:choose>
                <c:when test="${performance.id != null }">编辑</c:when>
                <c:otherwise>新增</c:otherwise>
            </c:choose>
        </li>
    </ol>
</div>
<div id="outSide">
    <div id="userInfo" class="infoArea">
        <span class="title">填报人信息</span>
        <div id="infoArea">
            <span>经办人：${performance.operator }</span>
            <span name='createDate'>经办时间：<span><fmt:formatDate value="${performance.handleTime }"
                                                               pattern="yyyy-MM-dd"/></span></span>
            <span>经办部门：${performance.department }</span>
        </div>
    </div>
    <form action="Add.shtml" method="Post" enctype="multipart/form-data">
        <div id="dataArea" class="infoArea">
            <span class="title">履约信息</span>
            <div id="mainInfo">
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>情况表类型：</span>
                    <select name="type" class="inputArea">
                        <option <c:if test="${performance.type eq '出库' }">selected</c:if>>出库</option>
                        <option <c:if test="${performance.type eq '入库' }">selected</c:if>>入库</option>
                    </select>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>单位：</span>
                    <select class="inputArea" name='unit'>
                        <option>吨</option>
                    </select>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>成交子明细号：</span>
                    <input name="dealSerial" class="inputArea" style="width:73%" value="${performance.dealSerial }"
                           readonly/>
                    <div class="buttonArea" id="choose-deal">请选择</div>
                </div>
                <div>
                    <span style="text-align:right">	标的号：</span>
                    <input class="inputArea" name='bidSerial' value="${performance.bidSerial }" readonly/>
                </div>
                <div>
                    <span style="text-align:right">承储单位：</span>
                    <input class="inputArea" name="deliveryPlace" value="${performance.deliveryPlace }" readonly/>
                    <input name="enterpriseId" value="${performance.enterpriseId }" type="hidden"/>
                </div>
                <div>
                    <span style="text-align:right">库点：</span>
                    <input class="inputArea" name="warehouseName" value="${performance.warehouseName }" readonly/>
                    <input name="warehouseId" value="${performance.warehouseId }" type="hidden"/>
                </div>
                <div>
                    <span style="text-align:right">仓房：</span>
                    <input class="inputArea" name="storehouse" value="${performance.storehouse }" readonly/>
                </div>
                <div class="outBound">
                    <span style="text-align:right"><b class="requiredData">*</b>提货截止时间：</span>
                    <input class="inputArea" name="takeEnd" value="${performance.takeEnd }" readonly/>
                </div>
                <div class="inBound">
                    <span style="text-align:right"><b class="requiredData">*</b>交货截止日期：</span>
                    <input name="deliveryEnd" class="inputArea" value="${performance.deliveryEnd }" readonly/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>品种：</span>
                    <input name="grainType" class="inputArea" value="${performance.grainType }" readonly/>
                </div>
                <div>
				<span style="text-align:right">
					<b class="requiredData">*</b>
					<lable class="outBound">提货单位</lable><lable class="inBound">交货单位</lable>：
				</span>
                    <input name='dealUnit' class="inputArea" value="${performance.dealUnit }" readonly/>
                    <input name='dealUnitId' value="${performance.dealUnitId }" type="hidden"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>合同数量：</span>
                    <input class="inputArea" name="quantity" value="${performance.quantity }" readonly/>
                </div>
                <div>
				<span style="text-align:right">
					<b class="requiredData">*</b>
					<lable class="inBound">按期完成提货数量</lable><lable class="outBound">按期完成入库数量</lable>：
				</span>
                    <input type="number" class="inputArea" value="${performance.inPlanQuantity }" name="inPlanQuantity"
                           onchange="numberFixed(this,3)" oninput="if(value.length>15)value=value.slice(0,15)" />
                </div>
                <div>
                    <span style='position: relative;bottom: 80px;text-align: right'>商务处理情况：</span>
                    <textarea name="processDetail" class="inputArea" rows="5"
                              maxlength="500">${performance.processDetail }</textarea>
                </div>
                <%-- <div>
                    <span>附件：</span>
                    <div id="add-annex" class="buttonArea">${filename eq null ? '上传文件' : filename}</div>
                    <input type="file" name="file" style="display:none;">
                </div> --%>

                <div>
                    <span style="text-align:right">附件：</span>
                    <ul style="width: 80%; display: inline-block;"
                        templateId="template-file" length=5 id="ul-file">
                        <c:forEach items="${files}" var="item">
                            <li style="float: left; margin-right: 5px; line-height: 40px;">
                                <div data="${item.id}" class="buttonArea file-button">
                                    <div id="afileName" style="display:inline-block;font-size:14px;" >
                                        <a href="${ctx }/sysFile/download.shtml?fileId=${item.id}" style="margin:0 10px;">${item.fileName}</a>
                                    </div>
                                    <%--<lable>${item.fileName}</lable>--%>
                                    <i class="layui-icon">&#x1006;</i>
                                    <c:forEach items="${suffixMap}" var="m">
                                        <c:if test="${m.key == item.id}">
                                            <c:choose>
                                                <c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
                                                        <a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${item.downloadUrl}','width=1200px;height=800px;')" id="openExcel">
                                                            预览
                                                        </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a style="color: yellowgreen" href="javascript:openAnnex('${item.id}')" id="openFile">
                                                        预览
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                        
                                    </c:forEach>
                                </div>
                                <%--<input type="file" style="display: none;" class="file-input"
                                       name="file"/>--%>
                            </li>
                        </c:forEach>
                        <c:if test="${fn:length(files) < 5 }">
                            <li style="float: left; margin-right: 5px; line-height: 40px;">
                                <div data="" class="buttonArea file-button">
                                    <lable class="toUpload">添加附件</lable>
                                    <i style="display: none" class="layui-icon">&#x1006;</i>
                                </div>
                                <input type="file" style="display: none;" class="file-input"
                                       name="file"/>
                            </li>
                        </c:if>
                    </ul>
                </div>

                <div>
                    <span style='position: relative;bottom: 80px;text-align: right'>备注：</span>
                    <textarea name='remark' class="inputArea" rows="5" maxlength="500">${performance.remark }</textarea>
                </div>
            </div>
        </div>
        <div id="bottom-button">
            <div class="buttonArea" id="save">
                <c:choose>
                    <c:when test="${performance.id != null }">编辑</c:when>
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
        <span class="title">成交子明细选择</span>
        <i id="close-float-alert" class="layui-icon">&#x1006;</i>
        <div style="margin-top:2%;padding-bottom:2%;border-bottom:1px solid #ccc">
            <form id="concluteForm" action="${ctx }/rotateConclute/ListDetail.shtml" method="POST">
                <%--成交明细号：--%>
                <%--<select name="sid" style="width:50%;" class="inputArea">--%>
                <%--<option type="" value="">请选择</option>--%>
                <%--<c:forEach items="${concluteList}" var="conclute">--%>
                <%--<option type="${conclute.inviteType }" value="${conclute.id }">${conclute.dealSerial }</option>--%>
                <%--</c:forEach>--%>
                <%--</select>--%>
                <%--<div id="concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div> --%>

                粮食品种：
                <select name="grainType" id="filter-grainType" style="width:15%;" class="inputArea"
                        style="display:none">
                    <option value="">全部</option>
                    <c:forEach items="${varietyList }" var="item">
                        <option value="${item.value }">${item.value }</option>
                    </c:forEach>
                </select>
                <input type="hidden" id="isOut" name="isOut" value="">
                <input type="hidden" id="isIn" name="isIn" value="">

                <input type="hidden" id="noticeType" name="noticeType" value="${performance.type}">

                库点：
                <c:if test="${defaultProjectUnit!=null&&defaultProjectUnit!='' }">
                <select name="receivePlace" id="filter-receivePlace" style="width:15%;" class="inputArea"
                        style="display:none">
                    <option value="${defaultProjectUnit }" selected>${defaultProjectUnit }</option>
                </select>
                </c:if>

                <c:if test="${defaultProjectUnit==null||defaultProjectUnit=='' }">
                <select name="receivePlace" id="filter-receivePlace" style="width:15%;" class="inputArea"
                        style="display:none">
                    <option value="">全部</option>
                    <c:forEach items="${basepoint }" var="point">
                        <option value="${point }"
                                <c:if test="${defaultProjectUnit eq point }">selected </c:if>>${point }</option>
                    </c:forEach>
                </select>
                </c:if>

                <%-- 库点类型：
                 <select id="filter-receivePlaceType" style="width:15%;" class="inputArea" style="display:none">
                     <option value="">全部</option>
                     <option value="直属单位">直属单位</option>
                     <option value="代储库">代储库</option>
                 </select>--%>
                <%--收获年份：--%>
                <%--<input name="warehoueYear" id="filter-warehoueYear" style="width:15%;" class="inputArea"/>--%>
                <%--仓号：--%>
                <%--<input name="storehouse" id="filter-storehouse" style="width:15%;" class="inputArea"/>--%>

                <%--<span id="dealUnit">提货单位：</span>--%>
                <%--<input name="dealUnit" id="filter-dealUnit" style="width:15%;" class="inputArea"/>--%>

                <div id="concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div>
                <div class="buttonArea" id="select-button1" onclick="chongzhi();">重置</div>


        </div>
        </form>
        <form id="out-table">
            <table>
                <thead>
                <tr>
                    <td>选择</td>
                    <td>成交子明细号</td>
                    <td>标的号</td>
                    <td>承储单位（盖章）</td>
                    <td>库点</td>
                    <td>仓房编号</td>
                    <td class="outBound">提货截止时间</td>
                    <td class="inBound">交货截止日期</td>
                    <td>品种</td>
                    <td class="inBound">交货单位</td>
                    <td class="outBound">提货单位</td>
                    <td>合同数量</td>
                </tr>
                <tr id="conclute-template" style="display:none">
                    <td><input type="radio" name="conclute-radio"></td>
                    <td name="dealSerial"></td>
                    <td name="bidSerial"></td>
                    <td name='deliveryPlace'></td>
                    <td name='delivery'></td>
                    <input name="enterpriseId" type="hidden"/>
                    <input name="warehouseName" type="hidden">
                    <input name="warehouseId" type="hidden">
                    <td name="storehouse"></td>
                    <td class="outBound" name="takeEnd"></td>
                    <td class="inBound" name="deliveryEnd"></td>
                    <td name="grainType"></td>
                    <td name="dealUnit"></td>
                    <input name="dealUnitId" type="hidden">
                    <td name="quantity"></td>
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

<div id="template-file" style="display: none">
    <li style="float: left; margin-right: 5px; line-height: 40px;">
        <div data="" class="buttonArea file-button">
            <lable class="toUpload">添加附件</lable>
            <i style="display: none" class="layui-icon">&#x1006;</i>
        </div>
        <input type="file" style="display: none;" class="file-input"
               name="file"/>
    </li>
</div>
<script>


    $(function () {
        // 初始化 如果为空置为出库
        if($("#noticeType").val()==null|| $("#noticeType").val()==""){
            $("#noticeType").val("出库");
        }

        $("select[name='type']").change(function () {
            let noticeType = $(this).val();
            $("#noticeType").val(noticeType);
        })
    });

    function chongzhi() {
        $("#filter-grainType option:selected").attr("selected", false);
        $("#filter-grainType").eq(0).attr("selected", true);

        $("#filter-receivePlace option:selected").removeAttr("selected");
        $("#filter-receivePlace").eq(0).attr("selected", true);

        // $("#filter-warehoueYear").val("");
        $("#filter-storehouse").val("");
        $("#filter-dealUnit").val("");
    }

    var laydate = layui.laydate;
    laydate.render({
        elem: "#filter-warehoueYear",
        type: "year",
        format: "yyyy",
    });
    $(function () {
        var type = $("select[name='type']").val();
        if (type == '入库') {
            $("select[name='sid']").find("option").each(function () {
                if ($(this).attr("type").indexOf('销售') != -1) {
                    $(this).hide();
                    $(this).removeAttr("selected");
                } else {
                    $(this).show();
                }
            });
            $(".outBound").hide();
            $(".inBound").show();
        } else {
            $("select[name='sid']").find("option").each(function () {
                if ($(this).attr("type").indexOf('销售') != -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                    $(this).removeAttr("selected");
                }
            });
            $(".inBound").hide();
            $(".outBound").show();
        }
    });

    $("select[name='type']").change(function () {
        var type = $(this).val();
        if (type == '入库') {
            $("select[name='sid']").find("option").each(function () {
                if ($(this).attr("type").indexOf('销售') != -1) {
                    $(this).hide();
                    $(this).removeAttr("selected");
                } else {
                    $(this).show();
                }
            });
            $(".outBound").hide();
            $(".inBound").show();
        } else {
            $("select[name='sid']").find("option").each(function () {
                if ($(this).attr("type").indexOf('销售') != -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                    $(this).removeAttr("selected");
                }
            });
            $(".inBound").hide();
            $(".outBound").show();
        }
    });

    $("#add-annex").click(function () {
        $("input[type='file']").click();
    });


    $(document).on("click", ".file-button>lable", function () {
        $(this).parent().next().click();
    });

    //上传图片
    $(document).on("change", ".file-input", function () {
        var filename = $(this).val().split("\\");
        if (filename != "") {
            $(this).parent().find('lable').html(filename[filename.length - 1]);
            $(this).parent().find('lable').removeClass("toUpload");
            $(this).parent().find('i').show();
            var length = $(this).parent().parent().attr('length'); //限制数
            var fileLength = $(this).parent().parent().children('li').length; //已有数
            if (fileLength < length) {
                var templateId = $(this).parent().parent().attr('templateId');
                $(this).parent().parent().append($('#' + templateId).html());
            }
        }
    });

    //删除图片
    $(document)
        .on(
            "click",
            ".file-button>i",
            function () {
                if ($(this).parent().parent().parent()
                        .find('.toUpload').length == 0) {
                    var templateId = $(this).parent().parent().parent()
                        .attr('templateId');
                    $(this).parent().parent().parent().append(
                        $('#' + templateId).html());
                }
                $(this).parent().parent().remove();
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
        layer.load();
        var map = {"入库": "inBound", "出库": "outBound"};
        var patchAll = true;
        $(".requiredData").parent().parent().find("input:not(:hidden),select").each(function () {
            if ($(this).parent().hasClass(map[$("select[name='type']").val() == '入库' ? '出库' : '入库']))
                return true;
            // debugger;
            if ($(this).attr("name") == "bidSerial") {
                return true;
            }
            if ($(this).val() == "") {

                alert("*项为必填项,请补全相关信息");
                patchAll = false;
                return false;
            }
        });
        if (!patchAll) {
            layer.closeAll();
            return;
        }

        var fileIds = [];
        var undefind = undefind;
        $("#ul-file .file-button").each(
            function () {
                if ($(this).attr("data") != undefind
                    && $(this).attr("data") != "")
                    fileIds.push($(this).attr("data"))
            });
        if ($(this).html().indexOf('保存') != -1) {
            $("form").ajaxSubmit({
                type: "post",
                data: {
                    "handleTime": $("span[name='createDate']>span").html(),
                    "fileIds": JSON.stringify(fileIds),
                    "status": "待提交"
                },
                success: function (data) {
                    if (data.success) {
                        layer.msg("信息保存成功", {icon: 1}, function () {
                            window.location.href = "${ctx}/RotateProcess/Performance.shtml?type=Total";
                        });
                    } else {
                        layer.closeAll();
                        layerMsgError(data.msg);
                    }
                },
                error : function () {
                    layer.closeAll();
                    layerMsgError("操作失败，请稍后重试");
                }
            });
        } else if ($(this).html().indexOf('提交') != -1) {
            var way = $("#save").html().indexOf("保存") != -1 ? "Add.shtml" : "Edit.shtml";
            $("form").ajaxSubmit({
                url: way,
                type: "post",
                data: {
                    "handleTime": $("span[name='createDate']>span").html(),
                    "status": "审核中",
                    "fileIds": JSON.stringify(fileIds),
                    "id": "${performance.id }"
                },
                success: function (data) {
                    if (data.success) {
                        layer.msg("信息保存成功", {icon: 1}, function () {
                            window.location.href = "${ctx}/RotateProcess/Performance.shtml?type=Total";
                        })
                    } else {
                        layer.closeAll();
                        layerMsgError(data.msg);
                    }
                },
                error : function () {
                    layer.closeAll();
                    layerMsgError("操作失败，请稍后重试");
                }
            });
        } else if ($(this).html().indexOf('编辑') != -1) {
            $("form").ajaxSubmit({
                url: "Edit.shtml",
                type: "post",
                data: {
                    "handleTime": $("span[name='createDate']>span").html(),
                    "fileIds": JSON.stringify(fileIds),
                    "id": "${performance.id }",
                    "status":"待提交"
                },
                success: function (data) {
                    if (data.success) {
                        layer.msg("信息保存成功", {icon: 1}, function () {
                            window.location.href = "${ctx}/RotateProcess/Performance.shtml?type=Total";
                        });
                    } else {
                        layer.closeAll();
                        layerMsgError(data.msg);
                    }
                },
                error : function () {
                    layer.closeAll();
                    layerMsgError("操作失败，请稍后重试");
                }
            });
        } else {
            layer.closeAll();
            return false;
        }
    });

    $("#add-list").click(function () {
        var template = $("#template-tr").clone(true);
        $(template).removeAttr("id");
        $(template).addClass("data-tr");
        $("#data-result").append($(template));
        $(template).show();
    });

    $(".remove-detail").click(function () {
        $(this).parent().parent().hide(500, function () {
            $(this).remove();
        })
    });

    $("#choose-deal").click(function () {
        $("#float-alert").slideToggle(500, function () {
            $("#table-wapper").slideToggle(500);
        });
        var type = $("select[name='type']").val();
        if (type == "出库") {
            $("#isIn").val("");
            $("#isOut").val("1")
            $("#dealUnit").html("提货单位：");
        } else {
            $("#isIn").val("1");
            $("#isOut").val("")
            $("#dealUnit").html("承储单位：");
        }

        $("#concluteButton").click();
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
        $("input[name='bidSerial']").val($(trdata).find("td[name='bidSerial']").html());
        $("#mainInfo input[name='deliveryPlace']").val($(trdata).find("td[name='deliveryPlace']").html());
        $("input[name='enterpriseId']").val($(trdata).find("input[name='enterpriseId']").val());
        $("#mainInfo input[name='warehouseName']").val($(trdata).find("input[name='warehouseName']").val());
        $("input[name='warehouseId']").val($(trdata).find("input[name='warehouseId']").val());
        $("#mainInfo input[name='dealUnit']").val($(trdata).find("td[name='dealUnit']").html());
        $("input[name='dealUnitId']").val($(trdata).find("input[name='dealUnitId']").val());
        $("#mainInfo input[name='storehouse']").val($(trdata).find("td[name='storehouse']").html());
        $("input[name='takeEnd']").val($(trdata).find("td[name='takeEnd']").html());
        $("input[name='deliveryEnd']").val($(trdata).find("td[name='deliveryEnd']").html());
        $("#mainInfo input[name='grainType']").val($(trdata).find("td[name='grainType']").html());
        $("input[name='quantity']").val($(trdata).find("td[name='quantity']").html());
        $("#close-float-alert").click();

        $.ajax({
            data: {
                "dealSerial": $(trdata).find("td[name='dealSerial']").html(),
                "pageindex": 1,
                "pagesize": 1
            },
            type: "post",
            url: "${ctx}/RotateProcess/all/Recording.shtml",
            success: function (data) {
                if (data != null && data.result.length > 0) {
                    $.ajax({
                        data: {
                            "id": data.result[0].id
                        },
                        type: "post",
                        url: "${ctx}/RotateProcess/Recording/Detail.shtml",
                        success: function (detail) {
                            if (detail != null) {
                                var advices = "";
                                for (var i = 0; i < detail.processDetail.length; i++) {
                                    advices += detail.processDetail[i].type + "：" + detail.processDetail[i].advise + "，金额：" + detail.processDetail[i].amount + "\n"
                                }
                                $("textarea[name='processDetail']").html(advices);
                            }
                        }
                    });
                }
            }
        });

        $("input[name='dealSerial']").change();
    });

    /**
     *  成交子明细弹出层数据信息
     * */
    $("#concluteButton").click(function () {
        $("#concluteForm").ajaxSubmit({
            success: function (data) {
                $("#schemeDetail-data-list").find("tr").remove();
                for (var i = 0; i < data.length; i++) {
                    /*
                        承储单位一直对应企业信息    对应enterpriseId,deliveryPlace,warehouseId,warehouseName,storehouse
                        成交单位（交货单位（入库），提货单位（出库））均对应客户    dealUnit,dealUnitId
                     */

                    var dataMode = $("#conclute-template").clone(true);
                    $(dataMode).find("td[name='dealSerial']").html(data[i]["dealSerial"]);
                    $(dataMode).find("td[name='bidSerial']").html(data[i]["bidSerial"]);
                    $(dataMode).find("td[name='deliveryPlace']").html(data[i]["enterpriseName"]);   // 承储单位均为公司
                    $(dataMode).find("td[name='delivery']").html(data[i]["deliveryPlace"]);   // 承储单位均为公司
                    $(dataMode).find("input[name='enterpriseId']").val(data[i]["enterpriseId"]);

                    $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);

                    if('出库' == $("select[name='type'] option:selected").val()) {
                        $(dataMode).find("input[name='warehouseId']").val(data[i]["deliveryId"]);
                        $(dataMode).find("input[name='warehouseName']").val(data[i]["deliveryPlace"]);

                        $(dataMode).find("input[name='dealUnitId']").val(data[i]["receiveId"]);
                        $(dataMode).find("td[name='dealUnit']").html(data[i]["receivePlace"]);
                    } else {
                        $(dataMode).find("input[name='warehouseId']").val(data[i]["receiveId"]);
                        $(dataMode).find("input[name='warehouseName']").val(data[i]["receivePlace"]);

                        $(dataMode).find("input[name='dealUnitId']").val(data[i]["deliveryId"]);
                        $(dataMode).find("td[name='dealUnit']").html(data[i]["deliveryPlace"]);
                    }


                    $(dataMode).find("td[name='takeEnd']").html(data[i]["takeEnd"]);
                    $(dataMode).find("td[name='deliveryEnd']").html(data[i]["deliveryEnd"]);
                    $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
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
        $("#schemeDetail-data-list").find("input[type='checkbox']").each(function () {
            var trdata = $(this).parent().parent();
            var tempgrain = $(trdata).find("td[name='grainType']").html();
            var tempreceive = $(trdata).find("td[name='receivePlace']").html()
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
            window.location.href = "${ctx}/RotateProcess/Performance.shtml?type=Total";
        }, function () {

        });
    });

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