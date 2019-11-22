function Add(isedit,id,storehouses){
	this.isedit = isedit;
	this.id= id;
	this.storehouses=storehouses;
}

Add.prototype={
	initPage:function(){
		var self=this;

		layui.form.on('submit(save)', function(data) {
			$("#save").attr("disabled",true);
			self.save(data.field);
			return false;
		});
		layui.form.render('select','form');
		
		var storeDate=$('[name="storeDate"]').val();
		layui.laydate.render({
			elem : $('[name="storeDate"]')[0],
			type : "date",
			format : "yyyy-MM-dd",
			value : storeDate,
		});
		var firstSupplyDate=$('[name="firstSupplyDate"]').val();
		layui.laydate.render({
			elem : $('[name="firstSupplyDate"]')[0],
			type : "date",
			format : "yyyy-MM-dd",
			value : firstSupplyDate,
		});
		var releaseGasDate=$('[name="releaseGasDate"]').val();
		layui.laydate.render({
			elem : $('[name="releaseGasDate"]')[0],
			type : "date",
			format : "yyyy-MM-dd",
			value : releaseGasDate,
		});
		var discoveryDate=$('[name="discoveryDate"]').val();
		layui.laydate.render({
			elem : $('[name="discoveryDate"]')[0],
			type : "date",
			format : "yyyy-MM-dd",
			value : discoveryDate,
		});
		//粮食下拉框
		layui.form.on('select(grainType)',function(data){
			if(!data.value||!$('[name="storehouse"]').val()){
				$('[name="realQuantity"]').val('');
				return;
			}
			else{
				if(!$('[name="warehouse"]').val()){
					layer.msg('请选择库点',{icon:0});
					return;
				}else{
					self.getRealQuantity();
				}
			}
		});
		//仓房下拉框
		layui.form.on('select(storehouse)',function(data){
            if(!data.value){
                $('select[name="storehouseType"]').val('');
            }else{
                for(var i=0;i<self.storehouses.length;i++){
                    if(data.value==self.storehouses[i].encode){
                        $('select[name="storehouseType"]').val(self.storehouses[i].type);
                        break;
                    }
                }
            }
            layui.form.render('select','form');


			if(!data.value||!$('[name="grainType"]').val()){
				$('[name="realQuantity"]').val('');
				return;
			}
			else{
				if(!$('[name="warehouse"]').val()){
					layer.msg('请选择库点',{icon:0});
					return;
				}else{
					self.getRealQuantity();
				}
			}
		});
	},
	
	getRealQuantity:function(){
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../reportSwtz/getLastestQuantity.shtml',
				data : {
					reportWarehouse:$('[name="warehouse"]').val(),
					storehouse:$('[name="storehouse"]').val(),
					variety:$('[name="grainType"]').val()
				},
				success : function(result) {
					layerMsgSuccess("实际数量读取成功!");
					$('[name="realQuantity"]').val(result.toFixed(3));

				},
				error : function() {
					layer.closeAll();
					layerMsgError("实际数量读取失败!");
				},
				complete:function(){
					layer.closeAll('loading');
				}
		}); 
	},

	save:function(postData){
		postData.isedit=this.isedit;

		if(this.isedit)
			postData.id=this.id;
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../StorageFumigate/saveOrUpdate.shtml',
				data : postData,
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功"
							, function() {
							location.href = "../StorageFumigate/main.shtml"
						});
					} else {
						layerMsgError("操作失败");
                        $("#save").attr("disabled",false);
                    }

				},
				error : function() {
					layer.closeAll();
					layerMsgError("操作失败");
                    $("#save").attr("disabled",false);
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
			location.href = "../StorageFumigate/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
}