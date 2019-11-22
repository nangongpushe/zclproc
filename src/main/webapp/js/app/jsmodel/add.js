function Add(isedit,id,detailList,quotas,grainTypes,hostUrl){
	this.form=layui.form;
	this.isedit=isedit;
	this.id=id;
	this.url=hostUrl;
	this.grainTypes = grainTypes || [];
	this.quotas = quotas;
	this.quotasMap = {};//等级指标Map, 小麦->[一等,二等...]
	this.initQuotas();
	
	if(isedit){
		for(var i=0;i<detailList.length;i++){
			this.initDetailByImport(detailList[i]);
		}
	}

	this.detailList=ko.observableArray(detailList||[]);
	this.rotateType="轮入";
	var date = new Date();
	this.reportMonth = date.getFullYear()+"-12";
	this.storehouses=ko.observableArray([]);
}

Add.prototype={
	initQuotas:function(){
		var grainType;
		for(var i =0; i<this.quotas.length;i++){
			grainType=quotas[i].type;
			if(this.quotasMap[grainType]==undefined){
				this.quotasMap[grainType] = [].concat(quotas[i]);
				this.grainTypes = this.grainTypes.concat(grainType);
			}else{
				this.quotasMap[grainType] = this.quotasMap[grainType].concat(quotas[i]);
			}
		}
	},
	
	initPage:function(){
		var self=this;
		if(!this.isedit){
			var nowDate = new Date();
			var year = nowDate.getFullYear()+1;
			$('input[name="year"]').val(year);
			$('input[name="planName"]').val(year+"年度轮换计划");
		}else{
			$("#in").find('[name="yieldTime"]').each(function(){
				var yieldTime = $(this).val();
				layui.laydate.render({
					elem : $(this)[0],
					type : "year",
					format : "yyyy",
					value:yieldTime
				});
			});
		}
		this.renderTable4();
		layui.laydate.render({
			elem : $('[name="reportMonth"]')[0],
			type : "month",
			format : "yyyy-MM",
		});
		
		//layui.form.render("select",'form');
		layui.form.on('select(warehouse)',function(data){
			$.ajax({
				url:'../storageStoreHouse/getEncodeByWarehouse.shtml',
				type:'POST',
				data:{
					warehouse:data.value
				},
				success:function(res){
					self.storehouses(res);
					layui.form.render('select','search3');
				},
				error:function(){
					layerMsgError('获取该库点的仓房出错!');
				}
			});
		});
		layui.form.on('submit(save)', function(data) {
			var postData = data.field;
//			if(!postData.attachment){
//				layerMsgError("请上传文件");
//				return;
//			}
				
			var detailList=ko.toJS(self.detailList());
			if(detailList.length==0){
				layerMsgError("请添加计划明细");
				return false;
			}
			for(var i=0;i<detailList.length;i++){
				if(detailList[i].rotateType=="轮入"){
					detailList[i].yieldTime = $('#in tr[data-index="'+i+'"]').find('[name="yieldTime"]').val();
					detailList[i].quality = $('#in tr[data-index="'+i+'"]').find('[name="quality"] option[value='+detailList[i].qualityId+']').text();
					delete detailList[i].quotas;
					if(isNaN(detailList[i].rotateNumber)||
							!detailList[i].rotateNumber){
						layerMsgError('请检查轮换数量:轮入数量>0');
						return false;
					}
				}else{
					if(isNaN(detailList[i].rotateNumber)||
							!detailList[i].rotateNumber||
							Number(detailList[i].rotateNumber)>Number(detailList[i].realCapacity)){
						layerMsgError('请检查轮换数量:0<轮出数量≤实际库存');
						return false;
					}
				}
			}
				
			
			postData.isedit = self.isedit;
			postData.detailList=JSON.stringify(detailList);
			postData.department=$('[name="department"]').text();
			postData.colletor=$('[name="colletor"]').text();
			postData.colletorDate=$('[name="colletorDate"]').text();
			postData.modifier=$('[name="modifier"]').text();
			postData.modifyDate=$('[name="modifyDate"]').text();
			if(isedit)
				postData.id=self.id;
			postData.state = $(data.elem).attr("data-status");
			self.save(postData);
			return false;
		});
	},
	//轮入、轮出 模态框
	add:function(rotateType){
		this.rotateType=rotateType;
		if(rotateType == "轮入"){
//			$('#inModal').modal('show');
			var detail=this.initDetail();
			var detailList = this.detailList();
			detailList.push(detail);
			this.detailList(detailList);
			this.render("轮入");
		}else{
			$('#outModal').modal('show');
		}
		//this.confirmChoice();
	},
	
	showModal:function(data){
		$('#inModal').modal('show');
	},
	
	selectWarehouse:function(op){

		var selectList = layui.table.checkStatus("myTable4").data;

		if(null==selectList||selectList.length==0){
			layer.msg("请选择库点",{icon:0});
			return;
		}else if(selectList.length>1){
			layer.msg("只能选择一个库点",{icon:0});
			return;
		}
		debugger
		$("input[tag='model']").val(selectList[0].warehouseShort);
		if('result' == op)
			$("input[name='acceptedUnitId']").val(selectList[0].id);
		else
            $("input[name='warehouseId']").val(selectList[0].id);
		this.hideModal('inModal','myTable4');
	},
	renderTable4:function(){
		layui.form.render("select","search4");
		layui.table.render({
			elem:"#myTable4",
			loading:true,
			url:self.hostUrl+'/storageWarehouse/listValidWarehouse.shtml',
			method:"POST",
            data:{
                // warehouse:data.value
            },
			width:770,
			cols:[[
				{checkbox: true,fixed:true},
				{field:'warehouseCode',title:'库点代码',width:200,align:'center'},
				{field:'warehouseShort',title:'库点简称',width:200,align:'center'},
				{field:'warehouseName',title:'库点名称',width:320,align:'center'},
			]],
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'

			},
			page:true,//开启分页
			limit:pagesize,
			id:"myTable4"
		});
	},
	
	reloadTable4:function(){
		layui.table.reload("myTable4",{
			method:"POST",
			where:{
				warehouseCode:$('#search4 [name="warehouseCode"]').val(),
                warehouseShort:$('#search4 [name="warehouseShort"]').val(),
                warehouseName:$('#search4 [name="warehouseName"]').val(),
			}
		});
	},
	
	render:function(type){
//		layui.form.render('select','form');
		var id="in";
		if(type == "轮出"){
			id="out"
		}
		$("#"+id).find('[name="yieldTime"]').each(function(){
			layui.laydate.render({
				elem : $(this)[0],
				type : "year",
				format : "yyyy",
			});
		});
	},
	hideModal:function(modal,tableId){
//		$('#'+tableId).next().find("div.layui-form-checked").removeClass('layui-form-checked');
		layui.table.reload(tableId);
		$('#'+modal).modal('hide');
		
	},
	initDetailByImport:function(detail){
		var self=this;
		if(detail.rotateType=="轮出"){
			detail.rotateNumber=ko.observable(detail.rotateNumber||0);
			detail.quality=detail.quality||'--';
		}else if(detail.rotateType=="轮入"){
			detail.foodType=ko.observable(detail.foodType||"");
			detail.yieldTime=ko.observable(detail.yieldTime||"");
			detail.orign=ko.observable(detail.orign||"");
			detail.rotateNumber=ko.observable(detail.rotateNumber||0);
			detail.qualityId =ko.observable(detail.qualityId||"");
			detail.quality=detail.quality||"";
			detail.quotas=ko.computed(function(){
				var grainType = this.foodType();
				return self.quotasMap[grainType]||[];
			},detail);
//			//导入时，根据质量等级Grade,查找quality id
//			if(detail.quality){
//				var quotas=detail.quotas();
//				for(var i=0;i<quotas.length;i++){
//					if(quotas[i].grade == detail.quality){
//						detail.qualityId(quotas[i].id);
//						break;
//					}
//				}
//			}
		}
	},
	//导入excel渲染
	renderExcelImport:function(elemid){
		var self=this;
		Excel_Import({
			elem:elemid,
			url:"../rotatePlan/importExcel.shtml",
			data:{
				reportMonth:self.reportMonth
			},
			success:function(data){
				for(var i=0;i<data.length;i++){
					self.initDetailByImport(data[i]);
				}
				var detailList = self.detailList();
				detailList = detailList.concat(data);
				self.detailList(detailList);
			}
		});
	},
	getGrainQuantites:function(grainType){
		 $.ajax({
				type : 'POST',
				url : '../rotatePlan/saveOrUpdate.shtml',
				data : postData,
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功", function() {
							location.href = "../rotatePlan/main.shtml"
						});
					} else {
						layerMsgError(result.msg);
					}

				},
				error : function() {
					layer.closeAll();
					layerMsgError("error");
				}
			});  
	},
	//导入excel渲染
	renderUploadFile:function(elemid){
		var self=this;
		Excel_Import({
			elem:elemid,
			data:{
				reportMonth:self.reportMonth
			},
			success:function(data){
				for(var i=0;i<data.length;i++){
					self.initDetailByImport(data[i]);
				}
				var detailList = self.detailList();
				detailList = detailList.concat(data);
				self.detailList(detailList);
			}
		});
	},
};