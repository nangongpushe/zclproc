<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
	<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
	#mainTable + .layui-form .layui-table-body td[data-field="warehouseName"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="storagehouse"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="detectionOperation"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="detectionTime"]{
		text-align: center;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="detectionHumen"]{
		text-align: left;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>粮油情检测管理</li>
		<li class="active">氮气浓度检测记录</li>
	</ol>
</div>

<div class="" id="self-cover-grain" style="">
	<div class="dialogsCont-" style="">
		<div class="grain-cont-detail"></div>
		<a class="cancalButtons" onclick="displayNone()" style="">返回</a>
	</div>
</div>
<style>
	#self-grain-cover {
		z-index: 20000000;
		opacity: 0.3;
		background-color: rgb(0, 0, 0);
		position: fixed;
		top: 0px;
		display: none;
		left: 0px;
		width: 100%;
		height: 100%;
	}
	.dialogsCont-{
		padding-top: 10px;
		padding: 0 15px 12px;
		pointer-events: auto;
		user-select: none;
		-webkit-user-select: none;
	}
	.cancalButtons{
		height: 28px;
		display: inline-block;
		line-height: 28px;
		margin: 5px 5px 0;
		padding: 0 15px;
		border: 1px solid #dedede;
		background-color: #fff;
		color: #333;
		position: absolute;
		border-radius: 2px;
		font-weight: 400;
		top: 0;
		right: 16px;
		cursor: pointer;
		text-decoration: none;
	}
	#self-cover-grain {
		z-index: 3;
		overflow: scroll;
		min-width: 260px;
		top: 0;
		margin: 0;
		width: 100%;
		height: 100%;
		padding: 0;
		display: none;
		background-color: #fff;
		position: fixed;
		-webkit-background-clip: content;
		border-radius: 2px;
		box-shadow: 1px 1px 50px rgba(0, 0, 0, .3);
	}
</style>
<script>
    //点击弹框取消按钮
    function displayNone() {
        $('#self-cover-grain').css({'display':'none'})
        $('#self-grain-cover').css({'display':'none'})
        $('.grain-cont-detail').html('')
        //searchReload()
    }
</script>

<div class="container-box clearfix" style="padding: 10px">
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">库点名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="warehouseName" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">仓号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="storagehouse" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">检测时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="detectionTime" />
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">检测人:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="detectionHumen" />
				</div>
			</div>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" id="query">查询</button>
			</div>
		</div>
	</div>
	<shiro:hasPermission name="RotateFreight:add">
	<button class=" layui-btn layui-btn-primary layui-btn-small" id="add">
		 新增
	</button>
	</shiro:hasPermission>
	<button class=" layui-btn layui-btn-primary layui-btn-small" style="margin-top:5px;" data-bind="click:function(){$root.batchExport();}">
		 导出
	</button>
	<table class="layui-table" id="mainTable" lay-filter="table"></table>
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
<shiro:hasPermission name="RotateFreight:edit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="RotateFreight:edit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="editadd">复制</a>
</shiro:hasPermission>
<shiro:hasPermission name="RotateFreight:audit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
</shiro:hasPermission>
	</script>
</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script>
function Main(){
	this.checkedIds=[];//保存选中的导出数据ID
	this.rows=[];//保存当前页数据
}

