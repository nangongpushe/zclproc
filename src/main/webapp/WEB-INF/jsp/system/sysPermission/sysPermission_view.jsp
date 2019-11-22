<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<link rel="StyleSheet" type="text/css" href="${ctx }/plugins/zTree_v3/css/metroStyle/metroStyle.css"/>
<style>
	#LAY_table_permission + .layui-form .layui-table-body td[data-field="name"]{
		text-align: left;
	}
	#LAY_table_permission + .layui-form .layui-table-body td[data-field="type"]{
		text-align: left;
	}
	#LAY_table_permission + .layui-form .layui-table-body td[data-field="url"]{
		text-align: left;
	}
	#LAY_table_permission + .layui-form .layui-table-body td[data-field="createTime"]{
		text-align: center;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li class="active">权限菜单管理</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
		
		<div class="demoTable">
				<input type="hidden" class="layui-input" name="perId" id="perId" autocomplete="off">
			名称：
			<div class="layui-inline">
				<input class="layui-input" name="name" id="name" autocomplete="off">
			</div>
			类型：
			<div class="layui-inline">
				<input class="layui-input" name="type" id="type" autocomplete="off">
			</div>
			<button class="layui-btn layui-btn-primary layui-btn-small" id="serch_reload" data-type="reload">查询</button>
			<div class="layui-inline" style="float:right">
				<button class="layui-btn layui-btn-primary layui-btn-small" onclick="javascript:window.location.href='${ctx}/sysPermission/add.shtml'">添加权限</button>
			</div>
		</div>
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
	<div class="row">
		<div class="col-md-2">
			<ul id="tree" class="ztree"></ul>
		</div>
  		<div class="col-md-9">	
  			<table class="layui-hide" id="LAY_table_permission" lay-filter="demoEvent"></table>
		</div>
	</div>
	
	

	</div>

<script>

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
			$("#perId").val(treeNode.id);
			document.getElementById("serch_reload").click();		
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




layui.use('table',function(){
var table =layui.table;
//render初始化参数
table.render({elem:'#LAY_table_permission'
	,url:'${ctx}/sysPermission/list.shtml'
	,method:'POST'
	,cols:[[
		/* ,{field:'id',title:'ID',width:200,sort:true} */
		/* ,{field:'parentid',title:'上级',width:200} */
		{field:'name',title:'名称',width:180,align:'center'}
		,{field:'type',title:'类型',width:140,align:'center'}
		,{field:'url',title:'地址',width:240,align:'center'}
		,{field:'createTime',title:'创建时间',width:170,align:'center'}
		,{width:200,title:'操作', align:'center',fixed:'right', toolbar: '#barDemo'} //这里的toolbar值是模板元素的选择器
		]]
	,id:'testReload'
	,page:true
	,even: true //开启隔行背景
	,height:490
	});
	
//监听工具条
table.on('tool(demoEvent)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
  var data = obj.data; //获得当前行数据
  var layEvent = obj.event; //获得 lay-event 对应的值
  var tr = obj.tr; //获得当前行 tr 的DOM对象
 
  if(layEvent === 'detail'){ //查看
  	window.location.href='${ctx}/sysPermission/detail.shtml?id='+data.id
    //do somehing

  } else if(layEvent === 'del'){ //删除
    layer.confirm('确定删除此数据？', function(index){
      obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
      layer.close(index);
      $.ajax("${ctx}/sysPermission/del.shtml?id="+data.id)
      //向服务端发送删除指令
    });
  } else if(layEvent === 'edit'){ //编辑
    //do something
    window.location.href='${ctx}/sysPermission/edit.shtml?id='+data.id

  }
});
	
var $ =layui.$,
	active ={
    reload:function(){
	var demoReload =$('#name');
	var type =$('#type');
	var perId = $('#perId');
	table.reload('testReload',{
		where:{ //设定异步数据接口的额外参数
			key:{
					name:demoReload.val(),
					type:type.val(),
					perId:perId.val()
				}		
			}	
	});
	}
};
$('.demoTable .layui-btn').on('click',function(){
	var type =$(this).data('type');
	active[type] ?active[type].call(this) :'';}
	);});



</script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
</script>
<%@ include file="../../common/AdminFooter.jsp" %>