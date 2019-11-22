<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>质量管理</li>
        <li class="active">结果导入</li>
    </ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
    <div class="layui-form" id="search">
        <div class="layui-form-item">
            <%--<div class="layui-inline">
                <label class="layui-form-label ">模板名称:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="templetId" id="templetId" autocomplete="off" type="hidden">
                    <input class="layui-input" name="templetName" id="templetName" autocomplete="off" onclick="toAddSelect();">
                        <input type="hidden" name="templetNo" lay-verify="required" id="templetNo"   class="form-control "  placeholder=""/>
                </div>
            </div>--%>
            <input class="layui-input" name="templetId" id="templetId" value="${templateId}"  autocomplete="off" type="hidden">
            <div class="layui-inline">
               文件原始名称:${qualityResultFile.fileName}
            </div>
            <div class="layui-inline">
                文件导入日期:${qualityResultFile.createDate1}
            </div>
            <div class="layui-inline">

                <label class="layui-form-label " style="text-align:right">是否导入:</label>
                <div class="layui-input-inline">
                    <select lay-verify="required" class="form-control "  name="status" id="status" lay-filter="status">
                        <%--<option value="">--请选择--</option>--%>
                        <option value="0">未导入</option>
                        <option value="1">已导入</option>
                    </select>
                </div>
            </div>
                <input type="hidden" name="checkType" lay-verify="required" id="checkType" value="${qualityResultFile.checkType}"   class="form-control "  placeholder=""/>
            <input type="hidden" name="resultFileId" lay-verify="required" id="resultFileId" value="${resultFileId}"   class="form-control "  placeholder=""/>
                <div class="layui-inline">
                <div class="layui-inline" >
                    <button class="layui-btn layui-btn-primary layui-btn-small" id="reload" data-type="reload">查询</button>
                    <button class="layui-btn layui-btn-primary layui-btn-small" id="backup" onclick="back1('${ctx}/QualityResult/QualityResultFile.shtml')" >返回</button>
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label " style="text-align:right">检验类型:</label>
            <div class="layui-input-inline">
                <select lay-verify="required" class="form-control validate[required]"  name="validType" id="validType">
                    <option value="">--请选择--</option>
                    <c:forEach items="${validTypes}" var="item">
                        <option value="${item.value}">${item.value}</option>
                    </c:forEach>
                </select>
            </div>

        </div>
        <%--<button class="layui-btn layui-btn-primary layui-btn-small" data-type="importResult">导入结果</button>--%>

        <button class="layui-btn layui-btn-primary layui-btn-small" lay-event="importResult" id="importResult" onclick="importResult();">导入结果</button>
        <button class="layui-btn layui-btn-primary layui-btn-small" id="delData">批量删除</button>
    </div>

    <!-- layui表格 -->
    <table lay-filter="test" id="mytable"></table>
    <script type="text/html" id="barDemo">
        <%--<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>--%>
        <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
        <%--<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>--%>
    </script>
</div>



