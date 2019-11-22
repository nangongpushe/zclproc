<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
		<li class="active">维修管理</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
   
    <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
      <input type="hidden" name="id"  value=""/>
      <input type="hidden" name="durablesId"  value=""/>
      <input type="hidden" name="encode"  value=""/>
		     <div class="layui-form" id="search" >
		      <div class="layui-form-item">					
					<div class="layui-inline ">
						<label class="layui-form-label " ><span class="red">*</span>物资编号:</label>
						<div class="layui-input-inline ">
							<input type="button" style="text-align:left;" onclick="toAddDurables()" lay-verify="required" class="layui-input" name="encode" id="encode" autocomplete="off">
						</div>
					</div>
					<div class="layui-inline ">
						<label class="layui-form-label"><span class="red"></span>品名:</label>
						<div class="layui-input-inline">
							<input type="text"  class="layui-input" placeholder="--自动带出--" readonly name="commodity" id="commodity"
								autocomplete="off">
						</div>
					</div>
					<div class="layui-inline ">
						<label class="layui-form-label "><span class="red"></span>类别:</label>
						<div class="layui-input-inline">
							<input type="text"  class="layui-input" placeholder="--自动带出--" readonly name="type" id="type" autocomplete="off">
						</div>
					</div>
					
				
						
					<div class="layui-inline ">
						<label class="layui-form-label"><span class="red"></span>规格型号:</label>
						<div class="layui-input-inline">
							<input type="text"  class="layui-input" placeholder="--自动带出--" readonly name="model" id="model"
								autocomplete="off">
						</div>
					</div>
					<div class="layui-inline ">
						<label class="layui-form-label "><span class="red"></span>采购时间:</label>
						<div class="layui-input-inline">
							<input type="text"  class="layui-input" placeholder="--自动带出--" readonly name="purchaseDate" id="purchaseDate" autocomplete="off">
						</div>
					</div>
					<div class="layui-inline ">
						<label class="layui-form-label "><span class="red"></span>保管负责人:</label>
						<div class="layui-input-inline">
							<input type="text"  class="layui-input" placeholder="--自动带出--" readonly name="custodian" id="custodian" autocomplete="off">
						</div>
					</div>
					
			
					
					<div class="layui-inline ">
						<label class="layui-form-label"><span class="red"></span>维护负责人:</label>
						<div class="layui-input-inline">
							<input type="text"  class="layui-input" placeholder="--自动带出--" readonly name="guardian" id="guardian"
								autocomplete="off">
						</div>
					</div>
					
					
				</div>
				<div class="layui-form-item">
					
						<label  class="layui-form-label"><span class="red"></span>主要功能:</label>
							<div class="layui-input-inline" style="width:75%">
							<input type="text"  class="layui-input" placeholder="--自动带出--" readonly name="majorFunction" id="majorFunction"
								autocomplete="off">
						</div>
					
					
				</div>
				
				<div class="layui-row title">
				<h5>保养记录</h5>
				</div>
				<div class="layui-form-item">
					
					<div class="layui-inline ">
						<label class="layui-form-label "><span class="red">*</span>保养日期:</label>
						<div class="layui-input-inline">
							<input type="text" lay-verify="required" class="layui-input"  name="maintainDate" id="maintainDate" autocomplete="off">
						</div>
					</div>
					<div class="layui-inline ">
						<label class="layui-form-label"><span class="red">*</span>维修保养人员:</label>
						<div class="layui-input-inline">
							<input type="text" lay-verify="required" class="layui-input"  name="maintainMan" id="maintainMan"
								autocomplete="off">
						</div>
					</div>
				</div>
				<div class="layui-form-item">
					
						<label   class="layui-form-label "><span class="red">*</span>主要内容:</label>
						<div class="layui-input-inline" style="width:75%">
							<input type="text" lay-verify="required" class="layui-input"  name="maintainContent" id="maintainContent" autocomplete="off">
						</div>
					
					
				</div>
				
				<div class="layui-form-item">
					
						<label class="layui-form-label"><span class="red"></span>备注:</label>
						<div class="layui-input-inline" style="width:75%">
				    	  <textarea   placeholder="--限500字--" maxlength="500" name="remark" class="layui-textarea"></textarea>
				    	</div>
					
				</div>
				
			  </div>
			  
			    <p>备注：带有<span class="red">*</span>为必填项！</p>
		        <p class="btn-box text-center">
		        	 <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
             		<a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
		           
		        </p>
		         </div>
			  </div>
		       
		        
    </form>


</div>


<script>


	
layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#maintainDate' //指定元素
	  });
	  
  //监听提交
  form.on('submit(save)', function(data){
	 layer.load();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
				 layer.closeAll('loading');
					layer.msg("保存成功",{icon:1}, function(){
						location.href="${ctx}/DurablesMaintain.shtml";
					})
					
				}
				}); 
    return false;
  });
  
  
});
 
 
 function toAddDurables(){
	$.colorbox({
		title : '选择非易耗品',
		iframe : true,
		opacity	: 0.2,
		href : "${ctx}/DurablesMaintain/select_durables_list.shtml?",
		innerWidth : '80%',
		innerHeight : '65%',
		close : '×15151',
		fixed : true
	});
}


/* 返回非易耗品*/
  function callDurablesSelect(data){
  
   $("input[name='durablesId']").val(data.id);
 	$("input[name='type']").val(data.type);
 	$("input[name='encode']").val(data.encode);
 	$("#encode").val(data.encode);
 	$("input[name='commodity']").val(data.commodity);
 	$("input[name='model']").val(data.model);
 	$("input[name='purchaseDate']").val(data.purchaseDate);
 	$("input[name='unit']").val(data.unit);
 	$("input[name='yield']").val(data.yield);
 	$("input[name='power']").val(data.power);
 	$("input[name='overallDimension']").val(data.overallDimension);
 	$("input[name='majorFunction']").val(data.majorFunction);
 	$("input[name='custodian']").val(data.custodian);
 	$("input[name='guardian']").val(data.guardian);
 	$("input[name='operator']").val(data.operator);
 	$("input[name='storageRequire']").val(data.storageRequire);
 	
 	
  }
    
   
	
   		
		
	
	 $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
				history.go(-1);
			});
		
	});
	
	

	// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

	var storageDate  = new Date().Format("yyyy-MM-dd");
	$("input[name='storageDate']").val(storageDate);
	
</script>
