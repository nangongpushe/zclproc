<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="../common/AdminHeader.jsp"%>


<div class="container-box">
  <ol class="breadcrumb">
		<%--<li>位置：</li>--%>
		<li>客户资料管理</li>
		<li class="active"><c:if test="${auvp=='a'}">
		新增
		</c:if>
		<c:if test="${auvp=='u'}">
		编辑
		</c:if>
		<c:if test="${auvp=='v'}">
		查看
		</c:if>客户资料管理</li>
	</ol>
     <form class="form_input"  action="save.shtml" method="post" lay-filter="form"  enctype="multipart/form-data">
     <input type="hidden" name="auvp" value="${auvp}">
     <input type="hidden" name="id"  value="${customerInformation.id }"/>
        <table class="table table-bordered">
            <!-- 表格内容 start -->
            <tbody>
             <tr>
                    <td class="text-right"><span class="red">*</span><b> 客户名称:</b></td>
                    <td><input maxlength="30" type="text" id="clientName" name="clientName"  value="${customerInformation.clientName }" class="form-control validate[required]" placeholder="--请输入--"/></td>
                  	<td class="text-right"><span class="red">*</span><b>客户分类:</b></td>
                    <td class="btn-select-parent">
                        <select class="form-control validate[required] " name="clientType" id="clientType">
                    		<option value="">--请选择--</option>
		                 <c:forEach items="${clientType}" var="clientType">  
		        			<option value="${clientType.value}" <c:if test="${clientType.value eq customerInformation.clientType }">selected="selected"</c:if> >${clientType.value}</option>
		   				 </c:forEach>
   					</select>
                </td>
                </tr>
               <tr>
                <td class="text-right"><span class="red">*</span><b>组织机构代码:</b></td>
                <td><input  maxlength="20" type="text" name="organizationCode" value="${customerInformation.organizationCode }" class="form-control validate[required]" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b> 企业统一社会信用代码:</b></td>
                <td>
                
                	<c:if test="${auvp=='u'}">
						<input  maxlength="18" type="text" name="socialCreditCode" id="socialCreditCode"  readOnly value="${customerInformation.socialCreditCode }" class="form-control validate[required]" placeholder="--请输入--"/>
					</c:if>
					<c:if test="${auvp!='u'}">
						<input  maxlength="18" type="text" name="socialCreditCode" id="socialCreditCode" onblur="checkIsAdd();" value="${customerInformation.socialCreditCode }" class="form-control validate[required]" placeholder="--请输入--"/>
					</c:if>
                </td>
               </tr>
               <tr>
                    <td class="text-right"><span class="red">*</span><b>企业性质:</b></td>
                    <td>
                        <select class="form-control validate[required]"  name="enterpriseNature" id="enterpriseNature">
                    		<option value="">--请选择--</option>
		                 <c:forEach items="${enterpriseNature}" var="enterpriseNature">  
		        			<option value="${enterpriseNature.value}" <c:if test="${enterpriseNature.value eq customerInformation.enterpriseNature }">selected="selected"</c:if> >${enterpriseNature.value}</option>
		   				 </c:forEach>
   					</select>
                    </td>
                    <td class="text-right"><span class="red">*</span><b>登记注册类型:</b></td>
                    <td><input  maxlength="20" type="text" name="registType" value="${customerInformation.registType }" class="form-control validate[required]" placeholder="--请输入--"/></td>
                </tr>
                 <tr>
                  	<td class="text-right"><span class="red">*</span><b>工商登记注册号:</b></td>
                    <td><input  maxlength="20" type="text" name="businessNo" value="${customerInformation.businessNo }" class="form-control validate[required]" placeholder="--请输入--"/></td>
                    <td class="text-right"><span class="red">*</span><b>是否具备代储资格:</b></td>
                    <td>
                    <select name="extraQualification" id="extraQualification" class="form-control validate[required]">
                        	<option value="是">是</option>
                            <option value="否">否</option>
                        </select>
                    </td>
                </tr>
               <tr id="distpicker">
                  	 <td class="text-right"><span class="red">*</span><b>行政区域:</b></td>
                    <td>
                    <select id="province" name="province" onclick="provinceSelect();" class="form-control validate[required]">
					    <option value="000000" style="color:#999;" disabled="disabled" >-请选择省-</option>  
					</select>
					<input type="hidden" name="provinceCode" id="provinceCode" value="${customerInformation.provinceCode}" class="form-control"/>
					</td>
					<td> 
					<select id="city" name="city" onchange="citySelect();"  class="form-control validate[required]">
					    <option value="000000" style="color:#999;" disabled="disabled" >-请选择市-</option>  
					</select> 
					<input type="hidden" name="cityCode" id="cityCode" value="${customerInformation.cityCode}" class="form-control"/>
					</td> 
					<td>
					<select id="area" name="area"  class="form-control validate[required]" onchange="areaSelect();" >
					    <option value="000000" style="color:#999;" disabled="disabled">-请选区-</option>  
					</select>
					<input type="hidden" name="areaCode" id="areaCode" value="${customerInformation.areaCode}" class="form-control"/>
                    </td>
                </tr>
               <tr>
               		<td class="text-right"><span class="red">*</span><b>企业邮政编码:</b></td>
                    <td><input  maxlength="6" type="text" id="postalcode" name="postalcode" value="${customerInformation.postalcode }" class="form-control validate[required]" placeholder="--请输入--"/></td>
                  	<td class="text-right"><span class="red">*</span><b>法定代表人:</b></td>
                    <td><input  maxlength="10" type="text" name="personIncharge" value="${customerInformation.personIncharge }" class="form-control validate[required]" placeholder="--请输入--"/></td>
                
               </tr>
              <tr>
                    <td class="text-right"><span class="red">*</span><b>联系人:</b></td>
                    <td><input  maxlength="10" type="text" name="contactor" value="${customerInformation.contactor }" class="form-control validate[required]" placeholder="--请输入--"/></td>
                  	<td class="text-right"><span class="red">*</span><b>联系电话:</b></td>
                    <td><input  maxlength="11" type="text"  id="contactTel" name="contactTel" value="${customerInformation.contactTel }" class="form-control validate[required]" placeholder="--请输入--"/></td>
                </tr>
              <tr>
                    <td class="text-right"><span class="red"></span><b>企业传真:</b></td>
                    <td><input  maxlength="11" type="text" name="contactFax" value="${customerInformation.contactFax }" class="form-control " placeholder="--请输入--"/></td>
                    <td class="text-right"><span class="red">*</span><b>从事行业:</b></td>
                    <td class="btn-select-parent">
                        <select  class="form-control validate[required]"  name="industry" id="industry" onchange="show()">
                    		<option value="">--请选择--</option>
		                 <c:forEach items="${industry}" var="industry">  
		        			<option value="${industry.value}" <c:if test="${industry.value eq customerInformation.industry }">selected="selected"</c:if> >${industry.value}</option>
		   				 </c:forEach>
   					</select>
                </td>
               </tr>
              <tr id="tr_id" >
                    <td class="text-right" ><span class="red">*</span><b>加工品种:</b></td>
                    <td><input maxlength="100" type="text" name="processVariety" id="processVariety" value="${customerInformation.processVariety }"  placeholder="--请输入--"/></td>
                  	<td class="text-right"><span class="red">*</span><b>加工能力:</b></td>
                    <td><input maxlength="50" type="text" name="processCapability" id="processCapability" value="${customerInformation.processCapability }"  placeholder="--请输入--"/></td>
                </tr>
               
               <tr>
                    <td class="text-right"><span class="red"></span><b>发票抬头:</b></td>
                    <td><input maxlength="20" type="text" name="invoiceTitle" value="${customerInformation.invoiceTitle }" class="form-control " placeholder="--请输入--"/></td>
                    <td class="text-right"><span class="red"></span><b>发票税号:</b></td>
                    <td><input maxlength="20" type="text" name="taxId" value="${customerInformation.taxId }" class="form-control " placeholder="--请输入--"/></td>
               </tr>
               <tr>
                  	<td class="text-right"><span class="red"></span><b>开户行:</b></td>
                    <td><input maxlength="50" type="text" name=depositBank value="${customerInformation.depositBank }" class="form-control" placeholder="--请输入--"/></td>
                    <td class="text-right"><span class="red"></span><b>开户账号:</b></td>
                    <td><input maxlength="50" type="text" name="depositAccount" value="${customerInformation.depositAccount }" class="form-control " placeholder="--请输入--"/></td>
               
               </tr>
                <tr>
                  	<td class="text-right"><span class="red">*</span><b>企业电话:</b></td>
                    <td><input maxlength="20" type="text" id="telephone" name="telephone" value="${customerInformation.telephone }" class="form-control validate[required]" placeholder="--请输入--"/></td>
                    <td class="text-right"><span class="red">*</span><b>企业地址:</b></td>
                    <td><input maxlength="50" type="text" name="address" value="${customerInformation.address }" class="form-control validate[required]" placeholder="--请输入--"/></td>
                </tr>
               <tr>
                    
                  	<td class="text-right"><span class="red"></span><b>银行信用等级:</b></td>
                  	<td>
                  		 
                        <select  class="form-control "  name="bankCreditRating" id="bankCreditRating">
                    		<option value="">--请选择--</option>
		                 <c:forEach items="${bankCreditRating}" var="bankCreditRating">  
		        			<option value="${bankCreditRating.value}" <c:if test="${bankCreditRating.value eq customerInformation.bankCreditRating }">selected="selected"</c:if> >${bankCreditRating.value}</option>
		   				 </c:forEach>
   					</select>
                  	</td>
                  	<td class="text-right"><span class="red"></span><b>固定资产(万元):</b></td>
                    <td><input  type="text"  maxlength="8" id="fixedAssets" name="fixedAssets" value="${customerInformation.fixedAssets }" class="form-control" placeholder="--请输入--" step="0.01" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0"/></td>
                </tr>
               
               <tr>
                  	<td class="text-right"><span class="red"></span><b>注册资本:</b></td>
                    <td><input maxlength="8" type="text" step="0.01" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" name="registeredCapital" value="${customerInformation.registeredCapital }" class="form-control" placeholder="--请输入--"/></td>
                  	<td class="text-right"><span class="red"></span><b>从业人员数:</b></td>
                    <td><input maxlength="5"  name="employedNum" value="${customerInformation.employedNum }" class="form-control" placeholder="--请输入--"  onkeyup="this.value=this.value.replace(/\D|^0/g,'')" /></td>
                </tr>
             <tr>
                 <td class="text-right"><span class="red">*</span><b>身份证号码:</b></td>
                 <td><input type="text"  name="idCard" value="${customerInformation.idCard }" class="form-control validate[required]" placeholder="--请输入--"/></td>
             </tr>
                 
               <tr>
                    <td class="text-right"><span>&nbsp;&nbsp;</span><b>备注:</b></td>
                    <td colspan="3"><textarea style="word-break:break-all;word-wrap: break-word;" rows="4" name="remark" class="form-control" placeholder="--请输入--" maxlength="500">${customerInformation.remark }</textarea></td>
                </tr>
                </tbody>
                <!-- 表格内容 end -->
            </table>
        
        <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
            <button type="button" id="btnSave" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
        </p>
  
