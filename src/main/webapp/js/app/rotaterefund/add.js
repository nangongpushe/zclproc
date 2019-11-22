function Add(isedit,id){
	this.isedit=isedit;
	this.id=id;
	this.dealList = ko.observableArray([]);
	this.pageIndex=1;
	this.pageSize = pagesize;
	this.firstShowModal=true;
	this.selected = null;
}
$("#saves").click(function () {
    if($("#data-result").children().length==1){
        layer.msg("请选择明细");
        return;
    }
    var datas=[];
    var datas2=[];
    $("#data-result").find("tr").each(function () {
        debugger
		if($(this).find("input[name='id']")[0].value.indexOf(",")!=-1){
			var ids=$(this).find("input[name='id']")[0].value.split(",");
			var group=$(this).find("td[name='group']")[0].innerText;
			var remark=$(this).find("input[name='remark']")[0].value;
			ids.forEach(function (value) {
			    var data={};
				data["id"]=value;
				data["remark"]=remark;
				data["group"]=group;
                if(data["id"]!="") {
                    datas.push(data);
                }
			})
		}else{
            var data={};
            data["id"]=$(this).find("input[name='id']")[0].value;
            data["group"]=$(this).find("td[name='group']")[0].innerText;
            data["remark"]=$(this).find("input[name='remark']")[0].value;
            if(data["id"]!="") {
                datas.push(data);
            }
		}
    })
	datas.forEach(function (value) {
		$("#amountDetail").find("tr").each(function () {
		    var data2={};
			if($(this).find("input[name='id']")[0].value==value.id){
			    debugger
				data2["id"]=$(this).find("input[name='detailId']")[0].value;
				data2["concluteDetailId"]=value.id;
                data2["bidSerial"]=$(this).find("td[name='bidSerial']")[0].innerText;
                data2["dealType"]=$(this).find("td[name='inviteType']")[0].innerText;
                data2["dealNumber"]=$(this).find("td[name='quantity']")[0].innerText;
                data2["dealAmount"]=$(this).find("td[name='bail']")[0].innerText;
                data2["refundAmount"]=$(this).find("input[name='refund']")[0].value;
                data2["company"]=$(this).find("td[name='clientName']")[0].innerText;
                data2["dealDates"]=$(this).find("td[name='dealDate']")[0].innerText;
                data2["groupId"]=value.group;
                data2["remark"]=value.remark;
                if(data2["concluteDetailId"]!="") {
                    datas2.push(data2);
                }
			}
        })
	})

	var data3={};
    data3["serial"]=$("#serial")[0].value;
    data3["handleTime"]=$("#handleTime")[0].value;
    data3["operator"]=$("#operator")[0].value;
    data3["department"]=$("#department")[0].value;
	debugger
	console.log(datas2);
    $.ajax({
        type : 'POST',
        url : '../rotateRefund/saveOrUpdate.shtml',

        data : {"main":JSON.stringify(data3),
			    "datas":JSON.stringify(datas2),
		        "isedit":isedit,
		        "mainId":id},
        success : function(result) {
            if (result.success) {
                layerMsgSuccess("操作成功",function() {
                    location.href = "../rotateRefund/main.shtml"
                });
            } else {
                layer.closeAll("loading");
                $(eventEle).attr("disabled",false);
                layerMsgError("操作失败");
            }

        },
        error : function() {
            layer.closeAll("loading");
            $(eventEle).attr("disabled",false);
            layerMsgError("error");
        }
    });

})
$("#cancel").click(function () {
    layer.closeAll();
    $(".container-box3").attr("style","display:none");
})
$("#saveAmount").click(function () {
    var id=[];
    var amount=0;
    $("#amountDetail2").find("tr").each(function (index,item) {
        amount=toDecimal2NoZero(parseFloat($(item).find("input[name='refund']")[0].value)+parseFloat(amount));
        debugger
        id.push($(item).find("input[name='id']")[0].value);
        console.log(id);
        $("#amountDetail").find("tr").each(function () {
            if($(this).find("input[name='id']")[0].value==$(item).find("input[name='id']")[0].value){
                $(this).find("input[name='refund']")[0].value=$(item).find("input[name='refund']")[0].value;
            }
        })
    })
    $("#data-result").find("td[name='mark']").each(function () {
    	if($(this).find("input[name='id']")[0].value==id.join(",")){
    		$(this).parent().find("input[name='refund']")[0].value=amount;
    		return;
		}
    })
    layer.closeAll();
    $(".container-box3").attr("style","display:none");
})
function showMultiple(elem) {
   debugger
    if($(elem).parent().parent().find("input[name='id']")[0].value.indexOf(",")==-1){
    	return;
	}

	var id=$(elem).parent().parent().find("input[name='id']")[0].value.split(",");
    $("#amountDetail2").find("tr").each(function () {
        $(this).remove();
    })
    id.forEach(function (value) {
        $("#amountDetail").find("tr").each(function () {
            if ($(this).find("input[name='id']")[0].value == value) {
                var template = $("#detail-tr2").clone(true);
                var template2=$(this).clone(true);
                $(template).attr("style", "display:table-row");
                //$(template).addClass("data-tr");
                $("#amountDetail2").append($(template2));
            }
        })
    })
    var width=$('.container-box').innerWidth()-300;
        layer.open({
            type : 1,
            title:"标的明细",
            content : $('.container-box3'),
            closeBtn: 0,
            area:[width,'500px'],
        });
    //$('.container-box3').attr("style","display:none");
}
function judgeAmount(obj) {
    debugger
	var amount=$(obj).parent().parent().find("td[name='surplusBail']")[0].innerText;
    if(parseFloat(amount)<parseFloat(obj.value)){
        layer.msg("本次保证金退还金额不能大于未退还保证金金额");
        obj.value=$(obj).parent().parent().find("td[name='surplusBail']")[0].innerText;
    }else if(parseFloat(obj.value<=0)){
        layer.msg("本次保证金退还金额不能小于等于0");
        obj.value=$(obj).parent().parent().find("td[name='surplusBail']")[0].innerText;
    }else{
        $("#amountDetail").find("tr").each(function () {
            if($(this).find("input[name='id']")[0].value==$(obj).parent().parent().find("input[name='id']")[0].value){
                $(this).find("input[name='refund']")[0].value=obj.value;
            }
        })
	}
}

