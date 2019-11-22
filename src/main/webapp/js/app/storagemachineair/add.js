function Add(isedit,id,storehouses){
	this.isedit = isedit;
	this.id= id;
	this.storehouses=storehouses;
}

Add.prototype={
	initPage:function(){
		var self=this;

		layui.form.on('submit(save)', function(data) {
			$("#save").attr("disabled",true);
			self.save(data.field);
			return false;
		});
		layui.form.render('select','form');

        layui.form.verify({
            grainBulkHeight: function(value){
            	if(value<0){
                    return '不能为负数';
				}
            },
            grainBulkVolume:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            fanPower:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            fanQuantity:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            totalAirVolume:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            airDuctQuantity:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            airDuctGap:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            averageAirVolume:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            airPathRatio:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            maxAirTemperature:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            minAirTemperature:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            minAirHumidity:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            averageAirHumidity:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            maxGrainTemperature:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            minGrainTemperature:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            averageGrainTemperature:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            maxGrainTemperatureNew:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            minGrainTemperatureNew:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            averageGrainTemperatureNew:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            maxGrainDew:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            minGrainDew:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            averageGrainDew:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            maxGrainDewNew:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
            minGrainDewNew:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
			averageGrainDewNew:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
			totalPowerConsumption:function(value){
                if(value<0){
                    return '不能为负数';
                }
            },
			averagePowerConsumption:function(value){
                if(value<0){
                    return '不能为负数';
                }
            }
        })

        var airStartTime=$('[name="airStartTime"]').val();
		layui.laydate.render({
			elem : $('[name="airStartTime"]')[0],
			type : "datetime",
			format : "yyyy-MM-dd HH:mm:ss",
			value : airStartTime,
			done:function(value, date, endDate){
                //debugger
				if(!$('[name="airEndTime"]').val())
					return;
				else{


                    var start = NewDate(value);
                    var end = NewDate($('[name="airEndTime"]').val());
                    var minus=((end-start)/1000)/3600;
                    console.log(minus.toFixed(1))
					if(minus<=0){
						layer.msg("通风开始时间需小于等于停止时间",{icon:0});
						return;
					}else{

						$('[name="totalAirTime"]').val(minus.toFixed(1));
						self.calculateAverageAirVolume();
					}
				}
				
			},
		});
		var airEndTime=$('[name="airEndTime"]').val();
		layui.laydate.render({
			elem : $('[name="airEndTime"]')[0],
			type : "datetime",
			format : "yyyy-MM-dd HH:mm:ss",
			value : airEndTime,
			done:function(value, date, endDate){
				//debugger
				if(!$('[name="airStartTime"]').val())
					return;
				else{
                    var start = NewDate($('[name="airStartTime"]').val());
                    var end = NewDate(value);
                    var minus=((end-start)/1000)/3600;
                    console.log(minus.toFixed(1))
					if(minus<=0){
						layer.msg("通风开始时间需小于等于停止时间",{icon:0});
						return;
					}else{
						$('[name="totalAirTime"]').val(minus.toFixed(1));
						self.calculateAverageAirVolume();
					}
				}
			},
		});
		//自定义 时间
        function NewDate(str){
            if(!str){
                return 0;
            }
            arr=str.split(" ");
            d=arr[0].split("-");
            t=arr[1].split(":");
            var date = new Date();
            date.setUTCFullYear(d[0], d[1] - 1, d[2]);
            date.setUTCHours(t[0], t[1], t[2], 0);
            return date;
        }

        //粮食下拉框
		layui.form.on('select(grainType)',function(data){
			if(!data.value||!$('[name="storehouse"]').val()){
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
			//保管人
			if(!data.value){
				$('[name="storeMan"]').val('');
			}else{
				$('[name="storeMan"]').val('');
				for(var i=0;i<self.storehouses.length;i++){
					if(data.value==self.storehouses[i].encode){
						$('[name="storeMan"]').val(self.storehouses[i].keeper);
						break;
					}
				}
			}
			if(!data.value||!$('[name="grainType"]').val()){
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
	
	calculateAverageAirVolume:function(){
		//计算单位通风量
		if(!$('[name="totalAirVolume"]').val()||!$('[name="totalAirTime"]').val())
			return;
		else{
			var averageAirVolume = Number($('[name="totalAirVolume"]').val())/Number($('[name="totalAirTime"]').val());
			$('[name="averageAirVolume"]').val(averageAirVolume.toFixed(3));
		}
	},
	getRealQuantity:function(){
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../reportSwtz/getLastestQuantity.shtml',
				data : {
					reportWarehouse:$('[name="warehouse"]').val(),
					storehouse:$('[name="storehouse"]').val(),
					variety:$('[name="grainType"]').val()
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
		postData.isedit=this.isedit;
		if(this.isedit)
			postData.id=this.id;
		layer.load();
		 $.ajax({
				type : 'POST',
				url : '../StorageMachineAir/saveOrUpdate.shtml',
				data : postData,
				success : function(result) {
					if (result.success) {
						layerMsgSuccess("操作成功"
							, function() {
							location.href = "../StorageMachineAir/main.shtml"
						});
					} else {
						layerMsgError("操作失败");
                        $("#save").attr("disabled",false);
                    }

				},
				error : function() {
					layer.closeAll();
					layerMsgError("error:服务出错");
                    $("#save").attr("disabled",false);
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
			location.href = "../StorageMachineAir/main.shtml";
		}, function(index) {//否
			layer.close(index);
		});
	},
}