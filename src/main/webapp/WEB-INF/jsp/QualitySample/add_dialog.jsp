<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/11 0011
  Time: 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
</head>
<body>
<style>
    #search3 dl{
        max-width:100%;
    }
    #myTable4 + .layui-form .layui-table-body td[data-field="warehouseCode"]{
        text-align: left;
    }
    #myTable4 + .layui-form .layui-table-body td[data-field="warehouseShort"]{
        text-align: left;
    }
    #myTable4 + .layui-form .layui-table-body td[data-field="warehouseName"]{
        text-align: left;
    }
    .modal-backdrop.in{
        display: none;
    }
</style>

<div class="row clear-m">
    <ol class="breadcrumb">
        <li>位置:</li>
        <li>质量管理</li>
        <li class="active"><c:if test="${auvp=='a'}">
            新增
        </c:if>
            <c:if test="${auvp=='u'}">
                编辑
            </c:if>
            <c:if test="${auvp=='v'}">
                查看
            </c:if>样品信息</li>
    </ol>
    <div class="container-box clearfix" style="padding: 10px">
        <!--检验结果表-->
        <form class="form_input"  action="QualitySample/save.shtml" method="post" lay-filter="form" enctype="multipart/form-data">
            <input type="hidden" name="auvp" value="${auvp}">
            <input type="hidden" name="id"  value="${QualitySample.id }"/>
            <table class="table table-bordered">
                <!-- 表格内容 start -->
                <tbody>
                <tr>
                    <td class="text-right"><span class="red">*</span><b> 样品编号:</b></td>
                    <td><input type="text" lay-verify="required" maxlength="15" autocomplete="off" name="sampleNo" id="sampleNo" value="${QualitySample.sampleNo }"  class="form-control validate[required]" placeholder="--请输入--" onchange="check();"/></td>
                    <td class="text-right"><span class="red">*</span><b> 数量(吨):</b></td>
                    <td><input type="text" maxlength="13"  oninput="clearNoNum(this)" name="quantity" value="${QualitySample.quantity }" autocomplete="off" class="form-control validate[required]" placeholder="--请输入--"/></td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b> 成交明细号:</b></td>
                    <td>

                        <input type="text" autocomplete="off" lay-verify="required" name="dealSerial" id="dealSerial" value="${QualitySample.dealSerial }" class="form-control validate[required]" placeholder="--请选择--" />
                        <c:if test="${isEdit}">
                            <a type="button" class="btn btn-link" id="chooseBtn_1" data-target="#myModal" data-toggle="modal">选择</a>
                            <a type="button" class="btn btn-link" id="userMode">自定义</a>
                        </c:if>
                    </td>
                    <td class="text-right"><b> 扦样日期:</b></td>
                    <td><input type="text" lay-verify="required" name="samplingDate" id="samplingDate" value="${QualitySample.samplingDate }"  class="form-control " autocomplete="off" placeholder="--请选择时间--"/></td>
                    <%--<td class="text-right"><span class="red"></span><b> 粮食储存方式:</b></td>
                  <td><input type="text"  name="storageWay" value="${QualitySample.storageWay }" class="form-control" placeholder="--请输入--"/></td>--%>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b> 样品来源:</b></td>
                    <td>
                        <input type="hidden" name="warehouseId" value="${QualitySample.warehouseId}">
                        <input type="text" autocomplete="off" readonly="readonly" lay-verify="required" tag="model" name="sampleSouce" value="${QualitySample.sampleSouce }" warehouseid="${QualitySample.warehouseId}" warehouseType="id" class="form-control validate[required]" placeholder="--自动带出--"/>

                        <a type="button" class="btn btn-link" <c:if test="${!(isEdit && isEditSampleSouce)}"> style="display: none" </c:if> id="chooseBtn" data-target="#myModal" data-bind="click:function(){$root.showModal($data);}">选择</a>

                    </td>
                    <td class="text-right"><span class="red"></span><b> 任务执行人:</b></td>
                    <td><input type="text" autocomplete="off"  name="executor" maxlength="5" value="${QualitySample.executor }" class="form-control" placeholder="--请输入--"/></td>
                </tr>
                <tr>

                    <td class="text-right"><span class="red">*</span><b>仓/罐号:</b></td>
                    <td>
                        <select lay-verify="required" class="form-control validate[required]" disabled="disabled" id="storehouse" name="storehouse" >
                            <if test="${not empty QualitySample.storehouse}">
                                <option value="${QualitySample.storehouse}">${QualitySample.storehouse}</option>
                            </if>
                            <%--<option value="p30" selected="selected">p30</option>--%>
                        </select>
                        <%--<input type="text"  name="storehouse" id="storehouse" readonly="readonly" value="${QualitySample.storehouse }" class="form-control validate[required]" placeholder="--自动带出--"/>--%>
                        <c:if test="${isEdit}">
                            <a type="button" class="btn btn-link" id="userMode1">自定义</a>
                        </c:if>
                    </td>
                    <td class="text-right"><span class="red">*</span><b> 粮食品种:</b></td>
                    <td>
                        <%--<input type="text" lay-verify="required"  name="variety" id="variety" readonly="readonly" value="${QualitySample.variety }" class="form-control validate[required]" placeholder="--自动带出--"/>--%>
                        <select lay-verify="required" name="variety" id="variety" class="form-control validate[required]" disabled="disabled">
                            <option value="">--请选择--</option>
                            <option value="小麦" <c:if test="${QualitySample.variety eq '小麦'}">selected</c:if>>小麦</option>
                            <option value="早籼稻谷" <c:if test="${QualitySample.variety eq '早籼稻谷'}">selected</c:if>>早籼稻谷</option>
                            <option value="晚籼稻谷" <c:if test="${QualitySample.variety eq '晚籼稻谷'}">selected</c:if>>晚籼稻谷</option>
                            <option value="粳稻谷" <c:if test="${QualitySample.variety eq '粳稻谷'}">selected</c:if>>粳稻谷</option>
                            <option value="玉米" <c:if test="${QualitySample.variety eq '玉米'}">selected</c:if>>玉米</option>
                            <option value="菜籽油" <c:if test="${QualitySample.variety eq '菜籽油'}">selected</c:if>>菜籽油</option>
                            <option value="大豆油" <c:if test="${QualitySample.variety eq '大豆油'}">selected</c:if>>大豆油</option>
                            <option value="花生油" <c:if test="${QualitySample.variety eq '花生油'}">selected</c:if>>花生油</option>
                            <option value="葵花籽油" <c:if test="${QualitySample.variety eq '葵花籽油'}">selected</c:if>>葵花籽油</option>
                            <option value="其他油" <c:if test="${QualitySample.variety eq '其他油'}">selected</c:if>>其他油</option>
                        </select>


                        <input type="hidden" name="varietyType" id="varietyType" value='${entity.varietyType }' class="form-control"  placeholder=""/>
                    </td>
                </tr>
                <tr>

                    <td class="text-right"><span class="red">*</span><b> 收获年份:</b></td>
                    <td><input type="text" lay-verify="required"  disabled="disabled" name="harvestYear" id="harvestYear" readonly="readonly" value="${QualitySample.harvestYear }" class="form-control validate[required]"autocomplete="off" placeholder="--自动带出--"/></td>
                    <td class="text-right"><span class="red">*</span><b> 产地:</b></td>
                    <td>
                        <input type="text" name="origin" id="origin" readonly="readonly" class="form-control validate[required]" value="${QualitySample.origin }" autocomplete="off" placeholder="--自动带出--"/>
                    </td>
                </tr>

                <tr>
                    <%--<td class="text-right"><span class="red">*</span><b> 扦样日期:</b></td>
                    <td><input type="text" lay-verify="required" name="samplingDate" id="samplingDate" value="${QualitySample.samplingDate }"  class="form-control " autocomplete="off" placeholder="--请选择时间--"/></td>--%>
                    <td class="text-right"><span class="red">*</span><b> 检验开始时间:</b></td>
                    <td><input type="text" lay-verify="required"  name="testDate" id="testDate" value="${QualitySample.testDate }"  class="form-control" autocomplete="off" placeholder="--请选择时间--"/></td>
                    <td class="text-right"><span class="red">*</span><b> 检验结束时间:</b></td>
                    <td><input type="text" lay-verify="required"  name="testEndDate" id="testEndDate" value="${QualitySample.testEndDate }"  class="form-control" autocomplete="off" placeholder="--请选择时间--"/></td>
                </tr>
                <tr>
                    <td class="text-right"><b> 扦样人:</b></td>
                    <td><input type="text"  maxlength="5" name="samplingPeople" autocomplete="off"  value="${QualitySample.samplingPeople }" class="form-control" placeholder="--请输入--"/></td>
                    <td class="text-right"><span class="red">*</span><b> 入库年月:</b></td>
                    <td><input type="text"  name="inStoreYear" autocomplete="off" id="inStoreYear" value="${QualitySample.inStoreYear }" class="form-control validate[required]" placeholder="--请选择--" autocomplete="off"/></td>
                    <td style="display:none;" class="text-right"><span class="red">*</span><b> 样品状态:</b></td>
                    <td style="display:none;">
                        <select lay-verify="required" name="testStatus" class="form-control validate[required]" id="testStatus" >
                            <!-- <option value="">--请选择--</option> -->
                            <option value="未检">未检</option>
                            <!-- <option value="在检">在检</option>
                            <option value="检毕">检毕</option>
                            <option value="销毁">销毁</option> -->
                        </select>
                    </td>
                    <%-- 	<td class="text-right"><span class="red">*</span><b> 检验人:</b></td>
                      <td><input type="text"  name="testPeople" value="${QualitySample.testPeople }" class="form-control validate[required]" placeholder="--请输入--"/></td> --%>
                </tr>
                <tr>
                    <td class="text-right"><span class="red" id="oil">*</span><b>储备性质:</b></td>
                    <td>
                        <select lay-verify="required" name="storeNature" id="storeNature" class="form-control validate[required]">
                            <option value="">--请选择--</option>
                            <option value="省级储备" <c:if test="${QualitySample.storeNature eq '省级储备'}">selected</c:if>>省级储备</option>
                            <option value="中央储备" <c:if test="${QualitySample.storeNature eq '中央储备'}">selected</c:if>>中央储备</option>
                        </select>
                    <td class="text-right"><span class="red" id="grain">*</span><b>储存方式:</b></td>
                    <td>
                        <select lay-verify="required" class="form-control validate[required]"  name="storeType" id="storeType">
                            <option value="">--请选择--</option>
                            <c:forEach items="${storeType}" var="storeType">
                                <c:if test="${storeType.value eq QualitySample.storeType }">
                                    <option value="${storeType.value}" selected="selected" >${storeType.value}</option>
                                </c:if>
                                <c:if test="${storeType.value ne QualitySample.storeType }">
                                    <option value="${storeType.value}" >${storeType.value}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red">*</span><b> 封存时间:</b></td>
                    <td><input type="text" readonly name="storeTime" id="storeTime" value='<fmt:formatDate value="${QualitySample.storeTime}" pattern="yyyy-MM-dd" />' class="form-control "autocomplete="off" placeholder="--请选择--"/></td>
                    <td class="text-right"><span class="red">*</span><b> 检验类型:</b></td>
                    <td>
                        <select lay-verify="required" class="form-control validate[required]"  name="validType" id="validType">
                            <option value="">--请选择--</option>
                            <c:forEach items="${validTypes}" var="item">
                                <option value="${item.value}">${item.value}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><span>&nbsp;&nbsp;</span><b>任务优先级:</b></td>
                    <td><input name="taskPriority" maxlength="10" class="form-control" placeholder="--请输入--" value="${QualitySample.taskPriority }"/></td>
                    <td class="text-right"><span class="red">*</span><b>质检类别:</b></td>
                    <td><select lay-verify="required" class="form-control validate[required]"  name="checkType">
                        <option value="">--请选择--</option>
                        <option <c:if test="${QualitySample.checkType==1}"> selected</c:if> value="1">内部质检</option>
                        <option <c:if test="${QualitySample.checkType==2}"> selected</c:if> value="2">第三方质检</option>
                    </select></td>
                </tr>
                <tr>
                    <td class="text-right"><span>&nbsp;&nbsp;</span><b>备注:</b></td>
                    <td colspan="3"><textarea rows="4" name="remark" class="form-control" placeholder="--请输入--" maxlength="500">${QualitySample.remark }</textarea></td>
                </tr>

                <!-- 表格内容 end -->
                </tbody>
            </table>
            <p>备注:带有<span class="red">*</span>为必填项！</p>
            <p class="btn-box text-center">
                <%--<button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">返回</button>--%>
                <button type="button" id="btnSave" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
                <button type="button" id="btnPrint" onclick="javascript:window.print();" class="layui-btn layui-btn-primary layui-btn-small ">打印</button>
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
                                            data-bind="click:function(){$root.reloadTable4();}">查询</button>
                                </div>
                            </div>
                        </div>
                        <table class="layui-table" lay-filter="table4" id="myTable4"></table>
                        <div class="modal-footer">
                            <button type="button"
                                    class="layui-btn layui-btn-primary layui-btn-small"
                                    data-bind="click:function(){$root.selectWarehouse()}">确定</button>
                            <button type="button"
                                    class="layui-btn layui-btn-primary layui-btn-small"
                                    data-bind="click:function(){$root.hideModal('inModal','myTable4')}">取消</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 模态框（Modal） -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="layui-form" id="search3" lay-filter="search3">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">粮食品种:</label>
                                    <div class="layui-input-inline">
                                        <select id="grainType" lay-search lay-filter="dealId">
                                            <option value="">--请选择--</option>
                                            <c:forEach items="${variety}" var="item">
                                                <option>${item.value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">收获年份:</label>
                                    <div class="layui-input-inline">
                                        <input class="layui-input" name="warehoueYear" autocomplete="off">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">库点:</label>
                                    <div class="layui-input-inline">
                                        <input class="layui-input" name="receivePlace" autocomplete="off">
                                        <%--<select name="receivePlace">
                                            <option value="">全部</option>
                                            <c:forEach items="${warehouse}" var="warehouse">
                                                <option value="${warehouse.warehouseShort}">${warehouse.warehouseShort}</option>
                                            </c:forEach>
                                        </select>--%>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">仓号:</label>
                                    <div class="layui-input-inline">
                                        <input class="layui-input" name="storehouse"  autocomplete="off">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">产地:</label>
                                    <div class="layui-input-inline">
                                        <input class="layui-input" name="origin"  autocomplete="off">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <button class="layui-btn layui-btn-primary layui-btn-small" id="sc" data-type="reload" data-bind="click:function(){$root.queryPageList(1);}">查询</button>
                                </div>
                            </div>
                            <div class="layui-form-item">

                            </div>
                        </div>
                        <div class="layui-row title">
                            <h5>明细详情</h5>
                        </div>
                        <table class="layui-table">
                            <thead>
                            <tr>
                                <td data-bind="visible:list().length!=0"></td>
                                <td align="center">成交子明细号</td>
                                <td align="center">粮食品种</td>
                                <td align="center">产地</td>
                                <td align="center">收获年份</td>
                                <td align="center">交货/接收库</td>
                                <td align="center">仓号</td>
                                <td align="center">交货起始日期</td>
                                <td align="center">交货截止日期</td>
                                <td align="center">储存方式</td>
                            </tr>
                            </thead>
                            <tbody data-bind="foreach:list">
                            <tr>

                                <td><input type="radio" name="radio"
                                           data-bind="click:function(){$root.choose($data);return true;}" /></td>

                                <td data-bind="text:dealSerial" align="left"></td>
                                <td data-bind="text:grainType" align="left"></td>
                                <td data-bind="text:produceArea" align="left"></td>
                                <td data-bind="text:warehoueYear?warehoueYear:''" align="center"></td>
                                <!-- ko if: produceYear&&'--'!=produceYear  -->
                                <!-- <td data-bind="text:produceYear"></td> -->
                                <!-- /ko -->
                                <!-- ko if: deliveryPlace&&'--'!=deliveryPlace  -->
                                <!-- <td data-bind="text:deliveryPlace"></td> -->
                                <!-- /ko -->
                                <td data-bind="text:receivePlace?(receivePlace=='--'?deliveryPlace:receivePlace):deliveryPlace	" align="left"></td>
                                <td data-bind="text:storehouse?storehouse:''" align="left"></td>
                                <td data-bind="text:deliveryStart?deliveryStart:''" align="center"></td>
                                <td data-bind="text:deliveryEnd?(deliveryEnd=='--'?takeEnd:deliveryEnd):takeEnd" align="center"></td>
                                <td data-bind="text:storageType?storageType:''" align="left"></td>
                            </tr>
                            </tbody>

                        </table>

                        <div class="layui-row">
                            <div id="pagination" class="pull-right"></div>
                        </div>

                    </div>


                    <div class="modal-footer">
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.confirmChoose();}">确定</button>
                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>

