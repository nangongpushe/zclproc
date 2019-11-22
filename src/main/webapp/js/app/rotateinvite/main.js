

function Main(){
	this.list=ko.observableArray([]);
	this.total=0;
	this.pagesize=pagesize;
	this.pageindex=1;
}

Main.prototype={
	initPage:function(){
		var self=this;
		//日期选择器
		layui.laydate.render({
			elem:"#handleTime",
			type:"date",
			format:"yyyy-MM-dd",
		});
		//form渲染
		layui.form.render("select","search");
		$('#searchBtn').click(function(){
			self.queryPageList();
		});
        $('#clear').click(function(){
            self.clear();
        });
		self.add();
//		self.renderPage("pagination");
		self.renderLayTable();
	},
	
	init:function(object){
		object.handleTime=Date_format(object.handleTime,true);
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
//					self.pageindex=obj.curr;
//					self.pagesize=obj.limit;
//					self.queryPageList();
//			}
//		})
//	},
//	
//	queryPageList:function(){
//		var inviteName=$('input[name="inviteName"]').val();
//		var inviteType=$('select[name="inviteType"]').val();
//		var handleTime=$('[name="handleTime"]').val();
//		var self=this;
//		$.ajax({
//			url:"../rotateInvite/listPagination.shtml",
//			method:"GET",
//			data:{
//				pageIndex:self.pageindex,
//				pageSize:self.pagesize,
//				inviteName:inviteName,
//				inviteType:inviteType,
//				handleTime:handleTime,
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
		var width=($('.container-box').innerWidth()-50)/6+1;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
//			width:1060,
			cols:[[
				{field:"inviteSerial",title:"招标结果编号",width:width,fixed:true,sort:true, align:'center'},
				{field:"inviteName",title:"招标结果名称",width:width, align:'center'},
				{field:"inviteType",title:"招标结果类别",width:width, align:'center'},
				{field:"operator",title:"创建人",width:width, align:'center'},
				{field:"handleTime",title:"时间",width:width,sort:true,templet: '#handleTimeFormat', align:'center'},
				{fixed: 'right',title:"操作", width:width, align:'center', toolbar: '#barDemo'}
			]],
			url:"../rotateInvite/listPagination.shtml",
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
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
			}else if(layEvent=='submit'){
				self.submit(data);
			}
		});
	},
	
	queryPageList:function(){
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				inviteName:$('input[name="inviteName"]').val(),
				inviteType:$('select[name="inviteType"]').val(),
				handleTime:$('[name="handleTime"]').val(),
			}
		});
	},
	clear:function () {
        $('input[name="inviteName"]').val("");
        $('select[name="inviteType"]').val("");
        $('[name="handleTime"]').val("");
        var form = layui.form;
        form.render();
    },
	
	add:function(){
		$('#add').click(function(){
			location.href="../rotateInvite/add.shtml";
		})
		
	},
	show:function(data) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../rotateInvite/view.shtml?sid=" + data.id;
		$.post(url, {}, function(str) {
			layer.open({
				type : 1,
				content : str,
				area:[width,height]
			});
		});
	},
	edit:function(data){
		location.href = "../rotateInvite/edit.shtml?sid="+ data.id;
	},
	submit:function(data){
		var self=this;
		layer.confirm('是否要生成成交结果?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			var loadIndex=layer.load();
			$.ajax({
				url:"../rotateInvite/updateIsGather.shtml",
				type:"POST",
				data:{
					'sid':data.id
				},
				success:function(result){
					if(result.success){
						layer.close(loadIndex);
						layerMsgSuccess("操作成功",function(){self.queryPageList();});
//						obj.update({
//							state:state
//						});
					}else{
						layerMsgError(result.msg);
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