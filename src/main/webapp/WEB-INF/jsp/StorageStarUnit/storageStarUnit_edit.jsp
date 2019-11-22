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
		<li>仓储管理</li>
		<li>粮库管理</li>
		<li class="active">星级粮库申报</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">
    <!--检验结果表-->
      <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
         <input type="hidden" name="id"  value="${storageStarUnit.id}"/>
         <input type="hidden" name="storeHouse"  value="${storageStarUnit.storeHouse}"/>
		  <input type="hidden" name="warehouse"  id="warehouse" value="${storageStarUnit.warehouse}"/>
      <div class="layui-form"    id="search" >
      	<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮库名称：</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-verify="required" name="warehouseId" lay-filter="warehouseId"
							id="warehouseId">
						<option  value=""></option>
						<c:forEach var="item" items="${storageWarehouseList}">

								<option  <c:if test="${item.id==storageStarUnit.warehouseId}">selected</c:if> value="${item.id}">${item.warehouseShort }</option>



						</c:forEach>

					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>通讯地址：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  autocomplete="off" maxlength="50"  value="${storageStarUnit.postalAddress}"   id="postalAddress" name="postalAddress">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮库主任：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  autocomplete="off" maxlength="10"  value="${storageStarUnit.director}"   id="director" name="director">
				</div>
			</div>
			

			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>电子信箱：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required|customEmail"  autocomplete="off"  maxlength="25"  value="${storageStarUnit.email}"   id="email" name="email">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>邮编：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required|customCode"  autocomplete="off" maxlength="6"  value="${storageStarUnit.zip}"   id="zip" name="zip">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>电话：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required|customPhone"  autocomplete="off" maxlength="13"  value="${storageStarUnit.telphone}"   id="telphone" name="telphone">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>传真：</label>
				<div class="layui-input-inline">
					<input class="layui-input"   lay-verify="customfax" autocomplete="off"  maxlength="14"  value="${storageStarUnit.fax}"   id="fax" name="fax">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>职工总人数(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber"  autocomplete="off"  maxlength="9"  value="${storageStarUnit.entireStaff}"   id="entireStaff" name="entireStaff" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>有职业资格证书人员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="customNumber"  autocomplete="off"  maxlength="9"  value="${storageStarUnit.nvq}"   id="nvq" name="nvq" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"/>
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>大专（含）以上学历(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber" autocomplete="off"  maxlength="9"  value="${storageStarUnit.juniorCollege}"   id="juniorCollege" name="juniorCollege" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>中级（含）以上职称(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber"  autocomplete="off" maxlength="9"  value="${storageStarUnit.mediumGrade}"   id="mediumGrade" name="mediumGrade" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>粮油保管员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="customNumber"  autocomplete="off"  maxlength="9"  value="${storageStarUnit.keeper}"   id="keeper" name="keeper" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"/>
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>粮油质量检验员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber" autocomplete="off"  maxlength="9"  value="${storageStarUnit.monitor}"   id="monitor" name="monitor" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>粮仓机械员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber"  autocomplete="off" maxlength="9"  value="${storageStarUnit.mechanic}"   id="mechanic" name="mechanic" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>中央控制室操作员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="customNumber"  autocomplete="off"  maxlength="9"  value="${storageStarUnit.controlOperator}"   id="controlOperator" name="controlOperator" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"/>
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>电工(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber" autocomplete="off"  maxlength="9"  value="${storageStarUnit.electrician}"   id="electrician" name="electrician" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>安全生产管理员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber"  autocomplete="off" maxlength="9"  value="${storageStarUnit.safety}"   id="safety" name="safety" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>原"星级"等级：</label>
				<div class="layui-input-inline">
	
					<input class="layui-input"   name="oldLevel"  autocomplete="off"  maxlength="10"  value="${storageStarUnit.oldLevel}"  >
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>申请企业名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required" autocomplete="off"  maxlength="25"  value="${storageStarUnit.enterprise}"   id="enterprise" name="enterprise">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>现申请评定"星级"等级：</label>
				<div class="layui-input-inline">
	
					<input class="layui-input"  name="applyLevel"  lay-verify="required" autocomplete="off"  maxlength="10"  value="${storageStarUnit.applyLevel}"  >
				</div>
			</div>

				<c:if test="${not empty sysFile}">
               	<div class="layui-inline">
					<label style=" width: 100px;text-align: right " class="layui-form-label"><span class="red">*</span>已经上传的附件:</label>
					<div class="layui-input-inline">
						<input type="hidden" name="groupId"  value="${storageStarUnit.groupId}">
						<input type="hidden" name="pictureId"  value="${storageStarUnit.id}"   id="pictureId" />
						<a style="color:red;margin:auto 20px;"href="${ctx}/sysFile/download.shtml?fileId=${sysFile.id}">${sysFile.fileName }</a>
						<div style="display:inline-block;font-size:20px;" id="openExce">
							<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${sysFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
								预览
							</a>
							<a href="javascript:openAnnex('${storageStarUnit.groupId}')" id="openFile" style="display: none">
								预览
							</a>
						</div>

					</div>
					</div>
				</div>
				
				<div class="layui-inline">
				<label style=" width: 100px;text-align: right " class="layui-form-label"><span class="red"></span>更换附件：</label>
				<div class="layui-input-inline">
					<input type="file"   name="file"  class="form-control " placeholder="--请输入--"/>
				</div>
					<input type="button" style="" id="clearBtn" onclick="clearFile()" value="删除附件"/>
			  </div>

             </c:if>  
             <c:if test="${ empty sysFile}">
             <div class="layui-inline">
               <label class="layui-form-label" style="text-align:right">附件：</label>
				<div class="layui-input-inline">
					<input type="file"   name="file"  class="form-control " placeholder="--请输入--"/>
				</div>
				 <input type="button" style="" id="clearBtn" onclick="clearFile()" value="删除附件"/>
               </div>
             </c:if>    	
				
					
		</div>
		
			<div class="layui-form-item">
					
						<label style=" width: 100px;text-align: right " class="layui-form-label"><span class="red"></span>备注:</label>
						  <div style="margin-left: 111px"; class="layui-input-block">
				    	  <textarea   placeholder="--限450字--" maxlength="350" name="remark" class="layui-textarea">${storageStarUnit.remark}</textarea>
				    	</div>
			</div>
      </div>
     <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
             <a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
        </p>
    </form>

</div>
</div>
<script>
    if ("${storageStarUnit.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
    form.on('select(warehouseId)', function(data){

        var options=$("#warehouseId option:selected"); //获取选中的项


        $("#warehouse").val(options.text());

    })
	
 //自定义验证规则
  form.verify({
  //非零开头的最多带两位小数的数字
    customNumber: function(value){
      if(value.length!=0){
	       if(!(/^\+?[1-9][0-9]*$/.test(value))){
	        return '只能输入整数';
	      }
      }
    }
    , customEmail: function(value){
      if(value.length!=0){
	       if(!(/(^$)|^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value))){
	        return '邮箱格式不正确';
	      }
      }
    }, customfax: function(value){
      if(value.length!=0){
	       if(!(/^(\d{3,4}-)?\d{7,8}$/.test(value))){
	        return '传真格式不正确';
	      }
      }
    }
    , customUrl: function(value){
      if(value.length!=0){
	       if(!(/(^$)|(^#)|(^http(s*):\/\/[^\s]+\.[^\s]+)/.test(value))){
	        return '链接格式不正确';
	      }
      }
    }, customCode: function(value){
     
	       if(!(/^[1-9][0-9]{5}$/.test(value))){
	        return '邮政编码格式不正确';
	      }
      
    } , customPhone: function(value){
          if (ValidatePhone(value) == false) {

              return '电话格式错误';
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
     var inspectorType = $('#inspectorType').val();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
                    //debugger
				    if(data.success){
				 	layer.msg("保存成功",{icon:1}, function(){
						  	location.href="${ctx}/StorageStarUnit.shtml";
						})
					}else{
				        layer.alert(data.msg);
					}
				}
				}); 
    return false;
  });


  
});

$("input[name='file']").change(function () {
    $("#clearBtn").css("display",true);
});
function clearFile() {
    // 清除隐藏信息
    $("input[name='file']").val("");	// 删除
    $("input[name='groupId']").val("");
    $("input[name='pictureId']").val("").next().html("");
    $("#clearBtn").css("display", "none");	// 隐藏删除按键
    $("#openExce a").html("");
};

	 $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
				history.go(-1);
			});
		
	});
	

	
