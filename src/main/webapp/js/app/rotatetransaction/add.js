function Add(rotateConclute,clientNames){
	this.initObject(rotateConclute);
	this.rotateConclute = rotateConclute;
	this.curDetail = ko.observable();
	this.mainSchemes = ko.observableArray([]);
	this.searchlist = ko.observableArray([]);
	this.curDetail = {};
    this.customers=[];
    for(var j=0;j<customers.length;j++){
        this.customers.push({clientName:customers[j].clientName,clientId:customers[j].id});
    }
}

Add.prototype={
	initPage:function(){
		var self=this;

		layui.form.on('submit(save)', function(data) {
			self.save(data.field);
			return false;
		});
//		layui.form.on('submit(showModal)', function(data) {
//			self.showModal();
//			return false;
//		});
		layui.form.on('submit(addSubmit)', function(data) {
			$('#addModal').modal('hide');
			var postData = data.field;
			self.addDetail(postData);
			return false;
		});
//		layui.form.on('select(mainScheme)', function(data) {
//			var year = $('[name="year"]').val()
//			if(data.value&&year)
//				self.getSchemes(data.value,year);
//			return false;
//		});
        layui.form.render("select","search1");

		layui.form.render('select', 'form');//刷新渲染表单中的select
		layui.laydate.render({
			elem:$('[name="year"]')[0],
			type:'year',
			format:'yyyy',
//			done: function(value){
//				var rotateType =$('[name="inviteType"]').val();
//				if(rotateType&&value)
//					self.getSchemes(rotateType,value);
//				return false;
//			  }
			change : function (value, date, endDate) {
                $('[name="year"]').val(value);
                if($('[name="year"]').length){
                    $(".layui-laydate").remove();
				}
            }
		});
	},
	initObject:function(object){
		object.gatherDate = Date_format(object.gatherDate,true);
		object.detailList=ko.observableArray(object.detailList||[]);
	},
	renderSearchModal:function(){
		layui.form.render('select', 'form');
	},
	save:function(data){
		var postData = {};
		postData.grainType = data.grainType;
		postData.inviteType=data.inviteType;
		postData.gatherDate=data.gatherDate;
		postData.gather=data.gather;
		postData.gatherUnit=data.gatherUnit;
		var detailList = ko.toJS(this.rotateConclute.detailList);
		if(!detailList||detailList.length==0){
			layer.msg("请添加明细",{icon:0});
			return;
		}
		
		var tab=document.getElementById("detailTable");
		
		var rows=tab.rows;
		
		var lastSelect="";
		for(var i=1;i<rows.length;i++)
		 {
			lastSelect = rows[i].cells[4].innerHTML;
		 }

		if(lastSelect!=data.grainType&&lastSelect!=""){
			layerMsgError("请选择同一粮食品种!");
			return;	
		}
		
		
		
		for(var i=0;i<detailList.length;i++){
			//detailList[i].produceYear=$("#detailTable tbody tr:eq("+i+")").find('[name="produceYear"]').val();
			detailList[i].deliveryStart=$("#detailTable tbody tr:eq("+i+")").find('[name="deliveryStart"]').val();
			detailList[i].deliveryEnd=$("#detailTable tbody tr:eq("+i+")").find('[name="deliveryEnd"]').val();
			detailList[i].dealUnit=$("#detailTable tbody tr:eq("+i+")").find("[name='dealUnit'] option:selected").html();
			detailList[i].deliveryId=$("#detailTable tbody tr:eq("+i+")").find("[name='dealUnit']").val();
			detailList[i].dealAmount=$("#detailTable tbody tr:eq("+i+")").find('[name="dealAmount"]').val();
            var d1 = new Date(detailList[i].deliveryStart.replace(/\-/g, "\/"));
            var d2 = new Date(detailList[i].deliveryEnd.replace(/\-/g, "\/"));
            if(d1 >=d2)            {
                alert("明细第"+(i+1)+"行交货截止日期要大于交货起始日期");
                return false;
            }
		}

		postData.detaillist = JSON.stringify(detailList);
		console.log(postData.detaillist);
		postData.status="已分发";
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../rotateTransaction/saveOrUpdate.shtml',
				data : postData,
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功"
							, function() {
							location.href = "../rotateTransaction/main.shtml"
						});
					} else {
						layerMsgError("操作失败");
					}

				},
				error : function() {
					layer.closeAll();
					layerMsgError("ERROR:服务出错");
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
			location.href = "../rotateTransaction/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
	getSchemes:function(rotateType,year){
		var self=this;
		$.ajax({
			type : 'POST',
			url : '../RotateScheme/listScheme.shtml',
			data : {
				rotateType:rotateType,
				schemeType:'入库',
				year:year
			},
			success : function(data) {
				self.mainSchemes(data||[]);
				layui.form.render('select', 'search');
			},
			error : function() {
				layerMsgError("");
			}
		}); 
	},


//	--------模态框---------------
	showModal:function(){
		var foodType = $('[name="grainType"]').val();
		var inviteType = $('[name="inviteType"]').val();
		var year = $('[name="year"]').val();
		



		if(!foodType||!inviteType||!year){
			layerMsgError("请先选择粮食品种、采购类别及年份");
			return;
		}
		
		var tab=document.getElementById("detailTable");
		
		var rows=tab.rows;
		
		var lastSelect="";
		for(var i=1;i<rows.length;i++)
		 {
			lastSelect = rows[i].cells[4].innerHTML;
		 }

		
		if(lastSelect!=foodType&&lastSelect!=""){
			layerMsgError("请选择同一粮食品种!");
			return;	
		}
		
		
		$('#search [name="mainSchemeName"]').val("");
		$('#search [name="schemeBatch"]').val("");
		this.renderLayTable();
		$('#addModal').modal('show');
        layui.form.render("select","search");

    },
	initDetail:function(data){
        var self = this;
        var detail = {};
        detail.schemeID = data.dId;
		detail.enterpriseName=data.enterpriseName;
		detail.enterpriseId=data.enterpriseId;
		detail.receivePlace=data.libraryId;
		detail.receiveId=data.warehouseId;
		detail.storehouse=data.branNumber;
		detail.grainType=data.foodType;
		//quantity:data.rotateNumber,
		detail.quantity=ko.observable(data.rotateNumber);
		detail.produceArea=data.ogirin;
		detail.produceYear=data.yieldTime;
		detail.storageType=data.storeType;
		//produceArea:ko.observable(""),
		//produceYear:ko.observable(""),
		detail.dealPrice=ko.observable(0.00);
		//dealAmount:ko.observable(""),
		detail.dealAmount=ko.computed(function(){
			return (Number(this.dealPrice())*Number(this.quantity())).toFixed(2);
			},detail);
        detail.deliveryStart=ko.observable("");
        detail.deliveryEnd=ko.observable("");
        detail.dealUnit=ko.observable("");
        detail.deliveryId=ko.observable("");
		return detail;
		/*return {
			schemeID:data.dId,
			enterpriseName:data.enterpriseName,
			enterpriseId:data.enterpriseId,
			receivePlace:data.libraryId,
            receiveId:data.warehouseId,
			storehouse:data.branNumber,
			grainType:data.foodType,
			//quantity:data.rotateNumber,
            quantity:ko.observable(data.rotateNumber),
			produceArea:data.ogirin,
			produceYear:data.yieldTime,
			//produceArea:ko.observable(""),
			//produceYear:ko.observable(""),
			dealPrice:ko.observable(""),
			//dealAmount:ko.observable(""),
            dealAmount:ko.computed(function(){
                return (Number(this.dealPrice())*Number(this.quantity())).toFixed(2);
            },data),
			deliveryStart:ko.observable(""),
			deliveryEnd:ko.observable(""),
			dealUnit:ko.observable(""),
            deliveryId:ko.observable(""),
		};*/
		
	},
	renderLayTable:function(){
		var self=this;
		layui.table.render({
			elem:"#mainTable",
			loading:true,
			width:768,
			cols:[[
				{checkbox: true,fixed:true},
				{field:"mainSchemeName",title:"方案名称",width:180, align:'center'},
				{field:"schemeBatch",title:"子方案批号",width:100, align:'center'},
                {field:"enterpriseName",title:"企业",width:100, align:'cneter'},
                {field:"enterpriseId"},
				{field:"libraryId",title:"库点",width:100, align:'center'},
				{field:"branNumber",title:"仓号",width:100, align:'center'},
				{field:"foodType",title:"粮食品种",width:100, align:'center'},
				{field:"rotateNumber",title:"数量",width:135, align:'center'},
			]],
			url:"../RotateScheme/listDetailPagination.shtml",
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			where:{
				mainSchemeName:$('#search [name="mainSchemeName"]').val(),
				schemeBatch:$('#search [name="schemeBatch"]').val(),
				schemeType:'入库',
				rotateType:$('[name="inviteType"]').val(),
				foodType:$('[name="grainType"]').val(),
                yieldTime:$('[name="year"]').val()
			},
			page:true,//开启分页
			limit:pagesize,
			limits:[10],
			id:'myTableID',
			done:function(res,curr,count){
                $("[data-field='enterpriseId']").css('display','none');
			},
		});
		
/*		layui.table.on('tool(table)',function(obj){
			var data = obj.data; //获得当前行数据
			var layEvent = obj.event;//获得 lay-event 对应的值
			if(layEvent == 'add'){
				$('#addModal').modal('hide');
				var detail= self.initDetail(data);
				var detailList=self.rotateConclute.detailList();
				detailList.push(detail);
				self.rotateConclute.detailList(detailList);
				var index = detailList.length-1;
				var tr = $("#detailTable tbody tr:eq("+index+")");
				layui.laydate.render({
					elem:tr.find('[name="produceYear"]')[0],
					type:'year',
					format:'yyyy'		
				});
				layui.laydate.render({
					elem:tr.find('[name="deliveryStart"]')[0],
					type:'date',
					format:'yyyy-MM-dd'
				});
				layui.laydate.render({
					elem:tr.find('[name="deliveryEnd"]')[0],
					type:'date',
					format:'yyyy-MM-dd'		
				});
			}
		});*/
	},
	
	queryPageList:function(){
		layui.table.reload("myTableID",{
			method:"POST",
			where:{
				mainSchemeName:$('#search [name="mainSchemeName"]').val(),
				schemeBatch:$('#search [name="schemeBatch"]').val(),
                warehouseType:$("#search [name=warehouseType]").val(),
                libraryId:$("#search [name='libraryId']").val(),
                branNumber:$("#search [name='branNumber']").val(),

				schemeType:'入库',
				rotateType:$('[name="inviteType"]').val(),
               /* warehouseType:$('[name="warehouseType"]').val(),
                libraryId:$('[name="libraryId"]').val(),
                branNumber:$('[name="branNumber"]').val(),*/
                yieldTime:$('[name="year"]').val(),
                foodType:$('[name="grainType"]').val(),
                branNumber:$('[name="branNumber"]').val(),

			}
		});
	},
	clear:function () {
        $('#search [name="mainSchemeName"]').val("");
        $('#search [name="schemeBatch"]').val("");
        $('[name="warehouseType"]').val("");
        $('[name="libraryId"]').val("");
        $('[name="branNumber"]').val("");

        var form = layui.form;
        form.render();
    },
	removeDetail:function(data,dataIndex){
		layer.confirm("确定要删除改明细?",function(index){
			var detailList = rotateConclute.detailList();
			detailList.splice(dataIndex,1);
			rotateConclute.detailList(detailList);
			layer.close(index);
		},function(){
			layer.clsoe(index);
		})
	},
	
	selectConfirm:function(){
		var selectList = layui.table.checkStatus("myTableID").data;

		if(null==selectList||selectList.length==0){
			layerMsgError("请勾选数据信息");
			return;
		}
		var detailList = this.rotateConclute.detailList();
		for(var i=0;i<selectList.length;i++){
			var detail=this.initDetail(selectList[i]);
			detailList.push(detail);
		}	
		this.rotateConclute.detailList(detailList);
		
		var index = detailList.length-1;
		var tr = $("#detailTable tbody tr:eq("+index+")");
		/*$('#detailTable tbody tr [name="produceYear"]').each(function(){
			layui.laydate.render({
				elem:$(this)[0],
				type:'year',
				format:'yyyy'		
			});
		});*/
		
		$('#detailTable tbody tr [name="deliveryStart"]').each(function(){
			layui.laydate.render({
				elem:$(this)[0],
				type:'date',
				format:'yyyy-MM-dd'		
			});
		});
		
		$('#detailTable tbody tr [name="deliveryEnd"]').each(function(){
			layui.laydate.render({
				elem:$(this)[0],
				type:'date',
				format:'yyyy-MM-dd'	
			});
		});
		
		$('#addModal').modal('hide');
		layui.form.render("select");
//		this.hideModal('addModal','myTableID')
	},
	hideModal:function(modal,tableId){
		layui.table.reload(tableId);
		$('#'+modal).modal('hide');
		
	},
}