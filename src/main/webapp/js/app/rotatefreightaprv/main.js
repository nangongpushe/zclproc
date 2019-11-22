function Main(type){
	this.type=type;
}

Main.prototype={
	initPage:function(){
		var self=this;
        layui.form.render('select','search');
		self.renderLayTable();
	},
	
	renderLayTable:function(){
		var self=this;
//		var width=($('.container-box').innerWidth()-250)/10;
		var width=138;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
			cols:[[
				{field:"reportUnit",title:"调入单位",width:width,fixed:true, align:'center'},
				{field:"grainType",title:"品种",width:width, align:'center'},
				{field:"totalQuantity",title:"数量合计(吨)",width:width, align:'center'},
				{field:"totalBulk",title:"散运合计(吨)",width:width,sort:true, align:'center'},
				{field:"totalPackage",title:"包装合计(吨)",width:width,sort:true, align:'center'},
				{field:"totalFreight",title:"运费合计(元/吨)",width:width,sort:true, align:'center'},
				{field:"totalFee",title:"费用合计(元)",width:width,sort:true, align:'center'},
				{field:"status",title:"状态",width:width,sort:true, align:'center'},
				{field:"company",title:"填报单位",width:width,sort:true, align:'center'},
				{field:"reportDate",title:"填报时间",width:width,sort:true,templet: '#reportDateFormat', align:'center'},
				{fixed: 'right',title:"操作", width:250, align:'center', toolbar: '#barDemo'}
			]],
			url:"../rotateFreightAPRV/listPagination.shtml",
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
		layui.table.on('tool(table)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='detail'){
				self.show(data);
			}else if(layEvent=='edit'){
				self.edit(data);
			}else if(layEvent=='remove'){
				self.remove(data);
			}else if(layEvent=='submit'){
				self.updateStatus(data,'OA审核流程');
			}else if(layEvent=='report'){
				self.updateStatus(data,'待汇总');
			}else if(layEvent == 'pass'){
				self.updateStatus(data,'审核通过');
			}else if(layEvent=='reject'){
				self.updateStatus(data,'已驳回')
			}else if(layEvent=='gather'){
				self.updateGather(data);
			}
		});
	},
	
	queryPageList:function(){
		var self=this;
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				reportUnit:$('input[name="reportUnit"]').val(),
				type:self.type,
				outUnit:$('[name="outUnit"]').val(),
                grainType:$('[name="grainType"]').val(),
                status:$('[name="status"]').val(),
			}
		});
	},
	clear:function () {
        $('input[name="reportUnit"]').val("");
        $('[name="outUnit"]').val("");
        $('[name="grainType"]').val("");
        $('[name="status"]').val("");
        var form = layui.form;
        form.render();
    },
	
	add:function(){
		location.href="../rotateFreightAPRV/add.shtml";	
	},
	show:function(data) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight()-8;
		var url = "../rotateFreightAPRV/view.shtml?sid=" + data.id;
		$.post(url, {}, function(str) {
			layer.open({
				type : 1,
				content : str,
				area:[width,height]
			});
		});
	},
	edit:function(data){
		location.href = "../rotateFreightAPRV/edit.shtml?sid="+ data.id;
	},
	updateStatus:function(data,status){
		var self =this;
		var tip;
		var postData={};
		if(status=='OA审核流程'){
			tip='提交后将进入OA审核流程,是否提交?';
		}else if(status == '待汇总'){
			tip='确定上报?';
		}else if(status == '已驳回'){
			tip='确定要驳回?'
		}
		postData.id=data.id;
		postData.status=status;
		layer.confirm(tip, {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			var loadIndex=layer.load();
			$.ajax({
				url:"../rotateFreightAPRV/updateStatus.shtml",
				type:"POST",
				data:postData,
				success:function(result){
					if(result.success){
						layer.close(loadIndex);
						layerMsgSuccess("操作成功",function(){self.queryPageList();});
//						obj.update({
//							state:state
//						});
					}
				},
				error:function(){
					layer.close(loadIndex);
					layerMsgError('ERROR:服务错误');
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});

	},
	remove:function(data){
		var self=this;
		layer.confirm("确定要删除?", {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			$.ajax({
				url:"../rotateFreightAPRV/remove.shtml",
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
				},
				error:function(){
					layerMsgError('ERROR:服务错误');
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});
	},
	updateGather:function(data){
		var self =this;
		layer.confirm("是否要汇总？", {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			$.ajax({
				url:"../rotateFreightAPRV/updateGather.shtml",
				type:"POST",
				data:{
					id:data.id,
					grainType:data.grainType
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功",function(){self.queryPageList();});
					}
				},
				error:function(){
					layerMsgError('ERROR:服务错误');
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});

	},
	
};