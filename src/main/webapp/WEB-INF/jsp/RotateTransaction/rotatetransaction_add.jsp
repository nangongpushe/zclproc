<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp"%>

<style>
	#mainTable + .layui-form .layui-table-body td[data-field="mainSchemeName"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="schemeBatch"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="libraryId"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="branNumber"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="foodType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="rotateNumber"]{
		text-align: right;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>竞标管理</li>
		<li class="active">交易明细管理</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-row title">
		<h5>招标结果信息</h5>
	</div>
	
	<form class="layui-form"  lay-filter="form">

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮食品种:</label>
				<div class="layui-input-inline">
					<select lay-verify="required" name="grainType" onChange="toCheckIsChanged(this);">
						<option value="">--请选择--</option>
						<c:forEach items="${grainTypes}" var="item">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>采购类别:</label>
				<div class="layui-input-inline">
					<select lay-verify="required" name="inviteType"
						lay-filter="mainScheme" >
						<option value="">--请选择--</option>
						<option value="订单采购">订单采购</option>
						<option value="进口粮采购">进口粮采购</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>采购年份:</label>
					<div class="layui-input-inline">
						<input class="layui-input" name="year" autocomplete="off" lay-filter="mainScheme">
				</div>
			</div>

		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>汇总人:</label>
				<div class="layui-input-inline">
					<input type="text" name="gather" lay-verify="required" readonly
						autocomplete="off" class="layui-input form-control" value="${model.gather}">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>汇总时间:</label>
				<div class="layui-input-inline">
					<input type="text" name="gatherDate" lay-verify="required" readonly
						autocomplete="off" class="layui-input form-control" value='<fmt:formatDate pattern="yyyy-MM-dd" 
            value="${model.gatherDate}" />'>
				</div>
			</div>
			
