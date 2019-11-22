<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">

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
		  <input type="hidden" name="storehouse"  value="${durables.storehouse}" id="storehouse"/>

		  <div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>物资编码：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="encode"  value="${durables.encode }" id="encode" autocomplete="off" maxlength="25">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>类型：</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" lay-verify="required" name="type" lay-filter="aihao"
						id="type">
						<option></option>

						<option></option>
						<c:if test="${durables.type == '物资'}"    >
              			 	 <option selected="selected" value="物资">物资</option>
          				  	</c:if>
          				  <c:if test="${durables.type != '物资'}"    >
              			 	 <option  value="物资">物资</option>
          				  </c:if>




						<c:if test="${durables.type == '药剂类'}"    >
							<option selected="selected" value="药剂类">药剂类</option>
						</c:if>
						<c:if test="${durables.type != '药剂类'}"    >
							<option  value="药剂类">药剂类</option>
						</c:if>



					</select>
					<!-- </div> -->
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>品名：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" maxlength="25" value="${durables.commodity }" name="commodity" id="commodity" autocomplete="off">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label ">规格型号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="model" value="${durables.model }" maxlength="25" id="model" autocomplete="off">
				</div>
			</div>	
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>制造单位：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" maxlength="25" value="${durables.unit }" name="unit" id="unit" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red"></span>目前状态：</label>
				<div class="layui-input-inline">
				<select class="layui-input" lay-verify="required" name="status" lay-filter="aihao"
						id="status">
						
						 <c:forEach var="item" items="${states}">
						 <c:if test="${durables.status == item.value}">
						  <option selected="selected" value="${item.value}">${item.value }</option>
						 </c:if>
						  <c:if test="${durables.status != item.value}">
						  <option  value="${item.value}">${item.value }</option>
						 </c:if>
						</c:forEach>			
						
					</select>
					
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>金额(元)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.amount }" name="amount" id="amount" autocomplete="off"   onkeyup="clearNoNum(this) " onBlur="checkAmount(this);" maxlength="15">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>生产厂家：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  maxlength="40" value="${durables.manufacturer }" name="manufacturer" id="manufacturer" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>出厂编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  maxlength="40"    value="${durables.serialNumber }" name="serialNumber" id="serialNumber" autocomplete="off">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>供应商：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="supplier"  maxlength="40" value="${durables.supplier }" id="supplier" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red"></span>随机资料：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  name="options"  maxlength="40"    value="${durables.options }" id="options" autocomplete="off">
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
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" lay-verify="required" name="warehouseId" lay-filter="warehouseId"
						id="warehouseId">
						<option></option>
						 <c:forEach var="item" items="${storehouses}">
						 <c:if test="${durables.warehouseId == item.id}">
						  <option selected="selected" value="${item.id}">${item.warehouseShort }</option>
						 </c:if>
						  <c:if test="${durables.warehouseId != item.id}">
						  <option  value="${item.id}">${item.warehouseShort }</option>
						 </c:if>
						</c:forEach>			
						
					</select>
					<!-- </div> -->
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>是否建立卡片：</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-verify="required" name="needCard" lay-filter="aihao"
						id="needCard">
						<c:if test="${durables.needCard == '是'}"    >
              			 	 <option selected="selected" value="是">是</option>
          				  	</c:if>
          				  <c:if test="${durables.needCard != '是'}"    >
              			 	 <option  value="是">是</option>
          				  </c:if>
          				  	<c:if test="${durables.needCard == '否'}"    >
              			 	 <option selected="selected" value="否">否</option>
          				  	</c:if>
          				  <c:if test="${durables.needCard != '否'}"    >
              			 	 <option  value="否">否</option>
          				  </c:if>
						
					
						
					</select>
					
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
					<input class="layui-input"  lay-verify="required"  maxlength="25" value="${durables.power }" name="power" id="power" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>产量：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required|customNumber" maxlength="25" value="${durables.yield }" name="yield" id="yield" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>外形尺寸：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" maxlength="25"   value="${durables.overallDimension }" name="overallDimension" id="overallDimension" autocomplete="off">
				</div>
			</div>

			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>主要功能：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required" maxlength="25"  value="${durables.majorFunction }" name="majorFunction" id="majorFunction" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>保管负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.custodian }" name="custodian" id="custodian"  onclick="toAddInspectorManager('1','durables_add')"   readOnly  autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>维护负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"   value="${durables.guardian }" name="guardian" id="guardian"  onclick="toAddInspectorManager('2','guardian')"   readOnly  autocomplete="off">
				</div>
			</div>

				
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>操作负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input" type="text"   value="${durables.operator }" lay-verify="required" name="operator" id="operator" onclick="toAddInspectorManager('3','operator')"   readOnly   placeholder=""/>
				</div>
			</div>	
		</div>
		
		<div class="layui-form-item">
			
				<label class="layui-form-label">主要保管要求：</label>
				<div class="layui-input-inline" style="width:75%">
					<input type="text"  class="layui-input"   value="${durables.storageRequire }" placeholder=""  name="storageRequire" id="storageRequire"
						autocomplete="off" maxlength="45">
				</div>
				
					
		</div>
		
		<div class="layui-form-item">
					
				<label class="layui-form-label">存放地点：</label>
				<div class="layui-input-inline" style="width:75%">
					<input type="text"  class="layui-input"   value="${durables.storagePlace }" placeholder=""  name="storagePlace" id="storagePlace"
						autocomplete="off" maxlength="45">
				</div>
					
		</div>
		
			<div class="layui-form-item">
					
						<label class="layui-form-label"><span class="red"></span>备注：</label>
						 <div class="layui-input-inline" style="width:75%">
				    	  <textarea   placeholder="--限500字--" maxlength="500" name="remark" class="layui-textarea">${durables.remark } </textarea>
				    	</div>
			</div>
           	<div class="layui-row title">
				<h5> <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="toAddImage();">添加图片</button>  物资照片(可多个)</h5>
			</div>
			  <c:forEach items="${sysFiles}" var="sysfile">  
             
            <div class="layui-form-item">
            	
				<input style="display:inline;width:50%" type="hidden" name="pictureId" value="${sysfile.id }"  class="form-control"/> <a style="color:red;margin:auto 20px;" href="${ctx}/sysFile/download.shtml?fileId=${sysfile.id}">${sysfile.fileName }</a>  <a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDeleteImage(this);">删除</a>
			</div>
             </c:forEach> 
	   
	   		<div id="addImage" class="layui-row title">
				<h5> <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="addOption();">随机附件</button>    随机附件、备件及工具</h5>
			</div>
			 
			 
			<table class="layui-table" >
                <thead>
                <tr>
                    <th style="width:6%;text-align: center">操作</th>
                    <th style="width:25%;text-align: center"><span class="red"></span>名称</th><th style="width:15%;text-align: center"><span class="red"></span>规格型号</th><th style="width:10%;text-align: center"><span class="red"></span>数量 </th><th style="text-align: center">存放地点</th>
                </tr>
                </thead>
                <!-- 表格内容start -->
                <tbody id="addOption" class="text-center">
                	   <c:forEach items="${durablesOptions}" var="durablesOption">  
           
		            <tr>
		            	<td style="width:6%" ><input type="hidden" name="purchaseId" style="width:0px;"/><a href="javascript:void(0);"  class="layui-btn layui-btn layui-btn-mini" onclick="toDelete(this);">删除</a>	</td>
		                <td style="width:25%" >
		                	 <input type="hidden" style="width:0%"  name="durablesId" value="${durablesOption.durablesId}"  class="layui-input"   placeholder=""/>	              
			                <input  style="display:inline;width:100%"   class="form-control" type="text" name="optionName" value="${durablesOption.optionName}" maxlength="25" placeholder=""/>
		                 </td>
		                 <td style="width:15%" ><input type="text" name="optionModel" class="form-control" maxlength="15" value="${durablesOption.optionModel}" placeholder=""/></td>
		                 <td style="width:10%"><input type="text" maxlength="7"  onkeyup="clearNoNum(this) " onBlur="checkAmounts(this);" class="form-control" name="optionNum"  value="${durablesOption.optionNum}" placeholder="" /></td>
		                  <td ><input type="text" name="optionPlace"  value="${durablesOption.optionPlace}"  class="form-control"  placeholder=""/></td>
		              
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
    <div class="jumpPage" id="displayPage"></div>
