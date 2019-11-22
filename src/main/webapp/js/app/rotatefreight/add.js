function Add(isedit,id,freightDetails,shipTypes){
	this.isedit=isedit;
	this.id=id;
	if(isedit){
		for(var i=0;i<freightDetails.length;i++){
			this.initFreightDetail(freightDetails[i]);
		}
	}
	this.freightDetails = ko.observableArray(freightDetails||[]);
	this.shipTypes=[];
	for(var j=0;j<shipTypes.length;j++){
		this.shipTypes.push(shipTypes[j].value);
	}
}

Add.prototype={

	initFreightDetail:function(freightDetail){
		freightDetail.tenders = ko.observable(freightDetail.tenders||'');
		freightDetail.shipType = ko.observable(freightDetail.shipType||'');
		freightDetail.deliveryAddress = ko.observable(freightDetail.deliveryAddress||'');
		freightDetail.receiveAddress = ko.observable(freightDetail.receiveAddress||'');
		freightDetail.distance = ko.observable(freightDetail.distance||'');
		freightDetail.groupId = ko.observable(freightDetail.groupId||'');
		freightDetail.remark = ko.observable(freightDetail.remark||'');
		freightDetail.fileName = ko.observable(freightDetail.fileName||'');
	},
	initPage:function(){
		var self=this; 

		layui.form.on('submit(save)', function(data) {
			var postData = data.field;
			postData.status = $(data.elem).attr('data-status');
			self.save(postData);
			return false;
		});
        var laydate = layui.laydate;
        var endDate= laydate.render({
            elem: '#inviteEndTime',//选择器结束时间
            type: 'date',
            min:"1970-1-1",//设置min默认最小值
            done: function(value,date){
                startDate.config.max={
                    year:date.year,
                    month:date.month-1,//关键
                    date: date.date,
                    hours: 0,
                    minutes: 0,
                    seconds : 0
                }
            }
        });
        //日期范围
        var startDate=laydate.render({
            elem: '#inviteTime',
            type: 'date',
            max:"2099-12-31",//设置一个默认最大值
            done: function(value, date){
                endDate.config.min ={
                    year:date.year,
                    month:date.month-1, //关键
                    date: date.date,
                    hours: 0,
                    minutes: 0,
                    seconds : 0
                };
            }
        });

        /*layui.laydate.render({
            elem : $('[name="inviteTime"]')[0],
            type : "date",
            format : "yyyy-MM-dd",
        });
        layui.laydate.render({
            elem : $('[name="inviteEndTime"]')[0],
            type : "date",
            format : "yyyy-MM-dd",
        });*/


		if(this.isedit){
			for(var i=0;i<this.freightDetails().length;i++)
				this.initUploadOfDetail(i);
		}
		layui.form.render('select', 'search2');
		this.renderTable1();
	},

	save:function(postData){
		var freightDetails = ko.toJS(this.freightDetails);
		if(null==freightDetails||freightDetails.length==0){
			layer.msg('请添加运费明细',{icon:0});
			return;
		}
        for(var i=0;i<freightDetails.length;i++){
          var  value=freightDetails[i].distance;
            if(value.length!=0){
                if(!(/^\d+(\.\d+)?$/.test(value))){
                    layer.msg('距离只能输入大于0的数',{icon:0});
                    return ;
                }
            }
        }
		postData.freightDetailsStr=JSON.stringify(freightDetails);
		postData.isedit=this.isedit;
		if(isedit)
			postData.id=this.id;
		layer.load();
		 $.ajax({
			type : 'POST',
			url:'../rotateFreight/saveOrUpdate.shtml',
			data : postData,
			success : function(result) {
				if (result.success) {
					layerMsgSuccess("操作成功"
						, function() {
						location.href = "../rotateFreight/main.shtml"
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
	cancel:function(){
		layer.confirm('确定要取消吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			location.href = "../rotateFreight/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
	remove:function(index){
		var detailList=this.freightDetails();
		detailList.splice(index,1);
		this.freightDetails(detailList);
	},
    deleteFileForDetail:function(index){
        var self=this;
        self.freightDetails()[index].groupId("");
        self.freightDetails()[index].fileName("");
    },
    deleteFile:function(){
		$('#uploadFile').html('<i class="layui-icon"></i>上传');
        $('#deleteFile').hide();
        $("input#fileId").val('');
        $("#afileName a").html("");
        $("#delFileBtn").hide();
        $("#openExce a").html("");
    },

//	--------模态搜索框---------------
	showModal:function(){	
		$('#myModal').modal('show');
	},
	
	hideModal:function(){
		this.reloadTable1();
		$('#myModal').modal('hide');
	},
	
	toFreightDetail:function(deal){
		return {
			tenders:'',
			dealSerial:deal.dealSerial,
			shipType:'',
			deliveryAddress:'',
			receiveAddress:'',
			distance:0,
			planNumber:deal.quantity,
			groupId:'',
			remark:'',
			inviteType:deal.inviteType
		}
	},
	
	confirm:function(){
		var selectList = layui.table.checkStatus('myTable1').data;

		if(null==selectList||selectList.length==0){
			layerMsgError("请勾选数据");
			return;
		}
		
		var detailList = this.freightDetails();
		for(var i=0;i<selectList.length;i++){
			var detail=this.toFreightDetail(selectList[i]);
			this.initFreightDetail(detail);
			detailList.push(detail);
		}
		this.freightDetails(detailList);
		for(var i=0;i<this.freightDetails().length;i++)
			this.initUploadOfDetail(i);
		this.hideModal();
	},

	initUploadOfDetail:function(index){
    	debugger;
		var self=this;
		layui.upload.render({
			elem:'#uploadFileForDetail'+index,
			url:'../sysFile/uploadFile.shtml',
			accept:'file',
			done : function(res) {
				if (res.code == 0) {
					self.freightDetails()[index].groupId(res.data.fileId);
					self.freightDetails()[index].fileName(res.data.fileName);
					layer.msg(res.msg, {
						icon : 1
					});
				} else {
					layer.msg(res.msg, {
						icon : 2
					});
				}
			},
			error : function(res) {
				layer.msg(res, {
					icon : 2
				});
			}
		});
	},
	
	renderTable1:function(){

		layui.table.render({
			elem:"#myTable1",
			loading:true,
			url:'../rotateConclute/listDetailByJoin.shtml',
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			width:850,
			cols:[[
				{checkbox: true,fixed:true} ,
				{field:'dealSerial',title:'成交子明细号',width:200,align:'center'},
				{field:'inviteType',title:'轮换类型',width:110,align:'center'},
				{field:'grainType',title:'粮食品种',width:110, align:'center'},
				{field:'quantity',title:'数量(吨)',width:150,align:'center'},
				{field:'dealUnit',title:'成交单位',width:140,align:'center'},
				{field:'dealDate',title:'成交时间',width:140,align:'center'}
			]],
			page:true,//开启分页
			limit:pagesize,
			limits:[10],
			id:"myTable1"	
		});
	},
	
	reloadTable1:function(){
		layui.table.reload("myTable1",{
			method:"POST",
			where:{
				dealSerial:$('#search2 [name="dealSerial"]').val(),
                inviteType:$('#search2 [name="inviteType"]').val(),
                grainType:$('#search2 [name="grainType"]').val(),
                dealUnit:$('#search2 [name="dealUnit"]').val(),
                dealDate:$('#search2 [name="dealDate"]').val(),
			}
		});
	},
	clear1:function () {
        $('#search2 [name="dealSerial"]').val("");
        $('#search2 [name="inviteType"]').val("");
		$('#search2 [name="grainType"]').val("");
		$('#search2 [name="dealUnit"]').val("");
		$('#search2 [name="dealDate"]').val("");
        var form = layui.form;
        form.render();
    }
}