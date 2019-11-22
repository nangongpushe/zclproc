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
		<li>熏蒸记录</li>
		<c:if test="${isEdit}">
			<li class="active">熏蒸记录编辑</li>
		</c:if>
		<c:if test="${!isEdit}">
			<li class="active">熏蒸记录新增</li>
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
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="serial" lay-verify="required"
						autocomplete="off" value="${model.serial}" readonly>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>库点名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="warehouse" lay-verify="required"
						autocomplete="off" value="${model.warehouse}" readonly>
					<input type="hidden" name="warehouseId" value="${model.warehouseId}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>天气:</label>
				<div class="layui-input-inline">
					<select name="weather" lay-verify="required" lay-filter="weather">
						<option value="">--请选择--</option>
						<option value="阴">阴</option>
						<option value="晴">晴</option>
					</select>
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>气温℃:</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input form-control" name="temperature" lay-verify="required"
						autocomplete="off" value="${model.temperature}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>气湿RH%:</label>
				<div class="layui-input-inline">
					<input  type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input form-control" name="humidity" lay-verify="required"
						autocomplete="off" value="${model.humidity}">
				</div>
			</div>
			
		</div>
		
		<div class="layui-row title">
			<h5>仓情</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>仓号:</label>
				<div class="layui-input-inline">
					<select name="storehouse" lay-verify="required" lay-filter="storehouse">
						<option value="">--请选择--</option>
						<c:forEach items="${storehouses}" var="item">
							<option value="${item.encode }">${item.encode}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>仓房类型:</label>
				<div class="layui-input-inline">
					<select name="storehouseType" lay-verify="required" lay-filter="storehouseType">
						<option value="">--请选择--</option>
						<c:forEach items="${storehouseTypes}" var="item">
							<option value="${item.value }">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right">仓房结构:</label>
				<div class="layui-input-inline">
					<input maxlength="15" class="layui-input form-control" name="storehouseStructure"
						autocomplete="off" value="${model.storehouseStructure}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right">仓房总体积(m³):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input form-control" name="storehouseVolume"
						autocomplete="off" value="${model.storehouseVolume}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right">堆放形式 :</label>
				<div class="layui-input-inline">
					<input maxlength="15" class="layui-input form-control" name="stack"
						autocomplete="off" value="${model.stack}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right">气密性(S):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" class="layui-input form-control" name="gas"
						autocomplete="off" value="${model.gas}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right">密封方法:</label>
				<div class="layui-input-inline">
					<input maxlength="15" class="layui-input form-control" name="sealing"
						autocomplete="off" value="${model.sealing}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>入库时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="storeDate" lay-verify="required"
						autocomplete="off" value='<fmt:formatDate value="${model.storeDate}" pattern="yyyy-MM-dd" />'>
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right">粮堆体积(m³):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input form-control" name="grainVolume"
						autocomplete="off" value="${model.grainVolume}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right">空间体积(m³):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input form-control" name="spaceVolume"
						autocomplete="off" value="${model.spaceVolume}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right">粮堆高度 (m):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input form-control" name="grainHeight"
						autocomplete="off" value="${model.grainHeight}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>上年度曾否熏蒸:</label>
				<div class="layui-input-inline">
					<select name="isFumigateLastYear" lay-verify="required" lay-filter="isFumigateLastYear">
						<option value="">--请选择--</option>
						<option value="是">是</option>
					   	<option value="否">否</option>
					   	
					</select>
				</div>
			</div>
		</div>
		
		<div class="layui-row title">
			<h5>粮情</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>粮食品种:</label>
				<div class="layui-input-inline">
					<select name="grainType" lay-verify="required" lay-filter="grainType">
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${grainTypes}">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>数量(t):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="10" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input form-control" name="realQuantity" lay-verify="required"
						autocomplete="off" value="${model.realQuantity}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>杂质(%):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" class="layui-input" name="impurity" lay-verify="required"
						autocomplete="off" value="${model.impurity}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>仓温(℃):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="storageTemperature" lay-verify="required"
						autocomplete="off" value="${model.storageTemperature}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>仓湿(RH%):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="storageHumidity" lay-verify="required"
						autocomplete="off" value="${model.storageHumidity}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>水分(%):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="dew" lay-verify="required"
						autocomplete="off" value="${model.dew}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>最高粮温(℃):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="maxGrainTemperature" lay-verify="required"
						autocomplete="off" value="${model.maxGrainTemperature}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>最低粮温(℃):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="minGrainTemperature" lay-verify="required"
						autocomplete="off" value="${model.minGrainTemperature}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>平均粮温(℃):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="averageGrainTemperature" lay-verify="required"
						autocomplete="off" value="${model.averageGrainTemperature}">
				</div>
			</div>
		</div>
		
		<div class="layui-row title">
			<h5>虫情</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>虫粮等级:</label>
				<%--<div class="layui-input-inline">
					<input class="layui-input" name="maxPestDensity" lay-verify="required"
						autocomplete="off" value="${model.maxPestDensity}">
				</div>--%>
				<div class="layui-input-inline">
					<select name="maxPestDensity" lay-verify="required" lay-filter="maxPestDensity">
						<option value="">--请选择--</option>
						<option value="基本无虫粮">基本无虫粮</option>
						<option value="一般虫粮">一般虫粮</option>
						<option value="严重虫粮">严重虫粮</option>
						<option value="危险虫粮">危险虫粮</option>
					</select>
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"style="text-align:right"><span class="red">*</span>虫种及密度:</label>
				<div class="layui-input-inline">
					<input maxlength="15" class="layui-input" name="among" lay-verify="required"
						autocomplete="off" value="${model.among}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3" style="text-align:right">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>发现部位:</label>
				<div class="layui-input-inline">
					<input maxlength="15" class="layui-input" name="discoverySite" lay-verify="required"
						autocomplete="off" value="${model.discoverySite}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>发现虫害时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="discoveryDate" lay-verify="required"
						autocomplete="off" value='<fmt:formatDate value="${model.discoveryDate}" pattern="yyyy-MM-dd" />'>
				</div>
			</div>
		</div>
		<div class="layui-row title">
			<h5>药剂</h5>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>药剂名称:</label>
				<div class="layui-input-inline">
					<input maxlength="15" class="layui-input" name="drugName" lay-verify="required"
						   autocomplete="off" value="${model.drugName}" >
					<%--<select name="drugName" lay-verify="required" lay-filter="drugName">
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${durables}">
							<option value="${item.commodity}">${item.commodity}</option>
						</c:forEach>
					</select>--%>
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>施药人数(人):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="1" class="layui-input" id="personNumber" name="personNumber" lay-verify="required"
						   onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
						   onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'0')}else{this.value=this.value.replace(/\D/g,'')}"
						   autocomplete="off" value="${model.personNumber}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>施药方法:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="drugMethod" lay-verify="required"
						   autocomplete="off" value="${model.drugMethod}" maxlength="50">
				</div>
			</div>

		</div>
		
		<div class="layui-row title">
			<h5>初次施药情况</h5>
		</div>

		
		<div class="layui-form-item">


			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>熏蒸方式:</label>
				<div class="layui-input-inline">
					<select name="fumigateType" lay-verify="required" lay-filter="fumigateType">
						<option value="">--请选择--</option>
						<option value="整仓">整仓</option>
						<option value="局部">局部</option>
						<option value="膜下">膜下</option>
						<option value="空间">空间</option>
						<option value="空仓">空仓</option>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>单位用药量空间(g/m³):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="unitDrugSpace" lay-verify="required"
						autocomplete="off" value="${model.unitDrugSpace}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>单位用药量粮堆(g/m³):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="unitDrugGrain" lay-verify="required"
						autocomplete="off" value="${model.unitDrugGrain}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>总用药量空间(g):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);"  step="0.1" class="layui-input" name="totalDrugSpace" lay-verify="required"
						autocomplete="off" value="${model.totalDrugSpace}">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>总用药量粮堆(g/m³):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);"  step="0.1" class="layui-input" name="totalDrugGrain" lay-verify="required"
						autocomplete="off" value="${model.totalDrugGrain}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>施药时间(h):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" class="layui-input" name="applyDrugTime" lay-verify="required"
						   onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0" autocomplete="off" value="${model.applyDrugTime}">
				</div>
			</div>

		</div>
		
		<div class="layui-row title">
			<h5>补药情况</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">初次补药日期:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="firstSupplyDate"
						autocomplete="off" value='<fmt:formatDate value="${model.firstSupplyDate}" pattern="yyyy-MM-dd" />'>
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">初次补药量(kg):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="firstSupplyQuantity"
						autocomplete="off" value="${model.firstSupplyQuantity}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">初次补药操作时间(h):</label>
				<div class="layui-input-inline">
					<input maxlength="5" class="layui-input" name="firstSupplyOperateTime"
						autocomplete="off" value="${model.firstSupplyOperateTime}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">补药方式:</label>
				<div class="layui-input-inline">
					<select name="supplyType" lay-filter="supplyType">
						<option value="">--请选择--</option>
						<option value="仓外环流">仓外环流</option>
						<option value="仓内">仓内</option>
					</select>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">是否多次补药:</label>
				<div class="layui-input-inline">
					<select name="isMultiSupply" lay-filter="isMultiSupply">
						<option value="">--请选择--</option>
						<option value="是">是</option>
						<option value="否">否</option>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">总补药次数(次):</label>
				<div class="layui-input-inline">
					<input ttype="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="totalSupplyCount"
						autocomplete="off" value="${model.totalSupplyCount}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">总补药量(kg):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="totalSupplyQuantity"
						autocomplete="off" value="${model.totalSupplyQuantity}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">总用药量(kg):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="totalSupplyDosage"
						   autocomplete="off" value="${model.totalSupplyDosage}">
				</div>
			</div>
		</div>
		
		<div class="layui-row title">
			<h5>环流情况</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>环流模式:</label>
				<div class="layui-input-inline">
					<select name="circulationType" lay-filter="circulationType" lay-verify="required">
						<option value="">--请选择--</option>
						<option value="连续">连续</option>
						<option value="间断">间断</option>
					</select>
				</div>
			</div>

			<div class="ex">
				<%--<label class="layui-form-label">累计环流时间(h):</label>--%>
				<div class="layui-input-inline">
					<input class="hide" name="totalCirculationTime"value="${model.totalCirculationTime}">
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>环流开始时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="totalCirculationStarttime" lay-verify="required"
						   autocomplete="off" value="${model.totalCirculationStarttime}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>环流结束时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="totalCirculationEndtime" lay-verify="required"
						   autocomplete="off" value="${model.totalCirculationEndtime}">
				</div>
			</div>
		</div>
		
		<div class="layui-row title">
			<h5>散气</h5>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>散气日期:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="releaseGasDate" lay-verify="required"
						autocomplete="off" value='<fmt:formatDate pattern="yyyy-MM-dd" 
            value="${model.releaseGasDate}" />'>
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>散气方式:</label>
				<div class="layui-input-inline">
					<input maxlength="15" class="layui-input" name="releaseGasType" lay-verify="required"
						autocomplete="off" value="${model.releaseGasType}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>散气时间(d):</label>
				<div class="layui-input-inline">
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" class="layui-input" name="releaseGasTime" lay-verify="required" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0"
						autocomplete="off" value="${model.releaseGasTime}">
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">残渣处理:</label>
				<div class="layui-input-inline">
					<input maxlength="100" class="layui-input" name="draffDeal"
						autocomplete="off" value="${model.draffDeal}">
				</div>
			</div>

			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">药剂包装物处理:</label>
				<div class="layui-input-inline">
					<input maxlength="100" class="layui-input" name="drugPackageDeal"
						autocomplete="off" value="${model.drugPackageDeal}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right">效果检查:</label>
				<div class="layui-input-inline">
					<input maxlength="15" class="layui-input" name="effectCheck"
						autocomplete="off" value="${model.effectCheck}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>审核人:</label>
				<div class="layui-input-inline">
					<input maxlength="5" class="layui-input" name="storeMan" lay-verify="required"
						autocomplete="off" value="${model.storeMan}">
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>填写人:</label>
				<div class="layui-input-inline">
					<input maxlength="5" class="layui-input" name="storeKeeper" lay-verify="required"
						autocomplete="off" value="${model.storeKeeper}">
				</div>
			</div>
			<div class="exa">

				<%--<label class="hidea">熏蒸操作员:</label>--%>
				<div class="layui-input-inline">
					<input class="hide" name="fumigateOperator" value="${model.fumigateOperator}">
				</div>
			</div>
			<div class="exb">
				<%--<label class="hideb">熏蒸指挥员:</label>--%>

				<div class="layui-input-inline">
					<input class="hide" name="fumigateCommander"  value="${model.fumigateCommander}">
				</div>
			</div>
			<div class="exc">
				<%--<label class="hidec">单位负责人:</label>--%>

				<div class="layui-input-inline">
					<input class="hide" name="unitChargeMan" value="${model.unitChargeMan}">
				</div>
			</div>
			<div class="exd">
				<%--<label class="hided">安全监督员:</label>--%>

				<div class="layui-input-inline">
					<input class="hide" name="supervisor"  value="${model.supervisor}">
				</div>
			</div>
			<div class="exe">
				<%--<label class="hidee">仓储部负责人:</label>--%>

				<div class="layui-input-inline">
					<input class="hide" name="storeChargeMan" value="${model.storeChargeMan}">
				</div>
			</div>
			<div class="layui-form-item layui-form-text layui-col-md3">
				<label class="layui-form-label"  style="text-align:right">备注:</label>
				<div class="layui-input-inline">
					<textarea placeholder="最多500字符"
						class="layui-textarea" name="remark" maxlength="200">${model.remark}</textarea>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label"  style="text-align:right"><span class="red">*</span>上报日期:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="reportTime" lay-verify="required"
							autocomplete="off" value='<fmt:formatDate pattern="yyyy-MM-dd" 
            value="${model.reportTime}" />' readonly>
				</div>
			</div>
		</div>

	
		<div class="layui-form-item text-center">
			<button type="button" class=" layui-btn layui-btn-primary layui-btn-small"
				lay-submit="" lay-filter="save" id="save">保存</button>
			<button type="button"
				class=" layui-btn layui-btn-primary layui-btn-small" id="cancel" data-bind="click:function(){$root.cancel();}">取消</button>
		</div>
	</form>

