<%@ page language="java" contentType="text/html; charset=UTF-8"
%>


<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="feedbackSerial"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="examineSerial"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="feedbackName"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="storehouse"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="manager"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="inspectorType"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="inspectors"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="reportDate"]{
		text-align: center;
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
		<li>代储监管</li>
		<li>业务信息</li>
		<li class="active">问题反馈</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
 	
 	 <!-- //3:代储企业 -->
  	
 	 <div class="layui-form" id="search" >
 	 <%-- 	<shiro:hasAnyRoles name="公司仓储部"> --%>
		<div class="layui-form-item">
		
		     <div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>考评编号：</label>
				<div class="layui-input-inline">
						<input class="layui-input"   name="examineSerial" id="examineSerial" >
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">问题反馈名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="feedbackName" name="feedbackName">
				</div>
			</div>
		
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>库点名称：</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-filter="storehouse"  lay-verify="required" name="storehouse" lay-filter="aihao"
						id="storehouse">
						<c:if test="${falg=='' }">
						<option></option>
						
						</c:if>
						
					   <c:forEach var="item" items="${storehouses}">
						  <option  value="${item.warehouseShort}">${item.warehouseShort }</option>
						</c:forEach>						
					</select>								
				</div>
			</div>
			
			
		
		
		
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">填表时间起：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="timeStart" name="timeStart">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">填表时间止：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="timeEnd" name="timeEnd">
				</div>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn">查询</button>
			</div>
		</div>	
	
		
	</div>
 	 
	
   
    <div class="manage">
     <shiro:hasPermission name="StoreFeedBackAgent:add">  
         <p class="btn-box" style="padding-top:0px;margin-left:10px;">
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small "  onclick="window.location.href='${ctx }/StoreFeedBackAgent/add.shtml?'">新增</button>
        </p>
        </shiro:hasPermission>
        
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  			
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
			{{#  if(d.isMyself=== '1'){ }}
			 <shiro:hasPermission name="StoreFeedBackAgent:edit">  
  			<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:hasPermission>  
 			<shiro:lacksPermission name="StoreFeedBackAgent:edit">  
  			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">编辑</a>
			</shiro:lacksPermission>  
			<shiro:hasPermission name="StoreFeedBackAgent:print">  
		   <a class="layui-btn layui-btn layui-btn-mini" lay-event="print">打印</a>
		   </shiro:hasPermission> 
			<shiro:lacksPermission name="StoreFeedBackAgent:print">  
		   <a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">打印</a>
		   </shiro:lacksPermission> 
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="export">导出</a>
			<shiro:hasPermission name="StoreFeedBackAgent:delete">  
  			<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
			 </shiro:hasPermission> 
			<shiro:lacksPermission name="StoreFeedBackAgent:delete">  
  			<a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="">删除</a>
			 </shiro:lacksPermission> 
			
			{{#  } else { }}
			
  			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">编辑</a>
			<shiro:hasPermission name="StoreFeedBackAgent:print">  
		   <a class="layui-btn layui-btn layui-btn-mini" lay-event="print">打印</a>
		   </shiro:hasPermission> 
			<shiro:lacksPermission name="StoreFeedBackAgent:print">  
		   <a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">打印</a>
		   </shiro:lacksPermission> 
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="export">导出</a>
  			<a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="">删除</a>
			
			{{#  } }}
		
		</script>
    </div>
</div>


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
	var inspectorType = $('#inspectorType').val();
	var table = layui.table;
	table.render();
		var width=($('.container-box').innerWidth()-35)/7;
		var storehouse="";
	 form.on('select(storehouse)', function(data){
    storehouse= $(data.elem).find("option:selected").val();
  /*   $("#manager").val($('#'+index).val()); */
	});
	
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/StoreFeedBackAgent/list.shtml?',
		method:'POST',
		cols : [[
			{align:'center', field : 'feedbackSerial',title : '问题反馈编号',width:width,fixed: true},
				{align:'center',field:'examineSerial',title: '考评编号',width:width},
 			{align:'left',field:'feedbackName',title: '问题反馈名称',width:width},
		/* 	{align:'center', field : 'storehouse',title : '库点名称',width:width},	
			{align:'center', field : 'manager',title : '库点负责人',width:width},		 */
			{align:'center',field : 'storehouse',title : '库点名称',width:width},
			{align:'center',field : 'manager',title : '库点负责人',width:width},
			{align:'center', field : 'inspectorType',title : '类型',width:width},
			{align:'center', field : 'inspectors',title : '检查人员',width:width},
			{align:'center', field : 'reportDate',title : '填表时间',width:width},	 	
			{fixed : 'right',align : 'center',toolbar : '#barDemo',title: '操作',width:width+150}, 
			
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
			var inspectorType = $('#inspectorType').val();
			location.href = "${ctx}/StoreFeedBackAgent/view.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/StoreFeedBackAgent/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					    layer.msg("删除成功",{icon:1}, function(){
						table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
								feedbackSerial : $('#search #feedbackSerial').val(),
								feedbackName : $('#search #feedbackName').val(),
								storehouse : $('#search #storehouse').val(),
								manager : $('#search #manager').val(),
								timeEnd : $('#search #timeEnd').val(),
								timeStart : $('#search #timeStart').val(),
								inspectorType : $('#search #inspectorType').val(),
								examineSerial : $('#search #examineSerial').val()
								
							}
						});
					})
						
				});
			});
		} else if (obj.event === 'edit') {
			var inspectorType = $('#inspectorType').val();
			location.href = "${ctx}/StoreFeedBackAgent/edit.shtml?id="
					+ data.id;
		}
		else if (obj.event === 'print') {
			var inspectorType = $('#inspectorType').val();
			location.href = "${ctx}/StoreFeedBackAgent/print.shtml?id="
					+ data.id;
		}else if (obj.event === 'export') {
			var inspectorType = $('#inspectorType').val();
			location.href = "${ctx}/StoreFeedBackAgent/export.shtml?id="
					+ data.id;
		}
		
		
	});
 function checkTime() {
     var timeEnd = $('#search #timeEnd').val();
     var  timeStart = $('#search #timeStart').val();
     if (timeStart!=null&&timeStart!=''&&timeEnd!=null&&timeEnd!=''){
         var startTime = new Date(Date.parse(timeStart));
         var endTime = new Date(Date.parse(timeEnd));
         if (startTime>=endTime){
             alert("填表时间止要大于填表时间起");
             retur;
         }
     }
 }

	//搜索
	$('#searchBtn').click(function() {
        checkTime();
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				feedbackSerial : $('#search #feedbackSerial').val(),
				feedbackName : $('#search #feedbackName').val(),
				storehouse : $('#search #storehouse').val(),
				manager : $('#search #manager').val(),
				timeEnd : $('#search #timeEnd').val(),
				timeStart : $('#search #timeStart').val(),
				inspectorType : $('#search #inspectorType').val(),
				examineSerial : $('#search #examineSerial').val()
				
				
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>
