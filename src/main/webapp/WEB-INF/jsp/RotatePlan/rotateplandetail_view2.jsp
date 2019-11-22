<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<%-- <%@include file="../common/AdminHeader.jsp"%> --%>

<!-- <div class="row clear-m">
<ol class="breadcrumb">
<li>轮换业务</li>
<li>轮换计划</li>
<li class="active">计划清单</li>
</ol>
</div> -->
<style>

    #data-list tr
    td[data-field="rotateType"],
    td[data-field="libraryName"],
    td[data-field="barnNumber"],
    td[data-field="foodType"],
    td[data-field="orign"],
    td[data-field="quality"],
    td[data-field="qualityDetail"],
    td[data-field="rotateType"] {
        text-align: left;
    }

    #data-list tr
    td[data-field="count"],
    td[data-field="rotateNumber"],
    td[data-field="column"],
    td[data-field="brown"],
    td[data-field="unitWeight"],
    td[data-field="impurity"],
    td[data-field="dew"],
    td[data-field="yellowRice"],
    td[data-field="unsoundGrain"],
    td[data-field="wetGluten"],
    td[data-field="koh"],
    td[data-field="mmol"] {
        text-align: right;
    }

    #tableHead tr td {
        text-align: center;
    }

</style>


<div class="container-box clearfix" style="padding: 10px">


    <fieldset class="layui-elem-field layui-field-title text-center"
              style="margin-top: 20px;">
        <legend>${rotatePlan.planName}</legend>
    </fieldset>
    <div class="layui-row">
        <div class="layui-col-md3">
            <span>计划年份:</span> <span data-field="department">${rotatePlan.year}</span>
        </div>
        <div class="layui-col-md3">
            <span>填报部门:</span> <span data-field="colletor">${rotatePlan.department}</span>
        </div>
        <div class="layui-col-md3">
            <span>经办人：</span> <span data-field="modifier">${rotatePlan.colletor}</span>
        </div>
        <div class="layui-col-md3">
            <span>经办时间：</span> <span><fmt:formatDate value="${rotatePlan.colletorDate}" pattern="yyyy-MM-dd"/></span>
        </div>
    </div>
    <!-- layui静态表格 -->
    <table class="layui-table">
        <thead id="tableHead">
        <tr>
            <td>序号</td>
            <td>轮换类别</td>
            <td>企业</td>
            <td>库点</td>
            <td>仓号</td>
            <td>粮食品种</td>
            <td>收获年份</td>
            <td>产地</td>
            <td>等级</td>
            <td>质量详情</td>
            <td>轮换数量(吨)</td>

            <td>成交数量(吨)</td>
            <td>未成交数量(吨)</td>

            <td>存储方式</td>
            <td>出糙(%)</td>
            <td>容重(g/L)</td>
            <td>杂质(%)</td>
            <td>水分(%)</td>
            <td>黄米粒(%)</td>
            <td>不完善粒(%)</td>
            <td>小麦湿面筋(%)</td>
            <td>酸价(KOH)(mg/g)</td>
            <td>过氧化值(mmol/kg)</td>
        </tr>
        </thead>
        <tbody id="data-list">
        <c:forEach items="${rotatePlan.planDetail}" var="item" varStatus="status">
            <tr>
                <td style="text-align:right" data-field="count">${status.count}</td>
                <td style="text-align:left" data-field="rotateType">${item.rotateType}</td>
                <td style="text-align:center" data-field="enterpriseName">${item.enterpriseName}</td>
                <td style="text-align:left" data-field="libraryName">${item.libraryName}</td>
                <td style="text-align:left" data-field="barnNumber">${item.barnNumber}</td>
                <td style="text-align:left" data-field="foodType">${item.foodType}</td>
                <td style="text-align:center" data-field="yieldTime">${item.yieldTime}</td>
                <td style="text-align:left" data-field="orign">${item.orign}</td>
                <td style="text-align:left" data-field="quality">${item.quality}</td>
                <td style="text-align:left" data-field="qualityDetail">
                    <textarea readonly class="layui-textarea" name="qualityDetail"
                              maxlength="45">${item.qualityDetail}</textarea>
                </td>
                <td style="text-align:right" data-field="rotateNumber">${item.rotateNumber}</td>
                <td style="text-align:right" data-field="dealDetailNumber">${item.dealDetailNumber}</td>
                <td style="text-align:right" data-field="unDealDetailNumber">${item.unDealDetailNumber}</td>
                <td style="text-align:right" data-field="storeType">${item.storeType}</td>
                <c:choose>
                    <c:when test="${item.rotateType=='轮出'}">
                        <td data-field="brown">${item.swtz.brown!=null&&item.swtz.brown!=''?item.swtz.brown:'--'}</td>
                        <td data-field="unitWeight">${item.swtz.unitWeight!=null&&item.swtz.unitWeight!=''?item.swtz.unitWeight:'--'}</td>
                        <td data-field="impurity">${item.swtz.impurity!=null&&item.swtz.impurity!=''?item.swtz.impurity:'--'}</td>
                        <td data-field="dew">${item.swtz.dew!=null&&item.swtz.dew!=''?item.swtz.dew:''}</td>
                        <td data-field="yellowRice">${item.swtz.yellowRice!=null&&item.swtz.yellowRice!=''?item.swtz.yellowRice:'--'}</td>
                        <td data-field="unsoundGrain">${item.swtz.unsoundGrain!=null&&item.swtz.unsoundGrain!=''?item.swtz.unsoundGrain:'--'}</td>
                        <td data-field="wetGluten">${item.swtz.wetGluten!=null&&item.swtz.wetGluten!=''?item.swtz.wetGluten:'--'}</td>
                        <td data-field="koh">${item.swtz.koh!=null&&item.swtz.koh!=''?item.swtz.koh:'--'}</td>
                        <td data-field="mmol">${item.swtz.mmol!=null&&item.swtz.mmol!=''?item.swtz.mmol:'--'}</td>
                    </c:when>
                    <c:otherwise>
                        <td data-field="column">${item.quotaItemMap["出糙"]!=null&&item.quotaItemMap["出糙"]!=''?item.quotaItemMap["出糙"]:"--"}</td>
                        <td data-field="column">${item.quotaItemMap["容重"]!=null&&item.quotaItemMap["容重"]!=''?item.quotaItemMap["容重"]:"--"}</td>
                        <td data-field="column">${item.quotaItemMap["杂质"]!=null&&item.quotaItemMap["杂质"]!=''?item.quotaItemMap["杂质"]:"--"}</td>
                        <td data-field="column">${item.quotaItemMap["水分"]!=null&&item.quotaItemMap["水分"]!=''?tem.quotaItemMap["水分"]:"--"}</td>
                        <td data-field="column">${item.quotaItemMap["黄米粒"]!=null&&item.quotaItemMap["黄米粒"]!=''?item.quotaItemMap["黄米粒"]:"--"}</td>
                        <td data-field="column">${item.quotaItemMap["不完善粒"]!=null&&item.quotaItemMap["不完善粒"]!=''?item.quotaItemMap["不完善粒"]:"--"}</td>
                        <td data-field="column">${item.quotaItemMap["小麦湿面筋"]!=null&&item.quotaItemMap["小麦湿面筋"]!=''?item.quotaItemMap["小麦湿面筋"]:"--"}</td>
                        <td data-field="column">${item.quotaItemMap["酸价"]!=null&&item.quotaItemMap["酸价"]!=''?item.quotaItemMap["酸价"]:"--"}</td>
                        <td data-field="column">${item.quotaItemMap["过氧化值"]!=null&&item.quotaItemMap["过氧化值"]!=''?item.quotaItemMap["过氧化值"]:"--"}</td>
                    </c:otherwise>
                </c:choose>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${myFile!=null&&type=='ProviceUnit'}">
        <div style="border: 1px #D8D8D8 solid; margin-top: 10px;">
            <div
                    style="background-color: #f8f8f8; height: 40px; line-height: 40px">
                <label style="padding-left: 20px">附件</label>
            </div>
            <div class="opinion_list clearfix" style="margin-left: 20px;">
                <div class="pull-left"
                     style="width: 43px; height: 43px; background-color: #f6f7f7; margin-top: 10px">
                    <i class="layui-icon 21cake_list"
                       style="font-size: 40px; color: #1E9FFF;"></i>
                </div>
                <div class="pull-left" style="margin-top:20px;">
                    <span>${myFile.fileName }</span>
                    <a href="../sysFile/download.shtml?fileId=${myFile.id}"
                       style="color: #0000FF; margin-left: 20px">下载</a>
                </div>
            </div>
        </div>
    </c:if>

    <div class="layui-row text-center">
        <%--<a href="../rotatePlan/exportExcel.shtml?id=${rotatePlan.id}&type=${type}" class="layui-btn layui-btn-small"
           id="exportExcel">导出</a>--%>
        <button class="layui-btn layui-btn-primary layui-btn-small" data-toggle="modal" data-target=".bs-example-modal-lg">选择导出条件</button>
    </div>


    <div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form class="layui-form" action="${ctx }/sysRole/save.shtml" method="post">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel2">导出条件</h4>
                    </div>
                    <div class="modal-body">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label" style="text-align:right">导出条件：</label>
                                <div class="layui-input-inline">
                                    <select name="dataSocpe" lay-filter="dataSocpe" class="layui-input" id="dataSocpe">
                                        <option value="all" selected>全部</option>
                                        <option value="deal">已成交</option>
                                        <option value="undeal">未成交</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal" data-type="" id="exportByCondition">导出</button>
                        <button class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

</div>


<script>
    var form = layui.form;
    form.render();
    $('#exportByCondition').click(function(){
        var dataSocpe = $('#dataSocpe').val();
        window.location.href = "../rotatePlan/exportExcel.shtml?id=${rotatePlan.id}&type=${type}&dataScope="+dataSocpe;
    })
    // 	var id='${rotatePlan.id}';
    // 	$('#exportExcel').click(function(){
    // 		$.ajax({
    // 			url:'../rotatePlan/exportExcel.shtml',
    // 			type:'POST',
    // 			data:{
    // 				id:id
    // 			},
    // 			success:function(result){},
    // 			error:function(error){
    // 				layerMsgError('导出失败');
    // 			}
    // 		});
    // 	});
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>