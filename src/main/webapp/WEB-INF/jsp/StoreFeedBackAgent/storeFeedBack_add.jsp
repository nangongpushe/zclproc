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
		<li>代储监管</li>
		<li>业务信息</li>
		<li class="active">问题反馈</li>
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
     <input type="hidden" name="id"  value=""/>
     <input type="hidden" name="storehouse"  value="" id="storehouse"/>

       <div class="layui-form" id="search" >
		<div class="layui-form-item">
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>问题反馈名称：</label>
				<div class="layui-input-inline">
					<input maxlength="20" class="layui-input" lay-verify="required" autocomplete="off" id="feedbackName" name="feedbackName">
				</div>
			</div>
			
			
			
		
			<%-- <div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">
				<input type="hidden" value="${wareHouse }" readOnly autocomplete="off" readOnly id="storehouse" name="storehouse">
				<input class="layui-input"  lay-verify="required" value="${enterpriseName }" readOnly autocomplete="off" readOnly id="enterpriseName" name="enterpriseName">
							
				</div>
			</div>
			
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input type="hidden" value="${mananger }" readOnly autocomplete="off" readOnly id="manager" name="manager">
					<input class="layui-input"  lay-verify="required" value="${enterpriseManager }" readOnly autocomplete="off" readOnly id="enterpriseManager" name="enterpriseManager">
				</div>
			</div> --%>
			
			<c:if test="${falg=='' }">
				<div class="layui-inline" id="storehouse1" >
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称：</label>
				<div class="layui-input-inline">
				
					<select class="layui-input" lay-filter="warehouseId" lay-verify="required" name="warehouseId" id="warehouseId">
						<option  value=""></option>
						  <c:forEach var="item" items="${storehouses}" varStatus="status">
						 
						  <option  class="${ status.index + 1}"  value="${item.id}">${item.warehouseShort }</option>
						 
						</c:forEach>									
					</select>					
				</div>
			</div>
			</c:if>
			<c:if test="${falg=='1' }">
			<div class="layui-inline" id="storehouse2" >
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称：</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-filter="warehouseId" lay-verify="required" name="warehouseId" id="warehouseId">
						<option  value=""></option>
						<c:forEach var="item" items="${storehouses}" varStatus="status">
							<option  class="${ status.index + 1}"  value="${item.id}">${item.warehouseShort }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			</c:if>
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点负责人：</label>
				<div class="layui-input-inline">
					<input maxlength="5" class="layui-input"  lay-verify="required"  autocomplete="off"  id="manager" name="manager">
				</div>
			</div>
			
	
		      <div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>类型：</label>
				<div class="layui-input-inline">
					<select class="layui-input"  lay-verify="required" name="inspectorType" 
						id="inspectorType">
						<c:if test="${falg=='1' }">	
						<option selected="selected" value="自检">自检</option>
						</c:if>
						<c:if test="${falg=='' }">	
						 <option value="检查">检查</option>	
						 </c:if>				
					</select>					
				</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>填表时间：</label>
					<div class="layui-input-inline">
						<input class="layui-input" lay-verify="required" autocomplete="off" id="reportDate" name="reportDate">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label" style="text-align:right"><span class="red">*</span>检查组负责人：</label>
					<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" onclick="toAddInspectorManager('1','inspectorManager')"   readOnly autocomplete="off" id="inspectorManager" name="inspectorManager">
								
					</div>
				</div>

				
				<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评编号：</label>
				<div class="layui-input-inline">
						<input class="layui-input" readOnly onclick="changeExamineSerial(this)" lay-verify="required" name="examineSerial" id="examineSerial" >
				</div>
			</div>
				
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>检查人员：</label>
					<div class="layui-input-inline"   style="width:65%;" >
						<input  style="display:inline-block;width:85%;" class="layui-input" lay-verify="required" onclick="toAddInspectorManager('2','inspectors')"   readOnly   placeholder="请选择"  id="inspectors" name="inspectors">
				    <a style="width:10px;" onclick="cleanInspectors();" >清空</a>
				</div>
			</div>	
			<div class="layui-inline">
					
				<label  class="layui-form-label" style="text-align:right">附件：</label>
				<div class="layui-input-inline">
					<input type="file"   name="file"  class="form-control " placeholder="--请输入--"/>
				</div>
				<input type="button" id="delfile" class="layui-btn layui-btn-small" style="display: none" value="删除">
					
		</div>

		</div>	
			  
		
	</div>
       		
       	 <hr class="layui-bg-green">

       
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="addMaterialName();">新增问题</button>
                
          
        	<table class="layui-table" >
                <thead>
                <tr>
                     <th style="width:8%;text-align: center">操作</th><th style="width:14%;text-align: center">问题类型</th>
                    <th style="width:30%;text-align: center">问题描述</th><th style="width:30%;text-align: center">整改建议</th><th style="text-align:center">整改情况</th>
                </tr>
                </thead>
                <!-- 表格内容start -->
                <tbody id="materialDetail" class="text-center">
                
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
		href : "${ctx}/StoreFeedBack/select_user_list.shtml?storehouse="+$("#storehouse").val()+"&inspectorManager="+inspectorManager+"&temp_page="+eles,
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
	   	 $("#inspectors").val(inspectors+','+data.name);
	   }
   }
	
}

 function cleanInspectors(){
   $("#inspectors").val("");
 }

