<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">


	.layui-inline{
		width: 45% ;
	}
	.layui-form-item .layui-form-label{
		width: 30% ;
		max-width:130px;
	}

	.layui-form-item .layui-input-inline{
		width: 65% ;
	}
	.layui-form-item {
		margin-bottom: 1px;
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

	<form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
		<input type="hidden" name="id"  value="${storeEnterprise.id}"/>
		<input type="hidden" class="province"  value="${storeEnterprise.province}"/>
		<input type="hidden" class="city"  value="${storeEnterprise.city}"/>
		<input type="hidden" class="area"  value="${storeEnterprise.area}"/>

		<input type="hidden" id="provinceCode" name="provinceCode"  value="${storeEnterprise.provinceCode}"/>
		<input type="hidden" id="cityCode" name="cityCode"  value="${storeEnterprise.cityCode}"/>
		<input type="hidden" id="areaCode" name="areaCode"  value="${storeEnterprise.areaCode}"/>

		<div class="layui-form" id="search" >
			<div class="layui-form-item">

				<div class="layui-inline ">
					<label class="layui-form-label "  style="text-align:right"><span class="red">*</span>代储企业编号：</label>
					<div class="layui-input-inline ">
						<input type="text" lay-verify="required" class="layui-input"  value="${storeEnterprise.enterpriseSerial}" maxlength="10" name="enterpriseSerial" id="enterpriseSerial" autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业名称：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required"  maxlength="50"  value="${storeEnterprise.enterpriseName}" class="layui-input" name="enterpriseName" id="enterpriseName"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业简称：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required" maxlength="10" value="${storeEnterprise.shortName}" class="layui-input" name="shortName" id="shortName"
							   autocomplete="off">
					</div>
				</div>



				<%-- <div class="layui-inline ">
                    <label class="layui-form-label " ><span class="red">*</span>组织机构代码:</label>
                    <div class="layui-input-inline ">
                        <input type="text" lay-verify="required" maxlength="25" value="${storeEnterprise.organizationCode}" class="layui-input" name="organizationCode" id="organizationCode" autocomplete="off">
                    </div>
                </div> --%>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业统一社会信用代码：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required|socialCreditCode" class="layui-input" value="${storeEnterprise.socialCreditCode}"  maxlength="18" name="socialCreditCode" id="socialCreditCode"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>登记注册类型：</label>
					<div class="layui-input-inline">
						<!-- <div class="layui-inline" style="width: 170px"> -->
						<select class="layui-input" lay-verify="required"  name="registType" maxlength="16" lay-filter="aihao"
								id="registType">
							<option></option>
							<c:if test="${storeEnterprise.registType == '有限责任公司'}"    >
								<option selected="selected" value="有限责任公司">有限责任公司</option>
							</c:if>
							<c:if test="${storeEnterprise.registType != '有限责任公司'}"    >
								<option  value="有限责任公司">有限责任公司</option>
							</c:if>
							<c:if test="${storeEnterprise.registType == '股份有限公司'}"    >
								<option selected="selected" value="股份有限公司">股份有限公司</option>
							</c:if>
							<c:if test="${storeEnterprise.registType != '股份有限公司'}"    >
								<option  value="股份有限公司">股份有限公司</option>
							</c:if>
							<c:if test="${storeEnterprise.registType == '非公司企业法人'}"    >
								<option selected="selected" value="非公司企业法人">非公司企业法人</option>
							</c:if>
							<c:if test="${storeEnterprise.registType != '非公司企业法人'}"    >
								<option  value="非公司企业法人">非公司企业法人</option>
							</c:if>
							<c:if test="${storeEnterprise.registType == '个人独资企业'}"    >
								<option selected="selected" value="个人独资企业">个人独资企业</option>
							</c:if>
							<c:if test="${storeEnterprise.registType != '个人独资企业'}"    >
								<option  value="个人独资企业">个人独资企业</option>
							</c:if>
							<c:if test="${storeEnterprise.registType == '合伙企业'}"    >
								<option selected="selected" value="合伙企业">合伙企业</option>
							</c:if>
							<c:if test="${storeEnterprise.registType != '合伙企业'}"    >
								<option  value="合伙企业">合伙企业</option>
							</c:if>
							<c:if test="${storeEnterprise.registType == '中外合作企业'}"    >
								<option selected="selected" value="中外合作企业">中外合作企业</option>
							</c:if>
							<c:if test="${storeEnterprise.registType != '中外合作企业'}"    >
								<option  value="中外合作企业">中外合作企业</option>
							</c:if>
							<c:if test="${storeEnterprise.registType == '合营企业'}"    >
								<option selected="selected" value="合营企业">合营企业</option>
							</c:if>
							<c:if test="${storeEnterprise.registType != '合营企业'}"    >
								<option  value="合营企业">合营企业</option>
							</c:if>
							<c:if test="${storeEnterprise.registType == '外商独资企业'}"    >
								<option selected="selected" value="外商独资企业">外商独资企业</option>
							</c:if>
							<c:if test="${storeEnterprise.registType != '外商独资企业'}"    >
								<option  value="外商独资企业">外商独资企业</option>
							</c:if>

						</select>
						<!-- </div> -->
					</div>
				</div>



				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业经济类型：</label>
					<div class="layui-input-inline">
						<!-- <div class="layui-inline" style="width: 170px"> -->
						<select class="layui-input" lay-verify="required"  name="economicType" maxlength="18" lay-filter="aihao"
								id="economicType">
							<option></option>

							<c:if test="${storeEnterprise.economicType == '国有经济'}"    >
								<option selected="selected" value="国有经济">国有经济</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType != '国有经济'}"    >
								<option  value="国有经济">国有经济</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType == '集体经济'}"    >
								<option selected="selected" value="集体经济">集体经济</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType != '集体经济'}"    >
								<option  value="集体经济">集体经济</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType == '私营经济'}"    >
								<option selected="selected" value="私营经济">私营经济</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType != '私营经济'}"    >
								<option  value="私营经济">私营经济</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType == '个体经济'}"    >
								<option selected="selected" value="个体经济">个体经济</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType != '个体经济'}"    >
								<option  value="个体经济">个体经济</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType == '联营经济'}"    >
								<option selected="selected" value="联营经济">联营经济</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType != '联营经济'}"    >
								<option  value="联营经济">联营经济</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType == '股份制'}"    >
								<option selected="selected" value="股份制">股份制</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType != '股份制'}"    >
								<option  value="股份制">股份制</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType == '外商投资'}"    >
								<option selected="selected" value="外商投资">外商投资</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType != '外商投资'}"    >
								<option  value="外商投资">外商投资</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType == '港澳台投资'}"    >
								<option selected="selected" value="港澳台投资">港澳台投资</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType != '港澳台投资'}"    >
								<option  value="港澳台投资">港澳台投资</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType == '其他经济类'}"    >
								<option selected="selected" value="其他经济类">其他经济类</option>
							</c:if>
							<c:if test="${storeEnterprise.economicType != '其他经济类'}"    >
								<option  value="其他经济类">其他经济类</option>
							</c:if>

						</select>
						<!-- </div> -->
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>是否具备中央储备粮代储资格：</label>
					<div class="layui-input-inline">
						<!-- <div class="layui-inline" style="width: 170px"> -->
						<select class="layui-input" lay-verify="required"  name="seniority" lay-filter="aihao"
								id="seniority">


							<c:if test="${storeEnterprise.seniority == '是'}"    >
								<option selected="selected" value="是">是</option>
							</c:if>
							<c:if test="${storeEnterprise.seniority != '是'}"    >
								<option  value="是">是</option>
							</c:if>
							<c:if test="${storeEnterprise.seniority == '否'}"    >
								<option selected="selected" value="否">否</option>
							</c:if>
							<c:if test="${storeEnterprise.seniority != '否'}"    >
								<option  value="否">否</option>
							</c:if>

						</select>
						<!-- </div> -->
					</div>
				</div>

				<%-- <div class="layui-inline ">
                    <label class="layui-form-label"><span class="red">*</span>工商登记注册号:</label>
                    <div class="layui-input-inline">
                        <input type="text" lay-verify="required" class="layui-input" value="${storeEnterprise.businessNo}"  maxlength="13" name="businessNo" id="businessNo"
                            autocomplete="off">
                    </div>
                </div> --%>





				<div class="layui-inline" >

					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业行政区划：</label>
					<div class="btn-select-parent">
						<div id="distpicker" class="form-inline">
							<div>
								<label class="sr-only" for="province">Province</label>
								<select class="form-control  pull-left" style="width: 22%" lay-verify="customProvince" name="province" id="province"></select>
							</div>
							<div>
								<label class="sr-only" for="city">City</label>
								<select class="form-control  pull-left" style="width: 22%" name="city" lay-verify="customProvince" id="city"></select>
							</div>
							<div>
								<label class="sr-only" for="district">District</label>
								<select class="form-control  pull-left" style="width: 22%" name="area"  id="district"></select>
							</div>
						</div>
					</div>
				</div>



				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>法定代表人：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required" class="layui-input" value="${storeEnterprise.personIncharge}" maxlength="10" name="personIncharge" id="personIncharge"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业地址：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required" class="layui-input" value="${storeEnterprise.address}" maxlength="50" name="address" id="address"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业电话：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required|customPhone" class="layui-input" value="${storeEnterprise.telephone}" maxlength="50" name="telephone" id="telephone"
							   autocomplete="off">
					</div>
				</div>




				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>企业传真：</label>
					<div class="layui-input-inline">
						<input type="text"  class="layui-input" value="${storeEnterprise.fax}" maxlength="50"  name="fax" id="fax"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>企业电子邮箱：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="customEmail" class="layui-input" value="${storeEnterprise.email}" name="email"  maxlength="50"  id="email"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>企业网址：</label>
					<div class="layui-input-inline">
						<input type="text"   lay-verify="customUrl" class="layui-input" value="${storeEnterprise.website}" maxlength="50" name="website" id="website"
							   autocomplete="off">
					</div>
				</div>


				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>企业邮政编码：</label>
					<div class="layui-input-inline">
						<input type="text"  lay-verify="customCode"  class="layui-input" value="${storeEnterprise.postalcode}" maxlength="12" name="postalcode" id="postalcode"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>开户银行：</label>

					<div class="layui-input-inline">
						<input type="text"  value="${storeEnterprise.depositBank}" class="layui-input" maxlength="12" name="depositBank" id="depositBank"
							   autocomplete="off">

					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right">银行信用等级：</label>
					<div class="layui-input-inline">
						<!-- <div class="layui-inline" style="width: 170px"> -->
						<select class="layui-input" name="bankCreditRating" lay-filter="aihao"
								id="bankCreditRating">

							<option></option>
							<c:forEach var="item" items="${bankCreditRatings}">
								<c:if test="${storeEnterprise.bankCreditRating == item.value}">
									<option selected="selected" value="${item.value}">${item.value }</option>
								</c:if>
								<c:if test="${storeEnterprise.bankCreditRating != item.value}">
									<option  value="${item.value}">${item.value }</option>
								</c:if>
							</c:forEach>


						</select>

					</div>
				</div>


				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>银行账户：</label>
					<div class="layui-input-inline">
						<input type="text"  class="layui-input" lay-verify="customCardPhone" name="depositAccount" value="${storeEnterprise.depositAccount}" maxlength="19" id="depositAccount"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>固定资产（万元）：</label>
					<div class="layui-input-inline">
						<input type="number"  class="layui-input" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" onchange = "numberFixed(this,4)" lay-verify="customIntegerNumberTwo" value="${storeEnterprise.fixedAssets}" name="fixedAssets" id="fixedAssets"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>注册资本（万元）：</label>
					<div class="layui-input-inline">
						<input type="number"  class="layui-input" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" onchange = "numberFixed(this,4)" lay-verify="customIntegerNumberTwo" value="${storeEnterprise.registeredCapital}" name="registeredCapital" id="registeredCapital"
							   autocomplete="off">
					</div>
				</div>


				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>资产（万元）：</label>
					<div class="layui-input-inline">
						<input type="number"  class="layui-input" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" onchange = "numberFixed(this,4)" lay-verify="customIntegerNumberTwo" value="${storeEnterprise.assets}" name="assets" id="assets"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>企业从业人数（人）：</label>
					<div class="layui-input-inline">
						<input type="text"  class="layui-input" maxlength="15" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0"  lay-verify="customIntegerNumber" value="${storeEnterprise.people}" name="people" id="people"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right">联系人：</label>
					<div class="layui-input-inline">
						<input type="text"  class="layui-input" maxlength="50" lay-verify="layui-input" name="contacts" value="${storeEnterprise.contacts}" id="contacts"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right">联系人电话：</label>
					<div class="layui-input-inline">
						<input type="text"  class="layui-input" maxlength="50" lay-verify="layui-input|customPhone1" name="contactNumber" value="${storeEnterprise.contactNumber}" id="contactNumber"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>
						是否停用：</label>
					<div class="layui-input-inline">
						<!-- <div class="layui-inline" style="width: 170px"> -->
						<select class="layui-input" lay-verify="required"  name="isStop" lay-filter="aihao"
								id="isStop">


							<c:if test="${storeEnterprise.isStop == 'Y'}"    >
								<option selected="selected" value="Y">是</option>
							</c:if>
							<c:if test="${storeEnterprise.isStop != 'Y'}"    >
								<option  value="Y">是</option>
							</c:if>
							<c:if test="${storeEnterprise.isStop == 'N'}"    >
								<option selected="selected" value="N">否</option>
							</c:if>
							<c:if test="${storeEnterprise.isStop != 'N'}"    >
								<option  value="N">否</option>
							</c:if>

						</select>
						<!-- </div> -->
					</div>
				</div>

				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>
						是否动态轮换：</label>
					<div class="layui-input-inline">
						<!-- <div class="layui-inline" style="width: 170px"> -->
						<select class="layui-input" lay-verify="required"  name="isInput" lay-filter="aihao"
								id="isInput">
							<c:if test="${storeEnterprise.isInput == '1'}"    >
								<option selected="selected" value="1">是</option>
							</c:if>
							<c:if test="${storeEnterprise.isInput != '1'}"    >
								<option  value="1">是</option>
							</c:if>
							<c:if test="${storeEnterprise.isInput == '0'}"    >
								<option selected="selected" value="0">否</option>
							</c:if>
							<c:if test="${storeEnterprise.isInput != '0'}"    >
								<option  value="0">否</option>
							</c:if>

						</select>
						<!-- </div> -->
					</div>
				</div>

			</div>

			<p>备注：带有<span class="red">*</span>为必填项！</p>
			<p class="btn-box text-center">
				<a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
				<a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
			</p>
		</div>
	</form>

