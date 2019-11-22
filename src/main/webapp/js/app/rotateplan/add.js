var idStr = [];

function Add(isedit, id, detailList, rotatePlanmain, planname, grainLevel, oilLevel) {
    this.form = layui.form;
    this.isedit = isedit;
    this.id = id;
    //this.grainTypes = grainTypes || [];
    this.grainLevel = grainLevel;
    this.oilLevel = oilLevel;
    this.storeTypes = ["散装","包装"];
    this.excludeInIds = [];//查询轮入弹框内容时过滤掉包含这些id的数据
    this.excludeOutCondition = [];//查询轮出弹框内容时过滤掉包含对应库点仓号的数据
    //this.quotas = quotas;
    //this.quotasMap = {};//等级指标Map, 小麦->[一等,二等...]
    //this.initQuotas();

    if (isedit) {
        for (var i = 0; i < detailList.length; i++) {
            if('轮入' == detailList[i].rotateType){
                this.excludeInIds.push(detailList[i].planmaindetailId);
            }else if('轮出' == detailList[i].rotateType){
                this.excludeOutCondition.push(detailList[i])
            }

            this.initDetailByImport(detailList[i]);
        }
        this.planName = ko.observable(rotatePlanmain.planName || '');
        this.planname1 = ko.observable(planname || '');
        this.year = ko.observable(rotatePlanmain.year || '');
        this.stockout = ko.observable(rotatePlanmain.stockOut || 0);
        this.stockin = ko.observable(rotatePlanmain.stockIn || 0);
        this.modifier = ko.observable(rotatePlanmain.colletor || '');
        if (rotatePlanmain.planType == '01') {
            this.planType = ko.observable("年度计划");
        } else if (rotatePlanmain.planType == '02') {
            this.planType = ko.observable("超标粮食处置计划");
        } else if (rotatePlanmain.planType == '03') {
            this.planType = ko.observable("补充计划");
        } else {
            this.planType = ko.observable("");
        }
        this.state = ko.observable(rotatePlanmain.state || '');
        this.planmainID = ko.observable(rotatePlanmain.id || '');
        this.renderTable3(rotatePlanmain.id);
        this.renderTable6(rotatePlanmain.id);
    } else {
        this.planName = ko.observable('');
        this.planname1 = ko.observable('');
        this.year = ko.observable('');
        this.stockout = ko.observable('');
        this.stockin = ko.observable('');
        this.modifier = ko.observable('');
        this.planType = ko.observable('');
        this.state = ko.observable('');
        this.planmainID = ko.observable('');
    }
    this.detailList = ko.observableArray(detailList || []);

    this.rotateType = "轮入";
    var date = new Date();
    this.reportMonth = date.getFullYear() + "-12";
    this.storehouses = ko.observableArray([]);
}

