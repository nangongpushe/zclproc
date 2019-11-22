
function Add(rotateArrive,rotateClaim){
	this.rotateArrive=rotateArrive;
	this.rotateClaim=rotateClaim;
	
	this.originDealSerial = null;
	this.selectDealSerial = null;
	this.warehouseAndEncode = null;
	this.currentDealSerial=null;
	this.selectDealAmount=0;
	this.processDetails = ko.observableArray([]);
	this.claimType = null;
	this.dealPrice = ko.observable("");
	this.claimAmount = ko.observable();
	this.claimWeight = ko.computed(function () {
		if(!this.dealPrice()||!this.claimAmount()||!this.claimType||this.claimType!="货款"){
			return "";
		}
		return (Number(this.claimAmount())/Number(this.dealPrice())).toFixed(0);
	},this)
	this.firstShowModal=true;
	this.list=ko.observableArray([]);
	
	this.pageindex=1;
	this.pagesize=pagesize;
	this.total=0;
}

Add.prototype={

	initPage:function(){
		var self=this; 

		//表单提交
		layui.form.on('submit(save)', function(data) {
			var postData = data.field;
			postData.arriveId=self.rotateClaim.arriveId;
			self.save(postData);
			return false;
		});
		
		layui.laydate.render({
			elem : $('#search [name="dealDate"]')[0],
			type : "date",
			format : "yyyy-MM-dd",
		});
		
		layui.form.render("select", 'form');//刷新渲染表单
		layui.form.render("select", 'search');
		//选择认领类型,获取认领额度
		layui.form.on('select(claimType)',function(data){
			$('#form1 #dealItem').removeClass("has-error");
			if(!self.currentDealSerial){
				layerMsgError("请先选择交易明细");
				$('#form1 #dealItem').addClass("has-error");
				return;
			}
			var elem = $(data.elem);
			self.claimType=data.value;
			self.reloadTable();
			self.getClaimBound();
		});
		self.renderTable();
	},
/*	initProcess:function(process){
		var self=this;
		return {
			arriveId:self.rotateArrive.id,
			dealSerial:self.currentDealSerial,
			claimAmount:ko.observable(),
			claimType:process.Type,
		};
	},*/
	//根据dealSerial claimType查询已认领金额
	getClaimBound:function(){
		var self =this;
		 $.ajax({
				type : 'GET',
				url : '../rotateClaim/getTotalAmount.shtml',
				cache:false,
			 	async:false,
				data : {
					dealSerial:self.currentDealSerial,
					claimType:self.claimType,
                    arriveId:""
					// arriveId:self.rotateArrive.id
				},
				success : function(result) {
					if(result.success){
						if(self.claimType == "货款"){
							self.rotateClaim.claimBound=self.selectDealAmount>result.data?self.selectDealAmount-result.data:0;
						}else{
							var processDetails=self.processDetails();
							var processDetailCount = 0;
							for(var i =0;i<processDetails.length;i++){
								if(processDetails[i].type == self.claimType){
									//var processBalance = processDetails[i].amount-result.data;
                                    processDetailCount = self.accAdd(processDetailCount,processDetails[i].amount);
								}else{
									continue;
								}
							}
                            var processBalance = self.accSub(processDetailCount,result.data);
                            self.rotateClaim.claimBound= processBalance>0?processBalance:0;
						}
						$('#form1 [name="claimBound"]').val(self.rotateClaim.claimBound);
					}
				},
				error : function() {
					layer.closeAll();
					layerMsgError("error");
				}
			}); 
	},
	//获取dealSerial对应的商务处理明细类型
	getProcessDetails:function(){
		var self =this;
		 $.ajax({
				type : 'GET',
				url : '../RotateProcess/GetRotateProcessByDealSerial.shtml',
				cache:false,
				data : {
					dealSerial:self.currentDealSerial
				},
				success : function(result) {
					if(result.success){
						if(!result.data)
							self.processDetails([]);
						else
							self.processDetails(result.data);
						layui.form.render('select','form');
					}
				},
				error : function() {
					layer.closeAll();
					layerMsgError("error");
				}
			}); 
	},

	checkAmount:function(elem){
		var reg = /^\d+\.?(\d{1,2})?$/;
		var value=$(elem).val();
		if(!reg.test(value))
			$(elem).val(value.substring(0,value.length-1));
	},
    checkQuantity:function(elem){
        var reg = /^\d+\.?(\d{1,3})?$/;
        var value=$(elem).val();
        if(!reg.test(value))
            $(elem).val(value.substring(0,value.length-1));
    },

	save:function(postData){
		var self = this;
		layer.confirm('确定认领?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			self.saveSingle(postData);
		}, function(index) {//否
			layer.close(index);
		}); 
	},
	
	saveSingle:function(postData){
		var self=this;
		var claimBound = Number(postData.claimBound);
		if(isNaN(postData.claimAmount)|| postData.claimAmount<=0){
			layer.msg("认领金额需大于0!",{icon:0});
			return false;
		}else if(postData.claimAmount>claimBound){
			layer.msg("认领金额已超出认领额度!",{icon:0});
			return false;
		}else if(postData.claimAmount>self.rotateArrive.balance){
			layer.msg("货款余额不足!",{icon:0});
			return false;
		}
		//校验认领数量，待办

		postData.claimType= self.claimType;
		postData.arriveId = self.rotateArrive.id;
		layer.load();
		$.ajax({
			type : 'POST',
			url : '../rotateClaim/saveOrUpdate.shtml',
			data : postData,
			success : function(result) {
				if (result.success) {
					layerMsgSuccess("操作成功");
					location.reload();
				} else {
					layerMsgError("操作失败");
				}

			},
			error : function() {
				layer.closeAll();
				layerMsgError("ERROR:服务错误!");
			},
			complete:function(){
				layer.closeAll('loading');
			}
		}); 
	},

	
	cancel:function(){
		location.href='../rotateClaim/main.shtml'
	},
	//---------模态框------------
	init:function(object){
		object.dealDate=Date_format(object.dealDate,true);
		object.gatherDate=Date_format(object.gatherDate,true);
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
		var dealSerial=$('#search input[name="dealSerial"]').val();
		var dealUnit=$('#search select[name="dealUnit"]').val();
		var dealDate=$('#search [name="dealDate"]').val();
		var self=this;
		$.ajax({
			url:"../rotateConclute/listDetailPagination1.shtml",
			type:"POST",
			data:{
				pageIndex:self.pageindex,
				pageSize:self.pagesize,
				dealSerial:dealSerial,
				dealUnit:self.rotateArrive.payUnit,
				dealDate:dealDate,
			},
			success:function(res){
				var list= res.result||[];
				for(var i=0;i<list.length;i++){
					self.init(list[i]);
				}
				self.list(list);
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
	
	showModal:function(){
		if(this.firstShowModal){
			this.queryPageList();
			this.firstShowModal=false;
		}
			
		$('#myModal').modal('show');
	},

	choose:function(data){
		this.selectDealSerial=data.dealSerial;
		this.selectDealAmount=data.dealAmount;
		this.quantity = data.quantity;
		this.dealPrice(data.dealPrice);
		this.warehouseAndEncode=(data.deliveryPlace?data.deliveryPlace:"") + (data.storehouse?data.storehouse:"");
	},
	confirmChoose:function(){
		this.originDeailSerial = this.currentDealSerial;
		this.currentDealSerial=this.selectDealSerial;
		this.warehouseAndEncode=this.warehouseAndEncode;
//		this.selectDeal=null;
		$('[name="dealSerial"]').val(this.currentDealSerial);
        $('[name="warehouseAndEncode"]').val(this.warehouseAndEncode);
        $('[name="quantity"]').html(this.quantity);
		this.claimType=null;
		$('[name="claimType"]').val('');
		$('#form1 [name="claimBound"]').val('');
		layui.form.render("select", 'form');
		$('#myModal').modal('hide');
		this.getProcessDetails();
	},
	hideModal:function(){
//		$('#search [name="grainType"]').val("");
//		$('#search [name="inviteType"]').val("");
//		$('#search [name="dealDate"]').val("");
		$('#myModal').modal('hide');
	},
	//----------认领历史---------------
	renderTable:function(){
		var self=this;
		var width=($('.container-box').innerWidth()-55)/5+2;
		layui.table.render({
			elem:"#myTable",
			loading:true,
			url:'../rotateClaim/listPagination.shtml',
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			where:{
				arriveId:self.rotateArrive.id
			},
			cols:[[
				{field:'claimType',title:'认领类型',width:width,align:'center'},
				{field:'claimAmount',title:'认领金额(元)',width:width,align:'center'},
                {field:'warehouseAndEncode',title:'认领库点及仓号',width:width,align:'center'},
                {field:'claimWeight',title:'认领吨数',width:width,align:'center'},
				{field:'claimMan',title:'认领人',width:width, align:'center'},
				{field:'dealSerial',title:'所属成交子明细号',width:width, align:'center'},
				//{field:'claimDate',title:'认领时间',width:width, align:'center',templet:'#claimDateFormat'},
				{field:'claimDate',title:'认领时间',width:width,align:'center',templet:'<div>{{ Format(d.claimDate,"yyyy-MM-dd hh:mm")}}</div>'},
				{fixed: 'right',title:'操作', width:width, align:'center', toolbar: '#barDemo'}
			]],
			page:true,//开启分页
			limit:pagesize,
			limits:[10],
			id:"myTable"	
		});
		
		layui.table.on('tool(table)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='delete'){
				self.remove(data);
			}
		});
	},
	
	reloadTable:function(){
		var self=this;
		layui.table.reload("myTable",{
			method:"POST",
			where:{
				claimType:self.claimType,
				dealSerial:self.dealSerial,
				arriveId:self.rotateArrive.id
			},
		});
	},
	remove:function(data){
		data.claimDate = Date_format(data.claimDate,true);
		var self=this;
		layer.confirm('确定要退款吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			 $.ajax({
					type : 'POST',
					url : '../rotateClaim/remove.shtml',
					data : JSON.stringify(data),
				 	contentType: "application/json",
					success : function(result) {
						if (result.success) {
							layerMsgSuccess("操作成功"
								, function() {
								location.reload();
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
		}, function(index) {//否
			layer.close(index);
		});
	},
    accSub:function(arg1, arg2) {
		var r1, r2, m, n;
		try {
			r1 = arg1.toString().split(".")[1].length;
		}
		catch (e) {
			r1 = 0;
		}
		try {
			r2 = arg2.toString().split(".")[1].length;
		}
		catch (e) {
			r2 = 0;
		}
		m = Math.pow(10, Math.max(r1, r2)); //last modify by deeka //动态控制精度长度
		n = (r1 >= r2) ? r1 : r2;
		return ((arg1 * m - arg2 * m) / m).toFixed(n);
	},
    /**
     ** 加法函数，用来得到精确的加法结果
     ** 说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
     ** 调用：accAdd(arg1,arg2)
     ** 返回值：arg1加上arg2的精确结果
     **/
    accAdd:function (arg1, arg2) {
    var r1, r2, m, c;
    try {
        r1 = arg1.toString().split(".")[1].length;
    }
    catch (e) {
        r1 = 0;
    }
    try {
        r2 = arg2.toString().split(".")[1].length;
    }
    catch (e) {
        r2 = 0;
    }
    c = Math.abs(r1 - r2);
    m = Math.pow(10, Math.max(r1, r2));
    if (c > 0) {
        var cm = Math.pow(10, c);
        if (r1 > r2) {
            arg1 = Number(arg1.toString().replace(".", ""));
            arg2 = Number(arg2.toString().replace(".", "")) * cm;
        } else {
            arg1 = Number(arg1.toString().replace(".", "")) * cm;
            arg2 = Number(arg2.toString().replace(".", ""));
        }
    } else {
        arg1 = Number(arg1.toString().replace(".", ""));
        arg2 = Number(arg2.toString().replace(".", ""));
    }
    return (arg1 + arg2) / m;
}
}