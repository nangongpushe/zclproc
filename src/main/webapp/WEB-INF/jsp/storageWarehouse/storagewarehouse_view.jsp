<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container-box clearfix layui-fluid" style="padding: 10px">
	<div class="layui-fluid">
	<fieldset class="layui-elem-field layui-field-title text-center"
		style="margin-top: 20px;">
		<legend>${warehouse.warehouseName}</legend>
	</fieldset>
	<c:if test="${type eq 'dc' }">
		<div class="layui-row">
			<div class="layui-col-md4" style="width: 200px">
				<span>所属企业名称：</span> <span>${warehouse.enterpriseName }</span>
			</div>
			<div class="layui-col-md4"  style="width: 200px">
				<span>组织机构代码：</span> <span>${warehouse.organizationCode}</span>
			</div>
			<div class="layui-col-md4"  style="width: 200px">
				<span>统一社会信用代码：</span> <span>${warehouse.socialCreditCode}</span>
			</div>
		</div>
	</c:if>

	<div class="layui-row">
		<div class="layui-col-md12"  style="width: 200px">
			<span>库点代码：</span> <span>${warehouse.warehouseCode }</span>
		</div>
	</div>
		<div class="layui-row">
			<div class="layui-col-md12"  style="width: 200px">
				<span>库点名称：</span> <span>${warehouse.warehouseName }</span>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-md12"  style="width: 200px">
				<span>库点简称：</span> <span>${warehouse.warehouseShort }</span>
			</div>
		</div>
	<div class="layui-row">
		<div class="layui-col-md4"> 
			<span>库点企业性质：</span> <span>${warehouse.warehouseNature }</span>
		</div>
		<div class="layui-col-md4">
			<span>库点类别：</span> <span>${warehouse.warehouseType }</span>
		</div>
		<div class="layui-col-md4">
			<span>建成日期：</span> <span>${warehouse.completionDate }</span>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md4">
			<span>库点设计仓容(吨)：</span> <span>${warehouse.storageCapacity }</span>
		</div>
		<div class="layui-col-md4">
			<span>库点面积(平方米)：</span> <span>${warehouse.acreage }</span>
		</div>
		<div class="layui-col-md4">
			<span>库点电话：</span> <span>${warehouse.telphone }</span>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md4">
			<span>库点传真：</span> <span>${warehouse.fax }</span>
		</div>
		<div class="layui-col-md8">
			<span>库点行政区划名称：</span> <span>${warehouse.province } ${warehouse.city } ${warehouse.area }</span>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md4">
			<span>库点邮政编码：</span> <span>${warehouse.postalcode }</span>
		</div>
		<div class="layui-col-md4">
			<span>库点经度：</span> <span>${warehouse.longitude }</span>
		</div>
		<div class="layui-col-md4">
			<span>库点纬度：</span> <span>${warehouse.latitude }</span>
		</div>
		
	</div>
	<div class="layui-row">
		<div class="layui-col-md4">
			<span>库点地址：</span> <span>${warehouse.address }</span>
		</div>
		<div class="layui-col-md4">
			<span>库点联系人：</span> <span>${warehouse.creator }</span>
		</div>
	</div>
	</div>
</div>