</div>


<script>
    function callUserSelect_da(data){
        // console.log(data)
        $('#custodian').val(data.data.name);
    }
    function callUserSelect_operator(data){
        $('#operator').val(data.data.name);
    }
    function callUserSelect_guardian(data){
        $('#guardian').val(data.data.name);
    }
</script>
<script>
    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
        if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
            obj.value= parseFloat(obj.value);
        }
    }
    function checkAmount(obj) {
		if (obj.value.indexOf(".")< 0&& obj.value !=""){
		    alert("输入数值要有两位小数");
            obj.value="";
		}
    }
    function checkAmounts(obj) {
        var reg = /[A-Za-z]+/;
        var optionNum = $(obj).val();
        if (reg.test(optionNum)) {
            alert("只能输入数字");
            $(obj).val("");
        }
    }
 var num ="";
function toAddInspectorManager(a,eles){
    var inspectorManager = $("#inspectorManager").val();
    var storehouse = $("#storehouse").val();

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
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#purchaseDate' //指定元素
	  });
	  
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
      var beginDate=$("#purchaseDate").val();
      var endDate=$("#storageDate").val();
      var d1 = new Date(beginDate.replace(/\-/g, "\/"));
      var d2 = new Date(endDate.replace(/\-/g, "\/"));

      if(beginDate!=""&&endDate!=""&&d1>d2)
      {
          alert("入库时间不能小于采购时间！");
          return;
      }
     layer.load();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
				layer.closeAll('loading');
				if (data.success){
                    layer.msg("保存成功",{icon:1}, function(){
                        location.href="${ctx}/Durables.shtml";
                    })
				}else {
				    alert(data.msg);
				}

				}
				}); 
    return false;
  });
  
  
});

	
 
   function addOption(){
       var tr =   '<tr>'
           +'<td style="width:6%;text-align: center;"><input type="hidden" name="purchaseId" style="width:0px;"/><a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDelete(this);">删除</a>	</td>'
           +'<td style="width:25%" >'
           +'<input type="hidden" style="width:0%"  name="durablesId" value="${durablesOption.durablesId}"  class="layui-input" placeholder=""/>'
           +'<input  style="display:inline;width:100%"   class="form-control" type="text" name="optionName" maxlength="25"  placeholder=""/>'
           +' </td>'
           +'<td style="width:15%" ><input type="text" name="optionModel" class="form-control" maxlength="15"  placeholder=""/></td>'
           +'<td style="width:10%"><input type="text" maxlength="7"  onkeyup="clearNoNum(this) " onBlur="checkAmounts(this);" '
		   + 'class="form-control" name="optionNum" id="optionNum"  placeholder=""/></td>'
           +'<td ><input type="text" name="optionPlace"  maxlength="40"  class="form-control"  placeholder=""/></td>'
           +'</tr>';
          
   	$("#addOption").before(tr);
   }
    
    function toDelete(ob){
      $(ob).parent().parent().remove();
    }
    
  	 function toAddImage(){
    var tr =   '<div class="layui-form-item">'
				+'<input style="display:inline;width:50%" type="file" name="file" class="form-control"/> <a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDeleteImage(this);">删除</a>'
			+'</div>'
          
   	$("#addImage").before(tr);
   }
    
    function toDeleteImage(ob){
      $(ob).parent().remove();
    }
    
	
	 $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
				history.go(-1);
			});
		
	});
	

	
