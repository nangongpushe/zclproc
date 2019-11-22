<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
.layui-table-view {
    margin: 10px 10px !important;
}
/* <!-- 页面的CSS --> */
	#outSide{
		width:94%;
		margin-left:2%;
		padding:1%;
		background:#fff;
		border-top:2px solid #23b7e5;
	}
	
	.infoArea{
		width:100%;
		padding:20px 0;
		border-bottom: 2px solid #e2e2e2;
	}
	
	.title{
		color:RGB(25,174,136);
		font-weight:bold;
	}
	
	#infoArea{
		margin-top:20px;
		margin-left:4%;
	}
	
	#infoArea span{
		padding-right:100px;
	}
	
	.requiredData{
		color:red;
	}
	
	#mainInfo{
		margin-top:20px;
		margin-left:2.5%;
	}
	
	#mainInfo>div{
		padding:10px 0;
		width:100%;
	}
	
	#mainInfo>div span{
		width:10%;
		display:inline-block;
		text-align:center;
	}
	
	.inputArea{
		width:89%;
		padding:5px;
		border-radius:5px;
		outline: none;
		border:1px solid #ccc;
		resize: none;
	}
	
	.buttonArea{
		padding:5px 15px;
		background:RGB(25,174,136);
		border:none;
		border-radius:5px;
		color:#fff;
		cursor:pointer;
		display:inline;
	}
	
	#listArea{
		padding:20px 0;
		width:100%;
	}
	
	table{
		margin-top:20px;
		width:100%;
		border-collapse:collapse;
		text-align:center;
	}
	
	thead{
		background:#eee;
	}
	
	table tr td{
		width:9%;
		border:none;
		padding:10px 0;
	}
	
	tbody tr{
		border-bottom:1px solid #ccc;
	}
	
	#bottom-button{
		text-align:right;
		padding-right:20px;
		margin-top:20px;
	}
	
	#bottom-button>div{
		margin-right:10px;
	}
	
	#template-tr{
		display:none;
	}
	
	.layui-table-view {
    margin: 10px 10px !important;
}

</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li><a onclick="javascript:history.back(-1);">数据词典 </a></li>
		<li class="active">数据词典-${type }</li>
	</ol>
</div>
<div id="outSide">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
	<div class="row">
		<div class="col-md-1"></div>
  		<div class="col-md-9">
  		<form class="layui-form" action="${ctx }/sysDict/save.shtml" method="post">
  		
  		<input class="inputArea" type="text" id="id" name="id" style="width:80%" value="${sysDict.id }" hidden>		

		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>类型：</label>
		    <div class="layui-input-block">
		      <input type="text" name="type"  autocomplete="off" placeholder="请输入类型" class="layui-input" lay-verify="required" value="${sysDict.type }">
		    </div>
		  </div> 

  		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">名称：</label>
		    <div class="layui-input-block">
		      <input type="text" name="label"  autocomplete="off" placeholder="请输入词典名称" class="layui-input"  value="${sysDict.label }">
		    </div>
		  </div> 	

  		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>数值：</label>
		    <div class="layui-input-block">
		      <input type="text" name="value"  autocomplete="off" placeholder="请输入词典值" class="layui-input"  value="${sysDict.value }" lay-verify="required">
		    </div>
		  </div> 	

		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">排序：</label>
		    <div class="layui-input-block">
		      <input type="text" name="sort"  autocomplete="off" placeholder="请输入排序" class="layui-input"  value="${sysDict.sort }" lay-verify="number">
		    </div>
		  </div> 

  		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">上级词典：</label>
		    <div class="layui-input-block">
		    <select name="parentid" id="parentid" value="${sysDict.parentid}">
		        <option value=""></option> 
		         <c:forEach var="obj" items="${list}" varStatus="name" >
                         <option value="${obj.id }">${obj.value }</option>
                </c:forEach>
		      </select>
		    </div>
		  </div> 
	  	
	   <div class="layui-form-item layui-form-text">
			<label class="layui-form-label" style="text-align:right">备注：</label>
			<div class="layui-input-block">
			  <textarea placeholder="请输入内容" class="layui-textarea" id="remark" name="remark">${sysDict.remark }</textarea>
			</div>
		</div>

	    <div class="layui-form-item">
		    <div class="layui-input-block">
		      <button class="layui-btn layui-btn-primary layui-btn-small" lay-submit lay-filter="formDemo" id="btnSave">确认</button>
		      <button type="reset" class="layui-btn layui-btn-primary layui-btn-small" onclick="javascript:history.back(-1);" id="btnCancel">取消</button>
		    </div>
		</div>		  
</form>
  	<div class="col-md-2"></div>		
  		</div>
	</div>

 
	
</div>

<script>
var parentId = "${sysDict.parentid}";
$("#parentid").val(parentId);

var type = "${type}";
if(type=="详情"){
	$("form").find("input,textarea").prop("readonly", true);
	$("form").find("select").prop("disabled", true);
	$('#btnSave').hide();
	$('#btnCancel').text("返回");
}
//Demo
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  
  
  form.render();
 
  //自定义验证规则
  form.verify({
  });
  
  
  //监听提交
  form.on('submit(demo1)', function(data){
    layer.alert(JSON.stringify(data.field), {
      title: '最终的提交信息'
    })
    return false;
  });
  
  
});
</script>

<%@ include file="../../common/AdminFooter.jsp" %>