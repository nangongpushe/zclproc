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
      <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
           <input type="hidden" name="id"  value="${consumables.id }"/>
           <input type="hidden" name="groupId"  value="${consumables.groupId}"/>
		  <input type="hidden" name="storehouse"  value="${consumables.storehouse}" id="storehouse"/>

		  <div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>所入库房:</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" lay-verify="required" name="warehouseId" lay-filter="warehouseId"
						id="warehouseId">

						<option></option>
						<c:forEach var="item" items="${storehouses}" varStatus="status">
							<c:if test="${consumables.warehouseId == item.id}">
								<option class="${ status.index + 1}" selected="selected" value="${item.id}">${item.warehouseShort }</option>
							</c:if>
							<c:if test="${consumables.warehouseId != item.id}">
								<option  class="${ status.index + 1}" value="${item.id}">${item.warehouseShort }</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>品名:</label>
				<div class="layui-input-inline">
					<input class="layui-input" maxlength="10" lay-verify="required" value="${consumables.commodity}" name="commodity" id="commodity" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">规格型号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" maxlength="10" value="${consumables.model}" name="model" id="model" autocomplete="off">
				</div>
			</div>
	
				
			<div class="layui-inline">
				<label class="layui-form-label ">单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" maxlength="15" value="${consumables.unit}" name="unit" id="unit" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>入库量:</label>
				<div class="layui-input-inline">
					<input class="layui-input" maxlength="5" value="${consumables.incomingQuantity}" readOnly lay-verify="required|customNumber" style="background:#CCCCCC"  name="incomingQuantity" id="incomingQuantity"  autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">本次领用:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.apply}" name="apply" readOnly id="apply" onchange="changeApply(this)" autocomplete="off"  style="background:#CCCCCC"/>
				</div>
			</div>	
	
			<div class="layui-inline">
				<label class="layui-form-label ">累计领用:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.totalApply}" type="text"  name="totalApply" value="0" class="form-control"  style="background:#CCCCCC"  readonly placeholder="0"/>
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">剩余量:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.surplus}" type="text"  name="surplus"  value="0" class="form-control" style="background:#CCCCCC"   readonly placeholder="0"/>
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>单价(元):</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.unitPrice}" lay-verify="required|customNumber" type="text"  placeholder="--请输入--" onchange="changeUnitPrice(this)" name="unitPrice"  class="form-control"   placeholder="0" maxlength="6"/>
				</div>
			</div>	
		
				
			<div class="layui-inline">
				<label class="layui-form-label ">金额(元):</label>
				<div class="layui-input-inline">
					<input class="layui-input"  value="<fmt:formatNumber type="number" value="${consumables.amount}" pattern="0.00" maxFractionDigits="2"/>"  style="background:#CCCCCC" name="amount" id="amount" readonly autocomplete="off">

				</div>
			</div>		
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>生产厂家:</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" maxlength="20"  value="${consumables.manufacturer}" name="manufacturer" id="manufacturer" placeholder="--请输入--" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>出厂编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  maxlength="15" value="${consumables.serialNumber}" name="serialNumber" id="serialNumber"  placeholder="--请输入--" autocomplete="off">
				</div>
			</div>	
		
				
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>供应商:</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  maxlength="15" value="${consumables.supplier}" type="text" name="supplier"  class="form-control" placeholder="--请输入--"/>
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">随机资料:</label>
				<div class="layui-input-inline">
					<input class="layui-input"  maxlength="20" value="${consumables.options}" type="text" name="options"  class="form-control"  placeholder="--请输入--"/>
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>入库时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${consumables.storageDate }" name="storageDate" id="storageDate" autocomplete="off">
				</div>
			</div>
	
				
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>保管员:</label>
				<div class="layui-input-inline">
					<input class="layui-input" value="${consumables.custodian}" type="text" lay-verify="required" onclick="toAddInspectorManager('1','custodian')"  name="custodian"   id="custodian"  class="form-control"  placeholder="--请输入--"/>
				</div>
			</div>	
		</div>
		
		<div class="layui-form-item">
					
				<label class="layui-form-label"><span class="red">*</span>存放地点:</label>
				<div class="layui-input-inline" style="width:75%">
					<input type="text"  value="${consumables.storagePlace}"  maxlength="30"  lay-verify="required" class="layui-input" placeholder=""  name="storagePlace" id="storagePlace"
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
				<h5> <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="toAddImage();">添加附件</button>物资附件(可多个)</h5>
			</div>
			  <c:forEach items="${sysFiles}" var="sysfile">  
             
            <div class="layui-form-item">
				<input style="display:inline;width:50%" type="hidden" name="pictureId" value="${sysfile.id }"  class="form-control"/>
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
				<a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDeleteImage(this);">删除</a>
			</div>
             </c:forEach> 
			
	
		
        <p id="addImage">备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
             <a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
        </p>
       </div>
    </form>
    
