
$("#clearFileBtn").click(function () {
	// 删除文件
	$("input[name='file']").val("");
	$("#fileId").val("");
	// 隐藏按键
	$(this).hide();
    $("#afileName a").html("");
   /* $("#fileName").attr("style","display:none;");*/
    $("#fileName").html("");
    $("#openExce a").html("");
	$("#uploadFile").html("<i class=\"layui-icon\"></i>上传");
});


function Add(isedit,id,bidType,detailList){
	this.isedit=isedit;
	this.id=id;
	if(isedit)
		for(var i=0;i<detailList.length;i++)
			this.init(detailList[i]);
	this.detailList=ko.observableArray(detailList||[]);
	this.reimport=false;//true:代表导入了excel
	this.bidType=ko.observable(bidType||"招标采购");

	this.schemeDetailList=ko.observableArray([]);
	this.pageIndex=1;
	this.pageSize=pagesize;
	this.total=0;
	this.curScheme=null;
	this.curBidDetail=null;
}

Add.prototype={
	init:function(object){
		object.schemeID = ko.observable(object.schemeID||'--请选择--');
	},
	initPage:function(){
		var self=this; 
		var dealDate=$('[name="dealDate"]').val();
		layui.laydate.render({
			elem : $('[name="dealDate"]')[0],
			type : "date",
			format : "yyyy-MM-dd",
			value : dealDate
		});
		self.renderSelect();
		
		//选择框
		layui.form.on('select(bidType)', function(data) {
			self.detailList([]);
			self.bidType(data.value);
			if(data.value!='招标采购'){
				self.renderSelect();
			}else{
				layui.form.render('select','form');
			}
			self.renderExcelImport("#file",self.bidType());
		});
		
		//选择框
		layui.form.on('select(foodType)', function(data) {//更改粮食品种不可保存处理
			self.detailList([]);
		});
		//表单提交
		layui.form.on('submit(save)', function(data) {
			var postData = data.field;
			self.save(postData);
			return false;
		});
		self.renderExcelImport("#file",self.bidType());
//		self.bindSelect();
		layui.form.render(null, 'form');//刷新渲染表单
	},
	renderSelect:function(){
		var saleDate=$('[name="saleDate"]').val();
		layui.laydate.render({
			elem : $('[name="saleDate"]')[0],
			type : "date",
			format : "yyyy-MM-dd",
			value : saleDate
		});
	},

	renderExcelImport:function(elemid,bidType){
		var self=this;
		Excel_Import({
			elem:elemid,
			url:"../rotateBID/importExcel.shtml",
			data: {
				bidType : bidType
			},
			success:function(data){
                // 去除数据中的空格
                for(let i = 0;i<data.length;i++){
                    for(let obj in data[i]){
                        data[i][obj] = $.trim(data[i][obj]);
                        //修复第一个字符是小数点 的情况.  
						if(data[i][obj].indexOf('.')!=-1) {
                            if (data[i][obj] != '' && data[i][obj].substring(0, 1) == '.') {
                                data[i][obj] = "";
                            }
                            if (obj != "tincture"){
                                data[i][obj] = data[i][obj].replace(/[^\d.]/g, "");  //清除“数字”和“.”以外的字符  
                            data[i][obj] = data[i][obj].replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的       
                            data[i][obj] = data[i][obj].replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
                            data[i][obj] = data[i][obj].replace(/^(\-)*(\d+)\.(\d\d\d).*$/, '$1$2.$3');//只能输入三个小数       
                            if (data[i][obj].indexOf(".") < 0 && data[i][obj] != "") {//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额  
                                if (data[i][obj].substr(0, 1) == '0' && data[i][obj].length == 2) {
                                    data[i][obj] = data[i][obj].substr(1, data[i][obj].length);
                                }
                            }
                        }
                        }

                    }
                }

				for(var i=0;i<data.length;i++){
					data[i].schemeID=ko.observable(data[i].schemeID||'--请选择--');
				}
				self.detailList([]);
				self.detailList(data);
				self.reimport=true;
				layui.form.render('select','form');
//				self.bindSelect();
			}
		});
	},
	
//	bindSelect:function(){
//		var self=this;
//		layui.form.on('select(schemeId)', function(data) {
//			console.log(data.elem[data.elem.selectedIndex]);
//			var index=Number($(data.elem).attr('data-index'));
//			
//			self.detailList()[index].schemeID=data.value;
//			self.detailList()[index].schemeName=$(data.elem[data.elem.selectedIndex]).text();
//		});
//	},

	save:function(postData){
        if (postData.bidType != "招标采购") {
            var dealDate=Date.parse(new Date(postData.dealDate));
            var saleDate= Date.parse(new Date(postData.saleDate));
            if (saleDate-dealDate<=0){
                layerMsgError("卖出时间要大于竞价时间");
                return;
            }
        }
		var detailList=ko.toJS(this.detailList());
		if(detailList.length==0){
			layerMsgError("请导入标的物明细");
			return;
		}
        /*标的号不能重复*/
        var hash = {};

        for(var i=0;i<detailList.length;i++){
            if(hash[detailList[i].bidSerial]){
                layerMsgError("标的号不能重复");
                return;
            }
            hash[detailList[i].bidSerial] = true;
        }

		for(var i=0;i<detailList.length;i++){
			if(detailList[i].schemeID == '--请选择--'){
				layerMsgError("标的物明细的子方案ID为必选项");
				return;
			}
		}

        for(var i=0;i<detailList.length;i++){
            if(detailList[i].bidSerial == ''||detailList[i].bidSerial ==null){
                layerMsgError("标的号不能为空");
                return;
            }
        }


		if (postData.bidType == "招标采购") {
			postData.saler = '--';
		} else {
			postData.tenderee = '--';
			postData.foodType = '--';
		}
		postData.isedit = this.isedit;
		postData.detailList=JSON.stringify(detailList);
		postData.reimport=this.reimport;
		if(this.isedit)
			postData.id=this.id ;
		layer.load();
        $.ajax({
               type : 'POST',
               url : '../rotateBID/saveOrUpdate.shtml',
               data : postData,
               success : function(result) {
                   if (result.success) {
                       layerMsgSuccess("操作成功"
                           , function() {
                           location.href = "../rotateBID/main.shtml"
                       });
                   } else {
                   		if(result.msg!=""){
                            layerMsgError(result.msg);
						}else {
                            layerMsgError("操作失败");
						}

                   }

               },
               error : function() {
                   layer.closeAll();
                   layerMsgError("error:服务错误");
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
			location.href = "../rotateBID/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
	//---------模态框----------------
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
	queryPageList:function(data){
		var self=this;
		var rotateType=$('[name="bidType"]').val();
		var postData={
			pageIndex:self.pageIndex,
			pageSize:self.pageSize,
			rotateType:rotateType,
			state:'已完成',
			isEnd:'1'//条件状态不等于1的方案
		};
		if(rotateType=='招标采购'){
			postData.foodType=$('[name="foodType"]').val();
			postData.branNumber =$.trim(data.storeHouse);
			postData.yieldTime=$.trim(data.produceYear);
			postData.ogirin=$.trim(data.produceArea);
			postData.libraryId=$.trim(data.company);
			postData.quantity=$.trim(data.quantity);
			postData.enterprise=$.trim(data.enterprise);
		}else{
			postData.foodType=$.trim(data.grainType),
			postData.branNumber =$.trim(data.storehouse),
			postData.ogirin=$.trim(data.produceArea),
			postData.libraryId=$.trim(data.deliveryPlace),
			postData.quantity=$.trim(data.total),
			postData.yieldTime=$.trim(data.warehouseYear)
		}

		$.ajax({
			url:"../RotateScheme/listDetail.shtml",
			type:"POST",
			data:postData,
			success:function(res){
				var list= res.result||[];
				self.schemeDetailList(list);
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
				$('#addModal').modal('show');

			},
			error:function(res){
				layerMsgError("ERROR:数据获取异常");
			}
		});
	},
	showModal:function(data){
		this.curBidDetail=data;
		this.queryPageList(data);
	},
	hideModal:function(){
		this.curScheme=null;
		this.curBidDetail=null;
		$('#addModal').modal('hide');
	},
	choose:function(data){
		this.curScheme=data;
	},
	confirmChoose:function(){
		if(this.curScheme==null){
			layerMsgError("请选择子方案");
		}
        var check = document.getElementById("coverAll").checked;
        if(check == true){
            this.coverAllDetail(this.curScheme);
		}else{
            this.curBidDetail.schemeID(this.curScheme.dId);
		}
		this.hideModal();
	},
    coverAllDetail:function (data) {
        var detailList=ko.toJS(this.detailList());
        for(var i =0;i<detailList.length;i++){
        	//根据库点、仓号、粮食品种、收获年份、产地获取主方案下对应的唯一子方案
            var rotateType=$('[name="bidType"]').val();
            var postData={
            	schemeId:data.schemeId,
                rotateType:rotateType,
                state:'已完成'
            };
            if(rotateType=='招标采购'){
                postData.foodType=$('[name="foodType"]').val();
                postData.branNumber =$.trim(detailList[i].storeHouse);
                postData.yieldTime=$.trim(detailList[i].produceYear);
                postData.ogirin=$.trim(detailList[i].produceArea);
                postData.libraryId=$.trim(detailList[i].company);
                postData.quantity=$.trim(detailList[i].quantity);
                postData.enterprise=$.trim(detailList[i].enterprise);
            }else{
                postData.foodType=$.trim(detailList[i].grainType),
				postData.branNumber =$.trim(detailList[i].storehouse),
				postData.ogirin=$.trim(detailList[i].produceArea),
				postData.libraryId=$.trim(detailList[i].deliveryPlace),
				postData.quantity=$.trim(detailList[i].total),
				postData.yieldTime=$.trim(detailList[i].warehouseYear)
            }
            $.ajax({
                url:"../RotateScheme/getSchemeDetailByCondition.shtml",//根据计划详情子id查出该计划详情子id关联的未成交的方案数量
                data:postData,
                async:false,
                type:"post",
                success:function(data){
                	debugger
					if(data){
                		var a = data.dId;
                		/*var temp = detailList[i];
                        temp.schemeID = a;
                        detailList.splice(i,1);
                        temp.schemeID=ko.observable(a||'--请选择--');
                        detailList.splice(i, 0, temp);*/
                        detailList[i].schemeID=ko.observable(a||'--请选择--');
                    }else{
                        detailList[i].schemeID=ko.observable('--请选择--');
					}
                }
            });

		}
        this.detailList([]);
        this.detailList(detailList);
    }

}

