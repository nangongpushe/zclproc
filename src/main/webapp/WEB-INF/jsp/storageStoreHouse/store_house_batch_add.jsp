<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../common/AdminHeader.jsp" %>

<style>
    /*.layui-table-cell{min-height: 30px}*/


</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>代储监管</li>
        <li>企业信息</li>
        <li class="active">仓房批量新增</li>
    </ol>
</div>


<div class="container-box clearfix" style="padding: 10px">
    <form class="layui-form" lay-filter="form">
        <div class="layui-row title">
            <h5>仓房信息</h5>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-inline">
                <button type="button" class=" layui-btn layui-btn-primary layui-btn-small" lay-submit lay-filter="addCols">
                    <i class="layui-icon">&#xe654;</i>新增一行
                </button>
                <button type="button" class=" layui-btn layui-btn-primary layui-btn-small" lay-submit lay-filter="save">
                    <i class="layui-icon">&#xe605;</i>保存
                </button>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">所属库点：</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="warehouse" readonly>
                    <input type="hidden" name="warehouseId">
                    <input type="hidden" name="warehouseCode">
                </div>
                <div class="layui-input-inline">
                    <button type="button" class=" layui-btn layui-btn-primary layui-btn-small" lay-submit lay-filter="chooseWarehosue">
                        选择
                    </button>
                </div>
            </div>
        </div>
        <table id="storehouse" class="layui-table" lay-filter="storehouse"/>
    </form>

</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script type="text/html" id="toolbar">
    <button type="button" class="layui-btn layui-btn-primary layui-btn-mini" lay-event="del" >删除</button>
</script>

<script type="text/html" id="status">
    <span lay-event="status"></span>
    <select class="layui-select" lay-filter="status" name="status">
        <option value=""></option>
        <c:forEach items="${statusDict }" var="item">
            <option value="${item.value }">${item.value }</option>
        </c:forEach>
    </select>
</script>

<script type="text/html" id="type">
    <span lay-event="type"></span>
    <select class="layui-select" lay-filter="type" name="type">
        <option value=""></option>
        <c:forEach items="${typeDict }" var="item">
            <option value="${item.value }">${item.value }</option>
        </c:forEach>
    </select>
</script>

<script type="text/html" id="info">
    <div class="layui-form">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">库点简称:</label>
                <div class="layui-input-inline">
                    <input type="text" name="searchShort" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">库点名称:</label>
                <div class="layui-input-inline">
                    <input type="text" name="searchName" autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-inline">
                <button class=" layui-btn layui-btn-primary layui-btn-small" lay-submit lay-filter="search">查询</button>
            </div>
        </div>
    </div>
    <table id="warehouse" class="layui-table" lay-filter="warehouse"/>
</script>

