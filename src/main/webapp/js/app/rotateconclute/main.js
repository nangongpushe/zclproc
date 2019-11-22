function Main(type){
	this.list=ko.observableArray([]);
	this.total=0;
	this.pagesize=pagesize||10;
	this.pageindex=1;
	this.type=type;
	this.status = type=="Base"||type=="ProviceUnit"?"":"";
}

Main.prototype={
	initPage:function(){
		var self=this;
		//日期选择器
		layui.laydate.render({
			elem:"#dealDate",
			type:"date",
			format:"yyyy-MM-dd",
		});
		//form渲染
		layui.form.render("select","search");
//		self.queryPageList();
		self.renderLayTable();
	},
	
	init:function(object){
		object.dealDate=Date_format(object.dealDate,true);
		object.gatherDate=Date_format(object.gatherDate,true);
	},
	
//	renderPage:function(elemId){
//		var self=this;
//		$("#"+elemId).children('div').remove();
//		layui.laypage.render({
//			elem:elemId,
//			count:self.total,
//			limit:self.pagesize,
//
//			jump:function(obj,first){
//				if(!first){
//					self.pageindex=obj.curr;
//					self.pagesize=obj.limit;
//					self.queryPageList();
//				}
//			}
//		})
//	},
//	
//	queryPageList:function(){
//		var grainType=$('input[name="grainType"]').val();
//		var inviteType=$('select[name="inviteType"]').val();
//		var dealDate=$('[name="dealDate"]').val();
//		var self=this;
//		$.ajax({
//			url:"../rotateConclute/listPagination.shtml",
//			method:"GET",
//			data:{
//				pageIndex:self.pageindex,
//				pageSize:self.pagesize,
//				grainType:grainType,
//				inviteType:inviteType,
//				dealDate:dealDate,
//			},
//			success:function(res){
//				var list= res.result||[];
//				for(var i=0;i<list.length;i++){
//					self.init(list[i]);
//				}
//				self.list(list);
//				var pageReload=self.pageindex!=res.pageIndex
//					||self.total!=res.totalCount;
//				self.pageindex=res.pageIndex;
//				self.pagesize=res.pageSize;
//				self.total=res.totalCount;
//				if(pageReload){
//					self.renderPage("pagination");
//				}
//			}
//		});
//	},
	
	renderLayTable:function(){
		var self=this;
		var width=($('.container-box').innerWidth()-50)/8+1;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
			cols:[[
				{field:"dealSerial",title:"成交明细号",width:width,fixed:true,sort:true, align:'center'},
				{field:"grainType",title:"粮食品种",width:width, align:'center'},
				{field:"inviteType",title:"招标类别",width:width, align:'center'},
				{field:"dealDate",title:"竞价交易时间",width:width,templet: '#dealDateFormat', align:'center'},
				{field:"gather",title:"汇总人",width:width,sort:true, align:'center'},
				{field:"gatherDate",title:"汇总时间",width:width,templet: '#gatherDateFormat',align:'center'},
				{field:"status",title:"分发状态",width:width,sort:true, align:'center'},
                {fixed: 'right',title:"操作", width:width, align:'center', toolbar: '#barDemo'}
			]],
			url:"../rotateConclute/listPagination.shtml",
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			where:{
				type:self.type,
				status:self.status
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
			}else if(layEvent=='distribute'){
				self.submit(obj,data,'已分发','分发');
			}
		});
	},
	
	queryPageList:function(){
		var self=this;
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				grainType:$('[name="grainType"]').val(),
				inviteType:$('select[name="inviteType"]').val(),
				dealDate:$('[name="dealDate"]').val(),
				status:$('[name="status"]').val(),
				type:self.type
				//status:self.status
			}
		});
	},
	clear:function () {
        $('[name="grainType"]').val("");
        $('select[name="inviteType"]').val("");
        $('[name="dealDate"]').val("");
        $('[name="status"]').val("");
        var form = layui.form;
        form.render();
    },
	show:function(data) {	
		var self=this;
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../rotateConclute/view.shtml?";
		$.post(url, {sid:data.id,type:self.type}, function(str) {
			layer.open({
				type : 1,
				content : str,
				area:[width,height]
			});
		});
	},
	submit:function(obj,data,state,tip){
		var self=this;
		layer.confirm('确定要继续'+tip+'吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			layer.load();
			$.ajax({
				url:"../rotateConclute/updateStatus.shtml",
				type:"POST",
				data:{
					'id':data.id,
					'status':state
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
};