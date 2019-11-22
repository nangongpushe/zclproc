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


.layui-inline{
	width: 45% ;
}
.layui-form-item .layui-form-label{
    width: 30% ;
    max-width:130px;
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
		<li class="active">考核评分</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
   <shiro:hasPermission name="StoreExamineAgent:search">  
   <div class="layui-form" id="search" >
		<div class="layui-form-item">
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>库点名称：</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-filter="storehouse"  lay-verify="required" name="storehouse" 
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
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>考评类型：</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-verify="required" name="examineType" lay-filter="aihao"
						id="examineType">
						<option  value=""></option>
						<option  value="企业自评">企业自评</option>
						<option  value="检查考评">检查考评</option>
						
											
					</select>					
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">考评时间起：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="timeStart" name="timeStart">
				</div>
			</div>
			
		
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">考评时间止：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="timeEnd" name="timeEnd">
				</div>
			</div>
			<div class="layui-inline">
		      <label class="layui-form-label" style="text-align:right">得分范围：</label>
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
	</shiro:hasPermission>
	
	
   
    <div class="manage">
   	   <shiro:hasPermission name="StoreExamineAgent:add">  
           <p class="btn-box" style="padding-top:0px;margin-left:10px">
            <a type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="window.location.href='${ctx }/StoreExamineAgent/add.shtml?'">新增</a>
              
        </p>
    	</shiro:hasPermission>  
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  		
		
  		 	<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
			{{#  if(d.isMyself=== '1'){ }}
			 <shiro:hasPermission name="StoreExamineAgent:edit">  
  			<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:hasPermission>  
 			<shiro:lacksPermission name="StoreExamineAgent:edit">  
  			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">编辑</a>
			</shiro:lacksPermission>  
			<shiro:hasPermission name="StoreExamineAgent:print">  
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="export">导出</a>
		   <a class="layui-btn layui-btn layui-btn-mini" lay-event="print">打印</a>
		   </shiro:hasPermission> 
			<shiro:lacksPermission name="StoreExamineAgent:print">  
			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">导出</a>
		   <a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">打印</a>
		   </shiro:lacksPermission> 

			<shiro:hasPermission name="StoreExamineAgent:delete">  
  			<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
			 </shiro:hasPermission> 
			<shiro:lacksPermission name="StoreExamineAgent:delete">  
			
  			<a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="">删除</a>
			 </shiro:lacksPermission> 
			{{#  } else { }}
			
  			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">编辑</a>
			<shiro:hasPermission name="StoreExamineAgent:print">  
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="export">导出</a>
		   <a class="layui-btn layui-btn layui-btn-mini" lay-event="print">打印</a>
		   </shiro:hasPermission> 
			<shiro:lacksPermission name="StoreExamineAgent:print">  
			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">导出</a>
		   <a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">打印</a>
		   </shiro:lacksPermission> 
			
  			<a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="">删除</a>
			
			{{#  } }}
			

  		
  			

  	
		
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
		url : '${ctx}/StoreExamineAgent/list.shtml?',
		method:'POST',
		cols : [[
 			{align:'center',field:'examineSerial',title: '考评编号',width:200,fixed: true},
			{align:'center',field : 'examineName',title : '考评名称',width:200},
			{align:'center',field : 'templetName',title : '考评模板',width:200},
			{align:'center',field : 'storehouse',title : '库点名称',width:300},
			{align:'center',field : 'manager',title : '库点负责人',width:200},
			{align:'center',field : 'examineType',title : '考评类型',width:120},
			{align:'center',field : 'examineTime',title : '考评时间',width:120},
			{align:'center',field : 'points',title : '考评得分',width:100},
			{align:'center',field : 'inspectors',title : '考评人',width:200},
			{fixed : 'right',align : 'center',toolbar : '#barDemo',title: '操作',width:300}, 
			
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
		
			location.href = "${ctx}/StoreExamineAgent/view.shtml?id="
					+ data.examineSerial;
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/StoreExamineAgent/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					layer.msg("删除成功",{icon:1}, function(){
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
					})
						
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/StoreExamineAgent/edit.shtml?id="
					+ data.examineSerial;
		}else if (obj.event === 'print') {
			location.href = "${ctx}/StoreExamineAgent/print.shtml?id="
					+ data.examineSerial;
		}else if (obj.event === 'export') {
			location.href = "${ctx}/StoreExamine/export.shtml?id="
					+ data.examineSerial+"&type=0";
		}
		
	});
     function checkTime() {
         var timeEnd = $('#search #timeEnd').val();
         var  timeStart = $('#search #timeStart').val();
         if (timeStart!=null&&timeStart!=''&&timeEnd!=null&&timeEnd!=''){
             var startTime = new Date(Date.parse(timeStart));
             var endTime = new Date(Date.parse(timeEnd));
             if (startTime>=endTime){
                 alert("考评时间止要大于考评时间起");
                 retur;
             }
         }
     }
     function checkscore() {
        var pointsStart = $('#pointsStart').val();
         var    pointsEnd = $('#pointsEnd').val();
         if (pointsStart!=null&&pointsStart!=''&&pointsEnd!=null&&pointsEnd!=''){
             if (parseInt(pointsStart)-parseInt(pointsEnd)>=0){
                 alert("得分范围有误，请重新输入")
                 $('#pointsStart').val("");
                 $('#pointsEnd').val("");
                 return;
			 }
		 }
     }
	//搜索
	$('#searchBtn').click(function() {
        checkTime();
        checkscore();
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
	
	function exportxls(){
		
		var enterpriseName =$('#search #enterpriseName').val();
		var seniority =$('#search #seniority').val();
		var registType =$('#search #registType').val();
		var economicType =$('#search #economicType').val();
		var province =$('#search #province').val();
		var city =$('#search #city').val();
		var area =$('#search #area').val();
		
		window.location.href="${ctx }/StoreExamineAgent/exportxls.shtml";
		
	}

</script>
<%@include file="../common/AdminFooter.jsp"%>
