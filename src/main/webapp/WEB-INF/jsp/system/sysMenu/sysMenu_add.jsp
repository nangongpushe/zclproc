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
		<li><a onclick="javascript:history.back(-1);">菜单管理 </a></li>
		<li class="active">增加</li>
	</ol>
</div>
<div id="outSide">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			<legend>菜单管理</legend>
	</fieldset>
	<div class="row">
		<div class="col-md-2">
			<ul id="tree" class="ztree"></ul> 
		</div>
  		<div class="col-md-8">
  		<form class="form-horizontal" action="${ctx }/sysMenu/save.shtml">
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">名称：</label>
		    <input type="text" class="form-control" name="menuId" id="menuId" placeholder="菜单名称" value="${sysMenu.menuId }" style="display:none">
		    <input type="text" class="form-control" name="menuLevel" id="menuLevel" placeholder="菜单等级" value="${sysMenu.menuLevel }" style="display:none">
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="menuName" id="menuName" placeholder="菜单名称" value="${sysMenu.menuName }">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">URL地址：</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="url" id="url" placeholder="URL地址" value="${sysMenu.url }">
		    </div>
		  </div>
		  
	   	  <div class="form-group">
		    <label class="col-sm-2 control-label">排序：</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="sort" id="sort" placeholder="排序" value="${sysMenu.sort }">
		    </div>
		  </div>
		  
		  <div class="form-group">
		      <label for="inputPassword3" class="col-sm-2 control-label">上级菜单：</label>
		    <div class="col-sm-10">
		    
		     <select class="form-control" name="parentid" id="select-control" onchange="levelChange()">   
		     		  <option value="" level="1">无上级菜单(可点击左侧菜单进行选择)</option>
			      <c:forEach var="data" items="${list}" varStatus="var" >
		              <option value="${data.menuId }" level="${data.menuLevel }">${data.menuName }</option>
			      </c:forEach>	
			</select>
		    </div> 
		  </div>
		 
		   <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">备注：</label>
		    <div class="col-sm-10">
		      <textarea class="form-control" rows="3" name="note" >${sysMenu.note }</textarea>   
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <div class="col-sm-offset-5">
		      <button type="submit" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
		      <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="javascript:history.back(-1);">取消</button>
		    </div>
		  </div>
</form>
  	<div class="col-md-2"></div>		
  		</div>
	</div>

 
	
</div>

<script>

var parentId = "${sysMenu.parentid}";
$("#select-control").val(parentId);	



  var zTreeObj;  
   
   var setting = {  
    data: {  
    	key:{
    		 name:"menuName"
    	},
    
        simpleData: {  
            enable: true,  
            idKey: "menuId",  
            pIdKey: "parentid",          
            rootPId: 0  
        }  
    },
    
    check:{
    	enable : false
    },
    callback: {
              onClick: zTreeOnClick
             
          }  
	};  
	
	function zTreeOnClick(event, treeId, treeNode) {
/* 			$('[name="id"]').val(treeNode.id);
			$('[name="parentId"]').val(treeNode.parentId);	 */
			$("#select-control").val(treeNode.menuId);	
			var level = treeNode.menuLevel;
	        if(level==null){  		   	
	        	  $("#menuLevel").val(1);
	        }else{
	        	  $("#menuLevel").val(level+1);
	        }
	};
	
	 function onCheck(e,treeId,treeNode){
            var treeObj=$.fn.zTree.getZTreeObj("tree"),
            nodes=treeObj.getCheckedNodes(true),
            v="";
            for(var i=0;i<nodes.length;i++){
            	v+=nodes[i].name + ",";
            	alert(nodes[i].menuName); //获取选中节点的值
            }
	}
	
   $(document).ready(function(){  
   	  var urls = "${ctx}/sysMenu/getTree.shtml";
   	         $.ajax({
             type: "POST",
             data:'',
             url: urls,
             dataType: "json",
             success: function(data){
            			 var zNodes=[];
            			   $.each(data,function(i,item){
            			   		item.url = "";
            			   		zNodes.push(item);
            			   });           		
						zTreeObj = $.fn.zTree.init($("#tree"), setting, zNodes);
      					zTreeObj.expandAll(false);	 
                      }
         });      
   });
   
   function levelChange(){
   		var objS = document.getElementById("select-control");
        var level = objS.options[objS.selectedIndex].getAttribute('level');
        if(level==null){  		
        	  $("#menuLevel").val(1);
        }else{
        	  $("#menuLevel").val(level++);
        }
      
   }  
</script>

<%@ include file="../../common/AdminFooter.jsp" %>