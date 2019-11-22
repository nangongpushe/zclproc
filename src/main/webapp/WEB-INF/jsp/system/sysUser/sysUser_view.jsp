<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="user_role.jsp"%>
<style>
	#LAY_table_user + .layui-form .layui-table-body td[data-field="account"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="name"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="department"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="company"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="cellPhone"]{
		text-align: right;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="createTime"]{
		text-align: center;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li class="active">用户管理</li>
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
				<shiro:hasPermission name="sysUser:add">
					<button class="layui-btn layui-btn-primary layui-btn-small"  onclick="javascript:window.location.href='${ctx}/sysUser/add.shtml'">添加用户</button>
				</shiro:hasPermission>
			</div>
		</div>
		
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
		<table class="layui-hide" id="LAY_table_user" lay-filter="demoEvent"></table>


	</div>


<script>


 	$('#myModal').on('show.bs.modal', function (event) {  
        var label = $(event.relatedTarget) // 触发事件的标签 
        var recipient = label.data('whatever') // 解析出whatever内容  
        var modal = $(this)  //获得模态框本身
        modal.find('.modal-title').text('新增报表'/*  + recipient */)  //			
        /* modal.find('.modal-body input').val(recipient)   */
    })  

layui.use('table',function(){
var table =layui.table;
//render初始化参数
table.render({elem:'#LAY_table_user'
	,url:'${ctx}/sysUser/list.shtml'
	,method:'POST'
	,cols:[[
		/* ,{field:'id',title:'ID',width:200,sort:true} */
		{field:'account',title:'账号',width:150,align:'center'}
		,{field:'name',title:'名称',width:150,align:'center'}
		,{field:'department',title:'部门',width:150,align:'center'}
		,{field:'company',title:'公司名称',width:170,align:'center'}
		,{field:'cellPhone',title:'联系电话',width:180,align:'center'}
		,{field:'createTime',title:'创建时间',width:200,align:'center'}
		,{title:'操作', align:'center',width:250,fixed:'right', toolbar: '#barDemo',align:'center'} //这里的toolbar值是模板元素的选择器
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
  	window.location.href='${ctx}/sysUser/detail.shtml?id='+data.id
    //do somehing
  } else if(layEvent === 'del'){ //删除
    layer.confirm('确定删除此数据？', function(index){
      obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
      layer.close(index);
      $.ajax("${ctx}/sysUser/del.shtml?id="+data.id)
      //向服务端发送删除指令
    });
  }else if(layEvent === 'edit'){ //删除
  	window.location.href='${ctx}/sysUser/edit.shtml?id='+data.id
      //向服务端发送删除指令
    
  } else if(layEvent === 'addrole'){ 
    //do something
   
    var urls = "${ctx}/sysRole/getRole.shtml";
         $.ajax({
          type: "POST",
          data:{userId:data.id},
          url: urls,
          dataType: "json",
          success: function(res){
          	var Rolelist = res.data.Rolelist;
          	var myRole = res.data.myRole;
          			   $('#resText').empty();   //清空resText里面的所有内容
                         var html = ''; 
                         $.each(Rolelist, function(commentIndex, comment){
                         	if($.inArray(comment.name, myRole)!=-1){
                         		html += '<div class="checkbox"><label><input type="checkbox" style="height:16px" name="roleId" checked="checked" value="' + comment.id
                                         + '">' + comment.name
                                         + '  </label></div>';
                         	}else{
                         		html += '<div class="checkbox"><label><input type="checkbox" style="height:16px" name="roleId" value="' + comment.id
                                         + '">' + comment.name
                                         + '  </label></div>';
                         	}
                               
                         });
                         $('#resText').html(html);
                  }
        });      
    
   	$('#myMenuTree').on('show.bs.modal', function (event) {  
       var label = $(event.relatedTarget) // 触发事件的标签 
       var recipient = label.data('whatever') // 解析出whatever内容  
       var modal = $(this)  //获得模态框本身
       modal.find('.modal-title').text('分配权限给' + data.name)  //			
       modal.find('.modal-body input').val(data.id)   
   		})
   		
   		
    $("#myMenuTree").modal("show");
  }
});
	
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
	active[type] ?active[type].call(this) :'';});

});



</script>

<script type="text/html" id="barDemo">
  <shiro:hasPermission name="sysUser:detail"><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a></shiro:hasPermission>
  {{#  if(d.isEdit==='Y'){ }}
  <shiro:hasPermission name="sysUser:edit"><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a></shiro:hasPermission>
  {{#  } else { }}

  {{#  } }}
  <shiro:hasPermission name="sysUser:addrole"><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="addrole">分配角色</a></shiro:hasPermission>
  <shiro:hasPermission name="sysUser:del"><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a></shiro:hasPermission>
</script>
<%@ include file="../../common/AdminFooter.jsp" %>