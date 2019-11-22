function Add(isedit, id, detailList, quotas, grainTypes,grainLevel,oilLevel) {
    this.form = layui.form;
    this.isedit = isedit;
    this.id = id;
    //debugger
    this.grainTypes = grainTypes || [];
    this.quotas = quotas;
    this.grainLevel = grainLevel;
    this.oilLevel = oilLevel;
    this.quotasMap = {};//等级指标Map, 小麦->[一等,二等...]
    //this.initQuotas();
    if (isedit) {
        for (var i = 0; i < detailList.length; i++) {
            this.initDetailByImport(detailList[i]);
        }
    }
    this.detailListTemp = detailList;
    this.detailList = ko.observableArray(this.detailListTemp || []);
    var date = new Date();
    this.reportMonth = date.getFullYear() + "-12";
    this.storehouses = ko.observableArray([]);
    this.rotateTypes = ["轮入","轮出"];
}

Add.prototype = {
    initQuotas: function () {
        var grainType;
        for (var i = 0; i < this.quotas.length; i++) {
            //debugger
            grainType = quotas[i].type;
            if (this.quotasMap[grainType] == undefined) {
                this.quotasMap[grainType] = [].concat(quotas[i]);
                this.grainTypes = this.grainTypes.concat(grainType);
            } else {
                this.quotasMap[grainType] = this.quotasMap[grainType].concat(quotas[i]);
            }
        }
    },

    initPage: function () {
        var self = this;

        if (!this.isedit) {
            var nowDate = new Date();
            var year = nowDate.getFullYear() + 1;
            layui.laydate.render({
                elem: $('input[name="year"]')[0],
                type: "year",
                value: year,
                min: (year - 1).toString() + '-01-01',
                max: (year + 2).toString() + '-12-31',
                showBottom :false,
                change: function(value, date, endDate){
                    $("#date").val(value);
                    //debugger
                    if($("select[name='planType'] option:selected").val()=="01"){
                        $('input[name="planName"]').val(value + "年度轮换计划");
                    }else if($("select[name='planType'] option:selected").val()=="02"){
                        $('input[name="planName"]').val(value + "超标粮食处置计划");
                    }else if($("select[name='planType'] option:selected").val()=="03"){
                        $('input[name="planName"]').val(value + "补充计划");
                    }
                    if($(".layui-laydate").length){
                        $(".layui-laydate").remove();
                    }
                },
                btns: ['now', 'confirm'],
                done: function (value, date, endDate) {
                }
            });
            $('input[name="planName"]').val(year + "年度轮换计划");
        } else {
            $("#in").find('[class="yieldTime"]').each(function () {
                var yieldTime = $(this).val();
                layui.laydate.render({
                    elem: $(this)[0],
                    type: "year",
                    format: "yyyy",
                    trigger: 'click',
                    change: function(value, date, endDate){
                        //console.log(this.elem);
                        this.elem[0].value=value;
                        if($(".layui-laydate").length){
                            $(".layui-laydate").remove();
                        }
                    },
                    value: yieldTime
                });
            });
            $("#out").find('[class="yieldTime"]').each(function () {
                var yieldTime = $(this).val();
                layui.laydate.render({
                    elem: $(this)[0],
                    type: "year",
                    format: "yyyy",
                    trigger: 'click',
                    change: function(value, date, endDate){
                        //console.log(this.elem);
                        this.elem[0].value=value;
                        if($(".layui-laydate").length){
                            $(".layui-laydate").remove();
                        }
                    },
                    value: yieldTime
                });
            });
            var nowDate = new Date();
            var year = nowDate.getFullYear() + 1;
            layui.laydate.render({
                elem: $('input[name="year"]')[0],
                type: "year",
                min: (year - 1).toString() + '-01-01',
                max: (year + 2).toString() + '-12-31',
                showBottom :false,
                change: function(value, date, endDate){
                    $("#date").val(value);
                    //debugger
                    if($("select[name='planType'] option:selected").val()=="01"){
                        $('input[name="planName"]').val(value + "年度轮换计划");
                    }else if($("select[name='planType'] option:selected").val()=="02"){
                        $('input[name="planName"]').val(value + "超标粮食处置计划");
                    }else if($("select[name='planType'] option:selected").val()=="03"){
                        $('input[name="planName"]').val(value + "补充计划");
                    }
                    if($(".layui-laydate").length){
                        $(".layui-laydate").remove();
                    }
                },
                btns: ['now', 'confirm'],
                done: function (value, date, endDate) {

                }
            });
        }

        layui.laydate.render({
            elem: $('[name="reportMonth"]')[0],
            type: "month",
            format: "yyyy-MM",
        });

        layui.form.on('submit(save)', function (data) {
            //alert(JSON.stringify(data.field));
            var postData = data.field;
            var detailList = ko.toJS(self.detailList());

            if (detailList.length == 0) {
                layerMsgError("请添加计划明细");
                return false;
            }

            for (var i = 0; i < detailList.length; i++) {
                if(detailList[i].rotateType == self.rotateTypes[0]){
                    detailList[i].yieldTime = $('#in tr[data-index="' + i + '"]').find('[class="yieldTime"]').val();
                }else{
                    detailList[i].yieldTime = $('#out tr[data-index="' + i + '"]').find('[class="yieldTime"]').val();
                }
                delete detailList[i].quotas;
                if (isNaN(detailList[i].rotateNumber) ||
                    detailList[i].rotateNumber<=0) {
                    layerMsgError('请检查轮换数量:数量>0');
                    return false;
                }
            }

            // 判断轮出中是否有同一年粮食品种一样的
            for(let j = 0; j < detailList.length; j ++){
                if(detailList[j].rotateType== self.rotateTypes[1]){
                    let foodType = detailList[j].foodType;
                    let year = detailList[j].yieldTime;
                    for(let k = j+1;k<detailList.length;k++){
                        if(detailList[k].rotateType==self.rotateTypes[1]) {
                            if (foodType == detailList[k].foodType && year == detailList[k].yieldTime) {
                                layerMsgError("一年中出库有相同粮食品种存在");
                                return false;
                            }
                        }
                    }
                }
            }

            postData.isedit = self.isedit;
            //alert("detailList="+JSON.stringify(detailList));
            postData.detailList = JSON.stringify(detailList);
            postData.department = $('[name="department"]').text();
            postData.colletor = $('[name="colletor"]').text();
            postData.colletorDate = $('[name="colletorDate"]').text();
            postData.modifier = $('[name="modifier"]').text();
            postData.modifyDate = $('[name="modifyDate"]').text();
            if (isedit)
                postData.id = self.id;
            postData.state = $(data.elem).attr("data-status");
            self.save(postData);
            return false;
        });
    },

    save: function (postData) {
        layer.load();
        $.ajax({
            type: 'POST',
            url: '../rotatePlan/declareSaveOrUpdate.shtml',
            data: postData,
            success: function (result) {
                if (result.success) {
                    layerMsgSuccess("操作成功", function () {
                        location.href = "../rotatePlan/declare.shtml"
                    });
                } else {
                    layerMsgError("ERROR:" + (result.msg || "接口异常"));
                }

            },
            error: function () {
                layer.closeAll();
                layerMsgError("ERROR:服务出错");
            },
            complete: function () {
                layer.closeAll('loading');
            }
        });
    },

    cancel: function (text, elem) {
        layer.confirm('确定要' + text + '吗?', {
            icon: 0,
            title: '提示'
        }, function (index) {//是
            location.href = "../rotatePlan/declare.shtml";
        }, function (index) {//否
            layer.close(index);
        });
    },

    checkAmount: function (elem) {
        var reg = /^\d+\.?(\d{1,2})?$/;
        var value = $(elem).val();
        if (!reg.test(value))
            $(elem).val(value.substring(0, value.length - 1));
    },

    showModal: function (data) {
        this.currentInDetail = data;
        $('#inModal').modal('show');
    },

    remove: function (data, index) {
        var detailList = this.detailList();
        detailList.splice(index, 1);
        this.detailList(detailList);
    },

    render: function (type) {
        if(this.rotateTypes[0] == type){
            //console.log( $("#in").find('[class="yieldTime"]'));
            $("#in").find('[class="yieldTime"]').each(function () {
                layui.laydate.render({
                    elem: $(this)[0],
                    type: "year",
                    trigger: 'click',
                    change: function(value, date, endDate){
                        //console.log(this.elem);
                        this.elem[0].value=value;
                        if($(".layui-laydate").length){
                            $(".layui-laydate").remove();
                        }
                    },
                    format: "yyyy"
                });
            });
        }else if(this.rotateTypes[1] == type){
            $("#out").find('[class="yieldTime"]').each(function () {
                layui.laydate.render({
                    elem: $(this)[0],
                    type: "year",
                    trigger: 'click',
                    change: function(value, date, endDate){
                        //console.log(this.elem);
                        this.elem[0].value=value;
                        if($(".layui-laydate").length){
                            $(".layui-laydate").remove();
                        }
                    },
                    format: "yyyy"
                });
            });
        }
    },

    hideModal: function (modal, tableId) {
        layui.table.reload(tableId);
        $('#' + modal).modal('hide');
    },

    //轮入、轮出 模态框
    add: function (rotateType) {
        var detail = this.initDetail(rotateType);
        this.detailList.push(detail);
        this.render(rotateType);
    },

    initDetail: function (type) {
        var self = this;
        var detail = {};
        detail.rotateType = ko.observable(type);
        detail.foodType = ko.observable("");
        detail.yieldTime = ko.observable("");
        detail.orign = ko.observable("");
        detail.rotateNumber = ko.observable('0.000');
        detail.qualityId = ko.observable()
        detail.quotas = ko.computed(function () {
            var grainType = this.foodType();
            if(grainType) {
                if (grainType.indexOf("油") != -1) {
                    return self.oilLevel || [];
                } else {
                    return self.grainLevel || [];
                }
            }
            return "";
        }, detail);
        return detail;
    },
    initDetailByImport: function (detail) {
        var self = this;
        detail.rotateType = ko.observable(detail.rotateType || "");
        detail.foodType = ko.observable(detail.foodType || "");
        detail.yieldTime = ko.observable(detail.yieldTime || "");
        detail.orign = ko.observable(detail.orign || "");
        detail.rotateNumber = ko.observable(detail.rotateNumber || 0);
        detail.qualityId = ko.observable(detail.qualityId || "");
        detail.quotas = ko.computed(function () {
            var grainType = this.foodType();
            if(grainType) {
                if (grainType.indexOf("油") != -1) {
                    return self.oilLevel || [];
                } else {
                    return self.grainLevel || [];
                }
            }
            //return self.quotasMap[grainType] || [];
        }, detail);
    },
};