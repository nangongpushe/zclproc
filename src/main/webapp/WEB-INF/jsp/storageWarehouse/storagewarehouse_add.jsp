<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/AdminHeader.jsp"%>

<script src="${ctx }/plugins/colorbox/jquery.colorbox.js"></script>

<!-- <style>
	.layui-form-label{
		width:150px;
	}
</style> -->

<div class="row clear-m">
	<ol class="breadcrumb">
		<c:choose>
			<c:when test="${type eq 'dc'}">
				<li>代储管理</li>
				<li>企业信息</li>
				<li><a href="${ctx }/storageWarehouse.shtml?type=${type }">库点管理</a></li>
				<li class="active">库点管理表</li>
			</c:when>
			<c:otherwise>
				<li>仓储管理</li>
				<li><a href="${ctx }/storageWarehouse.shtml?type=${type }">库点管理</a></li>
				<li class="active">库点管理表</li>
			</c:otherwise>
		</c:choose>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
    <form class="layui-form" id="save_form">
    	<!-- hidden字段部分开始 -->
    	<input name="id" value="${warehouse.id }" hidden="hidden">
    	<input name="provinceCode" value="${warehouse.provinceCode }" hidden="hidden">
    	<input name="cityCode" value="${warehouse.cityCode }" hidden="hidden">
    	<input name="areaCode" value="${warehouse.areaCode }" hidden="hidden">
		<input name="enterpriseId" value="${warehouse.enterpriseId }" hidden="hidden">
    	<!-- hidden字段部分结束 -->
       	<c:if test="${type eq 'dc'}">
	       	<div class="layui-row layui-col-space1">
	       		<div class="layui-col-md6">
	        		<label class="layui-form-label" style="text-align:right"><span class="red">*</span>所属企业名称：</label>
	        		<div class="layui-input-inline">
						<input lay-verify="required" class="layui-input" autocomplete="off" name="enterpriseName" value = "${warehouse.enterpriseName }" 
						onclick="toAddEnterprise()" readOnly>
					</div>
	       		</div>
	       		<div class="layui-col-md6">
	        		<label class="layui-form-label" style="text-align:right"><span class="red">*</span>统一社会信用代码：</label>
	        		<div class="layui-input-inline">
						<input lay-verify="required" class="layui-input" autocomplete="off" name="socialCreditCode" value = "${warehouse.socialCreditCode }" readOnly>
					</div>
	       		</div>
	       		<%-- <div class="layui-col-md6">
	        		<label class="layui-form-label" style="text-align:right"><span class="red"></span>组织机构代码：</label>
	        		<div class="layui-input-inline">
						<input lay-verify="required" class="layui-input" autocomplete="off" name="organizationCode" value="${warehouse.organizationCode }" readOnly maxlength="10">
					</div>
	        	</div> --%>
	        </div>
		</c:if>
		
		<div class="layui-row layui-col-space1">
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点代码：</label>
        		<div class="layui-input-inline">
					<input lay-verify="required|maxLengthTen" class="layui-input" onchange="check('warehouseCode','库点代码');" id="warehouseCode" autocomplete="off" name="warehouseCode"  value = "${warehouse.warehouseCode }" maxlength="10">
				</div>
       		</div>
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称：</label>
        		<div class="layui-input-inline">
					<input lay-verify="required|maxLengthFifty" class="layui-input" onchange="check('warehouseName','库点名称');" id="warehouseName" autocomplete="off" name="warehouseName" value="${warehouse.warehouseName }" maxlength="50">
				</div>
       		</div>
		</div>
		
		<div class="layui-row layui-col-space1">
			<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点简称：</label>
        		<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required|maxLengthFifty" autocomplete="off" onchange="check('warehouseShort','库点简称');" id="warehouseShort" name="warehouseShort" value = "${warehouse.warehouseShort }" maxlength="20">
				</div>
       		</div>
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right"><c:if test="${type ne 'dc' }"><span class="red">*</span></c:if>库点企业性质：</label>
        		<div class="layui-input-inline">
					<select <c:if test="${type ne 'dc' }">lay-verify="required"</c:if> id="warehouseNature" name="warehouseNature">
						<option value="">请选择企业性质</option>
					</select>
				</div>
       		</div>
       	</div>
       	<div class="layui-row layui-col-space1">
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right">
					<span class="red">*</span>库点类别：</label>
        		<div class="layui-input-inline">
					<c:if test="${type =='dc'}">

					<input lay-verify="required|maxLengthTwenty"  class="layui-input" autocomplete="off" readonly
						   name="warehouseType" value="代储库" maxlength="20">
					</c:if>

					<c:if test="${type!='dc'}">

						<input lay-verify="required|maxLengthTwenty"  class="layui-input" autocomplete="off" readonly
							   name="warehouseType" value="储备库" maxlength="20">
						<input name="organizationCode" value="CBL" hidden="hidden">
					</c:if>

				</div>
       		</div>
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right"><c:if test="${type ne 'dc' }"><span class="red">*</span></c:if>建成日期：</label>
        		<div class="layui-input-inline">
					<input <c:if test="${type ne 'dc' }">lay-verify="required|date"</c:if> class="layui-input" autocomplete="off" name="completionDate" value="${warehouse.completionDate }" id="completionDate">
				</div>
       		</div>
		</div>
		
		<div class="layui-row layui-col-space1">
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right"><c:if test="${type ne 'dc' }"><span class="red">*</span></c:if>库点设计仓容（吨）：</label>
        		<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" oninput="clearNoNum(this,3)"  name="storageCapacity" value = "${warehouse.storageCapacity }" type="text" maxlength="13">
				</div>
       		</div>
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right"><c:if test="${type ne 'dc' }"><span class="red">*</span></c:if>库点面积（平方米）：</label>    
        		<div class="layui-input-inline">    
					<input class="layui-input" autocomplete="off" oninput="clearNoNum(this,2)"  name="acreage" value="<fmt:formatNumber type="number" pattern="0.00" value="${warehouse.acreage }" />"
					type="text" maxlength="13">
				</div>
       		</div>
		</div>
		
		<div class="layui-row layui-col-space1">
			<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right"><c:if test="${type ne 'dc' }"><span class="red">*</span></c:if>库点电话：</label>
        		<div class="layui-input-inline">
					<input <c:if test="${type ne 'dc' }">lay-verify="required|maxLengthFifty|telephone"</c:if> class="layui-input" autocomplete="off" name="telphone" value = "${warehouse.telphone }">
				</div>
       		</div>
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right">库点传真：</label>
        		<div class="layui-input-inline">
					<input lay-verify="maxLengthFifty|fax" class="layui-input" autocomplete="off" name="fax" value = "${warehouse.fax }">
				</div>
       		</div>
		</div>
		<div class="layui-row layui-col-space1">
			<div class="layui-col-md6">
        		<div class="layui-col-md12" style="width:100%">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点行政区划名称：</label>
				<div class="btn-select-parent">
				    <div id="distpicker" class="form-inline">
						<select class="form-control  pull-left change-filter" style="width: 100px" lay-verify="required" id="province" name="province"></select>
						<select class="form-control  pull-left change-filter" style="width: 100px" lay-verify="required" id="city" name="city"></select>
						<select class="form-control  pull-left change-filter" style="width: 100px"  id="district" name="area"></select>
				    </div>
				</div>
			</div>
       		</div>
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right">库点邮政编码：</label>
        		<div class="layui-input-inline">
					<input class="layui-input" lay-verify="postalcode" autocomplete="off" name="postalcode" value = "${warehouse.postalcode }" maxlength="6">
				</div>
       		</div>
		</div>
       	<div class="layui-row layui-col-space1">
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right">库点经度：</label>
        		<!-- 库点行政区划 -->
        		<div class="layui-input-inline">
					<input lay-verify="longAndLat" class="layui-input" autocomplete="off" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" name="longitude" value="${warehouse.longitude }" maxlength="20">
				</div>
       		</div>
			<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right" style="text-align:right">库点纬度：</label>
        		<div class="layui-input-inline">
					<input lay-verify="longAndLat" class="layui-input" autocomplete="off" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" name="latitude" value = "${warehouse.latitude }" maxlength="20">
				</div>
       		</div>
       	</div>
       	<div class="layui-row layui-col-space1">
       		<div class="layui-col-md6">
        		<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点地址：</label>
        		<!-- 库点行政区划 -->
        		<div class="layui-input-inline" >
					<input lay-verify="required" class="layui-input" autocomplete="off" name="address" value="${warehouse.address }" maxlength="50">
				</div>
			</div>
			<div class="layui-col-md6">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>排序号：</label>
				<div class="layui-input-inline" >
					<input type="number" lay-verify="required" class="layui-input" autocomplete="off" name="orderNo" value="${warehouse.orderNo }" oninput="if(value.length>10)value=value.slice(0,10)">
				</div>
			</div>
		</div>
		<div class="layui-row layui-col-space1">
			<c:if test="${type == 'dc' }">
			<div class="layui-col-md6">
				<label class="layui-form-label" style="text-align:right">

						<span class="red">*</span>主库：</label>
				<div class="layui-input-inline layui-form" lay-filter="isHost">
					<select  lay-verify="required" id="isHost"
							 name="isHost" lay-filter="isHost">


						<c:if test="${warehouse.isHost == 'N'}"    >
							<option selected="selected" value="N">否</option>
						</c:if>
						<c:if test="${warehouse.isHost != 'N'}"    >
							<option  value="N">否</option>
						</c:if>

						<c:if test="${warehouse.isHost == 'Y'}"    >
							<option selected="selected" value="Y">是</option>
						</c:if>
						<c:if test="${warehouse.isHost != 'Y'}"    >
							<option  value="Y">是</option>
						</c:if>
					</select>
				</div>
			</div>
			</c:if>
			<%-------------------------------jovan-----------------------------------------------------%>
			<div class="layui-col-md6">
				<label class="layui-form-label" style="text-align:right">
					<span class="red">*</span>是否停用：</label>
				<div class="layui-input-inline">
					<select  lay-verify="required" id="isStop"
							 name="isStop">
						<c:if test="${warehouse.isStop == 'N'}"    >
							<option selected="selected" value="N">否</option>
						</c:if>
						<c:if test="${warehouse.isStop != 'N'}"    >
							<option  value="N">否</option>
						</c:if>
						<c:if test="${warehouse.isStop == 'Y'}"    >
							<option selected="selected" value="Y">是</option>
						</c:if>
						<c:if test="${warehouse.isStop != 'Y'}"    >
							<option  value="Y">是</option>
						</c:if>
					</select>
				</div>
			</div>
			<%-------------------------------jovan-----------------------------------------------------%>
		</div>
		<div class="layui-row layui-col-space1">
			<div class="layui-col-md6">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点联系人：</label>
				<!-- 库点行政区划 -->
				<div class="layui-input-inline" >
					<input type="text" lay-verify="required" class="layui-input" autocomplete="off" name="creator" value="${warehouse.creator }">
				</div>
			</div>
		</div>

       	<!-- <div class="layui-col-md6">
       		<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right" style="width: 185px;" ><span class="red">*</span>库点地址：</label>
				<div class="layui-input-inline">
					<input style="width: 950px;" lay-verify="required" class="layui-input" autocomplete="off" name="address" value="${warehouse.address }" maxlength="50">
				</div>
			</div>
       	</div> -->
