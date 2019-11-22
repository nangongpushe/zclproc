<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/12 0012
  Time: 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
</head>
<body>
<style>

    .btn:hover, .btn:link, .btn:active, .btn:visited{
        background-color:#fff;
        color:#23527c;
        border-color:#fff;
    }
    #freightDetails td>select{
        display:inline-block;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>仓储管理</li>
        <li>粮油情检测管理</li>
        <li>氮气浓度检测记录</li>
        <li class="active">${gaslog.id eq null ? '新增' : '编辑'}</li>
    </ol>
</div>
<div class="container-box clearfix" style="padding: 10px"
     id="rotateinvite_add">

    <div class="layui-row title">
        <h5>氮气浓度检测记录</h5>
    </div>
    <form class="layui-form" lay-filter="search" id="data-form">
        <div class="layui-form-item">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称:</label>
                <div class="layui-input-inline">
                    <input readonly  type="text" class="layui-input form-control" name="warehouseName" lay-verify="required" autocomplete="off" value="${gaslog.warehouseName}" >
                    <input type="hidden" name="warehouseId" value="${gaslog.warehouseId}"/>
                </div>
            </div>
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>仓号:</label>
                <div class="layui-input-inline">
                    <select name="storagehouse" lay-verify="required">
                        <option value="">请选择</option>
                        <c:forEach items="${oilcan }" var="item">
                            <option <c:if test="${item.encode eq gaslog.storagehouse }"> selected="selected"</c:if>>${item.encode }</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>检测时间:</label>
                <div class="layui-input-inline">
                    <input type="text" name="detectionTime" lay-verify="required" autocomplete="off" class="layui-input form-control" value='${gaslog.detectionTime}'>
                </div>
            </div>
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label" style="text-align:right"><span class="red">*</span>检测方法和仪器:</label>
                <div class="layui-input-inline">
                    <input type="text" name="detectionOperation" maxlength="20" lay-verify="required" autocomplete="off" class="layui-input form-control" value='${gaslog.detectionOperation }'>
                </div>
            </div>
        </div>
        <div class="layui-row title">
            <h5>检测点：</h5>
        </div>
        <table class="layui-table" id="temp">
            <thead>
            <tr>
                <th style="width:10%;text-align: center">检测点</th>
                <th  style="text-align:center">检测点浓度(ppm)</th>

            </tr>
            </thead>
            <!-- 表格内容start -->
            <tbody id="materialDetail" class="text-center">
            <c:forEach items="${storageGaslogTemps}" var="storageGaslogTemp" varStatus="idxStatus">

                <tr><td style="width:6%;text-align: left" ><input type="hidden" name="storageGaslogTemp[${idxStatus.index}].placeId" value="${storageGaslogTemp.placeId}"lay-verify="" style="width:0px;"/><span class="red">*</span>${idxStatus.count}</td>
                    <td ><input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0"   name="storageGaslogTemp[${idxStatus.index}].testing" value="${storageGaslogTemp.testing}"  class="layui-input" lay-verify="required" placeholder="--请输入--"/></td>

                </tr>

            </c:forEach>


            </tbody>
            <!-- 表格内容 end -->
            <td><span class="red">*</span>平均浓度</td>
            <%--<td colspan="3" style="padding: 0"></td> <input  class="layui-input" style="width: 100%; height: 100%;margin: 0;border: 0"/>--%>
            <td colspan="3"><input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0"  lay-verify="required" name="testingavg" class="layui-input" placeholder="--请输入--" value="${gaslog.testingavg }" /></td>
        </table>

        <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="addMaterialName();">增加检测点</button>
        <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="lessMaterialName();">删除最后一个检测点</button>

        <div class="layui-row title">
        </div>

        <%--<div class="layui-form-item layui-form-text">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label"><span class="red">*</span>磷化氢(ppm):</label>
                <div class="layui-input-inline">
                    <input type="number" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0"  class="layui-input" placeholder="--请输入--" name="phosphine" lay-verify="required" autocomplete="off" value='${gaslog.phosphine }'>
                </div>
            </div>
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label"><span class="red">*</span>含氧量(%):</label>
                <div class="layui-input-inline">
                    <input type="number" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" max="100"  class="layui-input" placeholder="--请输入--" name="oxygen" lay-verify="required" autocomplete="off"  value='${gaslog.oxygen }'>
                </div>
            </div>
        </div>--%>
        <div class="layui-form-item layui-form-text">
            <div class="layui-inline layui-col-md5">
                <label class="layui-form-label"><span class="red">*</span>检测人:</label>
                <div class="layui-input-inline">
                    <input type="text" name="detectionHumen" lay-verify="required" autocomplete="off" class="layui-input form-control" value='${gaslog.detectionHumen }' readonly>
                </div>
            </div>
        </div>
        <div class="layui-form-item text-center">
            <button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small"  id="submit">${gaslog.id eq null ? '保存':'保存更改'}</button>
            <%--<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="cancel">取消</button>--%>
        </div>
    </form>
