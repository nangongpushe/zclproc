<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">

	#mytable + .layui-form .layui-table-body td[data-field="commodity"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="storehouse"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="model"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="unit"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="unitPrice"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="amount"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="incomingQuantity"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="apply"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="totalApply"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="surplus"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="custodian"]{
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
		<li class="active">易耗品入库</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
    <shiro:hasPermission name="Consumables:search">  
     <div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">品名:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="commodity" id="commodity" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">所入库房:</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" name="storehouse" lay-filter="aihao"
						id="storehouse">
						<c:if test="${falg=='' }">
							<option></option>

						</c:if>

						<c:forEach var="item" items="${storehouses}">
							<option  value="${item.warehouseShort}">${item.warehouseShort }</option>
						</c:forEach>

					</select>
					<!-- </div> -->
				</div>
			</div>
			
			<div class="layui-inline" style="width:20px;">
				<button class="layui-btn layui-btn-primary layui-btn-small " id="searchBtn" data-type="reload" >查询</button>
			</div>
		</div>
	</div>
    </shiro:hasPermission>
    <div class="manage">
      
		 <shiro:hasPermission name="Consumables:add">  
        <p class="btn-box" style="padding-top:0px;margin-left:10px;">
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="window.location.href='${ctx }/Consumables/add.shtml?'">新增</button>
        </p>
     </shiro:hasPermission>   
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  			
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  		  <shiro:hasPermission name="Consumables:edit">  
  			<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:hasPermission>  
 			<shiro:lacksPermission name="Consumables:edit">  
  			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:lacksPermission>  
		

			<shiro:hasPermission name="Consumables:delete">  
  			<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
			 </shiro:hasPermission> 
			<shiro:lacksPermission name="Consumables:delete">  
  			<a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
			 </shiro:lacksPermission> 
			<shiro:hasPermission name="Consumables:receive">  
  			<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="receive">领取</a>
			 </shiro:hasPermission> 
			<shiro:lacksPermission name="Consumables:receive">  
  			<a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="receive">领取</a>
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
		url : '${ctx}/Consumables/list.shtml',

		method:'POST',
		cols : [[
 			{align:'center',field:'commodity',title: '品名',width:180,fixed: true}, 
 			{align:'center',field:'storehouse',title: '所入库房',width:180}, 
			{align:'center',field : 'model',title : '规格型号',width:120},
			{align:'center',field : 'unit',title : '单位',width:100}, 
			{align:'center',field : 'unitPrice',title : '单价(元)',width:120},
			{align:'center',field : 'amount',title : '金额(元)',width:120},
			{align:'center',field : 'incomingQuantity',title : '入库量',width:120},
			{align:'center',field : 'apply',title : '本次领用量',width:120},
			{align:'center',field : 'totalApply',title : '累计领用量',width:120},
			{align:'center',field : 'surplus',title : '剩余量',width:120},
			{align:'center',field : 'custodian',title : '保管员',width:120},
			{align:'center',field : 'storageDate',title : '入库时间',width:120},
			
			{fixed : 'right',align : 'center',toolbar : '#barDemo',title: '操作',width:260}, 
			
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
		
			location.href = "${ctx}/Consumables/view.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/Consumables/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					layer.msg("删除成功",{icon:1}, function(){
							table.reload("myTableID", {
							where : {
								commodity : $('#search #commodity').val(),
								storehouse : $('#search #storehouse').val(),
								
							}
						});
					})
					
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/Consumables/edit.shtml?id="
					+ data.id;
		} else if (obj.event === 'receive') {
		
			layer.open({
  			content: '<div style="padding: 5px 80px;">品名：'+data.commodity+'</div><div style="padding: 5px 80px;">剩余量：'+data.surplus+'</div><div style="padding: 5px 80px;">本次领取量<input type="text" id="apply" placeholder="" value=""/></div>'			  	
  			,btn: ['保存', '取消']
  			,yes: function(index, layero){
			      var apply = parseInt($("#apply").val()) ;
			      if(isNaN(apply)){
			   		 alert("请输入数字");
			   		 return;
			  		 }
			  		if(apply<=0){
			   		 alert("请输入大于0的数字");
			   		 return;
			  		 }
			  		var surplus=parseInt(data.surplus);
			  		 if(apply>surplus){
			  		 alert("领用量不可以大于剩余量");
			  		 return;
			  		 }
			      //累计领用
					var totalApply=parseInt(data.totalApply)+apply;
					surplus=parseInt(data.incomingQuantity)-totalApply;
					
					
					//更新数量
					
					$.post("${ctx}/Consumables/updateApply.shtml", {
					id : data.id,apply:apply,surplus:surplus,totalApply:totalApply
					}, function(result) {
						layer.closeAll(); //疯狂模式，关闭所有层
						table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
								commodity : $('#search #commodity').val(),
								model : $('#search #model').val(),
								
							}
						});
					});			
			    	
				
			  }
			  ,btn2: function(index, layero){
			    //按钮【按钮二】的回调
			    layer.closeAll(); //疯狂模式，关闭所有层
			    //return false 开启该代码可禁止点击该按钮关闭
			  }
			  
			  ,cancel: function(){ 
			    //右上角关闭回调
			    
			    //return false 开启该代码可禁止点击该按钮关闭
			  }
			});
			}
		
	});
			

	//搜索
	$('#searchBtn').click(function() {
		table.reload("myTableID", {
			method: 'post', //如果无需自定义HTTP类型，可不加该参数
			where : {
				commodity : $('#search #commodity').val(),
				storehouse : $('#search #storehouse').val(),
				
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>
