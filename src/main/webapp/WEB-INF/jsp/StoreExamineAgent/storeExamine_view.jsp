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
		<li>代储监管</li>
		<li>业务信息</li>
		<li class="active">考核评分</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	 <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
     <input type="hidden" name="id"  value="${storeExamine.id }"/>
     <input type="hidden" name="points" value="${storeExamine.points }" />
      <input type="hidden" name="examineTemplet" value="${storeExamine.examineTemplet }"/>
   
     
    
       <div class="layui-form" id="search" >
		<div class="layui-form-item">
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>考评编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${storeExamine.examineSerial }" readOnly autocomplete="off" id="examineSerial" name="examineSerial">
				</div>
			</div>
			
		
		
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>库点名称:</label>
				
				<div class="layui-input-inline">
				<input class="layui-input"  lay-verify="required" value="${storeExamine.storehouse }"  autocomplete="off" readOnly >
							
				</div>				
				
			</div>
			
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required" value="${storeExamine.manager }"  autocomplete="off" readOnly id="manager" name="manager">
				</div>
			</div>
			
			<%-- <div  class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>代储企业名称:</label>
				<div class="layui-input-inline">				
				<input class="layui-input" placeholder="请选择" onclick="toAddEnterpriseName()"  value="${storeExamine.enterpriseName }" readOnly autocomplete="off"  id="enterpriseName" name="enterpriseName">				
				</div>
			</div>
			
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>代储企业负责人：</label>
				<div class="layui-input-inline">
					
					<input class="layui-input"   value="${storeExamine.enterpriseManager }" readOnly autocomplete="off" readOnly id="enterpriseManager" name="enterpriseManager">
				</div> --%>
		<!-- 	</div> -->
		
		 <%--  <c:if test="${storeExamine.examineType != '检查考评'}">
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>库点名称:</label>
				
				<div class="layui-input-inline">
				<input class="layui-input"  lay-verify="required" value="${storeExamine.enterpriseName }"  autocomplete="off" readOnly >
							
				</div>				
				
			</div>
			
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required" value="${storeExamine.enterpriseManager }"  autocomplete="off" readOnly id="manager" name="manager">
				</div>
			</div>
		 </c:if> --%>
			
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>考评名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" value="${storeExamine.examineName }"  autocomplete="off" id="examineName" name="examineName">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red"></span>考评类型:</label>
				<div class="layui-input-inline">
				<input class="layui-input"  lay-verify="required" value="${storeExamine.examineType }"  autocomplete="off" readOnly >
							
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>考评时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" value="${storeExamine.examineTime }"  autocomplete="off" id="examineTime" name="examineTime">
				</div>
			</div>
		
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>考评组成员：</label>
					<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" value="${storeExamine.inspectors }"  autocomplete="off" >
				    	
				</div>
			</div>
			
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>考评模板:</label>
				<div class="layui-input-inline">
					<input style="text-align:left;" type="button" value="${storeExamine.examineTemplet }"  onclick="toAddTemplet()" class="layui-input" lay-verify="required" autocomplete="off" readOnly id="examineTemplet" >
				</div>
			</div>
		
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>模板名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  readOnly autocomplete="off" value="${storeExamine.templetName }"  id="templetName" name="templetName">
				</div>
			</div>
			 <c:if test="${not empty myFile}">
               
              <div class="layui-inline">
				<label class="layui-form-label">已经上传的附件：</label>
				<div class="layui-input-inline">
					<input type="hidden" name="pictureId" id="pictureId" /><a style="color:red;margin:auto 20px;" href="${ctx}/sysFile/download.shtml?fileId=${myFile.id}">${myFile.fileName }</a>
					<div style="display:inline-block;font-size:20px;" id="openExce">
						<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
							预览
						</a>
						<a href="javascript:openAnnex('${storeExamine.groupId}')" id="openFile" style="display: none">
							预览
						</a>
					</div>
				</div>
				</div>
            	
           
             </c:if>  
                <c:if test="${empty myFile }">
               
             	<div class="layui-inline">
				<label class="layui-form-label">附件</label>
				<div class="layui-input-inline">
					暂无
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
				     <!--    <div class="dropdown-mul-2" style="width:25%">
				          <select style="display:none"  id="mul-2" class ="validate[required]" name="inspectors" multiple placeholder="请选择">
				          <option value="组成员1" >组成员1</option>
				          <option value="组成员2" >组成员2</option>
				       
				        </select>
				        </div> -->
				     

<script>

    if ("${storeExamine.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }

  var  alltotal=0;

layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	
 
  
  //监听提交
  form.on('submit(save)', function(data){
      
     var inspectorType = $('#inspectorType').val();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
					
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
					location.href="${ctx}/StoreExamine.shtml";
			});
		
	});
	
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
  
  
 	var templateId =  $("input[name='examineTemplet']").val();
 	var examineSerial =$("#examineSerial").val();
	 $.ajax({
	  type: 'POST',
	 url:"${ctx}/StoreExamine/getStoreTemplate.shtml?templateId="+templateId+"&examineId="+examineSerial+"&type=0",
	  dataType: "json",
	  success:function(data){
	    $("#templateTab").remove();
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
		     			  			  +'<td><span style="display: none">'+item2.standard+'</span> <input style="text-align: center" onchange="changeStandard(this)" name="point" value='+item2.point+' type="text"/></td> </tr>	';
				 	   	         }else{
				 	   	         
								table+='<tr><td ><input type="hidden"  value='+item2.parentId+' name="parentId" /><input type="hidden"   value='+item2.itemName+' name="itemName" /><input type="hidden" value='+item2.standard+' name="standard" /> '+'&nbsp;&nbsp;'+num+'.&nbsp;&nbsp;'+item2.itemName+'('+item2.standard+'分)'+'</td>'
		     			  			  +'<td ><span style="display: none">'+item2.standard+'</span><input  style="text-align: center" onchange="changeStandard(this)" name="point" value='+item2.point+' type="text"/></td> </tr>'	;
		   					
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
	 		$("input").attr("readOnly","true");
 	$("textarea").attr("readOnly","true");	
	
	/*  $(".reback").click(function(){
			history.go(-1);
		
	}); */
	 
	 	
       } 
	  });
 	
 	}
 	
 	
 	callTemplateSelect();
		$("input").attr("readOnly","true");
 	$("textarea").attr("readOnly","true");	
	
	 $(".reback").click(function(){
			history.go(-1);
		
	});
</script>



