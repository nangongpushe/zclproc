function Add(isedit,id,phosphine){
	this.isedit = isedit;
	this.id= id;
	if(isedit){
		for(var i=0;i<phosphine.pointList.length;i++){
			phosphine.pointList[i].point=ko.observable(phosphine.pointList[i].point);
			phosphine.pointList[i].value=ko.observable(phosphine.pointList[i].value);
		}
	}
	this.detailList = ko.observableArray(phosphine.pointList||[]);
	this.count = isedit?phosphine.pointList.length:0;
	this.encode=isedit?phosphine.encode:'';
	this.fumigates=ko.observableArray([]);
	this.phosphine=phosphine;
}

Add.prototype={

	initPage:function(){
		var self=this;
		if(this.isedit||this.phosphine){
			self.getSerials(this.phosphine.encode);
		}

		layui.form.on('submit(save)', function(data) {
            $("#save").attr("disabled",true);
            self.save(data.field);
			return false;
		});
		layui.form.render('select','form');
		layui.form.on('select(encode)',function(data){
			if(!data.value){
				self.fumigates([]);
				layui.form.render('select','form');
			}else{
				if(self.encode!=data.value){
					self.getSerials(data.value);
				}
			}
			self.encode=data.value;
		})
	},
	
	getSerials:function(storehouse){
		var warehouse = $('[name="warehouse"]').val();
		var self=this;
		layer.load();
		$.ajax({
			url:"../StorageFumigate/getSerials.shtml",
			type:"POST",
			data:{
				'warehouse':warehouse,
				'storehouse':storehouse
			},
			success:function(result){
				self.fumigates(result);
				if(self.isedit||self.phosphine){
					$('[name="fumigate"]').val(self.phosphine.fumigate);
				}
				layui.form.render('select','form');
			},
			complete:function(){
				layer.closeAll('loading');
			},
			error:function(){
				layerMsgError("仓房:"+storehouse+"没有熏蒸记录");
			}
		});
	},

	save:function(postData){
		var detailList = ko.toJS(this.detailList());
		if(detailList.length==0){
			layer.msg("请添加检测点!",{icon:0});
            $("#save").attr("disabled",false);
			return;
		}
		postData.detailListStr=JSON.stringify(detailList);
		postData.isedit=this.isedit;

		if(this.isedit)
			postData.id=this.id;
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../StoragePhosphine/saveOrUpdate.shtml',
				data : postData,
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功"
							, function() {
							location.href = "../StoragePhosphine/main.shtml"
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
			location.href = "../StoragePhosphine/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
	add:function(){
		var self=this;
		if(self.count==7){
			layer.msg("检测点最多7个",{icon:0});
			return;
		}
		self.count=self.count+1;
		var detail={
			point:ko.observable('粮堆检测点'+self.count+'号'),
			value:ko.observable()
		};
		var detailList = self.detailList();
		detailList.push(detail);
		self.detailList(detailList);
	},
	remove:function(index){
		var detailList = this.detailList();
		var removelast = index==detailList.length-1;
		detailList.splice(index,1);
		if(!removelast){
			for(var i=0;i<detailList.length;i++)
				detailList[i].point('粮堆检测点'+(i+1)+'号');
			this.count=detailList.length;
		}
		this.detailList(detailList);
	}
}