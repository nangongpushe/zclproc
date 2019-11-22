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

    #del{
        padding: 5px 15px;
        background: #009688;
        border: none;
        color: #fff;
        cursor: pointer;
        display: inline;
    }

</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>通知书管理</li>
        <li>入库通知书</li>
        <li class="active">${notice.id ne null?'编辑':'新增' }入库通知书</li>
    </ol>
</div>
<div id="outSide">
    <form action="${ctx }/RotateNotif/Add.shtml" method="Post" enctype="multipart/form-data" class="layui-form">
        <div id="dataArea" class="infoArea">
            <span class="title">入库通知书信息</span>
            <div id="mainInfo">
                <div style="display:none">
                    <span style="text-align:right"><b class="requiredData">*</b>轮换类别：</span>
                    <select class="inputArea" id="rotate-type" name="rotateType">
                        <option>常规轮换</option>
                    </select>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>依据：</span>
                    <input name="documentNumber" autocomplete="off"
                           <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if> class="inputArea"
                           value="${notice.documentNumber }" maxlength="45"/>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>通知书编号：</span>
                    <input class="inputArea" type="text" autocomplete="off"
                           <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if>
                           value="${notice.noticeSerial }" placeholder="格式:年份-编号  例：2018-1" name="noticeSerial" maxlength="15" disabled="disabled">
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>接收单位：</span>
                    <div class="layui-input-inline inputArea" style="border: 0">
                        <select class="inputArea" id="accepte-unit" lay-search style="border: 0"
                                <c:if test="${notice.status == '已完成'}">disabled="disabled"</c:if> name="storeEnterprise.id"
                                required onchange="searchJiaoyi(this)">
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
                    <span style="text-align:right"><b class="requiredData">*</b>入库截止时间：</span>
                    <input id="storage-date" name="storageDate" autocomplete="off"
                           <c:if test="${notice.status == '已完成'}">disabled="disabled"</c:if> class="inputArea"
                           type="text" value="<fmt:formatDate value="${notice.storageDate }" pattern="yyyy-MM-dd"/>"/>
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
                <div>
                    <%--<span style="text-align:right">附件：</span>
                    <ul style="width:85%;display:inline-block;">
                        <c:forEach var="n" begin="0" end="0" varStatus="status">
                            <li style="float:left;margin-right:5px;">
                                <div index="${status.index }"
                                     <c:choose>
                                     <c:when test="${files[status.index] == null }">style="display:none" </c:when>
                                         <c:otherwise>data="${files[status.index].id }"</c:otherwise>
                                </c:choose> class="buttonArea file-button">
                                    <lable>${files[status.index] ne null?files[status.index].fileName : '添加附件' }</lable>
                                </div>
                                <input index="${status.index }" type="file" style="display:none;" class="file-input"
                                       name="file"/>
                            </li>
                        </c:forEach>
                    </ul>--%>
                        <span style="text-align:right"><b class="red" id="annex" style="display: none">*</b>附件：</span>
                        <div class="buttonArea" id="add-annex">添加附件</div>
                        <input type="hidden" name="annex" value="${notice.annex}"/>
                        <input type="file"  style="display:none;" id="file-input" name="file">
                        <div id="fileName" style="display:inline-block;font-size:14px;" >
                            <a href="${ctx }/sysFile/download.shtml?fileId=${notice.annex}" style="margin:0 10px;">${filename.fileName}</a>
                        </div>

                        <div style="display:inline-block;font-size:20px;" id="openExce">
                            <a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${filename.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
                                预览
                            </a>
                            <a href="javascript:openAnnex('${notice.annex}')" id="openFile" style="display: none">
                                预览
                            </a>
                        </div>
                        <div style="display:inline-block;font-size:20px;">
                            <input type="button" id="delFileBtn" <c:if test="${empty filename.fileName}">style="display: none" </c:if>  onclick="resetFileInput();"  value="删除"/>
                        </div>
                </div>
                <div>
                    <span style="position: relative;bottom: 4em;text-align: right">备注：</span>
                    <textarea name="remark" rows="4" class="inputArea" maxlength="200">${notice.remark }</textarea>
                </div>
            </div>
        </div>
        <div id="listArea">
            <div style="display: flex;flex-direction: row;align-items: center;height: 40px">
                <c:if test="${notice.status ne '已完成' }">
                    <div class="buttonArea" id="add-list">新增</div>
                    <div class=" layui-inline" style="display: flex;flex-direction: row;align-items: center;height: 30px;padding-top:6px;margin-left: 10px;">
                        <nobr>
                            <input id="manr" type="checkbox" name="pestCheckTypeList" value="手工填报" title="手工填报" lay-skin="primary"/>
                        </nobr>
                    </div>
                </c:if>
            </div>
            <table id="mytable">
                <thead>
                    <tr>
                        <td>品种</td>
                        <td>批号</td>
                        <td>成本</td>
                        <td>直管属性</td>
                        <td>收获年份</td>
                        <td>企业</td>
                        <td>库点</td>
                        <td>仓房</td>
                        <td>计划数(吨)</td>
                        <td <c:if test="${notice.status ne '已完成' and targetIdentity ne 'warehouse'}">class="hide"</c:if>>
                            实际数(吨)
                        </td>
                        <c:if test="${notice.status ne '已完成' }">
                            <td>操作</td>
                        </c:if>
                    </tr>
                </thead>
                <tbody id="data-result">
                    <tr id="template-tr">
                        <td name = "mark" style="display: none"></td>
                        <td align="left" name="variety"></td>
                        <td align="center" name="batchNumber"></td>
                        <td align="center" name="cost">
                            <input style="width: 80%" class="inputArea" type="number" oninput="if(value.length>15)value=value.slice(0,15)"/>
                        </td>
                        <td name="pipeAttribute">
                            <input style="width: 80%" class="inputArea" maxlength="10"/>
                        </td>
                        <td name="harvestYear"></td>
                        <td name="enterpriseName"></td>
                        <td name="enterpriseId" style="display: none"></td>
                        <td align="left" name="storageWarehouse">
                            <select>
                            </select>
                        </td>
                        <td align="left" name="storehouse">
                            <input class="inputArea"/>
                        </td>
                        <td name="planNumber">
                            <input style="width: 80%" class="inputArea" type="number" oninput="if(value.length>15)value=value.slice(0,15)" onchange="numberFixed(this,3)"/>
                        </td>
                        <td name="actualNumber" style="display:none">
                            <input style="width: 80%" class="inputArea" type="number" onchange="numberFixed(this,3)" oninput="if(value.length>15)value=value.slice(0,15)"/>
                        </td>
                        </td>
                        <c:if test="${notice.status ne '已完成' }">
                            <td>
                                <div class="buttonArea remove-detail">删除</div>
                            </td>
                        </c:if>
                    </tr>

                    <tr id="show" style="display: none">
                        <td name = "mark" style="display: none">handManuMark</td>
                        <td style="display: none">manuMark</td>
                        <td style="display: none">##</td>
                        <td align="left">
                            <select class="manuReportVariety" id="id_manuReportVariety" name="manuReportVariety">
                            </select>
                        </td>
                        <td align="center" name="manuBatchNumber" id="id_manuBatchNumber">manubatchNumber</td>
                        <td align="center" name="cost">
                            <input style="width: 80%" class="inputArea" id="id_manuCost" type="number" oninput="if(value.length>15)value=value.slice(0,15)"/>
                        </td>
                        <td name="pipeAttribute">
                            <input style="width: 80%" class="inputArea" id="id_manuPipeAttribute" maxlength="10" value="省储"/>
                        </td>
                        <td name="harvestYear" class="harvestYear" id="id_maunHarvestYear"></td>
                        <td name="enterpriseName" id="id_enterpriseName">manuEnterpriseName</td>
                        <td name="enterpriseId" id="id_enterpriseId" style="display: none">manuEnterpriseId</td>
                        <td align="left">
                            <select lay-filter="filter_manuWareHouse" class="manuWareHouse" name="manuWareHouse" id="id_manuWareHouse">
                            </select>
                        </td>

                        <td align="left">
                            <select id="id_maunStoreHouse" name="maunStoreHouse">
                            </select>
                        </td>
                        <td name="planNumber">
                            <input style="width: 80%" class="inputArea" type="number" id="id_planNumber" oninput="if(value.length>15)value=value.slice(0,15)" onchange="numberFixed(this,3)"/>
                        </td>
                        <td>
                            <button type="button" onclick="deleteRow('##')" id="del">删除</button>
                        </td>
                    </tr>

                <c:forEach items="${notice.noticeDetail }" var="item">
                    <tr class="data-tr" tag="${item.dealSerial }">
                        <td style="display: none">非手工填报</td>
                        <td name="variety">${item.variety}</td>
                        <td align="center" name="batchNumber">${item.batchNumber}</td>
                        <td name="cost">
                            <input style="width: 80%" class="inputArea" type="number"
                                   <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if>
                                   value="${item.cost}" oninput="if(value.length>15)value=value.slice(0,15)"></td>
                        <td name="pipeAttribute">
                            <input style="width: 80%" class="inputArea"
                                   <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if>
                                   value="${item.pipeAttribute }" maxlength="10"></td>
                        <td  name="harvestYear">
                                ${item.harvestYear }
                        </td>
                        <td name="enterpriseName">${item.enterpriseName}</td>
                        <td name="enterpriseId" style="display: none">${item.enterpriseId}</td>
                        <td name="storageWarehouse" accepteunit="${notice.storeEnterprise.id}" warehouseId="${item.warehouse.id}">
                                ${item.warehouse.warehouseShort }
                        </td>
                        <td name="storehouse">
                                ${item.storehouse }
                        </td>
                        <td name="planNumber">
                            <input style="width: 80%" type="number" class="inputArea"
                                   <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if>
                                   value="${item.planNumber }" onchange="numberFixed(this,3)" oninput="if(value.length>15)value=value.slice(0,15)">
                        </td>
                        <td name="actualNumber"
                            <c:if test="${notice.status ne '已完成' and targetIdentity ne 'warehouse'}">class="hide"</c:if>>
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
                        <c:when test="${notice.id != null }">编辑</c:when>
                        <c:otherwise>保存</c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${notice.status ne '已完成' }">
                    <div class="buttonArea" id="submit">提交</div>
                </c:if>
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
                <select name="grainType" id="filter-grainType" style="width:15%;" class="inputArea"
                        style="display:none">
                    <option value="">全部</option>
                    <c:forEach items="${varietyList }" var="item">
                        <option value="${item.value }">${item.value }</option>
                    </c:forEach>
                </select>
                库点：
                <select name="receivePlace" id="filter-receivePlace" style="width:15%;" class="inputArea">
                    <option value="">全部</option>
                    <%--<c:forEach items="${basepoint }" var="point">--%>
                    <%--<option value="${point.warehouseShort }">${point.warehouseShort }</option>--%>
                    <%--</c:forEach>--%>
                </select>
                <%-- 库点类型：
                 <select id="filter-receivePlaceType" style="width:15%;" class="inputArea" style="display:none">
                     <option value="">全部</option>
                     <option value="直属单位">直属单位</option>
                     <option value="代储库">代储库</option>
                 </select>--%>
                <input type="hidden" name="warehoueYear">
                收获年份：
                <input name="produceYear" id="filter-warehoueYear" style="width:15%;" class="inputArea"/>
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
            <select id="filter-receivePlace" style="width:15%;" class="inputArea" style="display:none">
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
                    <td><input type="checkbox" name="addAll"></td>
                    <td>成交明细号</td>
                    <td>品种</td>
                    <td>成交金额</td>
                    <td>收获年份</td>
                    <td>企业</td>
                    <td>库点</td>
                    <td>仓号</td>
                    <td>计划数</td>
                </tr>
                <tr id="conclute-template" style="display:none">
                    <td><input type="checkbox" name="cjmx"></td>
                    <td align="left" name="dealSerial"></td>
                    <td align="left" name="grainType"></td>
                    <td align="right" name="dealPrice"></td>
                    <td name="warehoueYear"></td>
                    <td align="left" name="enterpriseName"></td>
                    <td style="display: none" name="enterpriseId"></td>
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

    layui.use('form',function () {
       var form = layui.form;
       form.render("select");
       form.render();
       form.on('checkbox', function(){
           if ($("#manr").is(":checked")){
               document.getElementById("annex").style.display = "";
           }else {
               document.getElementById("annex").style.display = "none";
           }
       });
    });


    document.getElementById("file-input").addEventListener("change",function () {
        $("#delFileBtn").attr("style","display:block;");
    });
    function resetFileInput(){
        $("#file-input").val("");
        $("#add-annex").html("添加附件");
        $("#fileName").html("");
        $("input[name='annex']").val("");
        $("#delFileBtn").hide();
        $("#openExce a").html("");
    }
    $("#add-annex").click(function(){
        $("#file-input").click();
    });
    $("#file-input").change(function(){
        var filename = $(this).val().split("\\");
        $("#fileName").html(filename[filename.length - 1]);
    });
    if ("${notice.annex}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
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
    $(".file-button").eq(0).show();
    <c:if test="${files ne null}">
    $(".file-button").each(function () {
        if ($(this).css("display") != "none" && $(this).find("lable").html() == '添加附件')
            return false;
        if ($(this).css("display") == "none") {
            $(this).show();
            return false;
        }
    });
    </c:if>

    $(".file-button>lable").click(function () {
        $(".file-input").eq($(this).parent().attr("index")).click();
    });

    $(".file-input").change(function () {
        var filename = $(this).val().split("\\");
        if (filename != "") {
            $(".file-button").eq($(this).attr("index")).find("lable").html(filename[filename.length - 1]);
            $(".file-button").eq($(this).attr("index")).find("i").show();
            $(".file-button").each(function () {
                if ($(this).css("display") != "none" && $(this).find("lable").html() == '添加附件')
                    return false;
                if ($(this).css("display") == "none") {
                    $(this).show();
                    return false;
                }
            });
        }
    });
    var lastClickTime = 0;
    var lastClickTime1 = 0;
    var DELAY = 20000;

    //品种
    var manuVarietyValue;
    //批号
    var manubatchNumberValue;
    //成本
    var manuCostValue;
    //直管属性
    var manuPipeValue;
    //收获年份
    var manuHarvValue;
    //企业
    var manuEnterValue;
    //库点
    var manuWareValue;
    //仓房
    var manuStoreValue;
    //计划数
    var manuPlanValue;
    //企业ID
    var manuEnterIdValue;

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

        if (patchAll != false) {
            if ($("#manr").is(":checked") && document.getElementById("fileName").innerText == "") {
                alert("*项为必填项,请补全相关信息");
                patchAll = false;
            }
        }




        var temp1 = true;
        $("#mytable tbody tr").each(function(){
            var a = $(this).children();
            if (a[0].innerText == "手工填报") {
                temp1 = false;
                return false;
            }
        });

        if (patchAll != false && temp1 == false){
            $("#mytable tbody tr").each(function(){
                var a = $(this).children()[1].innerText;
                if (a != 0 && a != "manuMark" ){
                    manuVarietyValue = document.getElementById("variety" + a).value;
                    manuWareValue = document.getElementById(a).value;
                    manuStoreValue = document.getElementById("store" + a).value;
                    manuHarvValue = $('#harv'+ a).html();

                    if (manuVarietyValue == "请选择" || manuWareValue == "请选择" || manuStoreValue == "请选择"){
                        alert("下拉框必须填上");
                        patchAll = false;
                        return false;
                    }

                    if (manuHarvValue == ""){
                        alert("请点击选择收获年份");
                        patchAll = false;
                        return false;
                    }
                }

            });
        }

        var isSame = 0;

        var accepteunit = $("#accepte-unit").val();

        if (!patchAll) {
            $("#save,#submit").show();
            return;
        }
        var detailData = [];

        if (temp1){
            $(".data-tr").each(function () {
                var accepteunitTemp = $(this).find("td[name='storageWarehouse']").attr("accepteunit")
                if (accepteunit != accepteunitTemp) {
                    isSame += 1;
                }

                detailData.push({
                    "enterpriseId":$(this).find("td[name='enterpriseId']").html().trim(),
                    "dealSerial": $(this).attr("tag") == "" ? 0 : $(this).attr("tag"),
                    "variety": $(this).find("td[name='variety']").html().trim(),
                    "batchNumber": $(this).find("td[name='batchNumber']").html().trim(),
                    "cost": parseFloat($(this).find("td[name='cost']>input").val().trim()),
                    "pipeAttribute": $(this).find("td[name='pipeAttribute']>input").val().trim(),
                    "harvestYear": $(this).find("td[name='harvestYear']").html().trim(),
                    "storageWarehouse": $(this).find("td[name='storageWarehouse']").html().trim(),
                    "warehouse": {"id":$(this).find("td[name='storageWarehouse']").attr('warehouseId')},
                    "storehouse": $(this).find("td[name='storehouse']").html().trim(),
                    "planNumber": $(this).find("td[name='planNumber']").find("input").val(),
                    "actualNumber": $(this).find("td[name='actualNumber']").find("input").val(),
                });
            });
        }else {
            $("#mytable tbody tr").each(function(){
                var a = $(this).children()[1].innerText;
                if (a != 0 && a != "manuMark" ){
                    manuVarietyValue = document.getElementById("variety" + a).value;
                    manubatchNumberValue = $('#batchNumber'+ a).html();
                    manuCostValue = document.getElementById("cost" + a).value;
                    manuPipeValue = document.getElementById("pipe" + a).value;
                    manuHarvValue = $('#harv'+ a).html();
                    manuEnterValue = $('#enter'+ a).html();
                    manuWareValue = document.getElementById(a).value;
                    manuStoreValue = document.getElementById("store" + a).value;
                    manuPlanValue = document.getElementById("plan" + a).value;
                    manuEnterIdValue = $('#enterId'+ a).html();

                    detailData.push({
                        "variety": manuVarietyValue,
                        "batchNumber": manubatchNumberValue,
                        "cost": parseFloat(manuCostValue),
                        "pipeAttribute": manuPipeValue.trim(),
                        "harvestYear": manuHarvValue,
                        "enterpriseId":manuEnterIdValue,
                        "storageWarehouse": manuWareValue,
                        "warehouse": {"id":"5EB278F981901FD3E053020C0A0ACA6B"},
                        "storehouse": manuStoreValue,
                        "planNumber": manuPlanValue,
                        "actualNumber":"",
                        "dealSerial": manubatchNumberValue,
                    });
                }
            });

        }


        // 将所有disabled全部移除
        let objs = $("input[disabled='disabled'],select[disabled='disabled']");
        $(objs).each(function () {
            $(this).removeAttr("disabled");
        });
        if (isSame > 0) {
            layer.msg("入库明细中有存储库点和接收单位不一致记录", {icon: 2})
            $("#save,#submit").show();
            return;
        }

        if ($(this).html().indexOf('保存') != -1) {
            var currentTime = Date.parse(new Date());
            if (currentTime - lastClickTime > DELAY) {
                lastClickTime = currentTime;
                $("#save").hide()
                $("form").ajaxSubmit({
                    type: "post",
                    data: {
                        "detailList": JSON.stringify(detailData),
                        "status": "待提交",
                        "noticeType": "入库"
                    },
                    success: function (data) {
                        if (data.success) {
                            layer.msg("保存成功", {icon: 1}, function () {
                                window.location.href = "${ctx}/RotateNotif/In.shtml?type=Warehouse";
                            });
                        } else {
                            layer.msg("保存失败", {icon: 2})
                            $("#save").show();
                            $(objs).each(function () {
                                $(this).attr("disabled", true);
                            });
                        }
                    }
                });
            }
        } else if ($(this).html().indexOf('提交') != -1) {
            var currentTime = Date.parse(new Date());
            if (currentTime - lastClickTime1 > DELAY) {
                lastClickTime = currentTime;
                $("#save").hide()
                var way = $("#save").html().indexOf("保存") != -1 ? "${ctx }/RotateNotif/Add.shtml" : "Edit.shtml";
                $("form").ajaxSubmit({
                    url: way,
                    type: "post",
                    data: {
                        "id": "${notice.id }",
                        "noticeType": "入库",
                        "detailList": JSON.stringify(detailData),
                        "status": "待审核",
                    },
                    success: function (data) {
                        if (data.success) {
                            layer.msg("信息提交成功", {icon: 1}, function () {
                                window.location.href = "${ctx}/RotateNotif/In.shtml?type=Warehouse";
                            });
                        } else {
                            layer.msg("信息提交失败", {icon: 2})
                            $("#save,#submit").show();
                            $(objs).each(function () {
                                $(this).attr("disabled", true);
                            });
                        }
                    }
                });
            }
        } else if ($(this).html().indexOf('编辑') != -1) {
            var currentTime = Date.parse(new Date());
            if (currentTime - lastClickTime > DELAY) {
                lastClickTime = currentTime;
                $("#save").hide()
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
                                window.location.href = "${ctx}/RotateNotif/In.shtml?type=Warehouse";
                            });
                        } else {
                            layer.msg("保存失败", {icon: 2})
                            $("#save,#submit").show();
                            $(objs).each(function () {
                                $(this).attr("disabled", true);
                            });
                        }
                    }
                });
            }
        } else {
            $("#save,#submit").show();
            $(objs).each(function () {
                $(this).attr("disabled", true);
            });
            return false;
        }

    });

    $('input[name="addAll"]').on("click", function () {
        if ($(this).is(':checked')) {
            $('input[name="cjmx"]').each(function () {
                $(this).prop("checked", true);
            });
        } else {
            $('input[name="cjmx"]').each(function () {
                $(this).prop("checked", false);
            });
        }
    });

    $("input[name='cjmx']").on("change",function(){
        let cjmxNum = $("input[name='cjmx']").length;
        let checkedNum = $("input[name='cjmx']:checked").length;
        if(cjmxNum == checkedNum){
            $("input[name='addAll']").prop("checked",true);
        } else {
            $("input[name='addAll']").prop("checked", false);
        }
    })

    var a=document.getElementById("data-result");
    var tr=a.getElementsByTagName("tr");

    var index1 = 0;//初始下标
    var indexArr= new Array();

    var manuWareHouseId = 1;
    $("#add-list").click(function () {
        var enterpriseId = $('#accepte-unit').find("option:selected").attr('enterpriseId');
        var accepteUnit = $("#accepte-unit option:selected").val();
        if (accepteUnit == null || accepteUnit == "") {
            layer.msg("请先选择接受单位");
            return;
        }

        if (tr.length > 2){
            var temp = 0;
            if ($("#manr").is(":checked")) {
                $("#mytable tbody tr").each(function(){
                    var a = $(this).children();
                    if (a[0].innerText == "非手工填报") {
                        temp = 1;
                        alert("已经添加了非手工填报数据");
                        return false;
                    }
                });
            }else {
                $("#mytable tbody tr").each(function(){
                    var a = $(this).children();
                    if (a[0].innerText == "手工填报") {
                        temp = 1;
                        alert("已经添加了手工填报数据");
                        return false;
                    }
                });
            }
            if(temp == 1){
                return;
            }
        }


        if ($("#manr").is(":checked")){

            $("#manuReportVariety").empty();
            $("#" + manuWareHouseId).empty();


            var manuRList;
            $.ajax({
                type:'POST',
                url:'${ctx }/storageWarehouse/manReport.shtml',
                data: {'enterpriseId': enterpriseId},
                async: false,
                error: function (request) {

                },
                success: function (manuReportDataList) {
                    manuRList = manuReportDataList;
                    console.log(manuRList);
                }
            })


            index1++;
            indexArr.push(index1);
            var showHtml = $("#show").html();

            var html = "<tr id='tr##'>"+showHtml+"</tr>";
            html = html.replace(/manuMark/g,  manuWareHouseId);
            html = html.replace(/manuEnterpriseId/g,  enterpriseId);
            html = html.replace(/id_manuWareHouse/g,  manuWareHouseId);
            html = html.replace(/id_maunStoreHouse/g, 'store'+ manuWareHouseId);
            html = html.replace(/id_manuReportVariety/g, 'variety'+ manuWareHouseId);
            html = html.replace(/id_manuBatchNumber/g, 'batchNumber'+ manuWareHouseId);
            html = html.replace(/id_manuCost/g, 'cost'+ manuWareHouseId);
            html = html.replace(/id_manuPipeAttribute/g, 'pipe'+ manuWareHouseId);
            html = html.replace(/id_maunHarvestYear/g, 'harv'+ manuWareHouseId);
            html = html.replace(/id_enterpriseId/g, 'enterId'+ manuWareHouseId);
            html = html.replace(/id_enterpriseName/g, 'enter'+ manuWareHouseId);
            html = html.replace(/id_planNumber/g, 'plan'+ manuWareHouseId);
            html = html.replace(/filter_manuWareHouse/g, manuWareHouseId);
            html = html.replace(/##/g,index1);//把##替换成数字
            html = html.replace(/handManuMark/g, "手工填报");
            html = html.replace(/manubatchNumber/g, manuRList[0].manuBatchNumber);
            html = html.replace(/manuEnterpriseName/g, manuRList[0].enterpriseName);
            $("#show").before($(html));


            $("#variety" + manuWareHouseId).append("<option>请选择</option>");
            for (var i = 0; i < manuRList[0].variety.length; i++){
                $("#variety" + manuWareHouseId).append("<option>" + manuRList[0].variety[i] + "</option>");
            }

            $("#" + manuWareHouseId).append("<option>请选择</option>");
            for (var i = 0; i < manuRList.length; i++){
                $("#" + manuWareHouseId).append("<option>" + manuRList[i].storageShortName + "</option>");
            }

            layui.use('form',function () {
                var form = layui.form;
                form.on('select('+manuWareHouseId+')', function(data){
                    $("#store" + data.elem.id).empty();
                    $("#store" + data.elem.id).append("<option>请选择</option>");
                    for (var i = 0; i < manuRList.length; i++){
                        if(data.value == manuRList[i].storageShortName ){
                            var warehouseNumberList = manuRList[i].warehouseNumber;
                            for(var j = 0; j<warehouseNumberList.length;j++){
                                $("#store" + data.elem.id).append("<option>" + warehouseNumberList[j] + "</option>");
                            }
                        }
                    }
                    form.render("select");
                    form.render();
                })
                form.render("select");
                form.render();
            });

            $(".harvestYear").removeAttr("lay-key");
            layui.use('laydate', function(){
                var laydate = layui.laydate
                $('.harvestYear').each(function(){
                    laydate.render({
                        elem: this,
                        trigger: 'click',
                        type: "year",
                        format: "yyyy",
                    });
                });
            });
            manuWareHouseId = manuWareHouseId + 1;
            return;
        }


        var index = layer.load(1);
        $('#filter-receivePlace').empty();
        if (enterpriseId) {
            $.ajax({
                type: 'POST',
                url: '${ctx }/storageWarehouse/listWarehouseByHost.shtml',
                data: {'enterpriseId': enterpriseId},
                async: false,
                error: function (request) {

                },
                success: function (list) {
                    // if (list.length > 1) {
                    //     $('#filter-receivePlace').append('<option value="hostId-' + enterpriseId + '">全部</option>');
                    // }
                    $('#filter-receivePlace').append('<option value="hostId-' + enterpriseId + '">全部</option>');
                    for (var i = 0; i < list.length; i++) {
                        $('#filter-receivePlace').append('<option warehouseId="'+list[i].id+'">' + list[i].warehouseShort + '</option>')
                    }
                }
            });
        }
        else {
            $('#filter-receivePlace').append('<option value="">全部</option>')
        }

        $("#concluteButton").click();

        $("#float-alert").slideToggle(500, function () {
            $("#table-wapper").slideToggle(500);
        });
        layer.close(index);
    });

    $(".remove-detail").click(function () {
        $(this).parent().parent().hide(500, function () {
            $(this).remove();
        });
    });


    function deleteRow(inde){
        $("#tr" + inde).remove();
        var a = indexArr.indexOf(parseInt(inde));
        if (a > -1) {
            indexArr.splice(a, 1);
        }
    }


    $("#close-float-alert").click(function () {
        $("#table-wapper").slideToggle(500, function () {
            $("#float-alert").slideToggle(500, function () {
                $("#schemeDetail-data-list").find("tr").remove();
            });
        });
    });

    $("#add-tolist").click(function () {

        $("#schemeDetail-data-list").find("input[name='cjmx']").each(function () {
            if ($(this).prop("checked")) {
                var trdata = $(this).parent().parent();
                if ($(".data-tr[tag='" + $(trdata).attr("tag") + "']").length > 0)
                    return;
                var template = $("#template-tr").clone(true);
                $(template).attr("tag", $(trdata).attr("tag"));
                $(template).find("td[name='mark']").html("非手工填报");
                $(template).find("td[name='variety']").html($(trdata).find("td[name='grainType']").html());
                $(template).find("td[name='batchNumber']").html($(trdata).find("td[name='dealSerial']").html());
                $(template).find("td[name='cost']").find("input").val("");
                // html($(trdata).find("td[name='dealPrice']").html());
                $(template).find("td[name='pipeAttribute']").find("input").val("省储");
                $(template).find("td[name='harvestYear']").html($(trdata).find("td[name='warehoueYear']").html());
                $(template).find("td[name='storageWarehouse']").html($(trdata).find("td[name='receivePlace']").html()).attr("accepteunit", $("#accepte-unit").val()).attr("warehouseId",$(trdata).find("td[name='receivePlace']").attr("warehouseId"));
                $(template).find("td[name='storehouse']").html($(trdata).find("td[name='storehouse']").html());
                $(template).find("td[name='planNumber']").find("input").val($(trdata).find("td[name='quantity']").html());
                $(template).find("td[name='enterpriseName']").html($(trdata).find("td[name='enterpriseName']").html());
                $(template).find("td[name='enterpriseId']").html($(trdata).find("td[name='enterpriseId']").html());
                $(template).addClass("data-tr");
                $("#data-result").append($(template));
                $(template).slideToggle(500);
            }
        });
        $("#close-float-alert").click();
    });

    $("#concluteButton").click(function () {
        $("#concluteForm").ajaxSubmit({
            success: function (data) {
                $("#schemeDetail-data-list").find("tr").remove();
                for (var i = 0; i < data.length; i++) {
                    var dataMode = $("#conclute-template").clone(true);
                    $(dataMode).attr("tag", data[i]["dealSerial"]);
                    $(dataMode).find("td[name='dealSerial']").html(data[i]["dealSerial"]);
                    $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
                    $(dataMode).find("td[name='enterpriseName']").html(data[i]["enterpriseName"]);
                    $(dataMode).find("td[name='enterpriseId']").html(data[i]["enterpriseId"]);
                    $(dataMode).find("td[name='dealPrice']").html(data[i]["dealAmount"]);
                    $(dataMode).find("td[name='warehoueYear']").html(data[i]["produceYear"]);
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
            window.location.href = "${ctx}/RotateNotif/In.shtml?type=Warehouse";
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
            data: '{"noticeSerial":"' + noticeSerialVal + '", "type":"in"}',
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

    $("[name='actualNumber'] input").on("change",function () {
        if($(this).val()!=null) {
            let actualNumber = Number($(this).val());
            let planNumber = Number($(this).parent().prevAll("[name='planNumber']").find("input").val());
            if(actualNumber>planNumber){
                $(this).val("");
                layerMsgError("实际数大于计划数");
            }

        }
    });

</script>
<%@ include file="../common/AdminFooter.jsp" %>