function Add(freightDetails,customers){
	
	
	
		for(var i=0;i<freightDetails.length;i++){
			this.initFreightDetail(freightDetails[i]);
		}

	this.freightDetails = ko.observableArray(freightDetails||[]);
	this.customers=[];
	for(var j=0;j<customers.length;j++){
		this.customers.push({clientName:customers[j].clientName,clientId:customers[j].id});
	}
}

Add.prototype={
	initFreightDetail:function(freightDetail){
		freightDetail.clientName = ko.observable(freightDetail.clientName||'');
        freightDetail.clientId = ko.observable(freightDetail.clientId||'');
		freightDetail.price = ko.observable(freightDetail.price||'');
	},


	updateClientNameAndPrice:function(){
		var freightDetails = ko.toJS(this.freightDetails);
		var postData = [];
		for(var i=0;i<freightDetails.length;i++){

			if(freightDetails[i].clientId == null || freightDetails[i].clientId == ""){
                layer.msg("请选择中标单位");
				return;
			}

			if(freightDetails[i].price == null || freightDetails[i].price==""){
				layer.msg("请输入报价");
				return;
			}

			if(freightDetails[i].clientId && freightDetails[i].price){
				postData.push(freightDetails[i]);
			}
		}

		layer.load();
		 $.ajax({
			type : 'POST',
			url:'../rotateFreight/updateClientNameAndPrice.shtml',
			data : {freightDetailsStr:JSON.stringify(postData)},
			success : function(result) {
				if (result.success) {
					layerMsgSuccess("操作成功"
						, function() {
						location.href = "../rotateFreight/main.shtml?view_type=invite"
						});
				} else {
					layerMsgError("操作失败");
				}

			},
			error : function() {
				layer.closeAll();
				layerMsgError("error");
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
			location.href = "../rotateFreight/main.shtml?view_type=invite";
		}, function(index) {//否
			layer.close(index);
		});
	},
}