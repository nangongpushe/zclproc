<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link rel="StyleSheet" type="text/css" href="${ctx }/plugins/zTree_v3/css/metroStyle/metroStyle.css"/>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.exedit.js"></script>

<!-- Modal TREE -->
<div class="modal fade" id="myMenuTree" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
    
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"></h4>
      </div>
      <div class="modal-body">
      	<input type="text" name="roleId" id="roleId" hidden>
   	  	<ul id="tree" class="ztree"></ul> 
      </div>
      <div class="modal-footer">
      	<!-- <button class="layui-btn layui-btn-primary layui-btn-small" onclick="selectAll()">全选</button>
      	<button class="layui-btn layui-btn-primary layui-btn-small" onclick="cancelAll()">全不选</button> -->
        <button class="layui-btn layui-btn-primary layui-btn-small" onclick="addPermission()">确认</button>
        <button class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal">取消</button>
      </div>
      
    </div>
  </div>
</div>

<script>

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
    	enable : true,
   	 	chkboxType : { "Y" : "ps", "N" : "s" }
    },
    callback: {
              onClick: zTreeOnClick
          }  
	};  
	
	function zTreeOnClick(event, treeId, treeNode) {
				
	};
	
	function selectAll() {
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			treeObj.checkAllNodes(true);	
	};
	
	function cancelAll() {
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			zTreeObj.checkAllNodes(false);		
	};
	
	 function addPermission(e,treeId,treeNode){
            var treeObj=$.fn.zTree.getZTreeObj("tree"),
            nodes=treeObj.getCheckedNodes(true),
            v="";
            for(var i=0;i<nodes.length;i++){
            	v+=nodes[i].id + ",";
            	//alert(nodes[i].menuName); //获取选中节点的值
            }
	          $.ajax({
	             type: "POST",
	             url: "${ctx}/sysPermission/savePermission.shtml",
	             data: {roleId:$("#roleId").val(), permissionId:v},
	             dataType: "json",
	             success: function(data){
	                        if(data.msg=="success"){
	                        	alert("分配成功");
	                        	location.href="${ctx}/sysRole.shtml"
	                        }
	                      }
	         });
	}

</script>