</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>
<script>
    function clearNoNum(obj){
        //修复第一个字符是小数点 的情况.  
        if(obj.value !=''&& obj.value.substring(0,1) == '.'){
            obj.value="";
        }
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d\d).*$/,'$1$2.$3');//只能输入两个小数
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
    layui.laydate.render({
        elem:$('[name="warehoueYear"]')[0],
        type:"year",
        format:"yyyy",

    });
    var testDate=layui.laydate.render({
        elem: '#testDate',
        type: 'date',
        done:function(value,date,endDate){
            testEndDate.config.min ={
                year:date.year,
                month:date.month-1, //关键
                date: date.date,
                hours: 0,
                minutes: 0,
                seconds : 0
            };
            if(value != null && value != ''){
                /*$("#testEndDate").val(date.year+"-"+(date.month<10?('0'+date.month):date.month)+"-"+(date.date<10?('0'+date.date):date.date)+" "+(date.hours<10?('0'+date.hours):date.hours)+":"+(date.minutes<10?('0'+date.minutes):date.minutes)+":"+(date.seconds<10?('0'+date.seconds):date.seconds));*/
                $("#testEndDate").val(date.year+"-"+(date.month<10?('0'+date.month):date.month)+"-"+(date.date<10?('0'+date.date):date.date));
                //向后推3个月
                var d = new Date(date.year+"-"+(date.month<10?('0'+date.month):date.month)+"-"+(date.date<10?('0'+date.date):date.date));
                d.setMonth(d.getMonth()+3);
                //alert(d.toLocaleDateString());

                /*if((date.month + 3) <= 12){
                  date.month =  date.month+3;
                }else{
                  date.month = 3 - ( 12 - date.month);
                  date.year = date.year + 1;
                }*/
                //console.log(date.year+"-"+date.month+"-"+date.date);
                //alert((date.month<10?('0'+date.month):date.month))
                //$("#storeTime").val(date.year+"-"+(date.month<10?('0'+date.month):date.month)+"-"+(date.date<10?('0'+date.date):date.date));
                $("#storeTime").val(d.getFullYear()+"-"+(d.getMonth()+1<10?('0'+(d.getMonth()+1)):d.getMonth()+1)+"-"+(d.getDate()<10?('0'+d.getDate()):d.getDate()));
            }
        }
    });
    var testEndDate=layui.laydate.render({
        elem: '#testEndDate',
        type: 'date',
        done:function(value,date,endDate){
            testDate.config.max ={
                year:date.year,
                month:date.month-1, //关键
                date: date.date,
                hours: 0,
                minutes: 0,
                seconds : 0
            };

            if(value != null && value != ''){
                /*if((date.month + 3) <= 12){
                    date.month =  date.month+3;
                }else{
                    date.month = 3 - ( 12 - date.month);
                    date.year = date.year + 1;
                }*/
                //向后推3个月
                var d = new Date(date.year+"-"+(date.month<10?('0'+date.month):date.month)+"-"+(date.date<10?('0'+date.date):date.date));
                d.setMonth(d.getMonth()+3);
                //alert(d.getMonth()+1)
                //console.log(date.year+"-"+date.month+"-"+date.date);
                //$("#storeTime").val(date.year+"-"+(date.month<10?('0'+date.month):date.month)+"-"+(date.date<10?('0'+date.date):date.date));
                $("#storeTime").val(d.getFullYear()+"-"+(d.getMonth()+1<10?('0'+(d.getMonth()+1)):d.getMonth()+1)+"-"+(d.getDate()<10?('0'+d.getDate()):d.getDate()));
            }
        }
    });

    /*layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#testDate'
            ,format: 'yyyy-MM-dd' //可任意组合
        });
    });
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#testEndDate'
            ,format: 'yyyy-MM-dd' //可任意组合
        });
    });*/

    layui.laydate.render({
        elem: '#samplingDate'
        ,format: 'yyyy-MM-dd' //可任意组合
    });



    $(function(){
        var auvp = '${auvp}';
        var hasTask = '${hasTask}' == 'true'?true:false;

        /*	layui.laydate.render({
                elem : '#storeTime',
                format : 'yyyy-MM-dd',
                value : $('#storeTime').val()
            });*/

        // 格式化日期
        $("#testDate,#testEndDate").each(function () {
            $(this).val($(this).val().split(" ")[0]);
        });

        $("#userMode").click(function(){
            layer.confirm("要进入自定义模式么？",{btn:['是','否'],
                btn1:function(index){
                    $("input[placeholder='--自动带出--']").each(function(){
                        $(this).removeAttr("readonly");
                        $(this).attr("placeholder","")
                    });
                    $("#variety").removeAttr("disabled")
                    $("#harvestYear").removeAttr("disabled")
                    layer.close(index);
                },
                btn2:function(){
                    //do nothing;
                }
            })
        });

        $("input[tag='model']").click(function () {
            $("#chooseBtn").click();
        });

        // 仓罐号自定义
        $("#userMode1").click(function(){
            // 获取warehouseCode
            var warehouseCode = $("input[tag='model']").attr("warehouseCode");
            var warehouseId = $("input[tag='model']").attr("warehouseid");
            var warehouseType = $("input[tag='model']").attr("warehouseType");
            if((warehouseId==null ||warehouseId=="")&&(warehouseCode==null || warehouseCode=="")){
                layer.msg("请先选择样品来源");
            }else {
                layer.confirm("是否自定义仓/罐号？", {
                    btn: ['是', '否'],
                    btn1: function (index) {
                        $("#storehouse").removeAttr("disabled");
                        if(warehouseType=="id")
                            updateStroehouse(warehouseId,"");
                        else
                            updateStroehouse("",warehouseCode);
                        // $("#storehouse").attr("placeholder","--请输入--");
                        layer.close(index);
                    },
                    btn2: function () {
                        //do nothing;
                    }
                })
            }
        });

        document.getElementById("testStatus").value ='${QualitySample.testStatus }';
        document.getElementById("validType").value ='${QualitySample.validType }';
        if(auvp=='v'){$("#cancel").text("返回");}else{$("#cancel").text("取消");}
        if(auvp=='v'){
            $('#testDate').attr('disabled',true);
            $('#testEndDate').attr('disabled',true);
            $('#samplingDate').attr('disabled',true);
            $('#storeTime').attr('disabled',true);
            //下拉框禁用
            $("select").attr({"disabled":"disabled"});
            $("form").find("input,textarea,select").prop("readonly", true);
            $('#btnSave').hide();
            $('#btnPrint').hide();
        }else if(auvp=='u'){
            $('#sampleNo').prop("readonly", true);
            $('#id').prop("readonly", true);
            $('#btnPrint').hide();
            if(hasTask){
                $('#storeTime').attr('disabled',true);
                $("select").attr({"disabled":"disabled"});
                $("form").find("input,textarea,select").prop("readonly", true);
                $("#testStatus").removeAttr("disabled");
                $('textarea[name="remark"]').prop("readonly", false);
            }
        }else if(auvp=='p'){
            $("select").attr({"disabled":"disabled"});
            $("form").find("input,textarea,select").prop("readonly", true);
            $('#btnSave').hide();
        }else if(auvp=='a'){
            $('#btnPrint').hide();
        }

    });

    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#purchaseDate' //指定元素
        });
        laydate.render({
            elem:"#inStoreYear",
            type:"month"
        });
        laydate.render({
            elem:"#harvestYear",
            type:"year"
        });
    });
    //自定义错误显示位置
    $('.form_input').validationEngine({
        promptPosition: 'bottomRight',
        addPromptClass: 'formError-white'
    });



    $("#btnSave").click(function(){
        if(!$(".form_input").validationEngine('validate')==true){
            return;
        }

//    var harvestYear=document.getElementById("harvestYear").value;
        var samplingDate=document.getElementById("samplingDate").value;
        var testDate=document.getElementById("testDate").value;
        var testEndDate=document.getElementById("testEndDate").value;
        var storeTime=$('#storeTime').val();
        var str="";
        /* if(harvestYear==""){
        if(str==""){
                    str+="收获年份不能为空";
                    }else{
                    str+=",收获年份不能为空";
                    }
        } */

        if(testDate==""){
            if(str==""){
                str+="检验开始时间不能为空";
            }else{
                str+=",检验开始时间不能为空";
            }
        }
        if(testEndDate==""){
            if(str==""){
                str+="检验结束时间不能为空";
            }else{
                str+=",检验结束时间不能为空";
            }
        }
        if(storeTime==""){
            if(str==""){
                str+="封存时间不能为空";
            }else{
                str+=",封存时间不能为空";
            }
        }
        var variety = $()
        if(samplingDate!=""&&testDate!=""){
            var arr1 = samplingDate.split("-");
            var arr2 = testDate.split("-");
            var date1=new Date(parseInt(arr1[0]),parseInt(arr1[1])-1,parseInt(arr1[2]),0,0,0);
            var date2=new Date(parseInt(arr2[0]),parseInt(arr2[1])-1,parseInt(arr2[2]),0,0,0);
            if(date1.getTime()>date2.getTime()) {
                if(str==""){
                    str+="检验时间不能小于扦样日期";
                }else{
                    str+=",检验时间不能小于扦样日期";
                }
            }
        }
        if(str==""){


            layer.load();
            $("#storehouse").removeAttr("disabled");
            $(".form_input").ajaxSubmit({
                type:"post",
                success:function(data){
                    if(data.success){
                        layerMsgSuccess("保存成功",function(){location.href="${ctx}/QualitySample.shtml"});
                    }else{
                        $("#storehouse").attr("disabled","disabled");
                        layerMsgError("保存失败");
                    }
                },
                error:function(xhr){
                    layerMsgError("数据接口异常");
                },
                complete:function(){
                    layer.closeAll('loading');
                }
            });

        }else{
            layer.closeAll(); //疯狂模式，关闭所有层
            layer.open({
                title: '提示信息'
                ,content: str
            });
        }

    });

    $("#cancel").click(function(){
        var auvp = '${auvp}';
        if(auvp=='v'){
            history.go(-1);
        }else{
            layer.confirm('您是否要放弃', function(index) {
                history.go(-1);
            });

        }

    });

    function check(){
        var sampleNo=document.getElementById("sampleNo").value;
        $.post("${ctx}/QualitySample/check.shtml",{
            sampleNo : sampleNo
        }, function(result) {
            if (!result.success) {
                layer.closeAll(); //疯狂模式，关闭所有层
                layer.open({
                    title: '提示信息'
                    ,content: '样品编号已存在'
                });
                document.getElementById("sampleNo").value="";
            }
        });
    }

    // 更新仓罐号
    function updateStroehouse(warehouseId,warehouseCode){
        // 刷新列表
        $.post("${ctx}/storageStoreHouse/listStoreHouseAndOilcan.shtml",{
            warehouseId: warehouseId,
            warehouseCode: warehouseCode
        },function (data) {
            var stroehouseCode  = $("#storehouse option:selected").val();
            // 清空选项
            $("#storehouse").html("");
            // 添加选项
            if(data!=null && data.length > 0){
                for(var i = 0; i < data.length; i++){
                    if(data[i]!=stroehouseCode) {
                        $("#storehouse").append("<option value=\"" + data[i] + "\">" + data[i] + "</option>");
                    }else{
                        $("#storehouse").append("<option selected=\"selected\" value=\"" + data[i] + "\">" + data[i] + "</option>");
                    }
                }
                // 设置第一个选项为默认
                if(stroehouseCode==null || stroehouseCode=="") {
                    $("#storehouse option:eq(0)").attr('selected', 'selected');
                }
            }
        });
    }

    //成交明细模态框
    layui.form.render('select','search3');
    var selectedDealSerial = null;
    layui.form.on('select(dealId)',function(data){
        // debugger;
        if(selectedDealSerial!=data.value){
            vm.list([]);
            selectedDealSerial = data.value;
            vm.queryPageList(1);
        }
    });
    var isfirst=false;
    var vm={
        selectedDeal:null,
        curDeal:null,
        curNotice:null,
        pageindex:1,
        pagesize:10,
        total:0,
        list:ko.observableArray([]),
        init:function(object){
            object.dealDate=Date_format(object.dealDate,true);
            object.gatherDate=Date_format(object.gatherDate,true);
        },
        renderPage:function(elemId){
            var self=this;
            $("#"+elemId).children('div').remove();
            layui.laypage.render({
                elem:elemId,
                count:self.total,
                limit:self.pagesize,

                jump:function(obj,first){
                    if(!first){
                        self.pageindex=obj.curr;
                        self.pagesize=obj.limit;
                        self.queryPageList(self.pageindex);
                    }
                }
            })
        },
        //子明细搜索
        queryPageList:function(pageindex){
            var self=this;
            var warehoueYear = $('#search3 input[name="warehoueYear"]').val();
            var storehouse = $('#search3 input[name="storehouse"]').val();
            var origin = $('#search3 input[name="origin"]').val();
            var receivePlace = $('#search3 input[name="receivePlace"]').val();
            var grainType = $('#search3 #grainType').val();
            var pageIndexs=pageindex;
            var pageSizes=10;
//		 debugger;
// 		 if (isfirst){
// 		     pageIndexs=1;
//              pageSizes=10;
//              isfirst=false;
// 		 }else {
//              pageIndexs=self.pageindex;
//              pageSizes=self.pagesize;
// 		 }
            layer.load();

            $.ajax({
                url:"${ctx}/rotateConclute/listDetailForSample.shtml",
                type:"POST",
                data:{
                    pageIndex:pageIndexs,
                    pageSize:pageSizes,
                    grainType:grainType,
                    receivePlace:receivePlace,
                    warehoueYear:warehoueYear,
                    produceArea:origin,
                    storehouse:storehouse,
                    status:'已分发'
                },
                success:function(res){
                    var list= res.result||[];
                    for(var i=0;i<list.length;i++){
                        self.init(list[i]);
                    }
                    self.list(list);
                    var pageReload=self.pageindex!=res.pageIndex
                        ||self.total!=res.totalCount;
                    self.pageindex=res.pageIndex;
                    self.pagesize=res.pageSize;
                    self.total=res.totalCount;
                    if(pageReload){
                        self.renderPage("pagination");
                    }
                },
                error:function(xhr){
                    layerMsgError("数据接口异常");
                },
                complete:function(){
                    layer.closeAll('loading');
                }
            });
        },

        hideModal1:function(){
            $('#search3 select#dealId').val("");
            $('#search3 input[name="dealSerial"]').val("");
            layui.form.render('select','search3');
            this.list([]);
            $('#myModal').modal('hide');
        },

        choose:function(data){
            this.selectedDeal=data;
        },

        // 成交明细号 确认按钮绑定事件
        confirmChoose:function(){
            // debugger;
            var self=this;
            if(!self.selectedDeal){
                layer.msg('请先选择交易明细',{icon:0});
                return;
            }
            //根据交易明细获取出入库通知书
            /* $.ajax({
                url:"../RotateNotif/GetNoticeByDealSerial.shtml",
                type:"POST",
                data:{
                    dealSerial:self.selectedDeal.dealSerial
                },
                success:function(res){
                    if(res.success){
                        self.curNotice = res.data;
                    }else{
                        layerMsgError(res.msg);
                    }
                },
                error:function(xhr){
                    layerMsgError("数据接口异常:获取通知书");
                },
                complete:function(){
                    layer.closeAll('loading');
                }
            }); */
            self.curDeal = self.selectedDeal;
            self.fillInput();
            self.hideModal1();
        },

        // 成交明细号 确认按钮绑定事件
        fillInput:function(){
            var warehouseId="";
            var vm = this;
            // debugger
            if(this.curDeal){
                $.ajax({
                    <%--url:"${ctx}/QualitySample/pageQuery.shtml",--%>
                    url:"${ctx}/QualitySample/findErlySample.shtml",
                    data:{
                        dealSerial:this.curDeal.dealSerial,
                        validType:'入库质检'
                    },
                    type:"get",
                    success:function(data){
                        if(data!=""){
                            //回填第一次入库质检的数据
                            /*var list = data.data;
                            var qualtitySample = list[0];*/
                            warehouseId = data.warehouseId;
                            $("input[tag='model']").attr("warehouseid",warehouseId).attr("warehouseType","id");	// 保存warehouseId 编号
                            var qualtitySample = data;
                            if(qualtitySample.warehouseId==null){
                                qualtitySample.warehouseId= warehouseId;
                            }
                            //alert(JSON.stringify(qualtitySample.inStoreYear))
                            $('input[name="warehouseId"]').val(qualtitySample.warehouseId);
                            $('input#dealSerial').val(qualtitySample.dealSerial);
                            $('input[name="sampleSouce"]').val(qualtitySample.sampleSouce);
                            $('input[name="origin"]').val(qualtitySample.origin);
                            //$('input[name="storehouse"]').val(qualtitySample.storehouse);
                            $('select[name="storehouse"]').html("<option value=\""+qualtitySample.storehouse+"\" selected=\"selected\">" + qualtitySample.storehouse + "</option>");
                            $('input[name="quantity"]').val(qualtitySample.quantity);
                            $('input[name="variety"]').val(qualtitySample.variety);
                            $('input[name="inStoreYear"]').val(qualtitySample.inStoreYear);
                            var time_s =null;
                            if(qualtitySample.harvestYear!=null) {
                                time_s = qualtitySample.harvestYear.split('-');
                            }
                            $('input[name="harvestYear"]').val(time_s[0]);
                            $('input[name="varietyType"]').val(qualtitySample.varietyType);
                            $('select[name="storeNature"]').val(qualtitySample.storeNature);
                            $('select[name="storeType"]').val(qualtitySample.storeType);
                            $('#search3 input[name="storehouse"]').val("");
                            $('#search3 input[name="origin"]').val("");
                        }else{
                            //默认省级储备，默认根据成交明细信息回填
                            //alert("下")
                            warehouseId = vm.curDeal.receiveId;
                            $("input[tag='model']").attr("warehouseid",warehouseId).attr("warehouseType","id");	// 保存warehouseId 编号
                            $('input[name="warehouseId"]').val(warehouseId);
                            $('input#dealSerial').val(vm.curDeal.dealSerial);
                            $('input[name="sampleSouce"]').val(vm.curDeal.receivePlace);
                            warehouse = vm.curDeal.receivePlace;
                            $('input[name="origin"]').val(vm.curDeal.produceArea);
                            //$('input[name="storehouse"]').val(vm.curDeal.storehouse);
                            $('select[name="storehouse"]').html("<option value=\""+vm.curDeal.storehouse+"\" selected=\"selected\">" + vm.curDeal.storehouse + "</option>");
                            $('input[name="quantity"]').val(vm.curDeal.quantity);
                            $('input[name="variety"]').val(vm.curDeal.grainType);
                            $('input[name="inStoreYear"]').val(vm.curDeal.inStoreYear);
                            $('input[name="harvestYear"]').val(vm.curDeal.produceYear||vm.curDeal.warehoueYear);
                            if(vm.curDeal.grainType.indexOf('油')!=-1){
                                $('input[name="varietyType"]').val('油');
                            }else{
                                $('input[name="varietyType"]').val('粮');
                            }
                            //alert(1)
                            $('select[name="storeNature"]').val('省级储备');
                            $('select[name="storeType"]').val(vm.curDeal.storageType?vm.curDeal.storageType:'散装');
                        }

                        updateStroehouse(warehouseId,"");
                        layui.form.render('select','form');
                    }
                });




                /*$('input#dealSerial').val(this.curDeal.dealSerial);
                $('input[name="sampleSouce"]').val(this.curDeal.receivePlace);

                $('input[name="origin"]').val(this.curDeal.produceArea);
                $('input[name="storehouse"]').val(this.curDeal.storehouse);
                $('input[name="variety"]').val(this.curDeal.grainType);
                $('input[name="inStoreYear"]').val(this.curDeal.inStoreYear);
                $('input[name="harvestYear"]').val(this.curDeal.produceYear||this.curDeal.warehoueYear);
                if(this.curDeal.grainType.indexOf('油')!=-1){
                    $('input[name="varietyType"]').val('油');
                }else{
                    $('input[name="varietyType"]').val('粮');
                }*/


            }
            /* if(this.curNotice){
                $('input[name="noticeSerial"]').val(this.curNotice.noticeSerial);
            } */

        },

        showModal:function(data){
            $('#inModal').modal('show');
            this.renderTable4();
        },
        selectWarehouse:function(){
            var selectList = layui.table.checkStatus("myTable4").data;
            if(null==selectList||selectList.length==0){
                layer.msg("请选择库点",{icon:0});
                return;
            }else if(selectList.length>1){
                layer.msg("只能选择一个库点",{icon:0});
                return;
            }
            var warehouseCode = selectList[0].warehouseCode;
            var warehouse = selectList[0].warehouseShort;
            $("input[tag='model']").val(warehouse).attr("warehouseCode",warehouseCode).attr("warehouseType","code");
            // $("#storehouse").val("");//仓罐号置空
            $('input[name="warehouseId"]').val(selectList[0].id);
            updateStroehouse("",warehouseCode);


            this.hideModal('inModal','myTable4');
        },
        renderTable4:function(){
            layui.form.render("select","search4");
            layui.table.render({
                elem:"#myTable4",
                loading:true,
                url:'${ctx}/storageWarehouse/listValidWarehouse.shtml',
                method:"POST",
                width:770,
                cols:[[
                    {checkbox: true,fixed:true},
                    {field:'warehouseCode',title:'库点代码',width:200,align:'center'},
                    {field:'warehouseShort',title:'库点简称',width:200,align:'center'},
                    {field:'warehouseName',title:'库点名称',width:320,align:'center'},
                ]],
                request : {
                    pageName : 'pageIndex',
                    limitName : 'pageSize'
                },
                page:true,//开启分页
                limit:pagesize,
                id:"myTable4"
            });
        },
        reloadTable4:function(){
            layui.table.reload("myTable4",{
                method:"POST",
                where:{
                    warehouseCode:$('#search4 [name="warehouseCode"]').val(),
                    warehouseShort:$('#search4 [name="warehouseShort"]').val(),
                    warehouseName:$('#search4 [name="warehouseName"]').val(),
                }
            });
        },
        hideModal:function(modal,tableId){
            layui.table.reload(tableId);
            $('#'+modal).modal('hide');

        },
    };
    ko.applyBindings(vm,$('.container-box')[0]);
    $("#chooseBtn_1").click(function(){
        isfirst=true;
        $("#sc").click();
    });
</script>
</body>
</html>
