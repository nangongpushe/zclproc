<%@ page import="com.dhc.fastersoft.common.shrio.token.manager.TokenManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<style>
    #enterpriseTable + .layui-form .layui-table-body td[data-field="dealSerial"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="sampleNo"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="storehouse"]{
        text-align: right;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="variety"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="harvestYear"]{
        text-align: center;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="origin"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="validType"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="sampleSouce"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="samplingDate"]{
        text-align: center;
    }
</style>
<input type="hidden" name="id" value="${reportMain.id}">
<div class="content_right tab-content">
    <div class="text-left time" style="margin: 10px">
        <table width="100%">
            <tr>
                <td colspan="2">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">统计负责人：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input " autocomplete="off" id="manager" name="manager" style="width: 100px" value="${manager}">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">储备性质：</label>
                            <div class="layui-input-inline">
                                <select name="reserveProperty" class="form-control validate[required]" id="reserveProperty">
                                    <option <c:if test="${reserveProperty=='省级储备' }">selected</c:if> >省级储备</option>
                                    <option <c:if test="${reserveProperty=='中央储备' }">selected</c:if> >中央储备</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td width="33%" id="sumMonth">填报时间：<span id="nowMonth"><fmt:formatDate value="${ fillTime }"  pattern="yyyy年MM月dd日"/></span></td>
                <td width="33%"><span><font color="#6495ed  " id="status">【${status}】</font></i>粮油库存实物台账月报表</span></td>
                <td width="33%"><div class="text-right time" style="right: 30px;" id="name-unite">计量单位：<span id="unite">吨</span></div></td>
            </tr>
        </table>
    </div>
    <div class="con_box">
        <div class="table_box tab-pane slide_table" id="panel-06">
            <!-- 左上角头部固定-->
            <div class="public1" style="width: 200px;height: 28px;">
                <table class="table table-bordered nav_left" style="width: 200px;background-color: white;">
                    <tr>
                        <th class="td_first text-center" style="min-width: 147px;height: 56px !important;background-color: #e7f3f7;">操作</th>
                        <th class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;">储存库点名称</th>
                        <th class="td_first text-center" style="min-width: 147px;height: 56px !important;background-color: #e7f3f7;">仓号<br>(货位)</th>
                    </tr>
                </table>
            </div>
            <!-- 侧列固定-->
            <div class="public" style="width: 200px;height: 100%;padding-bottom: 17px">
                <table class="table table-bordered nav_left swtzTable" style="width: 200px;background-color: white;" id="leftTable">
                    <tr><th class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;"></th></tr>
                    <tr class="active"><td></td><td class="text-center thick">粮食合计</td><td class="text-center"><input name="storehouse" type="hidden"></td></tr>


                    <c:forEach items="${swtzList}" var="o" varStatus="i">
                        <tr class="text-center row${i.index}">
                            <td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow(${i.index})">删除</a></td>
                            <td >
                            	<select name="extendsWarehouseId">
                                    <c:if test="${flag=='1'}">
                                        <option>${o.extendsWarehouse}</option>

                                    </c:if>
                                    <c:if test="${flag!='1'}">
                                        <c:forEach items="${extendsWarehouse}" var="warehouse">
                                            <c:if test="${warehouse.warehouseShort != null}">
                                            <option <c:if test="${warehouse.id eq o.extendsWarehouseId }">selected</c:if> value="${warehouse.id}">${warehouse.warehouseShort}</option>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                           		</select>
                          	</td>
                            <td >
                                <%--<input name="storehouse" value="${o.storehouse}" class="validate[required]" maxlength="10">--%>

                                    <c:forEach items="${storeAndOrilMap}" var="item">
                                        <c:if test="${item.key == o.extendsWarehouseId}">

                                            <c:choose >
                                                <c:when test="${item.value['isInput']==0}">
                                                    <select name="storehouse" class="validate[required]" style="width: 90px">>
                                                    <c:forEach items="${item.value['encodeList']}" var="storeAndOil">
                                                        <option value="${storeAndOil}" <c:if test="${storeAndOil==o.storehouse}">selected</c:if>>${storeAndOil}</option>>
                                                    </c:forEach>
                                                    </select>
                                                </c:when>
                                                <c:when test="${item.value['isInput']==1}">
                                                    <input name="storehouse" value="${o.storehouse}" class="validate[required]" maxlength="10"/>
                                                </c:when>
                                            </c:choose>


                                        </c:if>
                                    </c:forEach>

                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
            <!-- 头部固定-->
            <div class="public2" style="height: 56px;border-left: 442px solid white;">
                <table class="table table-bordered header" style="border-bottom: 1px solid #7e9bb0">
                    <thead>
                    <tr>
                        <th rowspan="2" class="text-center">成交子明细号</th><th rowspan="2" class="text-center">品种</th><th rowspan="2" class="text-center">数量</th><th rowspan="2" class="text-center">产地</th><th rowspan="2" class="text-center">收获年份</th><th colspan="9" class="text-center">入库质量情况</th><th colspan="3" class="text-center">储存品质情况</th><th colspan="2" class="text-center">存储方式</th>
                    </tr>
                    <tr >
                        <th class="text-center">出糙(%)</th><th class="text-center">容重(g/l)</th><th class="text-center">杂质(%)</th><th class="text-center">水分(%)</th><th class="text-center">黄粒米(%)</th><th class="text-center">不完善粒(%)</th><th class="text-center">小麦湿面筋(%)</th><th class="text-center">酸价(KOH)(mg/g)</th><th class="text-center">过氧化值(mmol/kg)</th><th class="text-center">宜存数量</th><th class="text-center">轻度不宜存数量</th><th class="text-center">重度不宜存数量</th><th class="text-center">包装</th><th class="text-center">散装</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <!-- 表格-->
            <div class="table_tab" style="border-left: 442px solid white;">
                <table class="table table-bordered slide_table" style="..">
                    <!-- 表格内容 start -->
                    <tbody id="sumTbody">
                    <tr class="active" name="粮食合计">
                        <td></td><td></td><td><input sumRow="quantity" readonly/></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><input sumRow="advisedDeposit" name="advisedDeposit" readonly /></td><td><input sumRow="slightlyUnsuitable" name="slightlyUnsuitable" readonly /></td></td><td><input sumRow="severeUnsuitable" name="severeUnsuitable" readonly /></td><td><input sumRow="packing" name="packing" readonly /></td><td><input sumRow="bulk" name="bulk" readonly /></td>
                    </tr>
                    <c:forEach items="${swtzList}" var="o" varStatus="i">
                        <tr class="text-center row${i.index}" name="${o}">
                            <td><input name="dealSerial"  id="dealSerial${i.index}" onclick="selectSerial(${i.index})" value="${o.dealSerial}"/></td>
                            <td><select class="validate[required]" name="variety">
                                <option value="">--请选择--</option>
                                <c:forEach items="${grainTypes}" var="grain">
                                    <option value="${grain.value}" <c:if test="${grain.value eq o.variety }">selected="selected"</c:if> >${grain.value}</option>
                                </c:forEach>
                            </select></td>

                            <td>
                            	<input name="quantity" value="${o.quantity}" class="number validate[required]" maxlength="10"/>
                           	</td>
                           	<td>
                           		<input name="origin" value="${o.origin}" maxlength="45"/>
                           	</td>
                           	<td>
                           		<input name="harvestYear" value="${o.harvestYear}" class="date-year validate[required]" />
                           	</td>
                           	<td>
                           		<input name="brown" value="${o.brown}"/>
                           	</td>
                           	<td>
                           		<input name="unitWeight" value="${o.unitWeight}"/>
                          	</td>
                          	<td>
                          		<input name="impurity"  value="${o.impurity}"/>
                          	</td><td><input name="dew"  value="${o.dew}"/></td><td><input name="yellowRice"  value="${o.yellowRice}"/></td><td><input name="unsoundGrain"  value="${o.unsoundGrain}"/></td><td><input name="wetGluten"  value="${o.wetGluten}"/></td><td><input name="koh"  value="${o.koh}"/></td><td><input name="mmol"  value="${o.mmol}"/></td><td><input name="advisedDeposit" class="number" value="${o.advisedDeposit}"/></td><td><input name="slightlyUnsuitable" class="number" value="${o.slightlyUnsuitable}"/></td></td><td><input name="severeUnsuitable" class="number" value="${o.severeUnsuitable}"/></td>
                            <td><input name="packing" class="number" value="${o.packing}"/></td><td><input name="bulk" class="number" value="${o.bulk}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <!-- 表格内容 end -->
                </table>
            </div>
        </div>
        <button type="button" class="layui-btn layui-btn-small addRow" style="display: none" onclick="addRow()">增加一行</button>
        <button type="button" class="layui-btn layui-btn-small addRow" style="display: none" onclick="parseAllData()">导入上月数据</button>
        <button type="button" class="layui-btn layui-btn-small importRow" style="display: none" id="file">导入Excel</button>
        <a href="#" class="layui-btn layui-btn-small importRow" style="display: none" onclick="downloadResultTemplate()">导入模板下载</a>
    </div>