</script>

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>物资管理</li>
		<li>库存管理</li>
		<li class="active">非易耗品库存</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
     <form class="form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
     <input type="hidden" name="id"  value="${durables.id }"/>
      <input type="hidden" name="optionsId"  value=""/>
      <input type="hidden" name="groupId"  value="${durables.groupId}"/>
     
        <table class="table table-bordered" style="border: none">
            <!-- 表格内容 start -->
            <tbody>
            <tr>
                <td class="text-right"><b>物资编码：</b></td>
                <td><input type="text" name="encode" class="form-control" value="${durables.encode}" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b>类型：</b></td>
                <td class="btn-select-parent">
                    <input type="text" name="type" value="${durables.type}" class="form-control validate[required]" placeholder="--请选择--"/>
                    <div class="btn-group pull-right btn-select">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"></button>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:;">药剂</a></li>
                            <li><a href="javascript:;">麻袋</a></li>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>品名：</b></td>
                <td><input type="text" name="commodity" value="${durables.commodity}" class="form-control validate[required]" placeholder="--请输入--"/></td>
                <td class="text-right"><b>规格型号：</b></td>
                <td><input type="text" name="model" value="${durables.model}"  class="form-control validate[required]" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                <td class="text-right"><b>制造单位：</b></td>
                <td><input type="text" name="unit" value="${durables.unit}"  class="form-control " placeholder="--请输入--"/></td>
                <td class="text-right"><b>目前状态：</b></td>
                <td><input type="text" name="status" value="${durables.status}"  class="form-control" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>金额：</b></td>
                <td><input type="text" name="amount" value="${durables.amount}"  class="form-control validate[required] validate[custom[number]]" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b>生产厂家：</b></td>
                <td><input type="text" name="manufacturer" value="${durables.manufacturer}"  class="form-control validate[required]" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>生厂编号：</b></td>
                <td><input type="text" name="serialNumber" value="${durables.serialNumber}"  class="form-control validate[required]" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b>供应商：</b></td>
                <td><input type="text" name="supplier" value="${durables.supplier}"  class="form-control validate[required]" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                <td class="text-right"><b>随机资料：</b></td>
                <td><input type="text" name="options" value="${durables.options}"  class="form-control"  placeholder="--请输入--"/></td>
               <!--  <td class="text-right"><span>&nbsp;&nbsp;</span><b>物资照片(可多个)：</b></td>
                <td><input type="file" name="file" class="form-control"/></td> -->
                <c:if test="${durables.groupId!=null}">
                	 <td class="text-right"><span>&nbsp;&nbsp;</span><b>物资照片(可多个)：</b></td>
                	<td> <a href="${ctx}/sysFile/download.shtml?fileId=${durables.groupId}">${durables.groupId }</a></td>
                </c:if>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>入库时间：</b></td>
                <td><input type="text" name="storageDate" value="${durables.storageDate}"  class="form-control " readonly placeholder=""/></td>
                <td class="text-right"><span class="red">*</span><b>所入库房：</b></td>
                <td class="btn-select-parent">
                    <input type="text" name="storehouse" value="${durables.storehouse}"  class="form-control validate[required]" placeholder="--请选择--"/>
                    <div class="btn-group pull-right btn-select">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"></button>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:;">库001</a></li>
                            <li><a href="javascript:;">库002</a></li>
                            <li><a href="javascript:;">库003</a></li>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>是否建立卡片：</b></td>
                <td><input type="text" name="needCard" value="${durables.needCard}" class="form-control validate[required]" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b>采购时间：</b></td>
                <td><input type="text" name="purchaseDate" value="${durables.purchaseDate}"  class="form-control validate[required] validate[custom[dateFormat]]" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>功率：</b></td>
                <td><input type="text" name="power" value="${durables.power}" class="form-control validate[required] validate[custom[number]]" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b>产量：</b></td>
                <td><input type="text" name="yield" value="${durables.yield}"  class="form-control validate[required] validate[custom[number]]" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>外形尺寸：</b></td>
                <td><input type="text" name="overallDimension" value="${durables.overallDimension} " class="form-control validate[required]" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b>主要功能：</b></td>
                <td><input type="text" name="majorFunction" value="${durables.majorFunction}"  class="form-control validate[required]" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>保管负责人：</b></td>
                <td><input type="text" name="custodian" value="${durables.custodian}" class="form-control validate[required]" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b>维护负责人：</b></td>
                <td><input type="text" name="guardian" value="${durables.guardian}" class="form-control validate[required]" placeholder="--请输入--"/></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>操作负责人：</b></td>
                <td><input type="text" name="operator" value="${durables.operator}" class="form-control validate[required]" placeholder="--请输入--"/></td>
                <td class="text-right"><span class="red">*</span><b>主要保管要求：</b></td>
                <td><input type="text" name="storageRequire" value="${durables.storageRequire}" class="form-control validate[required]" placeholder="--请输入--"/></td>
            </tr>
            
            
            <tr>
                <td class="text-center" colspan="4"><b>物资照片(可多个)</b> 
                <button style="margin-left:5% "type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="toAddImage();">添加图片</button>
                </td>
            </tr>
             <c:forEach items="${sysFiles}" var="sysfile">  
             <tr>
                <td colspan="4"><input type="hidden" name="pictureId" id="pictureId" value="${sysfile.id }"/><a style="color:red;margin:auto 20px;" href="${ctx}/sysFile/download.shtml?fileId=${sysfile.id}">${sysfile.fileName }</a>  <a href="javascript:void(0);" class="layui-btn layui-btn-primary layui-btn-small " onclick="toDeleteImage(this);">删除</a> </td>
            </tr>
             </c:forEach> 
            <tr id="addImage">
                <td class="text-center" colspan="4"><b>随机附件、备件及工具</b> 
                <button style="margin-left:5% "type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="addOption();">添加随机附件</button>
                </td>
            </tr>
            <tr>
            	
            	<td class="text-center"><b>名称</b></td>
                <td class="text-center"><b>规格/型号</b></td>
                 <td class="text-center"><b>数量</b></td>
                <td class="text-center"><b>存放地点</b></td>  
            </tr>
           <c:forEach items="${durablesOptions}" var="durablesOption">  
           
            <tr>
                <td colspan="1">
                	 <input type="hidden" style="width:0%"  name="durablesId" value="${durablesOption.durablesId}"  class="form-control"   placeholder=""/>
	                <a  href="javascript:void(0);" class="layui-btn layui-btn-primary layui-btn-small " onclick="toDelete(this);">删除</a>
	                <input  style="display:inline;width:60%"  type="text" name="optionName" value="${durablesOption.optionName}" class="form-control"  placeholder="--请输入--"/>
                </td>
                 <td colspan="1"><input type="text" name="optionModel" class="form-control"  value="${durablesOption.optionModel}" placeholder="--请输入--"/></td>
                 <td colspan="1"><input type="text" name="optionNum" class="form-control validate[custom[number]]" value="${durablesOption.optionNum}"  placeholder=""/></td>
                  <td colspan="1"><input type="text" name="optionPlace" class="form-control"  value="${durablesOption.optionPlace}"  placeholder=""/></td>
            </tr>
               </c:forEach>  
             
            <tr id="addOption">
                <td class="text-right"><b>存放地点：</b></td>
                <td colspan="3"><input type="text" name="storagePlace" value="${durables.storagePlace}" class="form-control"  placeholder="--限200字--"/></td>
            </tr>
         
            <tr>
                <td class="text-right"><b>备注：</b></td>
                <td colspan="3"><textarea type="text" name="remark"  class="form-control" placeholder="--限500字--">${durables.remark}</textarea></td>
            </tr>

            <!-- 表格内容 end -->
        </table>
        <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
           <button type="button" class="layui-btn layui-btn-primary layui-btn-small cancel"  >取消</button>
        	<button class="layui-btn layui-btn-primary layui-btn-small save"  >保存</button>
        </p>
    </form>
    <div class="jumpPage" id="displayPage"></div>
