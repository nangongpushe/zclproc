function Main(){
	this.data=null;
}

Main.prototype={
	initPage:function(){
		var self=this;
		layui.form.render('select','search');
		layui.form.render('select','search3');
		self.renderLayTable();
	},
	
	renderLayTable:function(){
		var self=this;
//		var width=($('.container-box').innerWidth()-55)/8;
		var width=200;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
			cols:[[
				{field:"paySerial",title:"款项支付编号",width:200,fixed:true,sort:true,align:'center'},
				{field:"reportDate",title:"填报日期",width:width,templet: '#reportDateFormat',align:'center'},
				{field:"clientName",title:"收款单位",width:width,align:'center'},
				{field:"depositAccount",title:"账号",width:width,align:'center'},
				{field:"payType",title:"付款方式",width:width,align:'center'},
				{field:"proceedType",title:"货款类型",width:width-10,sort:true,align:'center'},
				{field:"status",title:"状态",width:width,sort:true,align:'center'},
				{fixed: 'right',title:"操作", width:width+10, align:'center', toolbar: '#barDemo'}
			]],
			url:"../rotatePayment/list.shtml",
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			where:{
				status:self.status
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
			}else if(layEvent=='edit'){
				self.edit(data);
			}else if(layEvent == 'audit'){
				self.showModal();
				self.data=null;
				self.data=data;
			}else if(layEvent=='invite_edit'){
				location.href='../rotateFreight/inviteEdit.shtml?sid='+data.id;
			}else if(layEvent=='submit'){
				self.submit(data,'审核中(业务部经理)');
			}else if(layEvent=='remove'){
				self.remove(data);
			}
		});
	},
	
	queryPageList:function(){
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				clientName:$('input[name="clientName"]').val(),
				depositAccount:$('input[name="depositAccount"]').val(),
				payType:$('[name="payType"]').val(),
				proceedType:$('[name="proceedType"]').val(),
				status:$('[name="status"]').val(),
			}
		});
	},
	
	add:function(){
		location.href="../rotatePayment/add.shtml";	
	},
	show:function(data) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../rotatePayment/view.shtml?sid=" + data.id;
		$.post(url, {}, function(str) {
			layer.open({
				type : 1,
				content : str,
				area:[width,height]
			});
		});
	},
	edit:function(data){
		location.href = "../rotatePayment/edit.shtml?sid="+ data.id;
	},
	submit:function(data,status){
		var self =this;
		var tip;
		if(data.status=='待提交'||data.status=='驳回'){
			tip='确定要提交?';
		}
		layer.confirm(tip, {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			layer.load();
			$.ajax({
				url:"../rotatePayment/updateStatus.shtml",
				type:"POST",
				data:{
					'id':data.id,
					'status':status
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功",function(){self.queryPageList();});
//						obj.update({
//							state:state
//						});
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
	remove:function(data){
		var self = this;
		layer.confirm("确定要删除?", {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			// debugger;
			$.ajax({
				url:"../rotatePayment/remove.shtml",
				type:"POST",
				data:{
					'sid':data.id
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功",function(){self.queryPageList();});
//						obj.update({
//							state:state
//						});
					}
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});

	},
	hideModal:function(){
		$('#myModal').modal('hide');
		
	},
	showModal:function(){
		$('[name="audit"]').val('');
		layui.form.render('select','search3');
		$('#myModal').modal('show');
	},
	audit:function(){
		var self=this;
		var audit=$('[name="audit"]').val();
		if(!audit){
			layer.msg('请选择审核操作',{icon:0});
			return;
		}
		var status=null,tip='';
		if(audit == '驳回'){
			status = '驳回';
			tip="确定驳回?";
		}	
		else if(audit == '审核通过'){
			tip="确定通过审核";
			if(this.data.status == '审核中(业务部经理)')
				status ='审核中(财务部经理)';
			else if(this.data.status == '审核中(财务部经理)')
				status ='审核中(分管领导)';
			else if(this.data.status == '审核中(分管领导)')
				status ='审核中(总经理)';
			else if(this.data.status == '审核中(总经理)')
				status ='审核中(董事长)';
			else if(this.data.status == '审核中(董事长)')
				status ='审核通过';
		}
		layer.confirm(tip, {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			$.ajax({
				url:"../rotatePayment/updateStatus.shtml",
				type:"POST",
				data:{
					'id':self.data.id,
					'status':status
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功",function(){
							self.queryPageList();
							$('[name="audit"]').val('');
							layui.form.render('select','search3');
						});
						$('#myModal').modal('hide');
//						obj.update({
//							state:state
//						});
					}
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});
	},
	
};