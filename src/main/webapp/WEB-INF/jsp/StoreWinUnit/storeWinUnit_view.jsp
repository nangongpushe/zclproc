
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
		<li>业务信息</li>
		<li class="active">优胜单位申报</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
    
      
     <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
    	 <input type="hidden" name="id"  value="${storeWinUnit.id }"/>
      	<input type="hidden" name="serial"  value="${storeWinUnit.serial }"/>
      	<input type="hidden" name="groupId"  value="${storeWinUnit.groupId }"/>
     <div class="layui-form" id="search" >
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>评选年份：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" value="${storeWinUnit.year }" autocomplete="off" id="year" name="year">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">上报单位：</label>
				<div class="layui-input-inline">
					<input class="layui-input" readOnly autocomplete="off" value="${storeWinUnit.declareUnit }"  id="declareUnit" name="declareUnit">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">上报时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input" readOnly autocomplete="off" value="${storeWinUnit.declareDate }" id="declareDate" name="declareDate">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>监管单位：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  readOnly value="${storeWinUnit.regulatoryUnit }"  autocomplete="off" id="regulatoryUnit" name="regulatoryUnit">
				</div>
			</div>
			
			 <c:if test="${not empty myFile}">
               
              <div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">已经上传的评选材料：</label>
				<div class="layui-input-inline">
					<input type="hidden" name="pictureId" id="pictureId" /><a style="color:red;margin:auto 20px;" href="${ctx}/sysFile/download.shtml?fileId=${myFile.id}">${myFile.fileName }</a>
					<div style="display:inline-block;font-size:20px;" id="openExce">
						<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
							预览
						</a>
						<a href="javascript:openAnnex('${storeWinUnit.groupId}')" id="openFile" style="display: none">
							预览
						</a>
					</div>
				</div>
				</div>
            	 
           
             </c:if>  
                <c:if test="${empty myFile }">
               
             	<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">评选材料：</label>
				<div class="layui-input-inline">
					<input class="layui-input" readOnly autocomplete="off" value="暂无"  >
				</div>
				</div>
             </c:if>    
			
		</div>
		
      
        <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <a type="button"  class="layui-btn layui-btn-primary layui-btn-small reback">返回</a>
           
        </p>

    </form>
  
</div>


<script>
    if ("${storeWinUnit.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
  

	$("input").attr("readOnly","true");
 	$("textarea").attr("readOnly","true");	
	
	 $(".reback").click(function(){
			location.href="${ctx}/StoreWinUnit.shtml";
		
	});
	
	
	



	
</script>


