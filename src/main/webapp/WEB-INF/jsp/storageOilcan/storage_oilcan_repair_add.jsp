<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@include file="../common/AdminHeader.jsp"%>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>仓房管理</li>
		<li><a href="${ctx }/storageOilcan.shtml">油罐信息管理</a></li>
		<li class="activity">油罐信息维修记录表</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	<div class="layui-row layui-col-space15">
	    <div class="layui-col-md4"><span>库点名称：</span>
	    <span>${oilcan.warehouse }</span>
		</div>
	    <div class="layui-col-md4"><span>油罐编号：</span>
	    <span>${oilcan.oilcanSerial }</span>
	    </div>
	    <div class="layui-col-md4"><span>油罐类型：</span>
	    <span>${oilcan.oilcanType }</span>
	    </div>
	</div>
	<div class="layui-row layui-col-space15">
	    <div class="layui-col-md4"><span>油罐状态：</span>
	    <span>${oilcan.oilcanStatus }</span>
	    </div>
	    <div class="layui-col-md4"><span>交付使用日期：</span>
	    <span>${oilcan.deliverDate }</span>
	    </div>
	</div>
	<%--结构：--%>
	<div class="layui-row layui-col-space15">
	    <div class="layui-col-md4"><span>设计容量(t)：</span>
	    <span>${oilcan.designedCapacity }</span>
	    </div>
	    <div class="layui-col-md4"><span>核定容量(t)：</span>
	    <span>${oilcan.authorizedCapacity }</span>
	    </div>
	</div>
	<%--罐外：--%>
	<div class="layui-row layui-col-space15">
	    <div class="layui-col-md4"><span>设计装油线高(t)：</span>
	    <span>${oilcan.designedOilLine }</span>
	    </div>
	    <div class="layui-col-md4"><span>实际装油线高(m)：</span>
	    <span>${oilcan.authorizedOilLine }</span>
	    </div>
	</div>
	
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>油罐维修记录：</legend>
	</fieldset>
	
	<form class="layui-form" id="oilcanRepairData">
		<input type="hidden" name="id" value="${repair.id }">
	    <input type="hidden" name="oilcanId" value="${oilcan.id }" >
		<div class="layui-form-item">
    		<label class="layui-form-label"><span class="red">*</span>日期：</label>
    		<div class="layui-input-block">
      			<input lay-verify="required" autocomplete="off" placeholder="请选择日期" class="layui-input date-need" 
      			name="repairDate" value="${repair.repairDate }">
    		</div>
  		</div>
  		<div class="layui-form-item">
    		<label class="layui-form-label"><span class="red">*</span>项目：</label>
    		<div class="layui-input-block">
      			<input lay-verify="required" autocomplete="off" placeholder="请输入名称" class="layui-input" 
      			name="projectName" value="${repair.projectName }" maxlength="50">
    		</div>
  		</div>
  		<div class="layui-form-item">
    		<label class="layui-form-label"><span class="red">*</span>检查维修情况摘要：</label>
    		<div class="layui-input-block">
      			<input lay-verify="required" autocomplete="off" placeholder="请输入项目验收情况" class="layui-input"
      			name="construction" value="${repair.construction }" maxlength="100">
    		</div>
  		</div>
  		<div class="layui-form-item">
    		<label class="layui-form-label">效果：</label>
    		<div class="layui-input-block">
      			<input lay-verify="" class="layui-input" name="effect" value="${repair.effect }" maxlength="100">
    		</div>
  		</div>
  		<div class="layui-form-item">
    		<label class="layui-form-label">记事：</label>
    		<div class="layui-input-block">
      			<textarea placeholder="请输入备注" class="layui-textarea" name="remark" maxlength="450">${repair.remark }</textarea>
    		</div>
  		</div>
  		<p class="btn-box text-center">
        	<button type="button" class="layui-btn layui-btn-primary layui-btn-small" name="cancelBt" onclick="cancelOperate();">取消</button>
        	<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="submitBt" lay-submit lay-filter="submit_btn">
        	保存<c:if test="${auvp eq 'u' }">更改</c:if></button>
    	</p>
	</form>
</div>

<script src="${ctx}/js/app/storage/common.js"></script>

<script>

layui.use(['form','laydate'],function() {
	var form = layui.form,
	laydate = layui.laydate;
	form.render();
	//为需要date的input渲染日历
	$('.date-need').each(function(){
		laydate.render({
			elem: this,
			format: 'yyyy年MM月dd日'
		});
	});
	
	form.on('submit(submit_btn)',function(){
	    layer.load();
		var oilcanRepairData = JSON.stringify($('#oilcanRepairData').serializeObject());
       	$.ajax({
           	type : 'POST',
           	url : '${ctx }/storageOilcanRepair/save.shtml?auvp=${auvp}',
           	dataType : "json",
   			contentType : "application/json",
           	data : oilcanRepairData,
            error: function(request) {
                layer.closeAll();
                if(request.responseText){
                    layer.open({
                        type: 1,
                        area: ['700px', '430px'],
                        fix: false,
                        content: request.responseText
                    });
                }
            },
            success : function(result) {
                if(result.success) {
					layer.msg(result.msg, {icon : 1, time : 1000}, function(){
						if ('${auvp }' === 'a') {
							location.href = '${ctx }/storageOilcan.shtml';
						} else if ('${auvp }' === 'u'){
							location.href = '${ctx }/storageOilcan/editPage.shtml?id=' + '${oilcan.id }';
						}
					});
				} else {
                    layer.closeAll();
					layer.msg(result.msg, {icon : 2, time : 1000});
				}
            }
       	});
	});
	
});	 

function cancelOperate() {
	if ('${auvp }' === 'v') {
		history.go(-1);
	} else {
		layer.confirm('您是否要放弃编辑', function(index) {
			history.go(-1);
		});
	}
};
</script>

</html>