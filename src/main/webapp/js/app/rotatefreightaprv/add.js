function Add(isedit,id,aprv,shipTypes,reportUnits,addressMap){
	this.isedit=isedit;
	this.id=id;
	this.aprv=aprv;
	this.detailList = ko.observableArray(aprv.detailList||[]);
	this.shipTypes=[];
	for(var j=0;j<shipTypes.length;j++){
		this.shipTypes.push(shipTypes[j].value);
	}
	this.currentDetail=ko.observable();
	this.currentIndex=-1;
	this.operation=null;//用于判断是新增还是编辑明细
	this.grainType=null;
	this.reportUnit=null;
	this.address=null;
	if(isedit){
		this.reportUnit=aprv.reportUnit;
		this.grainType=aprv.grainType;
	}
	
	this.reportUnits=reportUnits||[];
	this.addressMap = addressMap;
	this.map={};
	
}

Add.prototype={
		
		initPage:function(){
			var self=this;
			layui.form.render('select','form');
			layui.form.on('submit(save)', function(data) {
				var postData = data.field;
				postData.status = $(data.elem).attr('data-status');
				self.save(postData);
				return false;
			});
			layui.form.on('select(grainType)',function(data){
				if(self.grainType!=data.value){
					self.detailList([]);
					self.grainType=data.value;
				}
			});
			layui.form.on('select(reportUnit)',function(data){
		
				if(self.reportUnit!=data.value){
					self.detailList([]);
					self.reportUnit=data.value;
					if(!data.value)
						self.address='';
					else
						self.address=self.addressMap[data.value];
					$('#form1 [name="reportUnitAddress"]').val(self.address);
				}
			});
			layui.form.on('submit(confirm)', function(data) {
				var detail = ko.toJS(self.currentDetail());
				if(!detail){
					layerMsgError("请填写明细");
					return false;;
				}
				var detailList=self.detailList();
				if(self.operation=="edit"){
					detailList.splice(self.currentIndex,1,detail);
					self.detailList(detailList);
				}else if(self.operation=="add"){
					detailList.push(detail);
					self.detailList(detailList);
				}
				self.hideModal()
				return false;
			});
			/*弹框取消按钮*/
			/*layui.form.on('submit(notSure)', function(data) {
				self.hideModal()
				return false;
			});*/
	},
	initDetail:function(detail){
		detail.outUnit = ko.observable(detail.outUnit||'');
		detail.outStartPlace = ko.observable(detail.outStartPlace||'');
		detail.inAimPlace = ko.observable(detail.inAimPlace||'');
		detail.distance = ko.observable(detail.distance||'');
		detail.shipType = ko.observable(detail.shipType||'');
		detail.quantity = ko.observable(detail.quantity||'');
		detail.bulk = ko.observable(detail.bulk||'');
		detail.packageNum = ko.observable(detail.packageNum||'');
		detail.bulkFreightUnit = ko.observable(detail.bulkFreightUnit||'');
        detail.packageFreightUnit = ko.observable(detail.packageFreightUnit||'');
        /*detail.packagePreBoardRate = ko.observable(detail.packagePreBoardRate||'');
        detail.bulkPreBoardRate = ko.observable(detail.bulkPreBoardRate||'');
        detail.packageInStoreRate = ko.observable(detail.packageInStoreRate||'');
        detail.bulkInStoreRate = ko.observable(detail.bulkInStoreRate||'');*/
		detail.freight = ko.observable(detail.freight||'');
		detail.otherFee = ko.observable(detail.otherFee||'');
		detail.boardFee = ko.observable(detail.boardFee||'');
		detail.warehouseFee = ko.observable(detail.warehouseFee||'');
        detail.packagePreBoardRate = ko.observable(detail.packagePreBoardRate||'');
        detail.bulkPreBoardRate = ko.observable(detail.bulkPreBoardRate||'');
        detail.packageInStoreRate = ko.observable(detail.packageInStoreRate||'');
        detail.bulkInStoreRate = ko.observable(detail.bulkInStoreRate||'');
		/*detail.totalFee=ko.computed(function(){
			return Number(this.freight())+Number(this.otherFee())+Number(this.boardFee())+Number(this.warehouseFee());
		},detail);*/
        detail.totalFee=ko.computed(function(){
            return (Number(this.freight())+Number(this.otherFee())).toFixed(2);
        },detail);
		detail.remark = ko.observable(detail.remark||'');
	},
	save:function(postData){
		var detailList = ko.toJS(this.detailList);
		if(null==detailList||detailList.length==0){
			layer.msg('请添加运费审批明细',{icon:0});
			return;
		}
		postData.detailListStr=JSON.stringify(detailList);
		postData.isedit=this.isedit;
		if(isedit)
			postData.id=this.id;
		layer.load();
		 $.ajax({
			type : 'POST',
			url:'../rotateFreightAPRV/saveOrUpdate.shtml',
			data : postData,
			success : function(result) {
				if (result.success) {
					layerMsgSuccess("操作成功"
						, function() {
						location.href = "../rotateFreightAPRV/main.shtml"
						});
				} else {
					layerMsgError("操作失败");
				}

			},
			error : function() {
				layer.closeAll();
				layerMsgError("操作失败");
			},
			complete:function(){
				layer.closeAll('loading');
			}
		});  
	},
	cancel:function(){
		layer.confirm('确定要取消吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			location.href = "../rotateFreightAPRV/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
	remove:function(index){
		var detailList=this.detailList();
		detailList.splice(index,1);
		this.detailList(detailList);
	},
	/*编辑*/
	edit:function(data,index){
		this.operation='edit';
		//this.initDetail(data);
		this.currentDetail(data);
		this.currentIndex=index;
		//console.log(JSON.stringify(this.detailList()))
		$('#myModal').modal('show');
	},

//	--------模态框---------------
	/*新增*/
	showModal:function(){
		var self = this;
		this.operation='add';
//		var address= $('#form1 [name="reportUnitAddress"]').val();
//		this.aprv.reportUnitAddress=address;
        this.reportUnit = $("#enterpriseId option:selected").val();
		if(!this.reportUnit||!this.grainType){
			layer.msg("请先选择调入单位和粮食品种",{icon:0});
			return;
		}
		var detail={
			reportUnit:$("#reportUnit").val(),
			inAimPlace:$('#form1 [name=\"reportUnitAddress\"]').val(),
			grainType:this.grainType
		};
		this.initDetail(detail);
		this.currentDetail(detail);
		$('#myModal').modal('show');
	},
	/*隐藏模态框*/
	hideModal:function(data){
		$('#myModal').modal('hide');
	},

}