<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
    .layui-table-view {
        margin: 10px 10px !important;
    }
    /* <!-- 页面的CSS --> */
    #outSide{
        width:94%;
        margin-left:2%;
        padding:1%;
        background:#fff;
        border-top:2px solid #23b7e5;
    }

    .infoArea{
        width:100%;
        padding:20px 0;
        border-bottom: 2px solid #e2e2e2;
    }

    .title{
        color:RGB(25,174,136);
        font-weight:bold;
    }

    #infoArea{
        margin-top:20px;
        margin-left:4%;
    }

    #infoArea span{
        padding-right:100px;
    }

    .requiredData{
        color:red;
    }

    #mainInfo{
        margin-top:20px;
        margin-left:2.5%;
    }

    #mainInfo>div{
        padding:10px 0;
        width:100%;
    }

    #mainInfo>div span{
        width:10%;
        display:inline-block;
        text-align:center;
    }

    .inputArea{
        width:89%;
        padding:5px;
        border-radius:5px;
        outline: none;
        border:1px solid #ccc;
        resize: none;
    }

    .buttonArea{
        padding:5px 15px;
        background:RGB(25,174,136);
        border:none;
        border-radius:5px;
        color:#fff;
        cursor:pointer;
        display:inline;
    }

    #listArea{
        padding:20px 0;
        width:100%;
    }

    table{
        margin-top:20px;
        width:100%;
        border-collapse:collapse;
        text-align:center;
    }

    thead{
        background:#eee;
    }

    table tr td{
        width:9%;
        border:none;
        padding:10px 0;
    }

    tbody tr{
        border-bottom:1px solid #ccc;
    }

    #bottom-button{
        text-align:right;
        padding-right:20px;
        margin-top:20px;
    }

    #bottom-button>div{
        margin-right:10px;
    }

    #template-tr{
        display:none;
    }

    .layui-table-view {
        margin: 10px 10px !important;
    }

</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>运费管理</li>
        <li><a onclick="javascript:history.back(-1);">运费定义列表 </a></li>
        <li class="active">运费定义-${type }</li>
    </ol>
</div>
<div id="outSide">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-9">
            <form class="layui-form form_input" action="${ctx }/freightDef/save.shtml" method="post">

                <input class="inputArea" type="text" id="id" name="id" style="width:80%" value="${freightDef.id }" hidden>

                <div class="layui-form-item">
                    <label class="layui-form-label"><span class="red">*</span>运输方式：</label>
                    <div class="layui-input-block">
                        <%--<input type="text" name="shipType"  autocomplete="off" placeholder="请输入运输方式" class="layui-input" lay-verify="required" value="${freightDef.shipType }">--%>
                        <select name="shipType">
                            <option value="">--请选择--</option>
                            <c:forEach var="item" items="${shipTypes}">
                                <option value="${item.value}" <c:if test="${freightDef.shipType eq item.value}">selected</c:if>>${item.value}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label"><span class="red">*</span>包装方式：</label>
                    <div class="layui-input-block">
                        <%--<input type="text" name="packageType"  autocomplete="off" placeholder="请输入包装方式" class="layui-input" lay-verify="required" value="${freightDef.packageType }">--%>
                        <select name="packageType">
                            <option value="">--请选择--</option>
                            <option value="散运"<c:if test="${'散运' eq freightDef.packageType}">selected</c:if>>散运</option>
                            <option value="包装"<c:if test="${'包装' eq freightDef.packageType}">selected</c:if>>包装</option>
                        </select>

                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">运输单价(元/吨)：</label>
                    <div class="layui-input-block">
                        <input type="text" name="transportPrice" maxlength="13"  autocomplete="off" placeholder="请输入运输单价" class="layui-input number"  value="${freightDef.transportPrice }" lay-verify="number" oninput="clearNoNum(this)">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">板前费率(元/吨)：</label>
                    <div class="layui-input-block">
                        <input type="text" name="preBoardRate"  maxlength="13" autocomplete="off" placeholder="请输入板前费率" class="layui-input number"  value="${freightDef.preBoardRate }" lay-verify="number">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">入库费率(元/吨)：</label>
                    <div class="layui-input-block">
                        <input type="text" name="instoreRate" maxlength="13"  autocomplete="off" placeholder="请输入入库费率" class="layui-input number"  value="${freightDef.instoreRate }" lay-verify="number">
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn layui-btn-primary layui-btn-small" lay-submit lay-filter="demo1" id="btnSave">确认</button>
                        <button type="reset" class="layui-btn layui-btn-primary layui-btn-small" onclick="javascript:history.back(-1);" id="btnCancel">取消</button>
                    </div>
                </div>
            </form>
            <div class="col-md-2"></div>
        </div>
    </div>



</div>

<script>
   /* var parentId = "${sysDict.parentid}";
    $("#parentid").val(parentId);*/

    var type = "${type}";
    if(type=="详情"){
        $("form").find("input,textarea").prop("readonly", true);
        $("form").find("select").prop("disabled", true);
        $('#btnSave').hide();
        $('#btnCancel').text("返回");
    }

   function clearNoNum(obj) {
       //修复第一个字符是小数点 的情况.  
       if(obj.value !=''&& obj.value.substring(0,1) == '.'){
           obj.value="";
       }
       obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
       obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的       
       obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
       obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d\d).*$/,'$1$2.$3');//只能输入两个小数       
       if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额  
           if(obj.value.substr(0,1) == '0' && obj.value.length == 2){
               obj.value= obj.value.substr(1,obj.value.length);
           }
       }
   }

    //Demo
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;


        form.render();

        //自定义验证规则
        form.verify({
        });


        //监听提交
       /* form.on('submit(demo1)', function(data){
            layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            })
            return false;
        });*/
        form.on('submit(demo1)', function(data){
           // layer.load();
            $(".form_input").ajaxSubmit({
                type:"post",
                success:function(data){
                    //alert(data.success)
                    if(!data.success){
                        layer.msg(data.msg);
                    }else{
                        layer.closeAll('loading');
                        layer.msg("保存成功",{icon:1}, function(){
                            location.href="${ctx}/freightDef.shtml";
                        })
                    }
                }
            });
            return false;
        });

    });
</script>

<%@ include file="../common/AdminFooter.jsp" %>