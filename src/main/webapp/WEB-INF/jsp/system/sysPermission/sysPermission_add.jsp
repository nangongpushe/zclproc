<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link rel="StyleSheet" type="text/css" href="${ctx }/plugins/zTree_v3/css/metroStyle/metroStyle.css"/>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.exedit.js"></script>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li><a onclick="javascript:history.back(-1);">权限列表 </a></li>
		<li class="active">菜单权限-${type}</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
	<div class="row">
		<div class="col-md-2">
			<ul id="tree" class="ztree"></ul> 
		</div>
  		<div class="col-md-8">
  		<form class="layui-form" action="${ctx }/sysPermission/save.shtml" method="POST">
		<input type="text" class="form-control" name="id" id="id" value="${sysPermission.id}" style="display:none">
		<input type="text" class="form-control" name="menuLevel" id="menuLevel" placeholder="菜单等级" value="${sysPermission.menuLevel }" style="display:none">

		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>名称：</label>
		    <div class="layui-input-block">
		      <input type="text" name="name" autocomplete="off" placeholder="请输入权限名称" class="layui-input" lay-verify="required" value="${sysPermission.name }">
		    </div>
		  </div>

		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">上级菜单：</label>
		    <div class="layui-input-block">
		    <select name="parentId" id="select-control-parentId">
		        <option value=""></option> 
		         <c:forEach var="obj" items="${list}" varStatus="var" >
                         <option value="${obj.id }">${obj.name }</option>
                </c:forEach>
		      </select>
		    </div>
		  </div> 

  		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>类型：</label>
		    <div class="layui-input-block">
		    <select name="type" id="select-control-type">
		         <option value="menu">菜单</option>
	    		 <option value="button">按钮</option>
		      </select>
		    </div>
		  </div> 

		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>URL地址：</label>
		    <div class="layui-input-block">
		      <input type="text" name="url" autocomplete="off" placeholder="URL地址" class="layui-input" lay-verify="required" value="${sysPermission.url }">
		    </div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label" style="text-align:right">排序：</label>
		    <div class="layui-input-block">
		      <input type="text" name="sort" autocomplete="off" placeholder="请填写排序信息" class="layui-input" lay-verify="number" value="${sysPermission.sort }">
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



var parentId = "${sysPermission.parentId}";
$("#select-control-parentId").val(parentId);	

var type = "${sysPermission.type}";
$("#select-control-type").val(type);

var type = "${type}";
if(type=="详情"){
	$("form").find("input,textarea,select").prop("readonly", true);
	$("form").find("select").prop("disabled", true);
	$('#btnSave').hide();
	$('#btnCancel').text("返回");
}

$(document).ready(function(e){ 

  var zTreeObj;  
   
   var setting = {  
    data: {  
    	key:{
    		 name:"name"
    	},
    
        simpleData: {  
            enable: true,  
            idKey: "id",  
            pIdKey: "parentId",          
            rootPId: 0  
        }  
    },
    
    check:{
    	enable : false,
   	 	chkboxType : { "Y" : "ps", "N" : "ps" }
    },
    callback: {
              onClick: zTreeOnClick
             
          }  
	}; 
	
		function zTreeOnClick(event, treeId, treeNode) {
/* 			$('[name="id"]').val(treeNode.id);
			$('[name="parentId"]').val(treeNode.parentId);	 */
            $('input[name="name"]').val(treeNode.name);
			$("#select-control-parentId").val(treeNode.parentId);
			var form = layui.form
			form.render('select'); //刷新select选择框渲染
			var level = treeNode.menuLevel;
	        if(level==null){	   	
	        	  $("#menuLevel").val(1);
	        }else{
	        	  $("#menuLevel").val(level+1);
	        }	
			
	};
	
var urls = "${ctx}/sysPermission/getTree.shtml";
         $.ajax({
          type: "POST",
          data:{roleId:null},
          url: urls,
          dataType: "json",
          success: function(data){
          			var sysPermissions = data.sysPermissions;
         			 var zNodes=[];
         			   $.each(sysPermissions,function(i,item){					
         			   		item.url = "";
         			   		zNodes.push(item);
         			   });           		
					zTreeObj = $.fn.zTree.init($("#tree"), setting, zNodes);
   					zTreeObj.expandAll(false);	 	
                  }
        });      	

 } )
 
   function levelChange(){
   		var objS = document.getElementById("select-control-parentId");
        var level = objS.options[objS.selectedIndex].getAttribute('level');
        if(level==null){  		
        	  $("#menuLevel").val(1);
        }else{
        	  $("#menuLevel").val(level++);
        }
      
   }
   
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