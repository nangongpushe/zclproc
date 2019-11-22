function Main(type){

	this.list=ko.observableArray([]);
	this.total=0;
	this.pagesize=pagesize;
	this.pageindex=1;
	this.type=type;
}

Main.prototype={
	initPage:function(){
		var self=this;
		layui.laydate.render({
				elem : $('[name="year"]')[0],
				type : "year",
				change: function(value, date, endDate){
					//debugger
					$("#year").val(value);
					if($(".layui-laydate").length){
						$(".layui-laydate").remove();
					}
				},
				format : "yyyy"
		});
		layui.laydate.render({
			elem:$('[name="colletorDate"]')[0],
			type:"date",
			format:"yyyy-MM-dd",	
		});
		layui.laydate.render({
			elem:$('[name="completeDate"]')[0],
			type:"date",
			format:"yyyy-MM-dd",	
		});
		layui.form.render("select","search");

//		self.renderPage("pagination");
//		self.queryPageList();
		self.renderTable();
		
	},
	
	init:function(data){
		data.colletorDate=Date_format(data.colletorDate,true);
		data.state=ko.observable(data.state);

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
		var planName=$('[name="planName"]').val();
		var documentNumber=$('[name="documentNumber"]').val();
		var year=$('[name="year"]').val();
		var colletor=$('[name="colletor"]').val();
		var colletorDate=$('[name="colletorDate"]').val();
		var state=$('[name="state"]').val();
		var self=this;
		$.ajax({
			url:"../rotatePlan/list.shtml",
			method:"GET",
			data:{
				pageIndex:self.pageindex,
				pageSize:self.pagesize,
				planName:planName,
				documentNumber:documentNumber,
				year:year,
				colletor:colletor,
				colletorDate:colletorDate,
				state:state
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
	
	renderTable:function(){
		var width=($('.container-box').innerWidth()-50)/6+1;
		var self =this;
		layui.table.render({
			elem:"#myTable1",
			loading:true,
			url:'../rotatePlan/list.shtml',
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
//			width:1100,
			where:{
				state:'已分发',
				type:self.type
			},
			cols:[[
				{field:'planName',title:'计划详情名称',width:width,align:'center',fixed:true,sort:true},//325
				{field:'year',title:'年份',width:width,align:'center',sort:true},//180
				{field:'stockOut',title:'出库总数(吨)',width:width, align:'center',templet:'#stockOut',sort:true},//176
				{field:'stockIn',title:'入库总数(吨)',width:width,align:'center',templet:'#stockIn',sort:true},//174
				{field:'completeDate',title:'分发时间',width:width,align:'center',templet:'#completeDateFormat',sort:true},//184
                {field:'state',title:'审批状态',width:width, align:'center'},//160
                {field:'outDealQuantiy',title:'出库已成交数量(吨)',width:width,align:'center',sort:true},
                {field:'outUnDealQuantiy',title:'出库未成交数量(吨)',width:width,align:'center',sort:true},
                {field:'inDealQuantiy',title:'入库已成交数量(吨)',width:width,align:'center',sort:true},
                {field:'inUnDealQuantiy',title:'入库未成交数量(吨)',width:width,align:'center',sort:true},
				{fixed: 'right',title:"操作", width:width, align:'center', toolbar: '#barDemo',sort:true}//201
				
			]],
			page:true,//开启分页
			limit:pagesize,
			limits:[10],
			id:"myTable1",
			done: function(res, curr, count){
				$('#myTable1').next().find('a[data-id]').click(function(){
					self.show(this);
				})
			}
		});
		
		layui.table.on('tool(table1)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='view'){
				self.showAllInfo(data);
			}else if(layEvent=='remove'){
                self.remove(data);
			}

		});
	},
	
	reloadTable:function(){
		layui.table.reload("myTable1",{
			method:"POST",
			where:{
				year:$('#search [name="year"]').val(),
				completeDate:$('#search [name="completeDate"]').val(),
				state:'已分发',
				type: this.type
			}
		});
	},

	clearAll:function() {
        $("input[name='completeDate']").val("");
        $("#year").val("");
    },
	
	show:function(elem) {
		var width=$('.container-box').innerWidth()-300;
		var id = $(elem).attr('data-id');
		var rotateType = $(elem).attr('data-type');
		var url = "../rotatePlan/view.shtml";
		$.post(url, {sid:id,rotatetype:rotateType,type:self.type}, function(str) {
			layer.open({
				type : 1,
				title:rotateType+"计划明细",
				content : str,
				area:[width,'500px'],
			});
		});
	},
	
	showAllInfo:function(data) {
		var self=this;
		// var width=$('.container-box').innerWidth();
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../rotatePlan/view2.shtml";
		$.post(url, {sid:data.id,type:self.type}, function(str) {
			layer.open({
				type : 1,
				title:"计划明细",
				content : str,
				area:[width,height],
			});
		});
	},
/*	show:function(data,rotateType) {

		var url = "../rotatePlan/view.shtml";
		$.post(url, {sid:data.id,rotatetype:data.rotateType}, function(str) {
			layer.open({
				type : 1,
				title:rotateType+"计划明细",
				content : str,
				area:['auto','auto']
			});
		});
	},*/
	edit:function(data){
		location.href = "../rotatePlan/edit.shtml?sid="+ data.id;
	},
/*	submit:function(data,state,tip,obj){
		var self=this;
		layer.confirm('确定要继续'+tip+'吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			$.ajax({
				url:"../rotatePlan/updateState.shtml",
				type:"POST",
				data:{
					'id':data.id,
					'state':state
				},
				success:function(result){
					if(result.success){
						data.state(state);
						layerMsgSuccess("操作成功");
					}
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});

	},*/
	submit:function(obj,data,state,tip){
		var self=this;
		layer.confirm('确定要继续'+tip+'吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			$.ajax({
				url:"../rotatePlan/updateState.shtml",
				type:"POST",
				data:{
					'id':data.id,
					'state':state
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功",function(){self.reloadTable();});
//						obj.update({
//							state:state
//						});
					}
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});

	},
	remove:function(data){
		var self=this;
		layer.confirm('确定要删除吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			$.ajax({
				url:"../rotatePlan/remove.shtml",
				type:"POST",
				data:{
					'sid':data.id
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功",function(){
                            location.href = "../rotatePlan/main2.shtml"
						});
					}else{
                        layerMsgError(result.msg,function(){
                            location.href = "../rotatePlan/main2.shtml"
                        });
                    }
				}
			});
		}, function(index) {//否
			layer.close(index);
		});

	},
	add:function(){
		location.href="../rotatePlan/add.shtml";
	},
};