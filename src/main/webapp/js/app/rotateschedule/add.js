function Add(isedit,id,detailList,schedule){
	this.isedit = isedit;
	this.id= id;
	this.schedule=schedule;
	this.noticeList=ko.observableArray([]);
	if(isedit){
		for(var i =0;i<detailList.length;i++){
			this.initDetailIfEdit(detailList[i]);
		}
	}
	this.detailList=ko.observableArray(detailList||[]);
	this.dealList = ko.observableArray([]);
	
	this.selectedNoticeId =null;
	this.selectedDeal = [];
	this.pageIndex=1;
	this.pageSize=pagesize;
	this.total=0;
	this.reload=true;
}

Add.prototype={
	initDetailIfEdit:function(detail){
		detail.currentPeriod = ko.observable(detail.currentPeriod||'');
		detail.remark = ko.observable(detail.remark||'');
		detail.total=ko.computed(function(){
            //debugger
			return (Number(this.priorPeriod)+Number(this.currentPeriod())).toFixed(3);
		},detail);
		detail.compleRate=ko.computed(function(){
			//debugger
			var total=Number(this.priorPeriod)+Number(this.currentPeriod());
			//处理0.9999997时，避免显示为100%而做的处理（99.99）
            var floorPercent = Math.floor(total/this.quantity*100 * 100) / 100
			if(floorPercent == 99.99){
                return 99.99
			}else{
                return (total/this.quantity*100).toFixed(2);
			}

		},detail);
	},
	initPage:function(){
		var self=this;

		layui.form.on('submit(save)', function(data) {
			var postData = data.field;
			postData.status = $(data.elem).attr('data-status');
			self.save(postData);
			return false;
		});
		layui.form.render('select','form');
		layui.form.on('select(noticeType)',function(data){
			self.detailList([]);
			var url=null;
			if(data.value=="出库")
				url="../RotateNotif/Warehouse/Out/List.shtml";
			else if(data.value=="入库")
				url="../RotateNotif/Warehouse/In/List.shtml";
			self.getNoticeList(url);
		});
		layui.form.on('select(noticeSerial)',function(data){
			self.detailList([]);

		});

		layui.form.render('select','search');
		//编辑修改时
		if(this.isedit){
			if(this.schedule.noticeType=="出库")
				url="../RotateNotif/Warehouse/Out/List.shtml";
			else if(this.schedule.noticeType=="入库")
				url="../RotateNotif/Warehouse/In/List.shtml";
			self.getNoticeList(url);
		}
	},

	save:function(data){
		var postData = data;
		var detailList=ko.toJS(this.detailList());
		if(detailList.length==0){
			layer.msg("请添加进度明细",{icon:0});
			return;
		}
		for(var i=0;i<detailList.length;i++){
			/*if(detailList[i].currentPeriod<=0){
				layerMsgError("本期必须大于0！");
				return;
			}*/
			if(Number(detailList[i].total)>Number(detailList[i].quantity)){
				layerMsgError("累计数量已超出合同数量！");
				return;
			}
			
		}
		postData.detaillist = JSON.stringify(detailList);
		postData.noticeSerial = $('#notice dd.layui-this').text();
		postData.isedit=this.isedit;
		if(this.isedit)
			postData.id=this.id;
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../rotateSchedule/saveOrUpdate.shtml',
				data : postData,
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功"
							, function() {
							location.href = "../rotateSchedule/main.shtml"
						});
					} else {

						layerMsgError(result.msg);
					}

				},
				error : function() {
					layer.closeAll();
					layerMsgError("error:服务出错");
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
			location.href = "../rotateSchedule/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
//----------获取出入库通知书----------
	getNoticeList:function(url){
		var self=this;
		if(!url){
			self.noticeList([]);
			return;
		}
		$.ajax({
			url:url,
			type:"POST",
			data:{
				pagesize:0,
				pageindex:1,
				accepteUnit:'全部',
				status:'已完成',
			},
			success:function(res){
				self.noticeList(res.result);
				if(self.isedit){
					$('[name="noticeId"]').val(self.schedule.noticeId);
				}
				layui.form.render('select','form');
			},
			error:function(res){
				layerMsgError("出入库通知书数据获取异常");
			}
		});
		
	},
//	
//	getNotice:function(){
//		var self=this;
//		$.ajax({
//			url:'../RotateNotif/GetNotice.shtml',
//			type:"POST",
//			data:{
//				nId:$('[name="noticeSerial"]').val()
//			},
//			success:function(res){
//				self.selectedNotice=res;
//				self.dealList(res.noticeDetail);
//			},
//			error:function(res){
//				layerMsgError("ERROR:成交明细数据获取异常");
//			}
//		});
//	},

//	--------模态搜索框---------------
	renderPage:function(elemId){
		var self=this;
		$("#"+elemId).children('div').remove();
		layui.laypage.render({
			elem:elemId,
			count:self.total,
			limit:self.pageSize,

			jump:function(obj,first){
				if(!first){
					self.pageIndex=obj.curr;
					self.pageSize=obj.limit;
					self.queryPageList();
				}
			}
		})
	},
	queryPageList:function(){
		var dealSerial=$('[name="dealSerial"]').val();
		var grainType=$('[name="grainType"]').val();
		var noticeId = $('[name="noticeId"]').val();
        var bidSerial=$('[name="bidSerial"]').val();
        var storehouse=$('[name="storehouse"]').val();
		var self=this;
		$.ajax({
			url:"../rotateConclute/listDetailPageByNotice.shtml",
			type:"POST",
			data:{
				pageIndex:self.pageIndex,
				pageSize:self.pageSize,
				dealSerial:dealSerial,
				grainType:grainType,
                bidSerial:bidSerial,
                storehouse:storehouse,
				noticeId:noticeId
			},
			success:function(res){
				var list= res.result||[];
				for(var i=0;i<list.length;i++){
					list[i].checked=ko.observable(list[i].checked||false);
				}
				self.dealList(list);
				if(res.pageIndex&&res.totalCount){
					var pageReload=self.pageIndex!=res.pageIndex
					||self.total!=res.totalCount;
					self.pageIndex=res.pageIndex;
					self.pageSize=res.pageSize;
					self.total=res.totalCount;
					if(pageReload){
						self.renderPage("pagination");
					}
				}

			},
			error:function(res){
				layerMsgError("ERROR:成交明细数据获取异常");
			}
		});
	},
	clear:function () {
        $('[name="dealSerial"]').val("");
        $('[name="grainType"]').val("");
        $('[name="bidSerial"]').val("");
        $('[name="storehouse"]').val("");
        var form = layui.form;
        form.render();
    },
	getPriorPeriod:function(detail){
		var self=this;
		$.ajax({
			url:'../rotateSchedule/getPriorPeriod.shtml',
			type:'POST',
			data:{dealSerial:detail.dealSerial},
			success:function(res){
				detail.priorPeriod=res || 0;
				var detailList=self.detailList();
				var isSelected=false;
				
				for(var i=0;i<detailList.length;i++){
					if(detail.dealSerial==detailList[i].dealSerial){	
						isSelected=true;
						break;						
					}else{
						continue;
					}
				}
	
				if(isSelected){
					layerMsgError('该明细已选择，不可重复选择');
					isSelected=false;
				}else{
					detailList.push(detail);
					self.detailList(detailList);
					$('#myModal').modal('hide');
				}
			}
		});
	},
	showModal:function(){
//		$('#myModal [name="checkbox"]').attr('checked',false);
		var noticeId=$('[name="noticeId"]').val();
		if(!noticeId){
			layerMsgError('请先选择轮换类型和通知书编号');
			return;
		}

		if(!this.selectedNoticeId||this.selectedNoticeId!=noticeId){
			this.queryPageList();
			this.selectedNoticeId=noticeId;
			this.selectedDeal=[];
			if(!isedit){//非编辑要置空，编辑则保留点击“新增”时已有的列表内容
				this.detailList([]);
			}		
		}else{
			this.queryPageList();
		}
		this.selectedDeal=[];
		$('#myModal').modal('show');

	},
	hideModal:function(){
		$('#myModal').modal('hide');
	},
	choose:function(data,elem,index){
		var selectedLsit = this.selectedDeal;
		if(data.checked()){
			selectedLsit.splice(index,1);
		}else{
			selectedLsit.push(data);
		}
		this.selectedDeal=selectedLsit;
	},
	confirmChoose:function(elem){

		if($(elem).hasClass("loading")){
			return;
		}else{
			$(elem).addClass("loading");
		}
		if(this.selectedDeal==null||this.selectedDeal.length==0){
			layerMsgError('请选择成交子明细');
            $(elem).removeClass("loading");

			return;
		}
		
		
		for(var i=0;i<this.selectedDeal.length;i++){
			var scheduleDetail=this.initDetail(this.selectedDeal[i]);
			this.getPriorPeriod(scheduleDetail);
		}
		
		
		
		$(elem).removeClass("loading");
	},
	initDetail:function(deal){
		var scheduleDetail={
				storehouse:deal.storehouse||'-',
				grainType:deal.grainType,	
				deliveryUnit:deal.dealUnit,
				quantity:deal.quantity,
				priorPeriod:0,
				currentPeriod:ko.observable(''),
				remark:ko.observable(''),
				dealSerial:deal.dealSerial
			};
		scheduleDetail.total=ko.computed(function(){
			return (Number(this.priorPeriod)+Number(this.currentPeriod())).toFixed(3);
		},scheduleDetail);
		scheduleDetail.compleRate=ko.computed(function(){
			//var total=Number(this.priorPeriod)+Number(this.currentPeriod());
			//return (total/this.quantity*100).toFixed(2);
            //debugger
            var total=Number(this.priorPeriod)+Number(this.currentPeriod());
            //处理0.9999997时，避免显示为100%而做的处理（99.99）
            var floorPercent = Math.floor(total/this.quantity*100 * 100) / 100
            if(floorPercent == 99.99){
                return 99.99
            }else{
                return (total/this.quantity*100).toFixed(2);
            }
		},scheduleDetail);
		return scheduleDetail;
	},
	remove:function(index){
		var detailList=this.detailList();
		detailList.splice(index,1);
		this.detailList(detailList);
	}
}