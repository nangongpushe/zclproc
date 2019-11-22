<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>

<style type="text/css">

.layui-inline{
	width: 45% ;
}
.layui-form-item .layui-form-label{
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
		<li class="active">易耗品入库</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
   <form class="form_input"  action="Create.shtml" method="Post" enctype="multipart/form-data">
           <input type="hidden" name="id"  value="${consumables.id }"/>
           <input type="hidden" name="groupId"  value="${consumables.groupId}"/>
           
      <div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>所入库房:</label>
				
					<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.storehouse}" name="storehouse" id="storehouse" autocomplete="off">
				</div>
				
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label ">品名:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.commodity}" name="commodity" id="commodity" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">规格型号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.model}" name="model" id="model" autocomplete="off">
				</div>
			</div>
		
				
			<div class="layui-inline">
				<label class="layui-form-label ">单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.unit}" name="unit" id="unit" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>入库量:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.incomingQuantity}" lay-verify="required" name="incomingQuantity" id="incomingQuantity" onchange="changeIncomingQuantity(this)" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">本次领用:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.apply}" name="apply" id="apply" onchange="changeApply(this)" autocomplete="off">
				</div>
			</div>	
	
			<div class="layui-inline">
				<label class="layui-form-label ">累计领用:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.totalApply}" type="text"  name="totalApply" value="0" class="form-control" readonly placeholder="0"/>
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">剩余量:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.surplus}" type="text"  name="surplus"  value="0" class="form-control"  readonly placeholder="0"/>
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>单价(元):</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.unitPrice}" lay-verify="required" type="text"  placeholder="--请输入--" onchange="changeUnitPrice(this)" name="unitPrice"  class="form-control"   placeholder="0"/>
				</div>
			</div>	
		
				
			<div class="layui-inline">
				<label class="layui-form-label ">金额(元):</label>
				<div class="layui-input-inline">
					<input class="layui-input"  value="<fmt:formatNumber type="number" value="${consumables.amount}" pattern="0.00" maxFractionDigits="2"/>"  name="amount" id="amount" readonly autocomplete="off">

				</div>
			</div>		
			<div class="layui-inline">
				<label class="layui-form-label ">生产厂家:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.manufacturer}" name="manufacturer" id="manufacturer" placeholder="--请输入--" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">出厂编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.serialNumber}" name="serialNumber" id="serialNumber"  placeholder="--请输入--" autocomplete="off">
				</div>
			</div>	
		
				
			
			<div class="layui-inline">
				<label class="layui-form-label ">供应商:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.supplier}" type="text" name="supplier"  class="form-control" placeholder="--请输入--"/>
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">随机资料:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.options}" type="text" name="options"  class="form-control"  placeholder="--请输入--"/>
				</div>
			</div>	
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>入库时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.storageDate}" type="text" lay-verify="required" name="storageDate"  class="form-control"  placeholder="--请输入--"/>
				</div>
			</div>	
		
				
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>保管员:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.custodian}" type="text" lay-verify="required" name="custodian"  class="form-control"  placeholder="--请输入--"/>
				</div>
			</div>	
		</div>
		
		<div class="layui-form-item">
					
				<label class="layui-form-label">存放地点:</label>
				 <div class="layui-input-inline" style="width:75%">
					<input type="text"  value="${consumables.storagePlace}" class="layui-input" placeholder=""  name="storagePlace" id="storagePlace"
						autocomplete="off">
				</div>
					
		</div>
		
			<div class="layui-form-item">
					
						<label class="layui-form-label"><span class="red"></span>备注:</label>
						  <div class="layui-input-inline" style="width:75%">
				    	  <textarea   placeholder="--限500字--" maxlength="500" name="remark" class="layui-textarea"> ${consumables.remark}</textarea>
				    	</div>
			</div>
			
			<div class="layui-row title">
				<h5> 物资照片</h5>
			</div>
			  <c:forEach items="${sysFiles}" var="sysfile">  
             
            <div class="layui-form-item">
				<input style="display:inline;width:50%" type="hidden" name="pictureId" value="${sysfile.id } class="form-control"/>
				<a style="color:red;margin:auto 20px;" href="${ctx}/sysFile/download.shtml?fileId=${sysfile.id}">${sysfile.fileName }</a>
				<c:forEach items="${suffixMap}" var="m">
					<c:if test="${m.key == sysfile.id}">
						<c:choose>
							<c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
								<a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${sysfile.downloadUrl}','width=1200px;height=800px;')" id="openExcel">
									预览
								</a>
							</c:when>
							<c:otherwise>
								<a style="color: yellowgreen" href="javascript:openAnnex('${sysfile.id}')" id="openFile">
									预览
								</a>
							</c:otherwise>
						</c:choose>
					</c:if>

				</c:forEach>
			</div>
             </c:forEach> 
			
	
		
       
        <p class="btn-box text-center">
           <button type="button" class="layui-btn layui-btn-primary layui-btn-small cancel">返回</button>
            
        </p>
       </div>
    </form>
    
</div>



<script>

	 $(".cancel").click(function(){
		history.go(-1);
		
	});

	

$("input").attr("readOnly","true");
$("textarea").attr("readOnly","true");	
	
</script>
