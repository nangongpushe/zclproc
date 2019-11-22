<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>



<div class="container clearfix" style="padding: 10px">
<!-- 	<div class="layui-row title"> -->
<!-- 		<h5>保证金退还信息</h5> -->
<!-- 	</div> -->
	<div class="layui-row">
		<div class="layui-col-md3">
			<span>经办人:</span> <span>${model.operator}</span>
		</div>
		<div class="layui-col-md3">
			<span>经办部门:</span> <span>${model.department}</span>
		</div>
		<div class="layui-col-md3">
			<span>经办时间:</span> <span><fmt:formatDate pattern="yyyy-MM-dd" value="${model.handleTime}" /></span>
		</div>
		<div class="layui-col-md3">
			<span>标的号:</span> <span>${model.bidSerial}</span>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md3">
			<span>单位:</span> <span>${model.company}</span>
		</div>
		<div class="layui-col-md3">
			<span>交易方式:</span> <span>${model.dealType}</span>
		</div>
		<div class="layui-col-md3">
			<span>交易时间:</span> <span><fmt:formatDate pattern="yyyy-MM-dd" value="${model.dealDate}" /></span>
		</div>
		<div class="layui-col-md3">
			<span>数量(吨):</span> <span>${model.dealNumber}</span>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md3">
			<span>占用保证金(元):</span> <span>${model.dealAmount}</span>
		</div>
		<div class="layui-col-md3">
			<span>退还金额(元):</span> <span>${model.refundAmount}</span>
		</div>
		<div class="layui-col-md3">
			<span>未退还金额(元):</span>
			<span>${model.surplusBail}</span>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md12">
			<span>备注:</span> <span>${model.remark}</span>
		</div>
	</div>
</div>

