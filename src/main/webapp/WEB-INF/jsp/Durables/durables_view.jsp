<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">

	#data-head tr th{
		text-align: center;
	}

.layui-inline{
	width: 45% ;
}
.layui-form-item .layui-form-label{
	text-align: right;
    width: 30% ;
    max-width:120px;
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
		<li>物资管理</li>
		<li>库存管理</li>
		<li class="active">设备入库</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

    <!--检验结果表-->
      <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
    
      <input type="hidden" name="id"  value="${durables.id }"/>
      <input type="hidden" name="optionsId"  value=""/>
      <input type="hidden" name="groupId"  value="${durables.groupId}"/>
     
      <div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">物资编码：</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="encode"  value="${durables.encode }" id="encode" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>类型：</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<input class="layui-input" name="type"   value="${durables.type }" id="type" autocomplete="off">
					
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>品名：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.commodity }" name="commodity" id="commodity" autocomplete="off">
				</div>
			</div>
	
			<div class="layui-inline">
				<label class="layui-form-label ">规格型号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="model"   value="${durables.model }" id="model" autocomplete="off">
				</div>
			</div>	
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>制造单位：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.unit }" name="unit" id="unit" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red"></span>目前状态：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  name="status"   value="${durables.status }" id="status" autocomplete="off">
				</div>
			</div>
	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>金额(元)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required|number"   value="${durables.amount }" name="amount" id="amount" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>生产厂家：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.manufacturer }" name="manufacturer" id="manufacturer" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>出厂编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.serialNumber }" name="serialNumber" id="serialNumber" autocomplete="off">
				</div>
			</div>
	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>供应商：</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="supplier"   value="${durables.supplier }" id="supplier" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red"></span>随机资料：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  name="options"   value="${durables.options }" id="options" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>入库时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.storageDate }" name="storageDate" id="storageDate" autocomplete="off">
				</div>
			</div>
		
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>所入库房：</label>
				<div class="layui-input-inline">
				<input class="layui-input"  name="storehouse"   value="${durables.storehouse }" id="storehouse" autocomplete="off">
					
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>是否建立卡片：</label>
				<div class="layui-input-inline">
				<input class="layui-input"  name="needCard"   value="${durables.needCard }" id="needCard" autocomplete="off">
					
					
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>采购时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.purchaseDate }" name="purchaseDate" id="purchaseDate" autocomplete="off">
				</div>
			</div>
	
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>功率：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required"   value="${durables.power }" name="power" id="power" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>产量：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.yield }" name="yield" id="yield" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>外形尺寸：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.overallDimension }" name="overallDimension" id="overallDimension" autocomplete="off">
				</div>
			</div>
		
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>主要功能：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required"   value="${durables.majorFunction }" name="majorFunction" id="majorFunction" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>保管负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.custodian }" name="custodian" id="custodian" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>维护负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.guardian }" name="guardian" id="guardian" autocomplete="off">
				</div>
			</div>
	
				
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>操作负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input" type="text"   value="${durables.operator }" lay-verify="required" name="operator"    placeholder=""/>
				</div>
			</div>	
		</div>
		
		<div class="layui-form-item">
			
				<label class="layui-form-label">主要保管要求：</label>
				<div class="layui-input-inline" style="width:75%">
					<input type="text"  class="layui-input"   value="${durables.storageRequire }" placeholder=""  name="storageRequire" id="storageRequire"
						autocomplete="off">
				</div>
				
					
		</div>
		
		<div class="layui-form-item">
					
				<label class="layui-form-label">存放地点：</label>
				<div class="layui-input-inline" style="width:75%">
					<input type="text"  class="layui-input"   value="${durables.storagePlace }" placeholder=""  name="storagePlace" id="storagePlace"
						autocomplete="off">
				</div>
					
		</div>
		
			<div class="layui-form-item">
					
						<label class="layui-form-label"><span class="red"></span>备注：</label>
						 <div class="layui-input-inline" style="width:75%">
				    	  <textarea   placeholder="--限500字--" maxlength="500" name="remark" class="layui-textarea">${durables.remark } </textarea>
				    	</div>
			</div>
           	<div class="layui-row title">
				<h5> 物资照片(可多个)</h5>
			</div>
			  <c:forEach items="${sysFiles}" var="sysfile">  
             
            <div class="layui-form-item">
            	
				<input style="display:inline;width:50%" type="hidden" name="pictureId" value="${sysfile.id }" class="form-control" /> <a style="color:red;margin:auto 20px;" href="${ctx}/sysFile/download.shtml?fileId=${sysfile.id}">${sysfile.fileName }</a>
			</div>
             </c:forEach> 
	   
	   		<div id="addImage" class="layui-row title">
				<h5>   随机附件、备件及工具</h5>
			</div>
			 
			 
			<table class="layui-table" >
                <thead id="data-head">
                <tr>
                    
                    <th style="width:25%"><span class="red"></span>名称</th><th style="width:15%"><span class="red"></span>规格型号</th><th style="width:10%"><span class="red"></span>数量 </th><th>存放地点</th>
                </tr>
                </thead>
                <!-- 表格内容start -->
                <tbody id="addOption" class="text-center">
                	   <c:forEach items="${durablesOptions}" var="durablesOption">  
           
		            <tr>
		            	
		                <td style="width:25%" >
		                	 <input type="hidden" style="width:0%"  name="durablesId" value="${durablesOption.durablesId}"  class="layui-input"   placeholder=""/>	              
			                <input  style="display:inline;width:100%"   class="form-control" type="text" name="optionName" value="${durablesOption.optionName}" placeholder=""/>
		                 </td>
		                 <td style="width:15%" ><input type="text" name="optionModel" class="form-control" value="${durablesOption.optionModel}" placeholder=""/></td>
		                 <td style="width:10%"><input type="text"  class="form-control" name="optionNum"  value="${durablesOption.optionNum}" placeholder=""/></td>
		                  <td ><input type="text" name="optionPlace"  value="${durablesOption.optionPlace}"  class="form-control"  placeholder=""/></td>
		              
		            </tr>
               </c:forEach>  
                </tbody>
                <!-- 表格内容 end -->
            </table>
            
          
      
        <p class="btn-box text-center">
             <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">返回</a>
         
        </p>
    </form>
    
</div>




	

<script>
	var form = layui.form;
	form.render();
   $("input").attr("readOnly","true");
 	$("textarea").attr("readOnly","true");	
   
	
	 $(".cancel").click(function(){
		history.go(-1);
		
	});
	



	
</script>