</div>

<script src="${ctx }/js/cities.data.js"></script>
<script>
    var province =$(".province").val();
    var city =$(".city").val();
    var district =$(".area").val();
    //省市级联动
    $('#distpicker').distpicker({
        province: province,
        city: city,
        district:district,

    });

    layui.use(['form', 'laydate'], function(){
        var form = layui.form;
        form.render();
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#reportDate' //指定元素
        });

        //自定义验证规则
        form.verify({
            //非零开头的最多带两位小数的数字
            customNumber: function(value){
                if(value.length!=0){
                    if(!(/^([1-9][0-9]*)+(.[0-9]{1,2})?$/.test(value))){
                        return '只能填写数字';
                    }
                }
            }
            , customEmail: function(value){
                if(value.length!=0){
                    if(!(/(^$)|^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value))){
                        return '邮箱格式不正确';
                    }
                }
            }, customProvince: function(value){
                // debugger

                if(value==''){

                    return '请选择行政区划';

                }
            }


            , customUrl: function(value){
                if(value.length!=0){
                    if(!(/(^$)|(^#)|(^http(s*):\/\/[^\s]+\.[^\s]+)/.test(value))){
                        return '链接格式不正确';
                    }
                }
            }, customCode: function(value){
                if(value.length!=0){
                    if(!(/^[1-9][0-9]{5}$/.test(value))){
                        return '邮政编码格式不正确';
                    }
                }
            } ,customIntegerNumber: function(value){
                if(value.length!=0){
                    if(!(/^\+?[1-9][0-9]*$/.test(value))){
                        return '只能输入正整数';
                    }
                }
            },customIntegerNumberTwo: function(value){
                if(value.length!=0){
                    if (value<=0) {
                        return '只能输入大于0的数';
                    }
                    /*  if(!(/^-?\d+\.?\d{0,2}$/.test(value))){
                       return '只能输入两位小数的正整数';
                     }*/
                }
            },socialCreditCode: function(value){

                var patrn = /^[0-9A-Z]+$/;
                //18位校验及大写校验
                if ((value.length != 18) || (patrn.test(value) == false)) {

                    return '不是有效的统一社会信用代码！';

                }
            },customCardPhone: function(value){
                if(value.length!=0){
                    if(!(/^(\d{12}|\d{19})\s*$/.test(value))){
                        return '银行卡格式不对';
                    }
                }
            },
            customPhone: function(value){
                if (ValidatePhone(value) == false) {

                    return '电话格式错误';
                }
            },
            customPhone1: function(value){
                if (value.length!=0) {
                    if (ValidatePhone(value) == false) {

                        return '电话格式错误';
                    }
                }

            }


        });


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




        //监听提交
        form.on('submit(save)', function(data){
            $("#province option").each(function(){ //遍历全部option
                var text = $(this).text(); //获取option的text

                if($(this).text()==$("#province").val()) {
                    $("#provinceCode").val($(this).attr("data-code"));
                }
            });

            $("#city option").each(function(){ //遍历全部option
                var text = $(this).text(); //获取option的text

                if($(this).text()==$("#city").val()) {
                    $("#cityCode").val($(this).attr("data-code"));
                }
            });

            $("#district option").each(function(){ //遍历全部option
                var text = $(this).text(); //获取option的text

                if($(this).text()==$("#district").val()) {
                    $("#areaCode").val($(this).attr("data-code"));
                }
            });

            layer.load();
            var inspectorType = $('#inspectorType').val();
            $(".form_input").ajaxSubmit({
                type:"post",
                success:function(data){
                    layer.closeAll('loading');
                    layer.msg("保存成功",{icon:1}, function(){
                        location.href="${ctx}/StoreEnterprise.shtml?";
                    })
                }
            });
            return false;
        });


    });



    $("#province").siblings(".layui-unselect").remove();
    $("#city").siblings(".layui-unselect").remove();
    $("#district").siblings(".layui-unselect").remove();


    $(".cancel").click(function(){
        layer.confirm('您是否要放弃编辑', function(index) {
            history.go(-1);
        });

    });

    function numberFixed(obj,op){
        number = $(obj).val();
        if(number==null ||number =="" ){
            return
        }
        number = parseFloat(number).toFixed(op);
        $(obj).val(number);
    }