</div>
    </form>
    <div class="jumpPage" id="displayPage"></div>
</div>


<script>

function checkIsAdd(){
var socialCreditCode=$("#socialCreditCode").val();
$("#btnSave").attr("disabled",false);

	$.ajax({
                type: "POST",
                url: "${ctx}/CustomerInformation/checkIsAdd.shtml", //请求地址
                data: {"socialCreditCode": socialCreditCode}, //参数列表
                datatype: "json", //返回数据的格式
                success: function (data) {

                    if (data>0) {
                        var auvp = '${auvp}';
                        if (auvp!='v'){
                            alert("该企业统一社会信用代码已存在，不能重复添加！");
                        }
                      $("#btnSave").attr("disabled",true);
                      
                      $("#socialCreditCode").focus();
                      return false;
                    }else{
                    	 $("#btnSave").attr("disabled",false);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
              
                    alert("校验异常，请联系系统管理员！");
                }
            });
}


$(function(){
    //根据客户类型控制必填非必填
    changeRequired();

	var industry= document.getElementById("industry").value; 
	if(industry=="加工类"){ 
	document.getElementById("processVariety").setAttribute("class","form-control validate[required]");
	document.getElementById("processCapability").setAttribute("class","form-control validate[required]");
	$("#tr_id").show();
	}else{
	$("#tr_id").hide(); 
	} 
	var auvp = '${auvp}';
	if(auvp=='v'){$("#cancel").text("返回");}else{$("#cancel").text("取消");}
	document.getElementById("extraQualification").value='${customerInformation.extraQualification }';
	document.getElementById("clientType").value='${customerInformation.clientType }';
	document.getElementById("industry").value='${customerInformation.industry }';
	document.getElementById("enterpriseNature").value='${customerInformation.enterpriseNature }';
	document.getElementById("extraQualification").value='${customerInformation.extraQualification }';
	if(auvp=='v'){
	$("#btnSave").attr({"disabled":"disabled"});
	//下拉框禁用
	$("select").each(function () {$("#" + this.id).attr("disabled", true);});
		$("form").find("input,textarea,select").prop("readonly", true);
		$('#btnSave').hide();
	}else if(auvp='u'){
		$('#id').prop("readonly", true);
	}
	$('#distpicker').distpicker({
	            province: '${customerInformation.province }',
	            city: '${customerInformation.city }',
	            district: '${customerInformation.area }',
	            autoSelect: false
	  });
    layui.use(['form'], function(){
        form = layui.form;
        form.render('select');
    })

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
 function show(){
 var industry= document.getElementById("industry").value; 
	if(industry=="加工类"){ 
	document.getElementById("processVariety").setAttribute("class","form-control validate[required]");
	document.getElementById("processCapability").setAttribute("class","form-control validate[required]");
	$("#tr_id").show();
	}else{
	$("#tr_id").hide(); 
	} 
 }


function ValidatePhone(val){
    var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;//手机号码
    var isMob= /^0?1[3|4|5|8][0-9]\d{8}$/;// 座机格式
    if(isMob.test(val)||isPhone.test(val)){
        return true;
    }
    else{
        return false;
    }
}



   $("#btnSave").click(function(){
   

		if($(".form_input").validationEngine('validate')==true){
            if($("#postalcode").val() != null && $("#postalcode").val() != ''){
                if(!(/^[1-9][0-9]{5}$/.test($("#postalcode").val()))){
                    alert('邮政编码格式不正确');
                    return;
                }
            }
            if (ValidatePhone($("#contactTel").val()) == false) {

                alert('联系电话格式不正确');
                return;
            }
            if($("#telephone").val() != null && $("#telephone").val() != '') {
                if (ValidatePhone($("#telephone").val()) == false) {
                    alert('企业电话格式错误');
                    return;
                }
            }
            if($("#fixedAssets").val() != null && $("#fixedAssets").val() != '') {
                if (!(/^([1-9][0-9]*)+(.[0-9]{1,2})?$/.test($("#fixedAssets").val()))) {
                    alert('固定资产只能填写大于0数字');
                    return;
                }
            }

			$(".form_input").ajaxSubmit({
			type:"post",
			success:function(data){
				if(data.success){
				alert("保存成功"); 
				location.href="${ctx}/CustomerInformation.shtml";
				}else{
				alert("保存失败"); 
				}
			}
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
	function provinceSelect(){
		var code = $("#province").find("option:selected").attr("data-code");
		document.getElementById("provinceCode").value=code;
	}
	function citySelect(){
		var code = $("#city").find("option:selected").attr("data-code");
		document.getElementById("cityCode").value=code;
	}
	function areaSelect(){
		var code = $("#area").find("option:selected").attr("data-code");
		document.getElementById("areaCode").value=code;
	}
	$('#clientType').change(function(){
        changeRequired();
    })

    function changeRequired() {
        if('个人客户' == $('#clientType').val()){
            //组织机构代码
            $('input[name="organizationCode"]').removeClass('validate[required]');
            $('input[name="organizationCode"]').parent().prev().find('.red').hide();
            //企业统一社会信用代码

            $('input[name="socialCreditCode"]').removeClass('validate[required]');
            $('input[name="socialCreditCode"]').parent().prev().find('.red').hide();
            //登记注册类型

            $('input[name="registType"]').removeClass('validate[required]');
            $('input[name="registType"]').parent().prev().find('.red').hide();
            //企业性质

            $('select[name="enterpriseNature"]').removeClass('validate[required]');
            $('select[name="enterpriseNature"]').parent().prev().find('.red').hide();
            //工商登记注册号

            $('input[name="businessNo"]').removeClass('validate[required]');
            $('input[name="businessNo"]').parent().prev().find('.red').hide();
            //是否具备代储资格

            $('select[name="extraQualification"]').removeClass('validate[required]');
            $('select[name="extraQualification"]').parent().prev().find('.red').hide();
            //行政区域

            $('select[name="province"]').removeClass('validate[required]');
            $('select[name="province"]').parent().prev().find('.red').hide();

            $('select[name="city"]').removeClass('validate[required]');

            $('select[name="area"]').removeClass('validate[required]');
            //企业邮政编码

            $('input[name="postalcode"]').removeClass('validate[required]');
            $('input[name="postalcode"]').parent().prev().find('.red').hide();
            //法定代表人

            $('input[name="personIncharge"]').removeClass('validate[required]');
            $('input[name="personIncharge"]').parent().prev().find('.red').hide();
            //企业电话

            $('input[name="telephone"]').removeClass('validate[required]');
            $('input[name="telephone"]').parent().prev().find('.red').hide();
            //企业地址

            $('input[name="address"]').removeClass('validate[required]');
            $('input[name="address"]').parent().prev().find('.red').hide();
            //从事行业

            $('select[name="industry"]').removeClass('validate[required]');
            $('select[name="industry"]').parent().prev().find('.red').hide();

            //身份证号为必填
            if($('input[name="idCard"]').hasClass('validate[required]')){

            }else{
                $('input[name="idCard"]').addClass('validate[required]');
                $('input[name="idCard"]').parent().prev().find('.red').show()
            }
        }else{
            if($('input[name="organizationCode"]').hasClass('validate[required]')){

            }else{
                $('input[name="organizationCode"]').addClass('validate[required]');
                $('input[name="organizationCode"]').parent().prev().find('.red').show()
            }
            //企业统一社会信用代码
            if($('input[name="socialCreditCode"]').hasClass('validate[required]')){

            }else {
                $('input[name="socialCreditCode"]').addClass('validate[required]');
                $('input[name="socialCreditCode"]').parent().prev().find('.red').show();
            }
            //登记注册类型
            if($('input[name="registType"]').hasClass('validate[required]')){

            }else {
                $('input[name="registType"]').addClass('validate[required]');
                $('input[name="registType"]').parent().prev().find('.red').show();
            }
            //企业性质
            if($('select[name="enterpriseNature"]').hasClass('validate[required]')){

            }else {
                $('select[name="enterpriseNature"]').addClass('validate[required]');
                $('select[name="enterpriseNature"]').parent().prev().find('.red').show();
            }
            //工商登记注册号
            if($('input[name="businessNo"]').hasClass('validate[required]')){

            }else {
                $('input[name="businessNo"]').addClass('validate[required]');
                $('input[name="businessNo"]').parent().prev().find('.red').show();
            }
            //是否具备代储资格
            if($('select[name="extraQualification"]').hasClass('validate[required]')){

            }else {
                $('select[name="extraQualification"]').addClass('validate[required]');
                $('select[name="extraQualification"]').parent().prev().find('.red').show();
            }
            //行政区域
            if($('select[name="province"]').hasClass('validate[required]')){

            }else {
                $('select[name="province"]').addClass('validate[required]');
                $('select[name="province"]').parent().prev().find('.red').show();
            }
            if($('select[name="city"]').hasClass('validate[required]')){

            }else {
                $('select[name="city"]').addClass('validate[required]');
            }
            if($('select[name="area"]').hasClass('validate[required]')){

            }else {
                $('select[name="area"]').addClass('validate[required]');
            }
            //企业邮政编码
            if($('input[name="postalcode"]').hasClass('validate[required]')){

            }else {
                $('input[name="postalcode"]').addClass('validate[required]');
                $('input[name="postalcode"]').parent().prev().find('.red').show();
            }
            //法定代表人
            if($('input[name="personIncharge"]').hasClass('validate[required]')){

            }else {
                $('input[name="personIncharge"]').addClass('validate[required]');
                $('input[name="personIncharge"]').parent().prev().find('.red').show();
            }
            //企业电话
            if($('input[name="telephone"]').hasClass('validate[required]')){

            }else {
                $('input[name="telephone"]').addClass('validate[required]');
                $('input[name="telephone"]').parent().prev().find('.red').show();
            }
            //企业地址
            if($('input[name="address"]').hasClass('validate[required]')){

            }else {
                $('input[name="address"]').addClass('validate[required]');
                $('input[name="address"]').parent().prev().find('.red').show();
            }
            //从事行业
            if($('select[name="industry"]').hasClass('validate[required]')){

            }else {
                $('select[name="industry"]').addClass('validate[required]');
                $('select[name="industry"]').parent().prev().find('.red').show();
            }
            //身份证号为非必填
            $('input[name="idCard"]').removeClass('validate[required]');
            $('input[name="idCard"]').parent().prev().find('.red').hide();
        }
    }
/*layui.use(['form'], function() {
     form = layui.form;
    $('#distpicker').distpicker({
        province: '${customerInformation.province }',
        city: '${customerInformation.city }',
        district: '${customerInformation.area }',
        autoSelect: false
    });
})*/
</script>
