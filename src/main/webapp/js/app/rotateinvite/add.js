function Add(isedit,id,inviteSerial,invitedetail,current){
	this.isedit=isedit;
	this.id=id;
	this.inviteSerial=inviteSerial;
	this.inviteDetail=ko.observableArray(invitedetail||[]);
	this.reimport=false;//true:代表导入了excel
	this.pageindex=1;
	this.pagesize=pagesize;
	this.searchlist=ko.observableArray([]);
	this.current=ko.observable(current||{});
//	this.errorMsg = ko.observable('');
	this.inviteType="";
}

Add.prototype={
	initPage:function(){
		var self=this;

		layui.form.on('submit(save)', function(data) {
			// debugger
			//将按键设置为不可用
			$("button[lay-filter=\"save\"]").attr("disabled",true);

			var postData = data.field;
			postData.isgather = $(data.elem).attr('data-gather');
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
		self.renderExcelImport();
//		self.renderPage("pagination");
//		self.queryPageList();
		layui.form.on('select(inviteType)',function(data){
			if(self.inviteType!=data.value){
				$('[name="bidName"]').val("");
				self.inviteType=data.value;
			}
			
		});

		layui.form.render('select', 'search');//刷新渲染表单
		layui.laydate.render({
			elem : $('[name="createDate"]')[0],
			type : "date",
			format : "yyyy-MM-dd",
		});
	},
	renderExcelImport:function(){
		var self=this;
		Excel_Import({
			elem:"#excel",
			url:"../rotateInvite/importExcel.shtml",
			success:function(data){//一对多easypoi导入的是List类型
				 debugger
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
            $("button[lay-filter=\"save\"]").attr("disabled",false);
			return;
		}

        var inviteDetail=this.inviteDetail();
        if(inviteDetail.length==0) {
            layerMsgError("请导入招标结果明细");
            $("button[lay-filter=\"save\"]").attr("disabled",false);
        	return;
        }
		var   isbidSerialNull=""

		for(var i=0;i<inviteDetail.length;i++){
            if(inviteDetail[i].bidSerial==""||inviteDetail[i].bidSerial==null){
                isbidSerialNull="1"
            }
		}
		if(isbidSerialNull=="1"){
            layerMsgError("标段不能为空");
            $("button[lay-filter=\"save\"]").attr("disabled",false);
            return;
		}
		/*var  temp;
        for(var i=0;i<inviteDetail.length;i++){
        	if(i==0){
        		temp=inviteDetail[i].bidSerial;
			}else {
        		if(temp!=inviteDetail[i].bidSerial){
                    isbidSerialNull=2;
				}
			}

        }
        if(isbidSerialNull=="2"){
            layerMsgError("标段必须一致");
            $("button[lay-filter=\"save\"]").attr("disabled",false);
            return;
        }*/
        // debugger
        if($("#msg").val()!=""){
        	layerMsgError($("#msg").val());
            $("button[lay-filter=\"save\"]").attr("disabled",false);
        	return;
		}

		postData.isedit = this.isedit;
		postData.invitedetail=JSON.stringify(inviteDetail);
		postData.reimport=this.reimport;
		var currentBID=this.current();
		postData.bidId=currentBID.id;
		postData.bidType=currentBID.bidType;

		if(this.isedit){
			postData.id=this.id;
			postData.inviteSerial = this.inviteSerial;
		}

		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../rotateInvite/saveOrUpdate.shtml',
				data : postData,
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功", function() {
							location.href = "../rotateInvite/main.shtml"
						});
					} else {
                        // 将提交保存按钮设置成可用
                        $("button[lay-filter=\"save\"]").removeAttr("disabled");
						layerMsgError(result.msg);
                        $("button[lay-filter=\"save\"]").attr("disabled",false);
					}

				},
				error : function(result) {
					// 将提交保存按钮设置成可用
                    $("button[lay-filter=\"save\"]").removeAttr("disabled");

					layer.closeAll();
					layerMsgError(result.msg);
                    $("button[lay-filter=\"save\"]").attr("disabled",false);
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
				if(!first){
					self.pageindex=obj.curr;
					self.pagesize=obj.limit;
					self.queryPageList();
				}
			}
		})
	},
	queryPageList:function(){
		var self=this;
		var bidType=$('[name="inviteType"]').val();
		var foodType=$('[name="foodType"]').val();
		var createDate=$('[name="createDate"]').val();
		var name=$('[name="tenderee"]').val();
		var postData={
				pageIndex:self.pageindex,
				pageSize:self.pagesize,
				bidType:bidType,
				foodType:foodType,
				createDate:createDate
			};
		if(this.inviteType=="招标采购")
			postData.tenderee=name;
		else
			postData.saler=name;
		
		$.ajax({
			url:"../rotateBID/list.shtml",
			type:"POST",
			data:postData,
			success:function(res){
				var list= res.result||[];
//				if(list.length==0)
//					self.errorMsg('未找到类型为"'+bidType+'"的标的');
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
	clear:function () {
        $('[name="tenderee"]').val("");
        $('[name="foodType"]').val("");
        $('[name="createDate"]').val("");
        var form = layui.form;
        form.render();
    },
	choose:function(data){
		// debugger;
		this.current(data);
	},
	confirmChoose:function(){
		$('[name="bidName"]').val(this.current().bidName);
	},
	showModal:function(){
		var bidType=$('[name="inviteType"]').val();
		if(!bidType){
			layerMsgError("请先选择招标结果类别");
			return;
		}
		$('[name="foodType"]').val('');
		$('[name="tenderee"]').val('');
		$('[name="createDate"]').val('');
		layui.form.render('select','search');
		this.queryPageList();
		$('#myModal').modal('show');
	}
}