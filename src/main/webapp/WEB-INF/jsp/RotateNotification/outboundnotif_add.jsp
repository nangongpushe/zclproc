<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        /*width: 9%;*/
        border: 1px solid #e2e2e2;
        padding: 10px 0;
    }
    .table_my1 tr td{
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

    #float-alert-01 {
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

    #table-wapper-01 {
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

    #table-wapper-01 table {
        margin: 0;
        border-bottom: none;
    }

    #table-wapper table td:first-child {
        width: 3%;
    }

    #table-wapper-01 table td:first-child {
        width: 3%;
    }

    #close-float-alert {
        position: relative;
        left: 88.5%;
        font-size: 30px;
        color: RGB(42, 180, 168);
        cursor: pointer;
    }

    #close-float-alert-01 {
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

    #schemeDetail-data-list-01 input[type=checkbox] {
        width: 50%;
        outline: none;
    }

    #out-table {
        height: 310px;
        overflow: auto;
        margin-top: 20px;
    }

    #out-table-01 {
        height: 310px;
        overflow: auto;
        margin-top: 20px;
    }

    .he {
        display: none;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>通知书管理</li>
        <li>出库通知书</li>
        <li class="active">${notice.id ne null?'编辑':'新增' }出库通知书</li>
    </ol>
</div>
<div id="outSide">
    <input type = "hidden" id = "batchNumber1" value = ""/>
    <form action="${ctx }/RotateNotif/Add.shtml" method="Post" enctype="multipart/form-data" class="layui-form">
        <div id="dataArea" class="infoArea">
            <span class="title">出库通知书信息</span>
            <div id="mainInfo">
                <div style="display:none">
                    <span style="text-align:right"><b class="requiredData">*</b>轮换类别：</span> <select
                        class="inputArea" id="rotate-type" name="rotateType">
                    <option>常规轮换</option>
                </select>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>依据：</span>
                    <input name="documentNumber" class="inputArea" autocomplete="off"
                           <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if>
                           value="${notice.documentNumber }" maxlength="45">
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>通知书编号：</span>
                    <input class="inputArea" type="text" autocomplete="off"
                           <c:if test="${notice.status == '已完成'}">disabled="disabled"</c:if>
                           value="${notice.noticeSerial }"
                           placeholder="格式:年份-编号  例：2018-1" name="noticeSerial" maxlength="15" disabled="disabled">

                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>接收单位：</span>
                    <div class="layui-input-inline inputArea" style="border: 0">
                        <select id="accepte-unit" lay-search
                                <c:if test="${notice.status == '已完成'}">disabled="disabled"</c:if> name="storeEnterprise.id"
                                onchange="searchJiaoyi(this)">
                            <option value="">--请选择--</option>
                            <c:forEach items="${basepoint }" var="point">
                                <option
                                        <c:if test="${notice.storeEnterprise.id eq point.id }">selected</c:if>
                                        enterpriseId="${point.id}" value="${point.id}"
                                >${point.enterpriseName }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div>
                    <span style="text-align:right"><b class="requiredData">*</b>出库截止时间：</span>
                    <input id="storage-date" name="storageDate" autocomplete="off"
                           <c:if test="${notice.status == '已完成'}">disabled="disabled"</c:if> class="inputArea"
                           type="text"
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
                <div>
                    <span style="text-align:right"><b class="red" id="annex" <c:if test="${notice.manuReport eq '手工填报'}">style="display: inline"</c:if> style="display: none">*</b>附件：</span>
                    <div class="buttonArea" id="add-annex">添加附件</div>
                    <input type="hidden" name="annex" value="${notice.annex}"/>
                    <input type="file"  style="display:none;" id="file-input" name="file">
                    <span id="fileName">
                        <a href="${ctx }/sysFile/download.shtml?fileId=${notice.annex}" style="margin:0 10px;">${filename.fileName}</a>
                    </span>
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
                    <textarea <c:if test="${notice.status == '已完成'}"> readonly </c:if> name="remark" rows="4"
                           class="inputArea" maxlength="200">${notice.remark }</textarea>
                </div>
            </div>
        </div>
        <div id="listArea">
            <div style="display: flex;flex-direction: row;align-items: center;height: 40px">
                <c:if test="${notice.status ne '已完成' }">
                    <div class="buttonArea" id="add-list">新增</div>
                    <div class=" layui-inline" style="display: flex;flex-direction: row;align-items: center;height: 30px;padding-top:6px;margin-left: 10px;">
                        <nobr>
                            <input id="manr" type="checkbox" name="pestCheckTypeList" value="手工填报" title="手工填报" lay-skin="primary" <c:if test="${notice.manuReport eq '手工填报'}">checked</c:if>/>
                        </nobr>
                    </div>
                </c:if>
            </div>
            <table class="table_my1" id="mytable">
                <thead>
                    <tr>
                        <td align="center">品种</td>
                        <td align="center">批号</td>
                        <td align="center">成本</td>
                        <td align="center">直管属性</td>
                        <td align="center">入库年份</td>
                        <td align="center">企业</td>
                        <td align="center">储存库点</td>
                        <td align="center">仓房编号</td>
                        <td align="center">计划数(吨)</td>
                        <td align="center"
                            <c:if test="${notice.status ne '已完成' and targetIdentity ne 'warehouse'}">class="he"</c:if>>
                            实际数(吨)
                        </td>
                        <c:if test="${notice.status ne '已完成' }">
                            <td align="center">操作</td>
                        </c:if>
                    </tr>
                </thead>
                <tbody id="data-result">
                    <tr id="template-tr">
                        <td name = "mark" style="display: none"></td>
                        <td align="left" name="variety"></td>
                        <td align="center" name="batchNumber" onclick="showQualityResult(this.id)" id=""></td>
                        <td align="center" name="cost">
                            <input style="width: 80%" class="inputArea" type="number" oninput="if(value.length>15)value=value.slice(0,15)"/>
                        </td>
                        <td name="pipeAttribute" align="center">
                            <input style="width: 80%" class="inputArea" maxlength="10"/>
                        </td>
                        <td name="harvestYear" align="center"></td>
                        <td name="enterpriseName"></td>
                        <td name="enterpriseId" style="display: none">
                        <td align="left" name="storageWarehouse"></td>
                        <td align="left" name="storehouse"></td>
                        <td name="planNumber" align="center">
                            <input style="width: 80%" class="inputArea" onchange="numberFixed(this,3)" type="number" oninput="if(value.length>15)value=value.slice(0,15)" onchange="numberFixed(this,3)"/>
                        </td>
                        <td name="actualNumber" style="display:none" align="right">
                            <input style="width: 80%" class="inputArea"  type="number" oninput="if(value.length>15)value=value.slice(0,15)"  onchange="numberFixed(this,3)"/>
                        </td>
                        <td name="manuActualNumber" style="display: none"></td>
                        <td>
                            <div class="buttonArea remove-detail">删除</div>
                        </td>
                    </tr>
                    <c:forEach items="${notice.noticeDetail }" var="item">
                        <tr class="data-tr" tag="${item.dealSerial }">
                            <td name = "mark" style="display: none">${item.manuReport}</td>
                            <td name="variety" align="left">${item.variety}</td>
                            <td name="batchNumber" align="center">${item.batchNumber}</td>
                            <td name="cost" align="center">
                                <input style="width: 80%"
                                       <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if> type="number"
                                       class="inputArea" value="${item.cost }" oninput="if(value.length>15)value=value.slice(0,15)"/>
                            </td>
                            <td name="pipeAttribute" align="center"><input style="width: 80%"
                                                                           class="inputArea"
                                                                           <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if>
                                                                           value="${item.pipeAttribute }" maxlength="10"></td>
                            <td name="harvestYear" align="center">
                                    ${item.harvestYear }
                            </td>
                            <td name="enterpriseName">${item.enterpriseName}</td>
                            <td name="enterpriseId" style="display: none">${item.enterpriseId}</td>
                            <td name="storageWarehouse" align="left" accepteunit="${notice.storeEnterprise.id}" warehouseId="${item.warehouse.id}">
                                    ${item.warehouse.warehouseShort}
                            </td>
                            <td name="storehouse" align="left">
                                    ${item.storehouse }
                            </td>
                            <td name="planNumber" align="center">
                                <input style="width: 80%"
                                       <c:if test="${notice.status == '已完成'}">readonly="readonly"</c:if> class="inputArea"
                                       value="${item.planNumber }" onchange="numberFixed(this,3)"  type="number" oninput="if(value.length>15)value=value.slice(0,15)">
                            </td>
                            <td name="actualNumber" align="center"
                                <c:if test="${notice.status ne '已完成' and targetIdentity ne 'warehouse'}">class="he"</c:if>>
                                <input style="width: 80%" class="inputArea" value="${item.actualNumber }"
                                       onchange="numberFixed(this,3)"  type="number" oninput="if(value.length>15)value=value.slice(0,15)" >
                            </td>

                            <td name="manuActualNumber" style="display: none">${item.manuActualNumber }</td>

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
            <form id="concluteForm" action="${ctx }/rotateConclute/outList.shtml" method="POST">
                <input type="hidden" name="noticeType" value="出库">
                粮食品种：
                <select name="grainType" id="filter-grainType" style="width:15%;" class="inputArea"
                        style="display:none">
                    <option value="">全部</option>
                    <c:forEach items="${varietyList }" var="item">
                        <option value="${item.value }">${item.value }</option>
                    </c:forEach>
                </select>
                <input name="receivePlace" type="hidden"/>
                库点：
                <select name="deliveryPlace" id="filter-receivePlace" style="width:15%;" class="inputArea"
                        style="display:none">
                    <option value="">全部</option>

                </select>
                收获年份：
                <input name="warehoueYear" id="filter-warehoueYear" style="width:15%;" class="inputArea"/>
                仓号：
                <input name="storehouse" id="filter-storehouse" style="width:15%;" class="inputArea"/><br/>
                <div><br>
                    计划数：
                    <input name="quantity" id="filter-quantity" style="width:15%;" class="inputArea" autocomplete="off"/>
                    <div id="concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div>
                    <div class="buttonArea" id="select-button1" onclick="chongzi();">重置</div>
                </div>
            </form>

            <form id="out-table">
                <table>
                    <thead>
                        <tr>
                            <td align="center"><input type="checkbox" name="addAll"></td>
                            <td align="center">成交明细号</td>
                            <td align="center">品种</td>
                            <td align="center">成交金额</td>
                            <td align="center">收获年份</td>
                            <td align="center">企业</td>
                            <td align="center">存储库点</td>
                            <td align="center">仓号</td>
                            <td align="center">剩余计划数(吨)</td>
                        </tr>
                        <tr id="conclute-template" style="display:none">
                            <td><input type="checkbox" name="cjmx"></td>
                            <td align="left" name="dealSerial"></td>
                            <td align="left" name="grainType"></td>
                            <td align="left" name="dealPrice"></td>
                            <td align="center" name="warehoueYear"></td>
                            <td align="left" name="enterpriseName"></td>
                            <td style="display: none" name="enterpriseId"></td>
                            <td align="left" name="receivePlace"></td>
                            <td align="left" name="storehouse"></td>
                            <td align="right" name="quantity"></td>
                            <td style="display: none" name="batchNumber"></td>
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

<div id="float-alert-01">
    <div id="table-wapper-01">
        <span class="title">明细选择</span>
        <i id="close-float-alert-01" class="layui-icon">&#x1006;</i>
        <div style="margin-top:2%;padding-bottom:2%;border-bottom:1px solid #ccc">
            <form id="concluteForm-01" action="${ctx }/rotateConclute/outManuList.shtml" method="POST">
                <input type="hidden" name="noticeType" value="出库">
                粮食品种：
                <select name="grainType" id="filter-grainType-01" style="width:15%;" class="inputArea"
                        style="display:none">
                    <option value="">全部</option>
                    <c:forEach items="${varietyList }" var="item">
                        <option value="${item.value }">${item.value }</option>
                    </c:forEach>
                </select>
                <input name="receivePlace" type="hidden"/>
                库点：
                <select name="deliveryPlace" id="filter-receivePlace-01" style="width:15%;" class="inputArea"
                        style="display:none">
                    <option value="">全部</option>
                </select>
                收获年份：
                <input name="warehoueYear" id="filter-warehoueYear-01" style="width:15%;" class="inputArea"/>
                仓号：
                <input name="storehouse" id="filter-storehouse-01" style="width:15%;" class="inputArea"/><br/>
                <div><br>
                    数量：
                    <input name="quantity" id="filter-quantity-01" style="width:15%;" class="inputArea" autocomplete="off"/>
                    <div id="concluteButton-01" style="margin-left:20px;" class="buttonArea">搜索</div>
                    <div class="buttonArea" id="select-button1-01" onclick="chongzi01();">重置</div>
                </div>
            </form>

            <form id="out-table-01">
                <table>
                    <thead>
                        <tr>
                            <td align="center"><input type="checkbox" name="addAll"></td>
                            <td align="center">品种</td>
                            <td align="center">收获年份</td>
                            <td align="center">企业</td>
                            <td align="center">存储库点</td>
                            <td align="center">仓号</td>
                            <td align="center">数量</td>
                        </tr>
                        <tr id="conclute-template-01" style="display:none">
                            <td><input type="checkbox" name="cjmx"></td>
                            <td align="left" name="grainType"></td>
                            <td align="center" name="warehoueYear"></td>
                            <td style="display: none" name="enterpriseId"></td>
                            <td align="left" name="enterpriseName"></td>
                            <td style="display: none" name="enterpriseId"></td>
                            <td align="left" name="receivePlace"></td>
                            <td align="left" name="storehouse"></td>
                            <td align="right" name="quantity"></td>
                            <td style="display: none" name="batchNumber"></td>
                        </tr>
                    </thead>
                    <tbody id="schemeDetail-data-list-01">
                    </tbody>
                </table>
            </form>
            <div style="text-align:right;margin-top:20px;">
                <div class="buttonArea" id="add-tolist-01">添加</div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="qualityResultModal" tabindex="-1" role="dialog" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog modal-lg" style="width:1350px">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">质检结果</h4>
            </div>
            <div class="modal-body">
                <div class="layui-form" lay-filter="searchQualityResult" id="searchQualityResult">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">粮食品种:</label>
                            <div class="layui-input-inline">
                                <select name="variety1" lay-search>
                                    <option value="">请选择</option>
                                    <c:forEach var="item" items="${grainTypes}">
                                        <option value="${item.value}">${item.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">收获年份:</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" name="harvestYear" id="harvestYear" autocomplete="off">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label ">仓号:</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" name="storeEncode" id="storeEncode" autocomplete="off">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">产地:</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" name="origin" id="origin" autocomplete="off">
                            </div>
                        </div>
                        <input type="hidden" class="layui-input" name="index" id="index">
                        <div class="layui-inline">
                            <button class=" layui-btn layui-btn-primary layui-btn-small"
                                    onclick="reloadTable()">查询
                            </button>
                        </div>
                    </div>

                </div>
                <table class="layui-table" lay-filter="qualityResultTable" id="myqualityResultModalTable"></table>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                        onclick="selectQualityResult('qualityResultModal','myqualityResultModalTable')">
                    确定
                </button>
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                        onclick="hideModal('qualityResultModal','myqualityResultModalTable')">
                    取消
                </button>
            </div>
        </div>
    </div>
</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>
<script>
        layui.use('form',function () {
            var form = layui.form;
            form.render('select');
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
        var noticeSerialVal = "${notice.noticeSerial}";

        var undefind = undefind;

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

        laydate.render({
            elem: "#filter-warehoueYear-01",
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
        var lastClickTime2 = 0;
        var DELAY = 20000;
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

            if (!patchAll) {
                $("#save,#submit").show();
                return;
            }

            var temp2 = 0;
            $("#mytable tbody tr").each(function(){
                var a = $(this).children();
                if (a[2].innerText == "请选择") {
                    temp2 = 1;
                    alert("必须要选择批号");
                    return false;
                }
            });

            if (temp2 == 1){
                $("#save,#submit").show();
                return;
            }

            var temp1 = true;
            $("#mytable tbody tr").each(function(){
                var a = $(this).children();
                if (a[0].innerText == "手工填报") {
                    temp1 = false;
                    return false;
                }
            });


           if (temp1){
               var detailData = [];
               var flage = false
               $(".data-tr").each(function (index) {
                   let dealSerial = $(this).attr("tag");
                   let planNum = Number($(this).find("td[name='planNumber']").find("input").val());
                   // 判断剩余计划数量
                   $.ajax({
                       url: "${ctx}/rotateConclute/surplusPlanNum.shtml",
                       type: "post",
                       async: false,
                       data: {
                           dealSerial: dealSerial,
                           noticeId: "${notice.id}",
                       },
                       success: function (data) {
                           if(planNum > data.data){
                               layer.msg("第"+(index+1)+"行计划数量大于剩余计划数量")
                               flage = true;
                           }
                       }
                   })

                   if(flage)
                       return false

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
                       "manuReport": "非手工填报",
                   });
               });

               if(flage){
                   $("#save,#submit").show();
                   return;
               }
               // 将所有disabled全部移除
               let objs = $("input[disabled='disabled'],select[disabled='disabled']");
               $(objs).each(function () {
                   $(this).removeAttr("disabled");
               });

               if ($(this).html().indexOf('保存') != -1) {
                   var currentTime = Date.parse(new Date());
                   if (currentTime - lastClickTime > DELAY) {
                       lastClickTime = currentTime;
                       $("#save").hide()
                       $("form").ajaxSubmit({
                           type: "post",
                           data: {
                               "detailList": JSON.stringify(detailData),
                               "noticeType": "出库",
                               "status": "待提交"
                           },
                           success: function (data) {
                               if (data.success) {
                                   layer.msg("保存成功", {icon: 1}, function () {
                                       window.location.href = "${ctx}/RotateNotif/Out.shtml?type=Warehouse";
                                   });
                               } else {
                                   layer.msg("保存失败", {icon: 2});
                                   $("#save,#submit").show();
                                   $(objs).each(function () {
                                       $(this).attr("disabled", true);
                                   });
                               }
                           }
                       });
                   }
               } else if ($(this).html().indexOf('提交') != -1) {
                   var way = $("#save").html().indexOf("保存") != -1 ? "${ctx }/RotateNotif/Add.shtml" : "Edit.shtml";
                   var currentTime2 = Date.parse(new Date());
                   if (currentTime2 - lastClickTime2 > DELAY) {
                       lastClickTime2 = currentTime;
                       $("#submit").hide()
                       $("form").ajaxSubmit({
                           url: way,
                           type: "post",
                           data: {
                               "id": "${notice.id }",
                               "noticeType": "出库",
                               "detailList": JSON.stringify(detailData),
                               "status": "待审核",
                           },
                           success: function (data) {
                               if (data.success) {
                                   layer.msg("信息提交成功", {icon: 1}, function () {
                                       window.location.href = "${ctx}/RotateNotif/Out.shtml?type=Warehouse";
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
                                       window.location.href = "${ctx}/RotateNotif/Out.shtml?type=Warehouse";
                                   })
                               } else {
                                   layer.msg("保存失败", {icon: 2});
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
           } else {
               var detailData = [];
               var flage = false;
               $(".data-tr").each(function (index) {
                   let planNum = Number($(this).find("td[name='planNumber']").find("input").val());
                   let actualNumber = Number($(this).find("td[name='manuActualNumber']").html());
                   if(planNum > actualNumber){
                       layer.msg("第"+(index+1)+"行计划数量大于剩余计划数量")
                       flage = true;
                   }

                   if(flage){
                       return false
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
                       "manuActualNumber": Number($(this).find("td[name='manuActualNumber']").html()),
                       "manuReport": "手工填报",
                   });
               });

               if(flage){
                   $("#save,#submit").show();
                   return;
               }

               // 将所有disabled全部移除
               let objs = $("input[disabled='disabled'],select[disabled='disabled']");
               $(objs).each(function () {
                   $(this).removeAttr("disabled");
               });

               if ($(this).html().indexOf('保存') != -1) {
                   var currentTime = Date.parse(new Date());
                   if (currentTime - lastClickTime > DELAY) {
                       lastClickTime = currentTime;
                       $("#save").hide()
                       $("form").ajaxSubmit({
                           type: "post",
                           data: {
                               "detailList": JSON.stringify(detailData),
                               "noticeType": "出库",
                               "status": "待提交"
                           },
                           success: function (data) {
                               if (data.success) {
                                   layer.msg("保存成功", {icon: 1}, function () {
                                       window.location.href = "${ctx}/RotateNotif/Out.shtml?type=Warehouse";
                                   });
                               } else {
                                   layer.msg("保存失败", {icon: 2});
                                   $("#save,#submit").show();
                                   $(objs).each(function () {
                                       $(this).attr("disabled", true);
                                   });
                               }
                           }
                       });
                   }
               } else if ($(this).html().indexOf('提交') != -1) {
                   var way = $("#save").html().indexOf("保存") != -1 ? "${ctx }/RotateNotif/Add.shtml" : "Edit.shtml";
                   var currentTime2 = Date.parse(new Date());
                   if (currentTime2 - lastClickTime2 > DELAY) {
                       lastClickTime2 = currentTime;
                       $("#submit").hide()
                       $("form").ajaxSubmit({
                           url: way,
                           type: "post",
                           data: {
                               "id": "${notice.id }",
                               "noticeType": "出库",
                               "detailList": JSON.stringify(detailData),
                               "status": "待审核",
                           },
                           success: function (data) {
                               if (data.success) {
                                   layer.msg("信息提交成功", {icon: 1}, function () {
                                       window.location.href = "${ctx}/RotateNotif/Out.shtml?type=Warehouse";
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
                                       window.location.href = "${ctx}/RotateNotif/Out.shtml?type=Warehouse";
                                   })
                               } else {
                                   layer.msg("保存失败", {icon: 2});
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
           }

        });

        function showQualityResult(id){
            $('#batchNumber1').val(id);
            if ($('#'+id).html() == "请选择") {
                layui.form.render("select", "searchQualityResult");
                layui.laydate.render({
                    elem: $('#searchQualityResult [name="harvestYear"]')[0],
                    type: "year",
                    format: "yyyy",
                    change: function(value, date, endDate){
                        $('#searchQualityResult [name="harvestYear"]').val(value);
                        if($(".layui-laydate").length){
                            $(".layui-laydate").remove();
                        }
                    },
                });

                layui.table.render({
                    elem: "#myqualityResultModalTable",
                    loading: true,
                    url: '${ctx}/QualityResult/selectQualityResult.shtml',
                    method: "POST",
                    width: 1300,
                    request: {
                        pageName: 'pageIndex',
                        limitName: 'pageSize'
                    },
                    cols: [[
                        {checkbox: true, fixed: true},
                        {field: 'storeEncode', title: '仓号', width: 100, align: 'center'},
                        {field: 'variety', title: '粮食品种', width: 100, align: 'center'},
                        {field: 'harvestYear', title: '收获年份', width: 100, align: 'center'},
                        {field: 'origin', title: '产地', width: 100, align: 'center'},
                        {field: 'sampleNo', title: '样品编号', width: 100, align: 'center'},
                        {field: 'reportUnit', title: '检测单位', width: 100, align: 'center'},
                        {field: 'quantity', title: '数量', width: 100, align: 'center'},
                        {field: 'testDate', title: '检测时间', width: 200, align: 'center'},
                        {field: 'dealserial', title: '交易号', width: 200, align: 'center'},
                    ]],
                    page: true,//开启分页
                    limit: pagesize,
                    limits:[10],
                    id: "myqualityResultModalTable"
                });
                $('#qualityResultModal').modal('show');
            }
        }

        function reloadTable(){
            layui.table.reload("myqualityResultModalTable", {
                method: "POST",
                where: {
                    variety1: $('#searchQualityResult [name="variety1"]').val(),
                    harvestYear: $('#searchQualityResult [name="harvestYear"]').val(),
                    storeEncode: $('#searchQualityResult [name="storeEncode"]').val(),
                    origin1: $('#searchQualityResult [name="origin"]').val()
                }
            });
        }

        function hideModal (modal, tableId){
            layui.table.reload(tableId);
            $('#' + modal).modal('hide');
        }

        function selectQualityResult(modal, tableId) {
            var selectList = layui.table.checkStatus(tableId).data;
            if (null == selectList || selectList.length == 0) {
                layerMsgError("请勾选数据信息");
                return;
            } else if (selectList.length > 1) {
                layer.msg("只能选择一条质检结果", {icon: 0});
                return;
            }

           var id = $("#batchNumber1").val();
            $('#'+id).html(selectList[0].dealserial||"");
            hideModal(modal, tableId);
        }


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
        $("#add-list").click(function () {

            var enterpriseId = $('#accepte-unit').find("option:selected").attr('enterpriseId');
            var accepteUnit = $("#accepte-unit option:selected").val();

            if (accepteUnit == null || accepteUnit == "") {
                layer.msg("请先选择接受单位");
                return;
            }


            if (tr.length > 1){
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



            var index = layer.load(1);
            $('#filter-receivePlace').empty();
            $('#filter-receivePlace-01').empty();

           if($("#manr").is(":checked")){
               if (enterpriseId) {
                   $.ajax({
                       type: 'POST',
                       url: '${ctx }/storageWarehouse/listWarehouseByHost.shtml',
                       data: {'enterpriseId': enterpriseId},
                       async: false,
                       error: function (request) {

                       },
                       success: function (list) {
                           if (list.length > 1) {
                               $('#filter-receivePlace-01').append('<option value="hostId-' + enterpriseId + '">全部</option>');
                           }
                           for (var i = 0; i < list.length; i++) {
                               $('#filter-receivePlace-01').append('<option warehouseId="'+list[i].id+'">' + list[i].warehouseShort + '</option>')
                           }
                       }
                   });
               } else {
                   $('#filter-receivePlace-01').append('<option value="">全部</option>')
               }

               $("#concluteButton-01").click();

               $("#float-alert-01").slideToggle(500, function () {
                   $("#table-wapper-01").slideToggle(500);
               });
           }else {
               if (enterpriseId) {
                   $.ajax({
                       type: 'POST',
                       url: '${ctx }/storageWarehouse/listWarehouseByHost.shtml',
                       data: {'enterpriseId': enterpriseId},
                       async: false,
                       error: function (request) {

                       },
                       success: function (list) {
                           if (list.length > 1) {
                               $('#filter-receivePlace').append('<option value="hostId-' + enterpriseId + '">全部</option>');
                           }
                           for (var i = 0; i < list.length; i++) {
                               $('#filter-receivePlace').append('<option warehouseId="'+list[i].id+'">' + list[i].warehouseShort + '</option>')
                           }
                       }
                   });
               } else {
                   $('#filter-receivePlace').append('<option value="">全部</option>')
               }

               $("#concluteButton").click();

               $("#float-alert").slideToggle(500, function () {
                   $("#table-wapper").slideToggle(500);
               });
           }

           layer.close(index);

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

        $("#close-float-alert-01").click(function () {
            $("#table-wapper-01").slideToggle(500, function () {
                $("#float-alert-01").slideToggle(500, function () {
                    $("#schemeDetail-data-list-01").find("tr").remove();
                });
            });
        });

        var trindex = -1;
        $("#add-tolist").click(function () {
            $("#schemeDetail-data-list").find("input[name='cjmx']").each(function () {
                if ($(this).prop("checked")) {
                    trindex = trindex + 1;
                    var trdata = $(this).parent().parent();
                    if ($(".data-tr[tag='" + $(trdata).attr("tag") + "']").length > 0)
                        return;
                    var template = $("#template-tr").clone(true);
                    $(template).attr("tag", $(trdata).attr("tag"));
                    $(template).find("td[name='mark']").html("非手工填报");
                    $(template).find("td[name='variety']").html($(trdata).find("td[name='grainType']").html());
                    $(template).find("td[name='batchNumber']").attr("id",trindex);
                    $(template).find("td[name='batchNumber']").html($(trdata).find("td[name='batchNumber']").html()||"请选择");
                    $(template).find("td[name='cost']").find("input").val("");
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


        $("#add-tolist-01").click(function () {
            $("#schemeDetail-data-list-01").find("input[name='cjmx']").each(function () {
                if ($(this).prop("checked")) {
                    trindex = trindex + 1;
                    var trdata = $(this).parent().parent();
                    if ($(".data-tr[tag='" + $(trdata).attr("tag") + "']").length > 0)
                        return;
                    var template = $("#template-tr").clone(true);
                    $(template).attr("tag", $(trdata).attr("tag"));
                    $(template).find("td[name='mark']").html("手工填报");
                    $(template).find("td[name='variety']").html($(trdata).find("td[name='grainType']").html());
                    $(template).find("td[name='batchNumber']").attr("id",trindex);
                    $(template).find("td[name='batchNumber']").html($(trdata).find("td[name='batchNumber']").html()||"请选择");
                    $(template).find("td[name='cost']").find("input").val("");
                    $(template).find("td[name='pipeAttribute']").find("input").val("省储");
                    $(template).find("td[name='harvestYear']").html($(trdata).find("td[name='warehoueYear']").html());
                    $(template).find("td[name='storageWarehouse']").html($(trdata).find("td[name='receivePlace']").html()).attr("accepteunit", $("#accepte-unit").val()).attr("warehouseId",$(trdata).find("td[name='receivePlace']").attr("warehouseId"));
                    $(template).find("td[name='storehouse']").html($(trdata).find("td[name='storehouse']").html());
                    $(template).find("td[name='planNumber']").find("input").val($(trdata).find("td[name='quantity']").html());
                    $(template).find("td[name='enterpriseName']").html($(trdata).find("td[name='enterpriseName']").html());
                    $(template).find("td[name='enterpriseId']").html($(trdata).find("td[name='enterpriseId']").html());
                    $(template).find("td[name='actualNumber']").find("input").val($(trdata).find("td[name='quantity']").html());
                    $(template).find("td[name='manuActualNumber']").html($(trdata).find("td[name='quantity']").html());
                    $(template).addClass("data-tr");
                    $("#data-result").append($(template));
                    $(template).slideToggle(500);
                }
            });
            $("#close-float-alert-01").click();
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
                        $(dataMode).find("td[name='batchNumber']").html(data[i]["batchNumber"]);
                        $(dataMode).find("td[name='enterpriseName']").html(data[i]["enterpriseName"]);
                        $(dataMode).find("td[name='enterpriseId']").html(data[i]["enterpriseId"]);
                        $(dataMode).find("td[name='dealPrice']").html(data[i]["dealAmount"]);
                        $(dataMode).find("td[name='warehoueYear']").html(data[i]["warehoueYear"]);
                        let warehouseId = data[i]["deliveryId"];
                        $(dataMode).find("td[name='receivePlace']").html(data[i]["deliveryPlace"]).attr("warehouseId",warehouseId);
                        $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);
                        $(dataMode).find("td[name='quantity']").html(data[i]["surplusPlanNumber"]);
                        $("#schemeDetail-data-list").append($(dataMode));
                        $(dataMode).show();
                    }
                }
            });
        });

        $("#concluteButton-01").click(function () {

            var index = layer.load(1);
            $("#concluteForm-01").ajaxSubmit({
                success: function (data) {
                    layer.close(index);
                    $("#schemeDetail-data-list-01").find("tr").remove();
                    for (var i = 0; i < data.length; i++) {
                        var dataMode = $("#conclute-template-01").clone(true);
                        $(dataMode).attr("tag", data[i]["grainType"] + data[i]["warehoueYear"] + data[i]["enterpriseName"] + data[i]["receivePlace"] + data[i]["storehouse"] + data[i]["quantity"] + "");
                        $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
                        $(dataMode).find("td[name='batchNumber']").html(data[i]["batchNumber"]);
                        $(dataMode).find("td[name='warehoueYear']").html(data[i]["warehoueYear"]);
                        let warehouseId = data[i]["wareId"];
                        $(dataMode).find("td[name='enterpriseName']").html(data[i]["enterpriseName"]);
                        $(dataMode).find("td[name='enterpriseId']").html(data[i]["id"]);
                        $(dataMode).find("td[name='receivePlace']").html(data[i]["receivePlace"]).attr("warehouseId",warehouseId);
                        $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);
                        $(dataMode).find("td[name='quantity']").html(data[i]["quantity"]);
                        $("#schemeDetail-data-list-01").append($(dataMode));
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
            var receivePlaceType = $("#filter-receivePlaceType").val();
            $("#schemeDetail-data-list").find("input[type='checkbox']").each(function () {
                var trdata = $(this).parent().parent();
                var tempgrain = $(trdata).find("td[name='grainType']").html();
                var tempreceive = $(trdata).find("td[name='receivePlace']").html();
                var tempwarehoueYear = $(trdata).find("td[name='warehoueYear']").html();
                var tempstorehouse = $(trdata).find("td[name='storehouse']").html();
                var tempquantity = $(trdata).find("td[name='quantity']").html();
                var tempquantitype = $(trdata).find("td[name='receivePlaceType']").html();
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
                } else if (tempquantitype.indexOf(receivePlaceType) == -1) {
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
                window.location.href = "${ctx}/RotateNotif/Out.shtml?type=Warehouse";
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
            let noticeSerialValue = $(this).val();
            if (noticeSerialValue == noticeSerialVal)
                return;
            let url = "${ctx}/RotateNotif/isRotateNotif.shtml";
            $.ajax({
                url: url,
                contentType: "application/json",
                type: "post",
                data: '{"noticeSerial":"' + noticeSerialValue + '", "type":"out"}',
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
                        if (data[i]["deliveryPlace"] != $("#accepte-unit option:selected").html())
                            continue;
                        var dataMode = $("#conclute-template").clone(true);
                        $(dataMode).attr("tag", data[i]["dealSerial"]);
                        $(dataMode).find("td[name='dealSerial']").html(data[i]["dealSerial"]);
                        $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
                        $(dataMode).find("td[name='dealPrice']").html(data[i]["dealPrice"]);
                        $(dataMode).find("td[name='warehoueYear']").html(data[i]["warehoueYear"]);
                        $(dataMode).find("td[name='receivePlace']").html(data[i]["deliveryPlace"]);
                        $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);
                        $(dataMode).find("td[name='quantity']").html(data[i]["quantity"]);
                        $("#schemeDetail-data-list").append($(dataMode));
                        $(dataMode).show();
                    }
                }
            });
        };

        function chongzi01() {
            document.getElementById("concluteForm-01").reset();
            $("#concluteForm-01").ajaxSubmit({
                success: function (data) {
                    $("#schemeDetail-data-list-01").find("tr").remove();
                    for (var i = 0; i < data.length; i++) {
                        if (data[i]["receivePlace"] != $("#accepte-unit option:selected").html())
                            continue;
                        var dataMode = $("#conclute-template-01").clone(true);
                        $(dataMode).find("td[name='grainType']").html(data[i]["grainType"]);
                        $(dataMode).find("td[name='warehoueYear']").html(data[i]["warehoueYear"]);
                        $(dataMode).find("td[name='enterpriseName']").html(data[i]["enterpriseName"]);
                        $(dataMode).find("td[name='receivePlace']").html(data[i]["receivePlace"]);
                        $(dataMode).find("td[name='storehouse']").html(data[i]["storehouse"]);
                        $(dataMode).find("td[name='quantity']").html(data[i]["quantity"]);
                        $("#schemeDetail-data-list-01").append($(dataMode));
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