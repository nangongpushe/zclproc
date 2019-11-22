<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../common/AdminHeader.jsp" %>

<style>
    select[name="planType"], .layui-form #in select {
        display: inline-block;
    }

    #myTable5 + .layui-form .layui-table-body td[data-field="planName"] {
        text-align: left;
    }

    #myTable5 + .layui-form .layui-table-body td[data-field="year"] {
        text-align: center;
    }

    #myTable5 + .layui-form .layui-table-body td[data-field="stockOut"] {
        text-align: right;
    }

    #myTable5 + .layui-form .layui-table-body td[data-field="stockIn"] {
        text-align: right;
    }

    #myTable5 + .layui-form .layui-table-body td[data-field="colletor"] {
        text-align: left;
    }

    #myTable5 + .layui-form .layui-table-body td[data-field="colletorDate"] {
        text-align: center;
    }

    #myTable5 + .layui-form .layui-table-body td[data-field="state"] {
        text-align: left;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="rotateNumber"] {
        text-align: right;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="detailNumber"] {
        text-align: right;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="dealSerial"] {
        text-align: left;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="reportMonth"] {
        text-align: center;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="reportWarehouse"] {
        text-align: left;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="storehouse"] {
        text-align: left;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="variety"] {
        text-align: left;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="quantity"] {
        text-align: right;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="harvestYear"] {
        text-align: center;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="origin"] {
        text-align: left;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="brown"] {
        text-align: right;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="unitWeight"] {
        text-align: right;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="impurity"] {
        text-align: right;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="dew"] {
        text-align: right;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="yellowRice"] {
        text-align: right;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="unsoundGrain"] {
        text-align: right;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="wetGluten"] {
        text-align: right;
    }

    #myTable3 + .layui-form .layui-table-body td[data-field="koh"] {
        text-align: right;
    }

    #myTable6 + .layui-form .layui-table-body td[data-field="rotateType"] {
        text-align: left;
    }
    #myTable6 + .layui-form .layui-table-body td[data-field="foodType"] {
        text-align: left;
    }
    #myTable6 + .layui-form .layui-table-body td[data-field="yieldTime"] {
        text-align: center;
    }
    #myTable6 + .layui-form .layui-table-body td[data-field="orign"] {
        text-align: left;
    }#myTable6 + .layui-form .layui-table-body td[data-field="rotateNumber"] {
         text-align: right;
     }
    #myTable6 + .layui-form .layui-table-body td[data-field="detailNumber"] {
        text-align: right;
    }
    #myTable4 + .layui-form .layui-table-body td[data-field="warehouseCode"] {
        text-align: left;
    }
    #myTable4 + .layui-form .layui-table-body td[data-field="warehouseShort"] {
        text-align: left;
    }
    #myTable4 + .layui-form .layui-table-body td[data-field="warehouseName"] {
        text-align: left;
    }


    #storeTable + .layui-form .layui-table-body td[data-field="warehouse"] {
        text-align: left;
    }
    #storeTable + .layui-form .layui-table-body td[data-field="encode"] {
        text-align: left;
    }
    #storeTable + .layui-form .layui-table-body td[data-field="type"] {
        text-align: left;
    }
    #storeTable + .layui-form .layui-table-body td[data-field="address"] {
        text-align: left;
    }

    #myqualityResultModalTable + .layui-form .layui-table-body td[data-field="storeEncode"] {
        text-align: left;
    }
    #myqualityResultModalTable + .layui-form .layui-table-body td[data-field="variety"] {
        text-align: left;
    }
    #myqualityResultModalTable + .layui-form .layui-table-body td[data-field="harvestYear"] {
        text-align: center;
    }
    #myqualityResultModalTable + .layui-form .layui-table-body td[data-field="origin"] {
        text-align: left;
    }
    #myqualityResultModalTable + .layui-form .layui-table-body td[data-field="sampleNo"] {
        text-align: left;
    }
    #myqualityResultModalTable + .layui-form .layui-table-body td[data-field="reportUnit"] {
        text-align: left;
    }
    #myqualityResultModalTable + .layui-form .layui-table-body td[data-field="quantity"] {
        text-align: right;
    }
    #myqualityResultModalTable + .layui-form .layui-table-body td[data-field="testDate"] {
        text-align: center;
    }
    #myqualityResultModalTable + .layui-form .layui-table-body td[data-field="validType"] {
        text-align: left;
    }
    #myqualityResultModalTable + .layui-form .layui-table-body td[data-field="dealserial"] {
        text-align: left;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>轮换计划</li>
        <li class="active">计划详情</li>
    </ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

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
        <button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="planBtn"
                data-bind="click:function(){$root.showoutModel2($data)}">
            <i class="layui-icon"></i> 选择轮换计划
        </button>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label"><span class="red">*</span>计划详情名称:</label>
                <div class="layui-input-inline">
                    <input type="text" name="planName" autocomplete="off" class="layui-input form-control"
                           data-bind="value:planname1" maxlength="45">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label"><span class="red">*</span>计划名称:</label>
                <div class="layui-input-inline">
                    <input type="text" name="planmainName" autocomplete="off" class="layui-input form-control"
                           data-bind="value:planName" readonly>
                    <input type="hidden" name="planmainID" autocomplete="off" class="layui-input form-control"
                           data-bind="value:planmainID" readonly>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label"><span class="red">*</span>计划类别:</label>
                <div class="layui-input-inline">
                    <input type="text" name="planType" autocomplete="off" class="layui-input form-control"
                           data-bind="value:planType" readonly>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label"><span class="red">*</span>计划年份:</label>
                <div class="layui-input-inline">
                    <input type="text" name="year" autocomplete="off" class="layui-input form-control"
                           data-bind="value:year" readonly>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label"><span class="red">*</span>出库总数(吨):</label>
                <div class="layui-input-inline">
                    <input type="text" name="stockout" autocomplete="off" class="layui-input form-control"
                           data-bind="value:stockout" readonly>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label"><span class="red">*</span>入库总数(吨):</label>
                <div class="layui-input-inline">
                    <input type="text" name="stockin" autocomplete="off" class="layui-input form-control"
                           data-bind="value:stockin" readonly>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label"><span class="red">*</span>创建人:</label>
                <div class="layui-input-inline">
                    <input type="text" name="modifier" autocomplete="off" class="layui-input form-control"
                           data-bind="value:modifier" readonly>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label"><span class="red">*</span>审批状态:</label>
                <div class="layui-input-inline">
                    <input type="text" name="state" autocomplete="off" class="layui-input form-control"
                           data-bind="value:state" readonly>
                </div>
            </div>

            <div class="layui-row title">
                <h5>出入库计划明细</h5>
            </div>

            <div class="layui-tab" lay-filter="tab1">
                <ul class="layui-tab-title">
                    <li class="layui-this">轮入</li>
                    <li>轮出</li>
                </ul>
                <!-- 轮入 -->
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="inBtn"
                                data-bind="click:function(){$root.add('轮入')}">
                            <i class="layui-icon">&#xe608;</i> 新增
                        </button>

                        <%--<button type="button" class=" layui-btn layui-btn-primary layui-btn-small " id="file_in"
                                name="file">
                            导入
                        </button>

                        <a class="download" href="../sysFile/downloadTemplate.shtml?filename=计划轮入模板">轮入模板下载</a>--%>

                        <table class="layui-table" id="in">
                            <thead>
                            <tr>
                                <td class="layui-col-md1" align="center">轮换类别</td>
                                <td class="layui-col-md2" align="center">企业</td>
                                <td class="layui-col-md1" align="center">库点</td>
                                <td class="layui-col-md1" align="center">仓号</td>
                                <td class="layui-col-md1" align="center">粮食品种</td>
                                <td class="layui-col-md1" align="center">收获年份</td>
                                <td class="layui-col-md1" align="center">产地</td>
                                <!-- <td class="layui-col-md1">核定仓容(吨)</td> -->
                                <!-- <td class="layui-col-md1">实际库存(吨)</td> -->
                                <td class="layui-col-md1" align="center">轮换数量(吨)</td>
                                <td class="layui-col-md1" align="center">等级</td>
                                <td class="layui-col-md1" align="center">存储方式</td>
                                <td class="layui-col-md1" align="center">质量详情</td>
                                <td class="layui-col-md1" align="center">操作</td>
                            </tr>
                            </thead>
                            <tbody data-bind="foreach:detailList">
                            <!-- ko if:rotateType =='轮入' -->
                            <tr data-bind="attr:{'data-index':$index()}">
                                <td data-field="rotateType" class="field" data-bind="text:rotateType" align="left">
                                </td>
                                <!-- 企业 -->
                                <td data-field="enterpriseName" class="field" align="center">
                                    <div class="layui-input-inline">
                                        <input type="text" name="enterpriseName" lay-verify="required" readonly
                                               autocomplete="off" class="layui-input"
                                               data-bind="value:enterpriseName,attr:{enterpriseId:enterpriseId}"/>
                                    </div>
                                    <div class="layui-input-inline">
                                        <div class="layui-form-mid layui-word-aux">
                                            <a type="button" class="btn btn-link" id="chooseBtn3"
                                               data-target="#myModal"
                                               data-bind="click:function(){$root.showEnterpriseModal($data);}">选择</a>
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">
                                            <a type="button" class="btn btn-link" id="delEnterprise"
                                               data-target="#myModal"
                                               data-bind="click:function(){$root.delEnterprise($index());}">删除</a>
                                        </div>
                                    </div>
                                </td>
                                <!-- 库点 -->
                                <td data-field="libraryName" class="field" align="left">
                                    <div class="layui-input-inline" style="width:100px">
                                        <input type="text" name="libraryName" readonly
                                               autocomplete="off" class="layui-input" data-bind="value:libraryName,attr:{warehouseid:warehouseid}" />
                                    </div>
                                    <div class="layui-input-inline" style="width:100px">
                                        <div class="layui-form-mid layui-word-aux">
                                            <a type="button" class="btn btn-link" id="chooseBtn"
                                               data-target="#myModal"
                                               data-bind="click:function(){$root.showModal($data,$index());}">选择</a>
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">
                                            <a type="button" class="btn btn-link" id="delWarehosue"
                                               data-target="#myModal"
                                               data-bind="click:function(){$root.delWarehosue($index());}">删除</a>
                                        </div>
                                    </div>
                                </td>
                                <td data-field="barnNumber" class="field" align="left">
                                    <div class="layui-input-inline" style="width:100px">
                                        <input type="text" name="barnNumber"
                                               autocomplete="off" class="layui-input" data-bind='value:barnNumber,attr:{readonly:isInput}'>
                                    </div>
                                    <div class="layui-input-inline" style="width:100px">
                                        <div class="layui-form-mid layui-word-aux">
                                            <a type="button" class="btn btn-link" id="chooseBtn1"
                                               data-target="#myModal"
                                               data-bind="click:function(){$root.showstoreModal($data,$index());}">选择</a>
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">
                                            <a type="button" class="btn btn-link" id="delStorehosue"
                                               data-target="#myModal"
                                               data-bind="click:function(){$root.delStorehosue($data,$index());}">删除</a>
                                        </div>
                                    </div>
                                </td>

                                <td data-field="foodType" class="field" align="left">
                                    <input type="text" name="foodType" lay-verify="required"
                                           autocomplete="off" class="layui-input" data-bind="value:foodType" readonly>
                                </td>
                                <td data-field="yieldTime" class="field" align="center">
                                    <input type="text" name="yieldTime" lay-verify="required"
                                           autocomplete="off" class="layui-input" data-bind="value:yieldTime"
                                           style="width:100px" readonly>
                                </td>
                                <td data-field="orign" class="field" align="left">
                                    <input type="text" name="orign"
                                           autocomplete="off" class="layui-input" data-bind="value:orign" oninput="if(value.length>15)value=value.slice(0,15)">
                                    <input type="hidden" name="planmaindetailId" lay-verify="required"
                                           autocomplete="off" class="layui-input" data-bind="value:planmaindetailId"
                                           readonly>

                                </td>
                                <td align="right"><input data-field="rotateNumber"
                                                         type="number" lay-verify="required" autocomplete="off"
                                                         class="layui-input" data-bind=" value:rotateNumber "
                                                         maxlength="10" oninput="if(value.length>15)value=value.slice(0,15)" onchange = "numberFixed(this,3)"></td>
                                <td align="left" data-field="qualityId">
                                    <select class="layui-select" name="quality" data-bind="options:quotas,optionsCaption:'--请选择--',
																optionsText:'value',optionsValue:'id',
																value:qualityId" lay-verify="required">
                                    </select>
                                </td>
                                <td align="left" data-field="storeType">
                                    <select class="layui-select block" name="storeType" data-bind="options:$root.storeTypes,
                                                                    value:storeType" lay-verify="required">
                                    </select>
                                </td>
                                <td align="left"><textarea data-field="qualityDetail"
                                                           type="text"  autocomplete="off"
                                                           class="layui-input"
                                                           data-bind="value:qualityDetail" oninput="if(value.length>45)value=value.slice(0,45)"></textarea></td>
                                <%-- <textarea name="" id="" cols="30" rows="10"></textarea>--%>
                                <td><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini"
                                       data-bind="click:function(){$root.remove($data,$index())}">删除</a></td>
                            </tr>
                            <!-- /ko -->
                            </tbody>
                        </table>
                    </div>
                    <!-- 轮出 -->
                    <div class="layui-tab-item">
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="outBtn"
                                data-bind="click:function(){$root.add('轮出')}">
                            <i class="layui-icon">&#xe608;</i> 新增
                        </button>

                        <%--<button type="button" class=" layui-btn layui-btn-primary layui-btn-small " id="file_out"
                                name="file">
                            导入
                        </button>
                        <a class="download" href="../sysFile/downloadTemplate.shtml?filename=计划轮出模板">轮出模板下载</a>--%>
                        <table class="layui-table" id="out">
                            <thead>
                                <tr>
                                    <td align="center">轮换类别</td>
                                    <td align="center">库点</td>
                                    <td align="center">仓房</td>
                                    <td align="center">粮食品种</td>
                                    <td align="center">收获年份</td>
                                    <td align="center">产地</td>
                                    <td align="center">存储方式</td>
                                    <!-- <td>核定仓容(吨)</td> -->
                                    <td align="center">实际库存(吨)</td>
                                    <td align="center">轮换数量(吨)</td>
                                    <td align="center">成交子明细号</td>
                                    <td align="center">操作</td>
                                </tr>
                            </thead>
                            <tbody data-bind="foreach:detailList">
                                <!-- ko if:rotateType =='轮出' -->
                                <tr data-bind="attr:{'data-index':$index()}">
                                    <td data-field="rotateType" class="field" data-bind="text:rotateType" align="left"></td>
                                    <td data-field="libraryName" class="field" data-bind="text:libraryName"
                                        align="left"></td>
                                    <td data-field="barnNumber" class="field" data-bind="text:barnNumber"
                                        align="left"></td>
                                    <td data-field="foodType" class="field" data-bind="text:foodType" align="left"></td>
                                    <td data-field="yieldTime" class="field" data-bind="text:yieldTime" align="center"></td>
                                    <td data-field="orign" class="field" data-bind="text:orign" align="left"></td>
                                    <td align="left" data-field="storeType">
                                        <select class="layui-select block" style="display: block" name="storeType" data-bind="options:$root.storeTypes,
                                                                        value:storeType" lay-verify="required">
                                        </select>
                                            <%--<input data-field="storeType"  lay-verify="required"
                                                   autocomplete="off"
                                                   class="layui-input" data-bind="value:storeType" >--%>
                                    </td>
                                    <!-- <td data-field="approvalCapacity" class="field" data-bind="text:approvalCapacity"></td> -->
                                    <td data-field="realCapacity" class="field" data-bind="text:realCapacity"
                                        align="right"></td>
                                    <td align="right">
                                        <input data-field="rotateNumber" type="number" lay-verify="required"
                                               autocomplete="off" step="0.001"
                                               class="layui-input" data-bind="value:rotateNumber" maxlength="10" oninput="if(value.length>15    )value=value.slice(0,15)" onchange = "numberFixed(this,3)">
                                        <input type="hidden" name="planmaindetailId" lay-verify="required"
                                               autocomplete="off" class="layui-input" data-bind="value:planmaindetailId"
                                               readonly>
                                    </td>
                                    <td class="field" data-field="dealSerial" data-bind="text:dealSerial" align="left"></td>
                                    <td>
                                        <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini"
                                           data-bind="click:function(){$root.remove($data,$index())}">删除</a>
                                        <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini"
                                           data-bind="click:function(){$root.showQualityResult($data,$index())}">选择质检结果</a>
                                    </td>
                                </tr>
                            <!-- /ko -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


            <div class="layui-row text-center">
                <c:if test="${!isEdit }">
                    <div class="layui-col-md12" id="operation">
                        <button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small "
                                lay-filter="save" data-status="待分发">保存
                        </button>
                            <%--<button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small "
                                    lay-filter=save data-status="OA流程">提交
                            </button>--%>
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
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                                data-bind="click:function(){$root.cancel('返回');}">返回
                        </button>
                    </div>
                </c:if>
            </div>
        </div>
    </form>

    <!-- 轮入 模态框 -->
    <div class="modal fade" id="inModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="layui-form" lay-filter="search4" id="search4">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">库点简称:</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="warehouseShort" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">库点名称:</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="warehouseName" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>

                            <div class="layui-inline">
                                <button class=" layui-btn layui-btn-primary layui-btn-small"
                                        data-bind="click:function(){$root.reloadTable4();}">查询
                                </button>
                            </div>

                        </div>

                    </div>
                    <table class="layui-table" lay-filter="table4" id="myTable4"></table>
                    <div class="modal-footer">
                        <button type="button"
                                class="layui-btn layui-btn-primary layui-btn-small"
                                data-bind="click:function(){$root.selectWarehouse()}">确定
                        </button>
                        <button type="button"
                                class="layui-btn layui-btn-primary layui-btn-small"
                                data-bind="click:function(){$root.hideModal('inModal','myTable4')}">取消
                        </button>
                    </div>

                </div>

            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
    <!-- 轮出 模态框 -->
    <div class="modal fade" id="outModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg" style="width:1100px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4 class="modal-title">粮油轮换数据</h4>
                </div>
                <div class="modal-body">
                    <div class="layui-form" lay-filter="search3" id="search3">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">库点:</label>
                                <div class="layui-input-inline">
                                    <select name="warehouse" lay-filter="warehouse" lay-search>
                                        <option value="">搜索/直接选择</option>
                                        <c:forEach var="item" items="${warehouses}">
                                            <option value="${item}">${item}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">库点类型:</label>
                                <div class="layui-input-inline">
                                    <select name="warehouse_type" lay-search>
                                        <option value="">请选择</option>
                                        <option value="储备库">直属单位</option>
                                        <option value="代储库">代储库</option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">仓号:</label>
                                <div class="layui-input-inline">
                                    <input name="storehouse" class="layui-input">
                                    <%--<select name="storehouse"--%>
                                            <%--data-bind="options:$root.storehouses,optionsCaption:'搜索/直接选择'" lay-search>--%>
                                    <%--</select>--%>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">粮食品种:</label>
                                <div class="layui-input-inline">
                                    <select name="variety" lay-search>
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
                                    <input type="text" name="recepitYear" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">产地:</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="origin" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">填报日期:</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="reportMonth" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <br/>

                            <div class="layui-inline">
                                <button class=" layui-btn layui-btn-primary layui-btn-small"
                                        data-bind="click:function(){$root.reloadTable3();}">查询
                                </button>
                            </div>
                            <div class="layui-inline">
                                <button class=" layui-btn layui-btn-primary layui-btn-small"
                                        data-bind="click:function(){$root.clearAllCondition();}">清空
                                </button>
                            </div>
                        </div>

                    </div>
                    <table class="layui-table" lay-filter="table3" id="myTable3"></table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.selectConfirm('outModal','myTable3','轮出')}">确定
                    </button>
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.hideModal('outModal','myTable3')}">取消
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
    <!-- 轮换计划 模态框 -->
    <div class="modal fade" id="outModa2" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-" style="width:auto">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">轮换计划</h4>
                </div>
                <div class="modal-body">
                    <div class="layui-form" lay-filter="search5" id="search5">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label ">计划名称:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" name="planName1" id="planName1" autocomplete="off">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label ">年份:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" name="planyear1" id="planyear1" autocomplete="off">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">创建人:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" name="colletor1" id="colletor1"
                                           autocomplete="off">
                                </div>
                            </div>

                            <div class="layui-inline">
                                <button class=" layui-btn layui-btn-primary layui-btn-small"
                                        data-bind="click:function(){$root.reloadTable5();}">查询
                                </button>
                            </div>
                        </div>

                    </div>
                    <table class="layui-table" lay-filter="table5" id="myTable5"></table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.selectPlandeclare('outModa2','myTable5')}">确定
                    </button>
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.hideModal('outModa2','myTable5')}">取消
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
    <!-- 轮换计划明细 模态框 -->
    <div class="modal fade" id="planDetail" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg" style="width:700px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;</button>
                    <h4 class="modal-title">轮换计划明细</h4>
                </div>
                <div class="modal-body">
                    <table class="layui-table" lay-filter="table6" id="myTable6"></table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.selectPlanDetail('planDetail','myTable6','轮入')}">确定
                    </button>
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.hideModal('planDetail','myTable6')}">取消
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>

    <!-- 质检结果 模态框 -->
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
                                    <input class="layui-input" name="origin1" id="origin1" autocomplete="off">
                                </div>
                            </div>
                            <input type="hidden" class="layui-input" name="index1" id="index1">
                            <div class="layui-inline">
                                <button class=" layui-btn layui-btn-primary layui-btn-small"
                                        data-bind="click:function(){$root.reloadTable7();}">查询
                                </button>
                            </div>
                        </div>

                    </div>
                    <table class="layui-table" lay-filter="qualityResultTable" id="myqualityResultModalTable"></table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.selectQualityResult('qualityResultModal','myqualityResultModalTable')}">
                        确定
                    </button>
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.hideModal('qualityResultModal','myqualityResultModalTable')}">
                        取消
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>

    <div class="modal fade" id="enterpriseModele" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="layui-form" lay-filter="searchEnterprise" id="searchEnterprise">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">企业名称:</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="enterpriseName" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>

                            <div class="layui-inline">
                                <button class=" layui-btn layui-btn-primary layui-btn-small"
                                        data-bind="click:function(){$root.reloadEnterprise();}">查询
                                </button>
                            </div>

                        </div>

                    </div>
                    <table class="layui-table" lay-filter="enterpriseTable" id="enterpriseTable"></table>
                    <div class="modal-footer">
                        <button type="button"
                                class="layui-btn layui-btn-primary layui-btn-small"
                                data-bind="click:function(){$root.selectEnterprise()}">确定
                        </button>
                        <button type="button"
                                class="layui-btn layui-btn-primary layui-btn-small"
                                data-bind="click:function(){$root.hideModal('enterpriseModele','enterpriseTable')}">取消
                        </button>
                    </div>

                </div>

            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>

    <!-- 仓号 模态框 -->
    <div class="modal fade" id="storeModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg" style="width:550px">
            <div class="modal-content">
                <div class="modal-body">
                    <table class="layui-table" lay-filter="storeTable" id="storeTable"></table>
                    <div class="modal-footer">
                        <button type="button"
                                class="layui-btn layui-btn-primary layui-btn-small"
                                data-bind="click:function(){$root.selectStorehouse()}">确定
                        </button>
                        <button type="button"
                                class="layui-btn layui-btn-primary layui-btn-small"
                                data-bind="click:function(){$root.hideModal('storeModal','storeTable')}">取消
                        </button>
                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>

