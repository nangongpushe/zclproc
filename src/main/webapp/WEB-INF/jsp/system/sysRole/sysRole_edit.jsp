<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li><a onclick="javascript:history.back(-1);">角色列表</a></li>
		<li class="active">角色-${type}</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
	<div class="row">
		<div class="col-md-1"></div>
  		<div class="col-md-9">
  		<form class="form-horizontal" action="${ctx }/sysRole/save.shtml" method="POST">
  		<input type="text" class="form-control" name="id" id="id" value="${sysRole.id}" style="display:none">
  		
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label"><span class="red">*</span>角色名称：</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="name" id="name" placeholder="名称" value="${sysRole.name }" required>
		    </div>
		  </div>
		  	  
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label"><span class="red">*</span>角色描述：</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="type" id="type" placeholder="请输入角色类型" value="${sysRole.type }" required>
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <div class="col-sm-offset-4">
		      <button type="submit" class="layui-btn layui-btn-primary layui-btn-small" id="btnSave">保存</button>
		      <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="javascript:history.back(-1);" id="btnCancel">取消</button>
		    </div>
		  </div>
	</form>
  	<div class="col-md-2"></div>		
  		</div>
	</div>

 
	
</div>

<script>
var type = "${type}";
if(type=="详情"){
	$("form").find("input,textarea,select").prop("readonly", true);
	$('#btnSave').hide();
	$('#btnCancel').text("返回");
}
</script>

<%@ include file="../../common/AdminFooter.jsp" %>