</div>

<script>
    function callUserSelect_custodian(data){
        $('#custodian').val(data.data.name);
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
            href : "${ctx}//StoreFeedBack/select_user_list.shtml?storehouse="+$("#storehouse").val()+"&inspectorManager="+inspectorManager+"&temp_page="+eles,
            innerWidth : '800px',
            innerHeight : '75%',
            close : '×15151',
            fixed : true
        });
    }

    function callUserSelect(data){
        if(num=="1"){
            $("#custodian").val(data.name);
        }else if(num=='2'){
            $("#guardian").val(data.name);
        }else if(num=='3'){
            $("#operator").val(data.name);
        }


    }
  layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	var laydate = layui.laydate;
	  

	  
	   laydate.render({
	    elem: '#storageDate' //指定元素
	  });

      form.on('select(warehouseId)', function(data){
          $("#storehouse").val($("#warehouseId option:selected").text());
      });

      //自定义验证规则
      form.verify({
          //非零开头的最多带两位小数的数字
          customNumber: function(value){
              if(value.length!=0){
                  if(!(/^\d+(\.\d+)?$/.test(value))){
                      return '只能输入大于0的数';
                  }
              }
          }});


      //监听提交
  form.on('submit(save)', function(data){
    layer.load();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
				 layer.closeAll('loading');
					layer.msg("保存成功",{icon:1}, function(){
						location.href="${ctx}/Consumables.shtml";
					})
						
				}
				}); 
    return false;
  });
  
  
});
     function changeIncomingQuantity(ob){
     	 if(isNaN($(ob).val())){
   		 alert("请输入数字");
   		  return;
  		 }
  		// var apply =$("input[name='apply']").val();
  		
	
     }
    
     function changeUnitPrice(ob){
     	 
  		 var incomingQuantity =$("input[name='incomingQuantity']").val();
  		 if(incomingQuantity==''||incomingQuantity==null){
    	 alert("请先输入入库量");
    	 $("input[name='unitPrice']").val("");
    	 return;
    	}
    	if(isNaN($(ob).val())){
   		 alert("请输入数字");
   		 return;
  		 }
  		 
    	var unitPrice =$("input[name='unitPrice']").val();
    	incomingQuantity=parseFloat(incomingQuantity);
    	unitPrice=parseFloat(unitPrice);
    	//总价
    	$("input[name='amount']").val((unitPrice*incomingQuantity).toFixed(2));
		
     }
     
     function changeApply(ob){
        var incomingQuantity =$("input[name='incomingQuantity']").val();
         incomingQuantity=parseInt(incomingQuantity);
    	var apply =$("input[name='apply']").val();
    	
    	if(incomingQuantity==''||incomingQuantity==null){
    	 alert("请先输入入库量");
    	 $("input[name='apply']").val("");
    	 return;
    	}
    	
     	 if(isNaN($(ob).val())){
   		 alert("请输入数字");
   		 return;
  		 }
  		  incomingQuantity=parseInt(incomingQuantity);
  		  apply=parseInt(apply);
  		 if(apply>incomingQuantity){
  		 alert("领用量不可以大于入库量");
  		  $("input[name='apply']").val("");
  		 return;
  		 }
  		
  		
  		  $("input[name='totalApply']").val(apply);
  		   var surplus =$("input[name='surplus']").val();
  		  surplus=parseInt(surplus); 		  
  		 $("input[name='surplus']").val(incomingQuantity-apply);
    	
	
     }
    
    $(".save").click(function(){
   		
		var isValid = true;
		//校验必填项
			$('input[lay-verify="required"]').each(function() {
				if (!$(this).val()) {
					isValid = false;
					layer.msg('请填写必填项', {
						icon : 0
					})
					return false;
				}
			});
			
			if (isValid){
			
				$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
					layer.msg("保存成功",{icon:1}, function(){
						location.href="${ctx}/Consumables.shtml";
					})
				}
				});
			}
		});	
	 $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
				history.go(-1);
			});
		
	});
	
	 function toAddImage(){
    var tr =   '<div class="layui-form-item">'
				+'<input style="display:inline;width:50%" type="file" name="file" class="form-control"/> <a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDeleteImage(this);">删除</a>'
			+'</div>'
          
   	$("#addImage").before(tr);
   }
    
    function toDeleteImage(ob){
      $(ob).parent().remove();
    }
	
	

	


	
</script>
