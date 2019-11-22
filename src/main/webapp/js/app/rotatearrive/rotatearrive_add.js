function Add(isedit,id){
	this.isedit=isedit;
	this.id=id;
}

Add.prototype={
	initPage:function(){
		var self=this;
		layui.form.render("select","form1");
		//时间选择器
		var arrivedate=$('[name="arriveDate"]').val();

		layui.laydate.render({
				elem : $('[name="arriveDate"]')[0],
				type : "datetime",
				format : "yyyy-MM-dd HH:mm",
				value : arrivedate
		});

		layui.form.on('submit(save)', function(data) {
			var postData = data.field;
			if(postData.arriveAmount <= 0){
				layerMsgError("来款金额必须大于0");
				return;
			}
			if($(data.elem).attr("data-status") == "1")
				postData.status = "待提交";
			else if($(data.elem).attr("data-status") == "2")
				postData.status = "审核中(财务经理)";

			postData.isedit = self.isedit;
            postData.payUnit = $("#payUnitSel").find("option:selected").text();

            if((postData.payUnitId==null||postData.payUnitId=='')&&(postData.payer==null || postData.payer=="")){

            	layerMsgError("请填写付款人/单位");
            	return ;
			}

			if(isedit){
                postData.id=self.id;
			}else{
                postData.claimStatus="未完成";
			}

	 		layer.confirm($(data.elem).attr("data-msg"),
	 				function(){
	 					self.save(postData);
	 				},
	 				function(index){
	 					layer.close(index);
	 				});
			return false;
		});
	},
	
	cancel:function(elem){		
		layer.confirm('确定要取消吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			location.href = "../rotateArrive/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
	
	checkAmount:function(elem){
		var reg = /^\d+\.?(\d{1,2})?$/;
		var value=$(elem).val();
		if(!reg.test(value))
			$(elem).val(value.substring(0,value.length-1));
	},
	save:function(postData){
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../rotateArrive/saveOrUpdate.shtml',
				data : postData,
				success : function(result) {
					layer.closeAll('loading');
					if (result.success) {
						layerMsgSuccess("操作成功",function() {
							location.href = "../rotateArrive/main.shtml"
						});
					} else {
						layerMsgError("操作失败");
					}

				},
				error : function() {
					layer.closeAll();
					layerMsgError("error");
				}
			});  
	},
     deleteFile:function(){
         $('#uploadFile').html('<i class="layui-icon"></i>上传');
         /*$('#deleteFile').remove();*/
         $("#deleteFile").attr("style","display:none;");
         $("input#fileId").val('');
         $("#fileName").html("");
         $("#openExce a").html("");
     }
};