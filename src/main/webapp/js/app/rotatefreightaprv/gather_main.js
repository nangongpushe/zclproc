function Main(type){
	this.type=type;
}

Main.prototype={
	initPage:function(){
		var self=this;
        //日期选择器
        layui.laydate.render({
            elem:"#gatherTime",
            type:"date",
            format:"yyyy-MM-dd",
        });
		layui.form.render('select','search');
		self.renderLayTable();
	},
	
	renderLayTable:function(){
		var self=this;
		var width=($('.container-box').innerWidth()-200)/4;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
			cols:[[
				{field:"grainType",title:"品种",width:width, align:'center'},
				{field:"gatherMan",title:"汇总人",width:width,sort:true, align:'center'},
				{field:"gatherTime",title:"汇总时间",width:width,sort:true,templet: '#gatherTimeFormat', align:'center'},
				{field:"status",title:"状态",width:width, align:'center'},
				{fixed: 'right',title:"操作", width:220, align:'center', toolbar: '#barDemo'}
			]],
			url:"../rotateFreightAPRV/listGather.shtml",
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
			}else if(layEvent=='report'){
				self.updateGatherStatus(data,"OA汇总审核");
			}else if(layEvent=='reject'){
				self.updateGatherStatus(data,"已驳回");
			}else if(layEvent=='remove'){
				self.removeGather(data);
			}else if(layEvent=='gather'){
                self.updateGatherStatus(data,"已汇总");
            }

		});
	},
	
	queryPageList:function(){
		var self=this;
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				grainType:$('[name="grainType"]').val(),
                gatherMan:$('[name="gatherMan"]').val(),
                gatherTime:$('[name="gatherTime"]').val(),
                status:$('[name="status"]').val(),
				type:self.type
			}
		});
	},
	clear:function () {
        $('[name="grainType"]').val("");
        $('[name="gatherMan"]').val("");
        $('[name="gatherTime"]').val("");
        $('[name="status"]').val("");
        var form = layui.form;
        form.render();
    },
	show:function(data) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../rotateFreightAPRV/gather_view.shtml?sid=" + data.id;
		$.post(url, {}, function(str) {
			layer.open({
				type : 1,
				content : str,
				area:[width,height]
			});
		});
	},
	updateGatherStatus:function(data,status){
		var self =this;
		var tip;
		if(status=='OA汇总审核'){
			tip='上报后将进入OA审核流程,是否上报?';
		}else if(status == '已驳回'){
			tip='确定要驳回?'
		}else if(status == '已汇总'){
            tip='确定要汇总?'
        }
		layer.confirm(tip, {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			layer.load();
			$.ajax({
				url:"../rotateFreightAPRV/updateGatherStatus.shtml",
				type:"POST",
				data:{
					status:status,
					id:data.id
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
	
	removeGather:function(data){
		var self=this;
		layer.load();
		$.ajax({
			url:"../rotateFreightAPRV/removeGather.shtml",
			type:"POST",
			data:{
				id:data.id
			},
			success:function(result){
				if(result.success){
					layerMsgSuccess("操作成功",function(){self.queryPageList();});
//					obj.update({
//						state:state
//					});
				}
			},
			error:function(){
				layerMsgError('ERROR:服务错误');
			},
			complete:function(){
				layer.closeAll('loading');
			}
		});
	}
};