</div>
<script>
    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
        if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
            obj.value= parseFloat(obj.value);
        }
    }
    function checkAmounts(obj) {
        var reg = /[A-Za-z]+/;
        var optionNum = $(obj).val();
        if (reg.test(optionNum)) {
            alert("只能输入数字");
            $(obj).val("");
        }
    }
    layui.form.render("select","search");

    layui.laydate.render({
        elem:$('[name="detectionTime"]')[0],
        type:"date",
        format:"yyyy年MM月dd日",
    });

    $("#cancel").click(function(){
        layer.confirm('确定要取消吗?', {
            icon : 0,
            title : '提示'
        }, function(index) {//是
            location.href = "${ctx}/StorageGaslog/view.shtml";
        }, function(index) {//否
            layer.close(index);
        });
    });

    $("#submit").click(function(){
        var patchAll = true;
        $("#data-form").find("select,input").each(function(){
            if($(this).val() == ""){
                patchAll = false;
                return false;
            }
        })
        if(!patchAll)
            return;
        $("#data-form").ajaxSubmit({
            url:"${ctx}/StorageGaslog/${gaslog.id eq null ? 'Add':'Edit'}.shtml",
            type:"post",
            data:{
                "id":"${gaslog.id}"
            },
            beforeSend: function () {
                // 禁用按钮防止重复提交
                $("#submit").attr({ disabled: "disabled" });
            },
            success:function(data){
                if(data.success){
                    /*alert("保存成功");
                    location.href = "${ctx}/StorageGaslog/view.shtml";*/
                    layer.msg("保存成功！",{icon:1},function(){
                        location.href = "${ctx}/StorageGaslog/view.shtml";
                    });
                }else{
                    layer.msg("保存失败！",{icon:2});
                }
            },
            error:function(){
                layer.msg("系统异常！",{icon:2});
            },
            complete: function () {
                $("#submit").removeAttr("disabled");
            }
        });
    });
    var index = $("#temp>tbody").children("tr").length;
    function addMaterialName(){
        var tr =   '<tr id="row"><td style="width:6%;text-align: left" ><input type="hidden" name="storageGaslogTemp['+(index-1)+'].placeId" value='+ index +' style="width:0px;"/><span class="red">*</span>'+(index)+'</td>'
            +'<td ><input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" onkeyup="value=value.replace(/[^\\d\\.]/g,\'\')" data-rule="required;integer;length[1~10]" min="0"  name="storageGaslogTemp['+(index-1)+'].testing" class="layui-input" lay-verify="required"  placeholder="--请输入--"/></td>'

        index++;
        $("#materialDetail").append(tr);
    }

    function lessMaterialName() {
        if(index >0){
            layer.confirm("确定删除吗？",function (row) {
                var tr= $("#materialDetail tr:last").remove();
                --index;
                layer.close(row);
            });
        }
    }
</script>
</body>
</html>
