
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
      	<input type="hidden" name="recommend"  value="${storeWinUnit.recommend }"/>
      	
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
					<input class="layui-input" readOnly lay-verify="required"   placeholder="当前年份该公司没有被监管"  autocomplete="off" value="${storeWinUnit.declareUnit }"  id="declareUnit" name="declareUnit">
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
					<input type="hidden" name="groupId" id="groupId" value="${storeWinUnit.groupId }" />
					<a style="color:red;margin:auto 20px;" href="${ctx}/sysFile/download.shtml?fileId=${myFile.id}">${myFile.fileName }</a>
					<div style="display:inline-block;font-size:20px;" id="openExce">
						<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
							预览
						</a>
						<a href="javascript:openAnnex('${myFile.id}')" id="openFile" style="display: none">
							预览
						</a>
					</div>
				</div>
				</div>
            	 <div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">更换评选材料：</label>
				<div class="layui-input-inline">
					<input type="file" name="file" class="form-control "/>
					<input id="delfile" class="layui-btn-small layui-btn" value="删除"/>
				</div>
				</div>
           
             </c:if>  
                <c:if test="${empty myFile }">
               
             	<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right">评选材料：</label>
					<div class="layui-input-inline">
						<input type="file" name="file" class="form-control "/>
						<input style="display: none" id="delfile" class="layui-btn-small layui-btn" value="删除"/>
					</div>
				</div>
             </c:if>    
			
		</div>
		
      
        <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
             <a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
        </p>
	 </div>
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

 layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	var laydate = layui.laydate;
	
		//初始赋值
	  laydate.render({
	    elem: '#year'
	    ,type: 'year',
	     done: function(value, date){
	  	$("#declareUnit").val();
		$("#regulatoryUnit").val();
   			$(".form_input").ajaxSubmit({
				type:"post",
				 url:"${ctx}/StoreWinUnit/getcompany.shtml?year1="+value,
	 			 dataType: "json",
				success:function(data){
					if(data!=null){
					$("#declareUnit").val(data.data.enterpriseName);
						$("#regulatoryUnit").val(data.data.wareHouse);
					}
					
				}
				}); 
  			}
	    
	  });  
	 
 
  
  //监听提交
  form.on('submit(save)', function(data){
     var inspectorType = $('#inspectorType').val();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
					
					layer.msg("保存成功",{icon:1}, function(){
						  location.href="${ctx}/StoreWinUnit.shtml";
						})
				}
				}); 
    return false;
  });
  
  
});
 
  


	
	 $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
				 location.href="${ctx}/StoreWinUnit.shtml";
			});StoreWinUnit
		
	});
	

$("input[name='file']").change(function () {
	$("#delfile").show();
});
$("#delfile").click(function () {
    $("input[name='groupId']").val("")
	$("input[name='file']").val("");
    $("input[name='groupId']").next().html("");
	$(this).hide();
    $("#openExce a").html("");
})
	
</script>