<script>

    var resultFileId = '${resultFileId}';
    var form = layui.form;
    form.render();

    form.on("select(status)", function (data) {
        $('#reload').click();

        var status = $(data.elem).find("option:selected").val();
        if (status == 0) {
            //未导入，显示
            $('#importResult').css("display", "");
            $("#delData").show();
        } else {
            //已导入，隐藏
            $('#importResult').css("display", "none");
            $("#delData").hide();
        }

    });

    var table = layui.table;
    table.render();
    //执行渲染
    table.render({
        elem: '#mytable',
        url: '${ctx}/QualityResult/tempResultlist.shtml',
        /* width:1100, */
        method: 'post',
        cols: [[
            {checkbox: true, width: 69, align: 'center', fixed: true},
            {field: 'sampleNo', title: '样品编号', width: 150},
            {field: 'sampleName', title: '样品名称', width: 150},
            {field: 'remark', title: '备注', width: 150},
            {field: 'samplePlace', title: '抽样地点', width: 150},
            {field: 'basicNumber', title: '抽样基数(吨)', width: 150},
            {field: 'acceptedUnit', title: '承检单位', width: 150},
            {field: 'samplingDate', title: '扦样日期', width: 150},
            {field: 'testDate', title: '检验开始日期', width: 150},
            {field: 'testEndDate', title: '检验结束日期', width: 150},
            {field: 'enterpriseName', title: '受检单位', width: 150},
            {field: 'inspectedUnit', title: '库点简称', width: 150},
            {field: 'grade', title: '产品等级', width: 150},
            {field: 'storeType', title: '储存方式', width: 150},
            {field: 'origin', title: '粮食产地', width: 150},
            {field: 'inStoreDate', title: '入库年月', width: 150},
            {field: 'harvestYear', title: '收获年份', width: 150},

            {width: 160, align: 'center', toolbar: '#barDemo', title: '操作', width: 290, fixed: 'right'},

        ]],//设置表头
        where: {
            //传值 startDate : startDate,
            resultFileId: resultFileId,
            status: 0
        },
        page: false,//开启分页
        id: 'myTableID',
        done: function (res, curr, count) {

        },
    });

    //搜索
    $('#search button').click(function () {
        /*var templateId = $('#templetId').val();
        if(''==templateId || null ==templateId){
            alert("请选择模板")
            return ;
        }*/


        table.reload("myTableID", {
            method: 'post' //如果无需自定义HTTP类型，可不加该参数
            , where: {
                /*templateNo : $('#search #templetNo').val()
                resultFileId:$('#resultFileId').val()*/
                resultFileId: resultFileId,
                status: $('#status').val()
            }
        });
    });


    var upload = layui.upload;
    //执行实例
    var uploadInst = upload.render({
        elem: '#uploadExcel' //绑定元素
        , url: '${ctx}/QualityResult/uploadExcel.shtml'//上传接口
        , accept: 'file' //普通文件
        , exts: 'xls|xlsx' //只允许上传xlx和xlsx文件
        , before: function (obj) {
            this.data = {
                "templateId": $('#templetId').val(),
                "templateNo": $('#templetNo').val(),
                "templateName": $('#templetName').val()
            }//携带额外的数据
        }
        , done: function (res) {
            if (res.code == 0) {
                alert(res.msg);
                /* layer.open({title: '在线调试',content: '可以填写任意的layer代码'}); */
            } else {
                alert(res.msg);
            }
            //$('#search button').click();
            $('#reload').click();
            //location.href = "${ctx}/QualityResult/ImportQualityResult.shtml";
        }
        , error: function () {
            //请求异常回调
        }
    });
    //}

    table.on('tool(test)', function (obj) {
        var data = obj.data;
        console.log(data);
        blackList = data.blacklist;
        if (obj.event === 'detail') {

            location.href = "${ctx}/QualityResult/detailPage.shtml?id="
                + data.id;
        } else if (obj.event === 'del') {
            layer.confirm('确定删除吗？', function (index) {
                $.post("${ctx}/CustomerInformation/remove.shtml", {
                    id: data.id
                }, function (result) {
                    layer.closeAll(); //疯狂模式，关闭所有层
                    layer.open({
                        title: '提示信息'
                        , content: result.msg
                    });
                    table.reload("myTableID", {
                        method: 'post', //如果无需自定义HTTP类型，可不加该参数
                        where: {
                            clientName: $('#search #clientName').val(),
                            enterpriseNature: $('#search #enterpriseNature').val(),
                            industry: $('#search #industry').val(),
                            blacklist: $('#search #blacklist').val(),

                        }
                    });
                });
            });
        } else if (obj.event === 'edit') {
            location.href = "${ctx}/QualityResult/editTempResultPage.shtml?id=" + data.id + "&resultFileId=" + $('#resultFileId').val();
        }

    });

    function importResult() {
        var checkStatus = table.checkStatus('myTableID');
        var data = checkStatus.data;
        var ids = "";
        var templateId = $('#templetId').val();
        var checkType = $('#checkType').val();
        let validType = $("select[name='validType'] option:selected").val();

        if(validType==null||validType==""){
            layer.msg("请选择检验类型");
            return;
        }
        layer.load();
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                if (ids == "") {
                    ids = data[i].id;
                } else {
                    ids += "-" + data[i].id;
                }
            }
            let postData = {
                ids : ids,
                templateId : templateId,
                checkType : checkType,
                validType : validType,
            }
            $.post("${ctx}/QualityResult/importResult.shtml", postData, function (result) {
                layer.closeAll('loading');
                if (result.success) {
                    alert(result.msg);
                } else {
                    alert("导入失败");
                }
                //location.href="${ctx}/CustomerInformation.shtml";
                //$('#reload').click();
                window.location.reload();
            });
            //location.href = "${ctx}/CustomerInformation/inblacklist.shtml?ids="+ids;
        } else {
            layer.open({
                title: '提示信息'
                , content: '请勾选记录'
            });
            layer.closeAll('loading');
        }

    }


    //新增js
    function toAddSelect() {
        $.colorbox({
            title: '选择粮油数据',
            iframe: true,
            opacity: 0.2,
            href: "${ctx}/QualityThird/listChoice.shtml?",
            innerWidth: '1100px',
            innerHeight: '80%',
            close: '×15151',
            fixed: true
        });
    }

    //模板下载
    function downloadResultTemplate() {
        var templetId = $('#templetId').val();
        //alert(templetId)
        if ('' == templetId) {
            alert("请先选择模板！");
            return false;
        }
        window.location.href = '../QualityResult/downloadResultTemplate.shtml?templateId=' + templetId
    }

    function selectToData(data) {
        $("input[name='templetNo']").val(data.templetNo);
        $("input[name='templetName']").val(data.templetName);
        $("input[name='templetId']").val(data.id);
    }

    function back1(url) {
        location.href = url;
    }

    /**
     * 批量删除
     */
    $("#delData").click(function () {
        let ids = [];
        let url = "${ctx}/QualityResult/delImportData.shtml";
        // 获取选中的数据
        let checkStatus = layui.table.checkStatus("myTableID").data;
        if (checkStatus == null || checkStatus.length <= 0) {
            layer.msg("请选择要删除的数据");
            return;
        }
        $.each(checkStatus, function (index, obj) {
            ids.push(obj.id);
        });
        $.ajax({
            type: "POST",
            url: url,
            data: JSON.stringify(ids),
            contentType: 'application/json',
            success: function (result) {
                if (result.code == "0") {
                    layerMsgSuccess("成功删除" + result.data + "条数据");
                    layui.table.reload("myTableID");
                } else {
                    if(result.msg != null && result.msg != "")
                        layerMsgError(result.msg);
                    else
                        layerMsgError("删除失败，请稍后重试");
                }
            },
            error : function () {
                layerMsgError("删除失败，请稍后重试");
            }
        });
    });

</script>
<%@include file="../common/AdminFooter.jsp"%>