<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="role_permission.jsp"%>
<style>
	#LAY_table_user + .layui-form .layui-table-body td[data-field="name"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="type"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="createTime"]{
		text-align: center;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li class="active">角色管理</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
		
		<div class="demoTable">
			名称：
			<div class="layui-inline">
				<input class="layui-input" name="name" id="demoReload" autocomplete="off">
			</div>
			<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
			<div class="layui-inline" style="float:right">
				<button class="layui-btn layui-btn-primary layui-btn-small" onclick="javascript:window.location.href='${ctx}/sysRole/edit.shtml'">添加角色</button>
			</div>
		</div>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
	<table class="layui-hide" id="LAY_table_user" lay-filter="demoEvent"></table>
	
	<div  class="layui-btn" data-toggle="modal" data-target="#myMenuTree"  
                    data-whatever="" id="myMenuTree" style="display:none">分配权限
            </div>
	</div>

<script>

layui.use('table',function(){
var table =layui.table;
	laydate =layui.laydate;
	laydate.render({elem:'#createDate'});
//render初始化参数
table.render({elem:'#LAY_table_user'
	,url:'${ctx}/sysRole/list.shtml'
	,method:'POST'
	,cols:[[
		/* {field:'id',title:'ID',width:200,sort:true} */
		{field:'name',title:'名称',width:300,align:'center'}
		,{field:'type',title:'描述',width:300,align:'center'}
		,{field:'createTime',title:'创建时间',width:250,align:'center'}
		,{width:400,title:'操作', align:'center',	fixed:'right', toolbar: '#barDemo'} //这里的toolbar值是模板元素的选择器
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
    window.location.href='${ctx}/sysRole/detail.shtml?id='+data.id
  } else if(layEvent === 'del'){ //删除
    layer.confirm('确定删除此数据？', function(index){
      obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
      layer.close(index);
      $.ajax("${ctx}/sysRole/del.shtml?id="+data.id,function(res){
      	alert(res.message);
      	location.reload();
      })
      //向服务端发送删除指令
    });
  } else if(layEvent === 'edit'){ //编辑5j
     window.location.href='${ctx}/sysRole/edit.shtml?id='+data.id
  }else if(layEvent === 'permiss'){ 
    //do something
    //同步更新缓存对应的值
    
   	$('#myMenuTree').on('show.bs.modal', function (event) {  
        var label = $(event.relatedTarget) // 触发事件的标签 
        var recipient = label.data('whatever') // 解析出whatever内容  
        var modal = $(this)  //获得模态框本身
        modal.find('.modal-title').text('分配权限给' + data.name)  //			
        modal.find('.modal-body input').val(data.id)  
    })  
    
   	  var urls = "${ctx}/sysPermission/getTree.shtml";
         $.ajax({
          type: "POST",
          data:{roleId:data.id},
          url: urls,
          dataType: "json",
          success: function(data){
          			console.log(data)
          			var roleSysPermissions = data.roleSysPermissions;
          			var roles = [];
          			 $.each(roleSysPermissions,function(i,roleItem){
          			 	roles.push(roleItem.id)
          			 })
          			 
          			var sysPermissions = data.sysPermissions;
         			 var zNodes=[];
         			   $.each(sysPermissions,function(i,item){					
         			   		if(contains(roles,item.id)){
         			   			item.checked = true;   //给加上属性
         			   		}
         			   		zNodes.push(item);
         			   });           		
					zTreeObj = $.fn.zTree.init($("#tree"), setting, zNodes);
   					zTreeObj.expandAll(false);	 	
                  }
        });      
    
   	document.getElementById("myMenuTree").click();
  }
});

//判断相等
function contains(arr, obj) {  
    var i = arr.length;  
    while (i--) {  
        if (arr[i] == obj) {  
            return true;  
        }  
    }  
    return false;  
}  
	
	var $ =layui.$,
	active ={reload:function(){
	var demoReload =$('#demoReload');
	table.reload('testReload',{
		where:{ //设定异步数据接口的额外参数
			key:{
					name:demoReload.val()
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
  <shiro:hasPermission name="sysRole:detail"><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a></shiro:hasPermission>
  <shiro:hasPermission name="sysRole:edit"><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a></shiro:hasPermission>
  <shiro:hasPermission name="sysRole:permiss"><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="permiss" data-toggle="modal" data-target="#myMenuTree">分配权限</a></shiro:hasPermission>
  <shiro:hasPermission name="sysRole:del"><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a></shiro:hasPermission>
</script>
<%@ include file="../../common/AdminFooter.jsp" %>