Main.prototype={
	initPage:function(){
		var self=this;
		layui.laydate.render({
			elem:$('[name="detectionTime"]')[0],
			type:"date",
			format:"yyyy年MM月dd日",
		});
		self.renderLayTable();
		layui.table.on('checkbox(table)', function(obj){
			if(obj.checked){//选中
				if(obj.type=='one'){//单个选中
					if($.inArray(obj.data.id,self.checkedIds)==-1)
						self.checkedIds.push(obj.data.id);
				}else if(obj.type=='all'){//全选
					for(var i=0;i<self.rows.length;i++){
						if($.inArray(self.rows[i].id,self.checkedIds)==-1)
							self.checkedIds.push(self.rows[i].id);
					}
				}
			}else{//取消选中
				var index;
				if(obj.type=='one'){//单个
					index=$.inArray(obj.data.id,self.checkedIds);
					self.checkedIds.splice(index,1);
				}else if(obj.type=='all'){//全选
					for(var i=0;i<self.rows.length;i++){
						index=$.inArray(self.rows[i].id,self.checkedIds);
						self.checkedIds.splice(index,1);
					}
				}
			}
		});
	},
	
	renderLayTable:function(){
		var self=this;
		var width=($('.container-box').innerWidth()-50)/7+1;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
			cols:[[
				{checkbox: true},
				{field:"warehouseName",title:"库点名称",width:width,sort:true,align:'center'},
				{field:"storagehouse",title:"仓号",width:width,align:'center'},
				{field:"detectionOperation",title:"检测方法和仪器",width:width,align:'center'},
				/*{field:"phosphine",title:"磷化氢(ppm)",width:width},
				{field:"oxygen",title:"含氧量(%)",width:width},*/
				{field:"detectionTime",title:"检测时间",width:width,sort:true,align:'center'},
				{field:"detectionHumen",title:"检测人",width:width,align:'center'},
				{fixed:'right',title:"操作", width:160, align:'center', toolbar: '#barDemo'}
			]],
			url:"${ctx}/StorageGaslog/view.shtml",
			method:"POST",
			where:{
				status:self.status
			},
			page:true,//开启分页
			limit:pagesize,
			id:'myTableID',
			done:function(res,curr,count){
				self.rows = res.data;
				for(var i=0;i<res.data.length;i++){
					console.log($.inArray(res.data[i].id,self.checkedIds));
					if($.inArray(res.data[i].id,self.checkedIds)>=0){
						$('tbody tr[data-index="'+i+'"]').find(".layui-form-checkbox").addClass("layui-form-checked");
						$("tbody").find("tr").eq(i).find("td").eq(0).find(".layui-form-checkbox").trigger("click");
					}
				}
			},
		});
		var self =this;
		layui.table.on('tool(table)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='detail'){
				self.show(data);
			}else if(layEvent=='edit'){
				self.edit(data);
			}else if(layEvent=='del'){
				self.del(data);
			}else if(layEvent=='editadd'){
                self.editadd(data);
            }
		});
	},
	
	queryPageList:function(){
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				warehouseName:$('input[name="warehouseName"]').val(),
				storagehouse:$('input[name="storagehouse"]').val(),
				detectionTime:$('input[name="detectionTime"]').val(),
				detectionHumen:$('input[name="detectionHumen"]').val()
			}
		});
	},
	show:function(data) {
		var url = "${ctx}/StorageGaslog/Detail.shtml?id=" + data.id;
		window.location.href = url;
	},
	edit:function(data){
		//location.href = "${ctx}/StorageGaslog/Edit.shtml?id="+ data.id;
        layer.load(2, {time: 1000});
        $('#self-cover-grain').css({'display':'block'})
        $('#self-grain-cover').css({'display':'block'})
        $('.grain-cont-detail').load("../StorageGaslog/Edit.shtml?id="+data.id+"&Projectile="+'Projectile')
	},
    editadd:function(data){
        location.href = "${ctx}/StorageGaslog/toeditadd.shtml?id="+ data.id;
    },
	del:function(data){
		layer.confirm('确定要删除吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			$.ajax({
				url:"${ctx}/StorageGaslog/Delete.shtml",
				type:"post",
				data:{
					"id":data.id
				},
				success:function(res){
					if(res.success){
						layer.msg("删除成功！",{icon:1},function(){
							$("#query").click();
						});
					}else{
						layer.msg("删除失败！",{icon:2});
					}
				},
				error:function(){
					layer.msg("系统异常！",{icon:2});
				}
			});
		}, function(index) {//否
			layer.close(index);
		});
	},
	batchExport:function(){
		var self=this;
		layer.confirm('是否继续导出操作?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			if(self.checkedIds.length > 0){
				location.href="${ctx}/StorageGaslog/ExportExcel.shtml?ids="+self.checkedIds.join(',');
				layer.close(index);
			}else{
				layer.msg("您未选择任何一条数据",{icon:0});
				layer.close(index);
			}
		}, function(index) {//否
			layer.close(index);
		});
	},
};

var vm = new Main();
ko.applyBindings(vm,$(".container-box")[0]);
vm.initPage();

$("#add").click(function(){
	location.href="${ctx}/StorageGaslog/Add.shtml";	
});

$("#query").click(function(){
	layui.table.reload("myTableID",{
		method:"POST",
		where:{
			warehouseName:$('input[name="warehouseName"]').val(),
			storagehouse:$('input[name="storagehouse"]').val(),
			detectionTime:$('input[name="detectionTime"]').val(),
			detectionHumen:$('input[name="detectionHumen"]').val()
		}
	});
});
</script>
<script type="text/html" id="inviteTimeFormat">
	{{Date_format(d.inviteTime,true)}}
</script>
<script type="text/html" id="operatorTimeFormat">
	{{Date_format(d.operatorTime,true)}}
</script>
<%@include file="../common/AdminFooter.jsp"%>