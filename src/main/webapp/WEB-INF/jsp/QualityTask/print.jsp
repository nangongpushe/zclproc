<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="../common/AdminHeader.jsp"%>

<div class="row clear-m">
   <ol class="breadcrumb">
		<li>质量管理</li>
		<li>质量档案</li>
		<li class="active">打印检验任务</li>
	</ol>
	<div class="container-box clearfix" style="padding: 10px">
    <!--检验结果表-->
     <form class="form_input"  action="save.shtml" method="post" enctype="multipart/form-data">
     <input type="hidden" name="auvp" value="${auvp}">
     <input type="hidden" name="id"  value="${entity.id }"/>
        <table class="table table-bordered">
            <!-- 表格内容 start -->
            <tbody>
             <tr>
                <td class="text-right"><span class="red">*</span><b>任务编号:</b></td>
                <td>${entity.taskSerial }</td>
                <td  class="text-right"><span class="red">*</span><b>任务名称:</b></td>
                <td >${entity.taskName }</td>              
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>样品编号:</b></td>
                <td>${entity.sampleNo }
                </td>
                <td  class="text-right"><span class="red">*</span><b>库点名称:</b></td>
                <td >${entity.wearhouse }</td>              
            </tr>
             <tr>
                <td class="text-right"><span class="red">*</span><b>任务优先级:</b></td>
                <td>${entity.taskPriority }
                </td>
                <td  class="text-right"><span class="red">*</span><b>任务执行人:</b></td>
                <td >${entity.taskExecutor }</td>              
            </tr>
              <tr>
                <td class="text-right"><span class="red">*</span><b>检验类型:</b></td>
                <td>${entity.inspectionType }
                </td>
                <td  class="text-right"><span class="red">*</span><b>计划检验时间:</b></td>
                <td >${entity.plannedInspectionTime }</td>              
             </tr>
             <tr>
                <td class="text-right"><span class="red">*</span><b>实际检验时间:</b></td>
                <td>${entity.actualInspectionTime }</td>
                <td  class="text-right"><span class="red">*</span><b>任务状态:</b></td>
                <td >${entity.taskStatus }
                </td>              
            </tr>
             <tr>
             	<td class="text-right"><span class="red">*</span><b>任务创建人:</b></td>
                <td>${entity.creator }
                </td>
                <td class="text-right"><span class="red">*</span><b>任务创建时间:</b></td>
                <td>${entity.createDate}
                </td>
            </tr>
            <tr>
                    <td class="text-right"><span>&nbsp;&nbsp;</span><b>备注：</b></td>
                    <td colspan="3">${entity.remark }</td>
                </tr>
            <!-- 表格内容 end -->
            </tbody>
        </table>
        <p class="btn-box text-center">
             <button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
            <button type="button" id="btnPrint"  class="layui-btn layui-btn-primary layui-btn-small ">打印</button>
        </p>
  

    </form>
    <div class="jumpPage" id="displayPage"></div>
</div>
</div>

<script>
 $("#cancel").click(function(){
		layer.confirm('您是否要放弃', function(index) {
				history.go(-1);
			});
		
	});
	 $("#btnPrint").click(function(){
		$('#cancel').hide();
		$('#btnPrint').hide();	
		window.print();	
		$('#cancel').show();
		$('#btnPrint').show();	
	});
	
	
	

	
</script>
