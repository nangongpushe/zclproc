<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<%@include file="../common/AdminHeader.jsp"%>

<style>
	#view td{
		width:100px;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>运费管理</li>
		<li class="active">运费招标结果录入</li>
	</ol>
</div>

<div class="container clearfix" style="padding: 10px">
	
	<div class="layui-row">
		<div class="layui-col-md3">
			<span>运费方案名称:</span> <span>${model.freightName}</span>
		</div>
		<div class="layui-col-md3">
			<span>招标单位:</span> <span>${model.inviteUnit}</span>
		</div>
		<div class="layui-col-md3">
			<span>招标时间:</span> <span><fmt:formatDate value="${model.inviteTime}" pattern="yyyy-MM-dd"/></span>
		</div>
		<div class="layui-col-md3">
			<c:if test="${model.groupId==null or model.groupId=='' }">
				<span>方案文件:</span> <span>暂无文件</span>
			</c:if>
			<c:if test="${model.groupId ne null and model.groupId ne '' }">
				<span>方案文件:</span> <span><a href="../sysFile/download.shtml?fileId=${model.groupId}" style="color: #0000FF; margin-left: 20px">点击下载</a></span>
			</c:if>
		</div>
	</div>

<!-- layui静态表格 -->
	<table class="layui-table" id="view">
		<thead>
				<tr>
					<td align="center">成交子明细号</td>
					<td align="center">轮换类型</td>
					<td align="center">标段</td>
	
					<td align="center">运输方式</td>
					<td align="center">发货地址</td>
	
					<td align="center">收货地址</td>

					<td align="center">距离(公里)</td>
					<td align="center">计划数量(吨)</td>
					<td align="center">备注</td>
					<td align="center">中标单位</td>
					<td align="center">报价(元/吨)</td>
				</tr>


		</thead>
		<tbody data-bind="foreach:freightDetails">
					<tr>
						<td data-bind="text:dealSerial" align="left"></td>
						<td data-bind="text:inviteType" align="left"></td>
						<td data-bind="text:tenders" align="left"></td>
						<td data-bind="text:shipType" align="left"></td>
						<td data-bind="text:deliveryAddress" align="left"></td>
						<td data-bind="text:receiveAddress" align="left"></td>
						<td data-bind="text:distance" align="right"></td>
						<td data-bind="text:planNumber" align="right"></td>
						<td data-bind="text:remark" align="left"></td>
						<td >
							<form>
							<select id="clientNameSel" class="layui-select" data-bind="options:$root.customers,optionsCaption:'--请选择--',
								optionsText:'clientName',optionsValue:'clientId', value:clientId" lay-verify="required" lay-search lay-filter="clientName" style="width: 150px">
							</select>
							</form>

						</td>
						<td>
							<input   lay-verify="required" autocomplete="off" lay-verify="required|number"
								class="layui-input" data-bind="value:price" maxlength="10"  oninput="if(value.length>10)value=value.slice(0,10)"
								   onchange = "numberFixed(this,2)">
						</td>
					</tr>


		</tbody>
	</table>

	<div class="layui-form-item text-center">				
		<button class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.updateClientNameAndPrice();}">保存</button>
		<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.cancel();}">取消</button>
	</div>
</div>



<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatefreight/invite_edit.js"></script>
<%--<script src="${ctx}/jslect/jquery.combo.select.js"></script>--%>
<script src="${ctx}/js/select/jquery.combo.select.js"></script>
<script>
    function numberFixed(obj,op){
        number = $(obj).val();
        if(number==null ||number =="" ){
            return
        }
        number = parseFloat(number).toFixed(op);
        $(obj).val(number);
    }

    var freightDetails=${cf:toJSON(model.freightDetails)};
	var customers=${cf:toJSON(customers)};
	var vm = new Add(freightDetails,customers);
	ko.applyBindings(vm,$(".container-box")[0]);


    layui.use(['form', 'laydate'], function(){
        var form = layui.form;
        form.render();
        form.on('select(clientName)', function(data){

        });


    });
</script>
<%@include file="../common/AdminFooter.jsp"%>