Add.prototype = {
    initQuotas: function () {
        var grainType;
        for (var i = 0; i < this.quotas.length; i++) {
            grainType = quotas[i].type;
            if (this.quotasMap[grainType] == undefined) {
                this.quotasMap[grainType] = [].concat(quotas[i]);
            } else {
                this.quotasMap[grainType] = this.quotasMap[grainType].concat(quotas[i]);
            }
        }
    },

    initPage: function () {
        var self = this;
        this.renderEnterpriseTable();
        this.renderTable4();
        this.renderTable5();
        this.renderExcelImport("#file_in");
        this.renderExcelImport("#file_out");
        layui.laydate.render({
            elem: $('[name="reportMonth"]')[0],
            type: "month",
            format: "yyyy-MM",
            change: function(value, date, endDate){
                $('[name="reportMonth"]').val(value);
                if($(".layui-laydate").length){
                    $(".layui-laydate").remove();
                }
            },
        });

        layui.form.on('submit(save)', function (data) {
            var id = self.id;
            var isrepeat = false;
            var postData1 = data.field;
            var postData = {};
            postData.planName = postData1.planName;
            postData.planType = postData1.planType;
            postData.year = postData1.year;
            postData.planmainID = postData1.planmainID;
            var detailList = ko.toJS(self.detailList());
            if (detailList.length == 0) {
                layerMsgError("请添加计划明细");
                return false;
            }
            var willNumber = 0;
            for (var i = 0; i < detailList.length; i++) {
                if (detailList[i].rotateType == "轮入") {
                    detailList[i].yieldTime = $('#in tr[data-index="' + i + '"]').find('[name="yieldTime"]').val();
                    detailList[i].quality = $('#in tr[data-index="' + i + '"]').find('[name="quality"] option[value=' + detailList[i].qualityId + ']').text();
                    delete detailList[i].quotas;
                    if (isNaN(detailList[i].rotateNumber) ||
                        detailList[i].rotateNumber <= 0) {
                        layerMsgError('请检查轮换数量:轮入数量>0');
                        return false;
                    }
                    willNumber += detailList[i].rotateNumber;
                } else {
                    if (isNaN(detailList[i].rotateNumber) ||
                        detailList[i].rotateNumber <= 0 ||
                        Number(detailList[i].rotateNumber) > Number(detailList[i].realCapacity)) {
                        layerMsgError('请检查轮换数量:0<轮出数量≤实际库存');
                        return false;
                    }
                }
                if (detailList[i].isInput) {
                    detailList[i].isInput = 1;
                } else {
                    detailList[i].isInput = 0;
                }
            }

            postData.isedit = self.isedit;
            // alert(JSON.stringify(detailList));
            postData.detailList = JSON.stringify(detailList);
            //postData.detailList1=detailList;
            postData.department = $('[name="department"]').text();
            postData.colletor = $('[name="colletor"]').text();
            postData.colletorDate = $('[name="colletorDate"]').text();
            postData.modifier = $('[name="modifier"]').text();
            postData.modifyDate = $('[name="modifyDate"]').text();
            if (isedit)
                postData.id = self.id;
            postData.state = $(data.elem).attr("data-status");
            $.ajax({
                url: '../rotatePlan/getPlanname.shtml',
                type: 'post',
                success: function (plannamelist) {
                    $.each(plannamelist, function (index, a) {
                        if (id != 0) {
                            if (a.planName == postData.planName && a.id != id) {
                                isrepeat = true;
                                return false;
                            }
                        } else {
                            if (a.planName == postData.planName) {
                                isrepeat = true;
                                return false;
                            }
                        }

                    });
                    if (isrepeat) {
                        layer.confirm('已存在计划详情名称，确定要保存吗?', {
                            icon: 0,
                            title: '提示'
                        }, function () {//是
                            self.save(postData);
                            return false;
                        }, function (index) {//否
                            layer.close(index);
                        });
                    } else {
                        self.save(postData);
                        return false;
                    }

                }
            })
        });
    },
    save: function (postData) {
        layer.load();
        $.ajax({
            type: 'POST',
            url: '../rotatePlan/saveOrUpdate.shtml',
            data: postData,
            success: function (result) {
                if (result.success) {
                    layerMsgSuccess("操作成功", function () {
                        location.href = "../rotatePlan/main.shtml"
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
            location.href = "../rotatePlan/main.shtml";
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
    //轮入、轮出 模态框
    add: function (rotateType) {
        this.rotateType = rotateType;
        if (rotateType == "轮入") {
            //再次调用查询轮入数据，且已选择的数据不要查出来
            this.reloadTable6();
            $('#planDetail').modal('show');
        } else {
            //再次调用查询轮出数据，且已选择的数据不要查出来
            this.reloadTable3();
            $('#outModal').modal('show');
        }
    },
    renderTable1: function (id) {
        layui.table.render({
            elem: "#storeTable",
            loading: true,
            url: '../storageStoreHouse/storelist.shtml?warehouseId=' + id,
            method: "POST",
            width: 500,
            cols: [[
                {checkbox: true, fixed: true},
                {field: 'warehouse', title: '库点名称', width: 100, align: 'center'},
                {field: 'encode', title: '仓房编号', width: 100, align: 'center'},
                {field: 'type', title: '仓房类型', width: 100, align: 'center'},
                {field: 'authorizedCapacity', title: '实际仓容', width: 100, align: 'center'},
                {field: 'address', title: '地址', width: 200, align: 'center'}
            ]],
            page: true,//开启分页
            limit: pagesize,
            limits:[10],
            id: "storeTable"
        });

    },

    renderTable11: function (name) {
        layui.table.render({
            elem: "#storeTable",
            loading: true,
            url: '../storageStoreHouse/storehouselist.shtml?warehouseName=' + name,
            method: "POST",
            width: 500,
            cols: [[
                {checkbox: true, fixed: true},
                {field: 'warehouse', title: '库点名称', width: 100, align: 'center'},
                {field: 'encode', title: '仓房编号', width: 100, align: 'center'},
                {field: 'type', title: '仓房类型', width: 100, align: 'center'},

                {field: 'address', title: '地址', width: 100, align: 'center'}
            ]],
            page: true,//开启分页
            limit: pagesize,
            limits:[10],
            id: "storeTable"
        });

    },

    renderTable3: function (id) {
        var self = this;
        layui.form.render("select", "search3");
        layui.laydate.render({
            elem: $('#search3 [name="recepitYear"]')[0],
            type: "year",
            format: "yyyy",
            change: function(value, date, endDate){
                $('#search3 [name="recepitYear"]').val(value);
                if($(".layui-laydate").length){
                    $(".layui-laydate").remove();
                }
            },
        });

        layui.table.render({
            elem: "#myTable3",
            loading: true,
            url: '../kccx/list1.shtml?plandetailid=' + id,
            method: "POST",
            width: 1000,
            cols: [[
                {checkbox: true, fixed: true},
                {field: 'rotateNumber', title: '轮换数量(吨)', width: 100, align: 'center'},
                {field: 'detailNumber', title: '已轮换数量(吨)', width: 100, align: 'center'},
                {field: 'dealSerial', title: '交易号', width: 100, align: 'center'},
                {field: 'reportMonth', title: '报表月份', width: 100, align: 'center'},
                {field: 'reportWarehouse', title: '库点名称', width: 100, align: 'center'},
                {field: 'storehouse', title: '仓号', width: 100, align: 'center'},
                {field: 'variety', title: '品种', width: 100, align: 'center'},
                {field: 'quantity', title: '数量', width: 100, align: 'center'},
                {field: 'harvestYear', title: '收获年份', width: 100, align: 'center'},
                {field: 'origin', title: '产地', width: 100, align: 'center'},
                {field: 'brown', title: '出糙(%)', width: 100, align: 'center'},
                {field: 'unitWeight', title: '容重(g/l)', width: 100, align: 'center'},
                {field: 'impurity', title: '杂质(%)', width: 100, align: 'center'},
                {field: 'dew', title: '水分(%)', width: 100, align: 'center'},
                {field: 'yellowRice', title: '黄粒米(%)', width: 100, align: 'center'},
                {field: 'unsoundGrain', title: '不完善粒(%)', width: 100, align: 'center'},
                {field: 'wetGluten', title: '小麦湿面筋(%)', width: 100, align: 'center'},
                {field: 'koh', title: '酸价(KOH)(mg/g)', width: 100, align: 'center'},
                {field: 'packing', title: '包装', width: 100, align: 'center'},
                {field: 'bulk', title: '散装', width: 100, align: 'center'}
            ]],
            page: true,//开启分页
            limit: pagesize,
            limits:[10],
            id: "myTable3"
        });
    },

    reloadTable3: function () {
        var self = this;
        var excludeOutCondition = JSON.stringify(self.excludeOutCondition);
        layui.table.reload("myTable3", {
            method: "POST",
            where: {
                key: {
                    excludeOutCondition: excludeOutCondition,
                    variety: $('#search3 [name="variety"]').val(),
                    extendsWarehouse: $('#search3 [name="warehouse"]').val(),
                    storehouse: $('#search3 [name="storehouse"]').val(),
                    receiptYear: $('#search3 [name="recepitYear"]').val(),
                    origin: $('#search3 [name="origin"]').val(),
                    month: $('#search3 [name="reportMonth"]').val(),
                    warehouse_type: $('#search3 [name="warehouse_type"]').val()
                }
            }
        });
    },
    reloadTable6: function () {
        var self = this;
        layui.table.reload("myTable6", {
            method: "POST"
            /*where: {
                    excludeInIds: self.excludeInIds.join(',')
            }*/
        });
    },


    renderEnterpriseTable: function () {
        layui.form.render("select", "searchEnterprise");

        layui.table.render({
            elem: "#enterpriseTable",
            loading: true,
            url: '../StoreEnterprise/thisList.shtml',
            method: "POST",
            width: 770,
            cols: [[
                {checkbox: true, fixed: true},
                {field: 'id', title: "企业ID"},
                {field: 'enterpriseSerial', title: '企业代码', width: 200, align: 'center'},
                {field: 'shortName', title: '企业简称', width: 200, align: 'center'},
                {field: 'enterpriseName', title: '企业名称', width: 320, align: 'center'},
            ]],
            request: {
                pageName: 'page',
                limitName: 'pageSize'
            },
            page: true,//开启分页
            limit: pagesize,
            id: "enterpriseTable",
            done: function () {
                $("[data-field='id']").css('display', 'none');
            }
        });
    },

    reloadEnterprise: function () {
        layui.table.reload("enterpriseTable", {
            method: "POST",
            where: {
                enterpriseName: $('#searchEnterprise [name="enterpriseName"]').val(),
            }
        });
    },

    renderTable4: function (enterpriseId) {
        layui.form.render("select", "search4");

        layui.table.render({
            elem: "#myTable4",
            loading: true,
            // url:'../storageWarehouse/listValidWarehouse.shtml',
            url: "../storageWarehouse/hostPageList.shtml?enterpriseId=" + enterpriseId,
            method: "POST",
            width: 770,
            cols: [[
                {checkbox: true, fixed: true},
                {field: 'warehouseCode', title: '库点代码', width: 200, align: 'center'},
                {field: 'warehouseShort', title: '库点简称', width: 200, align: 'center'},
                {field: 'warehouseName', title: '库点名称', width: 320, align: 'center'},
            ]],
            request: {
                pageName: 'pageIndex',
                limitName: 'pageSize'
            },
            page: true,//开启分页
            limit: pagesize,
            id: "myTable4"
        });
    },

    reloadTable4: function () {
        layui.table.reload("myTable4", {
            method: "POST",
            where: {
                warehouseName: $('#search4 [name="warehouseName"]').val(),
                warehouseShort: $('#search4 [name="warehouseShort"]').val(),
            }
        });
    },
    renderTable5: function () {
        var width = 200;
        var self = this;
        layui.laydate.render({
            elem: $('#search5 [name="planyear1"]')[0],
            type: "year",
            format: "yyyy",
            change: function(value, date, endDate){
                $('#search5 [name="planyear1"]').val(value);
                if($(".layui-laydate").length){
                    $(".layui-laydate").remove();
                }
            },
        });

        layui.table.render({
            elem: "#myTable5",
            loading: true,
            url: '../rotatePlan/declareCompletelist.shtml',
            method: "POST",
            width: 1400,
            request: {
                pageName: 'pageIndex',
                limitName: 'pageSize'
            },
            cols: [[
                {checkbox: true, fixed: true},
                {field: 'planName', title: '计划名称', width: width, align: 'center'},//325
                {field: 'year', title: '年份', width: width, align: 'center'},//180
                {
                    field: 'stockOut',
                    title: '出库总数(吨)',
                    width: width - 4,
                    align: 'center',
                    templet: '#stockOut',
                    sort: true
                },//176
                {
                    field: 'stockIn',
                    title: '入库总数(吨)',
                    width: width - 4,
                    align: 'center',
                    templet: '#stockIn',
                    sort: true
                },//174
                {field: 'colletor', title: '创建人', width: width - 50, align: 'center'},//178
                {
                    field: 'colletorDate',
                    title: '创建时间',
                    width: width,
                    align: 'center',
                    templet: '#colletorDateFormat',
                    sort: true
                },//184
                {field: 'state', title: '审批状态', width: width, align: 'center'},//160
            ]],
            page: true,//开启分页
            limit: pagesize,
            limits:[10],
            id: "myTable5",
            done: function (res, curr, count) {
                $('#myTable5').next().find('a[data-id]').click(function () {
                    self.show(this);
                })
            }
        });
    },

    reloadTable5: function () {
        layui.table.reload("myTable5", {
            method: "POST",
            where: {
                planName1: $('#search5 [name="planName1"]').val(),
                planyear1: $('#search5 [name="planyear1"]').val(),
                colletor1: $('#search5 [name="colletor1"]').val(),
            }
        });
    },

    renderTable6: function (planID) {
        var width = 100;
        var self = this;
        layui.table.render({
            elem: "#myTable6",
            loading: true,
            url: '../rotatePlan/plandetail.shtml?sid=' + planID,
            method: "POST",
            width: 655,
            request: {
                pageName: 'pageIndex',
                limitName: 'pageSize'
            },
            cols: [[
                {checkbox: true, fixed: true},
                {field: 'rotateType', title: '轮换类别', width: width, align: 'center'},//325
                {field: 'foodType', title: '粮食品种', width: width, align: 'center'},//180
                {field: 'yieldTime', title: '收获年份', width: width, align: 'center'},//176
                {field: 'orign', title: '产地', width: width, align: 'center'},//174
                {field: 'rotateNumber', title: '轮换数量(吨)', width: width, align: 'center'},//178
                {field: 'detailNumber', title: '已轮换数量(吨)', width: width, align: 'center'},//184
            ]],
            page: true,//开启分页
            limit: pagesize,
            limits:[10],
            id: "myTable6"
        });
    },

    renderTable7: function () {
        layui.form.render("select", "searchQualityResult");
        layui.laydate.render({
            elem: $('#searchQualityResult [name="harvestYear"]')[0],
            type: "year",
            format: "yyyy",
            change: function(value, date, endDate){
                $('#searchQualityResult [name="harvestYear"]').val(value);
                if($(".layui-laydate").length){
                    $(".layui-laydate").remove();
                }
            },
        });

        layui.table.render({
            elem: "#myqualityResultModalTable",
            loading: true,
            url: '../QualityResult/selectQualityResult.shtml',
            method: "POST",
            width: 1300,
            request: {
                pageName: 'pageIndex',
                limitName: 'pageSize'
            },
            cols: [[
                {checkbox: true, fixed: true},
                {field: 'storeEncode', title: '仓号', width: 100, align: 'center'},
                {field: 'variety', title: '粮食品种', width: 100, align: 'center'},
                {field: 'harvestYear', title: '收获年份', width: 100, align: 'center'},
                {field: 'origin', title: '产地', width: 100, align: 'center'},
                {field: 'sampleNo', title: '样品编号', width: 100, align: 'center'},
                {field: 'reportUnit', title: '检测单位', width: 100, align: 'center'},
                {field: 'quantity', title: '数量', width: 100, align: 'center'},
                {field: 'testDate', title: '检测时间', width: 200, align: 'center'},
                // {field:'validType',title:'检验类型',width:100,align:'center'},
                {field: 'dealserial', title: '交易号', width: 200, align: 'center'},
            ]],
            page: true,//开启分页
            limit: pagesize,
            limits:[10],
            id: "myqualityResultModalTable"
        });
    },

    reloadTable7: function () {
        layui.table.reload("myqualityResultModalTable", {
            method: "POST",
            where: {
                variety1: $('#searchQualityResult [name="variety1"]').val(),
                harvestYear: $('#searchQualityResult [name="harvestYear"]').val(),
                storeEncode: $('#searchQualityResult [name="storeEncode"]').val(),
                origin1: $('#searchQualityResult [name="origin1"]').val()
            }
        });
    },
    showoutModel2: function (data) {
        this.planDeclarelist = data;
        $('#outModa2').modal('show');
    },


    showEnterpriseModal: function (data) {
        this.currentInDetail = data;
        $('#enterpriseModele').modal('show');
    },

    showModal: function (data, index) {
        let enterpriseId = $("tr[data-index=" + index + "] input[name='enterpriseName']").attr("enterpriseId");
        let enterpriseName = $("tr[data-index=" + index + "] input[name='enterpriseName']").val();
        if (enterpriseName == null || enterpriseName == "") {
            layui.layer.msg("请先选择所属企业");
            return;
        } else {
            this.renderTable4(enterpriseId);
        }

        this.currentInDetail = data;
        $('#inModal').modal('show');
    },

    // 更新模态框
    showstoreModal: function (data, index) {
        // 判断所属库点是否为空
        let libraryName = $("tr[data-index=" + index + "] input[name='libraryName']").val();
        if (libraryName == null || libraryName == "") {
            layui.layer.msg("请先选择所属库点");
            return;
        }

        var id = $("tr[data-index=" + index + "] input[name='libraryName']").attr("warehouseid");

        if (id != null && id != "") {
            this.renderTable1(id);
        } else {
            let detail1 = ko.toJS(data);
            let libraryName = detail1.libraryName;
            this.renderTable11(libraryName);
        }

        this.currentInDetail1 = data;
        $('#storeModal').modal('show');
    },

    selectWarehouse: function () {
        var selectList = layui.table.checkStatus("myTable4").data;

        if (null == selectList || selectList.length == 0) {
            layer.msg("请选择库点", {icon: 0});
            return;
        } else if (selectList.length > 1) {
            layer.msg("只能选择一个库点", {icon: 0});
            return;
        }
        this.currentInDetail.libraryName(selectList[0].warehouseShort);
        this.currentInDetail.warehouseid(selectList[0].id);
        this.currentInDetail.barnNumber("")
        if (selectList[0].isInput == 1) {
            this.currentInDetail.isInput(false);
        } else {
            this.currentInDetail.isInput(true);
        }
        // this.renderTable1(selectList[0].id);
        this.hideModal('inModal', 'myTable4');
    },

    selectEnterprise: function () {
        var selectList = layui.table.checkStatus("enterpriseTable").data;

        if (null == selectList || selectList.length == 0) {
            layer.msg("请选择所属企业", {icon: 0});
            return;
        } else if (selectList.length > 1) {
            layer.msg("只能选择一个所属企业", {icon: 0});
            return;
        }
        this.currentInDetail.enterpriseName(selectList[0].enterpriseName);
        this.currentInDetail.enterpriseId(selectList[0].id);
        this.currentInDetail.warehouseid("");
        this.currentInDetail.libraryName("");
        this.currentInDetail.barnNumber("");
        this.currentInDetail.isInput(false);

        if (selectList[0].isInput == 1) {
            this.currentInDetail.isInput(false);
        } else {
            this.currentInDetail.isInput(true);
        }
        this.hideModal('enterpriseModele', 'enterpriseTable');
    },
    selectStorehouse: function () {
        var selectList = layui.table.checkStatus("storeTable").data;

        if (null == selectList || selectList.length == 0) {
            layer.msg("请选择仓号", {icon: 0});
            return;
        } else if (selectList.length > 1) {
            layer.msg("只能选择一个仓号", {icon: 0});
            return;
        }
        this.currentInDetail1.barnNumber(selectList[0].encode);
        //this.currentInDetail1.barnNumber = selectList[0].encode
        this.hideModal('storeModal', 'storeTable');
    },


    remove: function (data, index) {
        var rotateType = data.rotateType;
        if('轮入' == rotateType){
            var excludeIndex = this.excludeInIds.indexOf(data.planmaindetailId);
            if (index > -1) {
                this.excludeInIds.splice(excludeIndex, 1);
            }
        }else if('轮出' == rotateType){
           /* var excludeIndex = this.excludeOutCondition.indexOf(data.planmaindetailId);
            if (index > -1) {
                this.excludeOutCondition.splice(excludeIndex, 1);
            }*/
           var excludeOutConditions =  this.excludeOutCondition;
           var tempexcludeOutConditions = [];
            for(var i = 0;i<excludeOutConditions.length;i++){
                var excludeOut = excludeOutConditions[i]
                if(excludeOut.libraryName != data.libraryName || excludeOut.barnNumber != data.barnNumber){
                    tempexcludeOutConditions.push(excludeOut);
                }
            }
            this.excludeOutCondition = tempexcludeOutConditions;
        }

        var detailList = this.detailList();
        detailList.splice(index, 1);
        this.detailList(detailList);
    },

    clearAllCondition: function () {
        $('#search3 [name="variety"]').val("");
        $('#search3 [name="warehouse"]').val("");
        $('#search3 [name="storehouse"]').val("");
        $('#search3 [name="recepitYear"]').val("");
        $('#search3 [name="origin"]').val("");
        $('#search3 [name="origin"]').val("");
        $('#search3 [name="reportMonth"]').val("");
        $('#search3 [name="warehouse_type"]').val("");
        var form = layui.form;
        form.render("select","search3");
    },

    show: function (elem) {
        var width = $('.container-box').innerWidth() - 300;
        var id = $(elem).attr('data-id');
        var rotateType = $(elem).attr('data-type');
        var url = "../rotatePlan/detailview.shtml";
        $.post(url, {sid: id, rotatetype: rotateType}, function (str) {
            layer.open({
                type: 1,
                title: rotateType + "计划明细",
                content: str,
                area: [width, '500px'],
                maxHeight: 400
            });
        });
    },


    clearAll: function () {
        $(".layui-select-title").find("input").each(function () {
            $(this).attr("value", "");
        });

        $("select[name='warehouse'] option:selected").attr("selected", false);
        $("select[name='warehouse'] option").eq(0).attr("selected", true);

        $("input[name='storehouse']").val("");

        // $("select[name='storehouse'] option:selected").attr("selected", false);
        // $("select[name='storehouse'] option").eq(0).attr("selected", true);

        $("select[name='variety'] option:selected").attr("selected", false);
        $("select[name='variety'] option").eq(0).attr("selected", true);

        $("input[name='recepitYear']").val("");
        $("input[name='origin']").val("");
        $("input[name='reportMonth']").val("");
    },

    hideModal: function (modal, tableId) {
        layui.table.reload(tableId);
        $('#' + modal).modal('hide');

    },
    selectConfirm: function (modal, tableId, type) {
        var selectList = layui.table.checkStatus(tableId).data;
        if (null == selectList || selectList.length == 0) {
            layerMsgError("请勾选数据信息");
            return;
        }

        var detailList = this.detailList();
        for (var i = 0; i < selectList.length; i++) {
            var detail = this.initDetail(selectList[i], type);
            this.excludeOutCondition.push(detail);
            detailList.push(detail);
        }
        this.detailList(detailList);
        //this.render(type);
        this.hideModal(modal, tableId);
    },

    selectPlandeclare: function (modal, tableId) {
        var plandeclare = layui.table.checkStatus(tableId).data;
        if (null == plandeclare || plandeclare.length == 0) {
            layerMsgError("请勾选数据信息");
            return;
        } else if (plandeclare.length > 1) {
            layer.msg("只能选择一条轮换计划", {icon: 0});
            return;
        }
        this.detailList([]);
        this.planDeclarelist.planmainID(plandeclare[0].id);
        this.planDeclarelist.planName(plandeclare[0].planName);
        this.planDeclarelist.planname1(plandeclare[0].planName);
        this.planDeclarelist.year(plandeclare[0].year);
        this.planDeclarelist.stockout(plandeclare[0].stockOut);
        this.planDeclarelist.stockin(plandeclare[0].stockIn);
        this.planDeclarelist.modifier(plandeclare[0].colletor);
        if (plandeclare[0].planType == '01') {
            this.planDeclarelist.planType("年度计划");
        } else if (plandeclare[0].planType == '02') {
            this.planDeclarelist.planType("超标粮食处置计划");
        } else if (plandeclare[0].planType == '03') {
            this.planDeclarelist.planType("补充计划");
        }
        this.planDeclarelist.state(plandeclare[0].state);
        this.renderTable3(plandeclare[0].id);
        this.renderTable6(plandeclare[0].id);
        this.hideModal(modal, tableId);
    },

    selectPlanDetail: function (modal, tableId, type) {
        var selectList = layui.table.checkStatus(tableId).data;
        if (null == selectList || selectList.length == 0) {
            layerMsgError("请勾选数据信息");
            return;
        } else if (selectList.length > 1) {
            layer.msg("只能选择一条轮入计划", {icon: 0});
            return;
        } else if (selectList[0].rotateType != '轮入') {
            layer.msg("请选择轮入的粮油品种", {icon: 0});
            return;
        }

        var detailList = this.detailList();
        for (var i = 0; i < selectList.length; i++) {
            this.excludeInIds.push(selectList[i].id)
            var detail = this.initDetail(selectList[i], type);
            detailList.push(detail);
        }
        this.detailList(detailList);
        //this.render(type);
        this.hideModal(modal, tableId);
    },
    initDetail: function (object, type) {
        var self = this;
        var detail = {};
        detail.rotateType = this.rotateType;
        if (type == '轮出') {
            detail.planmaindetailId = object.plandetailid;
            detail.libraryName = object.reportWarehouse;
            detail.warehouseid = "";
            detail.barnNumber = object.storehouse;
            detail.foodType = object.variety;
            detail.yieldTime = object.harvestYear;
            detail.orign = object.origin;
            //detail.storeType = ko.observable('');
            var bulk = object.bulk;
            var packing = object.packing;
            if(!bulk){
                //如果台账中散装数量为空或0
                if(!packing){
                    //如果台账中包装数量为空或0，则存储方式默认为散装
                    detail.storeType = ko.observable('散装');
                }else{
                    //如果台账中包装数量有值且不为0，则存储方式默认为包装
                    detail.storeType = ko.observable('包装');
                }
            }else{
                //如果台账中散装数量不为空
                if(!packing){
                    //如果台账中包装数量为空或0，则存储方式默认为散装
                    detail.storeType = ko.observable('散装');
                }else{
                    //如果台账中包装数量有值且不为0，则存储方式默认为散装
                    detail.storeType = ko.observable('散装');
                }
            }
            detail.approvalCapacity = "--";//轮出数据中无此字段
            detail.realCapacity = object.quantity;
            detail.rotateNumber = ko.observable(object.quantity);
            detail.quality = '--';
            detail.swtzId = object.reportId;
            detail.dealSerial =  ko.observable(object.dealSerial);
        } else {
            detail.planmaindetailId = object.id;
            detail.enterpriseName = ko.observable('');
            detail.enterpriseId = ko.observable('');
            detail.libraryName = ko.observable('');
            detail.warehouseid = ko.observable('');
            detail.isInput = ko.observable('');
            detail.barnNumber = ko.observable('');
            detail.qualityDetail = '';
            detail.foodType = ko.observable(object.foodType);
            detail.yieldTime = object.yieldTime;
            detail.orign = object.orign;
            detail.approvalCapacity = '';
            detail.realCapacity = "";//无此字段
            detail.rotateNumber = ko.observable('');
            detail.qualityId = object.qualityId;
            detail.storeType = ko.observable('');
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
        }
        return detail;
    },
    initDetailByImport: function (detail) {
        var self = this;
        if (detail.rotateType == "轮出") {
            detail.rotateNumber = ko.observable(detail.rotateNumber || 0);
            detail.quality = detail.quality || '--';
            detail.dealSerial = ko.observable(detail.dealSerial || "");
        } else if (detail.rotateType == "轮入") {
            detail.enterpriseId = ko.observable(detail.enterpriseId || "");
            detail.enterpriseName = ko.observable(detail.enterpriseName || "");
            detail.libraryName = ko.observable(detail.libraryName || "");
            detail.warehouseid = ko.observable(detail.warehouseid || "");
             detail.barnNumber=ko.observable(detail.barnNumber||"");//这个12.3之前为何注释掉
            detail.foodType = ko.observable(detail.foodType || "");
            detail.yieldTime = ko.observable(detail.yieldTime || "");
            detail.orign = ko.observable(detail.orign || "");
            if (detail.isInput == 1) {
                detail.isInput = ko.observable(false);
            } else {
                detail.isInput = ko.observable(true);
            }
            detail.rotateNumber = ko.observable(detail.rotateNumber || 0);
            detail.qualityId = ko.observable(detail.qualityId || "");
            detail.quality = detail.quality || "";
            detail.storeType = ko.observable(detail.storeType || "");
            detail.qualityDetail = detail.qualityDetail || "";
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
        }
    },
    //导入excel渲染
    renderExcelImport: function (elemid) {
        var self = this;
        Excel_Import({
            elem: elemid,
            url: "../rotatePlan/importExcel.shtml",
            data: {
                reportMonth: self.reportMonth
            },
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    self.initDetailByImport(data[i]);
                }
                var detailList = self.detailList();
                detailList = detailList.concat(data);
                self.detailList(detailList);
            }
        });
    },
    getGrainQuantites: function (grainType) {
        $.ajax({
            type: 'POST',
            url: '../rotatePlan/saveOrUpdate.shtml',
            data: postData,
            success: function (result) {
                if (result.success) {
                    layerMsgSuccess("操作成功", function () {
                        location.href = "../rotatePlan/main.shtml"
                    });
                } else {
                    layerMsgError(result.msg);
                }

            },
            error: function () {
                layer.closeAll();
                layerMsgError("error");
            }
        });
    },
    //导入excel渲染
    renderUploadFile: function (elemid) {
        var self = this;
        Excel_Import({
            elem: elemid,
            data: {
                reportMonth: self.reportMonth
            },
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    self.initDetailByImport(data[i]);
                }
                var detailList = self.detailList();
                detailList = detailList.concat(data);
                self.detailList(detailList);
            }
        });
    },

    showQualityResult: function (data, index) {
        this.renderTable7();
        this.index = index;
        $('#qualityResultModal').modal('show');
    },

    selectQualityResult: function (modal, tableId) {
        debugger;
        //   获取选中的数据
        var selectList = layui.table.checkStatus(tableId).data;
        //alert(JSON.stringify(selectList));
        if (null == selectList || selectList.length == 0) {
            layerMsgError("请勾选数据信息");
            return;
        } else if (selectList.length > 1) {
            layer.msg("只能选择一条质检结果", {icon: 0});
            return;
        }
        var detailList = this.detailList();
        var index = this.index;
        var oriObj = detailList[index];
        detailList.splice(index,1);
        this.detailList(detailList);

        oriObj.dealSerial  = ko.observable(selectList[0].dealserial|| "");
        detailList.splice(index, 0, oriObj); //

        this.detailList(detailList);
        this.hideModal(modal, tableId);
    },
    delStorehosue : function (obj,index) {
        let detailList = this.detailList();
        detailList[index].barnNumber("");

    },
    delWarehosue : function (index) {
        let detailList = this.detailList();
        detailList[index].warehouseid("");
        detailList[index].libraryName("");
        detailList[index].barnNumber("");
        detailList[index].isInput(false);
    },
    delEnterprise : function (index) {
        let detailList = this.detailList();
        detailList[index].enterpriseName("");
        detailList[index].enterpriseId("");
        detailList[index].warehouseid("");
        detailList[index].libraryName("");
        detailList[index].barnNumber("");
        detailList[index].isInput(false);
    }
};