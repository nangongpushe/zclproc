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
//		var width=($('.container-box').innerWidth()-50)/7+1;
		var width=250;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
//			width:900,
			cols:[[
				{field:"operator",title:"经办人",width:width,fixed:true, align:'center'},//100
				{field:"department",title:"经办部门",width:width, align:'center'},//145
				{field:"reportTime",title:"填报时间",width:width,sort:true,templet:'#reportTimeFormat', align:'center'},//145
				{field:"reportUnit",title:"填报单位",width:width, align:'center'},//145
				{field:"noticeType",title:"类型",width:width, align:'center'},//145
				{field:"noticeSerial",title:"所属通知书编号",width:width, align:'center'},//200
				{fixed: 'right',title:"操作", width:width, align:'center', toolbar: '#barDemo'}//80
			]],
			url:"../rotateSchedule/listScheduleHistory.shtml",
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			where:{
				groupBy:'NOTICE_SERIAL',
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
			}
		});
	},
	
	queryPageList:function(){
		var self=this;
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				reportTime:$('#search [name="reportTime"]').val(),
				operator:$('#search [name="operator"]').val(),
				department:$('#search [name="department"]').val(),
				reportUnit:$('#search [name="reportUnit"]').val(),
				noticeType:$('#search [name="noticeType"]').val(),
				noticeSerial:$('#search [name="noticeSerial"]').val(),
				type:self.type
			}
		});
	},
	clear:function () {
        $('#search [name="reportTime"]').val("");
        $('#search [name="operator"]').val("");
        $('#search [name="department"]').val("");
        $('#search [name="reportUnit"]').val("");
        $('#search [name="noticeType"]').val("");
        $('#search [name="noticeSerial"]').val("");
        var form = layui.form;
        form.render();
    },
	
/*	show:function(data) {
		var self=this;
		var width=$('.container-box').innerWidth()-300;
		var url = "../rotateSchedule/view2.shtml";
		$.post(url, {noticeType:data.noticeType,noticeSerial:data.noticeSerial,type:self.type}, function(str) {
			layer.open({
				type : 1,
				title:'',
				content : str,
				area:[width,'400px'],
			});
		});
	},*/
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
};