</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/storagefumigate/add.js"></script>
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
	$('[name="storehouse"]').val('${model.storehouse}');
	$('[name="grainType"]').val('${model.grainType}');
	$('[name="isFumigateLastYear"]').val('${model.isFumigateLastYear}');
	$('[name="storehouseType"]').val('${model.storehouseType}');
	$('[name="drugName"]').val('${model.drugName}');
	$('[name="fumigateType"]').val('${model.fumigateType}');
	$('[name="supplyType"]').val('${model.supplyType}');
	$('[name="isMultiSupply"]').val('${model.isMultiSupply}');
	/*$('[name="totalCirculationTime"]').val('${model.totalCirculationTime}');*/
	$('[name="weather"]').val('${model.weather}');
	$('[name="circulationType"]').val('${model.circulationType}');
    $('[name="maxPestDensity"]').val('${model.maxPestDensity}');
    $('[name="totalSupplyDosage"]').val('${model.totalSupplyDosage}');
    $('[name="totalCirculationStarttime"]').val('${model.totalCirculationStarttime}');
    $('[name="totalCirculationEndtime"]').val('${model.totalCirculationEndtime}');
}else{
    $('[name="storehouse"]').val('${model.storehouse}');
    $('[name="grainType"]').val('${model.grainType}');
    $('[name="isFumigateLastYear"]').val('${model.isFumigateLastYear}');
    $('[name="storehouseType"]').val('${model.storehouseType}');
    $('[name="drugName"]').val('${model.drugName}');
    $('[name="fumigateType"]').val('${model.fumigateType}');
    $('[name="supplyType"]').val('${model.supplyType}');
    $('[name="isMultiSupply"]').val('${model.isMultiSupply}');
    /*$('[name="totalCirculationTime"]').val('${model.totalCirculationTime}');*/
    $('[name="weather"]').val('${model.weather}');
    $('[name="circulationType"]').val('${model.circulationType}');
    $('[name="maxPestDensity"]').val('${model.maxPestDensity}');
    $('[name="totalSupplyDosage"]').val('${model.totalSupplyDosage}');
    $('[name="totalCirculationStarttime"]').val('${model.totalCirculationStarttime}');
    $('[name="totalCirculationEndtime"]').val('${model.totalCirculationEndtime}');
}
var vm = new Add(isedit,id,storehouses);
ko.applyBindings(vm,$(".container-box")[0]);
vm.initPage();

</script>

<script src="../js/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $(".ex .hide").click(function(){
            $(this).parents(".ex").hide("");
        });
        $(".exa .hide").click(function(){
            $(this).parents(".exa").hide("");
        });
        $(".exb .hide").click(function(){
            $(this).parents(".exb").hide("");
        });
        $(".exc .hide").click(function(){
            $(this).parents(".exc").hide("");
        });
        $(".exd .hide").click(function(){
            $(this).parents(".exd").hide("");
        });
        $(".exe .hide").click(function(){
            $(this).parents(".exe").hide("");
        });

    });
    layui.laydate.render({
        elem:$('[name="totalCirculationStarttime"]')[0],
        type:"date",
        format:"yyyy-MM-dd",
    });
    layui.laydate.render({
        elem:$('[name="totalCirculationEndtime"]')[0],
        type:"date",
        format:"yyyy-MM-dd",
    });



</script>
<%@include file="../common/AdminFooter.jsp"%>