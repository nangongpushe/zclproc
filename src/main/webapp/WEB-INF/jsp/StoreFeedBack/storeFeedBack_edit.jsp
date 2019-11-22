<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


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
		<li class="active">问题反馈表管理</li>
	</ol>
</div>

<!-- <div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>星级粮库</li>
		<li class="active">问题反馈表管理</li>
	</ol>
</div> -->
 
<div class="container-box clearfix" style="padding: 10px">
      
		 <c:forEach var="item" items="${manangers}" varStatus="status">
		  <input type="hidden" id="${status.index + 1}"  value="${item }" />						
		</c:forEach>	
     <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
      <input type="hidden" name="id"  value="${storeFeedBack.id }"/>
     <input type="hidden" name="feedbackSerial"  value="${storeFeedBack.feedbackSerial }"/>
     
       <div class="layui-form" id="search" >
       <div  class="layui-form-item">
       <%--  <shiro:hasAnyRoles name="库点管理员">   --%> 
         <%--  <input   type="hidden"  id="feedbackName" value="${storeFeedBack.feedbackName }" name="feedbackName"> --%>
         <%--  <c:if test="${storeFeedBack.inspectorType == '自检'}">
		
			<div class="layui-inline wareHouse" style="display:inline-block;">
				<label class="layui-form-label"><span class="red">*</span>问题反馈名称：</label>
				<div class="layui-input-inline">
						<input class="layui-input" onchange="changeFeedbackName(this)" value="${storeFeedBack.feedbackName }" lay-verify="required" autocomplete="off" id="feedbackName1" >
				</div>
			</div>
			
	
			<div class="layui-inline wareHouse" style="display:inline-block;">
				<label class="layui-form-label"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">
				<input class="layui-input"  lay-verify="required" value="${storeFeedBack.storehouse }"  readOnly autocomplete="off" readOnly id="storehouse" name="storehouse">
							
				</div>
			</div>
			
			
			<div class="layui-inline wareHouse" style="display:inline-block;">
				<label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input"   value="${storeFeedBack.manager }" readOnly autocomplete="off" readOnly id="storehouse" name="manager">
				</div>
			</div>
		 </c:if>
		 
		   <c:if test="${storeFeedBack.inspectorType != '自检'}">
			<div class="layui-inline wareHouse" style="display:none;">
				<label class="layui-form-label"><span class="red">*</span>问题反馈名称：</label>
				<div class="layui-input-inline">
						<input class="layui-input" onchange="changeFeedbackName(this)" value="${storeFeedBack.feedbackName }" lay-verify="required" autocomplete="off" id="feedbackName1" >
				</div>
			</div>
			
	
			<div class="layui-inline wareHouse" style="display:none;">
				<label class="layui-form-label"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">
				<input class="layui-input"  lay-verify="required" value="${storeFeedBack.storehouse }"  readOnly autocomplete="off" readOnly id="storehouse" name="storehouse">
							
				</div>
			</div>
			
			
			<div class="layui-inline wareHouse" style="display:none;">
				<label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input"   value="${storeFeedBack.manager }" readOnly autocomplete="off" readOnly id="storehouse" name="manager">
				</div>
			</div>
		 </c:if> --%>
		
			

		
		<%--   <c:if test="${storeFeedBack.inspectorType == '自检'}"> --%>
		
		  <div class="layui-inline enterprise" >
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>问题反馈名称：</label>
				<div class="layui-input-inline">
						<input class="layui-input"   value="${storeFeedBack.feedbackName }" maxlength="15" autocomplete="off" name="feedbackName" >
				</div>
			</div>
			
			 <c:if test="${storeFeedBack.inspectorType == '自检'}">
			<div class="layui-inline "  style="display:inline-block;">
			
		
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">
				<input class="layui-input"  lay-verify="required" value="${storehouse}" readOnly autocomplete="off" readOnly id="storehouse" name="storehouse">
				<input type="hidden" name="warehouseId" value="${warehouseId}">
				</div>
			</div>
			 </c:if>
			   <c:if test="${storeFeedBack.inspectorType != '自检'}">
			
			
			 <div class="layui-inline "  style="display:inline-block;">
			
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">
					<select class="layui-input"  lay-filter="storehouse" lay-verify="required" name="warehouseId"
						id="storehouse">
						
						  <c:forEach var="item" items="${storehouses}" varStatus="status">
						 <c:if test="${storeFeedBack.warehouseId == item.id}">
						  <option class="${ status.index + 1}" selected="selected" value="${item.id}">${item.warehouseShort }</option>
						 </c:if>
						  <c:if test="${storeFeedBack.warehouseId != item.id}">
						  <option  class="${ status.index + 1}" value="${item.id}">${item.warehouseShort }</option>
						 </c:if>
						</c:forEach>										
					</select>					
				</div>
			</div>
			 </c:if>
			<div class="layui-inline " style="display:inline-block;">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input" readonly  lay-verify="required" value="${storeFeedBack.manager }" maxlength="15"  autocomplete="off"  id="manager" name="manager">
				</div>
			</div>
			
		<%--  <div class="layui-inline enterprise" style="display:none;">
				<label class="layui-form-label"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">				
				<input class="layui-input" placeholder="请选择"  value="${storeFeedBack.enterpriseName }"  onclick="toAddEnterpriseName()"   readOnly autocomplete="off"  id="enterpriseName" name="enterpriseName">				
				</div>
			</div>
			
			
			 <div class="layui-inline enterprise" style="display:none;">
				<label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					
					<input class="layui-input"     value="${storeFeedBack.enterpriseManager }" readOnly id="enterpriseManager" name="enterpriseManager">
				</div>
			</div>
		 </c:if> --%>
		 
		  <%--  <c:if test="${storeFeedBack.inspectorType != '自检'}">
		  <div class="layui-inline enterprise" style="display:inline-block;">
				<label class="layui-form-label"><span class="red">*</span>问题反馈名称：</label>
				<div class="layui-input-inline">
						<input class="layui-input" onchange="changeFeedbackName(this)"  value="${storeFeedBack.feedbackName }"  autocomplete="off" id="feedbackName2" >
				</div>
			</div>
		 <div class="layui-inline enterprise" style="display:inline-block;">
				<label class="layui-form-label"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">				
				<input class="layui-input" placeholder="请选择"  value="${storeFeedBack.enterpriseName }"  onclick="toAddEnterpriseName()"   readOnly autocomplete="off"  id="enterpriseName" name="enterpriseName">				
				</div>
			</div>
			
			
			 <div class="layui-inline enterprise" style="display:inline-block;">
				<label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					
					<input class="layui-input"     value="${storeFeedBack.enterpriseManager }" readOnly id="enterpriseManager" name="enterpriseManager">
				</div>
			</div>
		 </c:if>

		</shiro:hasAnyRoles>
			
		<shiro:lacksRole name="库点管理员">    --%> 
		
			<%-- <div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>问题反馈名称：</label>
				<div class="layui-input-inline">
						<input class="layui-input" lay-verify="required" value="${storeFeedBack.feedbackName }" autocomplete="off"  name="feedbackName">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-filter="storehouse" lay-verify="required" name="storehouse" 
						id="storehouse">
						
						  <c:forEach var="item" items="${storehouses}" varStatus="status">
						 <c:if test="${storeFeedBack.storehouse == item.value}">
						  <option class="${ status.index + 1}" selected="selected" value="${item.value}">${item.value }</option>
						 </c:if>
						  <c:if test="${storeFeedBack.storehouse != item.value}">
						  <option  class="${ status.index + 1}" value="${item.value}">${item.value }</option>
						 </c:if>
						</c:forEach>													
					</select>					
				</div>
			</div>
			
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required" value="${storeFeedBack.manager }" readOnly autocomplete="off" readOnly id="manager" name="manager">
				</div>
			</div>
			
			
	
		</shiro:lacksRole>
		
			
			
			<shiro:hasAnyRoles name="库点管理员">   --%> 
				<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>类型:</label>
				<div class="layui-input-inline">
						
					<select class="layui-input"  lay-filter="inspectorType" lay-verify="required" name="inspectorType" 
						id="inspectorType">
						<c:if test="${storeFeedBack.inspectorType == '自检'}">
						  <option selected="selected" value="自检">自检</option>
						 </c:if>
						<%--   <c:if test="${storeFeedBack.inspectorType != '自检'}">
						  <option  value="自检">自检</option>
						 </c:if> --%>
						  <c:if test="${storeFeedBack.inspectorType == '检查'}">
						  <option selected="selected" value="检查">检查</option>
						 </c:if>
						 <%--  <c:if test="${storeFeedBack.inspectorType != '检查'}">
						  <option  value="检查">检查</option>
						 </c:if>	 --%>				
						
										
					</select>				
				</div>
				</div>
			<%-- </shiro:hasAnyRoles>
			<!-- 没有权限显示 -->
			<shiro:lacksRole name="库点管理员">    --%> 
			<%-- 	<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>类型:</label>
				<div class="layui-input-inline">
						
					<select class="layui-input"  lay-verify="required" name="inspectorType" 
						id="inspectorType">
						
						<option selected="selected" value="检查">检查</option>
										
					</select>				
				</div>
				</div>
				
			
			</shiro:lacksRole> --%>
			
		
		
				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>填表时间：</label>
					<div class="layui-input-inline">
						<input class="layui-input" lay-verify="required" value="${storeFeedBack.reportDate }" autocomplete="off" id="reportDate" name="reportDate">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>检查组负责人:</label>
					<div class="layui-input-inline">
					
						<input class="layui-input" lay-verify="required" onclick="toAddInspectorManager('1','inspectorManager')"   readOnly autocomplete="off" value="${storeFeedBack.inspectorManager }" id="inspectorManager" name="inspectorManager">
					</div>
				</div>
	
				<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评编号</label>
				<div class="layui-input-inline">
						<input class="layui-input" readOnly onclick="changeExamineSerial(this)" lay-verify="required" value="${storeFeedBack.examineSerial }" name="examineSerial" id="examineSerial" >
				</div>
		 		</div>
				<div class="layui-inline">
					
				 <label class="layui-form-label" style="text-align:right"><span class="red">*</span>检查人员：</label>
					<div class="layui-input-inline"   style="width:65%;" >
						<input  style="display:inline-block;width:85%;" value="${storeFeedBack.inspectors }"  class="layui-input" lay-verify="required" onclick="toAddInspectorManager('2','inspectors')"   readOnly   placeholder="请选择"  id="inspectors" name="inspectors">
				    <%--<a style="width:10px;" onclick="cleanInspectors();" >清空</a>
						<a style="width:10px;" onclick="cleanItemInspectors();">回删</a>--%>
				</div>
				 </div> 
				 <c:if test="${not empty sysFile}">
               
              <div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">已经上传的附件：</label>
				<div class="layui-input-inline">
					<input type="hidden" name="groupId"  value="${storeFeedBack.groupId}"/>
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
					 <input type="button" style="" id="clearBtn" onclick="clearFile()" value="删除附件"/>
				</div>
           
             </c:if>  
                <c:if test="${empty sysFile }">
               
             	<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">附件</label>
				<div class="layui-input-inline">
					<input type="file" name="file" class="form-control "/>
				</div>
					<input type="button" style="display: none" id="clearBtn" onclick="clearFile()" value="删除附件"/>
				</div>
             </c:if>    
			 
		</div>	
			  
		
	</div>
       		
       	 <hr class="layui-bg-green">

       
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="addMaterialName();">新增问题</button>
                
          
        	<table class="layui-table" >
                <thead>
                <tr>
                     <th style="width:8%;text-align: center">操作</th><th style="width:14%;text-align: center">问题类型</th>
                    <th style="width:30%;text-align: center">问题描述</th><th style="width:30%;text-align: center">整改建议</th><th style="text-align: center">整改情况</th>
                </tr>
                </thead>
                <!-- 表格内容start -->
                <tbody id="materialDetail" class="text-center">
                 <c:forEach items="${storeFeedBackDeatils}" var="storeFeedBackDeatil">  
                 <tr>
	                 <td style="width:8%"  ><input  type="hidden" name="feedbackId" value="${storeFeedBackDeatil.feedbackId }" style="width:0px;"/><a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDelete(this);">删除</a>	</td>
	                 <td ><input type="text" name="type" maxlength="25"  value="${storeFeedBackDeatil.type }" class="form-control validate[required]   placeholder="--请输入--"/></td>
	                  <td ><textarea type="text" name="description"  maxlength="250" class="form-control" placeholder="--限250字--">${storeFeedBackDeatil.description }</textarea></td>
	                   <td ><textarea type="text" name="advise"  maxlength="250" class="form-control" placeholder="--限250字--">${storeFeedBackDeatil.advise }</textarea></td>
	               
	               	 <td class="btn-select-parent">
	               	 <div class="layui-form-item">			
							<div class="layui-inline" style="width:100%">
		               		 <div class="layui-input-inline">
								<select class="layui-input"  name="rectification" value="${storeFeedBackDeatil.rectification }"  lay-filter="aihao" id="rectification">
								
									<c:if test="${storeFeedBackDeatil.rectification == '优秀'}"    >
              			 			 <option selected="selected" value="优秀">优秀</option>
		          				 	</c:if>
			          				 <c:if test="${storeFeedBackDeatil.rectification != '优秀'}"    >
			              			 	 <option  value="优秀">优秀</option>
			          				 </c:if>		
			          				 	<c:if test="${storeFeedBackDeatil.rectification == '良好'}"    >
              			 			 <option selected="selected" value="良好">良好</option>
		          				 	</c:if>
			          				 <c:if test="${storeFeedBackDeatil.rectification != '良好'}"    >
			              			 	 <option  value="良好">良好</option>
			          				 </c:if>	
			          				 	<c:if test="${storeFeedBackDeatil.rectification == '中等'}"    >
              			 			 <option selected="selected" value="中等">中等</option>
		          				 	</c:if>
			          				 <c:if test="${storeFeedBackDeatil.rectification != '中等'}"    >
			              			 	 <option  value="中等">中等</option>
			          				 </c:if>	
								</select>			
							</div>
							</div>
						</div>	                 
                    </td>
                   </tr>
                    </c:forEach>
                </tbody>
                <!-- 表格内容 end -->
            </table>
      
        <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
              <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
             <a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
        </p>
  	
       

    </form>
    