</script>

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<div class="container-box">
  <div class="location"><span>位置：代储监管/业务信息/星级粮库申报 </span></div>
    <!--检验结果表-->
     <form class="form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
     <input type="hidden" name="id"  value="${storageStarUnit.id}"/>
     <table class="table table-bordered">
            <!-- 表格内容 start -->
            <tbody>
            <tr>            
                <td class="text-right"><span class="red">*</span><b>粮库名称：</b></td>
                <td><input type="text"   name="warehouse"   value="${storageStarUnit.warehouse}"  class="form-control validate[required] "  maxlength="25" placeholder="--请输入--"/></td>
             
                <td class="text-right"><span class="red">*</span><b>通讯地址：</b></td>
                <td><input type="text"   name="postalAddress"   value="${storageStarUnit.postalAddress}"  class="form-control validate[required]" maxlength="50" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>粮库主任：</b></td>
                <td><input type="text"   name="director"   value="${storageStarUnit.director}"  class="form-control validate[required]" maxlength="5" placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red">*</span><b>电子信箱：</b></td>
                <td><input type="text"   name="email"   value="${storageStarUnit.email}"  class="form-control validate[required]" maxlength="25" placeholder="--请输入--"/></td>
            </tr>
            
             <tr>
                <td class="text-right"><span class="red">*</span><b>邮编：</b></td>
                <td><input type="text"   name="zip"   value="${storageStarUnit.zip}"  class="form-control validate[required] validate[custom[number]]" maxlength="6" placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red">*</span><b>电话：</b></td>
                <td><input type="text"   name="telphone"   value="${storageStarUnit.telphone}"  class="form-control validate[required]" maxlength="25" placeholder="--请输入--"/></td>
            </tr>
            
             <tr>
                <td class="text-right"><span class="red"></span><b>传真：</b></td>
                <td><input type="text"   name="fax"   value="${storageStarUnit.fax}"  class="form-control " maxlength="10" placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red"></span><b>职工总人数(人)：</b></td>
                <td><input type="text"   name="entireStaff"   value="${storageStarUnit.entireStaff}"  class="form-control validate[custom[number]]"  placeholder="--请输入--"/></td>
            </tr>
            
             <tr>
                <td class="text-right"><span class="red"></span><b>有职业资格证书人员(人)：</b></td>
                <td><input type="text"   name="nvq"   value="${storageStarUnit.nvq}"  class="form-control validate[custom[number]]"  placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red"></span><b>大专（含）以上学历(人)：</b></td>
                <td><input type="text"   name="juniorCollege"   value="${storageStarUnit.juniorCollege}"  class="form-control validate[custom[number]]"  placeholder="--请输入--"/></td>
            </tr>
            
              <tr>
                <td class="text-right"><span class="red"></span><b>中级（含）以上职称(人)：</b></td>
                <td><input type="text"   name="mediumGrade"   value="${storageStarUnit.mediumGrade}"  class="form-control validate[custom[number]]"  placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red"></span><b>粮油保管员(人)：</b></td>
                <td><input type="text"   name="keeper"   value="${storageStarUnit.keeper}"  class="form-control validate[custom[number]]"  placeholder="--请输入--"/></td>
            </tr>
            
              <tr>
                <td class="text-right"><span class="red"></span><b>粮油质量检验员(人)：</b></td>
                <td><input type="text"   name="monitor"   value="${storageStarUnit.monitor}"  class="form-control validate[custom[number]]"  placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red"></span><b>粮仓机械员(人)：</b></td>
                <td><input type="text"   name="mechanic"   value="${storageStarUnit.mechanic}"  class="form-control validate[custom[number]]"  placeholder="--请输入--"/></td>
            </tr>
            
             <tr>
                <td class="text-right"><span class="red"></span><b>中央控制室操作员(人)：</b></td>
                <td><input type="text"   name="controlOperator"   value="${storageStarUnit.controlOperator}"  class="form-control validate[custom[number]]"  placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red"></span><b>电工(人)：</b></td>
                <td><input type="text"   name="electrician"   value="${storageStarUnit.electrician}"  class="form-control validate[custom[number]]"  placeholder="--请输入--"/></td>
            </tr>
               <tr>
                <td class="text-right"><span class="red"></span><b>安全生产管理员(人)：</b></td>
                <td><input type="text"   name="safety"   value="${storageStarUnit.safety}"  class="form-control validate[custom[number]]"  placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red"></span><b>原"星级"等级：</b></td>
                <td class="btn-select-parent">
                    <input type="text"   readOnly name="oldLevel"   value="${storageStarUnit.oldLevel}"  class="form-control " maxlength="16" placeholder="--请选择--"/>
                    <div class="btn-group pull-right btn-select">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"></button>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:;">A</a></li>
                            <li><a href="javascript:;">B</a></li>
                            <li><a href="javascript:;">C</a></li>
                           
                        </ul>
                    </div>
                </td>
            </tr>
            
             <tr>
                <td class="text-right"><span class="red">*</span><b>申请企业名称：</b></td>
                <td><input type="text"   name="enterprise"   value="${storageStarUnit.enterprise}"  class="form-control validate[required]" maxlength="25"  placeholder="--请输入--"/></td>
                 <td class="text-right"><span class="red"></span><b>现申请评定"星级"等级：</b></td>
                <td class="btn-select-parent">
                    <input type="text"   readOnly name="applyLevel"   value="${storageStarUnit.applyLevel}"  class="form-control validate[required]"  placeholder="--请选择--"/>
                    <div class="btn-group pull-right btn-select">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"></button>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:;">A</a></li>
                            <li><a href="javascript:;">B</a></li>
                            <li><a href="javascript:;">C</a></li>
                           
                        </ul>
                    </div>
                </td>
            </tr>
            
            
             <tr>
              <c:if test="${not empty sysFile}">
               
             	 <td class="text-right"><span class="red"></span><b>已经上传的附件:</b></td>
                <td ><input type="hidden" name="pictureId"  value="${storageStarUnit.id}"   id="pictureId" /><a style="color:red;margin:auto 20px;" href="${ctx}/sysFile/download.shtml?file value="${storageStarUnit.id}"   id=${sysFile.id}">${sysFile.fileName }</a>   </td>
            	   <td class="text-right"><span class="red"></span><b>更换附件：</b></td>
                <td><input type="file" name="file" class="form-control "/></td>
           
             </c:if>  
                <c:if test="${empty sysFile }">
                <td class="text-right"><span class="red"></span><b>附件：</b></td>
                <td colspan="3"><input type="file" name="file" class="form-control "/></td>
             
             </c:if>    
            </tr>
            <tr>
               
                <td class="text-right"><span>&nbsp;&nbsp;</span><b>备注：</b></td>
                <td colspan="3"><textarea type="text" name="remark"  class="form-control" maxlength="250" placeholder="--限250字--">${storageStarUnit.remark}</textarea></td>
            </tr>
            <!-- 表格内容 end -->
            </tbody>
        </table>
        <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <button type="button" class="layui-btn layui-btn-primary layui-btn-small cancel"  >取消</button>
        	<button class="layui-btn layui-btn-primary layui-btn-small save"  >保存</button>
        </p>
    </form>
</div>
</div>

<script>

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
				
					location.href="${ctx}/StorageStarUnit.shtml";
			}
			});
		}
		
	});
	
	 $(".cancel").click(function(){
		history.go(-1);
		
	});
	
	


	
</script>
 --%>