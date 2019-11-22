function Main(){
	this.storehouses=ko.observableArray([]);
	this.warehouse=null;
	this.checkedIds=[];//保存选中的导出数据ID
	this.rows=[];//保存当前页数据
}

Main.prototype={
	initPage:function(){
		var self=this;
		layui.form.render('select','search');
		layui.form.on('select(warehouse)',function(data){
			if(!data.value){
				self.storehouses([]);
				layui.form.render('select','search');
			}else{
				if(self.warehouse!=data.value){
					self.getStorehouseByWarehouse(data.value);
					
				}
			}
			self.warehouse=data.value;
		});
		//table渲染
		self.renderLayTable();
		//复选框监听
		layui.table.on('checkbox(table)', function(obj){

			if(obj.checked){//选中
				if(obj.type=='one'){//单个选中
					if($.inArray(obj.data.id,self.checkedIds)==-1)
						self.checkedIds.push(obj.data.id);
				}else if(obj.type=='all'){//全选
					for(var i=0;i<self.rows.length;i++){
						if($.inArray(self.rows[i].id,self.checkedIds)==-1)
							self.checkedIds.push(self.rows[i].id);
					}
				}
			}else{//取消选中
				var index;
				if(obj.type=='one'){//单个
					index=$.inArray(obj.data.id,self.checkedIds);
					self.checkedIds.splice(index,1);
				}else if(obj.type=='all'){//全选
					for(var i=0;i<self.rows.length;i++){
						index=$.inArray(self.rows[i].id,self.checkedIds);
						self.checkedIds.splice(index,1);
					}
				}
			}
			console.log(layui.table.checkStatus('myTableID'));
		});
	},
	
	getStorehouseByWarehouse:function(warehouseId){
		debugger;
		var self=this;
		layer.load();
		$.ajax({
			url:"../storageStoreHouse/getEncodeByWarehouse.shtml",
			type:"POST",
			data:{
				'warehouse':warehouseId,
			},
			success:function(result){
				self.storehouses(result);
				layui.form.render('select','search');
			},
			complete:function(){
				layer.closeAll('loading');
			},
			error:function(){
				layerMsgError(warehouseName+"下的仓房,获取失败!");
			}
		});
	},
	
	renderLayTable:function(){
		var self=this;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
//			width:900,
			cols:[
			[
				{checkbox:true,fixed:true,rowspan: 2},
				{field:"warehouse",title:"库点名称",width:150,fixed:true,rowspan: 2,align:'center'},
				{field:"storehouse",title:"仓号",width:150,rowspan: 2,align:'center'},
				{field:"grainType",title:"粮食品种",width:150,rowspan: 2,align:'center'},
				{field:"realQuantity",title:"实际数量(吨)",width:150,rowspan: 2,align:'center'},
				{field:"airType",title:"通风方式",width:150,rowspan: 2,align:'center'},
				{field:"airStartTime",title:"开始通风时间",width:150,templet:'#airStartTimeFormat',rowspan: 2,align:'center'},
				{field:"airEndTime",title:"停止通风时间",width:150,templet:'#airEndTimeFormat',rowspan: 2,align:'center'},
				{title:"粮食平均温度(℃)",colspan:2,width:150,align:'center' },
				{title:"粮食平均水分(%)",colspan:2,width:150,align:'center' },
				{field:"operator",title:"操作人",width:100,rowspan: 2},
				{fixed: 'right',title:"操作", width:300, align:'center', toolbar: '#barDemo'}
			],
			[
				{field:"averageGrainTemperature",title:"通风前",width:75,align:'center'},
				{field:"averageGrainTemperatureNew",title:"通风后",width:75,align:'center'},
				{field:"averageGrainDew",title:"通风前",width:75,align:'center'},
				{field:"averageGrainDewNew",title:"通风后",width:75,align:'center'},
			]
			],

			url:"../StorageMachineAir/list.shtml",
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			page:true,//开启分页
			limit:pagesize,
			id:'myTableID',
			done:function(res,curr,count){
				self.rows = res.data;
				
				for(var i=0;i<res.data.length;i++){
					console.log($.inArray(res.data[i].id,self.checkedIds));
					if($.inArray(res.data[i].id,self.checkedIds)>=0){
						$('tbody tr[data-index="'+i+'"]').find(".layui-form-checkbox").addClass("layui-form-checked");
						$("tbody").find("tr").eq(i).find("td").eq(0).find(".layui-form-checkbox").trigger("click");
					}
				}
			},
		});
		var self =this;
		layui.table.on('tool(table)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='view'){
				self.show(data);
			}else if(layEvent=='remove'){
				self.remove(data);
			}else if(layEvent == 'edit'){
				//location.href="../StorageMachineAir/edit.shtml?sid="+data.id;
                layer.load(2, {time: 1000});
                $('#self-cover-grain').css({'display':'block'})
                $('#self-grain-cover').css({'display':'block'})
                $('.grain-cont-detail').load("../StorageMachineAir/edit.shtml?sid="+data.id+"&Projectile="+'Projectile')
			}else if(layEvent == 'editadd'){
                location.href="../StorageMachineAir/editadd.shtml?sid="+data.id;
            }
		});
	},
	
	queryPageList:function(){
		var self=this;
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				warehouse:$('#search [name="warehouse"]').val(),
				storehouse:$('#search [name="storehouse"]').val(),
				airType:$('#search [name="airType"]').val(),
				operator:$('#search [name="operator"]').val()
			}
		});
	},
	
	show:function(data) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../StorageMachineAir/view.shtml?sid=" + data.id;
		$.post(url, {}, function(str) {
			layer.open({
				type : 1,
				title:'',
				content : str,
				area:[width, height],
				//maxmin:true
			});
		});
	},
	add:function(){
		location.href="../StorageMachineAir/add.shtml"
	},
	remove:function(data,status,tip){
		var self=this;
		layer.confirm('确定删除吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			layer.load();
			$.ajax({
				url:"../StorageMachineAir/remove.shtml",
				type:"POST",
				data:{
					'sid':data.id,
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功",function(){self.queryPageList();});
					}else{
						layerMsgError("操作失败");
					}
				},
				complete:function(){
					layer.closeAll('loading');
				},
				error:function(){
					layerMsgError("操作失败");
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});

	},
	batchExport:function(){
		var self=this;
		layer.confirm('是否继续导出操作?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			location.href="../StorageMachineAir/exportExcel.shtml?ids="+self.checkedIds.join(',');
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});
	},
};