</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>
<script src="${ctx}/js/app/rotateplan/add.js"></script>
<script type="text/html" id="enableDate">
    {{Date_format(d.enableDate,true)}}
</script>
<script type="text/html" id="colletorDateFormat">
    {{Date_format(d.colletorDate,true)}}
</script>
<script type="text/html" id="stockOut">
    <a href="javascript:void(0);" data-id="{{d.id}}" class="layui-table-link" data-type="轮出">{{d.stockOut}}</a>
</script>
<script type="text/html" id="stockIn">
    <a href="javascript:void(0);" data-id="{{d.id}}" class="layui-table-link" data-type="轮入">{{d.stockIn}}</a>
</script>
<script>

    var isedit =${isEdit};
    var id = '${rotatePlan.id}' || '';
    //var quotas = {cf:toJSON(quotas)};
    var grainLevel = ${cf:toJSON(grainLevel)};
    var oilLevel = ${cf:toJSON(oilLevel)};
    var detailList = ${cf:toJSON(detailList)};
    var rotatePlanmain = ${cf:toJSON(rotatePlanmain)};
    var planname = '${rotatePlan.planName}' || '';
    var vm = new Add(isedit, id, detailList, rotatePlanmain, planname, grainLevel, oilLevel);
    ko.applyBindings(vm, $(".container-box")[0]);
    vm.initPage();

    UploadFile();

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