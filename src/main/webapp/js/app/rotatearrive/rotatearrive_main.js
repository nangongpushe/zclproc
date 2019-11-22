function RotateArrive_Main(){
	this.list=ko.observableArray([]);
	this.total=0;
	this.pagesize=pagesize;
	this.pageindex=1;
	this.firstLoadClaim=true;
}

RotateArrive_Main.prototype={
	initPage:function(){
		var self=this;
		layui.laydate.render({
				elem : $('[name="arriveDate"]')[0],
				type : "date",
				format : "yyyy-MM-dd hh:mm"
		});
        layui.laydate.render({
            elem : $('[name="beginArriveDate"]')[0],
            type : "date",
            format : "yyyy-MM-dd"
        });
        layui.laydate.render({
            elem : $('[name="endArriveDate"]')[0],
            type : "date",
            format : "yyyy-MM-dd"
        });
		layui.form.render("select","search");
		/*self.queryPageList();
		self.renderPage("pagination");*/
		this.renderTable();
	},
	
	init:function(object){
		object.arriveDate=Date_format(object.arriveDate,true);
		object.modifyDate=Date_format(object.modifyDate,true);
		object.reportDate=Date_format(object.reportDate,true);
		object.status=ko.observable(object.status);
	},
	
/*	renderPage:function(elemId){
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
		var arriveDate=$('input[name="arrivedate"]').val();
		var status=$('select[name="status"]').val();
		var claimStatus=$('select[name="claimStatus"]').val();
		var self=this;
		$.ajax({
			url:"../rotateArrive/listPagination.shtml",
			method:"GET",
			data:{
				pageIndex:self.pageindex,
				pageSize:self.pagesize,
				arriveDate:arriveDate,
				status:status,
				claimStatus:claimStatus
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
	},*/
	
	add:function(){
			location.href="../rotateArrive/add.shtml";	
	},
	audit:function(data) {	
		location.href="../rotateArrive/audit.shtml?sid="+data.id;
	},
	show:function(data) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var url = "../rotateArrive/view.shtml";
		$.post(url, {sid:data.id}, function(str) {
			layer.open({
				type : 1,
				title:"详情",
				content : str,
				area:[width, height]
			});
		});
	},
	showClaimOfArrive:function(elem) {
		var width=$('.container-box').innerWidth()-300;
		var url = "../rotateClaim/view_claimofarrive.shtml";
		$.post(url, {arriveId:$(elem).attr("data-id")}, function(str) {
			layer.open({
				type : 1,
				title:"认领情况",
				content : str,
				area:[width,'400px']
			});
		});
	},
	showAuditHistory:function(elem) {
		var width=$('.container-box').innerWidth()-300;
		var url = "../rotateArrive/auditHistory.shtml";
		$.post(url, {arriveId:$(elem).attr("data-id")}, function(str) {
			layer.open({
				type : 1,
				title:"审核记录",
				content : str,
				area:[width,'400px']
			});
		});
	},
	edit:function(data){
		location.href = "../rotateArrive/edit.shtml?sid="+ data.id;
	},
	submit:function(obj,data,status,tip){
		var self=this;
		layer.confirm('确定要继续'+tip+'吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			layer.load();
			$.ajax({
				url:"../rotateArrive/updateStatus.shtml",
				type:"POST",
				data:{
					'id':data.id,
					'status':status
				},
				success:function(result){
					 if(result.success){
						// obj.update({
						// 	status:status
						// });
						layerMsgSuccess("操作成功",function(){self.reloadTable();});
					}
				},
				complete:function(){
					layer.closeAll('loading');
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});
	},
	remove:function(data){
		var self=this;
		layer.confirm('确定要删除吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			layer.load();
			$.ajax({
				url:"../rotateArrive/remove.shtml",
				type:"POST",
				data:{
					'sid':data.id
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功");
						self.renderTable();
					}
				},
				complete:function(){
					layer.closeAll('loading');
				}
			});
			layer.close(index);
		}, function(index) {//否
			layer.close(index);
		});
	},
	
	renderTable:function(){
		var self=this;
		var width=($('.container-box').innerWidth()-260)/8+1;
		layui.table.render({
			elem:"#myTable",
			loading:true,
			url:'../rotateArrive/listPagination.shtml',
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
//			width:1070,
			cols:[[
				//{field:'arriveDate',title:'收款日期',width:width,align:'center',fixed:true,templet: '#arriveDateFormat'},//120
				{field:'arriveDate',title:'收款日期',width:width,align:'center',fixed:true,templet:'<div>{{ Format(d.arriveDate,"yyyy-MM-dd hh:mm")}}</div>'},
                //{field: 'arriveDate', title: '付款日期', width:width,align:'center',templet: "<div>{{layui.util.toDateString(d.arriveDate, 'yyyy-MM')}}</div>"},
                {field:'payer',title:'付款人',width:width,align:'center'},//100
                {field:'payUnit',title:'付款单位',width:width,align:'center'},
				{field:'status',title:'状态',width:width, align:'center',templet: '#auditHistory'},//120
				{field:'claimStatus',title:'货款状态',width:width,align:'center',templet: '#claimOfArrive'},//100
				{field:'reportDate',title:'填报时间',width:width, align:'center',templet: '<div>{{ Format(d.reportDate,"yyyy-MM-dd hh:mm")}}</div>'},//120
                {field:'approvalDate',title:'审批通过时间',width:width,align:'center',templet:'<div>{{ Format(d.approvalDate,"yyyy-MM-dd hh:mm")}}</div>'},
				{field:'reporter',title:'填报人',width:width-10, align:'center',},//100
				{field:'arriveAmount',title:'金额(元)',width:width, align:'center',},//100
				{field:'balance',title:'未认领金额(元)',width:width, align:'center',},//100
				{fixed: 'right',title:'操作', width:220, align:'center', toolbar: '#barDemo'}//200

			]],
			page:true,//开启分页
			limit:pagesize,
			id:"myTable",
			done: function(res, curr, count){
				$('#myTable').next().find('.claimOfArrive').click(function(){
					self.showClaimOfArrive(this);
				});
				$('#myTable').next().find('.auditHistory').click(function(){
					self.showAuditHistory(this);
				});
			}
		});
		
		layui.table.on('tool(table)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='edit'){
				self.edit(data);
			}else if(layEvent=='remove'){
				self.remove(data);
			}else if(layEvent=='submit'){
				self.submit(obj,data,'审核中(财务经理)','提交');
			}else if(layEvent=='viewClaim'){
				self.showClaimOfArrive(data);
			}else if(layEvent=='audit'){
				self.audit(data);
			}else if(layEvent=='view'){
				self.show(data);
			}
		});
	},
	
	reloadTable:function(){
        /**
		 * 进行数据校验
         */
         var beginArriveDate = $('input[name="beginArriveDate"]').val();
        var endArriveDate = $('input[name="endArriveDate"]').val();
		var minArriveAmount = $('input[name="minArriveAmount"]').val();
		var maxArriveAmount = $('input[name="maxArriveAmount"]').val();
		var minBalance = $('input[name="minBalance"]').val();
		var maxBalance = $('input[name="maxBalance"]').val();

        var oDate1 = new Date(beginArriveDate);
        var oDate2 = new Date(endArriveDate);
		if(oDate1>oDate2){
            layerMsgError("收款日期有误");
            return;
		}
		if(minArriveAmount!=null && maxArriveAmount!=null && parseInt(minArriveAmount)>parseInt(maxArriveAmount)){
			layerMsgError("金额输入有误");
			return;
		}
		if(minBalance!=null&&maxBalance!=null&parseInt(minBalance)>parseInt(maxBalance)){
            layerMsgError("未认领金额输入有误");
            return;
		}


        if(oDate1.getTime() > oDate2.getTime()){
            console.log('第一个大');
        } else {
            console.log('第二个大');
        }
		layui.table.reload("myTable",{
			method:"POST",
			where:{
				beginArriveDate:beginArriveDate,
                endArriveDate:endArriveDate,
				status:$('select[name="status"]').val(),
				claimStatus:$('select[name="claimStatus"]').val(),
                payUnit:$('input[name="payUnit"]').val(),	// 收款单位
				payer:$("input[name='payer']").val(),
                // reporter:$('input[name="reporter"]').val(),	// 填报单位
                minArriveAmount:minArriveAmount,	//最小金额
                maxArriveAmount:maxArriveAmount,	//最大金额
                minBalance:minBalance,	// 最小余额
                maxBalance:maxBalance,	// 最大余额
			}
		});
	},
	

	renderTable1:function(arriveId){
		layui.table.render({
			elem:"#myTable1",
			loading:true,
			url:'../rotateClaim/listClaimOfArrive.shtml',
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			where:{
				arriveId:arriveId
			},
			width:740,
			cols:[[
				{field:'dealSerial',title:'成交子明细号',width:120,align:'center'},
				{field:'claimMan',title:'认领人',width:100,align:'center'},
				{field:'claimDate',title:'认领时间',width:120, align:'center',templet: '#claimDateFormat'},
				{field:'claimType',title:'认领类型',width:100,align:'center'},
				{field:'claimAmount',title:'认领金额',width:100, align:'center',},
				
			]],
			page:true,//开启分页
			limit:15,
			limits:[10],
			id:"myTable1"	
		});
	},
	
	reloadTable1:function(){
		layui.table.reload("myTable1",{
			method:"POST",
			where:{
				warehouse:$('#search1 [name="warehouse"]').val(),
				type:$('#search1 [name="type"]').val(),
				status:$('#search1 [name="status"]').val(),
				minCapacity:$('#search1 [name="minCapacity"]').val(),
				maxCapacity:$('#search1 [name="maxCapacity"]').val(),
			}
		});
	},
};