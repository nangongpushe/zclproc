<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../common/AdminHeader.jsp"%>

<style>
    #optionTable + .layui-form .layui-table-body td[data-field="repairDateStr"]{
        text-align: center;
    }
    #optionTable + .layui-form .layui-table-body td[data-field="projectName"]{
        text-align: left;
    }
    #optionTable + .layui-form .layui-table-body td[data-field="construction"]{
        text-align: left;
    }
    #optionTable + .layui-form .layui-table-body td[data-field="remark"]{
        text-align: left;
    }

    #enterpriseTable + .layui-form .layui-table-body td[data-field="warehouseName"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="warehouseShort"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="enterpriseName"]{
        text-align: left;
    }
</style>


    <div class="row clear-m">
        <ol class="breadcrumb">
            <li>代储监管</li>
            <li>企业信息</li>
            <li class="active">[代储]仓房管理</li>
        </ol>
    </div>


<style type="text/css">
    .layui-form-label{
        text-align:right;
    }
</style>


<div class="container-box clearfix" style="padding: 10px">
    <form class="layui-form" id="storageStoreHouseFormId" action="${ctx }/storageStoreHouse/save.shtml">
        <input type="hidden" id="flag" name="flag" value="${flag }">
        <input name="id" value="${storageStoreHouse.id }" type="hidden">
        <table class="table table-bordered" lay-filter="test">
            <!-- 表格内容 start -->
            <tbody>
            <tr>
                <td class="text-right"><span class="red">*</span><b>所属库点:</b></td>
                <td>
                    <%--<select lay-filter="warehouse"  lay-verify="required"  id="warehouse" name="warehouse">--%>
                        <%--<c:forEach items="${wareHouses}" var="item">--%>
                            <%--<option value="${item.warehouseName }"  typeName="${item.warehouseCode }" <c:if test="${storageStoreHouse.warehouse eq item.warehouseName }">selected</c:if>>${item.warehouseName }</option>--%>
                        <%--</c:forEach>--%>
                    <%--</select>--%>
                        <%--<input type="hidden" name="reportWarehouseId" id="warehouse">--%>

                        <input class="layui-input" autocomplete="off" name="warehouse" readonly id="warehouse" value="${storageStoreHouse.warehouse}"
                               placeholder="请选择报库点..." onclick="addActiveClass(this)"/>
                </td>
                <%--<td><input  readonly="readonly" type="text" name="warehouse" id="warehouse" value='${storageStoreHouse.warehouse }' class="form-control validate[required]"  placeholder=""  /></td>--%>
                <td  class="text-right"><span class="red">*</span><b>库点代码:</b></td>
                <td ><input readonly="readonly"  class="form-control validate[required]" autocomplete="off" name="warehouseCode" value="${storageStoreHouse.warehouseCode }"
                            maxlength="10"></td>
            </tr>
            <tr>
                <td class="text-right"><b>仓房名称:</b></td>
                <td><input type="text" name="storehouseName" id="storehouseName" value='${storageStoreHouse.storehouseName }' class="form-control validate[required]"  placeholder=""  /></td>
                <td  class="text-right"><span class="red">*</span><b>仓房编号:</b></td>
                <td ><input lay-verify="required" class="form-control validate[required]" autocomplete="off" name="encode" value="${storageStoreHouse.encode }"
                            maxlength="20" onkeyup="this.value=this.value.toUpperCase()"></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>仓房类型:</b></td>
                <td>
                    <select lay-verify="required" name="type" onfocus="alert(1)">
                        <option value=""></option>
                        <c:forEach items="${typeDict }" var="item">
                            <option value="${item.value }" <c:if test="${storageStoreHouse.type eq item.value }">selected</c:if>>${item.value }</option>
                        </c:forEach>
                    </select>
                </td>
                <td  class="text-right"><!-- <span class="red">*</span> --><b>仓房状态:</b></td>
                <td >
                    <select name="status">
                        <option value=""></option>
                        <c:forEach items="${statusDict }" var="item">
                            <option value="${item.value }" <c:if test="${storageStoreHouse.status eq item.value }">selected</c:if>>${item.value }</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="text-right"><span class="red"></span><b>启用日期:</b></td>
                <td><input  class="layui-input date-need" autocomplete="off" name="enableDate"
                            value="${storageStoreHouse.enableDate }"></td>
                <td  class="text-right"><span class="red"></span><b>结构:</b></td>
                <td ><input class="layui-input" autocomplete="off" name="structure" value="${storageStoreHouse.structure }" maxlength="100"></td>
            </tr>
            <tr>
                <td class="text-right"><b>堆粮线高（m）:</b></td>
                <td><input class="layui-input" autocomplete="off" name="bulkHeight" value="${storageStoreHouse.bulkHeight }"  onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                           type="number" step="0.01"></td>
                <td  class="text-right"><b>仓门数量（扇）:</b></td>
                <td ><input class="layui-input" autocomplete="off" name="gateNum" value="${storageStoreHouse.gateNum }" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                            maxlength="30" type="number" step="1"></td>
            </tr>
            <tr>
                <td class="text-right"><b>建筑面积（长*宽）（㎡）:</b></td>
                <td><input class="layui-input" autocomplete="off" name="cfa" value="${storageStoreHouse.cfa }" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
                <td  class="text-right"><b>筒仓外径(m):</b></td>
                <td ><input class="layui-input" autocomplete="off" name="siloDiameter" value="${storageStoreHouse.siloDiameter }" type="number" step="0.01" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
            </tr>
            <tr>
                <td class="text-right"><b>筒仓内径(m):</b></td>
                <td><input lay-verify="siloBore" class="layui-input" autocomplete="off" name="siloBore" value="${storageStoreHouse.siloBore }" type="number" step="0.01" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
                <td  class="text-right"><b>筒仓体积(m³):</b></td>
                <td ><input class="layui-input" autocomplete="off" name="siloVolume" value="${storageStoreHouse.siloVolume }" type="number" step="0.01" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
            </tr>
            <tr>
                <td class="text-right"><b>仓门高度(m):</b></td>
                <td><input  class="layui-input" autocomplete="off" name="gateHeight" value="${storageStoreHouse.gateHeight }" type="number" step="0.01" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
                <td  class="text-right"><b>仓门宽度(m):</b></td>
                <td ><input class="layui-input" autocomplete="off" name="gateWidth" value="${storageStoreHouse.gateWidth }" type="number" step="0.01" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
            </tr>
            <tr>
                <td class="text-right"><b>檐高(m):</b></td>
                <td><input class="layui-input" autocomplete="off" name="eavesHeight" value="${storageStoreHouse.eavesHeight }" type="number" step="0.01" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
                <td  class="text-right"><b>设计容量(t):</b></td>
                <td ><input class="layui-input" autocomplete="off" name="designedCapacity" value="${storageStoreHouse.designedCapacity }" type="number" step="0.01" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
            </tr>
            <tr>
                <td class="text-right"><b>核定容量(t):</b></td>
                <td><input class="layui-input" autocomplete="off" name="authorizedCapacity" value="${storageStoreHouse.authorizedCapacity }" type="number" step="0.01" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
                <td  class="text-right"><b>粮堆面积（长*宽）（㎡）:</b></td>
                <td ><input class="layui-input" autocomplete="off" name="bulkArea" value="${storageStoreHouse.bulkArea }" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                            type="text" ></td>
            </tr>
            <tr>
                <td class="text-right"><b>通风口数量（个）:</b></td>
                <td><input class="layui-input" autocomplete="off" name="ventNum" value="${storageStoreHouse.ventNum }" type="number" step="1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
                <td  class="text-right"><b>风道类型:</b></td>
                <td ><input class="layui-input" autocomplete="off" name="ductType" value="${storageStoreHouse.ductType }" maxlength="20"></td>
            </tr>
            <tr>
                <td class="text-right"><b>实仓气密性（S）:</b></td>
                <td><input class="layui-input" autocomplete="off" name="siloTightness" value="${storageStoreHouse.siloTightness }" maxlength="20"></td>
                <td  class="text-right"><b>轴流风机数（台）:</b></td>
                <td ><input class="layui-input" autocomplete="off" name="axialNum" value="${storageStoreHouse.axialNum }" maxlength="30" type="number" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"></td>
            </tr>

            <tr>
                <td class="text-right"><b>存放类型:</b></td>
                <td><input type="text" name="storeType" id="storeType" value='${storageStoreHouse.storeType }' class="form-control "  placeholder=""  /></td>
                <td  class="text-right"><b>建筑类型:</b></td>
                <td ><input class="form-control " autocomplete="off" name="buildingType" value="${storageStoreHouse.buildingType }"
                            maxlength="20"></td>
            </tr>
            <tr>
                <td class="text-right"><b>仓房经度:</b></td>
                <td><input type="text" onchange="check();" name="longitude" id="longitude" value='${storageStoreHouse.longitude }' class="form-control "  placeholder=""  maxlength="20"  data-rule="integer;length[1~10]" min="0"/></td>
                <td  class="text-right"><b>仓房纬度:</b></td>
                <td ><input type="text" onchange="check();" class="form-control " autocomplete="off" name="latitude" id="latitude" value="${storageStoreHouse.latitude }"  data-rule="integer;length[1~10]" min="0"
                            maxlength="20"></td>
            </tr>

            <tr>
                <td class="text-right"><b>仓房长度(m):</b></td>
                <td><input type="text" step="0.01" name="length" id="length" value='${storageStoreHouse.length }' class="form-control "  placeholder="" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"  /></td>
                <td  class="text-right"><b>仓房宽度(m):</b></td>

                <td ><input type="text" lay-verify="width" step="0.01" class="form-control " maxlength="7" autocomplete="off" name="width" value="${storageStoreHouse.width }" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
                            maxlength="20"></td>
            </tr>
            <tr>
                <td class="text-right"><b>仓房高度(m):</b></td>
                <td><input type="number" step="0.01"name="height" id="height" value='${storageStoreHouse.height }' class="form-control "  placeholder="" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0" /></td>
                <td  class="text-right"><b>保管员:</b></td>
                <td ><input  class="form-control " autocomplete="off" name="keeper" value="${storageStoreHouse.keeper }"
                             maxlength="50"></td>
            </tr>
            <tr>

                <td class="text-right"><b>注释信息:</b></td>
                <td><textarea rows="4" name="remark" class="form-control" placeholder="" maxlength="200">${storageStoreHouse.remark }</textarea></td>
                <td class="text-right"><b>隔热措施:</b></td>
                <td colspan="3"><textarea rows="4" name="heatInsulation" class="form-control" placeholder="" maxlength="200">${storageStoreHouse.heatInsulation }</textarea></td>

            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>是否停用：</b></td>
                <td>
                    <div class="layui-input-inline">
                        <select  lay-verify="required" id="isStop"
                                 name="isStop">
                            <option <c:if test="${storageStoreHouse.isStop == 'N'}">selected="selected"</c:if>   value="N">否</option>
                            <option <c:if test="${storageStoreHouse.isStop == 'Y'}">selected="selected"</c:if>  value="Y">是</option>
                        </select>
                    </div>
                </td>
                <td class="text-right"><span class="red"></span><b>排序号:</b></td>
                <td><input  type="number" oninput="if(value.length>20) value=value.slice(0,20)" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" step="0.01"name="orderNo" id="orderNo" value='${storageStoreHouse.orderNo }' class="form-control "  placeholder=""  /></td>
            </tr>

            </tbody>
            <!-- 表格内容 end -->
        </table>
        <c:if test="${auvp ne 'v'}">
            <p name="prompt">备注：带有<span class="red">*</span>为必填项！</p>
        </c:if>

        <table lay-filter="operation" id="optionTable"></table>
        <c:if test="${auvp eq 'u'}">
            <script type="text/html" id="operationColId">
                <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
            </script>
        </c:if>

        <p class="btn-box text-center">
            <c:if test="${auvp eq 'a' or auvp eq 'u'}">
                <button type="reset" class="layui-btn layui-btn-primary layui-btn-small" name="cancelBtn"
                        onclick="cancelOperate('${auvp }', '${ctx}/storageStoreHouse/proxyStorageStoreHouse.shtml')">取消</button>
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="submitBt" lay-submit lay-filter="submit_btn">
                    保存<c:if test="${auvp eq 'u' }">更改</c:if></button>
            </c:if>
            <c:if test="${auvp eq 'v' }">
                <button type="reset" class="layui-btn layui-btn-primary layui-btn-small" name="cancelBtn"
                        onclick="cancelOperate('${auvp }', '${ctx}/storageStoreHouse/proxyStorageStoreHouse.shtml')">返回</button>
            </c:if>
        </p>
    </form>