function changeExamineSerial(){

    
	$.colorbox({
		title : '选择考评编号',
		iframe : true,
		opacity	: 0.2,
		href : "${ctx}/StoreFeedBackAgent/select_examineSerial_list.shtml?storehouse="+$("#storehouse").val(),
		innerWidth : '800px',
		innerHeight : '75%',
		close : '×15151',
		fixed : true
	});
}

function callExamineSerialSelect(data){
	$("#examineSerial").val(data.examineSerial);
	
}


if($("#manager").val()==null||$("#manager").val()==""){
	$("#manager").val($("#1").val());
}

 
layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#reportDate' //指定元素
	  });

   form.on('select(warehouseId)', function(data){
       $("#storehouse").val($("#warehouseId option:selected").text());
   		var index= $(data.elem).find("option:selected").attr("class");
    	$("#manager").val($('#'+index).val());
   });
	
  //监听提交
  form.on('submit(save)', function(data){
     layer.load();
   	$(".layui-form").ajaxSubmit({
				type:"post",
				success:function(data){
					 layer.closeAll('loading');
					layer.msg("保存成功",{icon:1}, function(){
						location.href="${ctx}/StoreFeedBackAgent.shtml?";
					})
					
				}
				}); 
    return false;
  });
  
  
});

 $("#mul-2").siblings(".layui-unselect").remove();	
 
 $('.dropdown-mul-2').dropdown({
      searchable: false,
      choice: function() {
      	  $(".dropdown-clear-all").remove();	
      }
    });
    $(".dropdown-clear-all").remove();	
  /*  $(".dropdown-display").css("heigth","30px"); */


  
   function addMaterialName(){
       var tr =   '<tr><td  style="width:8%"><input type="hidden" name="feedbackId" style="width:0px;"/><a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDelete(this);">删除</a>	</td>'
                +'<td ><input type="text" name="type" maxlength="25" class="form-control validate[required] "   placeholder="--请输入--"/></td>'
                +'<td ><textarea type="text" name="description"  class="form-control" maxlength="250" placeholder="--限250字--"></textarea></td>'
                +'<td ><textarea type="text" name="advise"  class="form-control" maxlength="250" placeholder="--限250字--"></textarea></td>'
              	  +'<td class="btn-select-parent">'
              	   
						+'<div class="layui-form-item">'				
							+'<div class="layui-inline" style="width:100%">'
		               		 +'<div class="layui-input-inline">'
								+'<select style="display: block;" class="layui-input"  name="rectification" lay-filter="aihao" id="rectification">'
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
					location.href="${ctx}/StoreFeedBackAgent.shtml?";
			});
		
	});

   $("input[name='file']").change(function () {
	  $("#delfile").show();
   });

   $("#delfile").click(function () {
	   $("input[name='file']").val("");
       $(this).hide();
   });

</script>
