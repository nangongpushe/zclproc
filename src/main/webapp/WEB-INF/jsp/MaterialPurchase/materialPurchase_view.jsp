<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <style type="text/css">
        #data-head tr th {
            text-align: center;
        }

        .layui-inline {
            width: 45%;
        }

        .layui-form-item .layui-form-label {
            text-align: right;
            width: 30%;
            max-width: 120px;
        }

        .layui-form-item .layui-input-inline {
            width: 65%;
        }

        .layui-form-item {
            margin-bottom: 1px;
        }

    </style>
</head>
</html>
<body style="background-color:#fff;overflow:auto!important;">

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>物资管理</li>
        <li class="active">采购管理</li>
    </ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

    <form class="layui-form form_input" action="Create.shtml" method="post" enctype="multipart/form-data">
        <div class="layui-form" id="search">
            <input type="hidden" name="id" value="${materialPurchase.id }"/>
            <input type="hidden" name="purchaseSerial" value="${materialPurchase.purchaseSerial }"/>
            <div class="layui-form-item">

                <div class="layui-inline ">
                    <label class="layui-form-label "><span class="red">*</span>申购部门:</label>
                    <div class="layui-input-inline ">
                        <input type="text" readOnly lay-verify="required" value="${materialPurchase.purchaseDept }" readOnly
                               class="layui-input" name="purchaseDept" id="purchaseDept" autocomplete="off">
                    </div>
                </div>
                <div class="layui-inline ">
                    <label class="layui-form-label"><span class="red">*</span>预计总金额:</label>
                    <div class="layui-input-inline">
                        <input type="text" readOnly lay-verify="number" value="<fmt:formatNumber type="number" value="${materialPurchase.totalAmount}" pattern="0.00" maxFractionDigits="2"/>"
                               class="layui-input" name="totalAmount" id="totalAmount"
                               autocomplete="off">
                    </div>
                </div>

                <div class="layui-inline ">
                    <label class="layui-form-label "><span class="red">*</span>申购人:</label>
                    <div class="layui-input-inline">
                        <input type="text" readOnly lay-verify="required" class="layui-input"
                               value="${materialPurchase.purchaseMan }" readOnly name="purchaseMan" id="purchaseMan"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-inline ">
                    <label class="layui-form-label"><span class="red">*</span>申购日期:</label>
                    <div class="layui-input-inline">
                        <input type="text" readOnly lay-verify="required" value="${materialPurchase.purchaseDate }"
                               class="layui-input" name="purchaseDate" id="purchaseDate"
                               autocomplete="off">
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label"><span class="red">*</span>采购原因</label>
                <div class="layui-input-inline" style="width:75%">
                    <textarea readOnly lay-verify="required" placeholder="--限500字--" maxlength="500" name="purchaseReason"
                              class="layui-textarea">${materialPurchase.purchaseReason } </textarea>
                </div>
            </div>

            <div class="layui-row title">
                <h5>材料明细</h5>
            </div>

            <table class="layui-table">
                <thead id="data-head">
                <tr>
                    <th><span class="red">*</span>物资/材料名称</th>
                    <th><span class="red">*</span>规格型号</th>
                    <th><span class="red">*</span>采购数量</th>
                    <th><span class="red">*</span>单价(元)</th>
                    <th><span class="red">*</span>预计单价(元)</th>
                    <th>备注</th>
                </tr>
                </thead>
                <!-- 表格内容start -->
                <tbody id="materialDetail" class="text-center">
                <c:forEach items="${materialPurchaseDeatils}" var="materialPurchaseDeatil">
                    <tr>
                        <td><input type="text" readOnly name="materialName" value="${materialPurchaseDeatil.materialName }"
                                   lay-verify="required" class="layui-input" placeholder="--请输入--"/></td>
                        <td><input type="text" readOnly name="model" value="${materialPurchaseDeatil.model }"
                                   class="form-control validate[required] " placeholder=""/></td>
                        <td><input type="text" readOnly name="quantity" value="${materialPurchaseDeatil.quantity }"
                                   lay-verify="required" class="layui-input" placeholder=""/></td>
                        <td><input type="text" readOnly name="unitPrice" value="${materialPurchaseDeatil.unitPrice }"
                                   lay-verify="required" class="layui-input" placeholder=""/></td>
                        <td><input type="text" readOnly name="estimatedUnitPrice"
                                   value="${materialPurchaseDeatil.estimatedUnitPrice }" lay-verify="number"
                                   class="layui-input" placeholder=""/></td>
                        <td><textarea type="text" readOnly name="remark" class="form-control" style="resize:none"
                                      placeholder="--限500字--">${materialPurchaseDeatil.remark }</textarea></td>
                    </tr>
                </c:forEach>
                </tbody>
                <!-- 表格内容 end -->
            </table>

        </div>
    </form>

</div>

</body>
