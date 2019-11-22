function Add(isedit,id,invitedetail){
	this.isedit=isedit;
	this.id=id;
	this.inviteDetail=ko.observableArray(invitedetail||[]);
	this.reimport=false;//true:代表导入了excel
	this.pageindex=1;
	this.pagesize=pagesize;
	this.searchlist=ko.observableArray([]);
	this.current=ko.observable();
}

Add.prototype={
	initPage:function(){
		var self=this; 

		layui.form.on('submit(save)', function(data) {
			var postData = data.field;
			self.save(postData);
			return false;
		});
		
		$('button#cancel').click(function() {
			layer.confirm('确定要取消吗?', {
				icon : 0,
				title : '提示'
			}, function(index) {//是
				location.href = "../rotateInvite/main.shtml";
			}, function(index) {//否
				layer.close(index);
			});
		});
		self.renderExcelImport(postData);
		self.renderPage("pagination");

		layui.form.render('select', 'search');//刷新渲染表单
	},
	renderExcelImport:function(postData){
		var self=this;
		Excel_Import({
			elem:"#excel",
			url:"../rotateInvite/importExcel.shtml",
			success:function(data){//一对多easypoi导入的是List类型		
				self.inviteDetail(data[0].inviteDetails);
				$('input[name="entrustCompany"]').val(data[0].entrustCompany);
				$('input[name="entrustBid"]').val(data[0].entrustBid);
				$('input[name="entrustNum"]').val(data[0].entrustNum);
				$('input[name="exploitingEntity"]').val(data[0].exploitingEntity);
				$('input[name="totalNum"]').val(data[0].totalNum);
				$('input[name="totalCompetitivePrice"]').val(data[0].totalCompetitivePrice);
				$('input[name="totalBidPrice"]').val(data[0].totalBidPrice);
				$('input[name="totalBail"]').val(data[0].totalBail);
				self.reimport=true;
			}
		});
	},
	save:function(postData){
		if(postData.inviteType!="招标采购"&&
				(postData.entrustBid==""||postData.entrustNum=="")){
			layerMsgError("委托标的及数量不能为空");
			return;
		}
		var inviteDetail=this.inviteDetail();
		if(inviteDetail.length==0)
			layerMsgError("请导入招标结果明细");
		postData.isedit = this.isedit;
		postData.invitedetail=JSON.stringify(inviteDetail);
		postData.reimport=this.reimport;
		var currentBID=this.current();
		postData.bidId=currentBID.id;
		postData.bidType=currentBID.bidType;
		if(this.isedit)
			postData.id=this.id ;
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../rotateInvite/saveOrUpdate.shtml',
				data : postData,
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功"
							, function() {
							location.href = "../rotateInvite/main.shtml"
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

//	--------模态搜索框---------------
	init:function(object){
		object.createDate=Date_format(object.createDate,true);
	},
	renderPage:function(elemId){
		var self=this;
		$("#"+elemId).children('div').remove();
		layui.laypage.render({
			elem:elemId,
			count:self.total,
			limit:self.pagesize,

			jump:function(obj,first){
				self.pageindex=obj.curr;
				self.pagesize=obj.limit;
				self.queryPageList();

			}
		})
	},
	queryPageList:function(){
		var bidType=$('[name="bidType"]').val();
		var foodType=$('[name="foodType"]').val();
		var tenderee=$('[name="tenderee"]').val();
		var createDate=$('[name="createDate"]').val();
		var self=this;
		$.ajax({
			url:"../rotateBID/list.shtml",
			type:"POST",
			data:{
				pageIndex:self.pageindex,
				pageSize:self.pagesize,
				bidType:bidType,
				foodType:foodType,
				tenderee:tenderee,
				createDate:createDate
			},
			success:function(res){
				var list= res.result||[];
				for(var i=0;i<list.length;i++){
					self.init(list[i]);
				}
				self.searchlist(list);
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
	},
	choose:function(data){
		this.current(data);
		console.log(this.current());
	},
	confirmChoose:function(){
		$('[name="bidName"]').val(this.current().bidName);
	},
}