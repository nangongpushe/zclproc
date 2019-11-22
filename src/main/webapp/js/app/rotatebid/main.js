function Main(){

	this.list=ko.observableArray([]);
	this.total=0;
	this.pagesize=pagesize;
	this.pageindex=1;
	this.current=ko.observable();
}

Main.prototype={
	initPage:function(){
		var self=this;
		//日期选择器
		layui.laydate.render({
			elem:"#createDate",
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
//		self.queryPageList();
//		self.renderPage("pagination");
		self.renderLayTable();
	},
	
	init:function(object){
		object.createDate=Date_format(object.createDate,true);
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
//		var bidType=$('[name="bidType"]').val();
//		var foodType=$('[name="foodType"]').val();
//		var tenderee=$('[name="tenderee"]').val();
//		var createDate=$('[name="createDate"]').val();
//		var self=this;
//		$.ajax({
//			url:"../rotateBID/listPagination.shtml",
//			method:"GET",
//			data:{
//				pageIndex:self.pageindex,
//				pageSize:self.pagesize,
//				bidType:bidType,
//				foodType:foodType,
//				tenderee:tenderee,
//				createDate:createDate
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
		var width=($('.container-box').innerWidth()-50)/8+1;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
//			width:1060,
			cols:[[
				{field:"bidType",title:"标的物类别",width:width,fixed:true,sort:true, align:'center'},
                {field:"bidName",title:"标的物名称",width:width, align:'center'},
				{field:"tenderee",title:"招标人",width:width, align:'center'},
				{field:"saler",title:"卖出人",width:width, align:'center'},
				{field:"foodType",title:"粮食品种",width:width, align:'center'},
				{field:"total",title:"数量合计（吨）",width:width, align:'center'},
				{field:"creator",title:"经办人",width:width,sort:true, align:'center'},
				{field:"createDate",title:"经办时间",width:width,sort:true,templet: '#createDateFormat', align:'center'},
				{fixed: 'right',title:"操作", width:width, align:'center', toolbar: '#barDemo'}
			]],
			url:"../rotateBID/listPagination.shtml",
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
			}
		});
	},
	
	queryPageList:function(){
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				bidType:$('[name="bidType"]').val(),
				foodType:$('[name="foodType"]').val(),
				tenderee:$('[name="tenderee"]').val(),
				createDate:$('[name="createDate"]').val(),
				saler:$('[name="saler"]').val(),
			}
		});
	},
	clear:function () {
        $('[name="bidType"]').val("");
        $('[name="foodType"]').val("");
        $('[name="tenderee"]').val("");
        $('[name="createDate"]').val("");
        $('[name="saler"]').val("");
        var form = layui.form;
        form.render();
    },
	
	add:function(){
		$('#add').click(function(){
			location.href="../rotateBID/add.shtml";
		})
		
	},
	show:function(data) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight()-8;
		var url = "../rotateBID/view.shtml?sid=" + data.id;
		$.post(url, {}, function(content) {
			layer.open({
				type : 1,
				title:'',
				content : content,
				area:[width,height]
			});
		});
	},
	edit:function(data){
		location.href = "../rotateBID/edit.shtml?sid="+ data.id;
	}
};