</div>

<script>
    if ("${sysFile.id}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
    function callUserSelect_inspectorManager(data){
        $('#inspectorManager').val(data.data.name);
    }
    function callUserSelect_inspectors(data){
        $('#inspectors').val(data.data.name);
    }
</script>
<script>
 var num ="";
 
function toAddInspectorManager(a,eles){
    var inspectorManager = $("#inspectorManager").val();
    num=a;
	$.colorbox({
		title : '选择人员',
		iframe : true,
		opacity	: 0.2,
		href : "${ctx}//StoreFeedBack/select_user_list.shtml?storehouse="+$("#storehouse option:selected").html()+"&inspectorManager="+inspectorManager+"&temp_page="+eles,
		innerWidth : '800px',
		innerHeight : '75%',
		close : '×15151',
		fixed : true
	});
}	

function callUserSelect(data){
    if(num=="1"){
   	$("#inspectorManager").val(data.name);
   }else if(num=='2'){
        var inspectors= $("#inspectors").val();
        if(inspectors==""){
            $("#inspectors").val(data.name);
        }else{
            //是否重复
            var   temp=  inspectors+',';
            var   name=data.name+',';
            if(temp.indexOf(name) == -1){
                $("#inspectors").val(inspectors+','+data.name);
            }else {

            }
        }
   }
	
}

 function cleanInspectors(){
   $("#inspectors").val("");
 }
 function cleanItemInspectors(){
     var inspectors= $("#inspectors").val();
     var le=inspectors.toString().split(",").length;
     le--;
     var names="";
     for (var i=0;i<le;i++){
         if (names==""){
             names+=inspectors.toString().split(",")[i];
         }else{
             names+=","+inspectors.toString().split(",")[i];
         }
     }
     $("#inspectors").val(names);
 }


/*  function changeFeedbackName(ob){
	
	$("#feedbackName").val($(ob).val());
	$("#feedbackName1").val($(ob).val());
	$("#feedbackName2").val($(ob).val());
} */

layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#reportDate' //指定元素
	  });
 
    form.on('select(storehouse)', function(data){
   var index= $(data.elem).find("option:selected").attr("class");
   /*  $("#manager").val($('#'+index).val()); */
	});
	 form.on('select(inspectorType)', function(data){
		var value=  $(data.elem).find("option:selected").val();
		  if(value=='检查'){
		       $("#wareHouse2").css("display","inline-block");
		     $("#wareHouse1").css("display","none");
		  }else{
		  	  
		  	   $("#wareHouse2").css("display","none");
		  	  $("#wareHouse1").css("display","inline-block");
	
		  }
     
	});
   //监听提交
  form.on('submit(save)', function(data){
      layer.load();
   	$(".layui-form").ajaxSubmit({
				type:"post",
				success:function(data){
				 layer.closeAll('loading');
					layer.msg("保存成功",{icon:1}, function(){
						  location.href="${ctx}/StoreFeedBack.shtml?";
						})
					
				}
				}); 
    return false;
  });
  
  
});

