<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
	#LAY_table_user + .layui-form .layui-table-body td[data-field="label"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="value"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="type"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="sort"]{
		text-align: right;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="createDate"]{
		text-align: center;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li class="active">数据字典</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">

		
		<div class="demoTable">
			名称：
			<div class="layui-inline">
				<input class="layui-input"
					   name="label" id="mykey" autocomplete="off">
			</div>
			类型：
			<div class="layui-inline">
				<input class="layui-input" name="type" id="myvalue" autocomplete="off">
			</div>
			<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
			<div class="layui-inline" style="float:right">
				<button class="layui-btn layui-btn-primary layui-btn-small" onclick="javascript:window.location.href='${ctx}/sysDict/add.shtml'"> 添加数字字典</button>
			</div>
		</div>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
		<table class="layui-hide" id="LAY_table_user" lay-filter="demoEvent"></table>
	
	</div>

<script>

layui.use('table',function(){
var table =layui.table;
//render初始化参数
table.render({elem:'#LAY_table_user'
	,url:'${ctx}/sysDict/list.shtml'
	,method:'POST'
	,cols:[[
		/* ,{field:'id',title:'ID',width:200,sort:true} */
		/* ,{field:'parentid',title:'上级',width:200} */
		{field:'label',title:'名称',width:200,align:'center'}
		,{field:'value',title:'数值',width:200,align:'center'}
		,{field:'type',title:'类型',width:200,align:'center'}
		,{field:'sort',title:'排序',width:200,align:'center'}
		,{field:'createDate',title:'创建时间',width:200,align:'center'}
		,{width:280,title:'操作', align:'center',fixed:'right', toolbar: '#barDemo'} //这里的toolbar值是模板元素的选择器
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
  	 window.location.href='${ctx}/sysDict/detail.shtml?id='+data.id
    //do somehing
  } else if(layEvent === 'del'){ //删除
    layer.confirm('确定删除此数据？', function(index){
      obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
      layer.close(index);
      $.ajax("${ctx}/sysDict/del.shtml?id="+data.id)
      //向服务端发送删除指令
    });
  } else if(layEvent === 'edit'){ //编辑
    //do something
    window.location.href='${ctx}/sysDict/edit.shtml?id='+data.id
  }
});
	
	active ={
	reload:function(){
	var mykey =$('#mykey');
	var myvalue =$('#myvalue');
	table.reload('testReload',{
		where:{ //设定异步数据接口的额外参数
					label:mykey.val(),
					type:myvalue.val()
			}	
	});
	}
	};
$('.demoTable .layui-btn').on('click',function(){
	var type =$(this).data('type');
	active[type] ?active[type].call(this) :'';
	});
});



</script>

<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
</script>
<%@ include file="../../common/AdminFooter.jsp" %>