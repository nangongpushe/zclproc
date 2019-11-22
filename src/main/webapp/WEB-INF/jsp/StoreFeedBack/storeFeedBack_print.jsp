<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>     --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">
body {height: auto;}
</style>

<script type="text/javascript" src="${ctx }/plugins/jQueryPrint/js/jQuery.print.js"></script>
 <input type="hidden" class="form-control" name="inspectorType" id="inspectorType" value="${inspectorType}"/>
<!-- <div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>轮换计划</li>
		<li class="active">计划清单</li>
	</ol>
</div> -->

<div class="container-box clearfix" style="padding: 10px">
	
	<div id="print" >
	<fieldset class="layui-elem-field layui-field-title text-center"
		style="margin-top: 20px;">
		<legend>检查发现问题反馈表</legend>
	</fieldset>
	<div class="layui-row">
		<div class="layui-col-md3">
		<c:if test="${ empty storeFeedBack.enterpriseName }">
			<span>被检查库点(盖章):</span> <span data-field="department">${storeFeedBack.storehouse}</span>
		</c:if>
		<c:if test="${not empty storeFeedBack.enterpriseName }">
		 <span>被检查库点(盖章):</span> <span data-field="department">${storeFeedBack.enterpriseName}</span>			
		</c:if>		
		</div>
		<div class="layui-col-md3">
			
		</div>
		<div class="layui-col-md3">
			
		</div>
		<div style="float:right" class="layui-col-md3">
			<span>填表时间：</span> <span>${storeFeedBack.reportDate}</span>
		</div>
	</div>
	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
			<tr>
				<td>序号</td>
				<td>问题类别</td>
				<td>检查发现问题及详细情况描述</td>
				<td>整改建议</td>
				<td>整改情况</td>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${storeFeedBackDeatils}" var="item" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${item.type}</td>
					<td>${item.description}</td>
					<td>${item.advise}</td>
					<td>${item.rectification}</td>
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="layui-row">
		<div style="display:inline-block;width:33%;" >
			<div style="display:inline-block;width:100%;">被检查库点</div>
			<div style="display:inline-block;width:100%;">负责人（签字）:</div>			
		</div>
		<div  style="display:inline-block;width:33%;" class="layui-col-md4">
			<div style="display:inline-block;width:100%;">检查人员</div>
			<div style="display:inline-block;width:100%;">（签字）:</div>
		</div>
		
		<div  style="display:inline-block" class="layui-col-md4">
			
			<div style="display:inline-block;width:100%;">检查组负责人检查</div>
			<div style="display:inline-block;width:100%;">确认（签字）:</div>
		</div>
	</div>
  </div>
	  <p class="btn-box text-center">
	   		  <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
              <button type="button"  onclick="jQuery('#print').print()" class="layui-btn layui-btn-primary layui-btn-small ">打印</button>
            
      </p>
</div>
<script>

  
	
	 $(".cancel").click(function(){
	
					location.href="${ctx}/StoreFeedBack.shtml";
			
		
	});
	
	

	
</script>

<%@include file="../common/AdminFooter.jsp"%>