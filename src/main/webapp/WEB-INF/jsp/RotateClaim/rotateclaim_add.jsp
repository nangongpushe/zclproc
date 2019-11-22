<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp"%>

<style>
	#mytable + .layui-form .layui-table-body td[data-field="claimType"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="claimAmount"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="claimMan"]{
		text-align: left;
	}

</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>货款管理</li>
		<li class="active">认领单</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-row title">
		<h5>货款到帐单信息</h5>
	</div>
	
	<div class="layui-row">
		<div class="layui-col-md4">
			<span>填报人:</span> <span>${rotateArrive.reporter}</span>
		</div>
		<div class="layui-col-md4">
			<span>填报单位:</span> <span>${rotateArrive.reportDept}</span>
		</div>
		<div class="layui-col-md4">
			<span>填报时间:</span> <span><fmt:formatDate value="${rotateArrive.reportDate}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate></span>
		</div>
		<div class="layui-col-md4">
			<span>付款人:</span> <span>${rotateArrive.payer}</span>
		</div>
		<div class="layui-col-md4">
			<span>付款单位:</span> <span>${rotateArrive.payUnit}</span>
		</div>
		<div class="layui-col-md4">
			<span>收款时间:</span> <span><fmt:formatDate value="${rotateArrive.arriveDate}" pattern="yyyy-MM-dd HH:mm" /></span>
		</div>
		<div class="layui-col-md4">
			<span>来款金额(元):</span> <span><fmt:formatNumber type="number" value="${rotateArrive.arriveAmount}"/></span>
		</div>
		<div class="layui-col-md4">
			<span>余额(元):</span> <span><fmt:formatNumber value="${rotateArrive.balance}"/></span>
		</div>
		<div class="layui-col-md4">
			<span>货款状态:</span> <span>${rotateArrive.claimStatus}</span>
		</div>
		<div class="layui-col-md12">
			<span>备注:</span> <span>${rotateArrive.remark}</span>
		</div>
	</div>
	
	
	<div class="layui-row title">
		<h5>认领单信息</h5>
	</div>
	
	<form class="layui-form"  lay-filter="form" id="form1">

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">认领人:</label>
				<div class="layui-input-inline">
					<input type="text" name="claimMan" readonly autocomplete="off"
						class="layui-input form-control" value="${model.claimMan}">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">认领时间:</label>
				<div class="layui-input-inline">
					<input type="text" name="claimDate" autocomplete="off"
						class="layui-input form-control" readonly
						value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${model.claimDate}" />'>
				</div>
			</div>

			<%--<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">认领时间:</label>
				<div class="layui-input-inline">
					<input type="text" name="claimDate" lay-verify="required"
						   autocomplete="off" placeholder="请输入认领时间" class="layui-input"
						   value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${model.claimDate}" />">
				</div>
			</div>--%>
		</div>

		<div class="layui-form-item" id="dealItem">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">所属成交子明细号:</label>
				<div class="layui-input-inline">
					<input type="text" name="dealSerial" lay-verify="required" readonly
						autocomplete="off" placeholder="--点击选择--"
						class="layui-input form-control" value="${model.dealSerial}">
				</div>
				<c:if test="${model.id==null or '' eq model.id}">
				<div class="layui-form-mid layui-word-aux">
					<a type="button" class="btn btn-link" id="chooseBtn"
						data-target="#myModal" data-bind="click:function(){$root.showModal();}">选择</a>
				</div>
				</c:if>
			</div>
			
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">认领类型:</label>
				<div class="layui-input-inline">

					<select name="claimType" lay-filter="claimType" data-change="0" data-loaded="0">
						<option value="">请选择</option>
						<option value="货款">货款</option>
						<!-- <option value="商务处理款">商务处理款</option> -->
						<!-- ko foreach : processDetails-->
							<option data-bind="value:type,text:type"></option>
						<!-- /ko -->
					</select>
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">认领额度(元):</label>
				<div class="layui-input-inline">
					<input type="text" name="claimBound" readonly
						autocomplete="off"  class="layui-input form-control" value="${model.claimBound}">
				</div>
			</div>
			
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">认领金额(元):</label>
				<div class="layui-input-inline">
					<input type="text" name="claimAmount"
						autocomplete="off" placeholder="请输入认领金额" class="layui-input" value="${model.claimAmount}"
						data-bind="value:claimAmount,event:{keyup:function(){$root.checkAmount($element);}}">
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">认领库点及仓号:</label>
				<div class="layui-input-inline">
					<input type="text" name="warehouseAndEncode" readonly
						   autocomplete="off"  class="layui-input form-control" value="">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">认领吨数:</label>
				<div class="layui-input-inline">
					<%--<input type="text" name="claimAmount"
						   autocomplete="off" placeholder="请输入认领金额" class="layui-input" value="${model.claimAmount}"
						   data-bind="event:{keyup:function(){$root.checkAmount($element);}}">--%>
					<input type="text" name="claimWeight"
						   autocomplete="off" placeholder="请输入认领吨数" class="layui-input" value=""
						   data-bind="value:claimWeight">
						   <%--data-bind="event:{keyup:function(){$root.checkQuantity($element);}}">--%>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">

			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">成交总数(吨):</label>
				<div class="layui-input-inline">
					<%--<input type="text" name="claimAmount"
						   autocomplete="off" placeholder="请输入认领金额" class="layui-input" value="${model.claimAmount}"
						   data-bind="event:{keyup:function(){$root.checkAmount($element);}}">--%>
					<span name="quantity" readonly class="layui-input form-control"></span>
				</div>
			</div>
		</div>

		<hr class="layui-bg-green">

		<div class="layui-form-item text-center">
			<button class="layui-btn layui-btn-primary layui-btn-small" lay-submit="" lay-filter="save">保存</button>
			<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.cancel()}">取消</button>

		</div>
	</form>
	
	<div class="layui-row title">
		<h5>认领记录</h5>
	</div>
	
	<table class="layui-table" lay-filter="table" id="myTable"></table>
	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="delete">退款</a>
  	</script>

	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<div class="layui-form" id="search" lay-filter="search">
						<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">成交子明细号:</label>
								<div class="layui-input-inline">
									<input class="layui-input" name="dealSerial"
										autocomplete="off">
								</div>
							</div>