</div>

<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
    <div class="modal-dialog"  style="width:800px;">
        <div class="modal-content">
            <div class="modal-header"><!-- data-dismiss="modal"  -->
                <button type="button" class="close" aria-hidden="true" onclick="removeActiveClass()">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel1">
                    选择库点
                </h4>
            </div>
            <div class="modal-body">
                <div class="layui-form" id="search">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <%--<label class="layui-form-label">库点类型:</label>
                            <div class="layui-input-inline">--%>
                                <%--<select class="layui-input" name="warehouseType" id="warehouse_type">--%>
                                    <%--<option value="">全部</option>--%>
                                    <%--<option value="储备库">储备库</option>--%>
                                    <%--<option value="代储库">代储库</option>--%>
                                <%--</select>--%>
                            <%--</div>--%>
                            <label class="layui-form-label">库点简称：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="warehouseShort" name="shortName">
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">库点名称：</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" autocomplete="off" id="warehouseName" name="name">
                                </div>
                            </div>
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="enterpriseSearch">查询</button>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-inline">
                                <label class="layui-form-label">企业名称：</label>
                                <div class="layui-input-inline">
                                    <input class="layui-input" autocomplete="off" id="enterpriseName" name="enterpriseName">
                                </div>
                            </div>
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="qingkong">清空</button>
                        </div>
                    </div>
                </div>
                <table lay-filter="operation1" id="enterpriseTable"></table>
                <script type="text/html" id="bar">
                    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="choose">选择</a>
                </script>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="removeActiveClass()">关闭
                </button>
                <!-- <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="selectBtn" onclick="selectEnterprise()">
                    选择
                </button> -->
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->

