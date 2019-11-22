<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="warehouse"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="postalAddress"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="director"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="email"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="zip"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="telphone"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="fax"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="entireStaff"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="nvq"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="juniorCollege"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="mediumGrade"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="keeper"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="monitor"]{
		text-align: right;
	}#mytable + .layui-form .layui-table-body td[data-field="mechanic"]{
		 text-align: right;
	 }
	#mytable + .layui-form .layui-table-body td[data-field="controlOperator"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="electrician"]{
		text-align: right;
	}#mytable + .layui-form .layui-table-body td[data-field="safety"]{
		 text-align: right;
	 }
	#mytable + .layui-form .layui-table-body td[data-field="oldLevel"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="applyLevel"]{
		text-align: left ;
	}
	#mytable + .layui-form .layui-table-body td[data-field="enterprise"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="createDate"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="creator"]{
		text-align: left;
	}


</style>
<style type="text/css">

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
		<li>仓储管理</li>
		<li>粮库管理</li>
		<li class="active">星级粮库申报</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">
 	 <div class="layui-form" id="search" >
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">粮库名称：</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-verify="required" name="warehouseId" lay-filter="warehouseId"
							id="warehouseId">
						<option  value=""></option>
						<c:forEach var="item" items="${storageWarehouseList}">

							<option warehouse="${item.warehouseShort }" value="${item.id}">${item.warehouseShort }</option>

						</c:forEach>

					</select>

				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">通讯地址：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="postalAddress" name="postalAddress">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red"></span>原"星级"等级：</label>
				<div class="layui-input-inline">
						<input class="layui-input" autocomplete="off" id="oldLevel" name="oldLevel">
					<%-- <select class="layui-input" lay-verify="required" name="oldLevel" lay-filter="aihao"
						id="oldLevel">
						<option></option>
					
						 <c:forEach var="oldLevel" items="${oldLevels}">
						  <option value="${oldLevel.value}">${oldLevel.value }</option>
						</c:forEach>			
					</select>	 --%>				
				</div>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn">查询</button>
			</div>
		</div>
		</div>

   

    <div class="manage">
         <p class="btn-box" style="padding-top:0px;margin-left:10px;">
        	 <shiro:hasPermission name="StorageStarUnit:add">  
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="window.location.href='${ctx }/StorageStarUnit/add.shtml?'">新增</button>
              </shiro:hasPermission>
            <!--   <button type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="exportxls()">导出</button>   -->
        </p>
        
         
        
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  		
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
			
			 <shiro:hasPermission name="StorageStarUnit:edit">  
  			<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:hasPermission>  
 			<shiro:lacksPermission name="StorageStarUnit:edit">  
  			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">编辑</a>
			</shiro:lacksPermission>  
			

			<shiro:hasPermission name="StorageStarUnit:delete">  
  			<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
			 </shiro:hasPermission> 
			<shiro:lacksPermission name="StorageStarUnit:delete">  
  			<a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="">删除</a>
			 </shiro:lacksPermission> 
			
			<a class="layui-btn  layui-btn layui-btn-mini" lay-event="export">导出</a>
		
		</script>
    </div>



<script>
	 var form = layui.form;
	form.render();
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/StorageStarUnit/list.shtml?type=0',
		method:'POST',
		cols : [[
 			{field:'warehouse',title: '粮库名称',width:200,fixed: true,align:'center'},
			{field : 'postalAddress',title : '通讯地址',width:200,align:'center'},
			{field : 'director',title : '粮库主任',width:120,align:'center'},
			{field : 'email',title : '电子信箱',width:120,align:'center'},
            {field : 'zip',title : '邮编',width:120,align:'center'},
            {field : 'telphone',title : '电话',width:120,align:'center'},
            {field : 'fax',title : '传真',width:120,align:'center'},
			{field : 'entireStaff',title : '职工总人数(人)',width:150,align:'center'},
			{field : 'nvq',title : '有职业资格证书人员(人)',width:220,align:'center'},
			{field : 'juniorCollege',title : '大专（含）以上学历(人)',width:180,align:'center'},
			{field : 'mediumGrade',title : '中级（含）以上职称(人)',width:180,align:'center'},
			{field : 'keeper',title : '粮油保管员(人)',width:150,align:'center'},
			{field : 'monitor',title : '粮油质量检验员(人)',width:180,align:'center'},
			{field : 'mechanic',title : '粮仓机械员(人)',width:180,align:'center'},
			{field : 'controlOperator',title : '中央控制室操作员(人)',width:180,align:'center'},
			{field : 'electrician',title : '电工(人)',width:120,align:'center'},
			{field : 'safety',title : '安全生产管理员(人)',width:180,align:'center'},
			{field : 'oldLevel',title : '原"星级"等级',width:120,align:'center'},
			{field : 'applyLevel',title : '现申请评定"星级"等级',width:180,align:'center'},
			{field : 'enterprise',title : '申请企业名称',width:120,align:'center'},
			{field : 'createDate',title : '创建时间',width:120,align:'center'},
			{field : 'creator',title : '创建人',width:120,align:'center'},
			
			{fixed : 'right',align : 'center',toolbar : '#barDemo',title: '操作',width:270}, 
			
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
		
			location.href = "${ctx}/StorageStarUnit/view.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/StorageStarUnit/remove.shtml", {
					id : data.id
				}, function(result) {
				  	layer.msg("删除成功",{icon:1}, function(){
						  layer.closeAll(); //疯狂模式，关闭所有层
						table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
                                warehouseId : $('#search #warehouseId').val(),
								postalAddress : $('#search #postalAddress').val(),
								oldLevel : $('#search #oldLevel').val(),
								type : "0",
							
								
							}
						});
						})
					
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/StorageStarUnit/edit.shtml?id="
					+ data.id;
		} else if (obj.event === 'export') {
			window.location.href="${ctx }/StorageStarUnit/exportxls.shtml?id="+data.id;
		/* 	location.href = "${ctx}/StorageStarUnit/edit.shtml?id="
					+ data.id; */
		}
		
	});
			

	//搜索
	$('#searchBtn').click(function() {
		table.reload("myTableID", {
			method: 'post', //如果无需自定义HTTP类型，可不加该参数
			where : {
                warehouseId : $('#search #warehouseId').val(),
					postalAddress : $('#search #postalAddress').val(),
					oldLevel : $('#search #oldLevel').val(),
					type : "0",
				
			}
		});
	});
	
	function exportxls(){
	
		var warehouseId =$('#warehouseId').val();
		var postalAddress =$('#postalAddress').val();
		var oldLevel =$(' #oldLevel').val();

		
		window.location.href="${ctx }/StorageStarUnit/exportxls.shtml?warehouseId="+warehouseId+"&postalAddress="+postalAddress+"&oldLevel="+oldLevel+"&type="+'0';
		
	}
	//    省市级联动
    $(function () {
        $('#distpicker,#distpicker1').distpicker({
             province: '浙江省',
            city: '苏州市',
        });
    });

</script>
<%@include file="../common/AdminFooter.jsp"%>
