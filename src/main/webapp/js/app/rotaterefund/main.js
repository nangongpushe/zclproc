function Main(){

}

Main.prototype={
	initPage:function(){
		var self=this;
		layui.laydate.render({
				elem : $('[name="dealDate"]')[0],
				type : "date",
				format : "yyyy-MM-dd"
		});
		layui.form.render("select","search");
		this.renderTable();
	},
	
	renderTable:function(){
		var self=this;
		var width=($('.container-box').innerWidth()-250)/8+1;
		layui.table.render({
			elem:"#myTable",
			loading:true,
			url:'../rotateRefund/listPagination.shtml',
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
//			width:1070,
			cols:[[
                {field:'serial',title:'联系单编号',width:width,align:'center',fixed:true,templet: '#arriveDateFormat'},
				{field:'bidSerial',title:'标的号',width:width,align:'center'},//120
				{field:'company',title:'单位',width:width,align:'center'},//100
				{field:'dealDates',title:'交易时间',width:width, align:'center'},//120
				{field:'dealType',title:'交易方式',width:width,align:'center'},//100
				{field:'refundAmount',title:'退还保证金(元)',width:width, align:'center'},//120
				{field:'operator',title:'经办人',width:width, align:'center'},//100
				{field:'department',title:'经办部门',width:width, align:'center'},//100
				{field:'handleTime',title:'经办时间',width:width, align:'center',templet: '#handleTimeFormat'},//100
				{fixed: 'right',title:'操作', width:200, align:'center', toolbar: '#barDemo'}//200
				
			]],
			page:true,//开启分页
			limit:pagesize,
			id:"myTable",
		});
		
		layui.table.on('tool(table)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='edit'){
				self.edit(data);
			}else if(layEvent=='remove'){
				self.remove(data);
			}else if(layEvent=='view'){
				self.show(data);
			}
		});
	},
	
	reloadTable:function(){
		layui.table.reload("myTable",{
			method:"POST",
			where:{
				company:$('[name="company"]').val(),
				dealDate:$('[name="dealDate"]').val(),
				serial:$('[name="serial"]').val(),
				dealType:$('[name="dealType"]').val()
			}
		});
	},
	clear:function () {
        $('[name="company"]').val("");
        $('[name="dealDate"]').val("");
        $('[name="serial"]').val("");
        $('[name="dealType"]').val("");
        var form = layui.form;
        form.render();
    },
	
	add:function(){
		location.href="../rotateRefund/add.shtml";	
	},
	// show : function(data) {
	// 	let width = $("#page-wrapper").innerWidth();
	// 	let height = $("#page-wrapper").innerHeight();
	// 	var url = "../rotateRefund/view.shtml";
	// 	$.post(url, {
	// 		sid : data.id
	// 	}, function(str) {
	// 		layer.open({
	// 			type : 1,
	// 			title : "详情",
	// 			content : str,
	// 			area : [ width, height]
	// 		});
	// 	});
	// },
    show : function(data) {
        location.href = "../rotateRefund/view.shtml?sid=" + data.mainId;
    },
	edit : function(data) {
		location.href = "../rotateRefund/edit.shtml?sid=" + data.mainId;
	},
	remove : function(data) {
		var self = this;
		layer.confirm('确定要删除吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {// 是
			layer.load();
			$.ajax({
				url : "../rotateRefund/remove.shtml",
				type : "POST",
				data : {
					'sid' : data.mainId
				},
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功");
						self.renderTable();
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