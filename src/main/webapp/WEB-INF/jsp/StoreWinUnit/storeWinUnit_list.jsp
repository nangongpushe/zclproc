<%@ page language="java" contentType="text/html; charset=UTF-8"
     %>


<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="serial"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="year"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="declareUnit"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="regulatoryUnit"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="declareDate"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="recommend"]{
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
		<li>代储监管</li>
		<li>业务信息</li>
		<li class="active">优胜单位申报</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
 	 <div class="layui-form" id="search" >
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">评选年份：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="year" name="year">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">上报单位：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="declareUnit" name="declareUnit">
				</div>
			</div>
			<div class="layui-inline" style="width: 30px" >
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn">查询</button>
			</div>	
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">上报时间起：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="timeStart" name="timeStart" >
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">上报时间止：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="timeEnd" name="timeEnd" >
				</div>
			</div>
			
				
			
		</div>	
	
   
    <div class="manage">
    	 <shiro:hasPermission name="StoreWinUnit:add">
        <p class="btn-box" style="padding-top:0px;margin-left:10px;">
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="window.location.href='${ctx }/StoreWinUnit/add.shtml?'">新增</button>
        </p>
        </shiro:hasPermission>
        
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  	
       <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
			
			 <shiro:hasPermission name="StoreWinUnit:edit">  
  			
 			{{#  if(d.recommend === '已推荐'){ }}
  		 	<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">编辑</a>
  			
  			{{#  } else { }}
					
  				<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
					
  			{{#  } }}
			</shiro:hasPermission>  
 			<shiro:lacksPermission name="StoreWinUnit:edit">  
			
  			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">编辑</a>
			</shiro:lacksPermission>  
			<shiro:hasPermission name="StoreWinUnit:recommend">  
           {{#  if(d.recommend === '已推荐'){ }}
  		 	 <a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini"  lay-event=""  >推荐</a>
  			
  			{{#  } else { }}
  			 <a class="layui-btn layui-btn layui-btn-mini" lay-event="recommend"  >推荐</a>
  			{{#  } }}
		  
		   </shiro:hasPermission> 
			<shiro:lacksPermission name="StoreWinUnit:recommend">  
			
		   <a class="layui-btn layui-btn layui-btn-mini layui-btn-disabled"  lay-event=""  >推荐</a>
		   </shiro:lacksPermission> 

			<shiro:hasPermission name="StoreWinUnit:delete">  
  			<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
			 </shiro:hasPermission> 
			<shiro:lacksPermission name="StoreWinUnit:delete">  
  			<a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="">删除</a>
			 </shiro:lacksPermission> 
			
 		
		
		</script>
		<script type="text/html" id="recommend">
 
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
		var date = new Date();
		//初始赋值
	  laydate.render({
	    elem: '#year'
	    ,type: 'year'
	   
	  });
	});

function checkTime() {
    var timeEnd = $('#search #timeEnd').val();
       var  timeStart = $('#search #timeStart').val();
       if (timeStart!=null&&timeStart!=''&&timeEnd!=null&&timeEnd!=''){
           var startTime = new Date(Date.parse(timeStart));
           var endTime = new Date(Date.parse(timeEnd));
           if (startTime>=endTime){
               alert("上报时间止要大于上报时间起");
               retur;
		   }
	   }
}
	var table = layui.table;
	table.render();
	var width=($('.container-box').innerWidth()-35)/7;
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/StoreWinUnit/list.shtml',
		method:'POST',
		cols : [[
			{align:'center',field : 'serial',title : '编号',width:width+20,fixed: true},
 			{align:'center',field:'year',title: '评选年份 ',width:width}, 
			{align:'center',field : 'declareUnit',title : '上报单位',width:width},
			{align:'center',field : 'regulatoryUnit',title : '监管单位',width:width},
			{align:'center',field : 'declareDate',title : '上报时间',width:width},	
			{align:'center',field : 'recommend',title : '状态',width:width},
			{fixed : 'right',align : 'center',toolbar : '#barDemo',title: '操作',width:width+90}, 
			
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
		
			location.href = "${ctx}/StoreWinUnit/view.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/StoreWinUnit/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					
					layer.msg("删除成功",{icon:1}, function(){
						 table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
								declareUnit : $('#search #declareUnit').val(),
								year : $('#search #year').val(),								
								timeEnd : $('#search #timeEnd').val(),
								timeStart : $('#search #timeStart').val()
							}
						});
						})
						
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/StoreWinUnit/edit.shtml?id="
					+ data.id;
		}
		else if (obj.event === 'recommend') {
			layer.confirm('您确定要 推荐么?', function(index) {
				$.post("${ctx}/StoreWinUnit/recommend.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
						layer.msg("推荐成功",{icon:1}, function(){
						 table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
								declareUnit : $('#search #declareUnit').val(),
								year : $('#search #year').val(),								
								timeEnd : $('#search #timeEnd').val(),
								timeStart : $('#search #timeStart').val()
							}
						});
						})
				});
			});
		}
		
		
	});
			

	//搜索
	$('#searchBtn').click(function() {
        checkTime();
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				declareUnit : $('#search #declareUnit').val(),
				year : $('#search #year').val(),								
				timeEnd : $('#search #timeEnd').val(),
				timeStart : $('#search #timeStart').val()
				
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>
