function Main(){
	this.rotateType='入库';
}

Main.prototype={
	initPage:function(){
		var self=this;
		layui.element.on('tab(test)', function(data){
			  self.rotateType = $(this).attr('data-type');
			  self.reloadTable();

		});
		layui.form.render('select','search');
		layui.laydate.render({
			elem:$('[name="endTime"]')[0],
			type:"date",
			format:"yyyy-MM-dd"
		});
		//table渲染
		self.renderLayTable1();
		//self.renderLayTable2();
	},

	
	renderLayTable1:function(){
		var self =this;
//		var width=($('.container-box').innerWidth()-50)/9+1;
		var width=200;
		layui.table.render({
			elem:"#mainTable1",
			loading:true,
			cols:[[
				{field:"grainType",title:"品种",width:width,fixed:true, align:'center'},//100
				{field:"schemeBatch",title:"批次",width:width, align:'center'},//145
				{field:"quantity",title:"计划数量合计(吨)",width:width,sort:true, align:'center'},//145
				{field:"priorPeriod",title:"上期合计(吨)",width:width, align:'center'},//145
				{field:"currentPeriod",title:"本期合计(吨)",width:width, align:'center'},//145
				{field:"total",title:"累计合计(吨)",width:width, align:'center'},//200
				{field:"compleRate",title:"完成率合计(%)",width:width, align:'center'},//200
				{field:"modifyTimeStr",title:"汇总时间",width:width, align:'center'},//200
				{fixed: 'right',title:"操作", width:width, align:'center', toolbar: '#barDemo1'}//80
			]],
			url:"../rotateSchedule/gatherScheduleDetail.shtml",
			method:"POST",
			where:{
				schemeType:self.rotateType
			},
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			page:true,//开启分页
			limit:pagesize,
			limits:[10],
			id:'myTableID1',
			done:function(res,curr,count){
			},
		});
		layui.table.on('tool(table1)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='view'){
				self.show(data,self.rotateType);
			}
		});
	},
	
	
	reloadTable:function(){
		var self=this;
		layui.table.reload("myTableID1",{
			method:"POST",
			where:{
				schemeType:self.rotateType,
				schemeBatch:$('#search [name="schemeBatch"]').val(),
				grainType:$('#search [name="grainType"]').val(),
				endTime:$('#search [name="endTime"]').val(),
			},
		});
	},
	clear:function () {
        $('#search [name="schemeBatch"]').val("");
        $('#search [name="grainType"]').val("");
        var form = layui.form;
        form.render();
    },
	
	
	show:function(data,rotateType) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../rotateSchedule/view_gather_detail.shtml";
		$.post(url, {schemeBatch:data.schemeBatch,grainType:data.grainType,rotateType:rotateType}, 
		function(str) {
			layer.open({
				type : 1,
				title:'',
				content : str,
				area:[width,height],
			});
		});
	},
};