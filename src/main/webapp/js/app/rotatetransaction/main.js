function Main(type){
	this.list=ko.observableArray([]);
	this.type=type;
	this.status = type=="Base"||type=="ProviceUnit"?"已分发":"";
}

Main.prototype={
	initPage:function(){
		var self=this;
		//搜索区select渲染
		layui.form.render("select","search");
		//table渲染
		self.renderLayTable();
	},
	
	init:function(object){
		object.dealDate=Date_format(object.dealDate,true);
		object.gatherDate=Date_format(object.gatherDate,true);
	},
	
	renderLayTable:function(){
		var self=this;
		var width=($('.container-box').innerWidth()-50)/6+1;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
//			width:1060,
			cols:[[
				{field:"dealSerial",title:"交易明细号",width:width,fixed:true , align:'center'},
				{field:"grainType",title:"粮食品种",width:width , align:'center'},
				{field:"inviteType",title:"招标类别",width:width, align:'center'},
				{field:"gather",title:"汇总人",width:width, align:'center'},
				{field:"gatherDateStr",title:"汇总时间",width:width,sort:true, align:'center'},
				{fixed: 'right',title:"操作", width:width, align:'center', toolbar: '#barDemo'}
			]],
			url:"../rotateTransaction/listPagination.shtml",
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
		var self =this;
		layui.table.on('tool(table)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='detail'){
				self.show(data);
			}
		});
	},
	
	queryPageList:function(){
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				grainType:$('#search [name="grainType"]').val(),
				inviteType:$('#search [name="inviteType"]').val(),
				type:self.type,
				status:self.status
			}
		});
	},
    clear:function () {
		//alert($('#search [name="grainType"]').val())
        $('#grainType').val("");
        $('#search [name="inviteType"]').val("");
        var form = layui.form;
        form.render();
    },
	
	show:function(data) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../rotateTransaction/view.shtml";
		$.post(url, {sid:data.id,type:self.type}, function(str) {
			layer.open({
				type : 1,
				content : str,
				area:[width, height]
			});
		});
	},
	add:function(){
		location.href="../rotateTransaction/add.shtml"
	},
};