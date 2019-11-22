<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<%-- <%@include file="../common/AdminHeader.jsp"%> --%>


<div class="container clearfix" style="padding: 10px">

    <div class="layui-row">
        <div class="layui-col-md4">
            <span>客户名称:</span> <span>${customerInformation.clientName}</span>
        </div>
    </div>
    <div class="layui-row">
        <div class="layui-col-md4">
            <span>联系人:</span> <span>${customerInformation.contactor}</span>
        </div>
    </div>
    <div class="layui-row">
        <div class="layui-col-md4">
            <span>联系电话:</span> <span>${customerInformation.contactTel}</span>
        </div>
        <%--<div class="layui-col-md4">
            <span>竞价交易时间:</span> <span>
						<fmt:formatDate
                                value="${model.dealDate}" pattern="yyyy-MM-dd" />
			</span>
        </div>--%>
    </div>

</div>
<div class="layui-row text-center">
    <a type="button" class="layui-btn layui-btn-small" onclick="layer.close(layer.index);">关闭</a>
</div>
    <!-- layui静态表格 -->
</div>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>