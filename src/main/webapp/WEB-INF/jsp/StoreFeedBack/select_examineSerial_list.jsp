<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="examineSerial"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="examineName"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="templetName"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="storehouse"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="manager"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="examineType"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="examineTime"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="points"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="inspectors"]{
		text-align: left;
	}
</style>
<style type="text/css">
.layui-table-view{
 margin-left:0;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>粮库管理</li>
		<li class="active">考核评分管理</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
    
   <div class="layui-form" id="search" >
		<div class="layui-form-item">
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red"></span>库点名称:</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-verify="required" name="storehouse" lay-filter="aihao"
						id="storehouse">
						<option>${storehouse}</option>
					   <%--<c:forEach var="item" items="${storehouses}">--%>
						  <%--<option  value="${item.warehouseShort}">${item.warehouseShort }</option>--%>
						<%--</c:forEach>	--%>
											
					</select>					
				</div>
			</div>
			<!-- <div class="layui-inline">
				<label class="layui-form-label"><span class="red"></span>考评类型:</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-verify="required" name="examineType" lay-filter="aihao"
						id="examineType">
						
						<option  value="企业自评">企业自评</option>
						
											
					</select>					
				</div>
			</div> -->
			<div class="layui-inline">
				<label class="layui-form-label">考评时间起：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="timeStart" name="timeStart">
				</div>
			</div>
			
		</div>	
		
		
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">考评时间止：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="timeEnd" name="timeEnd">
				</div>
			</div>
			<div class="layui-inline">
		      <label class="layui-form-label">得分范围</label>
		      <div class="layui-input-inline" style="width: 100px;">
		        <input type="text" id="pointsStart" name="pointsStart" placeholder="" autocomplete="off" class="layui-input">
		      </div>
		      <div class="layui-form-mid">-</div>
		      <div class="layui-input-inline" style="width: 100px;">
		        <input type="text" id="pointsEnd" name="pointsEnd" placeholder="" autocomplete="off" class="layui-input">
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
<!-- //lacksRole没有角色显示 -->
<script>
	 var form = layui.form;
	form.render();
	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  laydate.render({ 
		  elem: '#timeStart'
		  ,format: 'yyyy-MM-dd' //可任意组合
		});
		laydate.render({ 
		  elem: '#timeEnd'
		  ,format: 'yyyy-MM-dd' //可任意组合
		});
	});
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/StoreExamine/list1.shtml?storehouse=${storehouse}',
		method:'POST',
		cols : [[
			{width : 120,align : 'center',toolbar : '#barDemo',width:120}, 
 			{align:'center',field:'examineSerial',title: '考评编号',width:200}, 
			{align:'center',field : 'examineName',title : '考评名称',width:200},
			{align:'center',field : 'templetName',title : '考评模板',width:200}, 
			{align:'center',field : 'storehouse',title : '库点名称',width:200},
			{align:'center',field : 'manager',title : '库点负责人',width:200},
			{align:'center',field : 'examineType',title : '考评类型',width:120},
			{align:'center',field : 'examineTime',title : '考评时间',width:120},
			{align:'center',field : 'points',title : '考评得分',width:100},
			{align:'center',field : 'inspectors',title : '考评人',width:200},
			
			
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
		window.parent.callExamineSerialSelect(data);
		window.parent.$.colorbox.close();
		} 
		
	});
			

	//搜索
	$('#searchBtn').click(function() {
		table.reload("myTableID", {
			method: 'post', //如果无需自定义HTTP类型，可不加该参数
			where : {
					storehouse : $(' #storehouse').val(),
					examineType : $('#examineType').val(),
					timeStart : $('#timeStart').val(),
					timeEnd : $('#timeEnd').val(),
					pointsStart : $('#pointsStart').val(),
					pointsEnd : $('#pointsEnd').val(),
				
			}
		});
	});


     /*table.reload("myTableID", {
         method: 'post', //如果无需自定义HTTP类型，可不加该参数
         where : {
             storehouse : $(' #storehouse').val(),
             examineType : $('#examineType').val(),
             timeStart : $('#timeStart').val(),
             timeEnd : $('#timeEnd').val(),
             pointsStart : $('#pointsStart').val(),
             pointsEnd : $('#pointsEnd').val(),

         }
     });*/


</script>
<%@include file="../common/AdminFooter.jsp"%>
