<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp"%>

<style>
.title1{
margin-left:55px;
color: #23b7e5;
border-bottom: 1px solid #23b7e5;
}
.layui-form-item .layui-inline{
margin-right:0;
}
.layui-form-label{
padding: 0 0 0 3px;
}
[class*="layui-col-md"] label {
    width: 38%;
}
[class*="layui-col-md"] div.layui-input-inline {
    width: 60%;
}
.layui-form-item .layui-input-inline{
margin-right: 0px; 
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>粮油情检测管理</li>
		<li>谷物冷却记录</li>
		<c:if test="${isEdit}">
			<li class="active">谷物冷却记录编辑</li>
		</c:if>
		<c:if test="${!isEdit}">
			<li class="active">谷物冷却记录新增</li>
		</c:if>	
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

<!-- 	<div class="layui-row title"> -->
<!-- 		<h5>机械通风记录信息</h5> -->
<!-- 	</div> -->

	<form class="layui-form" lay-filter="form">
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="warehouse" lay-verify="required"
						autocomplete="off" value="${model.warehouse}" readonly>
					<input type="hidden" name="warehouseId" value="${model.warehouseId}"/>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>仓号:</label>
				<div class="layui-input-inline">
					<select name="encode" lay-verify="required" lay-filter="storehouse">
						<option value="">--请选择--</option>
						<c:forEach items="${storehouses}" var="item">
							<option value="${item.encode }">${item.encode}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>仓房类型:</label>
				<div class="layui-input-inline">
					<select name="type" lay-verify="required">
						<option value="">--请选择--</option>
						<c:forEach items="${storehouseTypes}" var="item">
							<option value="${item.value }">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮食品种:</label>
				<div class="layui-input-inline">
					<select name="grainVariety" lay-verify="required" lay-filter="grainType">
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${grainTypes}">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
		</div>
		
		
		<div class="layui-form-item">

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">跨度*长度(直径)m:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input form-control" name="diameter" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.diameter}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">粮堆高度m:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input form-control" name="bulkHeight" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);"  autocomplete="off" value="${model.bulkHeight}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">粮堆体积(m³):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input form-control" name="bulkCubage" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);"  autocomplete="off" value="${model.bulkCubage}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>水分%:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input form-control" name="dew" lay-verify="required|number" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);"  autocomplete="off" value="${model.dew}">
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>杂质%:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input form-control" name="impurity" lay-verify="required|number" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);"  autocomplete="off" value="${model.impurity}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>数量(t):</label>
				<div class="layui-input-inline">
					<input readonly class="layui-input form-control" name="realQuantity" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.realQuantity}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">谷冷机型号:</label>
				<div class="layui-input-inline">
					<input maxlength="15" class="layui-input form-control" name="valleyCoolerModel"
						autocomplete="off" value="${model.valleyCoolerModel}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">数量(台):</label>
				<div class="layui-input-inline">
					<input type="text"  class="layui-input form-control" name="valleyCoolerNum" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						autocomplete="off" value="${model.valleyCoolerNum}" maxlength="5">
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">总功率(KW):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input form-control" name="kw" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.kw}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">单位通风量m³/(h.t):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input form-control" name="mht" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.mht}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">风网类型:</label>
				<div class="layui-input-inline">
					<input maxlength="15" class="layui-input form-control" name="aspirationType"
						autocomplete="off" value="${model.aspirationType}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">总风量(m³/h):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input form-control" name="mh" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.mh}">
				</div>
			</div>
		</div>

		<div class="layui-form-item">

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>冷却通风目的:</label>
				<div class="layui-input-inline">
					<textarea placeholder="最多50字符" maxlength="50" lay-verify="required"
						class="layui-textarea" name="purpose" >${model.purpose}</textarea>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>通风开始时间 :</label>
				<div class="layui-input-inline">
					<input  class="layui-input form-control" name="startTime" lay-verify="required" id="startTime"
						autocomplete="off" value='<fmt:formatDate value="${model.startTime}" pattern="yyyy-MM-dd HH:mm" type="both"/>'>
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>通风结束时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="endTime" lay-verify="required" id="endTime"
						autocomplete="off" value='<fmt:formatDate value="${model.endTime}" pattern="yyyy-MM-dd HH:mm" type="both"/>'>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">制冷量(kw):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input form-control" name="totalTime" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.totalTime}">
				</div>
			</div>
			<%--<div class="layui-inline layui-col-md3">
				<label class="layui-form-label">风网布置:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="electrovalency"
						   autocomplete="off" value="${model.electrovalency}">
				</div>
			</div>--%>
		</div>
		
		<div class="layui-row title">
			<h5>气温℃</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input form-control" name="tempMax" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.tempMax}">
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input form-control" name="tempMin" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.tempMin}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input" name="tempAvg" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.tempAvg}">
				</div>
			</div>
		</div>
		
		<div class="layui-row title">
			<h5>气湿RH%</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input form-control" name="rhMax" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.rhMax}">
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input form-control" name="rhMin" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.rhMin}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input" name="rhAvg" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);"autocomplete="off" value="${model.rhAvg}">
				</div>
			</div>
		</div>
		
		<div class="layui-row title">
			<h5>冷通前粮温℃</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input form-control" name="beforeMax" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.beforeMax}">
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input form-control" name="beforeMin" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.beforeMin}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值:</label>
				<div class="layui-input-inline">
					<input type="text" step="0.1" maxlength="5" class="layui-input" name="beforeAvg" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.beforeAvg}">
				</div>
			</div>
		</div>

		<div class="layui-row title">
			<h5>冷通后粮温℃</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input form-control" name="afterMax" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.afterMax}">
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input form-control" name="afterMin" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.afterMin}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input" name="afterAvg" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);"autocomplete="off" value="${model.afterAvg}">
				</div>
			</div>
		</div>
		
		<div class="layui-row title">
			<h5>粮层温度梯度℃/m</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0" class="layui-input form-control" name="gradMax" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.gradMax}">
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0" class="layui-input form-control" name="gradMin" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.gradMin}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0" class="layui-input" name="gradAvg" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.gradAvg}">
				</div>
			</div>
		</div>
		
		<div class="layui-row title">
			<h5>粮层水分梯度%/m</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最高值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0" class="layui-input form-control" name="dewMax" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.dewMax}">
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>最低值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0" class="layui-input form-control" name="dewMin" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.dewMin}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>平均值:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0" class="layui-input" name="dewAvg" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);"autocomplete="off" value="${model.dewAvg}">
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>冷却风温度℃:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1"  class="layui-input" name="coolingAirTemp" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.coolingAirTemp}">
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>冷却风湿度RH%:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0" class="layui-input" name="coolingAirRh" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.coolingAirRh}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>实际冷却处理能力(t/24h):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0" class="layui-input" name="ability" lay-verify="required|number"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.ability}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">总电耗KW.h:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input" name="totalPower" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.totalPower}">
				</div>
			</div>
			
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">单位能耗KW.h/℃.t:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input" name="energyConsum" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.energyConsum}">
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">电价￥/(KW/h):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input" name="electrovalency" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.electrovalency}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">单位耗资(￥/t):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" step="0.1" class="layui-input" name="cost" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						   onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" autocomplete="off" value="${model.cost}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>保管员:</label>
				<div class="layui-input-inline">
					<input maxlength="5" class="layui-input" name="custodian" lay-verify="required"
						autocomplete="off" value="${model.custodian}">
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>操作人:</label>
				<div class="layui-input-inline">
					<input maxlength="5" class="layui-input" name="operator" lay-verify="required"
						autocomplete="off" value="${model.operator}" readonly>
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>分管领导:</label>
				<div class="layui-input-inline">
					<input maxlength="5" class="layui-input" name="leader" lay-verify="required"
						autocomplete="off" value="${model.leader}">
				</div>
			</div>


			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>上报日期:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="recordDate" lay-verify="required"
							autocomplete="off" value='<fmt:formatDate pattern="yyyy-MM-dd" 
            value="${model.recordDate}" />' readonly>
				</div>
			</div>
		</div>

	
		<div class="layui-form-item text-center">
			<button type="button" id="saveBtn" class=" layui-btn layui-btn-primary layui-btn-small"
				lay-submit="" lay-filter="save">保存</button>
			<button type="button"
				class=" layui-btn layui-btn-primary layui-btn-small" id="cancel" data-bind="click:function(){$root.cancel();}">取消</button>
		</div>
	</form>

</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/storagecooling/add.js"></script>

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
var storehouses = ${cf:toJSON(storehouses)};
if(isedit){
	$('[name="encode"]').val('${model.encode}');
	$('[name="grainVariety"]').val('${model.grainVariety}');
	$('[name="type"]').val('${model.type}');
}else{
    $('[name="encode"]').val('${model.encode}');
    $('[name="grainVariety"]').val('${model.grainVariety}');
    $('[name="type"]').val('${model.type}');
    $('[name="custodian"]').val('${model.custodian}');
}

var vm = new Add(isedit,id,storehouses);
ko.applyBindings(vm,$(".container-box")[0]);
vm.initPage();


</script>
<%@include file="../common/AdminFooter.jsp"%>