<%--        	<div class="layui-row layui-col-space1">
       		<div class="layui-col-md12">
       			<label class="layui-form-label"><span class="red">*</span>库点地址：</label>
       			
       			<input style="width: 500px;" lay-verify="required" class="layui-input" autocomplete="off" name="address" value="${warehouse.address }" maxlength="50">
	       		
       		</div>
       	</div> --%>
		<p name="prompt">备注：带有<span style="color: red">*</span>为必填项！</p>
		<p class="btn-box text-center">
		    <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="cancelBtn" name="cancelBtn"
		    onclick="cancelOperate('${auvp }', '${ctx}/storageWarehouse.shtml?type=${type}')">取消</button>
		    <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="submitBtn" name="submitBtn"
		    lay-submit lay-filter="submit_btn">保存</button>
		</p>	
	</form>
	   
</div>

<script src="${ctx}/js/app/storage/common.js"></script>

<script>
var WAREHOUSE_NAME = "${warehouse.warehouseName}";

layui.use(['form', 'laydate'], function(){
	var form = layui.form,
	layer = layui.layer,
	laydate = layui.laydate;
	
	//加载日历
	laydate.render({
   		elem : '#completionDate'
   	});
   	
   	/* var label = new Array(); */
    <c:forEach items="${typeList }" var="t">
    	$("#warehouseNature").append("<option value='"+ "${t.value }" +"'>" + "${t.value }" + "</option>");	
 	</c:forEach>
 	
   	//加载form
	form.render();
	
	if ('${auvp }' === 'v') {
		//console.log('${warehouse }');
 		$('input').attr('disabled','disabled');
 		$('select').attr('disabled','disabled');
           $('button[name=cancelBtn]').text('返回');//取消按钮
           $('#submitBtn').css('display','none');//保存按钮
           $('p[name=prompt]').css('display','none');//备注文字
           $("#warehouseNature option[value='${warehouse.warehouseNature }']").attr("selected", true);
           $("textarea[name=address]").val("${warehouse.address }");
           $("textarea[name=address]").attr("readOnly",true);
           //省市级联动
        $('#distpicker').distpicker({
            province: '${warehouse.province }',
            city: '${warehouse.city }',
            district: '${warehouse.area }',
            autoSelect: false
        });
        form.render('select');
 	} else if ('${auvp }' === 'u') {
       	$('#submitBtn').text('保存更改');
       	
       	$('#distpicker').distpicker({
            province: '${warehouse.province }',
            city: '${warehouse.city }',
            district: '${warehouse.area }',
            autoSelect: false
        });
        $("textarea[name=address]").val("${warehouse.address }");
        $("#warehouseNature option[value='${warehouse.warehouseNature }']").attr("selected", true);
        form.render('select');
 	} else if ('${auvp }' === 'a') {
 		$('#distpicker').distpicker({
            autoSelect: false
       	});
 	}
	
	//监听form
    form.on('submit(submit_btn)',function(){
        if (document.getElementById("city").options.length>1){
            if (document.getElementById("district").options.length>1){
                if (document.getElementById("district").value==""){
                    layerMsgError("请选择区");
                    return;
                }
            }
        }

        // 获取是否拥有主库点
        let param = {
            enterpriseId :$("input[name='enterpriseId']").val(),
            warehouseId : $("input[name='id']").val(),
        }

        $.post("${ctx}/storageWarehouse/countHostWarehouse.shtml",param,function (result) {
            let isHost = $("select[name='isHost'] option:selected").val();

            if(result.data=="0"){
                if(isHost == "N") {
                    layer.confirm('该企业下无主库点，是否将此库点设置为主库点',
                        {
                            btn: ['是', '否']
                        },
                        function (index) {
                            $("select[name='isHost']").val('Y');
                            layui.form.render("select",'isHost');
                            save();
                            layer.close(index);
                        },
                        function (index) {
                            save();
                            layer.close(index);
                        }
                    )
                } else {
                    save();
                }
            } else {
                if(isHost == "Y"){
                    layerMsgError("该企业下已存在主库点");
                    return;
                }else {
                    save();
                }
            }
        })

    });

    function save(){
        let save_form = JSON.stringify($('#save_form').serializeObject());
        $.ajax({
            type : 'POST',
            url :'${ctx }/storageWarehouse/save.shtml?auvp=${auvp }&type=${type}&ishost='+$("select[name='isHost'] option:selected").val(),
            dataType : "json",
            contentType : "application/json",
            data : save_form,
            success : function(result) {
                if(result.success) {
                    layer.msg(result.msg, {icon : 1, time : 1000}, function(){
                        location.href = '${ctx }/storageWarehouse.shtml?type=${type }';
                    });
                } else {
                    layer.msg(result.msg, {icon : 1, time : 1000});
                }
            }
        });
    }

	//表单验证
	form.verify({
   		maxLengthTen : function(value, item) {
   			return maxLengthLimit(value,item,10);
   		},
   		maxLengthFifty : function(value, item) {
   			return maxLengthLimit(value,item,50);
   		},
   		maxLengthTwenty : function(value, item) {
   			return maxLengthLimit(value,item,20);
   		},
   		storageCapacity : function(value, item) {
    		if(!/^\d{1,8}(\.\d{1,3})?$/.test(value)){
    			return $(item).parent().parent().find('label').text() + '请输入最长10位，小数位最多3位的数字';
    		}
   		},
   		acreage : function(value, item) {
    		if(!/^\d{1,8}(\.\d{1,2})?$/.test(value)) {
    			return $(item).parent().parent().find('label').text() + '请输入最长10位，小数位最多2位的数字';
    		}
   		},
   		postalcode : function(value, item) {
   			if (!/^$|(^\d{6}$)/.test(value)) {
   				return $(item).parent().parent().find('label').text() + '请输入6位数字';
   			}
   		},
   		longAndLat : function(value, item) {
   			if(isNaN(value)) {
   				return '请输入数字';
   			} else {
   				return maxLengthLimit(value,item,20);
   			}
   		},
   		fax : function(value, item) {
   			if (value!=='' && !/^(\d{3,4}-)?\d{7,8}$/.test(value)) {
   				return $(item).parent().parent().find('label').text() + "请输入正确的传真地址"
   			}
   		},
   		telephone : function(value, item) {
   			if (!/(^1[3|4|5|7|8][0-9]\d{8}$)|(^(\d{3}-?)?\d{8}$)|(^(\d{4}-?)?\d{7}$)/.test(value)) {
   				if(! /^(\d{3,4}-)?\d{7,8}$/.test(value)){
   				return $(item).parent().parent().find('label').text() + '请输入正确的电话号码';
   				}
   			}
   		},
	});
});