<script>
    // 初始化操作
    var dataTemplate = {
        encode: "",
        type: "",
        status: "",
        enableDate: "",
        isStop: "N",
    };
    var typeList = [
        {key:"平房仓",value:"平房仓"},
        {key:"筒仓",value:"筒仓"},
        {key:"圆仓",value:"圆仓"},
        {key:"楼房仓",value:"楼房仓"},
        {key:"立筒仓",value:"立筒仓"},
        {key:"其他",value:"其他"},
    ];
    var statusList = [
        {key:'空仓',value:'空仓'},
        {key:'满仓',value:'满仓'},
        {key:'入库中',value:'入库中'},
        {key:'出库中',value:'出库中'},
        {key:'维修',value:'维修'},
        {key:'其他',value:'其他'},
    ];

    var dataList = [dataTemplate];
    layui.use(['form', 'table', 'laydate','jquery'], function () {
        var form = layui.form;
        var table = layui.table;
        var laydate = layui.laydate;
        var $ = layui.$;

        table.render({
            elem : '#storehouse',
            data : dataList,
            page : false,
            height: '600',
            cols :[[
                {field : 'storehouseName', title : '仓房名称',fixed: true, width:150, align:'center', edit : true,},
                {field : 'encode', title : '<span stype="color:red">*</span>仓房编号', fixed: true, width:100, align:'center', edit :true},
                {field : 'message', title : '失败提示', fixed: true, width:100, align:'center'},
                {field : 'type', title : '<span stype="color:red">*</span>仓房类型', width:150, align:'center', templet: '#type'},
                {field : 'status', title : '仓房状态', width:150, align:'center', templet: '#status'},
                {field : 'enableDate', title : '启用日期', width:150, align:'center',edit:true, event:'setDate'},
                /*{field : 'structure', title : '结构', width:150, align:'center', edit :true},
                {field : 'bulkHeight', title : '堆粮线高（m）', width:150, align:'center', edit :true},
                {field : 'gateNum', title : '仓门数量（扇）', width:150, align:'center', edit :true},
                {field : 'cfa', title : '建筑面积（长*宽）（㎡）', width:150, align:'center', edit :true},
                {field : 'siloDiameter', title : '筒仓外径(m)', width:150, align:'center', edit :true},
                {field : 'siloBore', title : '筒仓内径(m)', width:150, align:'center', edit :true},
                {field : 'siloVolume', title : '筒仓体积(m³)', width:150, align:'center', edit :true},
                {field : 'gateHeight', title : '仓门高度(m)', width:150, align:'center', edit :true},
                {field : 'gateWidth', title : '仓门宽度(m)', width:150, align:'center', edit :true},
                {field : 'eavesHeight', title : '檐高(m)', width:150, align:'center', edit :true},
                {field : 'designedCapacity', title : '设计容量(t)', width:150, align:'center', edit :true},*/
                {field : 'authorizedCapacity', title : '核定容量(t)', width:150, align:'center', edit :true},
                // {field : 'bulkArea', title : '粮堆面积（长*宽）（㎡）', width:150, align:'center', edit :true},
                // {field : 'ventNum', title : '通风口数量（个）', width:150, align:'center', edit :true},
                // {field : 'ductType', title : '风道类型', width:150, align:'center', edit :true},
                // {field : 'siloTightness', title : '实仓气密性（S）', width:150, align:'center', edit :true},
                // {field : 'axialNum', title : '轴流风机数（台）', width:150, align:'center', edit :true},
                // {field : 'storeType', title : '存放类型', width:150, align:'center', edit :true},
                // {field : 'buildingType', title : '建筑类型', width:150, align:'center', edit :true},
                // {field : 'longitude', title : '仓房经度', width:150, align:'center', edit :true},
                // {field : 'latitude', title : '仓房纬度', width:150, align:'center', edit :true},
                // {field : 'length', title : '仓房长度(m)', width:150, align:'center', edit :true},
                // {field : 'width', title : '仓房宽度(m)', width:150, align:'center', edit :true},
                // {field : 'height', title : '仓房高度(m)', width:150, align:'center', edit :true},
                // {field : 'keeper', title : '保管员', width:150, align:'center', edit :true},
                // {field : 'remark', title : '注释信息', width:150, align:'center', edit :true},
                // {field : 'heatInsulation', title : '隔热措施', width:150, align:'center', edit :true},
                //{field : 'isStop', title : '是否停用', width:150, align:'center',event:'isStop', templet: '<div><input type="checkbox" lay-skin="switch" lay-text="开启|关闭" lay-filter="isStop" name="isStop" ></div>'},
                {fixed: 'right', title : '操作', width:150, align:'center', toolbar: '#toolbar'},
            ]],
            id: "storehouse",
            limit: 100,
            done: function (res, curr, count) {
                let tableView = this.elem.next(".layui-table-view");
                layui.each(tableView.find('tbody select'), function (index, item) {
                    let elem = $(item);
                    elem.parents('div.layui-table-cell').css('overflow', 'visible');
                });
                $.each(res.data, function (index,value) {
                    let elem = $('.layui-table-main [data-index="'+index+'"]');
                    elem.find("select[name='type']").val(value.type);
                    elem.find("select[name='status']").val(value.status);

                    if(value.isStop==='Y')
                        elem.find("input[name='isStop']").attr("checked",true);
                });
                form.render();
            }
        });

        form.render();
        form.on('submit(save)', function () {
            let warehouseId = $("input[name='warehouseId']").val();
            let warehouse = $("input[name='warehouse']").val();
            let warehouseCode = $("input[name='warehouseCode']").val();

            if(warehouseId==null || warehouseId == ""){
                layerMsgError("请选择所属库点");
                return;
            }

            let data = table.cache['storehouse'];
            // 清理空对象
            processArray(data);

            // 判断必填项
            let flage = false;
            $.each(data,function (index,value) {
               if(value.encode == null || $.trim(value.encode) == "" || value.type == null || $.trim(value.type) == ""){
                    flage = true;
                    return false;
               }
            });
            if(flage){
                layerMsgError("存在必填项未填写");
                return;
            }

            // 检查仓房编号是否重复
            let sameEncode = [];
            for(let i = 0;i < data.length - 1;i++){
                for(let j = i+1; j <data.length;j++){
                    if(data[i].encode==data[j].encode){
                        sameEncode.push(data[i].encode);
                    }
                }
            }
            if(sameEncode.length > 0 ){
                layerMsgError("存在重复的仓房编号：" + sameEncode.join('，'))
            }

            // 将库点信息放入
            $.each(data, function (index,value) {
                value['warehouse'] = warehouse;
                value['warehouseId'] = warehouseId;
                value['warehouseCode'] = warehouseCode;
            })

            console.log(data);
            $.ajax({
                url:"${ctx}/storageStoreHouse/addBatchStorageStoreHouse.shtml",
                type:"post",
                data: JSON.stringify(data),
                contentType:"application/json",
                success: function (result) {
                    let data = {
                        type: "",
                        status: "",
                        enableDate: "",
                        isStop: "N",
                    };
                    if(result.success){
                        layerMsgSuccess(result.msg);
                        table.reload('storehouse',{data:result.data});
                        form.render();
                    }else{
                        table.reload('storehouse',{data:result.data});
                        layerMsgError("库点中已存在下列仓房，请进行修改");
                        form.render();
                    }
                },
                errorr: function (result) {

                }
            });

        });

        // 新增行
        form.on('submit(addCols)',function () {
            var oldData = table.cache['storehouse'];
            let data = {
                type: "",
                status: "",
                enableDate: "",
                isStop: "N",
            };
            oldData.push(data);
            table.reload("storehouse",{
                data : oldData,
            });
            form.render();
        });

        // 选择所属库点
        form.on('submit(chooseWarehosue)', function () {
            layer.open({
                title: "库点选择",
                content : $("#info").html(),
                offset: ['100px', '350px'],
                area:['830px','700px'],
                yes:function (index) {
                    let checkStatus = table.checkStatus('warehouse');
                    if(checkStatus.data.length==0)
                        return;
                    if(checkStatus.data.length>1){
                        layerMsgError("只能选择一个库点");
                        return ;
                    }
                    let data = checkStatus.data[0];
                    $("input[name='warehouse']").val(data.warehouseShort);
                    $("input[name='warehouseId']").val(data.id);
                    $("input[name='warehouseCode']").val(data.warehouseCode);
                    form.render();
                    layer.close(index);
                },
                success : function () {
                    table.render({
                        elem: "#warehouse",
                         url:'../storageWarehouse/selectWarehouseListByEnterprise.shtml',
                        //url: "../storageWarehouse/hostPageList.shtml",
                        method: "POST",
                        loading:false,
                        width: 770,
                        cols: [[
                            {checkbox: true,},
                            {field: 'warehouseCode', title: '库点代码', width: 200, align: 'center'},
                            {field: 'warehouseShort', title: '库点简称', width: 200, align: 'center'},
                            {field: 'warehouseName', title: '库点名称', width: 320, align: 'center'},
                        ]],
                        request: {
                            pageName: 'page',
                            limitName: 'pageSize'
                        },
                        page: true,//开启分页
                        limit: pagesize,
                        limits:[10],
                        id: "warehouse"
                    });
                }
            });

        });

        form.on('submit(search)', function () {
           table.reload("warehouse",{
               method: "POST",
               where: {
                   warehouseName : $("input[name='searchName']").val(),
                   warehouseShort : $("input[name='searchShort']").val(),
               }
           })
        });

        form.on('switch(isStop)', function () {
            $(this).prev("[lay-event='isStop']").click();
        });

        form.on('select(status)', function () {
            $(this).parents(".layui-table-cell").find("[lay-event='status']").click();
        });

        form.on('select(type)', function () {
            $(this).parents(".layui-table-cell").find("[lay-event='type']").click();
        });

        table.on('tool(storehouse)',function (obj) {
            let data = obj.data;        // 获取行对象
            let tr = obj.tr;            // 获取行DOM

            if(obj.event === "del") {      // 删除行
                obj.del();
            } else if(obj.event === "setDate"){   // 启用日期
                let field = $(this).data("field");
                let input = $('input',this);
                $(input[0]).attr('readonly', true);
                let elemCell = $("div",this)[0];
                laydate.render({
                    elem: input[0],
                    show: true,
                    closeStop: elemCell,
                    done: function (value,date,endDate) {
                        data[field] = value;
                        obj.update(data);
                        table.reload("storehouse");
                    },
                });
            }else if(obj.event === "isStop"){   //  修改是否停用
                data['isStop'] = tr.find("input[name='isStop']").prop("checked") ? 'Y': 'N';
                obj.update(data);
            } else if(obj.event === "status"){
                data['status'] = tr.find('select[name="status"] option:selected').val();
                obj.update(data);
            } else if(obj.event === "type"){
                data['type'] = tr.find('select[name="type"] option:selected').val();
                obj.update(data);
            }
            // 获取数据
            let tableList = table.cache['storehouse'];

            // 清理空对象
            processArray(tableList);
            table.reload("storehouse",{data:tableList});
            form.render();
        });



        table.on('edit(storehouse)', function ( obj ) {
            let value = obj.value;  // 修改后的值
            let field = obj.field;  // 当前编辑的字段名
            let data = obj.data;    // 所在行的所有相关数据
            let checkFields = ['bulkHeight','storehouseName'];  // 需要检验的字段名
            // 去除输入数据的前后空格
            data[field] = $.trim(value);

            // 对输入进行校验
            if($.inArray(field,checkFields) != -1){

            }

            if(field === 'encode')
                data[field] = value.toUpperCase();

            let tableList = table.cache['storehouse'];
            tableList[data.LAY_TABLE_INDEX] = data;
            table.reload("storehouse",{data:tableList});
            form.render();
        })

    });

    function renderSelectOptions(options, settings) {
        if(options && options.length > 0){
            settings = settings || {};
            let keyField = settings.keyField || 'key',
                valueField = settings.valueField || 'value',
                selectedValue = settings.selectedValue || '';
            let html = [];
            $.each(options, function (index, value) {
                html.push('<option value="');
                html.push(value[valueField]);
                html.push('"');
                if(selectedValue && value[keyField] == selectedValue){
                    html.push(" selected ");
                }
                html.push(">");
                html.push(value[keyField]);
                html.push("</option>");
            });
            return html.join("");
        } else {
            return "";
        }
    };

    function isEmptyObj(o) { for (let attr in o) return !1; return !0 }
    function processArray(arr) {
        for (let i = arr.length - 1; i >= 0; i--) {
            if (arr[i] === null || arr[i] === undefined) arr.splice(i, 1);
            else if (typeof arr[i] == 'object') removeNullItem(arr[i], arr, i);
        }
        return arr.length == 0
    }
    function proccessObject(o) {
        for (let attr in o) {
            if (o[attr] === null || o[attr] === undefined) delete o[attr];
            else if(typeof o[attr]=='object') {
                removeNullItem(o[attr]);
                if (isEmptyObj(o[attr])) delete o[attr];
            }
        }
    }
    function removeNullItem(o,arr,i) {
        let s = ({}).toString.call(o);
        if (s == '[object Array]') {
            if (processArray(o) === true) {//o也是数组，并且删除完子项，从所属数组中删除
                if (arr) arr.splice(i, 1);
            }
        }
        else if (s == '[object Object]') {
            proccessObject(o);
            if (arr&&isEmptyObj(o)) arr.splice(i, 1);
        }
    }
</script>

<%@include file="../common/AdminFooter.jsp" %>