</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog"  style="width:800px;">
        <div class="modal-content">
            <div class="modal-header"><!-- data-dismiss="modal"  -->
                <button type="button" class="close" aria-hidden="true" onclick="removeActiveClass()">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    选择成交子明细
                </h4>
            </div>
            <div class="modal-body">
                <div class="layui-form" id="search">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">成交子明细号：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="dealSerial">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">样品编号：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="sampleNo">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">仓/罐号：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="storehouse">
                                <%--<select class="layui-select" id="storehouse">--%>
                                <%--</select>--%>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">粮食品种：</label>
                            <div class="layui-input-inline">
                                <select lay-verify="required" class="form-control"  name="variety" id="variety">
                                    <option value="">--请选择--</option>
                                    <c:forEach items="${grainTypes}" var="variety">
                                        <option value="${variety.value}">${variety.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">年份：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="harvestYear">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">产地：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="origin">
                            </div>
                        </div>
                         <div class="layui-inline">
                            <label class="layui-form-label">检验类型：</label>
                            <div class="layui-input-inline">
                                <select id="validType" disabled>
                               	<c:forEach items="${validTypes}" var="item">  
		        					<option value="${item.value}" <c:if test="${item.value eq '入库质检' }">selected</c:if>>${item.value}</option>
		   				 		</c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">样品来源：</label>
                            <div class="layui-input-inline">
                                <select id="sampleSouce">
                               	<c:forEach items="${basepoint }" var="point">
									<option <c:if test="${point eq currentPoint }">selected</c:if>>${point }</option>
								</c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="layui-inline">
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="enterpriseSearch">查询</button>
                        </div>
                    </div>
                </div>
                <table lay-filter="operation" id="enterpriseTable"></table>
                <script type="text/html" id="bar">
                    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="choose">选择</a>
                    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="cancleChoose">清空明细号</a>
                </script>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="removeActiveClass()">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->

</div>

<script language="javascript" type="text/javascript">
    var selectRow; //选择成交明细号的行号；
    var form = layui.form;
    form.render();
    var status = '${status}'; //报表状态
    var monthStatus = '${reportMain.reportStatus}'; //月报状态
    var storeAndOilMap = ${cf:toJSON(storeAndOrilMap)}; // 仓罐列表
    $("#reportId").val('${reportId}');
    var saveUrl = "${ctx}/reportSwtz/saveSwtz.shtml";
    var exportUrl='${ctx}/reportSwtz/exportSwtz.shtml';
    var dataList = "${swtzList}";
    var i = '${fn:length(swtzList)}';
    var laydate = layui.laydate;
    $("#sumTbody .date-year").each(function(){
        laydate.render({
            elem:$(this)[0],
            type:"year",
            format:"yyyy"
        });
    });
    laydate.render({
        elem:'#harvestYear',
        type:"year",
        format:"yyyy"
    });

    function sumToFirst() {
        $('#sumTbody input[sumRow]').each(function () {
            var sumRow = $(this).attr('sumRow');
            //console.log(sumRow);
            var sumTotal = 0;
            $('#sumTbody input[name='+sumRow+']').not($(this)).each(function () {
                sumTotal = accAdd(sumTotal,$(this).val())
            });
            $(this).val(sumTotal);
        });
    }

    $(function () {
        /* $(".number").keyup(function(){
            onlyNumber(this);
            sum(this);
        }).blur(function(){
            onlyNumber(this);
            sum(this);
        }); */
        if(dataList)
            sumToFirst()
    });

    /**Construction
     * 含sumRow属性的自动合计所有name为该属性值的input
     * @param obj
     */
    function sum(obj){
        //处理行合计
        var name = $(obj).attr('name');
        $('#sumTbody input[sumRow='+name+']').each(function () {
            var sumTotal = 0;
            $('#sumTbody input[name='+name+']').not($(this)).each(function () {
                sumTotal = accAdd(sumTotal,$(this).val())
            });
            $(this).val(sumTotal);
        });
    }
    // <input name="storehouse" class="validate[required]">
    function addRow() {
        var leftTable = $("#leftTable");
        leftTable.append('<tr class="text-center row'+i+'"><td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow('+i+')">删除</a></td><td><select name="extendsWarehouseId"><c:forEach items="${extendsWarehouse}" var="warehouse"><c:if test="${warehouse.warehouseShort != null}"><option value="${warehouse.id}">${warehouse.warehouseShort}</option></c:if></c:forEach></select></td><td>'
            +'<select name="storehouse" class="validate[required]" style="width: 90px"></select></td></tr>');
        var warehouseId = leftTable.find(".row"+i+" select[name='extendsWarehouseId']").val();  //  获取库点ID
        updateStroehouse(warehouseId,i);

        var html = '<tr class="text-center row'+i+'">' +
                        '<td>' +
            '<input name="dealSerial"  id="dealSerial'+i+'" onclick="selectSerial('+i+')"/></td>' +
                        '<td><select class="validate[required]" name="variety"><option value="">--请选择--</option>';
                        $.each( eval("("+'${grainTypes}'+")"), function(index,grain){
                            html += '<option value="'+grain.value+'">'+grain.value+'</option>';
                        });
                html += '</select></td>' +
                        '<td><input name="quantity" class="number validate[required]" maxlength="10"/></td>' +
                        '<td><input name="origin" /></td>' +
                        '<td><input name="harvestYear" class="date-year validate[required]"/></td>' +
                        '<td><input name="brown"/></td>' +
                        '<td><input name="unitWeight"/></td>' +
                        '<td><input name="impurity" /></td>' +
                        '<td><input name="dew" /></td>' +
                        '<td><input name="yellowRice" />' +
                        '</td><td><input name="unsoundGrain" /></td>' +
                        '<td><input name="wetGluten" /></td>' +
                        '<td><input name="koh" /></td>' +
                        '<td><input name="mmol" /></td>' +
                        '<td><input name="advisedDeposit" class="number"/></td>' +
                        '<td><input name="slightlyUnsuitable" class="number"/></td>' +
                        '<td><input name="severeUnsuitable" class="number"/></td>' +
                        '<td><input name="packing" class="number"/></td>' +
                        '<td><input name="bulk" class="number"/></td>' +
                    '</tr>'
        $('#sumTbody').append(html);
        i++;
        $(".number").keyup(function(){
            onlyNumber(this);
            sum(this);
        }).blur(function(){
            onlyNumber(this);
            sum(this);
        });
        var laydate = layui.laydate;
        $("#sumTbody .date-year").each(function(){
            laydate.render({
                elem:$(this)[0],
                type:"year",
                format:"yyyy"
            });
        });
    }
    
    function copyAllRow(){
    	var jsonlist = new Array();
        var i = 1;
        $("#sumTbody tr").each(function() {
            if(i>1){
                var obj = $(this).find('input,select').serializeObject();
                obj.variety = $(this).find("select[name='variety']").val();
                obj.storehouse = $('#leftTable tr:eq('+i+') select[name="storehouse"]').val();
                obj.extendsWarehouseId = $('#leftTable tr:eq('+i+') select[name="extendsWarehouseId"]').val()
                jsonlist.push(obj);
            }
            i++;
        });
        
        sessionStorage.setItem('swtzCopyData',JSON.stringify(jsonlist));
        layer.msg('已将数据复制到剪切板');
	}
    
    function parseAllData(){
    	var reportMonth = $("#month").val().split('-');
        reportMonth[0] = Number(reportMonth[1]) - 1 == 0 ? Number(reportMonth[0]) - 1 : reportMonth[0];
        reportMonth[1] = Number(reportMonth[1]) - 1 == 0 ? 12 : Number(reportMonth[1]) - 1;
    	$.ajax({
    		url:"${pageContext.request.contextPath}/reportSwtz/GetLastMonthData.shtml",
    		type:"post",
    		data:{
    		    "reportWarehouseId":"${reportWarehouseId}",
    			"reportWarehouse":"${reportWarehouse}",
    			"reportMonth": reportMonth[0].toString() + '-' + (reportMonth[1] < 10 ? '0'+reportMonth[1]:reportMonth[1])
    		},
    		success:function(data){
    			exportLastMonthData(data);
    		}
    	});
   	}

   	//缓存库点公司对应的库点信息
    var warehouseList = {};
    if('${extendsWarehouseJson}'){
        warehouseList = JSON.parse('${extendsWarehouseJson}');
    }
    function exportLastMonthData(data){
    	if(data.success){
    	    $("#manager").val(data.manager);
    	    $("#reserveProperty").val(data.reserveProperty);
    		var copyData = data.data;
    		for(var j = 0;j<copyData.length;j++){
    			for(var item in copyData[j])
    				copyData[j][item] = copyData[j][item] == null ? '': copyData[j][item];

    			var leftTableInfo = '<tr class="text-center row'+i+'">' +
                                        '<td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow('+i+')">删除</a></td>' +
                                        '<td>' +
                                            '<select name="extendsWarehouseId">';
    			for(var n in warehouseList){
    			    var warehouse = warehouseList[n];
    			    if(warehouse.warehouseShort != null && warehouse.warehouseShort != ''){
    			        leftTableInfo += '<option value="' + warehouse.id + '" ';
                        if(warehouse.id == copyData[j].extendsWarehouseId){
                            leftTableInfo += 'selected'
                        }
                        leftTableInfo += '>' + warehouse.warehouseShort + '</option>'
                    }
                }
                leftTableInfo += '</select>' +
                                 '</td>' +
                                 '<td>' +
                    // '<input name="storehouse" value="'+copyData[j].storehouse+'" class="validate[required]">' +
                    '<select name="storehouse" class="validate[required]" style="width: 90px"></select>'+
                    '</td>' +
                                 '</tr>'
                $("#leftTable").append(leftTableInfo);
                // 更新仓房列表
    			updateStroehouse(copyData[j].extendsWarehouseId,i);
                $("#leftTable .row"+i+" [name='storehouse']").val(copyData[j].storehouse);
	    		//$('#leftTable').append(
                //    '<tr class="text-center row'+i+'">' +
                //        '<td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow('+i+')">删除</a></td>' +
                //        '<td>' +
                //            '<select name="extendsWarehouseId">' +
                //            '<c:forEach items="${extendsWarehouse}" var="warehouse">' +
                //            '<c:if test="${warehouse.warehouseShort != null}">' +
                //                '<option <c:if test="warehouse.id eq 'copyData[j].extendsWarehouseId'">selected</c:if> value="${warehouse.id}">${warehouse.warehouseShort}</option>' +
                //            '</c:if>' +
                //            '</c:forEach>' +
                //            '</select>' +
                //        '</td>' +
                //        '<td><input name="storehouse" value="'+copyData[j].storehouse+'" class="validate[required]"></td>' +
                //   '</tr>');


	    		var html = '<tr class="text-center row'+i+'">' +
	                            '<td><input name="dealSerial"  readonly id="dealSerial'+i+'" onclick="selectSerial('+i+')" value="'+copyData[j].dealSerial+'"/></td>' +
	                            '<td><select class="validate[required]" name="variety"><option value="">--请选择--</option>';
	                            $.each( eval("("+'${grainTypes}'+")"), function(index,grain){
	                            	if(grain.value != copyData[j].variety)
	                                	html += '<option value="'+grain.value+'" >'+grain.value+'</option>';
                                	else
	                                	html += '<option value="'+grain.value+'" selected>'+grain.value+'</option>';
	                            });
	                    html += '</select></td>' +
	                            '<td><input name="quantity" class="number validate[required]" value="'+copyData[j].quantity+'" maxlength="10"/></td>' +
	                            '<td><input name="origin" value="'+copyData[j].origin+'"/></td>' +
	                            '<td><input name="harvestYear" class="date-year validate[required]" value="'+copyData[j].harvestYear+'"/></td>' +
	                            '<td><input name="brown"  value="'+copyData[j].brown+'"/></td>' +
	                            '<td><input name="unitWeight" value="'+copyData[j].unitWeight+'"/></td>' +
	                            '<td><input name="impurity" value="'+copyData[j].impurity+'"/></td>' +
	                            '<td><input name="dew" value="'+copyData[j].dew+'"/></td>' +
	                            '<td><input name="yellowRice" value="'+copyData[j].yellowRice+'"/>' +
	                            '</td><td><input name="unsoundGrain" value="'+copyData[j].unsoundGrain+'"/></td>' +
	                            '<td><input name="wetGluten" value="'+copyData[j].wetGluten+'"/></td>' +
	                            '<td><input name="koh" value="'+copyData[j].koh+'"/></td>' +
	                            '<td><input name="mmol" value="'+copyData[j].mmol+'"/></td>' +
	                            '<td><input name="advisedDeposit" class="number" value="'+copyData[j].advisedDeposit+'"/></td>' +
	                            '<td><input name="slightlyUnsuitable" class="number" value="'+copyData[j].slightlyUnsuitable+'"/></td>' +
	                            '<td><input name="severeUnsuitable" class="number" value="'+copyData[j].severeUnsuitable+'"/></td>' +
	                            '<td><input name="packing" class="number" value="'+copyData[j].packing+'"/></td>' +
	                            '<td><input name="bulk" class="number" value="'+copyData[j].bulk+'"/></td>' +
	                        '</tr>'
	            $('#sumTbody').append(html);
	            i++;
    		}
    		$(".number").keyup(function(){
                onlyNumber(this);
                sum(this);
            }).blur(function(){
                onlyNumber(this);
                sum(this);
            });
            var laydate = layui.laydate;
            $("#sumTbody .date-year").each(function(){
                laydate.render({
                    elem:$(this)[0],
                    type:"year",
                    format:"yyyy"
                });
            });
            sumToFirst();
    	}else
            layer.msg('上月内无数据');
    }

    /*function delRow(row) {
        $('.row'+row).remove();
        $('#sumTbody input[sumRow=quantity]').each(function () {
            var sumTotal = 0;
            $('#sumTbody input[name=quantity]').not($(this)).each(function () {
                sumTotal = accAdd(sumTotal,$(this).val())
            });
            $(this).val(sumTotal);
        });
    }*/
    function delRow(row) {
        $('.row'+row).remove();
        $('#sumTbody input[sumRow]').each(function () {
            var sumRow = $(this).attr('sumRow');
            //console.log(sumRow);
            var sumTotal = 0;
            $('#sumTbody input[name='+sumRow+']').not($(this)).each(function () {
                sumTotal = accAdd(sumTotal,$(this).val())
            });
            $(this).val(sumTotal);
        });
    }

    function selectSerial(row) {
        if('未保存' == '${status}'||'草稿' == '${status}' || '审核驳回' == '${status}' || '上报驳回' == '${status}'){
            selectRow = row;
            $('#myModal').modal({backdrop: 'static'}).modal('show');
        }
    }

    function removeActiveClass(obj) {
        $('#myModal').modal('hide');
    }
    
    var isInit = true;

    layui.use(['table'], function() {
        var table = layui.table;
        table.render({
            elem : '#enterpriseTable',
            url : '${pageContext.request.contextPath}/QualitySample/pageQuery.shtml?fillReport=true&nResult=true&isHasImportation=true',
            method : "POST",
            cols : [[
                {fixed : 'left', title : '操作', width : 182, align : 'center', toolbar : '#bar'},
                {field : 'dealSerial',title : '成交子明细号',width:200,align:'center'},
                {field : 'sampleNo',title : '样品编号',width:150,align:'center'},
                {field : 'storehouse',title : '仓/罐号',width:150,align:'center'},
                {field : 'variety',title : '粮食品种',width:150,align:'center'},
                {field : 'harvestYear',title : '收获年份',width:100,align:'center'},
                {field : 'origin',title : '产地',width:150,align:'center'},
				{field:  'validType',title:'检验类型',width:150,align:'center'},
				{field:  'sampleSouce',title:'样品来源',width:150,align:'center'},
                {field:  'samplingDate',title: '扦样日期',width:150,align:'center'}
            ]],//设置表头
            request : {
                pageName : 'page',
                limitName : 'pageSize'
            },
            page:true,//开启分页
            limit:10,
            id:'enterpriseTableId',
            done:function(res,curr,count){
            	if(isInit){
            		isInit = false;
            		$('#enterpriseSearch').click();
            	}
            },
        });

        //搜索
        $('#enterpriseSearch').click(function() {
            table.reload("enterpriseTableId", {
                method: 'post', //如果无需自定义HTTP类型，可不加该参数
                where : {
                    sampleNo : $('#search #sampleNo').val(),
                    dealSerial : $('#search #dealSerial').val(),
                    storehouse : $('#search #storehouse').val(),
                    variety : $('#search #variety').val(),
                    harvestYear : $('#search #harvestYear').val(),
                    origin : $('#search #origin').val(),
                    validType:$('#search #validType').val(),
                    sampleSouce:$('#search #sampleSouce').val()
                }
            });
        });

        table.on('tool(operation)', function(obj) {
            var data = obj.data;
            if (obj.event === 'choose') {
               	var tr = $('#dealSerial'+selectRow).parent().parent();
                $('#dealSerial'+selectRow).val(data.dealSerial);
                $(tr).find("input[name='origin']").val(data.origin);
                $(tr).find("input[name='origin']").attr('readonly',true);
                $(tr).find("select[name='variety']").val(data.variety);
                $(tr).find("select[name='variety']").attr('disabled',true);
                 // $(tr).find("select[name='storehouse']").attr("haha","haha").val(data.storehouse);
                // $(tr).find("input[name='storehouse']").attr('disabled',true);
                $(tr).find("input[name='quantity']").val(data.quantity);
                $(tr).find("input[name='harvestYear']").val(data.harvestYear);
                $(tr).find("input[name='harvestYear']").attr('readonly',true);

                $(tr).find("input[name='advisedDeposit']").val(data.quantity);
                $(tr).find("input[name='bulk']").val(data.quantity);

                sumToFirst();

                <%--if($('#search #sampleSouce').val() == '${currentPoint}'){--%>
                if( $('#leftTable').find('.row' + selectRow).find("select[name='extendsWarehouseId']").val()==data.warehouseId) {
                    $('#leftTable').find('.row' + selectRow).find("[name='storehouse']").val(data.storehouse);
                }
                // }
                if(data.qualityThird != null){
                	var detail = data.qualityThird.qualityResultItems;
                	if(detail!=null) {
                        $.each(detail, function (index, ele) {
                            if (ele.itemName == '出糙率(%)') {
                                $(tr).find("input[name='brown']").val(ele.result);
                            } else if (ele.itemName == '容重(g/l)') {
                                $(tr).find("input[name='unitWeight']").val(ele.result);
                            } else if (ele.itemName == '杂质(%)') {
                                $(tr).find("input[name='impurity']").val(ele.result);
                            } else if (ele.itemName == '水分(%)') {
                                $(tr).find("input[name='dew']").val(ele.result);
                            } else if (ele.itemName == '黄粒米(%)') {
                                $(tr).find("input[name='yellowRice']").val(ele.result);
                            } else if (ele.itemName == '不完善粒(%)') {
                                $(tr).find("input[name='unsoundGrain']").val(ele.result);
                            } else if (ele.itemName == '小麦湿面筋(%)') {
                                $(tr).find("input[name='wetGluten']").val(ele.result);
                            } else if (ele.itemName == '酸价(KOH)(mg/g)') {
                                $(tr).find("input[name='koh']").val(ele.result);
                            } else if (ele.itemName == '过氧化值(mmol/kg)') {
                                $(tr).find("input[name='mmol']").val(ele.result);
                            }
                        });
                    }
                }
            }
            if (obj.event === 'cancleChoose') {
                var tr = $('#dealSerial'+selectRow).parent().parent();
                $('#dealSerial'+selectRow).val("");
            }
            $('#myModal').modal('hide');
        });
        //监听FORM结束

    });


    // 库点事件绑定
    $(document).on("change","#leftTable select[name='extendsWarehouseId']",function () {
        var warehouseId = $(this).val();
        var i = $(this).parent().parent().attr("class").replace(/[^0-9]/ig, "");
        updateStroehouse(warehouseId,i);
    });



    // 刷新仓号列表
    function updateStroehouse(warehouseId,i){
        var leftTable = $("#leftTable");
        var warehouseMap = storeAndOilMap[warehouseId];
        var isInput = Number(warehouseMap['isInput']);
        if(isInput==0){
            leftTable.find(".row"+i+" [name='storehouse']").parent().html("<select name=\"storehouse\" class=\"validate[required]\" style=\"width: 90px\"></select>")
            // 下拉框
            var storehouseList = warehouseMap['encodeList'];
            leftTable.find(".row"+i+" select[name='storehouse']").html("");
            // 更新仓号列表
            if(storehouseList!=null){
                for(var j = 0;j < storehouseList.length;j++){
                    leftTable.find(".row"+i+" select[name='storehouse']").append("<option value=\""+storehouseList[j]+"\">"+storehouseList[j]+"</opiton>");
                }
            }
        }else{
            // 输入框
            leftTable.find(".row"+i+" [name='storehouse']").parent().html("<input name='storehouse' class=\"validate[required]\"/>");
        }
    }
    Excel_Import({
        elem:"#file",
        url:"../reportSwtz/importExcel.shtml",
        data:{reportWarehouseId:"${reportWarehouseId}"},
        success:function (copyData) {
            debugger
                for(let j = 0;j<copyData.length;j++){
                    for(var item in copyData[j])
                        copyData[j][item] = copyData[j][item] == null ? '': copyData[j][item];

                    var leftTableInfo = '<tr class="text-center row'+i+'">' +
                        '<td><a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" onclick="delRow('+i+')">删除</a></td>' +
                        '<td>' +
                        '<select name="extendsWarehouseId">';
                    for(var n in warehouseList){
                        var warehouse = warehouseList[n];
                        if(warehouse.warehouseShort != null && warehouse.warehouseShort != ''){
                            leftTableInfo += '<option value="' + warehouse.id + '" ';
                            if(warehouse.id == copyData[j].extendsWarehouseId){
                                leftTableInfo += 'selected'
                            }
                            leftTableInfo += '>' + warehouse.warehouseShort + '</option>'
                        }
                    }
                    leftTableInfo += '</select>' +
                        '</td>' +
                        '<td>' +
                        '<select name="storehouse" class="validate[required]" style="width: 90px"></select>'+
                        '</td>' +
                        '</tr>'
                    $("#leftTable").append(leftTableInfo);
                    // 更新仓房列表
                    updateStroehouse(copyData[j].extendsWarehouseId,i);
                    $("#leftTable .row"+i+" [name='storehouse']").val(copyData[j].storehouse);

                    var html = '<tr class="text-center row'+i+'">' +
                        '<td><input name="dealSerial"  readonly id="dealSerial'+i+'" onclick="selectSerial('+i+')" value="'+copyData[j].dealSerial+'"/></td>' +
                        '<td><select class="validate[required]" name="variety"><option value="">--请选择--</option>';
                    $.each( eval("("+'${grainTypes}'+")"), function(index,grain){
                        if(grain.value != copyData[j].variety)
                            html += '<option value="'+grain.value+'" >'+grain.value+'</option>';
                        else
                            html += '<option value="'+grain.value+'" selected>'+grain.value+'</option>';
                    });
                    let obj1 =copyData[j].storeInfoList;
                    let obj2 = copyData[j]['storeInfoList'];

                    html += '</select></td>' +
                        '<td><input name="quantity" class="number validate[required]" value="'+copyData[j].quantity+'" maxlength="10"/></td>' +
                        '<td><input name="origin" value="'+copyData[j].origin+'"/></td>' +
                        '<td><input name="harvestYear" class="date-year validate[required]" value="'+copyData[j].harvestYear+'"/></td>' +
                        '<td><input name="brown"  value="'+(copyData[j].storeInfoList[0].brown==null?'':copyData[j].storeInfoList[0].brown)+'"/></td>' +
                        '<td><input name="unitWeight" value="'+(copyData[j].storeInfoList[0].unitWeight==null?'':copyData[j].storeInfoList[0].unitWeight)+'"/></td>' +
                        '<td><input name="impurity" value="'+(copyData[j].storeInfoList[0].impurity==null?'':copyData[j].storeInfoList[0].impurity)+'"/></td>' +
                        '<td><input name="dew" value="'+(copyData[j].storeInfoList[0].dew==null?'':copyData[j].storeInfoList[0].dew)+'"/></td>' +
                        '<td><input name="yellowRice" value="'+(copyData[j].storeInfoList[0].yellowRice==null?'':copyData[j].storeInfoList[0].yellowRice)+'"/>' +
                        '</td><td><input name="unsoundGrain" value="'+(copyData[j].storeInfoList[0].unsoundGrain==null?'':copyData[j].storeInfoList[0].unsoundGrain)+'"/></td>' +
                        '<td><input name="wetGluten" value="'+(copyData[j].storeInfoList[0].wetGluten==null?'':copyData[j].storeInfoList[0].wetGluten)+'"/></td>' +
                        '<td><input name="koh" value="'+(copyData[j].storeInfoList[0].koh==null?'':copyData[j].storeInfoList[0].koh)+'"/></td>' +
                        '<td><input name="mmol" value="'+(copyData[j].storeInfoList[0].mmol==null?'':copyData[j].storeInfoList[0].mmol)+'"/></td>' +
                        '<td><input name="advisedDeposit" class="number" value="'+((copyData[j].stroageInfoList[0].advisedDeposit==null && copyData[j].stroageInfoList[0].slightlyUnsuitable==null
                            && copyData[j].stroageInfoList[0].severeUnsuitable==null)?
                            copyData[j].quantity:(copyData[j].stroageInfoList[0].advisedDeposit==null?'':copyData[j].stroageInfoList[0].advisedDeposit))+'"/></td>' +
                        '<td><input name="slightlyUnsuitable" class="number" value="'+(copyData[j].stroageInfoList[0].slightlyUnsuitable==null?'':copyData[j].stroageInfoList[0].slightlyUnsuitable)+'"/></td>' +
                        '<td><input name="severeUnsuitable" class="number" value="'+(copyData[j].stroageInfoList[0].severeUnsuitable==null?'':copyData[j].stroageInfoList[0].severeUnsuitable)+'"/></td>' +
                        '<td><input name="packing" class="number" value="'+(copyData[j].stroageModeList[0].packing==null&& copyData[j].stroageModeList[0].bulk==null?copyData[j].quantity:
                            (copyData[j].stroageModeList[0].packing==null?'':copyData[j].stroageModeList[0].packing))+'"/></td>' +
                        '<td><input name="bulk" class="number" value="'+(copyData[j].stroageModeList[0].bulk==null?'':copyData[j].stroageModeList[0].bulk)+'"/></td>' +
                        '</tr>'
                    $('#sumTbody').append(html);
                    i++;
                }
                $(".number").keyup(function(){
                    onlyNumber(this);
                    sum(this);
                }).blur(function(){
                    onlyNumber(this);
                    sum(this);
                });
                var laydate = layui.laydate;
                $("#sumTbody .date-year").each(function(){
                    laydate.render({
                        elem:$(this)[0],
                        type:"year",
                        format:"yyyy"
                    });
                });
                sumToFirst();
        },
        error: function () {
            layer.msg('导入失败，请检查数据后重试');
        }
    });

    function downloadResultTemplate() {
        window.location.href = '../sysFile/downloadTemplate.shtml?filename=实物台账导入模板';
    }

    $(document).on("input", ".number", function () {
        onlyNumber(this);
        sum(this);
    })

    // 修改数量
    $(document).on("input","input[name='quantity']",function () {
        let tr = $(this).parents("tr");
        let num1 = Number($(this).val());
        let num2 = Number($(tr).find("[name='slightlyUnsuitable']").val());   // 轻度不宜存数量
        let num3 = Number($(tr).find("[name='severeUnsuitable']").val());     // 重度不宜存数量

        let advisedDeposit = num1-num2-num3 < 0 ? tr.find("[name='advisedDeposit']").val() : NP.minus(NP.minus(num1,num2),num3);
        tr.find("[name='advisedDeposit']").val(advisedDeposit);  // 宜存数量

        let num4 = Number($(tr).find("[name='packing']").val());   // 包装

        let bulk = num1 - num4 < 0 ? tr.find("[name='bulk']").val() : NP.minus(num1,num4);;
        tr.find("[name='bulk']").val(bulk);  // 散装
        sumToFirst();
    });

    $(document).on("input", "input[name='slightlyUnsuitable'],input[name='severeUnsuitable']", function () {
        let tr = $(this).parents("tr");

        let num1 = Number($(tr).find("[name='quantity']").val());
        let num2 = Number($(tr).find("[name='slightlyUnsuitable']").val());
        let num3 = Number($(tr).find("[name='severeUnsuitable']").val());

        let advisedDeposit = NP.minus(NP.minus(num1,num2),num3);
        if(advisedDeposit >= 0)
            $(tr).find("[name='advisedDeposit']").val(advisedDeposit);
        else {
            $(this).val("");
            advisedDeposit = NP.minus(NP.minus(Number($(tr).find("[name='quantity']").val()), Number($(tr).find("[name='slightlyUnsuitable']").val())), Number($(tr).find("[name='severeUnsuitable']").val()));
            $(tr).find("[name='advisedDeposit']").val(advisedDeposit);
        }
    });


    $(document).on("input", "input[name='advisedDeposit']", function () {
        let tr = $(this).parents("tr");

        let num1 = Number($(tr).find("[name='quantity']").val());
        let num2 = Number($(tr).find("[name='advisedDeposit']").val());
        let num3 = Number($(tr).find("[name='slightlyUnsuitable']").val());
        let num4 = Number($(tr).find("[name='severeUnsuitable']").val());

        let advisedDeposit = NP.minus(NP.minus(NP.minus(num1,num2),num3),num4);
        if(advisedDeposit < 0)
            $(tr).find("[name='advisedDeposit']").val(NP.minus(NP.minus(num1,num3),num4));
    })


    $(document).on("input", "input[name='packing']", function () {
        let tr = $(this).parents("tr");

        let num1 = Number($(tr).find("[name='quantity']").val());
        let num2 = Number($(tr).find("[name='packing']").val());

        if(NP.minus(num1,num2) >= 0){
            $(tr).find("[name='bulk']").val(NP.minus(num1,num2));
        } else {
            $(this).val("");
            $(tr).find("[name='bulk']").val(num1);
        }

    })

    $(document).on("input", "input[name='bulk']", function () {
        let tr = $(this).parents("tr");

        let num1 = Number($(tr).find("[name='quantity']").val());
        let num2 = Number($(tr).find("[name='packing']").val());
        let num3 = Number($(this).val());

        if(NP.minus(NP.minus(num1,num2),num3) < 0){
            $(tr).find("[name='bulk']").val(NP.minus(num1,num2));
        }

    })


    ~(function(root, factory) {
        if (typeof define === "function" && define.amd) {
            define([], factory);
        } else if (typeof module === "object" && module.exports) {
            module.exports = factory();
        } else {
            root.NP = factory();
        }
    }(this, function() {
        'use strict';
        /**
         * @ file 解决浮动运算问题，避免小数点后产生多位数和计算精度损失。
         * 问题示例：2.3 + 2.4 = 4.699999999999999，1.0 - 0.9 = 0.09999999999999998
         */
        return {
            /**
             * 把错误的数据转正
             * strip(0.09999999999999998)=0.1
             */
            strip: function (num, precision = 12) {
                return +parseFloat(num.toPrecision(precision));
            },
            /**
             * Return digits length of a number
             * @ param {*number} num Input number
             */
            digitLength: function (num) {
                // Get digit length of e
                const eSplit = num.toString().split(/[eE]/);
                const len = (eSplit[0].split('.')[1] || '').length - (+(eSplit[1] || 0));
                return len > 0 ? len : 0;
            },
            /**
             * 精确加法
             */
            plus: function (num1, num2) {
                const baseNum = Math.pow(10, Math.max(this.digitLength(num1), this.digitLength(num2)));
                return (num1 * baseNum + num2 * baseNum) / baseNum;
            },
            /**
             * 精确减法
             */
            minus: function (num1, num2) {
                const baseNum = Math.pow(10, Math.max(this.digitLength(num1), this.digitLength(num2)));
                return (num1 * baseNum - num2 * baseNum) / baseNum;
            },
            /**
             * 精确乘法
             */
            times: function (num1, num2) {
                const num1Changed = Number(num1.toString().replace('.', ''));
                const num2Changed = Number(num2.toString().replace('.', ''));
                const baseNum = this.digitLength(num1) + this.digitLength(num2);
                return num1Changed * num2Changed / Math.pow(10, baseNum);
            },
            /**
             * 精确除法
             */
            divide: function (num1, num2) {
                const num1Changed = Number(num1.toString().replace('.', ''));
                const num2Changed = Number(num2.toString().replace('.', ''));
                return this.times((num1Changed / num2Changed), Math.pow(10, this.digitLength(num2) - this.digitLength(num1)));
            },
            /**
             * 四舍五入
             */
            round: function (num, ratio) {
                const base = Math.pow(10, ratio);
                return this.divide(Math.round(this.times(num, base)), base);
            }
        };
    }));


</script>