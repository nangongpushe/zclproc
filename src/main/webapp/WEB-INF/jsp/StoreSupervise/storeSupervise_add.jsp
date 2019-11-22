<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/AdminHeader.jsp"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="sysDate" class="java.util.Date" scope="page"/>
<style>
	#enterpriseTable + .layui-form .layui-table-body td[data-field="enterpriseSerial"]{
		text-align: left;
	}
	#enterpriseTable + .layui-form .layui-table-body td[data-field="socialCreditCode"]{
		text-align: left;
	}
	#enterpriseTable + .layui-form .layui-table-body td[data-field="enterpriseName"]{
		text-align: left;
	}
	#enterpriseTable + .layui-form .layui-table-body td[data-field="province"]{
		text-align: left;
	}
	#enterpriseTable + .layui-form .layui-table-body td[data-field="city"]{
		text-align: left;
	}
	#enterpriseTable + .layui-form .layui-table-body td[data-field="area"]{
		text-align: left;
	}
	#enterpriseTable + .layui-form .layui-table-body td[data-field="personIncharge"]{
		text-align: left;
	}
	#enterpriseTable + .layui-form .layui-table-body td[data-field="telephone"]{
		text-align: right;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>代储监管</li>
		<li><a href="${ctx }/StoreSupervise.shtml">分片监管</a></li>
		<li class="active">分片监管信息</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	<!-- <form class="layui-form" id="supervise"> -->
	<form class="form_input" id="supervise"  action="save.shtml" method="post" enctype="multipart/form-data">
		<input name="id" value="${supervise.id }" type="hidden">
		<input type="hidden" class="layui-input " autocomplete="off" name="createDept" readonly value="${supervise.createDept }" >
		<table  class="table table-bordered" lay-filter="test">
		<tbody>
		<tr>
                    <td class="text-right"><span class="red">*</span><b> 计划编号:</b></td>
                    <td><input class="layui-input validate[required]" autocomplete="off" name="superviseSerial" readonly="readonly" value="${supervise.superviseSerial }"></td>
                	<td class="text-right"><span class="red">*</span><b> 制定人:</b></td>
                    <td><input class="layui-input validate[required]" autocomplete="off" name="creator" readonly="readonly" value="${supervise.creator }" ></td>
                </tr>
        <tr>
        			<td class="text-right"><span class="red">*</span><b> 计划名称:</b></td>
                    <td><input  class="layui-input validate[required]" maxlength="20"  autocomplete="off" name="superviseName" value="${supervise.superviseName }"></td>
                    <td class="text-right"><span class="red">*</span><b> 计划年份:</b></td>
                    <td><input   class="layui-input validate[required]"  name="superviseYear" id="superviseYear" value="${supervise.superviseYear }"></td>
                </tr>
        <tr>
                    
                    
                    <td class="text-right"><span class="red"></span><b> 附件:</b></td>
                	<td colspan="3">
                    <c:choose>
					<c:when test="${auvp eq 'a' or supervise.groupId eq null or supervise.groupId eq ''}">
						<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="upload"><i class="layui-icon"></i>上传文件</button>
						<input type="hidden" name="groupId">
					</c:when>
					<c:otherwise>
						<%--<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="upload"><i class="layui-icon"></i>${myFile.fileName }</button>--%>
						<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="upload"><i class="layui-icon"></i>上传文件</button>
						<input type="hidden" name="groupId" value="${supervise.groupId }">
					</c:otherwise>
					</c:choose>
					<c:if test="${supervise.groupId ne null and supervise.groupId ne '' }">
						<span id="fileName">
							<a href="${ctx }/sysFile/download.shtml?fileId=${supervise.groupId}" style="margin:0 10px;">${myFile.fileName}</a>
						</span>
						<div style="display:inline-block;font-size:20px;" id="openExce">
							<%--<a href="${ctx }/sysFile/download.shtml?fileId=${supervise.groupId }">${myFile.fileName }</a>--%>
							<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
								预览
							</a>
							<a href="javascript:openAnnex('${supervise.groupId}')" id="openFile" style="display: none">
								预览
							</a>
						</div>
						<div style="display:inline-block;font-size:20px;" id="afileName">
							<input type="button" id="delFileBtn" <c:if test="${empty filename.fileName}">style="display: block" </c:if>  onclick="resetFileInput();"  value="删除"/>
						</div>


					</c:if>
					<a  style="color:red; font-size:10px;" >只允许上传格式为doc|xlsx|pdf|docx|xls的文件</a>
					</td>
                </tr>
		</tbody>
		</table>
		<%-- <div class="layui-row">
			<div class="layui-col-md4">
			<label class="layui-form-label"><span class="red">*</span>计划编号：</label>
			<div class="layui-input-inline">
				<input class="layui-input validate[required]" autocomplete="off" name="superviseSerial" readonly value="${supervise.superviseSerial }">
			</div>
			</div>
			<div class="layui-col-md4">
				<label class="layui-form-label"><span class="red">*</span>制定人：</label>
				<div class="layui-input-inline">
					<input class="layui-input validate[required]" autocomplete="off" name="creator" readonly value="${supervise.creator }" >
				</div>
			</div>
			<div class="layui-col-md4">
				<label class="layui-form-label"><span class="red"></span>制定人部门：</label>
				<div class="layui-input-inline">
					<input class="layui-input " autocomplete="off" name="createDept" readonly value="${supervise.createDept }" >
				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-md4">
				<label class="layui-form-label"><span class="red">*</span>计划名称：</label>
				<div class="layui-input-inline">
					<input  class="layui-input validate[required]"  autocomplete="off" name="superviseName" value="${supervise.superviseName }">
				</div>
			</div>
			<div class="layui-col-md4">
				<label class="layui-form-label"><span class="red">*</span>计划年份：</label>
				<div class="layui-input-inline"><!-- yyyy年MM月dd日 HH:mm:ss -->
					<input   class="layui-input validate[required]"  name="superviseYear" id="superviseYear" value="${supervise.superviseYear }">
				</div>
			</div>
			<div class="layui-col-md4">
				<label class="layui-form-label">附件：</label>
				<div class="layui-input-inline">
					<c:choose>
					<c:when test="${auvp eq 'a' or supervise.groupId eq null or supervise.groupId eq ''}">
						<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="upload"><i class="layui-icon"></i>上传文件</button>
						<input type="hidden" name="groupId">
					</c:when>
					<c:otherwise>
						<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="upload"><i class="layui-icon"></i>${file.fileName }</button>
						<input type="hidden" name="groupId" value="${supervise.groupId }">
					</c:otherwise>
					</c:choose>
					<c:if test="${supervise.groupId ne null and supervise.groupId ne '' }">
						<a href="${ctx }/sysFile/download.shtml?fileId=${supervise.groupId }" 
						class="layui-btn layui-btn-primary layui-btn-small">下载文件</a>
					</c:if>
				</div>
			</div>
		</div> --%>
	</form>
	
	<p class="btn-box">
		<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="addDetail" onclick="addRow()">新增明细</button>
	</p>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog"  style="width:800px;">
		<div class="modal-content">
			<div class="modal-header"><!-- data-dismiss="modal"  -->
				<button type="button" class="close" aria-hidden="true" onclick="removeActiveClass()">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					选择监管企业
				</h4>
			</div>
			<div class="modal-body">
				<div class="layui-form" id="search">
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">企业编号：</label>
							<div class="layui-input-inline">
								<input class="layui-input" autocomplete="off" id="enterpriseSerial" name="enterpriseSerial">
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">企业名称：</label>
							<div class="layui-input-inline">
								<input class="layui-input" autocomplete="off" id="enterpriseName" name="enterpriseName">
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
	<form id="detailForm">
		<table class="layui-table" id="detail">
			<colgroup>
			    <col>
			    <col style="width:120px">
			    <col>
			    <col>
			    <col>
			    <col>
			    <col>
			    <col>
			    <col>
			    <col>			  
  			</colgroup>
		    <thead>
				<tr>
					<th style="text-align:center">操作</th>
					<th style="width:120px;text-align: center" >库点名称</th>
					<th style="width:90px;text-align: center">企业编号</th>
					<th style="text-align:center">企业名称</th>
					<th style="text-align:center">统一社会信用代码</th>
					<th style="text-align:center">行政区划名称</th>
					<th style="text-align:center">法人代表</th>
					<th style="text-align:center">联系电话</th>
					<th style="text-align:center">监管开始日期</th>
					<th style="text-align:center">监管结束日期</th>
				</tr>
		    </thead>
		    <tbody>
		    <c:forEach var="item" items="${supervise.detail }" varStatus="i">
		    	<tr class="data-tr">
			    	<td>
			    	<button type="button" class="layui-btn layui-btn-primary layui-btn layui-btn-mini" onclick="delRow(this)">删除</button>
			    	</td>
			    	<td style="width:120px">
			    <!-- 	<select class="layui-input validate[required]" name="warehouseName" onchange="warehouseChangeCheck(this)">
			    	<option value="">请选择</option>
			    	<option value="直属库" typeName="ZHI">直属库</option>
			    	<option value="德清库" typeName="DEQ">德清库</option>
			    	<option value="衢州库" typeName="QUZ">衢州库</option>
			    	<option value="舟山库" typeName="ZSK">舟山库</option>
			    	<option value="越州库" typeName="YUE">越州库</option>
			    	<option value="中穗库" typeName="ZHS">中穗库</option></select> -->
			    	
			    	
			    	<select class="layui-input validate[required]"  name="warehouseName" 
						onchange="warehouseChangeCheck(this)">
						
						  <c:forEach var="item1" items="${storehouses}" varStatus="status">
						 
						  <option  class="${ status.index + 1}"  value="${item1.warehouseShort}" typeName="${item1.warehouseCode}" warehouseId="${item1.id}">${item1.warehouseShort }</option>
						 
						</c:forEach>									
					</select>
			    	
			    	<input class="layui-input " name="warehouseId" id="warehouseId" type="hidden" value="${item.warehouseId }">
			    	<input class="layui-input " name="warehouseCode" id="warehouseCode" type="hidden" value="${item.warehouseCode }">
			    	</td>
			    	<td><input class="layui-input" autocomplete="off" name="enterpriseSerial" readonly value="${item.enterpriseSerial }" 
			    	onclick="addActiveClass(this)"/></td>
			    	<td><input class="layui-input validate[required]" autocomplete="off" name="enterpriseName" readonly value="${item.enterpriseName }"></td>
			    	<td><input class="layui-input validate[required]" autocomplete="off" name="socialCreditCode" readonly value="${item.socialCreditCode }"></td>
			    	<td><input class="layui-input  validate[required]" autocomplete="off" name="division" readonly value="${item.division }"></td>
			    	<td><input class="layui-input validate[required]" autocomplete="off" name="personIncharge" readonly value="${item.personIncharge }"></td>
			    	<td><input class="layui-input validate[required]" autocomplete="off" name="telephone" readonly value="${item.telephone }"></td>
					<input class="layui-input validate[required]" autocomplete="off" name="enterpriseId" type="hidden" value="${item.enterpriseId }">
			    	<td><input class="layui-input date-need validate[required]" id="startDate${i.index}" autocomplete="off" name="superviseStart" id="superviseStart" value="<fmt:formatDate value="${item.superviseStart }" pattern="yyyy-MM-dd"/>"></td>
			    	<td><input class="layui-input date-need validate[required]" id="endDate${i.index}" autocomplete="off" name="superviseEnd" id="superviseEnd" value="<fmt:formatDate value="${item.superviseEnd }" pattern="yyyy-MM-dd"/>"></td>
		    	</tr>
		    </c:forEach>
		    </tbody>
	    </table>
	</form>
	
	<p class="btn-box text-center">
	    <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="cancelBtn" name="cancelBtn"
	    onclick="cancelOperate('${auvp }', '${ctx}/StoreSupervise.shtml')">取消</button>
	    <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="submitBtn">保存</button>
	</p>
	
