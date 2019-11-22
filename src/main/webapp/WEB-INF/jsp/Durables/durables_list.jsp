<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">

	#mytable + .layui-form .layui-table-body td[data-field="encode"]{
		 text-align: left;
	 }
	#mytable + .layui-form .layui-table-body td[data-field="commodity"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="type"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="model"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="unit"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="amount"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="serialNumber"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="custodian"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="guardian"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="status"]{
		text-align: left;
	}

.layui-inline{
	width: 45% ;
}
.layui-form-item .layui-form-label{
    width: 30% ;
    max-width:120px;
}

.layui-form-item .layui-input-inline{
  width: 65% ;
}
.layui-form-item {
    margin-bottom: 1px;
    }

</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>物资管理</li>
		<li>库存管理</li>
		<li class="active">设备入库</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">物资编码:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="encode" id="encode" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">品名:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="commodity" id="commodity" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">类型:</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" name="type" lay-filter="aihao"
						id="type">
						<option></option>
						<option value="物资">物资</option>
						<option value="药剂类">药剂类</option>
					</select>
					<!-- </div> -->
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">所入库点:</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" name="warehouseId" lay-filter="warehouseId"
							id="warehouseId" lay-search>
						<option></option>
						<c:forEach var="item" items="${storehouses}">
							<c:if test="${durables.warehouseId != item.id}">
								<option  value="${item.id}">${item.warehouseShort }</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>

			
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small " id="searchBtn" data-type="reload" >查询</button>
			</div>
		</div>
	</div>

   
    <div class="manage">
      
		<shiro:hasPermission name="Durables:add">  
     <p class="btn-box" style="padding-top:0px;margin-left:10px;">
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="window.location.href='${ctx }/Durables/add.shtml?'">新增</button>
        </p>
        </shiro:hasPermission>
    
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  		  <shiro:hasPermission name="Durables:edit">  
  			<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:hasPermission>  
 			<shiro:lacksPermission name="Durables:edit">  
  			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:lacksPermission>  
		

			<shiro:hasPermission name="Durables:delete">  
  			<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
			 </shiro:hasPermission> 
		
			<shiro:lacksPermission name="Durables:delete">  
  			<a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
			 </shiro:lacksPermission> 
		
		</script>
    </div>
</div>

<script>
	 var form = layui.form;
	form.render();
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/Durables/list.shtml',
		method:'POST',
		cols : [[
			{align:'center',field:'encode',title: '物资编码',width:200,fixed: true},
            {align:'center',field:'storehouse',title: '所入库点',width:200},
            {align:'center',field:'commodity',title: '品名',width:200},
 			{align:'center',field:'type',title: '类型',width:200}, 
 			
			{align:'center',field : 'model',title : '规格型号',width:200},
			{align:'center',field : 'unit',title : '单位',width:120}, 
			{align:'center',field : 'amount',title : '金额(元)',width:120},
			{align:'center',field : 'serialNumber',title : '出厂编号',width:200},
			{align:'center',field : 'custodian',title : '保管员',width:150},
			{align:'center',field : 'guardian',title : '维修员',width:150},
			{align:'center',field : 'storageDate',title : '入库时间',width:120},
			{align:'center',field : 'status',title : '状态',width:120},
			{fixed : 'right',align : 'center',toolbar : '#barDemo',title: '操作',width:250}, 
			
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
		if (obj.event === 'detail') {
		
			location.href = "${ctx}/Durables/view.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/Durables/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					layer.msg("删除成功",{icon:1}, function(){
						table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
								commodity : $('#commodity').val(),
								type : $('#type').val(),
								encode : $('#encode').val(),
								
								
							}
						});
					})
						
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/Durables/edit.shtml?id="
					+ data.id;
		}
		
	});
			

	//搜索
	$('#searchBtn').click(function() {
		table.reload("myTableID", {
			method: 'post', //如果无需自定义HTTP类型，可不加该参数
			where : {
				commodity : $(' #commodity').val(),
				type : $('#type').val(),
				encode : $('#encode').val(),
				warehouseId : $('#warehouseId').val()
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>