<%-- 			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label"><span class="red">*</span>汇总部门:</label>
				<div class="layui-input-inline">
					<input type="text" name="gatherUnit" lay-verify="required" readonly
						autocomplete="off" class="layui-input form-control" value="${model.gatherUnit}">
				</div>
			</div> --%>
		</div>

		<hr class="layui-bg-green">
		
	<button type="button" class=" layui-btn layui-btn-primary layui-btn-small " lay-filter="showModal"
	 	data-target="#addModal" data-bind="click:function(){$root.showModal();}">新增</button>	
	<!-- layui静态表格 -->
	<table class="layui-table" id="detailTable">
		<thead>
				<tr>
					<td align="center">企业</td>
					<td  align="center">接收所属库点</td>
					<td  align="center">仓房编号</td>
					<td  align="center">粮食品种</td>
					<td  align="center">数量</td>
					<td  align="center">产地</td>
					<td  align="center">收获年份</td>
					<td align="center">包装方式</td>
					<td  align="center">成交价格(元/吨)</td>
					<td  align="center">成交金额(元)</td>
					<td  align="center">交货起始日期</td>
					<td  align="center">交货截止日期</td>
					<td  align="center">成交单位</td>
					<td  align="center">操作</td>
				</tr>
		</thead>
		<tbody data-bind="foreach:rotateConclute.detailList" id="detailTable">
				<tr>
					<td data-bind="text:enterpriseName" align="left"></td>
					<td data-bind="text:enterpriseId" style="display: none"></td>
					<td data-bind="text:receivePlace" align="left"></td>
                    <%--<td data-bind="text:receiveId" style="display: none">--%>
					<td data-bind="text:storehouse" align="left"></td>
					<td data-bind="text:grainType"  align="left" tag="grainType"></td>
					<td data-bind="text:quantity" align="right"></td>
					<td data-bind="text:produceArea"  align="left"></td>
					<td data-bind="text:produceYear" align="center"></td>
					<td data-bind="text:storageType" align="center"></td>
					<td align="right">
						<%--<input type="number" data-bind="value:dealPrice" class="layui-input" lay-verify="required" name="dealPrice" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')">--%>
							<input type="number" step="0.01" data-bind="value:dealPrice" class="layui-input" lay-verify="required" name="dealPrice" onkeyup="value=value.replace(/[^\d\.]/g,'')"  data-rule="integer;length[1~10]" min="0"  maxlength="10">
					</td>
					<td align="right">
						<%--<input data-bind="value:dealAmount" class="layui-input" lay-verify="required" name="dealAmount" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')">--%>
							<input type="number" step="0.01" data-bind="value:dealAmount" class="layui-input" lay-verify="required" name="dealAmount" onkeyup="value=value.replace(/[^\d\.]/g,'')"  data-rule="integer;length[1~10]" min="0"  maxlength="10">

					</td>
					<td align="center">
						<input data-bind="value:deliveryStart" class="layui-input" lay-verify="required" name="deliveryStart">
					</td>
					<td align="center">
						<input data-bind="value:deliveryEnd" class="layui-input" lay-verify="required" name="deliveryEnd">
					</td>
					<td align="left">
						<%--<select data-bind="options:$root.clientNames,optionsCaption:'--请选择--',value:dealUnit" class="layui-select"  lay-verify="required" name="dealUnit" >--%>
						<%--</select>--%>
						<select  class="layui-select" name="dealUnit" data-bind="options:$root.customers,optionsCaption:'--请选择--',
								optionsText:'clientName',optionsValue:'clientId'" lay-verify="required" lay-search >
						</select>
					</td>
					<td align="center">
  						<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.removeDetail($data,$index());}">删除</a>
					</td>
				</tr>
		</tbody>
	</table>

		<div class="layui-row text-center"
			data-bind="visible:rotateConclute.detailList().length==0">未找到相关子方案</div>

		<hr class="layui-bg-green">

		<div class="layui-form-item text-center">

				<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="submitId" lay-submit="" lay-filter="save">保存</button>
				<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.cancel();}">取消</button>
		</div>
	</form>

		<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">查询子方案</h4>
				</div>
				<div class="modal-body">
					<div class="layui-form" id="search" lay-filter="search">
						<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">方案名称:</label>
								<div class="layui-input-inline">
									<input type="text" name="mainSchemeName"
										autocomplete="off" class="layui-input">
								</div>

								<label class="layui-form-label">子方案批号:</label>
								<div class="layui-input-inline">
									<input type="text" name="schemeBatch"
										autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">库点类型:</label>
								<div class="layui-input-inline">
									<select name="warehouseType">
										<option value="">--全部--</option>
										<option value="储备库">直属单位</option>
										<option value="代储库">代储库</option>
									</select>
								</div>
								<label class="layui-form-label">所属库点:</label>
								<div class="layui-input-inline">
									<%--<input type="text" name="libraryId"
										   autocomplete="off" class="layui-input">--%>
									<select lay-verify="required" class="form-control"  name="libraryId" id="libraryId" lay-search lay-filter="libraryId">
										<option value="">--搜索选择--</option>
										<c:forEach items="${storageWarehouses}" var="storageWarehouse">
											<option value="${storageWarehouse.warehouseShort}" >${storageWarehouse.warehouseShort}</option>
										</c:forEach>
									</select>

								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">所属仓号:</label>
								<div class="layui-input-inline">
									<%--<input type="text" name="branNumber"
										   autocomplete="off" class="layui-input">--%>
									<select lay-verify="required" class="form-control"  name="branNumber" id="branNumber" lay-search lay-filter="branNumber">
										<option value="">--搜索选择--</option>
										<c:forEach items="${branNumbers}" var="branNumber">
											<option value="${branNumber}" >${branNumber}</option>
										</c:forEach>
									</select>
								</div>
								<%--<label class="layui-form-label">粮食品种:</label>
								<div class="layui-input-inline">
									<select lay-verify="required" name="foodType">
										<option value="">--全部--</option>
										<c:forEach items="${grainTypes}" var="item">
											<option value="${item.value}">${item.value}</option>
										</c:forEach>
									</select>
								</div>--%>
							</div>


							<div class="layui-inline">
								<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload"
									data-bind="click:function(){$root.queryPageList();}">查询</button>
								<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload"
										data-bind="click:function(){$root.clear();}">清空</button>
							</div>
						</div>
					</div>
					
					<div class="layui-row text-center">
						<table class="layui-table" id="mainTable" lay-filter="table"></table>

					</div>

			</div>
			<div class="modal-footer">
					<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.selectConfirm();}">确认</button>
					<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal">取消</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatetransaction/add.js"></script>
<script>

	var rotateConclute=${cf:toJSON(model)};
	<%--var clientNames=${cf:toJSON(clientNameList)}--%>
    var customers=${cf:toJSON(customers)};
	var vm = new Add(rotateConclute,customers);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();


</script>
<%@include file="../common/AdminFooter.jsp"%>