<%-- 							<div class="layui-inline">
								<label class="layui-form-label">粮食品种:</label>
								<div class="layui-input-inline">
									<select  name="grainType">
										<option value="">--请选择--</option>
										<c:forEach var="item" items="${grainTypes}">
											<option value="${item.value}">${item.value}</option>
										</c:forEach>
									</select>
								</div>
							</div> --%>
							
<%-- 							<div class="layui-inline">
								<label class="layui-form-label">成交单位:</label>
								<div class="layui-input-inline">
									<select name="dealUnit" lay-search>
										<option value="">--请选择--</option>
										<c:forEach items="${customers}" var="custom">
											<option value="${custom.clientName}">${custom.clientName}</option>
										</c:forEach>
									</select>
								</div>
							</div>  --%>

							<div class="layui-inline">
								<label class="layui-form-label">竞价交易时间:</label>
								<div class="layui-input-inline">
									<input class="layui-input" name="dealDate" id="dealDate"
										autocomplete="off">
								</div>
							</div>
							<div class="layui-inline">
								<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload"
									data-bind="click:function(){$root.queryPageList();}">查询</button>
							</div>
						</div>
					</div>
					
					<table class="layui-table">
						<thead>
							<tr>
								<td data-bind="visible:list().length!=0" style="text-align: center"></td>
								<td style="text-align: center">成交子明细号</td>
								<td style="text-align: center">竞价交易时间</td>
								<td style="text-align: center">成交单位</td>
								
							</tr>
						</thead>
						<tbody data-bind="foreach:list">
							<tr>

								<td><input type="radio" name="radio"
									data-bind="click:function(){$root.choose($data);return true;}" /></td>

								<td style="text-align: left" data-bind="text:dealSerial"></td>
								<td style="text-align: center" data-bind="text:dealDate"></td>
								<td style="text-align: left" data-bind="text:dealUnit"></td>

							</tr>
						</tbody>

					</table>
					<div class="layui-row text-center"
						data-bind="visible:list().length==0">无数据</div>
					<div class="layui-row">
						<div id="pagination" class="pull-right"></div>
					</div>
					
				</div>
				
				
				<div class="modal-footer">
					<button type="button" class="layui-btn layui-btn-primary layui-btn-small"
						data-bind="click:function(){$root.confirmChoose();}">确定</button>
					<button type="button" class="layui-btn layui-btn-primary layui-btn-small"
						data-bind="click:function(){$root.hideModal();}">取消</button>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->

</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>
<script src="${ctx}/js/app/rotateclaim/add.js"></script>
<script type="text/html" id="claimDateFormat">
	{{Date_format(d.claimDate,true)}}
</script>


<script>

	var rotateClaim = ${cf:toJSON(model)};
	var rotateArrive = ${cf:toJSON(rotateArrive)};
	var vm = new Add(rotateArrive,rotateClaim);
	ko.applyBindings(vm,$('.container-box')[0]);
	vm.initPage();

	function Format(datetime,fmt) {
		if(datetime == null){
			return "";
		}
		if (parseInt(datetime)==datetime) {
			if (datetime.length==10) {
				datetime=parseInt(datetime)*1000;
			} else if(datetime.length==13) {
				datetime=parseInt(datetime);
			}
		}
		datetime=new Date(datetime);
		var o = {
			"M+" : datetime.getMonth()+1,                 //月份
			"d+" : datetime.getDate(),                    //日
			"h+" : datetime.getHours(),                   //小时
			"m+" : datetime.getMinutes(),                 //分
			"s+" : datetime.getSeconds(),                 //秒
			"q+" : Math.floor((datetime.getMonth()+3)/3), //季度
			"S"  : datetime.getMilliseconds()             //毫秒
		};
		if(/(y+)/.test(fmt))
			fmt=fmt.replace(RegExp.$1, (datetime.getFullYear()+"").substr(4 - RegExp.$1.length));
		for(var k in o)
			if(new RegExp("("+ k +")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
		return fmt;
	}
</script>

<%@include file="../common/AdminFooter.jsp"%>