<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../common/AdminHeader.jsp"%>


    <div class="row clear-m">
        <ol class="breadcrumb">
            <li>代储监管</li>
            <li>企业信息</li>
            <li class="active">[代储]仓房管理</li>
        </ol>
    </div>

<div class="container-box clearfix" style="padding: 10px">
    <div class="layui-row layui-col-space15">
        <div class="layui-form-item">
            <div class="layui-col-md4">
                <label class="layui-form-label">所属库点：</label>
                <label class="layui-form-label">${storageStoreHouse.warehouse }</label>
            </div>
            <div class="layui-col-md4">
                <label class="layui-form-label">仓房编号：</label>
                <label class="layui-form-label">${storageStoreHouse.encode }</label>
            </div>
            <div class="layui-col-md4">
                <label class="layui-form-label">仓房类型：</label>
                <label class="layui-form-label">${storageStoreHouse.type }</label>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-md4">
                <label class="layui-form-label">仓房状态：</label>
                <label class="layui-form-label">${storageStoreHouse.status }</label>
            </div>
            <div class="layui-col-md4">
                <label class="layui-form-label">启用日期：</label>
                <label class="layui-form-label">${storageStoreHouse.enableDate }</label>
            </div>
            <div class="layui-col-md4">
                <label class="layui-form-label">结构：</label>
                <label class="layui-form-label">${storageStoreHouse.structure }</label>
            </div>
        </div>
    </div>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>仓房维修保养记录</legend>
    </fieldset>
    <form class="layui-form" id="optionForm">
        <input type="hidden" id="flag" name="flag" value="${flag }">
        <input name="id" value="${option.id }" type="hidden">
        <c:choose>
            <c:when test="${auvp eq 'u'}">
                <input name="storehouseId" value="${option.storehouseId }" type="hidden">
            </c:when>
            <c:when test="${auvp eq 'a'}">
                <input name="storehouseId" value="${storageStoreHouse.id }" type="hidden">
            </c:when>
        </c:choose>
        <div class="layui-form-item">
            <label class="layui-form-label" style="text-align:right"><span class="red">*</span>日期：</label>
            <div class="layui-input-block">
                <input lay-verify="date" autocomplete="off" placeholder="请选择日期" class="layui-input date-need"
                       name="repairDate" value="<fmt:formatDate value='${option.repairDate }' type='date' pattern='yyyy-MM-dd'/>">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="text-align:right"><span class="red">*</span>项目名称：</label>
            <div class="layui-input-block">
                <input lay-verify="required" autocomplete="off" placeholder="请输入名称" class="layui-input"
                       name="projectName" value="${option.projectName }" maxlength="50">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="text-align:right"><span class="red">*</span>施工验收情况：</label>
            <div class="layui-input-block">
                <input lay-verify="required" autocomplete="off" placeholder="请输入项目验收情况" class="layui-input"
                       name="construction" value="${option.construction }" maxlength="100">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="text-align:right">备注：</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入备注" class="layui-textarea" name="remark" maxlength="450">${option.remark }</textarea>
            </div>
        </div>
        <p class="btn-box text-center">
            <button type="reset" class="layui-btn layui-btn-primary layui-btn-small" name="cancelBt" onclick="cancelOperate();">取消</button>
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="submitBt" lay-submit lay-filter="submit_btn">
                保存<c:if test="${auvp eq 'u' }">更改</c:if></button>
        </p>
    </form>
</div>

<script src="${ctx}/js/app/storage/common.js"></script>

<script type="text/javascript">
    layui.use(['form','laydate'],function() {
        var form = layui.form,
            laydate = layui.laydate;
        form.render();
        //为需要date的input渲染日历
        $('.date-need').each(function(){
            laydate.render({
                elem: this,
            });
        });
        form.on('submit(submit_btn)',function(){
            layer.load();
            var form = $('#optionForm');
            var json = JSON.stringify(form.serializeObject());
            $.ajax({
                type : 'POST',
                url : '${ctx }/storageStoreHouseOption/proxySave.shtml?auvp=${auvp }',
                dataType : "json",
                contentType : "application/json",
                data : json,
                error: function(request) {
                    layer.closeAll();
                    if(request.responseText){
                        layer.open({
                            type: 1,
                            area: ['700px', '430px'],
                            fix: false,
                            content: request.responseText
                        });
                    }
                },
                success : function(result) {
                    if(result.success) {
                        layer.msg(result.msg, {icon : 1, time : 1000}, function(){
                            if ('${auvp }' === 'a') {
                                location.href = '${ctx }/storageStoreHouse/proxyStorageStoreHouse.shtml';
                            } else if ('${auvp }' === 'u'){
                                location.href = '${ctx }/storageStoreHouse/proxyEditPage.shtml?id=' + '${storageStoreHouse.id }';
                            }
                        });
                    } else {
                        layer.closeAll();
                        layer.msg(result.msg, {icon : 2, time : 1000});
                    }
                }
            });
        });
    });

    function cancelOperate() {
        if ('${auvp }' === 'v') {
            history.go(-1);
        } else {
            layer.confirm('您是否要放弃编辑', function(index) {
                history.go(-1);
            });
        }
    };
</script>
<%@include file="../common/AdminFooter.jsp"%>