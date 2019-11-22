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
		<input type="hidden" name="id"  value=""/>
		<input type="hidden" id="provinceCode" name="provinceCode"  value=""/>
		<input type="hidden" id="cityCode" name="cityCode"  value=""/>
		<input type="hidden" id="areaCode" name="areaCode"  value=""/>

		<div class="layui-form" id="search" >
			<div class="layui-form-item">

				<div class="layui-inline ">
					<label class="layui-form-label "  style="text-align:right"><span class="red">*</span>代储企业编号：</label>
					<div class="layui-input-inline ">
						<input type="text" lay-verify="required" class="layui-input"  maxlength="10" name="enterpriseSerial" id="enterpriseSerial" autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业名称：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required"  maxlength="50" class="layui-input"    name="enterpriseName" id="enterpriseName"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业简称：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required" maxlength="10" class="layui-input" name="shortName" id="shortName"
							   autocomplete="off">
					</div>
				</div>



				<!-- <div class="layui-inline ">
                    <label class="layui-form-label " ><span class="red">*</span>组织机构代码:</label>
                    <div class="layui-input-inline ">
                        <input type="text" lay-verify="required" maxlength="25" class="layui-input" name="organizationCode" id="organizationCode" autocomplete="off">
                    </div>
                </div> -->
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业统一社会信用代码：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required|socialCreditCode" class="layui-input" maxlength="18" name="socialCreditCode" id="socialCreditCode"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>登记注册类型：</label>
					<div class="layui-input-inline">
						<!-- <div class="layui-inline" style="width: 170px"> -->
						<select class="layui-input" lay-verify="required" name="registType" maxlength="16" lay-filter="aihao"
								id="registType">
							<option></option>
							<option value="有限责任公司">有限责任公司</option>
							<option value="股份有限公司">股份有限公司</option>
							<option value="非公司企业法人">非公司企业法人</option>
							<option value="个人独资企业">个人独资企业</option>
							<option value="合伙企业">合伙企业</option>
							<option value="中外合作企业">中外合作企业</option>
							<option value="合营企业">合营企业</option>
							<option value="外商独资企业">外商独资企业</option>
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
							<option value="国有经济">国有经济</option>
							<option value="集体经济">集体经济</option>
							<option value="私营经济">私营经济</option>
							<option value="个体经济">个体经济</option>
							<option value="联营经济">联营经济</option>
							<option value="股份制">股份制</option>
							<option value="外商投资">外商投资</option>
							<option value="港澳台投资">港澳台投资</option>
							<option value="其他经济类">其他经济类</option>

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

							<option value="是">是</option>
							<option value="否">否</option>


						</select>
						<!-- </div> -->
					</div>
				</div>

				<!-- <div class="layui-inline ">
                    <label class="layui-form-label"><span class="red">*</span>工商登记注册号:</label>
                    <div class="layui-input-inline">
                        <input type="text" lay-verify="required" class="layui-input" maxlength="13" name="businessNo" id="businessNo"
                            autocomplete="off">
                    </div> -->
				<!-- </div> -->


				<div class="layui-inline" >

					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业行政区划：</label>
					<div class="btn-select-parent">
						<div id="distpicker" class="form-inline">
							<div>
								<label class="sr-only" for="province">Province</label>
								<select class="form-control  pull-left" style="width: 22%" name="province" lay-verify="customProvince" id="province"></select>
							</div>
							<div>
								<label class="sr-only" for="city">City</label>
								<select class="form-control  pull-left" style="width: 22%" name="city" lay-verify="customProvince"  id="city"></select>
							</div>
							<div>
								<label class="sr-only" for="district">District</label>
								<select class="form-control  pull-left" style="width: 22%" name="area" id="district"></select>
							</div>
						</div>
					</div>
				</div>




				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>法定代表人：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required" class="layui-input" maxlength="10" name="personIncharge" id="personIncharge"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业地址：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required" class="layui-input" maxlength="50" name="address" id="address"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>企业电话：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="required|customPhone" class="layui-input" maxlength="50" name="telephone" id="telephone"
							   autocomplete="off">
					</div>
				</div>




				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>企业传真：</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" maxlength="50"  name="fax" id="fax"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>企业电子邮箱：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="customEmail" class="layui-input" name="email"  maxlength="50" name="address" id="address"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>企业网址：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="customUrl"  class="layui-input" maxlength="50" name="website" id="website"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>企业邮政编码：</label>
					<div class="layui-input-inline">
						<input type="text"  lay-verify="customCode" class="layui-input" maxlength="12" name="postalcode" id="postalcode"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>开户银行：</label>
					<div class="layui-input-inline">
						<input type="text"  class="layui-input" maxlength="12" name="depositBank" id="depositBank"
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
								<option value="${item.value}">${item.value }</option>
							</c:forEach>


						</select>

					</div>
				</div>


				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>银行账户：</label>
					<div class="layui-input-inline">
						<input type="text" lay-verify="customCardPhone"  class="layui-input" name="depositAccount" maxlength="19" id="depositAccount"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>固定资产（万元）：</label>
					<div class="layui-input-inline">
						<input type="number" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" onchange = "numberFixed(this,4)" class="layui-input" lay-verify="customIntegerNumberTwo" name="fixedAssets" id="fixedAssets"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>注册资本（万元）：</label>
					<div class="layui-input-inline">
						<input type="number" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0"  onchange = "numberFixed(this,4)" class="layui-input" lay-verify="customIntegerNumberTwo" name="registeredCapital" id="registeredCapital"
							   autocomplete="off">
					</div>
				</div>


				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>资产（万元）：</label>
					<div class="layui-input-inline">
						<input type="number" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0"  onchange = "numberFixed(this,4)" class="layui-input" lay-verify="customIntegerNumberTwo" name="assets" id="assets"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right"><span class="red"></span>企业从业人数（人）：</label>
					<div class="layui-input-inline">
						<input type="number"  class="layui-input" maxlength="15" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" lay-verify="customIntegerNumber" name="people" id="people"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right">联系人：</label>
					<div class="layui-input-inline">
						<input type="text"  class="layui-input" maxlength="50" lay-verify="layui-input" name="contacts" id="contacts"
							   autocomplete="off">
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label" style="text-align:right">联系人电话：</label>
					<div class="layui-input-inline">
						<input type="text"  class="layui-input" maxlength="50" lay-verify="layui-input|customPhone1" name="contactNumber" id="contactNumber"
							   autocomplete="off">
					</div>
				</div>

				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>是否停用：</label>
					<div class="layui-input-inline">
						<!-- <div class="layui-inline" style="width: 170px"> -->
						<select class="layui-input" lay-verify="required"  name="isStop" lay-filter="aihao"
								id="isStop">
							<option value="N">否</option>
							<option value="Y">是</option>
						</select>
						<!-- </div> -->
					</div>
				</div>
				<%--jovan---------------------------------------------------------------%>
				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>是否动态轮换：</label>
					<div class="layui-input-inline">
						<!-- <div class="layui-inline" style="width: 170px"> -->
						<select class="layui-input" lay-verify="required"  name="isInput" lay-filter="aihao"
								id="isInput">
							<option value="0">否</option>
							<option value="1">是</option>
						</select>
						<!-- </div> -->
					</div>
				</div>
				<%--jovan---------------------------------------------------------------%>

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

    //省市级联动
    $('#distpicker').distpicker({
        province: '浙江省',
        city: '杭州市',
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
                    /* if(!(/^-?\d+\.?\d{0,2}$/.test(value))){
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
                    if(data.data!=null){
                        alert(data.data);

                    }else{
                        layer.msg("保存成功",{icon:1}, function(){
                            location.href="${ctx}/StoreEnterprise.shtml?";
                        })

                    }

                }
            });
            return false;
        });


    });






    $(".cancel").click(function(){
        layer.confirm('您是否要放弃编辑', function(index) {
            history.go(-1);
        });

    });

    $("#province").siblings(".layui-unselect").remove();
    $("#city").siblings(".layui-unselect").remove();
    $("#district").siblings(".layui-unselect").remove();

    function numberFixed(obj,op){
        number = $(obj).val();
        if(number==null ||number =="" ){
            return
        }
        number = parseFloat(number).toFixed(op);
        $(obj).val(number);
    }


</script>
