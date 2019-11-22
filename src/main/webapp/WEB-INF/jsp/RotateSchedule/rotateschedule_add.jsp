<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp" %>

<style>

</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>进度上报</li>
        <c:if test="${isedit}">
            <li class="active">上报编辑</li>
        </c:if>
        <c:if test="${!isedit}">
            <li class="active">上报新增</li>
        </c:if>
    </ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

    <div class="layui-row title">
        <h5>进度上报信息</h5>
    </div>

    <form class="layui-form" lay-filter="form">
        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>轮换类型:</label>
                <div class="layui-input-inline">
                    <select name="noticeType" lay-verify="required" lay-filter="noticeType">
                        <option value="">--请选择--</option>
                        <option value="出库">出库</option>
                        <option value="入库">入库</option>
                    </select>
                </div>
            </div>

            <div class="layui-inline layui-col-md5" id="notice">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>通知书编号:</label>
                <div class="layui-input-inline">
                    <select name="noticeId" lay-verify="required" lay-filter="noticeSerial"
                            data-bind="options:noticeList,optionsText:'noticeSerial',
					optionsValue:'id',optionsCaption:'--请选择--'">

                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">经办人:</label>
                <div class="layui-input-inline">
                    <input class="layui-input form-control" name="operator"
                           autocomplete="off" value="${model.operator}" readonly>
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">经办部门:</label>
                <div class="layui-input-inline">
                    <input class="layui-input form-control" name="department"
                           autocomplete="off" value="${model.department}" readonly>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">填报时间:</label>
                <div class="layui-input-inline">
                    <input class="layui-input form-control" name="reportTime"
                           autocomplete="off"
                           value='<fmt:formatDate value="${model.reportTime}" pattern="yyyy-MM-dd" />' readonly>
                </div>
            </div>

            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right">填报单位:</label>
                <div class="layui-input-inline">
                    <input class="layui-input form-control" name="reportUnit"
                           autocomplete="off" value="${model.reportUnit}" readonly>
                </div>
            </div>
        </div>


        <hr class="layui-bg-green">

        <button type="button"
                class=" layui-btn layui-btn-primary layui-btn-small" data-target="#myModal"
                name="file" data-bind="click:function(){$root.showModal();}">新增明细
        </button>

        <table class="layui-table">
            <thead>
            <tr>
                <td align="center">仓号</td>
                <td align="center">品种</td>
                <td align="center">提货单位</td>
                <td align="center">合同数量（吨）</td>
                <td align="center">上期累计（吨）</td>
                <td align="center">本期（吨）</td>
                <td align="center">累计（吨）</td>
                <td align="center">完成率（%）</td>
                <td align="center">备注</td>
                <td align="center">操作</td>
            </tr>
            </thead>
            <tbody data-bind="foreach:detailList">
            <tr>
                <td data-bind="text:storehouse" align="left"></td>
                <td data-bind="text:grainType" align="left"></td>
                <td data-bind="text:deliveryUnit" align="left"></td>
                <td data-bind="text:quantity" align="right"></td>
                <td data-bind="text:priorPeriod" align="right"></td>
                <td align="right">
                    <input class="layui-input" data-bind="value:currentPeriod" lay-verify="required|number"
                           onchange="numberFixed(this,3)">
                </td>
                <td data-bind="text:total" align="right"></td>
                <td data-bind="text:compleRate" align="right"></td>
                <td align="left">
                    <input class="layui-input" data-bind="value:remark" maxlength="500">
                </td>
                <td align="center">
                    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini"
                       data-bind="click:function(){$root.remove($index())}">删除</a>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="layui-row text-center"
             data-bind="visible:detailList().length==0">暂无明细数据
        </div>

        <div class="layui-form-item text-center">
            <button type="button" class=" layui-btn layui-btn-primary layui-btn-small"
                    lay-submit="" lay-filter="save" data-status="待提交">保存
            </button>
            <button type="button" class=" layui-btn layui-btn-primary layui-btn-small"
                    lay-submit="" lay-filter="save" data-status="审核中">提交
            </button>
            <button type="button"
                    class=" layui-btn layui-btn-primary layui-btn-small" id="cancel"
                    data-bind="click:function(){$root.cancel();}">取消
            </button>
        </div>
    </form>

    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true"
         data-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;
                    </button>
                    <h4>选择对应的成交明细</h4>
                </div>
                <div class="modal-body">
                    <div class="layui-form" id="search" lay-filter="search">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">成交子明细号:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" name="dealSerial" id="dealDate"
                                           autocomplete="off">
                                </div>
                            </div>

                            <div class="layui-inline">
                                <label class="layui-form-label">粮食品种:</label>
                                <div class="layui-input-inline">
                                    <select name="grainType">
                                        <option value="">--请选择--</option>
                                        <c:forEach var="item" items="${grainTypes}">
                                            <option value="${item.value}">${item.value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">标的:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" name="bidSerial" id="bidSerial"
                                           autocomplete="off">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">仓房编号:</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" name="storehouse" id="storehouse"
                                           autocomplete="off">
                                </div>
                            </div>

                            <div class="layui-inline">
                                <button class=" layui-btn layui-btn-primary layui-btn-small"
                                        data-type="reload"
                                        data-bind="click:function(){$root.queryPageList();}">查询
                                </button>
                            </div>
                            <div class="layui-inline">
                                <button class=" layui-btn layui-btn-primary layui-btn-small"
                                        data-type="reload"
                                        data-bind="click:function(){$root.clear();}">清空
                                </button>
                            </div>
                        </div>
                    </div>

                    <table class="layui-table">
                        <thead>
                        <tr>
                            <td data-bind="visible:dealList().length!=0"></td>
                            <td align="center">成交子明细号</td>
                            <td align="center">标的</td>
                            <td align="center">仓房编号</td>
                            <td align="center">粮食品种</td>
                            <td align="center">数量（吨）</td>
                        </tr>
                        </thead>
                        <tbody data-bind="foreach:dealList">
                        <tr>
                            <td><input type="checkbox" name="checkbox"
                                       data-bind="click:function(){$root.choose($data,$element,$index());return true;},checked:checked"/>
                            </td>
                            <td data-bind="text:dealSerial" align="left"></td>
                            <td data-bind="text:bidSerial" align="left"></td>
                            <td data-bind="text:storehouse" align="left"></td>
                            <td data-bind="text:grainType" align="left"></td>
                            <td data-bind="text:quantity" align="right"></td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="layui-row text-center"
                         data-bind="visible:dealList().length==0">无数据
                    </div>
                    <div class="layui-row">
                        <div id="pagination" class=""></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button"
                            class=" layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.confirmChoose($element);}">确定
                    </button>
                    <button type="button"
                            class=" layui-btn layui-btn-primary layui-btn-small"
                            data-bind="click:function(){$root.hideModal();}">取消
                    </button>

                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
<script src="../js/knockout-3.4.0.js"></script>

<script src="../js/app/rotateschedule/add.js"></script>
<script>
    var isedit =${isedit};
    var id = '${model.id}' || 0;
    var detailList =${cf:toJSON(details)};
    var schedule =${cf:toJSON(model)};

    if (isedit) {
        $('[name="noticeType"]').val("${model.noticeType}");

    }


    var vm = new Add(isedit, id, detailList, schedule);

    ko.applyBindings(vm, $(".container-box")[0]);
    vm.initPage();

    function numberFixed(obj, op) {
        //debugger
        number = $(obj).val();
        if (number == null || number == "") {
            return
        }
        number = parseFloat(number).toFixed(op);
        $(obj).val(number);
    }

</script>
<%@include file="../common/AdminFooter.jsp" %>