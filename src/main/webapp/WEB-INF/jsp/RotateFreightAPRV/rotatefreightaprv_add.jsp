<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp" %>

<style>

    .btn:hover, .btn:link, .btn:active, .btn:visited {
        background-color: #fff;
        color: #23527c;
        border-color: #fff;
    }

    #freightDetails td > select {
        display: inline-block;
    }

    #form2 [class*="layui-col-md"] label {
        width: 35%;
    }

    #form2 .layui-input-inline select {
        display: inline-block;
        width: 100%;
    }
    #form2 .layui-input-inline .layui-form-select{
        display: none;
    }

    #form2 .layui-input-block {
        margin-left: 127px;
    }

    #form2 .layui-input-block textarea {
        width: 80%;
    }
</style>

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>运费管理</li>
        <c:if test="${!isEdit }">
            <li class="active">运费审批新增</li>
        </c:if>
        <c:if test="${isEdit }">
            <li class="active">运费审批编辑</li>
        </c:if>
    </ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

    <div class="layui-row title">
        <h5>运费审批信息</h5>
    </div>

    <form class="layui-form" lay-filter="form" id="form1">
        <input type="hidden" name="reportUnit"  id="reportUnit" value=""/>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>调入单位:</label>
                <div class="layui-input-inline">
                    <select class="layui-select" name="enterpriseId" lay-verify="required" lay-filter="enterpriseId" id="enterpriseId">
                        <option value="">--请选择--</option>
                        <%--<option value="${company }">${company }</option>--%>
                        <c:forEach items="${reportUnits }" var="item">
                            <option  <c:if test="${item.enterpriseId==model.enterpriseId}">selected</c:if> value="${item.enterpriseId }">${item.shortName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>调入库点到达地:</label>
                <div class="layui-input-inline">
                    <input readonly class="layui-input form-control" id="reportUnitAddress" name="reportUnitAddress" lay-verify="required"
                           autocomplete="off" placeholder="请输入调入单位" value="${model.reportUnitAddress}">
                </div>
            </div>

        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮食品种:</label>
                <div class="layui-input-inline">
                    <select lay-verify="required" name="grainType" lay-filter="grainType">
                        <option value="">--请选择--</option>
                        <c:forEach items="${grainTypes }" var="item">
                            <option value="${item.value}">${item.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>填报人:</label>
                <div class="layui-input-inline">
                    <input type="text" name="reporter"
                           autocomplete="off" readonly lay-verify="required"
                           class="layui-input form-control" value="${model.reporter}">
                </div>
            </div>
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>填报时间:</label>
                <div class="layui-input-inline">
                    <input type="text" name="reportDate"
                           autocomplete="off" readonly lay-verify="required"
                           class="layui-input form-control"
                           value='<fmt:formatDate value="${model.reportDate}" pattern="yyyy-MM-dd"/>'>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>填报单位:</label>
                <div class="layui-input-inline">
                    <input type="text" name="company"
                           autocomplete="off" readonly lay-verify="required"
                           class="layui-input form-control" value="${model.company}">
                </div>
            </div>
        </div>

        <div class="layui-row title">
            <h5>运费审批明细</h5>
        </div>

        <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                data-bind="click:function(){$root.showModal();}">
            <i class="layui-icon">&#xe608;</i> 新增
        </button>
        <table class="layui-table">
            <thead>
            <tr>
                <td>调出单位</td>
                <td>调出库点起运地</td>
                <td>调入单位</td>
                <td>调入库点到达地</td>
                <td>品种</td>
                <td>运距(公里)</td>
                <td>运输方式</td>
                <td>数 量(吨)</td>
                <td>散运(吨)</td>
                <td>包装(吨)</td>
                <td>散运运费单价(元/吨)</td>
                <td>包装运费单价(元/吨)</td>

                <td>散运板前费率(元/吨)</td>
                <td>包装板前费率(元/吨)</td>
                <td>散运入库费率(元/吨)</td>
                <td>包装入库费率(元/吨)</td>

                <td>运费(元)</td>
                <td>其他费用(元)</td>
                <td>板前费(元)</td>
                <td>入库费(元)</td>
                <td>费用合计(元)</td>
                <td>备注</td>
                <td>操作</td>
            </tr>
            </thead>
            <tbody data-bind="foreach:detailList">
            <tr>
                <td data-bind="text:outUnit"></td>   <!-- 调出单位 -->
                <td data-bind="text:outStartPlace"></td> <!-- 调出库点起运地 -->
                <td data-bind="text:reportUnit"></td><!-- 调入单位  -->
                <td data-bind="text:inAimPlace"></td> <!-- 调入库点到达地 -->
                <td data-bind="text:grainType"></td> <!-- 品种 -->
                <td data-bind="text:distance"></td> <!-- 运距(公里)  -->
                <td data-bind="text:shipType"></td> <!-- 运输方式  -->
                <td data-bind="text:quantity"></td> <!-- 数量(吨) -->
                <td data-bind="text:bulk"></td><!-- 散运(吨) -->
                <td data-bind="text:packageNum"></td> <!-- 包装(吨) -->

                <td data-bind="text:bulkFreightUnit"></td> <!-- 散运运费单价(元/吨) -->
                <td data-bind="text:packageFreightUnit"></td> <!-- 包装运费单价(元/吨)  -->
                <td data-bind="text:bulkPreBoardRate"></td>  <!-- 散运板前费率(元/吨) -->
                <td data-bind="text:packagePreBoardRate"></td> <!-- 包装板前费率(元/吨)  -->
                <td data-bind="text:bulkInStoreRate"></td> <!-- 散运入库费率(元/吨) -->
                <td data-bind="text:packageInStoreRate"></td> <!-- 包装入库费率(元/吨) -->


                <td data-bind="text:freight"></td> <!-- 运费(元) -->
                <td data-bind="text:otherFee"></td><!--其他费用(元)  -->
                <td data-bind="text:boardFee"></td>  <!-- 板前费(元) -->
                <td data-bind="text:warehouseFee"></td><!-- 入库费(元) -->
                <td data-bind="text:totalFee"></td> <!-- 费用合计(元) -->
                <td data-bind="text:remark"></td> <!-- 备注  -->
                <td>
                    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" style="display:block;"
                       data-bind="click:function(){$root.edit($data,$index())}">编辑</a>
                    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" style="display:block;margin:0;margin-top:5px;"
                       data-bind="click:function(){$root.remove($index())}">删除</a>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="layui-row text-center"
             data-bind="visible:detailList().length==0">暂无明细数据
        </div>

        <div class="layui-form-item text-center">
            <button class=" layui-btn layui-btn-primary layui-btn-small" lay-submit="" lay-filter="save"
                    data-status="未提交">保存
            </button>
            <button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small " lay-filter=save
                    data-status="OA审核流程">提交
            </button>
            <button type="button" class=" layui-btn layui-btn-primary layui-btn-small"
                    data-bind="click:function(){$root.cancel();}">取消
            </button>
        </div>
    </form>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-bind="with:currentDetail">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4>新增明细</h4>
                </div>
                <div class="modal-body">
                    <form class="layui-form" lay-filter="form2" id="form2">
                        <%--<input name="id" value="${warehouse.id }" hidden="hidden">--%>
                        <%--hidden包装板前费率--%>
                        <%--&lt;%&ndash;包装板前费率&ndash;%&gt;<input class="layui-input"  name="packagePreBoardRate" id="packagePreBoardRate" autocomplete="off" data-bind="value:packagePreBoardRate" >
                        &lt;%&ndash;散运板前费率&ndash;%&gt;<input class="layui-input"  name="bulkPreBoardRate" id="bulkPreBoardRate" autocomplete="off" data-bind="value:bulkPreBoardRate">
                        &lt;%&ndash;包装入库费率&ndash;%&gt;<input class="layui-input"  name="packageInStoreRate" id="packageInStoreRate" autocomplete="off" data-bind="value:packageInStoreRate">
                        &lt;%&ndash;散运入库费率&ndash;%&gt;<input class="layui-input"  name="bulkInStoreRate" id="bulkInStoreRate" autocomplete="off" data-bind="value:bulkInStoreRate" >--%>
                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>调出单位:</label>

                                <div class="layui-input-inline">
                                    <input class="layui-input" name="outUnit"
                                           lay-verify="required" autocomplete="off" placeholder="请输入调出单位"
                                           data-bind="value:outUnit" oninput="if(value.length>40)value=value.slice(0,40)" />
                                </div>
                            </div>

                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>调出库点起运地:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" name="outStartPlace"
                                           lay-verify="required" autocomplete="off" placeholder="请输入调出库点起运地"
                                           data-bind="value:outStartPlace" oninput="if(value.length>40)value=value.slice(0,40)" >
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>调入单位:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" readonly name="reportUnit"
                                           lay-verify="required" autocomplete="off" placeholder="请输入调入单位"
                                           data-bind="value:reportUnit">
                                </div>
                            </div>

                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>调入库点到达地:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" readonly name="inAimPlace"
                                           lay-verify="required" autocomplete="off" placeholder="请输入调入库点到达地"
                                           data-bind="value:inAimPlace">
                                    <!-- 									<select class="layui-select" name="inAimPlace" data-bind="options:$root.inAimPlaces,optionsCaption:'--请选择--',
                                                                            value:inAimPlace" lay-verify="required"> -->
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!-- 品种 -->
                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>品种:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" readonly name="grainType"
                                           lay-verify="required" autocomplete="off" placeholder="请输入品种"
                                           data-bind="value:grainType">
                                </div>
                            </div>
                        </div>
                        <!-- 品种 -->
                        <div class="layui-form-item">
                            <!-- 运距(公里)  -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>运距(公里):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="distance"
                                           onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]"
                                           min="0"
                                           lay-verify="required" autocomplete="off" placeholder="请输入运距"
                                           data-bind="value:distance" type="number" oninput="if(value.length>15)value=value.slice(0,15)" />
                                </div>
                            </div>
                            <!-- 运距(公里)  -->
                            <!-- 运输方式  -->

                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>运输方式:</label>
                                <div class="layui-input-inline">
                                        <select class="layui-select" name="shipType" data-bind="options:$root.shipTypes,optionsCaption:'--请选择--',
										value:shipType" lay-verify="required" onchange="autoFill(this.value)">
                                        </select>
                                    <%--<select class=" form-control layui-select" lay-verify="required" name="shipType" lay-filter="shipType" onchange="autoFill(this.value)">
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${shipTypes}" var="item">
                                            <option value="${item.value}">${item.value}</option>
                                        </c:forEach>
                                    </select>--%>
                                </div>
                            </div>
                            <!-- 运输方式  -->
                        </div>
                        <!-- 运距(公里)  -->
                        <div class="layui-form-item">
                            <!-- 数量(吨) -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>数量(吨):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="quantity" id="quantity" readonly
                                           lay-verify="required|number" autocomplete="off"
                                           data-bind="value:quantity">
                                </div>
                            </div>
                            <!-- 数量(吨) -->
                            <!-- 散运(吨) -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>散运(吨):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="bulk" id="bulk"
                                           data-rule="integer;length[1~10]" min="0"
                                           onchange="sumquantity(this,'packageNum')"
                                           lay-verify="required|number" type="number" autocomplete="off"
                                           placeholder="请输入散运"
                                           data-bind="value:bulk" oninput="if(value.length>15)value=value.slice(0,15)" >
                                </div>
                            </div>
                            <!-- 散运(吨) -->
                        </div>

                        <div class="layui-form-item">
                            <!-- 包装(吨) -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>包装(吨):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="packageNum" id="packageNum"
                                           onchange="sumquantity(this,'bulk')"
                                           lay-verify="required|number" autocomplete="off" placeholder="请输入包装"
                                           data-rule="integer;length[1~10]" min="0"
                                           data-bind="value:packageNum" type="number" oninput="if(value.length>15)value=value.slice(0,15)">
                                </div>
                            </div>
                            <!-- 包装(吨) -->
                            <!-- 散运运费单价(元/吨) -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>散运运费单价(元/吨):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="bulkFreightUnit" id="bulkFreightUnit"
                                           readonly
                                           lay-verify="required|number" autocomplete="off" placeholder="请输入散运运费单价"
                                           data-bind="value:bulkFreightUnit" type="number">
                                </div>
                            </div>
                            <!-- 散运运费单价(元/吨) -->
                        </div>
                        <div class="layui-form-item">
                            <!-- 包装运费单价(元/吨)  -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>包装运费单价(元/吨):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="packageFreightUnit"
                                           id="packageFreightUnit" readonly
                                           lay-verify="required|number" autocomplete="off" placeholder="请输入包装运费单价"
                                           data-bind="value:packageFreightUnit" type="number">
                                </div>
                            </div>
                            <!-- 包装运费单价(元/吨)  -->
                            <!-- 包装板前费率(元/吨)  -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>包装板前费率(元/吨):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="packagePreBoardRate"
                                           id="packagePreBoardRate" readonly
                                           lay-verify="required|number" autocomplete="off"
                                           data-bind="value:packagePreBoardRate">
                                </div>
                            </div>
                            <!-- 包装板前费率(元/吨)  -->
                        </div>
                        <div class="layui-form-item">
                            <!-- 散运板前费率(元/吨) -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>散运板前费率(元/吨):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="bulkPreBoardRate"
                                           id="bulkPreBoardRate"
                                           lay-verify="required|number" autocomplete="off" readonly
                                           data-bind="value:bulkPreBoardRate">
                                </div>
                            </div>
                            <!-- 包装入库费率(元/吨) -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>包装入库费率(元/吨):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="packageInStoreRate"
                                           id="packageInStoreRate" readonly
                                           lay-verify="required|number" autocomplete="off"
                                           data-bind="value:packageInStoreRate">
                                </div>
                            </div>
                            <!-- 包装入库费率(元/吨) -->
                        </div>
                        <div class="layui-form-item">
                            <!-- 散运入库费率(元/吨) -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>散运入库费率(元/吨):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="bulkInStoreRate" id="bulkInStoreRate"
                                           lay-verify="required|number" autocomplete="off" readonly
                                           data-bind="value:bulkInStoreRate">
                                </div>
                            </div>
                            <!-- 散运入库费率(元/吨) -->
                            <!-- 运费(元) -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>运费(元):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="freight" id="freight"
                                           lay-verify="required|number" autocomplete="off" placeholder="请输入运费" readonly
                                           data-bind="value:freight" type="number">
                                </div>
                            </div>
                            <!-- 运费(元) -->
                        </div>
                        <div class="layui-form-item">
                            <!--其他费用(元)  -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>其他费用(元):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="otherFee" id="otherFee"
                                           lay-verify="required|number" autocomplete="off" placeholder="请输入其他费用"
                                           readonly
                                           data-bind="value:otherFee" type="number">
                                </div>
                            </div>
                            <!--其他费用(元)  -->
                            <!-- 板前费(元) -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>板前费(元):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="boardFee" id="boardFee"
                                           lay-verify="required|number" autocomplete="off" placeholder="请输入板前费" readonly
                                           data-bind="value:boardFee" type="number">
                                </div>
                            </div>
                            <!-- 板前费(元) -->
                        </div>

                        <div class="layui-form-item">
                            <!-- 入库费(元) -->
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><span class="red">*</span>入库费(元):</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input form-control" name="warehouseFee" id="warehouseFee"
                                           lay-verify="required|number" autocomplete="off" placeholder="请输入入库费" readonly
                                           data-bind="value:warehouseFee" type="number">
                                </div>
                            </div>
                            <!-- 入库费(元) -->
                        </div>

                        <!-- 备注  -->
                        <div class="layui-form-item layui-form-text">
                            <label class="layui-form-label">备注:</label>
                            <div class="layui-input-block">
                                <textarea placeholder="最多100字" class="layui-textarea" name="remark"
                                          data-bind="value:remark" oninput="if(value.length>100)value=value.slice(0,100)"></textarea>
                            </div>
                        </div>
                        <!-- 备注  -->
                        <div class="modal-footer">
                            <button type="button" class=" layui-btn layui-btn-primary layui-btn-small" lay-submit=""
                                    lay-filter="confirm">确定
                            </button>
                            <button type="button" class=" layui-btn layui-btn-primary layui-btn-small"
                                    data-bind="click:function(){$root.hideModal($data);}">取消
                            </button>
                            <!-- <button type="button" class=" layui-btn layui-btn-primary layui-btn-small" lay-submit="" lay-filter="notSure">取消</button> -->
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>


<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatefreightaprv/add.js"></script>

<script>
    var reportUnits =${cf:toJSON(reportUnits)};

    layui.use('form', function(){
        var form = layui.form;
        form.render();

        form.on('select(enterpriseId)', function(data){

            var options=$("#enterpriseId option:selected"); //获取选中的项

            for(var  i=0;i<reportUnits.length;i++){
             var enterpriseId=   reportUnits[i]["enterpriseId"];
             if(data.value==enterpriseId){
                 $("#reportUnitAddress").val(reportUnits[i]["addressMap"]);
             }
            }

            $("#reportUnit").val(options.text());

        })



    });
    /*$("#packagePreBoardRate").hide();
    $("#bulkPreBoardRate").hide();
    $("#packageInStoreRate").hide();
    $("#bulkInStoreRate").hide();*/
    var isedit = ${isEdit};
    var id = '${model.id}' || 0;
    if (isedit) {
        var form=layui.form;
        form.render();
        $('#form1 [name="grainType"]').val("${model.grainType}");
        $('#form1 [name="reportUnit"]').val("${model.reportUnit}");
    }

    var addressMap =${cf:toJSON(addressMap)};
    var aprv =${cf:toJSON(model)};
    var shipTypes =${cf:toJSON(shipTypes)};
    var vm = new Add(isedit, id, aprv, shipTypes, reportUnits, addressMap);
    ko.applyBindings(vm, $(".container-box")[0]);
    vm.initPage();

    function autoFill(value) {
        if (!value) return;
        var currentDetail = vm.currentDetail();
        //currentDetail.packageFreightUnit = 1111
        //alert(JSON.stringify(currentDetail))
        $.ajax({
            type: "post",
            url: '${ctx}/freightDef/selectByShipType.shtml',
            data: {"shipType": value},
            cache: false,
            async: false,
            dataType: "json",
            success: function (data) {
                for (i = 0; i < data.length; i++) {
                    var freightDef = data[i];
                    //给运费单价赋值
                    assignValue(freightDef, currentDetail);

                }
            },
            error: function () {
                alert("请求失败！");
            }
        });
        //计算并填入板前费
        sumPreBoardFee(currentDetail);
        //计算并填入入库费
        sumInStoreFee(currentDetail);
        //计算其他费用
        sumOtherFee(currentDetail);
        //计算运费
        sumFreight(currentDetail);
        // vm.initDetail(currentDetail);
    }

    function assignValue(freightDef, currentDetail) {
        if (freightDef.packageType == '包装') {
            //给包装运费单价赋值
            $('#packageFreightUnit').val(freightDef.transportPrice);
            $('#packageInStoreRate').val(freightDef.instoreRate);
            $('#packagePreBoardRate').val(freightDef.preBoardRate);
            currentDetail.packageFreightUnit = parseInt(freightDef.transportPrice);
            currentDetail.packageInStoreRate = parseInt(freightDef.preBoardRate);
            currentDetail.packagePreBoardRate = parseInt(freightDef.instoreRate);
            //alert("包装入库"+freightDef.preBoardRate+"包装板前"+freightDef.instoreRate);

        } else if (freightDef.packageType == '散运') {
            //给散运运费单价赋值
            $('#bulkFreightUnit').val(freightDef.transportPrice);
            $('#bulkPreBoardRate').val(freightDef.preBoardRate);
            $('#bulkInStoreRate').val(freightDef.instoreRate);
            currentDetail.bulkFreightUnit = parseInt(freightDef.transportPrice);
            currentDetail.bulkPreBoardRate = parseInt(freightDef.preBoardRate);
            currentDetail.bulkInStoreRate = parseInt(freightDef.instoreRate);
        }

        //alert(JSON.stringify(currentDetail))
    }

    //计算数量
    function sumquantity(obj, id) {
        var value = $(obj).val();
        if (value == null || value == "") {
            return
        }
        value = parseFloat(value).toFixed(3);
        $(obj).val(value);
        var currentDetail = vm.currentDetail();
        var value1 = $("#" + id).val();
        if ('' == value1) {
            value1 = 0;
        }
        var sumQuantity = Number(value) + Number(value1);
        $("#quantity").val(sumQuantity.toFixed(3));
        currentDetail.quantity = sumQuantity.toString();
        //计算并填入板前费
        sumPreBoardFee(currentDetail);
        //计算并填入入库费
        sumInStoreFee(currentDetail);
        //计算其他费用
        sumOtherFee(currentDetail);
        //计算运费
        sumFreight(currentDetail);
        vm.initDetail(currentDetail);
    }

    //计算板前费
    function sumPreBoardFee(currentDetail) {
        //获取包装、散运板前费率
        var packagePreBoardRate = $("#packagePreBoardRate").val();
        var bulkPreBoardRate = $("#bulkPreBoardRate").val();
        //获取包装、散运吨数
        var bulk = $("#bulk").val();
        if ("" == bulk) {
            bulk = 0;
        }
        var packageNum = $("#packageNum").val();
        if ("" == packageNum) {
            packageNum == 0;
        }
        var sumPreBoardFee = packagePreBoardRate * packageNum + bulkPreBoardRate * bulk;
        $("#boardFee").val(sumPreBoardFee);
        currentDetail.boardFee = sumPreBoardFee;
    }

    //计算入库费
    function sumInStoreFee(currentDetail) {
        //获取包装、散运入库费率
        var packageInStoreRate = $("#packageInStoreRate").val();
        var bulkInStoreRate = $("#bulkInStoreRate").val();
        //获取包装、散运吨数
        var bulk = $("#bulk").val();
        var packageNum = $("#packageNum").val();
        if ("" == bulk) {
            bulk = 0;
        }
        if ("" == packageNum) {
            packageNum == 0;
        }
        var warehouseFee = packageInStoreRate * packageNum + bulkInStoreRate * bulk;
        $("#warehouseFee").val(warehouseFee);
        currentDetail.warehouseFee = warehouseFee;
    }

    //计算其他费用
    function sumOtherFee(currentDetail) {
        var boardFee = $("#boardFee").val();
        var warehouseFee = $("#warehouseFee").val();
        var otherFee = Number(boardFee) + Number(warehouseFee);
        $("#otherFee").val(otherFee);
        currentDetail.otherFee = otherFee;
    }

    //计算运费
    function sumFreight(currentDetail) {
        //运费=散运*散运运费单价 + 包装*包装运费单价
        var bulk = $("#bulk").val();
        var packageNum = $("#packageNum").val();
        var packageFreightUnit = $('#packageFreightUnit').val();
        var bulkFreightUnit = $('#bulkFreightUnit').val();
        if ('' == bulk) {
            bulk = 0;
        }
        if ('' == packageNum) {
            packageNum = 0;
        }
        if ('' == packageFreightUnit) {
            packageFreightUnit = 0;
        }
        if ('' == bulkFreightUnit) {
            bulkFreightUnit = 0;
        }
        var freight = bulk * bulkFreightUnit + packageNum * packageFreightUnit;
        $("#freight").val(freight)
        currentDetail.freight = freight;
    }

</script>
<%@include file="../common/AdminFooter.jsp" %>