</script>

<script language="javascript" type="text/javascript">
    function formatBankNo (BankNo){
        if (BankNo.value == "") return;
        var account = new String (BankNo.value);
        account = account.substring(0,22); /*帐号的总数, 包括空格在内 */
        if (account.match (".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null){
            /* 对照格式 */
            if (account.match (".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" +
                    ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null){
                var accountNumeric = accountChar = "", i;
                for (i=0;i<account.length;i++){
                    accountChar = account.substr (i,1);
                    if (!isNaN (accountChar) && (accountChar != " ")) accountNumeric = accountNumeric + accountChar;
                }
                account = "";
                for (i=0;i<accountNumeric.length;i++){  /* 可将以下空格改为-,效果也不错 */
                    if (i == 4) account = account + " "; /* 帐号第四位数后加空格 */
                    if (i == 8) account = account + " "; /* 帐号第八位数后加空格 */
                    if (i == 12) account = account + " ";/* 帐号第十二位后数后加空格 */
                    account = account + accountNumeric.substr (i,1)
                }
            }
        }
        else
        {
            account = " " + account.substring (1,5) + " " + account.substring (6,10) + " " + account.substring (14,18) + "-" + account.substring(18,25);
        }
        if (account != BankNo.value) BankNo.value = account;
    }
</script>

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<div class="container-box">
   <div class="location"><span>位置： 代储企业信息管理></span></div>
    <!--检验结果表-->
     <form class="form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
     <input type="hidden" name="id"  value="${storeEnterprise.id}"/>
     <table class="table table-bordered">
            <!-- 表格内容 start -->
            <tbody>
            <tr>
                <td class="text-right"><span class="red">*</span><b>代储企业编号：</b></td>
                <td><input type="text"   name="enterpriseSerial"  value=" ${storeEnterprise.enterpriseSerial}"  class="form-control validate[required] "  maxlength="10" placeholder="--请输入--"/></td>
             
                <td class="text-right"><span class="red">*</span><b>企业名称：</b></td>
                <td><input type="text"   name="enterpriseName"  value="${storeEnterprise.enterpriseName}"  class="form-control validate[required]" maxlength="50" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                
                <td class="text-right"><b>企业简称：</b></td>
                <td><input type="text"   name="shortName"  value="${storeEnterprise.shortName}"  class="form-control" maxlength="20" placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red">*</span><b>组织机构代码：</b></td>
                <td><input type="text"   name="organizationCode"  value="${storeEnterprise.organizationCode}"  class="form-control validate[required]" maxlength="10" placeholder="--请输入--"/></td>
            </tr>
            <tr>
               
                <td class="text-right"><span class="red">*</span><b>企业统一社会信用代码：</b></td>
                <td><input type="text"   name="socialCreditCode"  value="${storeEnterprise.socialCreditCode}"  class="form-control validate[required]" maxlength="18" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b>登记注册类型：</b></td>
                <td class="btn-select-parent">
                    <input type="text"   readOnly name="registType"  value="${storeEnterprise.registType}"  class="form-control validate[required]" maxlength="16" placeholder="--请选择--"/>
                    <div class="btn-group pull-right btn-select">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"></button>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:;">有限责任公司</a></li>
                            <li><a href="javascript:;">股份有限公司</a></li>
                            <li><a href="javascript:;">非公司企业法人</a></li>
                            <li><a href="javascript:;">个人独资企业</a></li>
                            <li><a href="javascript:;">合伙企业</a></li>
                            <li><a href="javascript:;">中外合作企业</a></li>
                            <li><a href="javascript:;">合营企业</a></li>
                            <li><a href="javascript:;">外商独资企业</a></li>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>企业经济类型：</b></td>
                <td class="btn-select-parent">
                    <input type="text"   name="economicType"  readOnly value="${storeEnterprise.economicType}"  class="form-control validate[required]" maxlength="10" placeholder="--请选择--"/>
                    <div class="btn-group pull-right btn-select">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"></button>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:;">国有经济</a></li>
                            <li><a href="javascript:;">集体经济</a></li>
                            <li><a href="javascript:;">私营经济</a></li>
                            <li><a href="javascript:;">个体经济</a></li>
                            <li><a href="javascript:;">联营经济</a></li>
                            <li><a href="javascript:;">股份制</a></li>
                            <li><a href="javascript:;">外商投资</a></li>
                            <li><a href="javascript:;">港澳台投资</a></li>
                            <li><a href="javascript:;">其他经济类</a></li>
                        </ul>
                    </div>
                </td>
                <td class="text-right"><span class="red">*</span><b>是否具备中央储备粮代储资格：</b></td>
                
                <td class="btn-select-parent">
                    <input type="text"  readOnly  name="seniority"  value="${storeEnterprise.seniority}"  class="form-control validate[required]" placeholder="--请选择--"/>
                    <div class="btn-group pull-right btn-select">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"></button>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:;">是</a></li>
                            <li><a href="javascript:;">否</a></li>
                          
                        </ul>
                    </div>
                </td>
             </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>工商登记注册号：</b></td>
                <td><input type="text"   name="businessNo"  value="${storeEnterprise.businessNo}"  class="form-control validate[required]" maxlength="13" placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red">*</span><b>企业行政区划名称：</b></td>
                <td class="btn-select-parent">
                    <div id="distpicker" class="form-inline">
                        <div>
                            <label class="sr-only" for="province">Province</label>
                            <select value="${storeEnterprise.province}"  class="form-control validate[required] pull-left" name="province"  style="width: 30%" id="province"></select>
                        </div>
                        <div>
                            <label class="sr-only" for="city">City</label>
                            <select value="${storeEnterprise.city}"  class="form-control  validate[required] pull-left" name="city"  style="width: 30%" id="city"></select>
                        </div>
                        <div>
                            <label class="sr-only" for="district">District</label>
                            <select value="${storeEnterprise.area}"  class="form-control  validate[required] pull-left" name="area"  style="width: 30%" id="district"></select>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>法定代表人：</b></td>
                <td><input type="text"   name="personIncharge"  value="${storeEnterprise.personIncharge}"  class="form-control validate[required]" maxlength="10" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b>企业地址：</b></td>
                <td><input type="text"   name="address"  value="${storeEnterprise.address}"  class="form-control validate[required]" maxlength="50" placeholder="--请输入--"/></td>
            </tr>
            <tr>
               
                <td class="text-right"><span class="red">*</span><b>企业电话：</b></td>
                <td><input type="text"   name="telephone"  value="${storeEnterprise.telephone}"  class="form-control validate[required]" maxlength="50" placeholder="--请输入--"/></td>
                 <td class="text-right"><span>&nbsp;&nbsp;</span><b>企业传真：</b></td>
                <td><input type="text"   name="fax"  value="${storeEnterprise.fax}"  class="form-control" maxlength="50" placeholder="--请输入--"/></td>
            </tr>
          
            <tr>
                <td class="text-right"><span>&nbsp;&nbsp;</span><b>企业电子邮箱：</b></td>
                <td><input type="text"   name="email"  value="${storeEnterprise.email}"  class="form-control" maxlength="50" placeholder="--请输入--"/></td>
                <td class="text-right"><span>&nbsp;&nbsp;</span><b>企业网址：</b></td>
                <td><input type="text"   name="website"  value="${storeEnterprise.website}"  class="form-control" maxlength="50" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                <td class="text-right"><span>&nbsp;&nbsp;</span><b>企业邮政编码：</b></td>
                <td><input type="text"   name="postalcode"  value="${storeEnterprise.postalcode}"  class="form-control validate[custom[number]]"  maxlength="12" placeholder="--请输入--"/></td>
            	 <td class="text-right"><span>&nbsp;&nbsp;</span><b>开户银行：</b></td>
                <td class="btn-select-parent">
                    <input type="text"  readOnly  name="depositBank"  value="${storeEnterprise.depositBank}"  class="form-control"  placeholder="--请选择--"/>
                    <div class="btn-group pull-right btn-select">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"></button>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:;">工商银行</a></li>
                            <li><a href="javascript:;">建设银行</a></li>
                            <li><a href="javascript:;">农业银行</a></li>
                            <li><a href="javascript:;">中国银行</a></li>
                            <li><a href="javascript:;">交通银行</a></li>
                            <li><a href="javascript:;">招商银行</a></li>
                            <li><a href="javascript:;">邮政储蓄银行</a></li>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr>
              <td class="text-right"><span>&nbsp;&nbsp;</span><b>银行账户：</b></td>
                <td><input type="text"   name="depositAccount"  value="${storeEnterprise.depositAccount}"  class="form-control" maxlength="40" placeholder="--请输入--"/></td>
                <td class="text-right"><span>&nbsp;&nbsp;</span><b>银行信用等级：</b></td>
                <td class="btn-select-parent">
                    <input type="text"  readOnly  name="bankCreditRating"  value="${storeEnterprise.bankCreditRating}"  class="form-control" placeholder="--请选择--"/>
                    <div class="btn-group pull-right btn-select">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"></button>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:;">AAA级</a></li>
                            <li><a href="javascript:;">AA+</a></li>
                            <li><a href="javascript:;">AA</a></li>
                            <li><a href="javascript:;">BBB级</a></li>
                            <li><a href="javascript:;">BB级</a></li>
                            <li><a href="javascript:;">B级</a></li>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="text-right"><span>&nbsp;&nbsp;</span><b>固定资产（万元）：</b></td>
                <td><input type="text"   name="fixedAssets"  value="${storeEnterprise.fixedAssets}"  class="form-control validate[custom[number]]" placeholder="--请输入--" /></td>
                <td class="text-right"><span>&nbsp;&nbsp;</span><b>注册资本（万元）：</b></td>
                <td><input type="text"   name="registeredCapital"  value="${storeEnterprise.registeredCapital}"  class="form-control validate[custom[number]]" placeholder="--请输入--" /></td>
             </tr>
            <tr>
                <td class="text-right"><span>&nbsp;&nbsp;</span><b>资产（万元）：</b></td>
                <td><input type="text"   name="assets"  value="${storeEnterprise.assets}"  class="form-control validate[custom[number]]" placeholder="--请输入--"/></td>
                <td class="text-right"><span>&nbsp;&nbsp;</span><b>企业从业人数（人）：</b></td>
                <td><input type="text"   name="people"  value="${storeEnterprise.people}"  class="form-control validate[custom[number]]" placeholder="--请输入--"/></td>
            </tr>
            <!-- 表格内容 end -->
            </tbody>
        </table>
        <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <button type="button" class="layui-btn layui-btn-primary layui-btn-small cancel">取消</button>
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-small  save">保存</button>
        </p>
    </form>
</div>
</div>

<script>
   var province = $("#province").val();
   var city = $("#city").val();
   var area = $("#district").val();
//    省市级联动
    $(function () {
        $('#distpicker,#distpicker1').distpicker({
             province: province,
            city:city,
              area:area,
        });
    });
//查看页面时
/* if(GetQueryString("type")==3){
    $("input").attr("disabled","disabled");
    $("textarea").attr("disabled","disabled");
    $(document).unbind("click");
    $(".btn").hide();
//    $(".radio-inline").attr("disabled","disabled");
    $(".btn-select-parent select").attr("disabled","disabled");
} */
		//自定义错误显示位置 
 $('.form_input').validationEngine({ 
  promptPosition: 'bottomRight', 
  addPromptClass: 'formError-white'
 });
 

    
    $(".save").click(function(){
		if($(".form_input").validationEngine('validate')==true){
			$(".form_input").ajaxSubmit({
			type:"post",
			success:function(data){
				
				location.href="${ctx}/StoreEnterprise.shtml";
			}
			});
		}
		
	});
	
	  $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
				history.go(-1);
			});
		
	});
	
	


	
</script>
 --%>