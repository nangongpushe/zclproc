function Main(viewType){
	this.viewType = viewType;
	this.status = viewType == 'invite'?'审核通过':'';
}

Main.prototype={
	initPage:function(){
		var self=this;
		//日期选择器
		layui.laydate.render({
			elem:$('[name="inviteTime"]')[0],
			type:"date",
			format:"yyyy-MM-dd",
		});
		layui.form.render('select','search');
		self.renderLayTable();
	},
	
	renderLayTable:function(){
		var self=this;
		var width=($('.container-box').innerWidth()-50)/7+1;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
			cols:[[
				{field:"freightName",title:"运费方案名称",width:width,fixed:true,sort:true, align:'center'},
				{field:"inviteUnit",title:"招标单位",width:width, align:'center'},
				{field:"inviteTime",title:"招标开始时间",width:width,templet: '#inviteTimeFormat', align:'center'},
                {field:"inviteEndTime",title:"招标截止时间",width:width,templet: '#inviteEndTimeFormat', align:'center'},
				{field:"status",title:"审核状态",width:width, align:'center'},
				{field:"operator",title:"经办人",width:width, align:'center'},
				{field:"operatorTime",title:"经办时间",width:width,sort:true,templet: '#operatorTimeFormat', align:'center'},
				{fixed: 'right',title:"操作", width:width, align:'center', toolbar: '#barDemo'}
			]],
			url:"../rotateFreight/listPagination.shtml",
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
				self.submit(data,'审核通过');
			}else if(layEvent=='invite_edit'){
				location.href='../rotateFreight/inviteEdit.shtml?sid='+data.id;
			}else if(layEvent=='submit'){
				self.submit(data,'审核中');
			}else if(layEvent=='reject'){
				self.submit(data,'已驳回');
			}
		});
	},
	
	queryPageList:function(){
		var status;
		if(this.viewType=='invite')
			status = this.status;
		else
			status=$('select[name="status"]').val();
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				freightName:$('input[name="freightName"]').val(),
				status:status,
				inviteTime:$('[name="inviteTime"]').val(),
                inviteUnit:$('[name="inviteUnit"]').val(),
                operator:$('[name="operator"]').val(),
			}
		});
	},
	clear:function () {
        $('input[name="freightName"]').val("");
        $('[name="inviteTime"]').val("");
        $('[name="inviteUnit"]').val("");
        $('[name="operator"]').val("");
        $('select[name="status"]').val("");
        var form = layui.form;
        form.render();
    },
	add:function(){
		location.href="../rotateFreight/add.shtml";	
	},
	show:function(data) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../rotateFreight/view.shtml?sid=" + data.id+"&view_type="+this.viewType;
		$.post(url, {}, function(str) {
			layer.open({
				type : 1,
				content : str,
				area:[width,height]
			});
		});
	},
	edit:function(data){
		location.href = "../rotateFreight/edit.shtml?sid="+ data.id;
	},
	submit:function(data,status){
		var self =this;
		var tip;
		if(status=='审核中'){
			tip='确定要提交?';
		}else if(status=='审核通过'){
			tip='确定要通过审核?';
		}else if(status=="已驳回"){
			tip="确定要驳回吗?";
		}
		layer.confirm(tip, {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			layer.load();
			$.ajax({
				url:"../rotateFreight/updateStatus.shtml",
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

	}
	
};