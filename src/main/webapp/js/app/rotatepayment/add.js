function Add(isedit, id, detailList, customers) {
    this.isedit = isedit;
    this.id = id;
    if (isedit) {
        for (var i = 0; i < detailList.length; i++) {
            this.initDetail(detailList[i]);
        }
    }
    this.detailList = ko.observableArray(detailList || []);
    this.customers = customers;
}

Add.prototype = {
    initDetail: function (detail) {
        detail.quantity = ko.observable(detail.quantity || 0);
        detail.amount = ko.computed(function () {
            var i = Number(this.quantity()) * Number(this.price);
            return parseFloat(i).toFixed(2)
        }, detail);
    },
    initPage: function () {
        var self = this;
        layui.form.render('select', 'form');
        layui.form.on('select(clientName)', function (data) {
            for (var i = 0; i < self.customers.length; i++) {
                if (self.customers[i].clientName == data.value) {
                    $('[name="depositBank"]').val(self.customers[i].depositBank);
                    $('[name="depositAccount"]').val(self.customers[i].depositAccount);
                    break;
                }
            }
        });
        layui.laydate.render({
            elem: $('[name="startDealDate"]')[0],
            type: "date",
            format: "yyyy-MM-dd"
        });
        layui.laydate.render({
            elem: $('[name="endDealDate"]')[0],
            type: "date",
            format: "yyyy-MM-dd"
        });
        layui.form.on('submit(save)', function (data) {
            var postData = data.field;
            postData.status = $(data.elem).attr('data-status');
            self.save(postData);
            return false;
        });


        layui.form.render('select', 'search2');
        this.renderTable1();
    },

    save: function (postData) {
        var detailList = ko.toJS(this.detailList);
        if (null == detailList || detailList.length == 0) {
            layer.msg('请添加货款支付明细', {icon: 0});
            return;
        }
        for (var i = 0; i < detailList.length; i++) {
            if (detailList[i].quantity <= 0) {
                layer.msg('数量必须大于0', {icon: 0});
                return;
            }
        }
        postData.detailListStr = JSON.stringify(detailList);
        postData.isedit = this.isedit;
        if (isedit)
            postData.id = this.id;
        layer.load();
        $.ajax({
            type: 'POST',
            url: '../rotatePayment/saveOrUpdate.shtml',
            data: postData,
            success: function (result) {
                if (result.success) {
                    layerMsgSuccess("操作成功"
                        , function () {
                            location.href = "../rotatePayment/main.shtml"
                        });
                } else {
                    layerMsgError("操作失败");
                }

            },
            error: function () {
                layer.closeAll();
                layerMsgError("error");
            },
            complete: function () {
                layer.closeAll('loading');
            }
        });
    },
    cancel: function () {
        layer.confirm('确定要取消吗?', {
            icon: 0,
            title: '提示'
        }, function (index) {//是
            location.href = "../rotatePayment/main.shtml";
        }, function (index) {//否
            layer.close(index);
        });
    },

//	--------模态搜索框---------------
    showModal: function () {
        let deatUnit = $("#clientId option:selected").val();
        if(deatUnit == null ||deatUnit==""){
            layerMsgError("请选择收款单位");
            return;
        }
        $('#myModal').modal('show');
    },

    hideModal: function () {
        $('#myModal').modal('hide');
    },

    toDetail: function (deal) {
        return {
            concluteId : deal.id,
            schemeName: (deal.dealDate==null?'':deal.dealDate) + (deal.schemeName==null?'':deal.schemeName),
            bidSerial: deal.bidSerial,
            grainType: deal.grainType,
            quantity: deal.quantity,
            price: deal.dealPrice,
            amount: 0
        }
    },

    confirm: function () {
        debugger
        var selectList = layui.table.checkStatus('myTable1').data;

        if (null == selectList || selectList.length == 0) {
            layerMsgError("请勾选数据");
            return;
        }

        var detailList = this.detailList();
        for (var i = 0; i < selectList.length; i++) {
            var detail = this.toDetail(selectList[i]);
            this.initDetail(detail);
            detailList.push(detail);
        }
        this.detailList(detailList);
        this.hideModal();
    },
    renderTable1: function () {

        layui.table.render({
            elem: "#myTable1",
            loading: true,
            url: '../rotateConclute/listDetailForPay.shtml',
            method: "POST",
            request: {
                pageName: 'pageIndex',
                limitName: 'pageSize'
            },
            width: 850,
            cols: [[
                {checkbox: true, fixed: true},
                {field: 'dealSerial', title: '成交子明细号', width: 200, align: 'center'},
//				{field:'inviteType',title:'轮换类型',width:110,align:'center'},
                {field: 'grainType', title: '粮食品种', width: 110, align: 'center'},
                {field: 'quantity', title: '数量(吨)', width: 150, align: 'center'},
                {field: 'dealPrice', title: '成交价格(元/吨)', width: 150, align: 'center'},
                {field: 'dealUnit', title: '成交单位', width: 140, align: 'center'},
                {field: 'dealDate', title: '成交时间', width: 140, align: 'center'}
            ]],
            page: true,//开启分页
            limit: pagesize,
            limits:[10],
            id: "myTable1"
        });
    },

    reloadTable1: function () {
        var startDealDate = $('input[name="startDealDate"]').val();
        var endDealDate = $('input[name="endDealDate"]').val();
        var deatUnit = $("input[name='dealUnit']").val();
        // debugger
        if (startDealDate != null && endDealDate != null && new Date(startDealDate) > new Date(endDealDate)) {
            layerMsgError("成交时间输入有误");
            return;
        }

        layui.table.reload("myTable1", {
            method: "POST",
            where: {
                // dealSerial:$('#search2 [name="dealSerial"]').val(),
                grainType: $("select[name='grainType']").val(),
                dealUnit: deatUnit,
                startDealDate: startDealDate,
                endDealDate: endDealDate,
            }
        });
    },
    remove: function (index) {
        var detailList = this.detailList();
        detailList.splice(index, 1);
        this.detailList(detailList);
    }
}