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
     
      <div class="layui-form"    id="search" >
      	<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮库名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  autocomplete="off"  maxlength="25"  value="${storageStarUnit.warehouse}"   id="warehouse" name="warehouse">
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
					<input class="layui-input" lay-verify="customEmail"  autocomplete="off"  maxlength="25"  value="${storageStarUnit.email}"   id="email" name="email">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>邮编：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customCode"  autocomplete="off" maxlength="6"  value="${storageStarUnit.zip}"   id="zip" name="zip">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>电话：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  autocomplete="off" maxlength="11"  value="${storageStarUnit.telphone}"   id="telphone" name="telphone">
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
					<input class="layui-input" lay-verify="customNumber"  autocomplete="off"   value="${storageStarUnit.entireStaff}"   id="entireStaff" name="entireStaff">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>有职业资格证书人员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="customNumber"  autocomplete="off"  maxlength="10"  value="${storageStarUnit.nvq}"   id="nvq" name="nvq">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>大专（含）以上学历(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber" autocomplete="off"  maxlength="10"  value="${storageStarUnit.juniorCollege}"   id="juniorCollege" name="juniorCollege">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>中级（含）以上职称(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber"  autocomplete="off"   value="${storageStarUnit.mediumGrade}"   id="mediumGrade" name="mediumGrade">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>粮油保管员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="customNumber"  autocomplete="off"  maxlength="10"  value="${storageStarUnit.keeper}"   id="keeper" name="keeper">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>粮油质量检验员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber" autocomplete="off"  maxlength="10"  value="${storageStarUnit.monitor}"   id="monitor" name="monitor">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>粮仓机械员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber"  autocomplete="off"   value="${storageStarUnit.mechanic}"   id="mechanic" name="mechanic">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>中央控制室操作员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="customNumber"  autocomplete="off"  maxlength="10"  value="${storageStarUnit.controlOperator}"   id="controlOperator" name="controlOperator">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>电工(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber" autocomplete="off"  maxlength="10"  value="${storageStarUnit.electrician}"   id="electrician" name="electrician">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>安全生产管理员(人)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="customNumber"  autocomplete="off"   value="${storageStarUnit.safety}"   id="safety" name="safety">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>原"星级"等级：</label>
				<div class="layui-input-inline">
	
					<input class="layui-input"   name="oldLevel"  autocomplete="off"  maxlength="25"  value="${storageStarUnit.oldLevel}"  >		
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
	
					<input class="layui-input"  name="applyLevel"  lay-verify="required" autocomplete="off"  maxlength="25"  value="${storageStarUnit.applyLevel}"  >		
				</div>
			</div>

               	<div class="layui-inline">
					<label style=" width: 100px;text-align: right " class="layui-form-label"><span class="red">*</span>已经上传的附件:</label>
					<div class="layui-input-inline">
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
				
					
		</div>
		
			<div class="layui-form-item">
					
						<label style=" width: 100px;text-align: right " class="layui-form-label"><span class="red"></span>备注:</label>
						  <div style="margin-left: 111px"; class="layui-input-block">
				    	  <textarea   placeholder="--限500字--" maxlength="500" name="remark" class="layui-textarea">${storageStarUnit.remark}</textarea>
				    	</div>
			</div>
      </div>
     <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <a type="button"  class="layui-btn layui-btn-primary layui-btn-small reback">返回</a>
            
        </p>
    </form>

</div>
</div>
<script>
	 	var form = layui.form;
	form.render();
	$("input").attr("readOnly","true");
 	$("textarea").attr("readOnly","true");	
	
	 $(".reback").click(function(){
			history.go(-1);
		
	});

        if ("${storageStarUnit.groupId}" != "") {
            if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
                $("#openExcel").css("display", "");
            }else{
                $("#openFile").css("display", "");
            }
        }
</script>