</div>

<script src="${ctx}/js/app/storage/common.js"></script>

<script>
    /**  经纬度验证  **/
    /* function longitude(){
     alert();
     var longitude= document.getElementById("longitude").value;
     var reg= /^(((\d|[1-9]\d|1[1-7]\d|0)\.\d{0,4})|(\d|[1-9]\d|1[1-7]\d|0{1,3})|180\.0{0,4}|180)$/;
     if(!reg.test(longitude)){
     alert("经度：要求经度整数部分为0-180小数部分为0到4位！");
     }
    }
    function latitude(){
     alert();
     var latitude= document.getElementById("latitude").value;
     var reg= /^([0-8]?\d{1}\.\d{0,4}|90\.0{0,4}|[0-8]?\d{1}|90)$/;
     if(!reg.test(latitude)){
     alert("纬度：要求纬度整数部分为0-90小数部分为0到4位！");
     }
    } */
    function check() {
        var longitude =  document.getElementById("longitude").value;
        var latitude =  document.getElementById("latitude").value;
            if (longitude!=""&&longitude!=null){

                var lon = /^-?((0|[1-9]\d?|1[1-7]\d)(\.\d{1,7})?|180(\.0{1,7})?)?$/;
                var lonRe = new RegExp(lon);
                if (!lonRe.test(longitude)) {
                    alert("经度不符合规范：经度整数部分为0-180,小数部分为0-6位！");
                    $("#submitBt").hide();
                    return ;
                }else {
                    $("#submitBt").show();
                }

            }else {
                $("#submitBt").show();
            }
            if (latitude!=""&&latitude!=null){
                var lat = /^-?((0|[1-8]\d|)(\.\d{1,7})?|90(\.0{1,7})?)?$/;
                var latRe = new RegExp(lat);
                //alert(lonRe.test(longitude));//返回true OR  false

                if (!latRe.test(latitude)) {
                    alert("纬度不符合规范：纬度整数部分为0-90,小数部分为0-6位！");
                    $("#submitBt").hide();
                    return ;
                }else {
                    $("#submitBt").show();
                }
            }else {
                $("#submitBt").show();
            }
    }
    // var typeName = $("#warehouse").attr("typeName");
    // $('input[name="warehouseCode"]').val(typeName);
    layui.use(['form','laydate','table'],function() {
        var form = layui.form,
            laydate = layui.laydate,
            table = layui.table;

        form.render();
        form.on('select(warehouse)', function(data){
            var typeName = $("#warehouse").find("option:selected").attr("typeName");
            $('input[name="warehouseCode"]').val(typeName);
        });

        //为需要date的input渲染日历
        $('.date-need').each(function(){
            laydate.render({
                elem: this,
            });
        });
        //监听form
        form.on('submit(submit_btn)',function(){
            var form = $('#storageStoreHouseFormId');
            var json = JSON.stringify(form.serializeObject());
            $.ajax({
                type : 'POST',
                url : '${ctx }/storageStoreHouse/proxySave.shtml?auvp=${auvp }',
                dataType : "json",
                contentType : "application/json",
                data : json,
                error: function(request) {
                    if(request.responseText){
                        layer.open({
                            type: 1,
                            area: ['700px', '430px'],
                            fix: false,
                            content: request.responseText
                        });
                    }
                },
                success : function(result) {
                    if(result.success) {
                        layer.msg(result.msg, {icon : 1, time : 1000}, function(){
                            location.href = '${ctx }/storageStoreHouse/proxyStorageStoreHouse.shtml';
                        });
                    } else {
                        layer.msg(result.msg, {icon : 2, time : 1000});
                    }
                }
            });
        });

        //表单验证
        form.verify({
            bulkHeight : function(value, item) {
                if(value!=='' && !/^\d{1,3}(\.\d{1,2})?$/.test(value)) {
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长3位，小数位最多2位的数字';
                }
            },
            gateNum : function(value, item) {
                if(!/^[1-9]\d{0,29}$/.test(value)){
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长30位的正整数';
                }
            },
            /* cfa : function(value, item) {
                if(value!=='' && !/^\d{1,6}(\.\d{1,2})?$/.test(value)) {
                 return $(item).parent().parent().find('label').text() + '请输入大于0且最长8位，小数位最多2位的数字';
             }
            }, */
            siloDiameter : function(value, item) {
                if(value!=='' && value!=='' && !/^\d{1,3}(\.\d{1,2})?$/.test(value)) {
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长5位，小数位最多2位的数字';
                }
            },
            siloBore : function(value, item) {
                if(value!=='' && !/^\d{1,3}(\.\d{1,2})?$/.test(value)) {
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长5位，小数位最多2位的数字';
                }
            },
            siloVolume : function(value, item) {
                if(value!=='' && !/^\d{1,3}(\.\d{1,2})?$/.test(value)) {
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长5位，小数位最多2位的数字';
                }
            },
            gateHeight : function(value, item) {
                if(value!=='' && !/^\d{1,3}(\.\d{1,2})?$/.test(value)) {
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长5位，小数位最多2位的数字';
                }
            },
            gateWidth : function(value, item) {
                if(value!=='' && !/^\d{1,3}(\.\d{1,2})?$/.test(value)) {
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长5位，小数位最多2位的数字';
                }
            },
            eavesHeight : function(value, item) {
                if(value!=='' && !/^\d{1,3}(\.\d{1,2})?$/.test(value)) {
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长5位，小数位最多2位的数字';
                }
            },
            designedCapacity : function(value, item) {
                if(!/^\d{1,6}(\.\d{1,2})?$/.test(value)) {
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长8位，小数位最多2位的数字';
                }
            },
            authorizedCapacity : function(value, item) {
                if(!/^\d{1,6}(\.\d{1,2})?$/.test(value)) {
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长8位，小数位最多2位的数字';
                }
            },
           /* width : function(value, item) {
                if(!/^\d{1,6}(\.\d{1,2})?$/.test(value)) {
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长8位，小数位最多2位的数字';
                }
            },*/
            /* bulkArea : function(value, item) {
                if(value!=='' && !/^\d{1,4}(\.\d{1,2})?$/.test(value)) {
                 return $(item).parent().parent().find('label').text() + '请输入大于0且最长6位，小数位最多2位的数字';
             }
            }, */
            ventNum : function(value, item) {
                if(!/^[1-9]\d{0,29}$/.test(value)){
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长30位的正整数';
                }
            },
            axialNum : function(value, item) {
                if(value!=='' && !/^[1-9]\d{0,29}$/.test(value)){
                    return $(item).parent().parent().find('label').text() + '请输入大于0且最长30位的正整数';
                }
            },
        });

        var auvp = '${auvp}';
        if (auvp === 'u') {

            table.render({
                elem : '#optionTable',
                url : '${ctx}/storageStoreHouseOption/list.shtml?storehouseId=${storageStoreHouse.id }',
                method : "POST",
                cols : [[
                    /* {field : 'storehouseId',title: '仓房ID',width:300}, */
                    {field : 'repairDateStr',title : '维修保养日期',width:200,align : 'center'},
                    {field : 'projectName',title : '项目名称',width:300,align : 'center'},
                    {field : 'construction',title : '施工验收情况',width:300,align : 'center'},
                    {field : 'remark',title : '备注（单击可查看全部内容）',width:500,align : 'center'},
                    {width : 200,align : 'center',toolbar : '#operationColId',title : '操作',fixed: 'right'},
                ]],//设置表头
                request : {
                    pageName : 'page',
                    limitName : 'pageSize'
                },
                page:true,//开启分页
                limit:10,
                id:'optionTableId',
                done:function(res,curr,count){
                },
            });
        } else if (auvp === 'v') {

            $('input').attr('disabled','disabled');
            $('select').attr('disabled','disabled');

            table.render({
                elem : '#optionTable',
                url : '${ctx}/storageStoreHouseOption/list.shtml?storehouseId=${storageStoreHouse.id }',
                method : "POST",
                cols : [[
                    /* {field : 'storehouseId',title: '仓房ID',width:300}, */
                    {field : 'repairDateStr',title : '维修保养日期',width:200,align : 'center'},
                    {field : 'projectName',title : '项目名',width:300,align : 'center'},
                    {field : 'construction',title : '施工验收情况',width:300,align : 'center'},
                    {field : 'remark',title : '备注（单击可查看全部内容）',width:500,align : 'center'},
                ]],//设置表头
                request : {
                    pageName : 'page',
                    limitName : 'pageSize'
                },
                page:true,//开启分页
                limit:10,
                id:'optionTableId',
                done:function(res,curr,count){
                },
            });
        }
        //监听工具条
        table.on('tool(operation)', function(obj) {
            var data = obj.data;
            //console.log(data);
            if (obj.event === 'del') {
                layer.confirm('确认删除吗？', function(index) {
                    $.post("${ctx}/storageStoreHouseOption/remove.shtml", {
                        id : data.id
                    }, function(result) {
                        if (result.success) {
                            obj.del();
                        }
                        layer.msg(result.msg,{time:1000,icon:1});
                    });
                });
            } else if (obj.event === 'edit') {
                location.href = "${ctx}/storageStoreHouseOption/proxyEditPage.shtml?id="
                    + data.id;
            }
        });
    });

    //为当前点击的行新增activeClass
    function addActiveClass(obj) {
        $('#myModal1').modal({backdrop: 'static'}).modal('show');
    }

    //移除activeClass
    function removeActiveClass(obj) {
        $('#myModal1').modal('hide');
        $('.activeEnterprise').removeClass('activeEnterprise');
    }

    layui.use(['table'], function() {
        var table = layui.table;
        table.render({
            elem : '#enterpriseTable',
            //url : '${ctx}/storageWarehouse/limitPageList.shtml',
            url : '${ctx}/storageWarehouse/list.shtml',
            where : {
                type : 'dc'
            },
            method : "POST",
            cols : [[
                {fixed : 'left', title : '操作', width : 100, align : 'center', toolbar : '#bar'},
                {field : 'warehouseName',title : '库点名称',width:150,align : 'center'},
                {field : 'warehouseShort',title : '库点简称',width:150,align : 'center'},
                {field : 'enterpriseName',title : '所属企业名称(代储库点用)',width:200,align : 'center'}
            ]],//设置表头
            request : {
                pageName : 'page',
                limitName : 'pageSize'
            },
            page:true,//开启分页
            limit:10,
            id:'enterpriseTableId1',
            done:function(res,curr,count){
            },
        });
        //搜索
        $('#enterpriseSearch').click(function() {
            table.reload("enterpriseTableId1", {
                method: 'post', //如果无需自定义HTTP类型，可不加该参数
                where : {
                    warehouseType: $('#search #warehouse_type').val(),
                    name : $('#search #warehouseName').val(),
                    shortName : $('#search #warehouseShort').val(),
                    enterpriseName : $('#search #enterpriseName').val(),
                    type : 'dc'
                }
            });
        });
        $('#qingkong').click(function() {
            $('#warehouseName').val("");
            $('#warehouseShort').val("");
            $('#enterpriseName').val("");
            $('#warehouse_type').val("");
            var form = layui.form;
            form.render();
        });
        table.on('tool(operation1)', function(obj) {
            // debugger
            var data = obj.data;
            if (obj.event === 'choose') {
                $('#warehouse').val(data.warehouseShort).attr("typeName",data.warehouseCode);
                $('input[name="warehouseCode"]').val(data.warehouseCode);
                $('#reportWarehouseId').val(data.id);
                $('#reportWarehouse').change();
            }
            $('#myModal1').modal('hide');
        });
        //监听FORM结束
    });

</script>