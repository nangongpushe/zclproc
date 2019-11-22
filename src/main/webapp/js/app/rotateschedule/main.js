function Main(type){
//	this.list=ko.observableArray([]);
	this.type=type;
}

Main.prototype={
	initPage:function(){
		var self=this;
		layui.form.render('select','search');
		layui.laydate.render({
			elem:$('[name="reportTime"]')[0],
			type:"date",
			format:"yyyy-MM-dd"
		});
		
		//table渲染
		self.renderLayTable();
	},
	
	init:function(object){
		object.dealDate=Date_format(object.dealDate,true);
		object.gatherDate=Date_format(object.gatherDate,true);
	},
	
	renderLayTable:function(){
		var self=this;
//		var width=($('.container-box').innerWidth()-250)/7+1;
		var width=200;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
//			width:900,
			cols:[[
				{field:"operator",title:"经办人",width:width,fixed:true, align:'center'},//100
				{field:"department",title:"经办部门",width:width, align:'center'},//145
				{field:"reportTimeStr",title:"填报时间",width:width,sort:true, align:'center'},//145
				{field:"reportUnit",title:"填报单位",width:width, align:'center'},//145
				{field:"noticeType",title:"类型",width:width, align:'center'},//145
				{field:"noticeSerial",title:"所属通知书编号",width:width, align:'center'},//200
				{field:"status",title:"状态",width:width, align:'center'},//200
				{fixed: 'right',title:"操作", width:250, align:'center', toolbar: '#barDemo'}//80
			]],
			url:"../rotateSchedule/listPagination.shtml",
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			where:{
				type:self.type
			},
			page:true,//开启分页
			limit:pagesize,
			limits:[10],
			id:'myTableID',
			done:function(res,curr,count){
			},
		});
		var self =this;
		layui.table.on('tool(table)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='detail'){
				self.show(data);
			}else if(layEvent=='submit'){
				self.submit(data,'审核中','提交');
			}else if(layEvent=='report'){
				self.submit(data,'已通过','审核通过')
			}else if(layEvent=='reject'){
				self.submit(data,'未通过','驳回')
			}else if(layEvent == 'edit'){
				location.href="../rotateSchedule/edit.shtml?sid="+data.id;
			}else if(layEvent == 'remove'){
				self.remove(data);
			}
		});
	},
	
	queryPageList:function(){
		var self=this;
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				reportTime:$('#search [name="reportTime"]').val(),
				status:$('#search [name="status"]').val(),
                reportUnit:$('#search [name="reportUnit"]').val(),
                department:$('#search [name="department"]').val(),
                noticeType:$('#search [name="noticeType"]').val(),
                noticeSerial:$('#search [name="noticeSerial"]').val(),
                operator:$('#search [name="operator"]').val(),
				type:self.type
			}
		});
	},
	clear:function () {
        $('#search [name="reportTime"]').val("");
		$('#search [name="status"]').val("");
		$('#search [name="reportUnit"]').val("");
		$('#search [name="department"]').val("");
		$('#search [name="noticeType"]').val("");
		$('#search [name="noticeSerial"]').val("");
		$('#search [name="operator"]').val("");
        var form = layui.form;
        form.render();
    },
	
	show:function(data) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../rotateSchedule/view.shtml?sid=" + data.id;
		$.post(url, {}, function(str) {
			layer.open({
				type : 1,
				title:'',
				content : str,
				area:[width,height],
			});
		});
	},
	add:function(){
		location.href="../rotateSchedule/add.shtml"
	},
	remove:function(data){
		var self=this;
		layer.confirm('确定要删除吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			$.ajax({
				url:"../rotateSchedule/remove.shtml",
				type:"POST",
				data:{
					'id':data.id
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功",function(){
							self.queryPageList();
						});
					}
				},
				error:function(){
					layerMsgError("服务异常");
				}
			});
		}, function(index) {//否
			layer.close(index);
		});

	},
	submit:function(data,status,tip){
		var self=this;
		layer.confirm('确定'+tip+'吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			layer.load();
			$.ajax({
				url:"../rotateSchedule/updateStatus.shtml",
				type:"POST",
				data:{
					'id':data.id,
					'status':status
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功",function(){self.queryPageList();});
					}else{
						layerMsgError("操作失败");
					}
				},
				complete:function(){
					layer.closeAll('loading');
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});

	},
};