function changeExamineSerial(){

    
	$.colorbox({
		title : '选择考评编号',
		iframe : true,
		opacity	: 0.2,
        href : "${ctx}/StoreFeedBack/select_examineSerial_list.shtml?storehouse="+$("#storehouse option:selected").html(),

        innerWidth : '800px',
		innerHeight : '75%',
		close : '×15151',
		fixed : true
	});
}

function callExamineSerialSelect(data){
	$("#examineSerial").val(data.examineSerial);
	
}

function toAddEnterpriseName(){
    var storehouse = $("#storehouse").val();
     storehouse=encodeURI(encodeURI(storehouse));
	$.colorbox({
		title : '选择企业',
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
	
 $("#mul-2").siblings(".layui-unselect").remove();	
 
 $('.dropdown-mul-2').dropdown({
      searchable: false,
      choice: function() {
      	  $(".dropdown-clear-all").remove();	
      }
    });
    $(".dropdown-clear-all").remove();	


  
   function addMaterialName(){
       var tr =   '<tr><td  style="width:8%"><input type="hidden" name="feedbackId" style="width:0px;"/><a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDelete(this);">删除</a>	</td>'
                +'<td ><input type="text" name="type" maxlength="25" class="form-control validate[required] "   placeholder="--请输入--"/></td>'
                +'<td ><textarea type="text" name="description"  class="form-control" maxlength="250" placeholder="--限250字--"></textarea></td>'
                +'<td ><textarea type="text" name="advise"  class="form-control" maxlength="250" placeholder="--限250字--"></textarea></td>'
                 	 +'<td class="btn-select-parent">'
	               	 +'<div class="layui-form-item" >'			
							+'<div class="layui-inline" style="width:100%">'
		               		 +'<div class="layui-input-inline">'
								+'<select style="display: block;" class="layui-input"  name="rectification"   lay-filter="aihao" id="rectification">'
									+'<option value="优秀">优秀</option>'
									+'<option value="良好">良好</option>'
									+'<option value="中等">中等</option>'					
								+'</select>'			
							+'</div>'
							+'</div>'
						+'</div>'	                 
                    +'</td>'             	
                +'</tr>'
               
                
         
   	$("#materialDetail").append(tr);
   	
   }
    
    function toDelete(ob){
      $(ob).parent().parent().remove();
    }
	
  
	
	 $(".cancel").click(function(){
	  var inspectorType = $('#inspectorType').val();
		layer.confirm('您是否要放弃编辑', function(index) {
					location.href="${ctx}/StoreFeedBack.shtml?";
			});
		
	});

	
     /*    $("#storehouse>option").click(function(){
            alert($(this).attr("class"));
        }); */
//    $("#storehouse").change(function(){
//     alert($(this).val());
// });

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
</script>
	
	
</script>
