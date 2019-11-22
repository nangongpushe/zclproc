<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">
.layui-inline{
	width: 31% ;
}
.layui-form-item .layui-form-label{
    width: 30% ;
}

.layui-form-item .layui-input-inline{
  width: 60% ;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>代储监管</li>
		<li>企业信息</li>
		<li class="active">企业基本信息</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
   <div id="formdemo">
       <div class="layui-row">
			<div class="layui-col-md6">
			<span>代储企业编号:</span> <span data-field="department">${storeEnterprise.enterpriseSerial}</span>
			</div>
			<div class="layui-col-md6">
			<span>企业名称:</span> <span data-field="department">${storeEnterprise.enterpriseName}</span>	
			</div>
	   </div>
	   	   
	    <div class="layui-row">
			<div class="layui-col-md6">
			<span>企业简称:</span> <span data-field="department">${storeEnterprise.shortName}</span>
			</div>
			<div class="layui-col-md6">
			<span>企业行政区划:</span> <span data-field="department">${storeEnterprise.province}${storeEnterprise.city}${storeEnterprise.area}</span>
			</div>
			<%-- <div class="layui-col-md6">
			<span>组织机构代码:</span> <span data-field="department">${storeEnterprise.organizationCode}</span>	
			</div> --%>
	   </div>
	   
	    <div class="layui-row">
			<div class="layui-col-md6">
			<span>企业统一社会信用代码:</span> <span data-field="department">${storeEnterprise.socialCreditCode}</span>
			</div>
			<div class="layui-col-md6">
			<span>登记注册类型:</span> <span data-field="department">${storeEnterprise.registType}</span>	
			</div>
	   </div>
	   
	    <div class="layui-row">
			<div class="layui-col-md6">
			<span>企业经济类型:</span> <span data-field="department">${storeEnterprise.economicType}</span>
			</div>
			<div class="layui-col-md6">
			<span>是否具备中央储备粮代储资格:</span> <span data-field="department">${storeEnterprise.seniority}</span>	
			</div>
	   </div>
	   
	    
    
      <div class="layui-row">
			<div class="layui-col-md6">
			<span>法定代表人:</span> <span data-field="department">${storeEnterprise.personIncharge}</span>
			</div>
			<div class="layui-col-md6">
			<span>企业地址:</span> <span data-field="department">${storeEnterprise.address}</span>	
			</div>
	   </div>
	   
	   <div class="layui-row">
			<div class="layui-col-md6">
			<span>企业电话:</span> <span data-field="department">${storeEnterprise.telephone}</span>
			</div>
			<div class="layui-col-md6">
			<span>企业传真:</span> <span data-field="department">${storeEnterprise.fax}</span>	
			</div>
	   </div>
	   
	   <div class="layui-row">
			<div class="layui-col-md6">
			<span>企业电子邮箱:</span> <span data-field="department">${storeEnterprise.email}</span>
			</div>
			<div class="layui-col-md6">
			<span>企业网址:</span> <span data-field="department">${storeEnterprise.website}</span>	
			</div>
	   </div>
	   
	    <div class="layui-row">
			<div class="layui-col-md6">
			<span>企业邮政编码:</span> <span data-field="department">${storeEnterprise.postalcode}</span>
			</div>
			<div class="layui-col-md6">
			<span>开户银行:</span> <span data-field="department">${storeEnterprise.depositBank}</span>	
			</div>
	   </div>
	   
	    <div class="layui-row">
			<div class="layui-col-md6">
			<span>银行信用等级:</span> <span data-field="department">${storeEnterprise.bankCreditRating}</span>
			</div>
			<div class="layui-col-md6">
			<span>银行账户:</span> <span data-field="department">${storeEnterprise.depositAccount}</span>	
			</div>
	   </div>
	   
	    <div class="layui-row">
			<div class="layui-col-md6">
			<span>固定资产（万元）:</span> <span data-field="department">${storeEnterprise.fixedAssets}</span>
			</div>
			<div class="layui-col-md6">
			<span>注册资本（万元）:</span> <span data-field="department">${storeEnterprise.registeredCapital}</span>	
			</div>
	   </div>
	   
	     <div class="layui-row">
			<div class="layui-col-md6">
			<span>资产（万元）:</span> <span data-field="department">${storeEnterprise.assets}</span>
			</div>
			<div class="layui-col-md6">
			<span>企业从业人数（人）:</span> <span data-field="department">${storeEnterprise.people}</span>	
			</div>
	   </div>
	   <div class="layui-row">
		   <div class="layui-col-md6">
			   <span>联系人:</span> <span data-field="department">${storeEnterprise.contacts}</span>
		   </div>
		   <div class="layui-col-md6">
			   <span>联系电话:</span> <span data-field="department">${storeEnterprise.contactNumber}</span>
		   </div>
	   </div>
	   <div class="layui-row">
		   <div class="layui-col-md6">
			   <span>是否停用:</span> <span data-field="department">
			    <c:if test="${storeEnterprise.isStop == 'Y'}"    >
					是
				</c:if>
			    <c:if test="${storeEnterprise.isStop == 'N'}"    >
					否
				</c:if>
		   </span>
		   </div>
		   <div class="layui-col-md6">
			   <span>是否输入框:</span> <span data-field="department">
			    <c:if test="${storeEnterprise.isInput == '1'}"    >
					是
				</c:if>
			    <c:if test="${storeEnterprise.isInput == '0'}"    >
					否
				</c:if>
		   </span>
		   </div>
	   </div>
	 </div>
			
    <p class="btn-box text-center">
    	<a type="button"  class="layui-btn layui-btn-primary layui-btn-small reback">返回</a>
        
            
      </p>

</div>
<script src="${ctx }/js/cities.data.js"></script>
<script>

//省市级联动
		/* $('#distpicker').distpicker({
		 
		}); */
	var form = layui.form;
	form.render();

	$("input").attr("readOnly","true");
 	$("textarea").attr("readOnly","true");	
/* 	$("input").css("border-style","none");
 	$("textarea").css("border-style","none"); */
	
	 $(".reback").click(function(){
			history.go(-1);
		
	});
	
	
</script>


