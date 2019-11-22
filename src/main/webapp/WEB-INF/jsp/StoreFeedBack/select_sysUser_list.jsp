
<%@ page language="java" contentType="text/html; charset=UTF-8"
     %>


<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="account"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="name"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="department"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="company"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="cellPhone"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="createTime"]{
		text-align: center;
	}
</style>
<style type="text/css">
.layui-table-view{
 margin-left:0;
}
</style>



<div class="container-box clearfix" style="padding: 10px">
   
   <div class="layui-form" id="search" >
	   <input type="hidden" class="layui-input" autocomplete="off" id="originCode" name="originCode" value="${originCode}">

		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="name1" name="name1">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label">公司名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="company" name="company">
				</div>
			</div>

		    <div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn">查询</button>
			</div>	
		</div>	
        
	</div>
   
    <div class="manage">
       
        
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="select">选择</a>
		</script>
    </div>
</div>


<script>
    layui.use(['table', 'layer','jquery','laydate','form','element'], function () {

		var table = layui.table;
		//table.render();
		//执行渲染
		table.render({
			elem : '#mytable',
			url:'${ctx}/sysUser/list.shtml?originCode='+$('#originCode').val(),
			method:'POST',
			cols : [[
				{checkbox: true, LAY_CHECKED: false,filter:'test'}
				,{field:'account',title:'账号',width:150,align:'center'}
				,{field:'name',title:'名称',width:150,align:'center'}
				,{field:'department',title:'部门',width:150,align:'center'}
				,{field:'company',title:'公司名称',width:170,align:'center'}
				,{field:'cellPhone',title:'联系电话',width:180,align:'center'}
				,{field:'createTime',title:'创建时间',width:200,align:'center'}
			]],//设置表头
			request : {
				pageName : 'page',
				limitName : 'pageSize'
			},
			page:true,//开启分页
			limit:10,
			id:'myTableID',
			done:function(res,curr,count){
			},
		});

		//监听工具条

		//复选框选中监听,将选中的id 设置到缓存数组,或者删除缓存数组
		table.on('checkbox(test)', function (obj) {
            var checkStatus = table.checkStatus('myTableID');

			if('${pge}' == 'durables_add'||'${operator}' == 'operator'||'${guardian}' == 'guardian'||'${custodian}' == 'custodian'||'${inspectorManager}' == 'inspectorManager'||'${inspectors}' == 'inspectors'){ //durables_add
				//提示只能单选
                if (checkStatus.data.length > 1) {
                    layer.msg('只能进行单选');
                    return;
                }
                obj.data = checkStatus.data[0];
				if('${pge}' == 'durables_add'){
					window.parent.callUserSelect_da(obj)
				}
				if('${operator}' == 'operator'){
					window.parent.callUserSelect_operator(obj)
				}
				if('${guardian}' == 'guardian'){
					window.parent.callUserSelect_guardian(obj)
				}
				if('${custodian}' == 'custodian'){
					window.parent.callUserSelect_custodian(obj)
				}
				if('${inspectorManager}' == 'inspectorManager'){
					window.parent.callUserSelect_inspectorManager(obj)
				}
				if('${inspectors}' == 'inspectors'){
					window.parent.callUserSelect_inspectors(obj)
				}

			}else{
				window.parent.callUserSelect(obj);
			}

		});

		//搜索
		$('#searchBtn').click(function() {
			table.reload("myTableID", {
				method: 'post' //如果无需自定义HTTP类型，可不加该参数
				,where : {
					name1 : $('#name1').val(),
					company : $('#company').val(),
					originCode: $('#originCode').val()

				}
			});
		});
	});
</script>

<%@include file="../common/AdminFooter.jsp"%>


<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="GBK" %>


<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">
.layui-table-view{
 margin-left:0;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li>用户列表</li>
		<li class="active">详情</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
	
		
		

<div class="layui-form" id="search" >
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="name" name="name">
				</div>
			</div>
		   <div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn">查询</button>
			</div>	
		</div>	
        
	</div>
   
    <div class="manage">
       
        
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="select">选择</a>
		
		</script>
    </div>
</div>
</div>
<script>
	

	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url:'${ctx}/sysUser/list.shtml',
	
		cols : [[
			{width : 120,align : 'center',toolbar : '#barDemo',width:120}, 
			{field:'account',title:'账号',width:150,align:'center'}
		,{field:'name',title:'名称',width:150,align:'center'}
		,{field:'department',title:'部门',width:150,align:'center'}
		,{field:'company',title:'公司名称',width:170,align:'center'}
		,{field:'cellPhone',title:'联系电话',width:180,align:'center'}
		,{field:'createTime',title:'创建时间',width:200,align:'center'}
		,{title:'操作', align:'center',width:250,fixed:'right', toolbar: '#barDemo',align:'center'} //这里的toolbar值是模板元素的选择器
			
			
		]],//设置表头
		request : {
			pageName : 'page', 
			limitName : 'pageSize'
		},
		page:true,//开启分页
		limit:10,
		id:'myTableID',
		done:function(res,curr,count){
		},
	});
	
	//监听工具条

	table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'select') {
		window.parent.callTemplateSelect(data);
		window.parent.$.colorbox.close();
		} 
		
	});
			


</script>

<%@ include file="../../common/AdminFooter.jsp" %> --%>