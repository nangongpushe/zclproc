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
			elem:$('[name="arriveDate"]')[0],
			type:"date",
			format:"yyyy-MM-dd",
		});
		//form渲染
		layui.form.render("select","search");
		/*$('#searchBtn').click(function(){
			self.queryPageList();
		});
		self.queryPageList();
		self.renderPage("pagination");*/
		self.renderTable();
	},
	
	init:function(object){
		object.reportDate=Date_format(object.reportDate,true);
	},
	
/*	renderPage:function(elemId){
		var self=this;
		$("#"+elemId).children('div').remove();
		layui.laypage.render({
			elem:elemId,
			count:self.total,
			limit:self.pagesize,
			jump:function(obj,first){
				if(!first){
					self.pageindex=obj.curr;
					self.pagesize=obj.limit;
					self.queryPageList();
				}
			}
		})
	},
	
	queryPageList:function(){
		var arriveDate=$('[name="arriveDate"]').val();
		var status=$('[name="status"]').val();

		var self=this;
		$.ajax({
			url:"../rotateArrive/listPagination.shtml",
			method:"GET",
			data:{
				pageIndex:self.pageindex,
				pageSize:self.pagesize,
				arriveDate:arriveDate,
				status:"已通过",
			},
			success:function(res){
				var list= res.result||[];
				for(var i=0;i<list.length;i++){
					self.init(list[i]);
				}
				self.list(list);
				var pageReload=self.pageindex!=res.pageIndex
					||self.total!=res.totalCount;
				self.pageindex=res.pageIndex;
				self.pagesize=res.pageSize;
				self.total=res.totalCount;
				if(pageReload){
					self.renderPage("pagination");
				}
			}
		});
	},*/
	
	add:function(data){
		location.href = "../rotateClaim/add.shtml?id="+ data.id;
	},
    returnBack:function(data){
        location.href = "../rotateClaim/returnStatus.shtml?id="+ data.id;
    },
	renderTable:function(){
		var self=this;
		var width=($('.container-box').innerWidth()-250)/8;
		layui.table.render({
			elem:"#myTable",
			loading:true,
			url:'../rotateArrive/listPagination.shtml',
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			where:{
				status:"已通过",
			},
//			width:970,
			cols:[[
				{field:'arriveDate',title:'收款日期',width:width,align:'center',fixed:true,templet:' <div>{{ Format(d.arriveDate,"yyyy-MM-dd hh:mm")}}</div>'},//120
				{field:'payUnit',title:'付款单位',width:width,align:'center'},//100
				{field:'payer',title:'付款人',width:width,align:'center'},//100
				{field:'status',title:'状态',width:width, align:'center'},//120
				{field:'claimStatus',title:'货款状态',width:width,align:'center'},//100
				{field:'reportDate',title:'填报时间',width:width, align:'center',templet:' <div>{{ Format(d.reportDate,"yyyy-MM-dd hh:mm")}}</div>'},//120
				// {field:'claimDate',title:'认领时间',width:width, align:'center',templet: '#claimDateFormat'},
				{field:'claimDate',title:'认领时间',width:width,align:'center',templet:'<div>{{ Format(d.claimDate,"yyyy-MM-dd hh:mm")}}</div>'},
				{field:'reporter',title:'填报人',width:width, align:'center',},//100
				{field:'arriveAmount',title:'金额(元)',width:width, align:'center',},//100
				{field:'balance',title:'余额(元)',width:width, align:'center',},//100
				{fixed: 'right',title:'操作', width:200, align:'center', toolbar: '#barDemo'}//100
			]],
			page:true,//开启分页
			limit:pagesize,
			limits:[10],
			id:"myTable"	
		});
		
		layui.table.on('tool(table)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='view'){
				self.add(data);
			}else if(layEvent=='returnStatus'){
			    self.returnBack(data);
            }
		});
	},
	
	reloadTable:function(){
		layui.table.reload("myTable",{
			method:"POST",
			where:{
				status:"已通过",
				arriveDate:$('[name="arriveDate"]').val()
			},
		});
	},
};