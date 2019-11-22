function Audit(arriveId,auditStep){
	this.arriveId=arriveId;
	this.auditStep = auditStep;
}

Audit.prototype={
	initPage:function(){
		layui.form.render("select","form1");
		layui.form.on('select(status)',function(data){
			var value =data.value;
			if(value == "已驳回")
				$('#reasonDiv').show();
			else
				$('#reasonDiv').hide();
		});
	},
	
	cancel:function(elem){		
		layer.confirm('是否返回?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			location.href = "../rotateArrive/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
	
	audit:function(){
		var self=this;
		var status = $('select[name="status"]').val();
		//var auditStep = 1;
		var reason = "通过";
		if(!status){
			layerMsgError("请选择审核意见");
			return;
		}else if(status == "已驳回"){
			reason = $('[name="auditReason"]').val();
			if(!reason){
				layerMsgError("请填写原因");
				return;
			}
		}
		var advice = $('select[name="status"] option:selected').text();
		var postData = {
				arriveId:self.arriveId,
				advice:advice,
				reason:reason,
				status:status,
				auditStep:self.auditStep
		};
		layer.confirm('是否要继续?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			layer.load();
			 $.ajax({
					type : 'POST',
					url : '../rotateArrive/saveAudit.shtml',
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
					},
				}); 
		}, function(index) {//否
			layer.close(index);
		}); 
	}
};