<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li><a onclick="javascript:history.back(-1);">用户列表 </a></li>
		<li class="active">用户-${type}</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-9">
  		<form id="user" class="layui-form" action="${ctx }/sysUser/save.shtml" method="POST">
			<input type="hidden"  name="company" id="company" value="${sysUser.company }">
  		<input type="text" name="id" lay-verify="id" autocomplete="off" style="display:none" class="layui-input"  value="${sysUser.id }">
		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>账号：</label>
		    <div class="layui-input-block">
		      <input type="text" name="account" lay-verify="required|account" autocomplete="nope" placeholder="请输入登录账号" class="layui-input" value="${sysUser.account }">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>名称：</label>
		    <div class="layui-input-block">
		      <input type="text" name="name" lay-verify="required" placeholder="请输入名称" autocomplete="new-account" class="layui-input" value="${sysUser.name }">
		    </div>
		  </div>
  		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>密码：</label>
		    <div class="layui-input-block">
		      <input type="password" name="password" lay-verify="password" placeholder="请输入密码" autocomplete="new-password" lay-verify="required" class="layui-input" value="${sysUser.password }">
		    </div>
		  </div>
   		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>公司名称：</label>
		    <div class="layui-input-block">
		      <select type="text" name="enterPriseId" lay-verify="required" autocomplete="off" id="enterPriseId" lay-search>
		      	  <c:if test="${type =='详情'}">
					  <option >${sysUser.company }</option>

				  </c:if>
				<c:if test="${type!='详情'}">
					<option ></option>
			      <c:forEach items="${enterPrise}" var="company">
			      	<option  value="${company.id }" <c:if test="${sysUser.enterPriseId eq company.id }">selected</c:if>>${company.enterpriseName }</option>
			      </c:forEach>
				</c:if>
		      </select>
		    </div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点编码：</label>
		    <div class="layui-input-block">
		      <input type="text" name="originCode" lay-verify="required|originCode"  placeholder="库点编码" autocomplete="off" class="layui-input" value="${sysUser.originCode }" oninput="clearoriginCode(this)" maxlength="10">
		    </div>
		  </div>
		  
 		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">部门：</label>
		    <div class="layui-input-block">
		      <input type="text" name="department" lay-verify="department" placeholder="请输入部门信息" autocomplete="off" class="layui-input" value="${sysUser.department }">
		    </div>
		  </div>
   		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">岗位：</label>
		    <div class="layui-input-block">
		      <input type="text" name="position" lay-verify="position" placeholder="请输入岗位信息" autocomplete="off" class="layui-input" value="${sysUser.position }">
		    </div>
		  </div>
 		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">电话：</label>
		    <div class="layui-input-block">
		      <input type="tel" name="cellPhone" placeholder="请输入电话号码" autocomplete="off" lay-verify="phone1" class="layui-input" value="${sysUser.cellPhone }">
		    </div>
		  </div>
 		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">邮箱：</label>
		    <div class="layui-input-block">
		      <input type="text" name="email" lay-verify="email1" placeholder="请输入邮箱信息" autocomplete="off" class="layui-input" value="${sysUser.email }">
		    </div>
		  </div>
   		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">图像URL：</label>
		    <div class="layui-input-block">
		      <input type="text" name="avatar" lay-verify="avatar" placeholder="请输入图像URL" autocomplete="off" class="layui-input" value="${sysUser.avatar }">
		    </div>
		  </div>

 		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">电子签名URL：</label>
		    <div class="layui-input-block">
		      <input type="text" name="signature" lay-verify="signature" placeholder="请输入电子签名URL" autocomplete="off" class="layui-input" value="${sysUser.signature }">
		    </div>
		  </div>

	    <div class="layui-form-item">
		    <div class="layui-input-block">
		      <button class="layui-btn layui-btn-primary layui-btn-small" lay-submit lay-filter="formDemo" id="btnSave">保存</button>
		      <button type="reset" class="layui-btn layui-btn-primary layui-btn-small" onclick="javascript:history.back(-1);" id="btnCancel">取消</button>
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
	$("form").find("input,textarea").prop("readonly", true);
	$("form").find("select").prop("disabled", true);
	$('#btnSave').hide();
	$('#btnCancel').text("返回");
}
if(type=="编辑"){
	$("form").find("input[name='account']").removeAttr("lay-verify");
	$("form").find("input[name='account']").prop("readonly", true);
}

layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;

  
  
  form.render();
    form.on('select(enterPriseId)', function(data){

        var options=$("#enterPriseId option:selected"); //获取选中的项


        $("#company").val(options.text());

    })
  //创建一个编辑器
  var editIndex = layedit.build('LAY_demo_editor');
 
  //自定义验证规则
  form.verify({
    name: function(value){
      if(value.length > 5){
        return '至多5个字符';
      }
    }
    ,account: function(value){
    	var code;
		 $.ajax({
             type: "GET",
             url: "${ctx }/sysUser/validateAccount.shtml?account="+value,
             data: {},
             async : false,  
             dataType: "json",
             success: function(data){
					code=data.code;
                      }
         		});
		  if(code==1){
		  	return '账号已存在';
		  }
    }
    ,password:[/(.+){6,12}$/, '密码必须6到12位']
    ,phone1: function(value){
    	if(value!=null&&value!=''){
    		 if(/^1[3|4|5|7|8]\d{9}$/.test(value)){		       
		    	}else{
		     return '手机必须11位，只能是数字！';	    
		    }
    	}
    }
    ,email1: function(value){
    	if(value!=null&&value!=''){
    		 if(/^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$|^1[3|4|5|7|8]\d{9}$/.test(value)){		       
	    		}else{
		     return '邮箱格式不对！';	    
		    }
    	}
    }
  });
  //监听提交
  form.on('submit(user)', function(data){
    layer.alert(JSON.stringify(data.field), {
      title: '最终的提交信息'
    })
    return false;
  });
	
});


function clearoriginCode(obj) {
    obj.value = obj.value.toUpperCase();
    //修复第一个字符是小数点 的情况.  
    obj.value = obj.value.replace(/[^a-zA-z0-9]/g,"");  //清除“数字”和“.”以外的字符      
}
</script>

<%@ include file="../../common/AdminFooter.jsp" %>