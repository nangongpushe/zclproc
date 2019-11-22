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
		<li class="active">菜单管理</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			<legend>菜单管理</legend>
	</fieldset>
	
	<div class="demoTable">
			菜单名称：
			<div class="layui-inline">
				<input class="layui-input" name="menuName" id="Reload" autocomplete="off">
			</div>
			<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">搜索</button>
			<button class="layui-btn layui-btn-primary layui-btn-small" onclick="javascript:window.location.href='${ctx}/sysMenu/add.shtml'">添加菜单</button>
	</div>
	
	<div class="row">
		<div class="col-md-2">
			<ul id="tree" class="ztree"></ul> 
		</div>
  		<div class="col-md-9">	
  			<table class="layui-hide" id="LAY_table_user" lay-filter="demoEvent"></table>
		</div>
	</div>
	
	</div>

<script>


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
			$('[name="id"]').val(treeNode.id);
			$('[name="parentId"]').val(treeNode.parentId);		
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
             type: "GET",
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


layui.use('table',function(){
var table =layui.table;

//render初始化参数
table.render({elem:'#LAY_table_user'
	,url:'${ctx}/sysMenu/list.shtml'
	,method:'POST'
	,cols:[[{checkbox:true,width:67}
		/* ,{field:'logId',title:'ID',width:200,sort:true} */
		,{field:'menuName',title:'菜单名称',width:200,align:'center'}
		,{field:'url',title:'请求地址',width:200,align:'center'}
		,{field:'createTime',title:'创建时间',width:200,templet:"#dateTemplate",sort: true,align:'center'}
		,{width:200,title:'操作', align:'center', toolbar: '#barDemo'} //这里的toolbar值是模板元素的选择器
		]]
	,id:'testReload'
	,page:true
	,even: true //开启隔行背景
	,height:345
	});
	
//监听工具条
table.on('tool(demoEvent)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
  var data = obj.data; //获得当前行数据
  var layEvent = obj.event; //获得 lay-event 对应的值
  var tr = obj.tr; //获得当前行 tr 的DOM对象
 
  if(layEvent === 'detail'){ //查看
  	alert("查看！");
    //do somehing
  } else if(layEvent === 'del'){ //删除
    layer.confirm('确定删除此数据？', function(index){
      obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
      layer.close(index);
      $.ajax("${ctx}/sysMenu/del.shtml?id="+data.menuId)
      //向服务端发送删除指令
    });
  } else if(layEvent === 'edit'){ //编辑
    //do something
    //同步更新缓存对应的值
	window.location.href='${ctx}/sysMenu/edit.shtml?menuId='+data.menuId
  }
});
	
	var $ =layui.$,
	active ={reload:function(){
	var demoReload =$('#Reload');
	table.reload('testReload',{
		where:{ //设定异步数据接口的额外参数
			key:{
					menuName:demoReload.val()
				}		
			}	
	});
	}
	};
$('.demoTable .layui-btn').on('click',function(){
	var type =$(this).data('type');
	active[type] ?active[type].call(this) :'';});});



</script>

<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
</script>
<%@ include file="../../common/AdminFooter.jsp" %>