</div>


<script>
		//自定义错误显示位置 
 $('.form_input').validationEngine({ 
  promptPosition: 'bottomRight', 
  addPromptClass: 'formError-white'
 });
 

   function addOption(){
   var td =   '<tr>'
                +'<td colspan="1">'
                	 +'<input type="hidden" style="width:0%"  name="durablesId" value="${durablesOption.durablesId}"  class="form-control"   placeholder=""/>'
	                +'<a href="javascript:void(0);" class="layui-btn layui-btn-primary layui-btn-small " onclick="toDelete(this);">删除</a>'
	                +'<input  style="display:inline;width:60%"  type="text" name="optionName" class="form-control"  placeholder="--请输入--"/>'
                +'</td>'
                 +'<td colspan="1"><input type="text" name="optionModel" class="form-control"  placeholder="--请输入--"/></td>'
                 +'<td colspan="1"><input type="text" name="optionNum" class="form-control validate[custom[number]]"  placeholder=""/></td>'
                  +'<td colspan="1"><input type="text" name="optionPlace" class="form-control"   placeholder=""/></td>'
            +'</tr>'
          
   	$("#addOption").before(td);
   }
    
    function toDelete(ob){
      $(ob).parent().parent().remove();
    }
   
   function toAddImage(){
    var tr =   '<tr>'
                 +'<td colspan="4"><input style="display:inline;width:50%" type="file" name="file" class="form-control"/> <a href="javascript:void(0);" class="layui-btn layui-btn-primary layui-btn-small " onclick="toDeleteImage(this);">删除</a> </td>'
           		  +'</tr>'
          
   	$("#addImage").before(tr);
   }
    
    function toDeleteImage(ob){
      $(ob).parent().parent().remove();
    }
    
    
    $(".save").click(function(){
		if($(".form_input").validationEngine('validate')==true){
			$(".form_input").ajaxSubmit({
			type:"post",
			success:function(data){
				
				location.href="${ctx}/Durables.shtml";
			}
			});
		}
		
	});
	
	 $(".cancel").click(function(){
		history.go(-1);
		
	});
	
	


	
</script>
 --%>