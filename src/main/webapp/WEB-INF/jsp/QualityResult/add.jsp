<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<%@include file="../common/AdminHeader.jsp"%>
<link rel="stylesheet" href="${ctx}/css/combo.select.css">

<style>
	#myTable4 + .layui-form .layui-table-body td[data-field="warehouseCode"]{
		text-align: right;
	}
	#myTable4 + .layui-form .layui-table-body td[data-field="warehouseShort"]{
		text-align: left;
	}
	#myTable4 + .layui-form .layui-table-body td[data-field="warehouseName"]{
		text-align: left;
	}
</style>
<style>
<!--

-->
.buttonArea{
		padding:5px 15px;
		background:RGB(25,174,136);
		border:none;
		border-radius:5px;
		color:#fff;
		cursor:pointer;
		display:inline;
	}
</style>
<div class="row clear-m">
   <ol class="breadcrumb">
		<c:if test="${type==''}">
		<li>质量管理</li>
		<li>检验任务</li>
		</c:if>
		<c:if test="${type=='dc'}">
		<li>代储监管</li>
		<li>报表台账</li>
		</c:if>
		<li class="active"><c:if test="${auvp=='a'}">
		新增
		</c:if>
		<c:if test="${auvp=='u'}">
		编辑
		</c:if>
		<c:if test="${auvp=='v'}">
		查看
		</c:if>
		<c:if test="${type==''}">
		检验结果
		</c:if>
		<c:if test="${type=='dc'}">
		质量检测报告
		</c:if></li>
	</ol>
	<div class="container-box clearfix" style="padding: 10px">
    <!--检验结果表-->
     <form class="form_input layui-form" id="form_input"  action="save.shtml" method="post" enctype="multipart/form-data" lay-filter="form1">
     <input type="hidden" name="auvp" value="${auvp}">
     <input type="hidden" name="type" id="type" value="${type}"/>
		 <input type="hidden" name="id"  value="${entity.id }"/>
		 <input type="hidden" name="checkType"  value="1"/>
        <table class="table table-bordered">

            <!-- 表格内容 start -->
            <tbody>
            <tr>
           		 <td class="text-right"><span class="red">*</span><b>样品编号:</b></td>
                <td colspan="3">
					<c:if test="${auvp!='v'}">
						<select lay-verify="required" class="form-control"   name="sampleNo" id="sampleNo" lay-search lay-filter="sampleNo" >
							<option value="">--搜索选择--</option>
							<c:forEach items="${qualitySamples}" var="qualitySamples">
								<option value="${qualitySamples.sampleNo}" warehouseId="${qualitySamples.warehouseId}" sampleNo="${qualitySamples.id}">${qualitySamples.sampleNo}</option>
							</c:forEach>
						</select>
					</c:if>
					<c:if test="${auvp=='v'}">
					<input maxlength="50" tag="model" type="text" name="sampleNo2" value='${entity.sampleNo }' class="form-control"  placeholder=""/>
					</c:if>
					<input maxlength="50" tag="model" type="hidden" name="sampleNoId" id="sampleNoId" value='${entity.sampleNo }' class="form-control"  placeholder=""/>
					<input type="hidden" name="warehouseId" id="warehouseId"  value='${entity.warehouseId}' class="form-control"  placeholder=""/>
					<input type="hidden" name="varietyType" id="varietyType" value='${entity.varietyType }' class="form-control"  placeholder=""/>
                </td>
            </tr>
            <tr>
            	<td class="text-right"><span class="red">*</span><b>受检单位:</b></td>
                <td colspan="3">
   					<input maxlength="50" lay-verify="required" type="text" readonly="readonly" name="reportUnit" value='${entity.reportUnit }' class="form-control"  placeholder=""/>
                </td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>检测单位:</b></td>
                <td colspan="3">
                    <input type="hidden" name="acceptedUnitId" value="${entity.acceptedUnitId}">
                    <input maxlength="50" lay-verify="required" tag="model" type="text" readonly="readonly" id="acceptedUnit" name="acceptedUnit" value='${entity.acceptedUnit }' class="form-control"  placeholder=""/>
                    <c:if test="${isEdit}">
                        <a type="button" class="btn btn-link" id="chooseBtn" data-target="#myModal" data-bind="click:function(){$root.showModal($data);}">选择</a>
                    </c:if>
                </td>
            </tr>
            <tr>
                <td class="text-right"><b>粮食品种:</b></td>
                <td><input type="text" name="variety" id="variety" value='${entity.variety }' readonly="readonly" class="form-control"  placeholder="--自动带出--"/></td>
                <td class="text-right"><b>仓/罐号:</b></td>
                <td>
                	<input maxlength="80" type="text" name="storeEncode" id="storeEncode" value='${entity.storeEncode }'  class="form-control " readonly placeholder="--自动带出--"/>
                	<input hidden maxlength="80" type="text" name="oilcanSerial" id="oilcanSerial" value='${entity.oilcanSerial }' readonly class=" "  placeholder="--自动带出--"/>
					<c:if test="${isEdit}">
						<a type="button" class="btn btn-link" id="userMode1">自定义</a>
					</c:if>
				</td>
            </tr>
            <tr>
                <td class="text-right"><b>产地:</b></td>
                <td>
   					<input type="text" id="origin" name="origin" value='${entity.origin }' lay-verify="required" class="form-control " readonly placeholder="--自动带出--"/>
   				</td>
                <td class="text-right"><b>封存时间:</b></td>
                <td><input type="text" id="storeDate" name="storeDate" readonly value='${entity.storeDate }' class="form-control "  placeholder="--自动带出--"/></td>
            </tr>
			<tr>

				<td class="text-right"><b>检测开始时间:</b></td>
				<td><input type="text" id="testDate" name="testDate" readonly value='${entity.testDate }' class="form-control "  placeholder="--自动带出--"/></td>
				<td class="text-right"><b>检测结束时间:</b></td>
				<td>
					<input maxlength="100" type="text"  id="testEndDate" name="testEndDate" readonly value='${entity.testEndDate }' class="form-control"  placeholder="--自动带出--"/>
				</td>
			</tr>
            <tr>
                <td class="text-right"><b>车/船号:</b></td>
                <td><input maxlength="20" type="text" name="vehicleNumber" id="vehicleNumber" readonly value='${entity.vehicleNumber }' class="form-control "  placeholder="--自动带出--"/></td>
                <td class="text-right"><b>收获年份:</b></td>
                <td><input type="text" id="harvestYear" name="harvestYear" value='${entity.harvestYear }' readonly class="form-control "  placeholder="--自动带出--"/></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red" id="oil">*</span><b>储备性质:</b></td>
                <td>
                <select lay-verify="required" name="storeNature" id="storeNature" class="form-control ">
					<option value="">--请选择--</option>
                    <%--<option value="省级储备">省级储备</option>--%>
                    <%--<option value="中央储备">中央储备</option>--%>
					<c:if test="${entity.storeNature=='省级储备' }">
						<option value="省级储备" selected="selected" >省级储备</option>
					</c:if>
					<c:if test="${entity.storeNature!='省级储备' }">
						<option value="省级储备"  >省级储备</option>
					</c:if>
					<c:if test="${entity.storeNature!='中央储备' }">
						<option value="中央储备" >中央储备</option>
					</c:if>
					<c:if test="${entity.storeNature=='中央储备' }">
						<option value="中央储备" selected="selected">中央储备</option>
					</c:if>
				</select>
				 <td class="text-right"><span class="red" id="grain">*</span><b>储存方式:</b></td>
                <td>
                <select lay-verify="required" class="form-control "  name="storeType" id="storeType">
                   		 <option value="">--请选择--</option>
		                 <c:forEach items="${storeType}" var="storeType">
		                 	<c:if test="${storeType.value eq entity.storeType }">
		                 		<option value="${storeType.value}" selected="selected" >${storeType.value}</option>
							</c:if>
							<c:if test="${storeType.value ne entity.storeType }">
		                 		<option value="${storeType.value}" >${storeType.value}</option>
							</c:if>
		   				 </c:forEach>
   					</select>
                </td>
              
            </tr>
			<tr>
				<td class="text-right"><span class="red">*</span><b>数量(吨):</b></td>
				<td ><input maxlength="10" lay-verify="required" type="text" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" name="quantity" value='${entity.quantity }' class="form-control validate[required]"  placeholder=""/></td>
				<td class="text-right"><span class="red">*</span><b>主检人:</b></td>
				<td><input maxlength="20" type="text" name="mainTester" id="mainTester" readonly value='${entity.mainTester }' class="form-control "  placeholder="--自动带出--"/></td>
			</tr>
			<tr>
				<td class="text-right"><b>存储指标判定:</b></td>
				<td ><input type="text" name="storeJudge" id="storeJudge" value='${entity.storeJudge }' class="form-control "  placeholder="" maxlength="100"/></td>
				<td class="text-right"><b>卫生指标判定:</b></td>
				<td><input type="text" name="hygieneJudge" id="hygieneJudge" value='${entity.hygieneJudge }' class="form-control"  placeholder="" maxlength="100"/></td>
			</tr>
            <tr>
				<td class="text-right"><span class="red">*</span><b>模板编号:</b></td>
				<td ><input type="text" name="templetNo" lay-verify="required" id="templetNo" value='${entity.templetNo }' onclick="toAddSelect();" class="form-control "  placeholder=""/></td>
				<td class="text-right"><b>检验类型:</b></td>
				<td>
					<input type="text" name="validType" readonly value='${entity.validType }' class="form-control"  placeholder="--自动带出--"/>
				</td>
			</tr>

            <tr>
         		<td class="text-right"><span class="red"></span><b>附件(<a  style="color:red; font-size:10px;" >只允许上传xlx、xlsx和jpg文件</a>):</b></td>
                <td colspan="3">
              	<div class="layui-btn layui-btn-primary layui-btn-small" id="importFile">添加附件</div>
               	<div id="afileName" style="display:inline-block;font-size:14px;" >
			<c:forEach items="${files}" var="item">
          			<a href="${ctx }/sysFile/download.shtml?fileId=${item.id}" style="margin:0 10px;">${item.fileName }</a>
				<input type="hidden" name="fileName" value="${entity.fileName}">
				<c:forEach items="${suffixMap}" var="m">
					<c:if test="${m.key == item.id}">
						<c:choose>
							<c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
								<a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${item.downloadUrl}','width=1200px;height=800px;')" id="openExcel">
									预览
								</a>
							</c:when>
							<c:otherwise>
								<a style="color: yellowgreen" href="javascript:openAnnex('${item.id}')" id="openFile">
									预览
								</a>
							</c:otherwise>
						</c:choose>
					</c:if>

				</c:forEach>
				    <input type="hidden" name="fileid" id="fileid" value='${item.id }' />
			</c:forEach>
				</div>
					<button class="layui-btn layui-btn-primary layui-btn-small" type="button" id="btnDelete" <c:if test="${empty files || fn:length(files) == 0}">  style="display: none" </c:if> >删除</button>

				</td>
            </tr>
            <tr>
                <td class="text-right"><span class="red"></span><b>结论:</b></td>
                <td colspan="3"><textarea rows="4" name="remark" class="form-control" placeholder="最多输入400个字符" maxlength="400">${entity.remark }</textarea></td>
            </tr>

            <!-- 表格内容 end -->
            </tbody>
        </table>
        <div class="manage">
            <table class="layui-table" id="tableId">
						<thead>
							<tr>
								<td align="center">检测项名称</td>
								<td align="center">等级</td>
								<td align="center">标准值</td>
								<td align="center">检测值</td>
								<td align="center">结论</td>
								<c:if test="${auvp!='v'}"><td align="center">操作</td></c:if>
							</tr>
						</thead>
                <!-- 表格内容start -->
                <tbody id="Detail">
                <c:forEach items="${entityItem}" var="entityItem">  
                 <tr id="addtr" class="addtr">
	                <td colspan="1">${entityItem.itemName }<input readonly="readonly" style="text-align: left" type="hidden" value='${entityItem.itemName }' id="itemName" name="itemName" class="form-control validate[required] "placeholder=""/></td>
					 <input readonly="readonly" type="hidden" value='${entityItem.orderNo }' id="orderNo" name="orderNo" class="form-control validate[required] "placeholder=""/>
					 <td colspan="1"><input readonly="readonly" type="text" value='${entityItem.grade }' id="grade" name="grade" class="form-control "placeholder=""/></td>
	                <td colspan="1"><input readonly="readonly" type="text" value='${entityItem.standard }' id="standard" name="standard" class="form-control validate[required] "placeholder=""/></td>
	               <%-- <td colspan="1"><input type="text" value='${entityItem.result }' name="result" class="form-control validate[required] "placeholder=""/>--%>

					 <td colspan="1"><textarea rows="1" name="result" class="form-control" placeholder="" maxlength="125">${entityItem.result }</textarea></td>
					 <td colspan="1"><input type="text" value='${entityItem.remark }' id="remark" name="remarkItem" class="form-control  "placeholder=""/>
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
             <button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">返回</button>
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
									data-bind="click:function(){$root.reloadTable4();}">查询</button>
							</div>
						</div>
					</div>
					<table class="layui-table" lay-filter="table4" id="myTable4"></table>
					<div class="modal-footer">
						<button type="button"
							class="layui-btn layui-btn-primary layui-btn-small"
							data-bind="click:function(){$root.selectWarehouse('result')}">确定</button>
						<button type="button"
							class="layui-btn layui-btn-primary layui-btn-small"
							data-bind="click:function(){$root.hideModal('inModal','myTable4')}">取消</button>
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
    function clearNoNum(obj){
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
$(function () {
    $("input[name='file']").change(function () {
        $("#btnDelete").css("display","");
    });
});

    var vm = new Add(false,0,[],[],hostUrl);
var fileList = [];
ko.applyBindings(vm,$(".container-box")[0]);
vm.initPage();
 function mergeTable(tabObj,colIndex){
            if(tabObj != null){
                var i,j;
                var intSpan;
                var strTemp;
                for(i = 1; i < tabObj.rows.length; i++){
                    intSpan = 1;
                    strTemp = tabObj.rows[i].cells[colIndex].innerText ;
                    for(j = i + 1; j < tabObj.rows.length; j++){
                        if(strTemp == tabObj.rows[j].cells[colIndex].innerText){
                            intSpan++;
                            tabObj.rows[i].cells[colIndex].rowSpan = intSpan;
                            tabObj.rows[j].cells[colIndex].style.display = "none";
                            tabObj.rows[i].cells[3].rowSpan = intSpan;
                            tabObj.rows[j].cells[3].style.display = "none";
                            tabObj.rows[i].cells[4].rowSpan = intSpan;
                            tabObj.rows[j].cells[4].style.display = "none";
                        }else{
                            break;
                        }
                    }
                    i = j - 1;
                }
            }
        }
 
 var qualitySamples=${cf:toJSON(qualitySamples)};
layui.form.on('select(sampleNo)',function(data){
    var child = $("#sampleNo option:selected").attr("sampleNo");
    $('#sampleNoId').val(child);
    $('#warehouseId').val($("#sampleNo option:selected").attr("warehouseId"));

	  var sampleNo=data.value;

      for(var i=0;i<qualitySamples.length;i++){
      	if(qualitySamples[i].sampleNo == sampleNo){
      		$('input[name="reportUnit"]').val(qualitySamples[i].sampleSouce||'');
      		$('input[name="sampleName"]').val(qualitySamples[i].sampleName||'');
      		$('input[name="variety"]').val(qualitySamples[i].variety||'');
      		$('input[name="varietyType"]').val(qualitySamples[i].varietyType||'');
      		$('input[name="storeEncode"]').val(qualitySamples[i].storehouse||'');
      		$('input[name="oilcanSerial"]').val(qualitySamples[i].storehouse||'');
      		$('input[name="origin"]').val(qualitySamples[i].origin||'');
      		$('input[name="vehicleNumber"]').val(qualitySamples[i].vehicleNumber||'');
      		$('input[name="harvestYear"]').val(qualitySamples[i].harvestYear||'');
      		$('input[name="testDate"]').val(qualitySamples[i].testDate||'');
            $('input[name="testEndDate"]').val(qualitySamples[i].testEndDate||'');
      		$('input[name="validType"]').val(qualitySamples[i].validType||'');
      		$('input[name="storeDate"]').val(Date_format(qualitySamples[i].storeTime,true)||'');
            $('select[name="storeNature"]').val(qualitySamples[i].storeNature||'省级储备');
            $('select[name="storeType"]').val(qualitySamples[i].storeType||'');
            $('input[name="quantity"]').val(qualitySamples[i].quantity||'');
            $('input[name="mainTester"]').val(qualitySamples[i].executor||'${user.name}');
      		// if(qualitySamples[i].varietyType=='油'){
      		// 	$('span#grain').hide();
      		// }else if(qualitySamples[i].varietyType=='粮'){
      		// 	$('span#oil').hide();
      		// }else{
      		// 	$('span#grain').hide();
      		// 	$('span#oil').hide();
      		// }
      		layui.form.render('select');
      		break;
      	}else{
      		continue;
      	}
      }

});

	
 layui.use('laydate', function(){
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
    });
 layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#storeDate'
            ,format: 'yyyy-MM-dd' //可任意组合
        });
    });

    //日期选择器
	var laydate=layui.laydate;
	laydate.render({
		elem:"#harvestYear",
		type:"year",
		format:"yyyy",	
	});

