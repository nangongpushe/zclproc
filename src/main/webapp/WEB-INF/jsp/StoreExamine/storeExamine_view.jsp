<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">
.form_input td:nth-child(odd) {
    width: 18%; 
     padding-right: 0px !important; 
}
.td-size {
   
    font-size: 14;
    text-align: left;
}


p {
    font-size: 15px;
    line-height: 25px;
     padding-top: 0px; 
}
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
		<li class="active">考核评分管理</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	 <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
	 <input   value="${storeExamine.examineSerial }" id="examineSerial" type="hidden"  name="examineSerial">
     <input type="hidden" name="id"  value="${storeExamine.id }"/>
     <input type="hidden" name="points" value="${storeExamine.points }" />
      <input type="hidden" name="examineTemplet" value="${storeExamine.examineTemplet }"/>
		 <c:forEach var="item" items="${manangers}" varStatus="status">
		  <input type="hidden" id="${status.index + 1}"  value="${item }" />						
	  </c:forEach>		
    
    
       <div class="layui-form" id="search" >
       <div  class="layui-form-item">
       <shiro:hasPermission name="StoreExamine:storehouse">  
       <c:if test="${storeExamine.examineType == '企业自评'}">
			
			<div class="layui-inline wareHouse" style="display:inline-block;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${storeExamine.examineSerial }" readOnly autocomplete="off" >
				</div>
			</div>
			
	
			<div class="layui-inline wareHouse" style="display:inline-block;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称：</label>
				<div class="layui-input-inline">
				<input class="layui-input"  lay-verify="required" value="${storeExamine.storehouse }" readOnly autocomplete="off" readOnly id="storehouse" name="storehouse">
							
				</div>
			</div>
			
			
			<div class="layui-inline wareHouse" style="display:inline-block;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required" value="${storeExamine.manager }" readOnly autocomplete="off" readOnly id="manager" name="manager">
				</div>
			</div>
		 </c:if>
		  <c:if test="${storeExamine.examineType != '企业自评'}">
		 	<div class="layui-inline wareHouse" style="display:none;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${storeExamine.examineSerial }" readOnly autocomplete="off" >
				</div>
			</div>
			
	
			<div class="layui-inline wareHouse" style="display:none;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称：</label>
				<div class="layui-input-inline">
				<input class="layui-input"  lay-verify="required" value="${storeExamine.storehouse }" readOnly autocomplete="off" readOnly id="storehouse" name="storehouse">
							
				</div>
			</div>
			
			
			<div class="layui-inline wareHouse" style="display:none;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required" value="${storeExamine.manager }" readOnly autocomplete="off" readOnly id="manager" name="manager">
				</div>
			</div>
		 </c:if>
		

		
		
		<c:if test="${storeExamine.examineType == '企业自评'}">

		  <div class="layui-inline enterprise" style="display:none;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${storeExamine.examineSerial }" readOnly autocomplete="off"">
				</div>
		  </div>
			<div class="layui-inline enterprise" style="display:none;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称：</label>
				<div class="layui-input-inline">
				<input class="layui-input" placeholder="请选择"  value="${storeExamine.storehouse }" readOnly autocomplete="off"  id="enterpriseName" name="enterpriseName">
				</div>
			</div>


			  <div class="layui-inline enterprise" style="display:none;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">

					<input class="layui-input"   value="${storeExamine.manager }" autocomplete="off" readOnly id="enterpriseManager" name="enterpriseManager">
				</div>
			</div>
		 </c:if>
		  <c:if test="${storeExamine.examineType != '企业自评'}">
		  	  <div class="layui-inline enterprise" style="display:inline-block;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${storeExamine.examineSerial }" readOnly autocomplete="off"">
				</div>
			</div>
			  <div class="layui-inline enterprise" style="display:inline-block;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称：</label>
				<div class="layui-input-inline">
				<input class="layui-input" placeholder="请选择"   value="${storeExamine.storehouse }" readOnly autocomplete="off"  id="enterpriseName" name="enterpriseName">
				</div>
			</div>


			  <div class="layui-inline enterprise" style="display:inline-block;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">

					<input class="layui-input"   value="${storeExamine.manager }" autocomplete="off" readOnly id="enterpriseManager" name="enterpriseManager">
				</div>
			</div>
		 </c:if>

		</shiro:hasPermission>
			
		<shiro:lacksPermission name="StoreExamine:storehouse">  
		
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${storeExamine.examineSerial }"  readOnly autocomplete="off" >
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  value="${storeExamine.storehouse }" lay-verify="required" readOnly autocomplete="off" readOnly id="storehouse" name="storehouse">
					<%--<select class="layui-input" lay-filter="storehouse" lay-verify="required" name="storehouse"
						id="storehouse">
						
						  <c:forEach var="item" items="${storehouses}" varStatus="status">
						 <c:if test="${storeExamine.storehouse == item.value}">
						  <option class="${ status.index + 1}" selected="selected" value="${item.value}">${item.value }</option>
						 </c:if>
						  <c:if test="${storeExamine.storehouse != item.value}">
						  <option  class="${ status.index + 1}" value="${item.value}">${item.value }</option>
						 </c:if>
						</c:forEach>										
					</select>					--%>
				</div>
			</div>
			
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  value="${storeExamine.manager }" lay-verify="required" readOnly autocomplete="off" readOnly id="manager" name="manager">
				</div>
			</div>
		
		</shiro:lacksPermission>
		
		
	
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" value="${storeExamine.examineName }"  autocomplete="off" id="examineName" name="examineName">
				</div>
			</div>
			<shiro:hasPermission name="StoreExamine:storehouse">  
				<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评方式：</label>
				<div class="layui-input-inline">
				<input class="layui-input"   value="${storeExamine.examineType }" autocomplete="off" >
				
				
				</div>
				</div>
			</shiro:hasPermission>
			<!-- 没有权限显示 -->
			<shiro:lacksPermission name="StoreExamine:storehouse">  
				<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评方式：</label>
				<div class="layui-input-inline">
						<input class="layui-input"   value="${storeExamine.examineType }" autocomplete="off" >			
				</div>
				</div>
				
			
			</shiro:lacksPermission>
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评类型：</label>
				<div class="layui-input-inline">
				<input class="layui-input" lay-verify="required" value="${storeExamine.examineTempletType }" readOnly  autocomplete="off" id="examineTempletType" name="examineTempletType">
					<%-- <select class="layui-input" lay-filter="examineTempletType" lay-verify="required" name="examineTempletType" 
						id="examineTempletType">
						<c:if test="${storeExamine.examineTempletType == '四化粮库'}">
						  <option selected="selected" value="四化粮库">四化粮库</option>
						 </c:if>
						  <c:if test="${storeExamine.examineTempletType != '四化粮库'}">
						  <option  value="四化粮库">四化粮库</option>
						 </c:if>
						  <c:if test="${storeExamine.examineTempletType == '星级粮库'}">
						  <option selected="selected" value="星级粮库">星级粮库</option>
						 </c:if>
						  <c:if test="${storeExamine.examineTempletType != '星级粮库'}">
						  <option  value="星级粮库">星级粮库</option>
						 </c:if>				
											
					</select>		 --%>			
				</div>
				</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" lay-verify="required" value="${storeExamine.examineTime }"  autocomplete="off"  name="examineTime" readonly>
				</div>
			</div>
	
			
			<div class="layui-inline">
				
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评组成员：</label>
					<div class="layui-input-inline">
						<input class="layui-input" lay-verify="required" value="${storeExamine.inspectors }"  placeholder="名字请用逗号隔开" autocomplete="off" id="inspectors" name="inspectors">
				    
				</div>
			 </div>
			
			
			
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评模板：</label>
				<div class="layui-input-inline">
					<input style="text-align:left;" type="button" value="${storeExamine.examineTemplet }"  onclick="toAddTemplet()" class="layui-input" lay-verify="required" autocomplete="off" readOnly id="examineTemplet" >
				</div>
			</div>
	
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>模板名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  readOnly autocomplete="off" value="${storeExamine.templetName }"  id="templetName" name="templetName">
				</div>
			</div>
			 <c:if test="${not empty sysFile}">
               
              <div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">已经上传的附件：</label>
				<div class="layui-input-inline">
					<input type="hidden" name="pictureId" id="pictureId" />
					<a style="color:red;margin:auto 20px;" href="${ctx}/sysFile/download.shtml?fileId=${sysFile.id}">${sysFile.fileName }</a>
					<div style="display:inline-block;font-size:20px;" id="openExce">
						<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${sysFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
							预览
						</a>
						<a href="javascript:openAnnex('${sysFile.id}')" id="openFile" style="display: none">
							预览
						</a>
					</div>
				</div>
				</div>
            	 <div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">更换附件：</label>
				<div class="layui-input-inline">
					<input type="file" name="file" class="form-control "/>
				</div>
				</div>
           
             </c:if>  
                <c:if test="${empty sysFile }">
               
             	<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">附件</label>
				<div class="layui-input-inline">
					<input type="file" name="file" class="form-control "/>
				</div>
				</div>
             </c:if>    
			
			
		</div>	
		<div id="template" class="layui-row title">
			<h5>考核内容</h5>
		</div>
		
		
        <p  class="btn-box text-center">
             <a type="button"  class="layui-btn layui-btn-primary layui-btn-small reback">返回</a>
             
        </p>
  	
       

    </form>
 
</div>				       


<script>
    if ("${storeExamine.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
	$("input").attr("readOnly","true");
 	$("textarea").attr("readOnly","true");	
	
	 $(".reback").click(function(){
         history.go(-1);
			//location.href="${ctx}/StoreExamine.shtml?";
		
	});

  var  alltotal=0;

layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	
 
    form.on('select(storehouse)', function(data){
   var index= $(data.elem).find("option:selected").attr("class");
    $("#manager").val($('#'+index).val());
	});
	
	     form.on('select(examineType)', function(data){
		var value=  $(data.elem).find("option:selected").val();
		  if(value=='检查考评'){
		    $(".enterprise").css("display","inline-block");
		     $(".wareHouse").css("display","none");
		      $("#enterpriseName").attr("lay-verify","required");
		  }else{
		  	  $(".enterprise").css("display","none");
		  	  $(".wareHouse").css("display","inline-block");
		  	  $("#enterpriseName").removeAttr("lay-verify");
	
		  }
     
	});
	
	
  //监听提交
  form.on('submit(save)', function(data){
         layer.load();
     var inspectorType = $('#inspectorType').val();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
					 layer.closeAll('loading');			
					location.href="${ctx}/StoreExamine.shtml?";
				}
				}); 
    return false;
  });
  
  
});
 $('.dropdown-mul-2').dropdown({
      searchable: false,
      choice: function() {
      
      }
    });

    
	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#examineTime' //指定元素
	  });
	});

	 $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
					location.href="${ctx}/StoreExamine.shtml?";
			});
		
	});
	
 function toAddEnterpriseName(){
    var storehouse = $("#storehouse").val();
     storehouse=encodeURI(encodeURI(storehouse));
	$.colorbox({
		title : '选择考核企业',
		iframe : true,
		opacity	: 0.2,
		href : "${ctx}/StoreExamine/select_EnterpriseName_list.shtml?storehouse="+storehouse,
		innerWidth : '800px',
		innerHeight : '75%',
		close : '×15151',
		fixed : true
	});
}	


