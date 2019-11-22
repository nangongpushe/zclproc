<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/11 0011
  Time: 10:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
</head>
<body>
<link rel="stylesheet" href="${ctx}/css/combo.select.css">
<style>
    .modal-backdrop.in{
        display: none;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>质量管理</li>
        <li>检验任务</li>
        <li class="active"><c:if test="${auvp=='a'}">
            新增
        </c:if>
            <c:if test="${auvp=='u'}">
                编辑
            </c:if>
            <c:if test="${auvp=='v'}">
                查看
            </c:if>第三方质检记录
        </li>
    </ol>
    <div class="container-box clearfix" style="padding: 10px">
        <!--检验结果表-->
        <form class="form_input layui-form" id="form_input" action="QualityThird/save.shtml" method="post"
              enctype="multipart/form-data" lay-filter="form1">
            <input type="hidden" name="auvp" value="${auvp}">
            <input type="hidden" name="id" value="${entity.id }"/>
            <input type="hidden" name="checkType"  value="2"/>
            <table class="table table-bordered">
                <!-- 表格内容 start -->
                <tbody>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>承检单位:</b></td>
                    <td>
                        <%--<input  maxlength="50" type="text" name="acceptedUnit"  value='${entity.acceptedUnit }' class="form-control validate[required]"  placeholder=""/>--%>
                        <select  class="form-control validate[required]" name="acceptedUnit"
                                 id="acceptedUnit" lay-search>
                            <option value=""></option>
                            <%--<option value="浙江省粮油产品质量检验中心"
                                    <c:if test="${entity.acceptedUnit == '浙江省粮油产品质量检验中心'}">selected="selected" </c:if>>
                                浙江省粮油产品质量检验中心
                            </option>
                            <option value="舟山出入境检验检疫局"
                                    <c:if test="${entity.acceptedUnit == '舟山出入境检验检疫局'}">selected="selected" </c:if>>
                                舟山出入境检验检疫局
                            </option>
                            <option value="浙江省检验检疫科学技术研究院舟山分院"
                                    <c:if test="${entity.acceptedUnit == '浙江省检验检疫科学技术研究院舟山分院'}">selected="selected" </c:if>>
                                浙江省检验检疫科学技术研究院舟山分院
                            </option>
                            <option value="浙江省储备粮管理有限公司中心化验室"
                                    <c:if test="${entity.acceptedUnit == '浙江省储备粮管理有限公司中心化验室'}">selected="selected" </c:if>>
                                浙江省储备粮管理有限公司中心化验室
                            </option>--%>
                            <c:forEach items="${acceptedUnit}" var="acc">
                                <option value="${acc.value}">${acc.value}</option>
                            </c:forEach>
                        </select>

                    </td>

                    <td class="text-right"><span class="red">*</span><b>样品编号:</b></td>
                    <td>
                        <%--<input maxlength="32" type="text" name="sampleNo" value='${entity.sampleNo }'--%>
                        <%--class="form-control validate[required]" placeholder=""/>--%>

                        <select name="sampleNo" id="sampleNo" class="form-control" lay-search lay-verify="required"  lay-filter="sampleNo">
                            <c:if test="${pageType=='edit'||pageType=='view'}">
                                <option selected="selected" value="${entity.sampleNo}" sampleNo="${entity.id}" >${entity.sampleNo }</option>
                            </c:if>
                            <c:if test="${pageType=='add'}">
                                <option selected="selected" value="${entity.sampleNo}" sampleNo="${entity.id}" >${entity.sampleNo }</option>
                                <c:forEach items="${qualitySamples}" var="qualitySamples">
                                    <option value="${qualitySamples.sampleNo}"  sampleNo="${qualitySamples.id}">${qualitySamples.sampleNo}</option>
                                </c:forEach>
                            </c:if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>样品名称:</b></td>
                    <td>
                        <select lay-verify="required" class="form-control validate[required]" name="variety"
                                id="variety" lay-search>
                            <option value="">--请选择--</option>
                            <c:forEach items="${variety}" var="variety">
                                <option value="${variety.value}">${variety.value}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td class="text-right"><span class="red">*</span><b>受检单位:</b></td>
                    <td>
                        <input maxlength="50" tag="model" type="text" name="reportUnit" id="reportUnit"
                               value='${entity.reportUnit }' class="form-control" lay-verify="required"  placeholder="" readonly/>
                        <input type="hidden" name="warehouseId" value="${entity.warehouseId}">
                        <c:if test="${auvp!='v'}">
                            <a type="button" class="btn btn-link" id="chooseBtn" data-target="#myModal"
                               data-bind="click:function(){$root.showModal($data);}">选择</a>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>检验日期开始日期:</b></td>
                    <td><input id="testDate" name="testDate" class="form-control " lay-verify="required"  type="text"
                               value="${entity.testDate }"/></td>

                    <td class="text-right"><span class="red">*</span><b>检验日期截止日期:</b></td>
                    <td><input type="text" id="testEndDate" name="testEndDate" lay-verify="required"  value='${entity.testEndDate }'
                               class="form-control " placeholder=""/></td>

                </tr>

                <tr>
                    <td class="text-right"><span class="red">*</span><b>抽样基数(吨):</b></td>
                    <td><input maxlength="10"  name="quantity" value='${entity.quantity }'
                               class="form-control validate[required]" placeholder="单位：吨" oninput="clearNoNum(this)"/></td>
                    <td class="text-right"><span class="red">*</span><b>产品等级:</b></td>
                    <td><input maxlength="10" type="text" name="proGrade" value='${entity.proGrade }'
                               class="form-control validate[required]" placeholder=""/></td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>储存方式:</b></td>
                    <td>
                        <select lay-verify="required" class="form-control validate[required]" name="storeType"
                                id="storeType">
                            <%--<option value="">--请选择--</option>--%>
                            <c:forEach items="${storeType}" var="storeType">
                                <option value="${storeType.value}">${storeType.value}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td class="text-right"><span class="red">*</span><b>抽样地点:</b></td>
                    <td><input maxlength="100" type="text" name="storeEncode" value='${entity.storeEncode }'
                               class="form-control validate[required]" placeholder=""/></td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b>粮食产地:</b></td>
                    <td><input maxlength="50" type="text" name="origin" value='${entity.origin }'
                               class="form-control validate[required]" placeholder=""/></td>
                    <td class="text-right"><span class="red">*</span><b>入库时间:</b></td>
                    <td><input id="storeDate" name="storeDate" class="form-control" type="text"
                               value="${entity.storeDate }"/></td>
                </tr>

                <tr>
                    <td class="text-right"><span class="red">*</span><b>收获年份:</b></td>
                    <td><input id="harvestYear" name="harvestYear" class="form-control" type="text"
                               value="${entity.harvestYear }"/></td>

                    <td class="text-right"><span class="red">*</span><b>检测模板编号:</b></td>
                    <td><input type="text" name="templetNo" id="templetNo" onclick="toAddSelect();" value='${entity.templetNo }'
                               class="form-control" placeholder=""/></td>
                </tr>
                <tr>
                    <td class="text-right"><b>存储指标判定:</b></td>
                    <td><input id="storeJudge" name="storeJudge" class="form-control" type="text"
                               value="${entity.storeJudge }" maxlength="100"/></td>

                    <td class="text-right"><b>卫生指标判定:</b></td>
                    <td><input type="text" name="hygieneJudge" id="hygieneJudge"  value='${entity.hygieneJudge }'
                               class="form-control" placeholder="" maxlength="100"/></td>
                </tr>
                <tr>
                    <%--<td class="text-right"><span class="red">*</span><b>检测模板编号:</b></td>
                    <td><input type="text" name="templetNo" onclick="toAddSelect();" value='${entity.templetNo }' class="form-control validate[required]"  placeholder=""/></td>--%>
                    <%--<td class="text-right"><span class="red">*</span><b>储存品质判定:</b></td>
                    <td><input maxlength="20" type="text" name="qualityDetermin" value='${entity.qualityDetermin }' class="form-control validate[required]"  placeholder=""/></td>--%>
                </tr>
                <tr>
                    <td class="text-right"><b>结论:</b></td>
                    <td colspan="3"><textarea rows="4" name="remark" class="form-control" placeholder="最多输入400个字符" maxlength="400">${entity.remark }</textarea></td>
                </tr>
                <%--检验类型--%>
                <input type="hidden" name="validType" />
                <!-- 表格内容 end -->
                </tbody>
            </table>
            <div class="manage">
                <table class="layui-table" id="in">
                    <thead>
                    <tr>
                        <td align="center">检测项目</td>
                        <td align="center">等级</td>
                        <td align="center">标准值</td>
                        <td align="center">检测值</td>
                        <td align="center">结论</td>
                        <c:if test="${auvp!='v'}"><td align="center">操作</td></c:if>
                    </tr>
                    </thead>
                    <!-- 表格内容start -->
                    <tbody id="Detail" class="text-center">
                    <c:forEach items="${entityItem}" var="entityItem">
                        <tr>
                            <td colspan="1"><input maxlength="20" type="text" value='${entityItem.itemName }' readonly="readonly" id="itemName" name="itemName" class="form-control validate[required] " placeholder=""/></td>
                            <input readonly="readonly" type="hidden" value='${entityItem.orderNo }' id="orderNo" name="orderNo" class="form-control validate[required] "placeholder=""/>
                            <td colspan="1"><input maxlength="10" type="text" value='${entityItem.grade }' readonly="readonly" id="gradeItem" name="gradeItem" class="form-control validate[required] " placeholder=""/></td>
                            <td colspan="1"><input maxlength="20" type="text" value='${entityItem.standard }' id="standard" name="standard" class="form-control validate[required] " placeholder="" readonly/>
                                    <%--<td colspan="1"><input maxlength="20" type="text" value='${entityItem.result }' id="result" name="result" class="form-control  " placeholder=""/>--%>
                            <td colspan="1"><textarea rows="1" name="result" class="form-control" placeholder="" maxlength="125">${entityItem.result }</textarea></td>
                            <td colspan="1"><input maxlength="20" type="text" value='${entityItem.remark }' id="remark" name="remarkItem" class="form-control  " placeholder=""/>
                                <input type="hidden" value='${entityItem.resultId }' id="resultId" name="resultId" style="width:0px;"/></td>
                            <c:if test="${auvp!='v'}"><td colspan="1"><a href="javascript:void(0);" onclick="toDeleteTr(this);" class="layui-btn layui-btn-small layui-bg-red" data-id="">删除</a></td></c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <!-- 表格内容 end -->
                </table>
            </div>
            <p>备注：带有<span class="red">*</span>为必填项！</p>
            <p class="btn-box text-center">
                <%--<button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">返回</button>--%>
                <button type="button" id="btnSave" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
            </p>


        </form>
        <div class="jumpPage" id="displayPage"></div>
        <div class="modal fade" id="inModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="layui-form" lay-filter="search4" id="search4">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">库点代码:</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="warehouseCode" autocomplete="off"
                                               class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">库点简称:</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="warehouseShort" autocomplete="off"
                                               class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">库点名称:</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="warehouseName" autocomplete="off"
                                               class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <button class=" layui-btn layui-btn-primary layui-btn-small"
                                            data-bind="click:function(){$root.reloadTable4();}">查询
                                    </button>
                                </div>
                            </div>
                        </div>
                        <table class="layui-table" lay-filter="table4" id="myTable4"></table>
                        <div class="modal-footer">
                            <button type="button"
                                    class="layui-btn layui-btn-primary layui-btn-small"
                                    data-bind="click:function(){$root.selectWarehouse('third')}">确定
                            </button>
                            <button type="button"
                                    class="layui-btn layui-btn-primary layui-btn-small"
                                    data-bind="click:function(){$root.hideModal('inModal','myTable4')}">取消
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>
<script src="${ctx}/js/app/jsmodel/add.js"></script>
<script>
    var hostUrl = "${ctx}";
    var vm = new Add(false, 0, [], [],hostUrl);
    ko.applyBindings(vm, $(".container-box")[0]);
    vm.initPage();
    var i = 0;

    var qualitySamples=${cf:toJSON(qualitySamples)};
    layui.form.on('select(sampleNo)',function(data){
        var child = $("#sampleNo option:selected").attr("sampleNo");
        $('#sampleNoId').val(child);
        var sampleNo=data.value;

        for(var i=0;i<qualitySamples.length;i++) {
            if (qualitySamples[i].sampleNo == sampleNo) {
                $('input[name="reportUnit"]').val(qualitySamples[i].sampleSouce || '');
                $('input[name="testDate"]').val(qualitySamples[i].testDate || '');
                $('input[name="testEndDate"]').val(qualitySamples[i].testEndDate || '');
                $('input[name="warehouseId"]').val(qualitySamples[i].warehouseId || '');

                $('select[name="variety"]').next().find("input").val(qualitySamples[i].variety || '');
                $("select[name='variety'] option:selected").attr("selected",false);
                $("select[name='variety'] option").each(function () {
                    if($(this).val()==qualitySamples[i].variety){
                        $(this).attr("selected",true);
                    }
                });

                $("input[name='storeDate']").val(qualitySamples[i].samplingDate.substr(0,7) || '');

                $("select[name='storeType']").next().find("input").val(qualitySamples[i].storeType || '');
                $("select[name='storeType'] option:selected").attr("selected",false);
                $("select[name='storeType'] option").each(function () {
                    if($(this).val()==qualitySamples[i].storeType){
                        $(this).attr("selected",true);
                    }
                });


                //         // $('input[name="variety"]').val(qualitySamples[i].variety || '');
                //         // $('input[name="varietyType"]').val(qualitySamples[i].varietyType || '');
                //         // $('input[name="storeEncode"]').val(qualitySamples[i].storehouse || '');
                //         // $('input[name="oilcanSerial"]').val(qualitySamples[i].storehouse || '');
                $('input[name="origin"]').val(qualitySamples[i].origin || '');
                //         // $('input[name="vehicleNumber"]').val(qualitySamples[i].vehicleNumber || '');
                $('input[name="harvestYear"]').val(qualitySamples[i].harvestYear || '');
                $('input[name="validType"]').val(qualitySamples[i].validType||'');
                $('input[name="storeEncode"]').val(qualitySamples[i].storehouse || '');
                //         // $('input[name="testDate"]').val(qualitySamples[i].testDate || '');
                //         // $('input[name="validType"]').val(qualitySamples[i].validType || '');
                //         // $('input[name="storeDate"]').val(Date_format(qualitySamples[i].storeTime, true) || '');
                //         // $('select[name="storeNature"]').val(qualitySamples[i].storeNature || '省级储备');
                //         // $('select[name="storeType"]').val(qualitySamples[i].storeType || '');
                ('input[name="quantity"]').val(qualitySamples[i].quantity || '');
                //         // if(qualitySamples[i].varietyType=='油'){
                //         // 	$('span#grain').hide();
                //         // }else if(qualitySamples[i].varietyType=='粮'){
                //         // 	$('span#oil').hide();
                //         // }else{
                //         // 	$('span#grain').hide();
                //         // 	$('span#oil').hide();
                //         // }
                //         layui.form.render('select');
                //         break;
                //     } else {
                //         continue;
            }
        }
    });


    layui.use('laydate', function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#storeDate'
            , type: 'month'
            , format: 'yyyy-MM-dd' //可任意组合
        });


    });
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        var harvestYear = laydate.render({
            elem: '#harvestYear'
            , type: 'year'
            , format: 'yyyy' //可任意组合
        });
        var laydate = layui.laydate;
        laydate.render({
            elem: '#testDate'
            ,format: 'yyyy-MM-dd' //可任意组合
        });
        var laydate = layui.laydate;
        laydate.render({
            elem: '#testEndDate'
            ,format: 'yyyy-MM-dd' //可任意组合
        });
        /*var testDate = laydate.render({
            elem: '#testDate',
            format: 'yyyy-MM-dd', //可任意组合
            min:"1970-1-1",//设置min默认最小值
            done:function(value,date,endDate){
                testDate.config.max ={
                    year:date.year,
                    month:date.month-1, //关键
                    date: date.date,
                    hours: 0,
                    minutes: 0,
                    seconds : 0
                };
            }
        });*/


        /*var validity = laydate.render({
             elem: '#validity',
             format: 'yyyy-MM-dd', //可任意组合
            max:"2099-12-31",//设置一个默认最大值
            done:function(value,date,endDate){
                validity.config.min ={
                    year:date.year,
                    month:date.month-1, //关键
                    date: date.date,
                    hours: 0,
                    minutes: 0,
                    seconds : 0
                };
               /!* harvestYear.config.max ={
                    year:date.year,
                    month:date.month-1, //关键
                    date: date.date,
                    hours: 0,
                    minutes: 0,
                    seconds : 0
                };*!/

               /!* if(value != null && value != ''){
                    if((date.month + 3) <= 12){
                        date.month =  date.month+3;
                    }else{
                        date.month = 3 - ( 12 - date.month);
                        date.year = date.year + 1;
                    }
                    //console.log(date.year+"-"+date.month+"-"+date.date);
                    //alert((date.month<10?('0'+date.month):date.month))
                    $("#testEndDate").val(date.year+"-"+(date.month<10?('0'+date.month):date.month)+"-"+(date.date<10?('0'+date.date):date.date));
                }*!/
            }
         });*/
    });

    /*layui.use('laydate', function () {
        var laydate = layui.laydate;
       var validity = laydate.render({
            elem: '#validity',
             format: 'yyyy-MM-dd', //可任意组合
           min:"1970-1-1",//设置min默认最小值
           done:function(value,date,endDate){
               testDate.config.max ={
                   year:date.year,
                   month:date.month-1, //关键
                   date: date.date,
                   hours: 0,
                   minutes: 0,
                   seconds : 0
               };
           }
        });
    });*/
    $(function () {
        var auvp = '${auvp}';
        document.getElementById("acceptedUnit").value = '${entity.acceptedUnit }';
        document.getElementById("variety").value = '${entity.variety }';
        document.getElementById("storeType").value = '${entity.storeType }';
        if (auvp == 'v') {
            $("#cancel").text("返回");
        } else {
            $("#cancel").text("取消");
        }
        if (auvp == 'v') {
            $('#storeDate').attr('disabled', true);
            $('#testDate').attr('disabled', true);
            //下拉框禁用
            $("select").each(function () {
                $("#" + this.id).attr("disabled", true);
            });
            $("form").find("input,textarea,select").prop("readonly", true);
            $('#btnSave').hide();
            layui.form.render("select", "form1");
        } else if (auvp = 'u') {
            $('#id').prop("readonly", true);
            layui.form.render("select", "form1");
        }

    });
    layui.use('laydate', function () {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#purchaseDate' //指定元素
        });
    });
    //自定义错误显示位置
    $('.form_input').validationEngine({
        promptPosition: 'bottomRight',
        addPromptClass: 'formError-white'
    });

    function addList(grade, itemName, standard,orderNo) {
        var tr = '<tr id="addtr" class="addtr">'
            + '<td colspan="1"><input maxlength="20" type="text" value="' + itemName + '" id="itemName" name="itemName" readonly="readonly" class="form-control validate[required] "placeholder=""/></td>'
            +'<input readonly="readonly" type="hidden" value="'+orderNo+'" id="orderNo" name="orderNo" class="form-control validate[required] "placeholder=""/>'
            + '<td colspan="1"><input maxlength="10" type="text" value="' + grade + '" id="gradeItem" name="gradeItem" readonly="readonly" class="form-control validate[required] "  placeholder=""/></td>'
            + '<td colspan="1"><input maxlength="20" type="text" value="' + standard + '" id="standard" name="standard" readonly="readonly" class="form-control"   placeholder=""/>'
            /* + '<td colspan="1"><input maxlength="20" type="text" id="result" name="result" class="form-control  "placeholder=""/>'*/
            +'<td colspan="1" id="kin"><textarea rows="1" name="result" class="form-control" placeholder="" maxlength="125"></textarea></td>'
            + '<td colspan="1"><input maxlength="20" type="text" id="remark" name="remarkItem" class="form-control  "placeholder=""/>'
            + '<input type="hidden" id="resultId" name="resultId" style="width:0px;"/></td>'
            +'<td colspan="1" id="kin"><a href="javascript:void(0);" onclick="toDeleteTr(this);" class="layui-btn layui-btn-small layui-bg-red" data-id="">删除</a></td>'
            + '</tr>'
        $("#Detail").append(tr);
    }

    function toDelete() {
        $("tr.addtr").remove();
    }

    var lastClickTime = 0;
    var DELAY = 20000;
    $("#btnSave").click(function () {
        var beginDate=$("#testDate").val();
        var endDate=$("#testEndDate").val();


        var storeDate = document.getElementById("storeDate").value;
        var testDate = document.getElementById("testDate").value;
        var testEndDate = document.getElementById("testEndDate").value;
        var templetNo= document.getElementById("templetNo").value;
        var harvestYear= document.getElementById("harvestYear").value;
        var reportUnit= document.getElementById("reportUnit").value;
        var acceptedUnit= document.getElementById("acceptedUnit").value;
        var variety= document.getElementById("variety").value;
        var storeType = $("#storeType option:selected").val();

        var str = "";
        if (acceptedUnit==""){
            if (str == "") {
                str += "承检单位不能为空";
            } else {
                str += ",承检单位不能为空";
            }
        }else if (variety==""){
            if (str == "") {
                str += "样品名称不能为空";
            } else {
                str += ",样品名称不能为空";
            }
        }else if (storeDate == "") {
            if (str == "") {
                str += "入库时间不能为空";
            } else {
                str += ",入库时间不能为空";
            }
        } else if (testDate == "") {
            if (str == "") {
                str += "检验日期开始日期不能为空";
            } else {
                str += ",检验日期开始日期不能为空";
            }

        } else if (testEndDate == "") {
            if (str == "") {
                str += "检验日期截止日期不能为空";
            } else {
                str += ",检验日期截止日期不能为空";
            }
        }else if (templetNo==""){
            if (str == "") {
                str += "检测模板编号不能为空";
            } else {
                str += ",检测模板编号不能为空";
            }
        }else if (harvestYear==""){
            if (str == "") {
                str += "收获年份不能为空";
            } else {
                str += ",收获年份不能为空";
            }
        }else if (reportUnit==""){
            if (str == "") {
                str += "受检单位不能为空";
            } else {
                str += ",受检单位不能为空";
            }
        }else if(storeType == null||storeType==""){
            if(str == ""){
                str += "储存方式不能为空";
            } else {
                str += ",储存方式不能为空";
            }
        }

        var d1 = Date.parse(new Date(testDate));
        var d2 = Date.parse(new Date(testEndDate));
        if(beginDate!=""&&endDate!=""){
            if (d1-d2>=0){
                alert("检验日期截止日期要大于检验日期开始日期");
                return;
            }
        }
        if (str == "") {
            if ($(".form_input").validationEngine('validate') == true) {
                var currentTime = Date.parse(new Date());
                if (currentTime - lastClickTime > DELAY) {
                    lastClickTime = currentTime;
                    $("#btnSave").attr("disabled", true);
                    $(".form_input").ajaxSubmit({
                        type: "post",
                        success: function (data) {
                            if (data.success) {

                                alert("保存成功");
                                location.href = "${ctx}/QualityThird.shtml";
                            } else {
                                alert("保存失败");
                                $("#btnSave").attr("disabled", false);
                            }
                        }
                    });
                }
            }
        } else {
            layer.closeAll(); //疯狂模式，关闭所有层
            layer.open({
                title: '提示信息'
                , content: str
            });
        }

    });

    $("#cancel").click(function () {
        var auvp = '${auvp}';
        if (auvp == 'v') {
            history.go(-1);
        } else {
            layer.confirm('您是否要放弃', function (index) {
                history.go(-1);
            });

        }

    });

    function toAddSelect() {
        $.colorbox({
            title: '选择粮油数据',
            iframe: true,
            opacity: 0.2,
            href: "${ctx}/QualityThird/listChoice.shtml",
            innerWidth: '1100px',
            innerHeight: '80%',
            close: '×15151',
            fixed: true
        });
    }

    function selectToData(data) {
        toDelete();
        $("input[name='templetNo']").val(data.templetNo);
        var itemName = data.itemName.split(",");
        var itemId = data.itemId.split(",");
        var grade = data.grade.split(",");
        var standard = data.standard.split(",");
        var orderNo=data.orderNo.split(",");
        i = itemId.length;
        for (var i = 0; i < itemId.length; i++) {
            addList(grade[i], itemName[i], standard[i],orderNo[i]);
        }

    }
    function toDeleteTr(ob){
        $(ob).parent().parent().remove();
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

</script>
<script src="${ctx}/js/select/jquery.combo.select.js"></script>
</body>
</html>
