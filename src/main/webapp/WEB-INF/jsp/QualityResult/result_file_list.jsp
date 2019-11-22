<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
    #mytable + .layui-form .layui-table-body td[data-field="templetNo"]{
        text-align: left;
    }
    #mytable + .layui-form .layui-table-body td[data-field="templetName"]{
        text-align: left;
    }
    #mytable + .layui-form .layui-table-body td[data-field="type"]{
        text-align: left;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>质量管理</li>
        <li>质检数据导入</li>
    </ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

    <div class="layui-form" id="search">
        <div class="layui-form-item">
            <div class="layui-inline">
            <label class="layui-form-label ">模板编号:</label>
            <div class="layui-input-inline">
                <input class="layui-input" name="templetId" id="templetId" autocomplete="off" type="hidden">
                <input class="layui-input" type="hidden" name="templetName" id="templetName" autocomplete="off" >
                <input type="text" name="templetNo" lay-verify="required" id="templetNo" onclick="toAddSelect();"  class="form-control "  placeholder=""/>
            </div>
        </div>
            <div class="layui-inline">
                <label class="layui-form-label ">质检类型:</label>
                <div class="layui-input-inline">
                    <select name="checkType" id="checkType" class="layui-input" lay-verify="required" lay-filter="checkType">
                        <option value="">请选择</option>
                        <option value="1">内部质检</option>
                        <option value="2">第三方质检</option>
                    </select>
                </div>
            </div>

            <div class="layui-inline">
                <button class="layui-btn layui-btn-primary layui-btn-small" id="searchFile" data-type="reload">查询</button>
                <button class="layui-btn layui-btn-primary layui-btn-small" onclick="downloadResultTemplate()">模板下载</button>
                <div class="layui-btn layui-btn-primary layui-btn-small" id="uploadExcel">上传结果</div>
                <input name="file" id="uploadId" type="hidden">
            </div>
        </div>
       <%-- <div class="layui-inline">
            <button class="layui-btn layui-btn-primary layui-btn-small" lay-event="add" onclick="add();">新增</button>
        </div>--%>
    </div>
    <!-- layui表格 -->
    <table lay-filter="test" id="mytable"></table>
    <script type="text/html" id="barDemo">
       <%-- <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>--%>
        <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">维护质检数据</a>
        <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
    </script>

</div>

<script>
    var form=layui.form;
    form.render();

    var table = layui.table;
    table.render();
    //执行渲染
    table.render({
        elem : '#mytable',
        url : '${ctx}/QualityResult/resultFileList.shtml',
        /*  width:1180,  */
        method:'post',
        cols : [[
            {field:'templateNo',title: '模板编号',width:300,fixed: true,align : 'center'},
            {field : 'fileName',title : '文件原始名称',width:300,align : 'center'},
            {field : 'fileRename',title : '保存文件名称',width:300,align : 'center'},
            {field : 'checkType',title : '质检类型',width:300,align : 'center',templet: '#titleTpl'},
            {field : 'createDate1',title : '创建时间',width:300,align : 'center'},

            {width : 160,align : 'center',toolbar : '#barDemo',title: '操作',width:290,fixed: 'right'},
        ]],//设置表头
        /* 		request : {

                    pageName : 'page',
                    limitName : 'pageSize'
                }, */
        page:true,//开启分页
        /* 		limit:10, */
        id:'myTableID',
        done:function(res,curr,count){
        },
    });
    function add(){
        location.href = "${ctx}/QualityTemplet/addPage.shtml";
    }
    table.on('tool(test)', function(obj) {
        var data = obj.data;
        console.log(data);
        if (obj.event === 'detail') {

        } else if (obj.event === 'del') {
            layer.confirm('您确认要删除该文件吗?', function(index) {
                $.post("${ctx}/QualityResult/delImportFile.shtml", {
                    id : data.id
                }, function(result) {
                    layer.closeAll(); //疯狂模式，关闭所有层
                    layer.open({
                        title: '提示信息'
                        ,content: result.msg
                    });
                    table.reload("myTableID", {
                        method: 'post', //如果无需自定义HTTP类型，可不加该参数
                        where : {
                            templetNo : $('#search #templetNo').val()
                        }
                    });
                });
            });
        } else if (obj.event === 'edit') {
            location.href = "${ctx}/QualityResult/ImportQualityResult.shtml?id="
                + data.id +"&fileName="+data.fileName +"&templateId="+data.templateId+"&createDate="+data.createDate1;
        }

    });


    //搜索
    $('#searchFile').click(function() {
        table.reload("myTableID", {
            method: 'post' //如果无需自定义HTTP类型，可不加该参数
            ,where : {
                templateNo : $('#search #templetNo').val()
            }
        });
    });

    //模板下载
    function downloadResultTemplate () {
        var templetId = $('#templetId').val();
        var checkType = $('#checkType').val();
        //alert(templetId)
        if(''==templetId){
            alert("请先选择模板！");
            return false;
        }
        if(!checkType){
            alert("请选择质检类型！");
            return false;
        }
        window.location.href = '../QualityResult/downloadResultTemplate.shtml?templateId='+templetId+'&checkType='+checkType;
    }

    var upload = layui.upload;
    //执行实例
    var uploadInst = upload.render({
        elem: '#uploadExcel' //绑定元素
        ,url: '${ctx}/QualityResult/uploadExcel.shtml'//上传接口
        ,accept: 'file' //普通文件
        ,exts: 'xls|xlsx' //只允许上传xlx和xlsx文件
        ,before: function(obj){
            this.data={"templateId": $('#templetId').val(),
                "templateNo":$('#templetNo').val(),
                "templateName":$('#templetName').val(),
                "checkType":$('#checkType').val()
            }//携带额外的数据
        }
        ,done: function(res){
            if(res.code==0){
                alert(res.msg);
                /* layer.open({title: '在线调试',content: '可以填写任意的layer代码'}); */
            }else{
                alert(res.msg);
            }
            //$('#search button').click();
            //$('#reload').click();
            location.href = "${ctx}/QualityResult/QualityResultFile.shtml";
        }
        ,error: function(){
            //请求异常回调
        }
    });

    function selectToData(data){
        $("input[name='templetNo']").val(data.templetNo);
        $("input[name='templetName']").val(data.templetName);
        $("input[name='templetId']").val(data.id);
    }
    function toAddSelect(){
        $.colorbox({
            title : '选择粮油数据',
            iframe : true,
            opacity	: 0.2,
            href : "${ctx}/QualityThird/listChoice.shtml?",
            innerWidth : '1100px',
            innerHeight : '80%',
            close : '×15151',
            fixed : true
        });
    }
</script>
<script type="text/html" id="titleTpl">
	{{#if(d.checkType=='1'){}}
	内部质检
	{{#}else if
	(d.checkType=='2'){}}
	 第三方质检
	{{#}}}
</script>
<%@include file="../common/AdminFooter.jsp"%>