Add.prototype={
	initPage:function(){
		var self=this;
		//时间选择器
		var handleTime=$('[name="handleTime"]').val();

		layui.laydate.render({
				elem : $('[name="handleTime"]')[0],
				type : "date",
				format : "yyyy-MM-dd",
				value : handleTime
		});
		
		layui.laydate.render({
			elem : $('#search2 [name="dealDate"]')[0],
			type : "date",
			format : "yyyy-MM-dd",
		});
		layui.form.render("select","search2");
        var selectedDealSerial = null;
        layui.form.on('select(dealId)',function(data){
            // debugger;
            if(selectedDealSerial!=data.value){
                vm.list([]);
                selectedDealSerial = data.value;
                vm.queryPageList(1);
            }
        });
		// layui.form.on('submit(save)', function(data) {
		// 	$(this).attr("disabled",true);
         //    // layer.load(2);
		// 	var postData = data.field;
		// 	if(postData.refundAmount <= 0){
		// 		layerMsgError("退还保证金额必须大于0");
         //        $(this).attr("disabled",false);
		// 		return ;
		// 	}
        //
		// 	if (postData.surplusBail - postData.refundAmount < 0){
         //        layerMsgError("退还保证金不应大于未退还保证金");
         //        $(this).attr("disabled",false);
         //        return ;
		// 	}
        //
        //
        //
		// 	postData.isedit = self.isedit;
		// 	if(isedit)
		// 		postData.id=self.id;
        //
		// 	self.save(postData,this);
		// 	return false;
		// });
	},
	
	cancel:function(elem){		
		layer.confirm('确定要取消吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			location.href = "../rotateRefund/main.shtml";
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
	save:function(postData,eventEle){
		 $.ajax({
				type : 'POST',
				url : '../rotateRefund/saveOrUpdate.shtml?id='+id,
				data : postData,
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功",function() {
							location.href = "../rotateRefund/main.shtml"
						});
					} else {
                        layer.closeAll("loading");
                        $(eventEle).attr("disabled",false);
						layerMsgError("操作失败");
					}

				},
				error : function() {
					layer.closeAll("loading");
					$(eventEle).attr("disabled",false);
					layerMsgError("error");
				}
			});
	},
	
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
	queryPageList:function(isSearch){

        if(isSearch){
            this.pageIndex=1;
		}

		var dealSerial=$('#search2 [name="dealSerial"]').val();
		var bidSerial=$('#search2 [name="bidSerial"]').val();
		var dealUnit = $('#search2 [name="dealUnit"]').val();
		var dealDate = $('#search2 [name="dealDate"]').val();
        var inviteType = $('#search2 [name="inviteType"]').val();
        var ids=$("#hiddenId").find("input[name='ids']")[0].value;
		var self=this;
        var index = layer.load();
		$.ajax({
			url:"../rotateConclute/listDetailForRefund.shtml",
			type:"POST",
			data:{
				pageIndex:self.pageIndex,
				pageSize:self.pageSize,
				dealSerial:dealSerial,
				bidSerial:bidSerial,
				dealUnit:dealUnit,
				dealDate:dealDate,
                inviteType:inviteType,
				ids:ids
			},
			success:function(res){
                layer.close(index);
				var list = res.result || [];
				self.dealList(list);
				if(res.pageIndex && res.totalCount){
					var pageReload=self.pageIndex!=res.pageIndex
						||self.total!=res.totalCount;
					self.pageIndex=res.pageIndex;
                    // console.log("+++++"+self.pageIndex);
					self.pageSize=res.pageSize;
					self.total=res.totalCount;
					if(pageReload){
						self.renderPage("pagination");
					}
				}

			},
			error:function(res){
                layer.close(index);
				layerMsgError("ERROR:服务出错");
			}
		});
	},
	clear:function () {
        $('#search2 [name="bidSerial"]').val("");
        $('#search2 [name="dealUnit"]').val("");
        $('#search2 [name="inviteType"]').val("");
        $('#search2 [name="dealDate"]').val("");
        var form = layui.form;
        form.render();
    },
	showModal:function(){
	    if($("#data-result").children().length>=6){
	        layer.msg("一张联系单上最多有5条明细");
	        return;
        }
		this.selected = null;
		if(this.firstShowModal){
			this.queryPageList();
			//this.firstShowModal = false;
		}
		$("#myModal").modal('show');
	},
	choose:function(data){
		this.selected=data;
	},
	// confirm:function(){
	// 	if(this.selected==null){
	// 		layerMsgError("请选择");
	// 		return;
	// 	}else{
    //
	// 	    if(this.isedit){
	// 	        if(this.selected.id == $('#form1 #concluteDetailId').val()){
     //                $("#myModal").modal('hide');
	// 	            return;
     //            }
     //        }
    //
	// 		$('#form1 [name="bidSerial"]').val(this.selected.bidSerial);
	// 		$('#form1 [name="company"]').val(this.selected.dealUnit);
	// 		$('#form1 [name="dealType"]').val(this.selected.inviteType);
	// 		$('#form1 [name="dealDate"]').val(this.selected.dealDate);
	// 		$('#form1 [name="dealNumber"]').val(this.selected.quantity);
	// 		$('#form1 [name="dealAmount"]').val(this.selected.bail);
     //        $('#form1 [name="surplusBail"]').val(this.selected.surplusBail);
	// 		$('#form1 #concluteDetailId').val(this.selected.id);
    //
	// 		$("#myModal").modal('hide');
	// 	}
	// }
};