//弹出colorbox，选择代储企业信息
function toAddEnterprise() {
	$.colorbox({
		title : '选择代储企业信息',
		iframe : true,
		opacity	: 0.2,
		href : "${ctx}/storageWarehouse/enterpriseSelectPage.shtml",
		innerWidth : '75%',
		innerHeight : '75%',
		close : '×15151',
		fixed : false,
	});
}

//回调企业信息到form相应位置
function callAddEnterprise(data) {
	/* $("input[name='enterpriseSerial']").val(data.enterpriseSerial); */
	// debugger
	$("input[name='enterpriseName']").val(data.enterpriseName);
 	$("input[name='organizationCode']").val(data.organizationCode);
 	$("input[name='socialCreditCode']").val(data.socialCreditCode);
    $("input[name='enterpriseId']").val(data.id);
}

$("#province").siblings(".layui-unselect").remove();
$("#city").siblings(".layui-unselect").remove();
$("#district").siblings(".layui-unselect").remove();

$(".change-filter").change(function(){  
	//添加所需要执行的操作代码 
	$("input[name='provinceCode']").val($("#province").find("option:selected").attr("data-code"));
	$("input[name='cityCode']").val($("#city").find("option:selected").attr("data-code"));
	$("input[name='areaCode']").val($("#district").find("option:selected").attr("data-code"));
});
function check(value,name){
    let warehouseName = document.getElementById(value).value;
    if(warehouseName == null || warehouseName == "" || warehouseName == WAREHOUSE_NAME){
        return;
	}
	$.post("${ctx}/storageWarehouse/check.shtml?str="+value+"&value="+encodeURI(encodeURI(warehouseName)),{},	function(result) {
	if (!result.success) {
		layer.closeAll(); //疯狂模式，关闭所有层
		layer.open({
		title: '提示信息'
		,content: name+'已存在'
		}); 
		document.getElementById(value).value="";
	}
});
}
function numberFixed(obj,op){
    number = $(obj).val();
    if(number==null ||number =="" ){
        return
    }
    number = parseFloat(number).toFixed(op);
    $(obj).val(number);
}
function numberFixed1(obj,op){
    number = $(obj).val();
    if(number==null ||number =="" ){
        return
    }
    number = parseFloat(number).toFixed(op);
    $(obj).val(number);
}

function clearNoNum(obj,num) {
    //修复第一个字符是小数点 的情况.  
    if(obj.value !=''&& obj.value.substring(0,1) == '.'){
        obj.value="";
    }
    obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
    obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的       
    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
    if(num == null || num == "" ||num == 2)
    	obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
	else if(num == 3)
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d\d).*$/,'$1$2.$3');//只能输入三个小数 
    if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额  
        if(obj.value.substr(0,1) == '0' && obj.value.length == 2){
            obj.value= obj.value.substr(1,obj.value.length);
        }
    }
}
</script>
<%@include file="../common/AdminFooter.jsp"%>