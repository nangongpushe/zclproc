<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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
		<li>代储监管</li>
		<li>业务信息</li>
		<li class="active">优胜单位申报</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
    
      
       <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
          	<input type="hidden" name="recommend"  value="未推荐"/>
     <input type="hidden" name="id"  value=""/>
     <div class="layui-form" id="search" >
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>评选年份：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-filter="year"  autocomplete="off" id="year" name="year">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">上报单位：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  placeholder="当前年份该公司没有被监管" readOnly autocomplete="off" value="${company }" id="declareUnit" name="declareUnit">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">上报时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input" readOnly autocomplete="off" id="declareDate" name="declareDate">
				</div>
			</div>
		
		
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>监管单位：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" readOnly autocomplete="off" value="${wareHouse }" id="regulatoryUnit" name="regulatoryUnit">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">评选材料：</label>
				<div class="layui-input-inline">
					<input type="file" name="file" class="form-control "/>
				</div>
				<input type="button" id="delfile" style="display: none" class="layui-btn layui-btn-small" value="删除"/>
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
	 var date = new Date();
		//初始赋值
	  laydate.render({
	    elem: '#year'
	    ,type: 'year'
	    ,value: date.getFullYear(),
	    done: function(value, date){
	  		$("#declareUnit").val();
		$("#regulatoryUnit").val();
   			$(".form_input").ajaxSubmit({
				type:"post",
				 url:"${ctx}/StoreWinUnit/getcompany.shtml?year1="+value,
	 			 dataType: "json",
				success:function(data){
					if(data!=null){
					$("#declareUnit").val(data.data.enterpriseName);
						$("#regulatoryUnit").val(data.data.wareHouse);
					}
					
				}
				}); 
  			}
	  });  
	 
 
  
  //监听提交
  form.on('submit(save)', function(data){
     var inspectorType = $('#inspectorType').val();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
					layer.msg("保存成功",{icon:1}, function(){
						  location.href="${ctx}/StoreWinUnit.shtml";
						})
					
				}
				}); 
    return false;
  });
  
 /*    //监听提交
  laydate.on('select(year)', function(data){
     var year = $('#year').val();
     alert(1);
     return;
   	$(".form_input").ajaxSubmit({
				type:"post",
				 url:"${ctx}/StoreWinUnit/getcompany.shtml?year="+year,
	 			 dataType: "json",
				success:function(data){
					layer.msg("保存成功",{icon:1}, function(){
						  location.href="${ctx}/StoreWinUnit.shtml";
						})
					
				}
				}); 
    return false;
  }); */
});
 
  


	
	 $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
				history.go(-1);
			});
		
	});
	
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
	$("input[name='declareDate']").val(storageDate);
	
$("input[name='file']").change(function () {
	$("#delfile").show();
});

$("#delfile").click(function () {
	$("input[name='file']").val("");
	$(this).hide();
});
	
</script>