$(function(){
	var auvp = '${auvp}';

	mergeTable(tableId,0);
	if(auvp=='v'){$("#cancel").text("返回");}else{$("#cancel").text("取消");}
	if(auvp=='v'){

	//下拉框禁用
	$("select").each(function () {$("#" + this.id).attr("disabled", true);});
		$("form").find("input,textarea,select").prop("readonly", true);
		$('#btnSave').hide();
		$('div#importFile').hide();
		$('form select').show();
	}else if(auvp=='u'){
        document.getElementById("sampleNo").value ='${entity.sampleNo }';
		$('#id').prop("readonly", true);
		layui.form.render("select","form1");
        var id=$("#fileid").val();
        if (id!=null && id!=''){
            $('#btnDelete').show();
		}
	}else if(auvp=='a'){
		layui.form.render('select','form1');
	}
	/* $('#origin').comboSelect(); */
});
layui.use('laydate', function(){
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
 function addList(grade,itemName,standard,orderNo){
    var tr =   '<tr id="addtr" class="addtr">'
                +'<td colspan="1" id="kin">'+itemName+'<input readonly="readonly" type="hidden" value="'+itemName+'" id="itemName" name="itemName" class="form-control validate[required] "  placeholder=""/></td>'

        		+'<input readonly="readonly" type="hidden" value="'+orderNo+'" id="orderNo" name="orderNo" class="form-control validate[required] "placeholder=""/>'

				+'<td colspan="1" id="kin"><input readonly="readonly" type="text" value="'+grade+'" id="grade" name="grade" class="form-control validate[required] "placeholder="--请输入--"/></td>'
                +'<td colspan="1" id="kin"><input  readonly="readonly"type="text" value="'+standard+'" id="standard" name="standard" class="form-control validate[required]    placeholder=""/></td>'
                /*+'<td colspan="1" id="kin"><input type="text" value="" name="result" class="form-control validate[required]"     placeholder=""/>'*/
        +'<td colspan="1" id="kin"><textarea rows="1" name="result" class="form-control" placeholder="" maxlength="125"></textarea></td>'
		+'<td colspan="1" id="kin"><input type="text" value=""id="remark" name="remarkItem" class="form-control   placeholder=""/>'
        +'<input type="hidden" value="" id="resultId" name="resultId" style="width:0px;"/></td>'
        +'<td colspan="1" id="kin"><a href="javascript:void(0);" onclick="toDeleteTr(this);" class="layui-btn layui-btn-small layui-bg-red" data-id="">删除</a></td>'
                +'</tr>'
   	$("#Detail").append(tr);
   	mergeTable(tableId,0);
   }
    
    function toDelete(){
     $("tr.addtr").remove();
    }
    $("#btnDelete").click(function(){
        <%--var id=$("#fileid").val();--%>

		<%--if (id!=''){--%>
            <%--$.ajax({--%>
                <%--type : "POST",--%>
                <%--url : "${ctx }/sysFile/delete.shtml?id="+id,--%>
                <%--success : function(result) {--%>
                    <%--if ( result.success ) {--%>
                        <%--layerMsgSuccess("删除成功");--%>
                        <%--$("#btnDelete").hide();--%>
                        <%--$('#afileName').hide();--%>
                    <%--} else {--%>
                        <%--layerMsgError("删除失败");--%>
                    <%--}--%>
                <%--}--%>
            <%--});--%>
		<%--}--%>

		// 伪删除文件
		$("#fileid").val("");
		$("input[name='file']").val("");
		$("input[name='fileName']").val("");
        $("#btnDelete").hide();
        $('#afileName').hide();
	});
var lastClickTime = 0;
var DELAY = 20000;
   $("#btnSave").click(function(){


  var templetNo=document.getElementById("templetNo").value;

   var str="";
       var sampleNo=document.getElementById("sampleNo").value;
       if(sampleNo==""){
           str+="样品编号不能为空";
       }else{

       }

   if(templetNo==""){
   if(str==""){
   			str+="模板编号不能为空";
   			}else{
   			str+=",模板编号不能为空";
   			}
   }
   var variety=$('input[name="varietyType"]').val();
   // if(variety.indexOf('粮')!=-1){
   		var storeNature=document.getElementById("storeNature").value;

   		if(storeNature==null||storeNature==""){
   			if(str==""){ 
   				str+="储备性质不能为空";
   			}else{
   				str+=",储备性质不能为空"
   			}
   		}    
   // }else if(variety.indexOf('油')!=-1){


       var storeType=document.getElementById("storeType").value;
		   if(storeType==null||storeType==""){
			   if(str==""){
				   str+="储存方式不能为空";
			   }else{
				   str+=",储存方式不能为空"
			   }
		   }
       // }


   if(str==""){
   		if($(".form_input").validationEngine('validate')==true){
   			layer.load();
            var currentTime = Date.parse(new Date());
            if (currentTime - lastClickTime > DELAY) {
                lastClickTime = currentTime;
                $("#btnSave").attr("disabled", true);
			$(".form_input").ajaxSubmit({
			data:{
				'file':fileList
			},
			type:"post",
			success:function(data){
				if(data.success){
				layerMsgSuccess("保存成功",function(){location.href="${ctx}/QualityResult.shtml?type="+$("#type").val()});
				}else{
				layerMsgError("保存失败");
                    $("#btnSave").attr("disabled", false);
				}
			},
			error:function(xhr){
				layerMsgError("数据接口异常");
			},
			complete:function(){
				layer.closeAll('loading');
			}
			});
		}
		}
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
function toAddSelectStorageOilcan(){
	$.colorbox({
		title : '油罐信息管理',
		iframe : true,
		opacity	: 0.2,
		href : "${ctx}/QualityResult/listChoice.shtml?",
		innerWidth : '1200px',
		innerHeight : '80%',
		close : '×15151',
		fixed : true
	});
}
	$("#add-annex").click(function(){
		$("#file-input").click();
	});
	
	$("#file-input").change(function(){
		var filename = $(this).val().split("\\");
		$("#add-annex").html(filename[filename.length - 1]);
	});
	function selectToData(data){
	toDelete();
	$("input[name='templetNo']").val(data.templetNo);
    var itemName=data.itemName.split(","); 
	var itemId=data.itemId.split(","); 
	var grade=data.grade.split(","); 
	var standard=data.standard.split(",");
	var orderNo=data.orderNo.split(",");
	for(var i = 0 ; i < itemId.length ; i++) {
	addList(grade[i],itemName[i],standard[i],orderNo[i]);
	}
	}
	function selectToDataStorageOilcan(data){
	var str =data.deliverDate;
	var year = str.split('')[0]+str.split('')[1]+str.split('')[2]+str.split('')[3];
    var month = str.split('')[5]+str.split('')[6];
    var day = str.split('')[8]+str.split('')[9];
	$("input[name='oilcanSerial']").val(data.oilcanSerial);
	$("input[name='storeDate']").val(year+"-"+month+"-"+day);
	
	}
var upload = layui.upload;
	   //执行实例
  var uploadInst = upload.render({
    elem: '#importFile' , //绑定元素
    accept: 'file' ,//普通文件
	 exts:"xlx|xlsx|jpg",
    multiple:true,
    auto:false,
    choose:function(obj){
    	$("#afileName").empty();
    	var files = obj.pushFile();

        /*$("#btnDelete").show();*/
        obj.preview(function(index, file, result){
        	var filePart = document.createElement('input');
        	filePart.name = 'file';
        	filePart.type = 'hidden';
        	filePart.value = file;
        	filePart.id="fileid";
        	document.querySelector('#afileName').appendChild(filePart);
        	var link = document.createElement('a');
        	link.innerHTML = file.name;
        	link.style.margin = '0 10px';
        	document.querySelector('#afileName').appendChild(link);
            /*var btn = document.createElement('input');
            btn.type = "button";
            btn.value = "删除";
            btn.id="btnDelete";
            btn.class="layui-btn layui-btn-primary layui-btn-small";
            document.querySelector('#afileName').appendChild(btn);*/

            $('#afileName').show();
        });
    },
    error: function(){
      //请求异常回调
    }
  });
$("#userMode1").click(function(){
    layer.confirm("是否自定义仓/罐号？",{btn:['是','否'],
        btn1:function(index){
            $("#storeEncode").removeAttr("readonly");
            $("#storeEncode").attr("placeholder","--请输入--");
            layer.close(index);
        },
        btn2:function(){
            //do nothing;
        }
    })
});
function toDeleteTr(ob){
	$(ob).parent().parent().remove();
}
</script>
<script src="${ctx}/js/select/jquery.combo.select.js"></script>