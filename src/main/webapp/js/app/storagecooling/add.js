function Add(isedit,id,storehouses){
	this.isedit = isedit;
	this.id= id;
	this.storehouses=storehouses;
}

Add.prototype={
	initPage:function(){
		var self=this;

		layui.form.on('submit(save)', function(data) {
			self.save(data.field);
			return false;
		});
		layui.form.render('select','form');

        var laydate = layui.laydate;
        var endDate= laydate.render({
            elem: '#endTime',//选择器结束时间
            type: 'datetime',
            format : "yyyy-MM-dd HH:mm",
            min:"1970-1-1",//设置min默认最小值
            done: function(value,date){
                startDate.config.max={
                    year:date.year,
                    month:date.month-1,//关键
                    date: date.date,
                    hours: date.hours,
                    minutes: date.minutes,
                    seconds : date.seconds
                }
            }
        });
        //日期范围
        var startDate=laydate.render({
            elem: '#startTime',
            type: 'datetime',
            format : "yyyy-MM-dd HH:mm",
            max:"2099-12-31",//设置一个默认最大值
            done: function(value, date){
                endDate.config.min ={
                    year:date.year,
                    month:date.month-1, //关键
                    date: date.date,
                    hours: date.hours,
                    minutes: date.minutes,
                    seconds : date.seconds
                };
            }
        });
		
		/*var startTime=$('[name="startTime"]').val();
		layui.laydate.render({
			elem : $('[name="startTime"]')[0],
			type : "datetime",
			format : "yyyy-MM-dd HH:mm",
			value : startTime,
			done:function(value, date, endDate){
				if(!$('[name="endTime"]').val())
					return;
				else{
					var start = new Date(value);
					var end = new Date($('[name="endTime"]').val());
					var minus=((end-start)/1000)/60;
					if(minus<=0){
						layer.msg("通风开始时间需小于停止时间",{icon:0});
						return;
					}else{
						//$('[name="totalTime"]').val(minus.toFixed(1));
					}
				}
				
			},
		});
		var endTime=$('[name="endTime"]').val();
		layui.laydate.render({
			elem : $('[name="endTime"]')[0],
			type : "datetime",
			format : "yyyy-MM-dd HH:mm",
			value : endTime,
			done:function(value, date, endDate){
				if(!$('[name="startTime"]').val())
					return;
				else{
					var start = new Date($('[name="startTime"]').val());
					var end = new Date(value);			
					var minus=((end-start)/1000)/3600;
					if(minus<=0){
						layer.msg("通风开始时间需小于停止时间",{icon:0});
						return;
					}else{
						//$('[name="totalTime"]').val(minus.toFixed(1));
					}
				}
			},
		});*/


		//粮食下拉框
		layui.form.on('select(grainType)',function(data){
			if(!data.value||!$('[name="encode"]').val()){
				$('[name="realQuantity"]').val('');
				return;
			}
			else{
				if(!$('[name="warehouse"]').val()){
					layer.msg('请选择库点',{icon:0});
					return;
				}else{
					self.getRealQuantity();
				}
			}
		});
		//仓房下拉框
		layui.form.on('select(storehouse)',function(data){
			debugger
			//保管人
			if(!data.value){
                $('select[name="type"]').val('');
				$('[name="custodian"]').val('');
			}else{
				$('[name="custodian"]').val('');
				for(var i=0;i<self.storehouses.length;i++){
					if(data.value==self.storehouses[i].encode){
						//alert(self.storehouses[i].type);
						$('[name="custodian"]').val(self.storehouses[i].keeper);
                        //$('[name="custodian"]').val(self.storehouses[i].type);
                        $('select[name="type"]').val(self.storehouses[i].type);

						/*var getT = $($(this).parent().parent().parent().parent().next().children()[1]);
                        getT.find('.layui-anim-upbit').children().each(function (i, v) {
                        	if($(v).html() == self.storehouses[i].type){
                                $(v).addClass('layui-this')
                                getT.find('.layui-unselect').val(self.storehouses[i].type)
                                $(select[name="type"]).val(self.storehouses[i].type);
							}
                        })*/
						break;
					}
				}
				//self.findType();
			}
            layui.form.render('select','form');
			if(!data.value||!$('[name="grainVariety"]').val()){
				$('[name="realQuantity"]').val('');
				return;
			}
			else{
				if(!$('[name="warehouse"]').val()){
					layer.msg('请选择库点',{icon:0});
					return;
				}else{
					self.getRealQuantity();
				}
			}

		});
	},
	/*findType:function () {
        layer.load();
        $.ajax({
            type : 'POST',
            url : '../reportSwtz/getLastestQuantity.shtml',
            data : {
                reportWarehouse:$('[name="warehouse"]').val(),
                storehouse:$('[name="encode"]').val(),
            },
            success : function(result) {
                $('[name="realQuantity"]').val(result.toFixed(3));
            },
            error : function() {
                layer.closeAll();
                layerMsgError("仓房类型读取失败!");
            },
            complete:function(){
                layer.closeAll('loading');
            }
        });
    },*/
	getRealQuantity:function(){
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../reportSwtz/getLastestQuantity.shtml',
				data : {
					reportWarehouse:$('[name="warehouse"]').val(),
					storehouse:$('[name="encode"]').val(),
					variety:$('[name="grainVariety"]').val()
				},
				success : function(result) {
					layerMsgSuccess("实际数量读取成功!");
					$('[name="realQuantity"]').val(result.toFixed(3));

				},
				error : function() {
					layer.closeAll();
					layerMsgError("实际数量读取失败!");
				},
				complete:function(){
					layer.closeAll('loading');
				}
		}); 
	},

	save:function(postData){
		$("#saveBtn").attr("disabled",true);
        var tempMax = $('[name="tempMax"]').val();
        var tempMin = $('[name="tempMin"]').val();
        var tempAvg = $('[name="tempAvg"]').val();
        if(Number(tempMax)>=Number(tempAvg)&&Number(tempAvg)>=Number(tempMin)){

		}else{
        	alert('气温的最高值或最低值或平均值大小不符合逻辑,请检查!');
            $("#saveBtn").attr("disabled",false);
        	return false;
		}

        if(Number($('[name="rhMax"]').val())>=Number($('[name="rhAvg"]').val())&&Number($('[name="rhAvg"]').val())>=Number($('[name="rhMin"]').val())){

        }else{
            alert('气湿的最高值或最低值或平均值大小不符合逻辑,请检查!');
            $("#saveBtn").attr("disabled",false);
            return false;
        }
        if(Number($('[name="beforeMax"]').val())>=Number($('[name="beforeAvg"]').val())&&Number($('[name="beforeAvg"]').val())>=Number($('[name="beforeMin"]').val())){

        }else{
            alert('冷通前粮温的最高值或最低值或平均值大小不符合逻辑,请检查!');
            $("#saveBtn").attr("disabled",false);
            return false;
        }

        if(Number($('[name="afterMax"]').val())>=Number($('[name="afterAvg"]').val())&&Number($('[name="afterAvg"]').val())>=Number($('[name="afterMin"]').val())){

        }else{
            alert('冷通后粮温的最高值或最低值或平均值大小不符合逻辑,请检查!');
            $("#saveBtn").attr("disabled",false);
            return false;
        }
        if(Number($('[name="gradMax"]').val())>=Number($('[name="gradAvg"]').val())&&Number($('[name="gradAvg"]').val())>=Number($('[name="gradMin"]').val())){

        }else{
            alert('粮层温度梯度的最高值或最低值或平均值大小不符合逻辑,请检查!');
            $("#saveBtn").attr("disabled",false);
            return false;
        }
        if(Number($('[name="dewMax"]').val())>=Number($('[name="dewAvg"]').val())&&Number($('[name="dewAvg"]').val())>=Number($('[name="dewMin"]').val())){

        }else{
            alert('粮层水分梯度的最高值或最低值或平均值大小不符合逻辑,请检查!');
            $("#saveBtn").attr("disabled",false);
            return false;
        }

		postData.isedit=this.isedit;

		if(this.isedit)
			postData.id=this.id;
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../StorageCooling/saveOrUpdate.shtml',
				data : postData,
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功"
							, function() {
							location.href = "../StorageCooling/main.shtml"
						});
					} else {
						layerMsgError("操作失败");
                        $("#saveBtn").attr("disabled",false);
					}

				},
				error : function() {
					layer.closeAll();
					layerMsgError("操作失败");
                    $("#saveBtn").attr("disabled",false);
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
			location.href = "../StorageCooling/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
}