function callEnterpriseNameSelect(data){
	$("#enterpriseName").val(data.enterpriseName);
	$("#enterpriseManager").val(data.personIncharge);
}
	
 function toAddTemplet(){
/* 	$.colorbox({
		title : '选择考核模板',
		iframe : true,
		opacity	: 0.2,
		href : "${ctx}/StoreExamine/select_templet_list.shtml?",
		innerWidth : '800px',
		innerHeight : '75%',
		close : '×15151',
		fixed : true
	}); */
}	


 function callTemplateSelect(data){
  
  var type =$("#examineTempletType").val();
 	if(type=='星级粮库'){
 		type="0";
 		var templateId =  $("input[name='examineTemplet']").val();
 	var examineSerial =$("#examineSerial").val();
 	 layer.load();
	 $.ajax({
	  type: 'POST',
	 url:"${ctx}/StoreExamine/getStoreTemplate.shtml?templateId="+templateId+"&examineId="+examineSerial+"&type=0",
	  dataType: "json",
	  success:function(data){
	    $("#templateTab").remove();
	     layer.closeAll('loading');
	 	var table='<table class="td-size" id="templateTab" cellpadding="1" cellspacing="1" border="1">'
				     +'<thead>'
				     +'<tr>'
				         +'<th  style="width: 20%;" colspan="2"><p  style="text-align: center">'+data.data.itemName+'</p></th>'
				         +'<th  style="width: 70%;"  ><p  style="text-align: center">考核内容</p></th>'
				         +'<th  ><p  style="text-align: center">分数</p></th>'
				     +'</tr>'  
				      +'</thead>';
				      
		  for(var i=0;i<data.data.children.length;i++){
		      var item = data.data.children[i];
		     table+='<tbody>'		 
				 	  +'<tr>'
				 	  +'<td rowspan='+item.rowspan+'>'+'&nbsp;&nbsp;'+item.itemName+'</td>';
				 	   for(var j=0;j<item.children.length;j++){
				 	   	 var item1 = item.children[j];
				 	   	    table+='<td rowspan='+item1.children.length+'>'+'&nbsp;&nbsp;'+item1.itemName+'</td>';
				 	   	      for(var k=0;k<item1.children.length;k++){
				 	   	        var num = parseInt(k)+1;
				 	   	       var item2 = item1.children[k];
				 	   	       
				 	   	        
				 	   	         if(k==0){
				 	   	         	 table+='<td><input type="hidden"  value='+item2.parentId+' name="parentId" /><input type="hidden"  value='+item2.itemName+' name="itemName" /><input type="hidden"  value='+item2.standard+' name="standard" />'+'&nbsp;&nbsp;'+num+'.&nbsp;&nbsp;'+item2.itemName+'('+item2.standard+'分)'+'</td>'
		     			  			  +'<td><span style="display: none">'+item2.standard+'</span> <input style="text-align: center" onchange="changeStandard(this)" name="point"  lay-verify="required" readonly value='+item2.point+' type="text"/></td> </tr>	';
				 	   	         }else{
				 	   	         
								table+='<tr><td ><input type="hidden"  value='+item2.parentId+' name="parentId" /><input type="hidden"   value='+item2.itemName+' name="itemName" /><input type="hidden" value='+item2.standard+' name="standard" /> '+'&nbsp;&nbsp;'+num+'.&nbsp;&nbsp;'+item2.itemName+'('+item2.standard+'分)'+'</td>'
		     			  			  +'<td ><span style="display: none">'+item2.standard+'</span><input  style="text-align: center" onchange="changeStandard(this)" name="point"  lay-verify="required" readonly value='+item2.point+' type="text"/></td> </tr>'	;
		   					
				 	   	         }
				 	   	      }
				 	   }
				 	   table+='</tbody>';
				 	   
				 	  
		  }
		  
		  	var points =  $("input[name='points']").val();
		   table+='<tbody>'		 
				 	  +'<tr>'
				 	  +'<td  style="text-align: right"; colspan="3">'+'总分'+'</td>'
				 	  +'<td  style="text-align: center"; colspan="1"><span id="alltotal">'+points+'</span></td>'
				 	  +'</tr>'
				 	  +'</tbody>';
	 	$("#template").after(table);
	 
	 
	 	
       } 
	  });
 	}else{
 	var templateId =  $("input[name='examineTemplet']").val();
 	var examineSerial =$("#examineSerial").val();
 	layer.load();
	 $.ajax({
	  type: 'POST',
	 url:"${ctx}/StoreExamine/getStoreTemplate.shtml?templateId="+templateId+"&examineId="+examineSerial+"&type=1",
	  dataType: "json",
	  success:function(data){
	    layer.closeAll('loading');
	    $("#templateTab").remove();
	 		var table='<table class="td-size" id="templateTab" cellpadding="1" cellspacing="1" border="1">'
				     +'<thead>'
				     +'<tr>'
				         +'<th  style="width: 15%;" ><p  style="text-align: center">'+data.data.itemName+'</p></th>'
				            +'<th  style="width: 5%;" ><p  style="text-align: center">'+'分值'+'</p></th>'
				         +'<th  style="width: 70%;"  ><p  style="text-align: center">考核内容</p></th>'
				         +'<th  ><p  style="text-align: center">分数</p></th>'
				     +'</tr>'  
				      +'</thead>';
				      
		  for(var i=0;i<data.data.children.length;i++){
		      var item = data.data.children[i];
		     table+='<tbody>'		 
				 	  +'<tr>'
				 	  +'<td rowspan='+item.rowspan+'>'+'&nbsp;&nbsp;'+item.itemName+'</td>';
				 	   for(var j=0;j<item.children.length;j++){
				 	   	 var item1 = item.children[j];
				 	   	   /*  table+='<td >'+'&nbsp;&nbsp;'+item1.itemName+'</td>';
				 	   	    +'<td >'+'&nbsp;&nbsp;'+item1.itemName+'</td>'
				 	   	    +'<td >'+'&nbsp;&nbsp;'+item1.itemName+'</td>' */
				 	   	      for(var k=0;k<item1.children.length;k++){
				 	   	        var num = parseInt(k)+1;
				 	   	       var item2 = item1.children[k];
				 	   	       
				 	   	        
				 	   	         if(k==0){
				 	   	         	 table+= '<td style="text-align: center">'+'&nbsp;&nbsp;'+item2.standard+'</td>'
				 	   	         	 +'<td><input type="hidden"  value='+item2.parentId+' name="parentId" /><input type="hidden"   value='+item2.itemName+' name="itemName" /><input type="hidden"  value='+item2.standard+' name="standard" />'+'&nbsp;&nbsp;'+num+'.&nbsp;&nbsp;'+item2.itemName+'</td>'
		     			  			 
		     			  			 		     			  			   +'<td ><span style="display: none">'+item2.standard+'</span><input  style="text-align: center" onchange="changeStandard(this)" name="point" readonly lay-verify="required"  value='+item2.point+' type="text"/></td> </tr>'	;
				 	   	         }else{
				 	   	         
								table+= '<tr><td style="text-align: center">'+'&nbsp;&nbsp;'+item2.standard+'</td><td><input type="hidden"  value='+item2.parentId+' name="parentId" /><input type="hidden"   value='+item2.itemName+' name="itemName" /><input type="hidden" value='+item2.standard+' name="standard" /> '+'&nbsp;&nbsp;'+num+'.&nbsp;&nbsp;'+item2.itemName+'</td>'
		     			  			   +'<td ><span style="display: none">'+item2.standard+'</span><input  style="text-align: center" onchange="changeStandard(this)" name="point" readonly lay-verify="required"  value='+item2.point+' type="text"/></td> </tr>'	;
		   					
				 	   	         }
				 	   	      }
				 	   }
				 	   table+='</tbody>';
				 	   
				 	  
		  }
		  	var points =  $("input[name='points']").val();
		    table+='<tbody>'		 
				 	  +'<tr>'
				 	  +'<td  style="text-align: right"; colspan="3">'+'总分'+'</td>'
				 	  +'<td  style="text-align: center"; colspan="1"><span id="alltotal">'+points+'</span></td>'
				 	  +'</tr>'
				 	  +'</tbody>';
	 	$("#template").after(table);
	 
	 
	 	
       } 
	  });
 	}
 	
 	
 	}
 	
 	function changeStandard(ob){
 	  if(isNaN($(ob).val())){
   		 alert("请输入数字");
   		  $(ob).val("");
   		  return;
  		 }
 	  var standard =parseInt($(ob).val());
 	  var text =parseInt($(ob).siblings("span").text());
 	  if(standard>text){
 	  	 alert("请输入小于或等于标准分的数字");
 	  	  $(ob).val("0");
 	  	  return;
 	  } if(standard<0){
            alert("请输入大于或等于0的数字");
            $(ob).val("0");
            return;
        }
 	   	
 	   //计算总分
 	  var alltotal = 0;
 	    $("input[name='point']").each(function(){
 	    
 	       if($(this).val()!=""){
 	        alltotal = parseInt($(this).val())+alltotal;
 	       }
		   
		  });
		  $("#alltotal").text(alltotal);
		   $("input[name='points']").val(alltotal);
		  
 	}
 	
 	callTemplateSelect();


</script>