</div>

<script src="${ctx}/js/app/storage/common.js"></script>

<script type="text/javascript">

    function resetFileInput(){
        $("#upload").val("");
        $("#upload").html("上传文件");
        $("#fileName").html("");
        $("input[name='groupId']").val("");
        $("#delFileBtn").hide();
        $("#openExce a").html("");
    }
    if ("${supervise.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
var laydate=layui.laydate;
	laydate.render({
		elem:"#superviseYear",
		type:"year",
		format:"yyyy",	
		done:function(value,date){//value, date, endDate点击日期、清空、现在、确定均会触发。回调返回三个参数，分别代表：生成的值、日期时间对象、结束的日期时间对象
        $.post("${ctx}/StoreSupervise/check.shtml",{
					superviseYear : value
				}, function(result) {  
	if (!result.success) {
		layer.closeAll(); //疯狂模式，关闭所有层
		layer.open({
		title: '提示信息'
		,content: '计划年份已存在请更换年份'
		}); 
		document.getElementById("superviseYear").value="";
	}
            var superviseYear = $("#superviseYear").val();
            if (superviseYear!="") {
                $('[name="superviseStart"]').attr('value', Number(superviseYear)+1+"-01-01");
                $('[name="superviseEnd"]').attr('value', Number(superviseYear)+1+"-01-02");
            }
});  
    }
	});

//为当前点击的行新增activeClass
function addActiveClass(obj) {
	$(obj).parent().parent().find('select[name="warehouseName"]').each(function(){
		$(obj).parent().parent().addClass("activeEnterprise");
		$('#myModal').modal({backdrop: 'static'}).modal('show');//设置点击modal背景部分也不会消失的属性打开modal
	});
}

//移除activeClass
function removeActiveClass(obj) {
	$('#myModal').modal('hide');
	$('.activeEnterprise').removeClass('activeEnterprise');
}

layui.use(['laydate','table','upload'], function() {
	var laydate = layui.laydate,
	form = layui.form,
	table = layui.table,
	upload = layui.upload;
	
	//执行一个laydate实例
	/* laydate.render({
	  elem: '#superviseYear' //指定元素
	  ,type: 'year'
	  
	}); */
	//渲染form
	form.render();
	$("#detail").find(".date-need").each(function(){
		laydate.render({
			elem:$(this)[0],
			type:"date",
			format:"yyyy-MM-dd"
		});
	});
	
	//为detail中每个已有的库点名称赋值
	var index = 0;
	<c:forEach var="item" items="${supervise.detail }" >
		var valueText = '${item.warehouseName }';
		$("select[name='warehouseName']").eq(index).find('option[value='+valueText+']').attr("selected",true);
		index++;
	</c:forEach>
	//为detail表格中需要data的地方渲染日期选择器
	$("#detail").find(".date-need").each(function(){
		laydate.render({
			elem:$(this)[0],
			type:"date",
			format:"yyyy-MM-dd"
		});
	});
	//
	table.render({
		elem : '#enterpriseTable',
		url : '${ctx}/StoreEnterprise/list.shtml?isEnterpriseType=Y',
		method : "POST",
		cols : [[
/* 			{checkbox : true}, */
			{fixed : 'left', title : '操作', width : 100, align : 'center', toolbar : '#bar'},
 			{field : 'enterpriseSerial',title : '企业编号',width:150, align : 'center'},
			{field : 'enterpriseName',title : '企业名称',width:150, align : 'center'},
			{field : 'socialCreditCode',title : '统一社会信用代码',width:100, align : 'center'},
			{field : 'province',title : '行政区划省',width:100, align : 'center'},
			{field : 'city',title : '行政区划市',width:100, align : 'center'},
			{field : 'area',title : '行政区划区',width:100, align : 'center'},
			{field : 'personIncharge',title : '法人代表',width:100, align : 'center'},
			{field : 'telephone', title : '联系电话', width:150, align : 'center'},
		]],//设置表头
		request : {
			pageName : 'page', 
			limitName : 'pageSize'
		},
		page:true,//开启分页
		limit:10,
		id:'enterpriseTableId',
		done:function(res,curr,count){
		},
	});
	
	//搜索
	$('#enterpriseSearch').click(function() {
		table.reload("enterpriseTableId", {
			method: 'post', //如果无需自定义HTTP类型，可不加该参数
			where : {
					enterpriseName : $('#search #enterpriseName').val(),
					enterpriseSerial : $('#search #enterpriseSerial').val(),
			}
		});
	});
	
	table.on('tool(operation)', function(obj) {
		var data = obj.data;
		var province1= data.province;
        var city1 = data.city;
        var area1 = data.area;
		if (obj.event === 'choose') {
			var enterpriseSerial = data.enterpriseSerial;
			var warehouse = $('.activeEnterprise select[name="warehouseName"]').val();
			if (oneToManyCheck(enterpriseSerial, warehouse)) {
			    if(province1==null){
			        province1 = "";
				}
                if(city1==null){
                    city1 = "";
                }if(area1==null){
                    area1 = "";
                }
				fillEnterprise(data.enterpriseSerial, data.enterpriseName, data.socialCreditCode,
                    province1 + city1 + area1, data.personIncharge, data.telephone,data.id);
			}
		}
		$('.activeEnterprise').removeClass('activeEnterprise');
		$('#myModal').modal('hide');	
	});
	//监听FORM结束
	
	//监听upload开始
	upload.render({
	    elem: '#upload'
	    ,url: '${ctx }/StoreSupervise/upload.shtml'
	    ,accept: 'file' //普通文件
        ,size:1024*10
        ,exts:"doc|xlsx|pdf|docx|xls"
 		,before: function(obj) {
 			//console.log(obj);
	    	obj.preview(function(index, file, result) {
	    		$('#fileName').text(file.name);
	    		$("#delFileBtn").css("display","");
                $("#openExce a").html("");
	    	});
	    }
	    ,done: function(res){
/* 	    	console.log(res); */
	    	if (res.code === 0) {
	    		layer.msg(res.msg, {time:1000,icon:1});//提示上传结果
	    		$('input[name=groupId]').attr('value', res.data.fileId);
	    	} else {
	    		layer.msg(res.msg, {time:1000,icon:0});//提示上传结果
	    		if ('${supervise.groupId }' === null || '${supervise.groupId }' === '') {
	    			$('#upload').text('上传文件');
	    		} else {
	    			$('#upload').text('${file.fileName }');
	    		}
	    	}
	    }
  	});
  	//监听upload结束
});

function warehouseChangeCheck(obj) {
  	var typeName = $(obj).find("option:selected").attr("typeName");
  	var warehouseId = $(obj).find("option:selected").attr("warehouseId");
    $(obj).parent().find("input[name='warehouseCode']").val(typeName);
    $(obj).parent().find("input[name='warehouseId']").val(warehouseId);
	var warehouseName = $(obj).val();
	var enterpriseSerial = $(obj).parent().parent().find("input[name='enterpriseSerial']:first").val();
	//console.log(enterpriseSerial);
	//console.log(warehouseName);
	if (!oneToManyCheck(enterpriseSerial, warehouseName)) {
		$(obj).val("");
	}
	//console.log("changeCheck result : " + oneToManyCheck(enterpriseSerial, warehouseName));
}
//一对多检查函数，返回检查结果
function oneToManyCheck(enterpriseSerial, warehouseName) {
	var isValidate = true;
	if (warehouseName !== "" && enterpriseSerial != "点击选择") {
		$('input[name="enterpriseSerial"]').each(function(){
			if ($(this).val() === enterpriseSerial) {
				$(this).parent().parent().each(function(){
					//console.log('当前选中库点计数器');
					$(this).find("select[name='warehouseName']").each(function(){
						//console.log($(this).val());
						if($(this).val() !== warehouseName && $(this).val() !== "") {
							//console.log("tanchu jishu");
							isValidate = false;
							return false;
						}
					});
				});
			}
		});
	}
	if (!isValidate) {
		layer.msg("一个企业只能被一个库点监管！",{icon : 2, time : 1000});
	}
	return isValidate;
}

/* function selectEnterprise() {
	var table = layui.table;
	var checkStatus = table.checkStatus('enterpriseTableId');
	var data = checkStatus.data;//获取当前选择的企业信息
	
	if (data.length === 1) {
		var enterpriseSerial = data[0].enterpriseSerial;
		var warehouse = $('.activeEnterprise select[name="warehouseName"]').val();
		if (oneToManyCheck(enterpriseSerial, warehouse)) {
			fillEnterprise(data[0].enterpriseSerial, data[0].enterpriseName, data[0].organizationCode, 
			data[0].province + data[0].city + data[0].area, data[0].personIncharge, data[0].telephone);
		} 
	} else if (data.length === 0) {
		fillEnterprise("点击选择", "", "", "", "", "");
	} else {
		layer.alert("请选择一家监管企业");
		return false;
	}
	$('.activeEnterprise').removeClass('activeEnterprise');
	$('#myModal').modal('hide');	
}; */

//填写表格中当前选中的企业信息
function fillEnterprise(enterpriseSerial,enterpriseName,socialCreditCode,division,personIncharge,telephone,id){
	$('.activeEnterprise input[name="enterpriseSerial"]').val(enterpriseSerial);
	$('.activeEnterprise input[name="enterpriseName"]').val(enterpriseName);
	$('.activeEnterprise input[name="socialCreditCode"]').val(socialCreditCode);
	$('.activeEnterprise input[name="division"]').val(division);
	$('.activeEnterprise input[name="personIncharge"]').val(personIncharge);
	$('.activeEnterprise input[name="telephone"]').val(telephone);
    $('.activeEnterprise input[name="enterpriseId"]').val(id);
}
function addRow(){
	var trHTML =
	'<tr class="data-tr">'+
 	'<td>'+
 	'<button type="button" class="layui-btn layui-btn-primary layui-btn layui-btn-mini" onclick="delRow(this)">删除</button>'+
 	'</td>'+
 	'<td style="width:120px">'+
/*  	'<select class="layui-input validate[required]" name="warehouseName" id="warehouseName"  onchange="warehouseChangeCheck(this)">'+
 	'<option value="">请选择</option>'+
 	'<option value="直属库" typeName="ZHI">直属库</option>'+
 	'<option value="德清库" typeName="DEQ">德清库</option>'+
 	'<option value="衢州库" typeName="QUZ">衢州库</option>'+
 	'<option value="舟山库" typeName="ZSK">舟山库</option>'+
 	'<option value="越州库" typeName="YUE">越州库</option>'+
 	'<option value="中穗库" typeName="ZHS">中穗库</option>'+
 	'</select>'+ */
 	
 	 	'<select class="layui-input validate[required]"  name="warehouseName" onchange="warehouseChangeCheck(this)">'+
						
		   '<c:forEach var="item2" items="${storehouses}" varStatus="status">'+
						 
						  '<option  class="${ status.index + 1}"  value="${item2.warehouseShort}" typeName="${item2.warehouseCode}" warehouseId="${item2.id}">${item2.warehouseShort }</option>'+
						 
			'</c:forEach>'+									
		'</select>'+
 	'<input class="layui-input " name="warehouseId" id="warehouseId" type="hidden" value="${item.id }">'+
 	'<input class="layui-input " name="warehouseCode" id="warehouseCode" type="hidden" value="${item.warehouseCode }">'+
 	'</td>'+
 	'<td><input class="layui-input validate[required]" autocomplete="off" name="enterpriseSerial" readonly value="点击选择" onclick="addActiveClass(this)"></td>'+
    '<input class="layui-input validate[required]" autocomplete="off" name="enterpriseId" type="hidden"  value="">'+
 	'<td><input class="layui-input validate[required]" autocomplete="off" name="enterpriseName" readonly  value=""></td>'+
 	'<td><input class="layui-input validate[required]" autocomplete="off" name="socialCreditCode" readonly  value=""></td>'+
 	'<td><input class="layui-input validate[required]" autocomplete="off" name="division" readonly  value=""></td>'+
 	'<td><input class="layui-input validate[required]" autocomplete="off" name="personIncharge" readonly  value=""></td>'+
 	'<td><input class="layui-input validate[required]" autocomplete="off" name="telephone" readonly  value=""></td>'+
 	'<td><input class="layui-input date-need validate[required]" autocomplete="off" name="superviseStart" id="superviseStart" value=""></td>'+
 	'<td><input class="layui-input date-need validate[required]" autocomplete="off" name="superviseEnd" id="superviseEnd" value=""></td>'+
	'</tr>';
	$("#detail tbody:last").append(trHTML);
	var superviseYear = $("#superviseYear").val();
	if (superviseYear!="") {
        $('[name="superviseStart"]').attr('value', Number(superviseYear)+"-01-01");
        $('[name="superviseEnd"]').attr('value', Number(superviseYear)+1+"-01-02");
	}
	var laydate = layui.laydate;
	$("#detail").find(".date-need").each(function(){
		laydate.render({
			elem:$(this)[0],
			type:"date",
			format:"yyyy-MM-dd"
		});
	});
	table = layui.table;
	table.render();
};

//删除一行
function delRow(obj) {
	$(obj).parent().parent().remove();
};

var  btnFlag=0;
$("#submitBtn").click(function(){
	btnFlag=0;
    if (!$('#detailForm').validationEngine("validate")){
        return false;
    }
    if (!$('#supervise').validationEngine("validate")){
        return false;
    }
    
	
    var supervise = $('#supervise');
    var superviseJson = JSON.stringify(supervise.serializeObject());
    //console.log(supervise);
    //详情表数据
    var detailData = [];
    $(".data-tr").each(function(){
    
      	var superviseStart=  $(this).find("input[name='superviseStart']").val();
        var superviseEnd=  $(this).find("input[name='superviseEnd']").val();
    
     if(superviseStart>=superviseEnd) {
               layer.msg("监管开始时间应早于监管结束时间",{icon:0}); 
			    btnFlag=1;
               return false;
           }
        detailData.push({
            "warehouseName":$(this).find("select[name='warehouseName']").val(),
            "warehouseCode":$(this).find("input[name='warehouseCode']").val(),
            "warehouseId":$(this).find("input[name='warehouseId']").val(),
            "enterpriseSerial":$(this).find("input[name='enterpriseSerial']").val(),
            "enterpriseName":$(this).find("input[name='enterpriseName']").val(),
            "socialCreditCode":$(this).find("input[name='socialCreditCode']").val(),
            "division":$(this).find("input[name='division']").val(),
            "personIncharge":$(this).find("input[name='personIncharge']").val(),
            "telephone":$(this).find("input[name='telephone']").val(),
            "superviseStart":$(this).find("input[name='superviseStart']").val(),
            "superviseEnd":$(this).find("input[name='superviseEnd']").val(),
            "enterpriseId":$(this).find("input[name='enterpriseId']").val(),
        });
    });

    var detailJson = JSON.stringify(detailData);
    //console.log(detailJson);
//禁止多点

	if(btnFlag==1){
	    return;
	}

    $.ajax({
        type : 'POST',
        url : '${ctx }/StoreSupervise/save.shtml?auvp=${auvp}',
        data : {
            'superviseJson' : superviseJson,
            'detailJson' : detailJson
        },
        error: function(request) {
            //layer.closeAll('loading');
            //layer.alert("保存失败，请与管理员联系！");
            if(request.responseText){
                layer.open({
                    type: 1,
                    area: ['700px', '430px'],
                    fix: false,
                    content: request.responseText
                });
            }
            btnFlag=0;
        },
        success : function(result) {
            //layer.closeAll('loading');
            if (!result.success) {
                layer.alert('保存失败!', {icon:2});
                btnFlag=0;
                return;
            } else {
                layer.msg(result.msg,{time:1000,icon:1},function(){
                    location.href = '${ctx }/StoreSupervise.shtml';

                });
            }

        }
    });
    return false;
});

/* $('#submitBtn').click(function(){
	var supervise = $('#supervise');
	var superviseJson = JSON.stringify(supervise.serializeObject());
	//console.log(supervise);
	//详情表数据
	var detailData = [];
	$(".data-tr").each(function(){
		detailData.push({
			"warehouseName":$(this).find("select[name='warehouseName']").val(),
			"enterpriseSerial":$(this).find("input[name='enterpriseSerial']").val(),
			"enterpriseName":$(this).find("input[name='enterpriseName']").val(),
			"organizationCode":$(this).find("input[name='organizationCode']").val(),
			"division":$(this).find("input[name='division']").val(),
			"personIncharge":$(this).find("input[name='personIncharge']").val(),
			"telephone":$(this).find("input[name='telephone']").val(),
			"superviseStart":$(this).find("input[name='superviseStart']").val(),
			"superviseEnd":$(this).find("input[name='superviseEnd']").val(),
		});
	});
	
	var detailJson = JSON.stringify(detailData);
	//console.log(detailJson);

	$.ajax({
	   	type : 'POST',
	   	url : '${ctx }/StoreSupervise/save.shtml?auvp=${auvp}',
	   	data : {
	       	'superviseJson' : superviseJson,
	       	'detailJson' : detailJson
	   	},
	    error: function(request) {
	        //layer.closeAll('loading');
	        //layer.alert("保存失败，请与管理员联系！");
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
	            //layer.closeAll('loading');
	            if (!result.success) {
	                layer.alert(result.msg, {icon:2});
	                return;
	            } else {
	                layer.msg(result.msg,{time:1000,icon:1});
	                setTimeout(function(){
	                	location.href = '${ctx }/StoreSupervise.shtml';
	                },1000);
	            }
	        }
	}); */
/* }); */
var superviseYear=document.getElementById("superviseYear").value;
var superviseYear=layui.laydate.render({
    elem: '#superviseYear',
    type: 'year',
    format:"yyyy",
    done:function(value,date,endDate){
        alert("sdfsadf");
        superviseStart.config.min ={
            year:date.year,
            month:date.month-1, //关键
            date: date.date,
            hours: date.hours,
            minutes: date.minutes,
            seconds : date.seconds
        };
        if(value != null && value != ''){
            $("#superviseStart").val(date.year+1);
            $("#storeTime").val(date.year+1);
        }
    }
});
</script>


	