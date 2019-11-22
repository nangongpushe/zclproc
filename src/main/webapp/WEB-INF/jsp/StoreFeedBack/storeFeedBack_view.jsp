<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">
#search .layui-form-label{
    width: 130px ;
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
      <div class="layui-row">
      	
		
		<div class="layui-col-md4">
			<span>问题反馈名称:</span> <span data-field="department">${storeFeedBack.feedbackName }</span>
		</div>
	
		<c:if test="${empty storeFeedBack.enterpriseName }">
			<div class="layui-col-md4">
				<span>库点名称:</span> <span data-field="department">${storeFeedBack.storehouse }</span>			
			</div>
			<div class="layui-col-md4">
				<span>库点负责人:</span> <span data-field="department">${storeFeedBack.manager }</span>
			</div>
		</c:if>
		<c:if test="${not empty storeFeedBack.enterpriseName}">
			<div class="layui-col-md4">
				<span>库点名称:</span> <span data-field="department">${storeFeedBack.enterpriseName }</span>			
			</div>
			<div class="layui-col-md4">
				<span>库点负责人:</span> <span data-field="department">${storeFeedBack.enterpriseManager }</span>
			</div>
		</c:if>
		
	</div>
	
	 <div class="layui-row">
	 	<div class="layui-col-md4">
			<span>考评编号:</span> <span style="color:red;" id="examineSerial" onclick="examineSerial()" data-field="department">${storeFeedBack.examineSerial }</span>
		</div>
		<div class="layui-col-md4">
			<span>填表时间:</span> <span data-field="department">${storeFeedBack.reportDate }</span>
		</div>
		<div class="layui-col-md4">
			<span>检查组负责人:</span> <span data-field="department">${storeFeedBack.inspectorManager }</span>
		</div>
		
		
	</div>
	
	<div class="layui-row">
	 	
		<div class="layui-col-md4">
			<span>检查人员:</span> <span data-field="department">${storeFeedBack.inspectors }</span>
		</div>
		
		<c:if test="${not empty sysFile}">
               
              <div class="layui-col-md4">
              <span>已经上传的附件：</span>
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
				
           
             </c:if>  
                <c:if test="${empty sysFile }">
               
             	<div class="layui-inline">
				 <span>附件：</span>
				暂无
				</div>
             </c:if>    
		
	</div>
   
     
       		
       	 <hr class="layui-bg-green">

        	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
			<tr>
				<td style="width:100px;text-align: center">序号</td>
				<td style="text-align:center">问题类别</td>
				<td style="text-align:center">检查发现问题及详细情况描述</td>
				<td style="text-align:center">整改建议</td>
				<td style="text-align:center">整改情况</td>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${storeFeedBackDeatils}" var="item" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${item.type}</td>
					<td>${item.description}</td>
					<td>${item.advise}</td>
					<td>${item.rectification}</td>
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
      
        
        <p class="btn-box text-center">
              <%--<a type="button"  class="layui-btn layui-btn-primary layui-btn-small reback">返回</a>--%>
			<button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">返回</button>
            
        </p>
  	
       

    
</div>



<script>


    if ("${sysFile.id}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
	function examineSerial(){
	
		location.href = "${ctx}/StoreExamine/view.shtml?id="
					+ $("#examineSerial").text();
	}
	
	layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#reportDate' //指定元素
	  });
 
  
  
  
});
	$("input").attr("readOnly","true");
 	$("textarea").attr("readOnly","true");	
	
	 $(".reback").click(function(){
			history.go(-1);
		
	});

    $("#cancel").click(function(){
            history.go(-1);
    });

</script>
