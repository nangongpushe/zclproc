<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp"%>

<style>
.title1 {
	margin-left: 55px;
	color: #23b7e5;
	border-bottom: 1px solid #23b7e5;
}

.layui-form-item .layui-inline {
	margin-right: 0;
}

.layui-form-label {
	padding: 0 0 0 3px;
}

[class*="layui-col-md"] label {
	width: 38%;
}

[class*="layui-col-md"] div.layui-input-inline {
	width: 60%;
}

.layui-form-item .layui-input-inline {
	margin-right: 0px;
}

span.tip {
	margin-left: 10px;
	font-size: 10px;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>粮油情检测管理</li>
		<li>磷化氢检测记录</li>
		<c:if test="${isEdit}">
			<li class="active">磷化氢检测记录编辑</li>
		</c:if>
		<c:if test="${!isEdit}">
			<li class="active">磷化氢检测记录新增</li>
		</c:if>	
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-row title">
		<h5>磷化氢检测记录信息</h5>
	</div>

	<form class="layui-form" lay-filter="form">
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="warehouse" lay-verify="required"
						autocomplete="off" value="${model.warehouse}" readonly>
					<input type="hidden" name="warehouseId" value="${model.warehouseId}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>仓号:</label>
				<div class="layui-input-inline">
					<select name="encode" lay-verify="required" lay-filter="encode">
						<option value="">--请选择--</option>
						<c:forEach items="${storehouses}" var="item">
							<option value="${item.encode }">${item.encode}</option>
						</c:forEach>
					</select>
				</div>
			</div>		
		</div>

		<div class="layui-form-item">			
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>熏蒸记录编号:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="fumigate" lay-filter="fumigate" lay-verify="required"
						data-bind="options:fumigates,optionsCaption:'--请选择--'">
					</select>
				</div>
			</div>
			
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮堆平均浓度(ppm):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="average" lay-verify="required"
						   onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" autocomplete="off" value="${model.average}">
				</div>
			</div>
			
		</div>
		
		<div class="layui-form-item">			
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>检测人1:</label>
				<div class="layui-input-inline layui-col-md2">
					<input maxlength="5" class="layui-input form-control" name="inspector" lay-verify="required"
						autocomplete="off" value="${model.inspector}"  >
				</div>
			</div>
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>检测人2:</label>
				<div class="layui-input-inline layui-col-md2">
					<input maxlength="5" class="layui-input form-control" name="inspectors" lay-verify="required"
						   autocomplete="off" value="${model.inspectors}">
				</div>
			</div>
			

		</div>
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>检测时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="inspecteTime" lay-verify="required"
						   autocomplete="off" value='<fmt:formatDate value="${model.inspecteTime}" pattern="yyyy-MM-dd" />'>
				</div>
			</div>
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>检测仪器:</label>
				<div class="layui-input-inline layui-col-md2">
					<input maxlength="15" class="layui-input form-control" name="testDevice" lay-verify="required"
						   autocomplete="off" value="${model.testDevice}">
				</div>
			</div>

		</div>

		<div class="layui-form-item layui-form-text">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">备注:</label>
				<div class="layui-input-inline">
					<textarea placeholder="最多500个字符" class="layui-textarea" name="remark" maxlength="500">${model.remark}</textarea>
				</div>
			</div>

		</div>

		<div class="layui-row title">
			<h5>粮堆检测点</h5>
		</div>
		
		<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="inBtn" data-bind="click:function(){$root.add('轮入')}">
			<i class="layui-icon">&#xe608;</i> 新增
		</button>
		<span class="red tip">*最多新建7个</span>
		<table class="layui-table" id="in">
			<thead>
				<tr>
					<td style="text-align:center">粮堆检测点</td>
					<td style="text-align:center">磷化氢浓度(ppm)</td>
					<td style="text-align:center">操作</td>
				</tr>
			</thead>
			<tbody data-bind="foreach:detailList">
				<tr>
					<td data-bind="text:point"></td>
					<td>
						<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" lay-verify="required"
							   onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" autocomplete="off" data-bind="value:value">
					</td>
					<td  style="text-align:center" ><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini"data-bind="click:function(){$root.remove($index())}">删除</a></td>
				</tr>
			</tbody>
		</table>
		
		<div class="layui-form-item text-center">
			<button type="button" class=" layui-btn layui-btn-primary layui-btn-small"
				lay-submit="" lay-filter="save" id="save">保存</button>
			<button type="button"
				class=" layui-btn layui-btn-primary layui-btn-small" id="cancel" data-bind="click:function(){$root.cancel();}">取消</button>
		</div>
	</form>

</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/storagephosphine/add.js"></script>
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
    function checkAmounts(obj) {
        var reg = /[A-Za-z]+/;
        var optionNum = $(obj).val();
        if (reg.test(optionNum)) {
            alert("只能输入数字");
            $(obj).val("");
        }
    }
var isedit=${isEdit};
var id = '${model.id}'||0;
var phosphine=${cf:toJSON(model)};
if(isedit){
	$('[name="encode"]').val('${model.encode}');
}else{
    $('[name="encode"]').val('${model.encode}');

}
var vm = new Add(isedit,id,phosphine);
ko.applyBindings(vm,$(".container-box")[0]);
vm.initPage();

layui.laydate.render({
    elem:$('[name="inspecteTime"]')[0],
    type:"date",
    format:"yyyy-MM-dd",
});
</script>
<%@include file="../common/AdminFooter.jsp"%>