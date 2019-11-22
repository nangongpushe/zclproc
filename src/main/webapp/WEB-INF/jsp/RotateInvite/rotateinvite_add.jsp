<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp"%>

<style>

.btn:hover, .btn:link, .btn:active, .btn:visited{
	background-color:#fff;
	color:#23527c;
	border-color:#fff;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>竞标管理</li>
		<li class="active">招标结果管理</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px"
	id="rotateinvite_add">

	<div class="layui-row title">
		<h5>招标结果信息</h5>		
	</div>

	<form class="layui-form" lay-filter="search">

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>招标结果名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="inviteName" lay-verify="required"
						autocomplete="off" placeholder="请输入招标结果名称"
						value="${model.inviteName}" maxlength="45">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>招标结果类别:</label>
				<div class="layui-input-inline">
					<select lay-verify="required" name="inviteType"
						lay-filter="inviteType">
						<option value="">--请选择--</option>
						<option value="招标采购">招标采购</option>
						<option value="竞价销售">竞价销售</option>
						<option value="内部招标">内部招标</option>
						<option value="协议销售">协议销售</option>
					</select>
				</div>
			</div>
		</div>

		<div class="layui-form-item layui-form-text">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>所属标的:</label>
				<div class="layui-input-inline">
					<input type="text" name="bidName" lay-verify="required" readonly
						autocomplete="off" placeholder="--点击选择--"
						class="layui-input form-control" value="${model.bidName}">
				</div>
				<div class="layui-form-mid layui-word-aux">
					<a type="button" class="btn btn-link" id="chooseBtn"
						 data-target="#myModal" data-bind="click:function(){$root.showModal();}">选择</a>
				</div>
			</div>
			<div class="layui-inline layui-col-md5">
				<button style="margin-left: 62px;" type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="excel" name="file">数据导入</button>
				<input hidden="hidden" id="msg" value=""/>
				<a style="margin-left:10px"  href="../sysFile/downloadTemplate.shtml?filename=招标结果模板">招标结果模板下载</a>
			</div>
		</div>
		<div class="layui-form-item layui-form-text">

				<label class="layui-form-label">备注:</label>
				<div class="layui-input-block">
					<textarea placeholder="最多500字符" class="layui-textarea" name="remark" maxlength="500">${model.remark}</textarea>
				</div>
		</div>
		<%--<div class="layui-form-item layui-form-text">
			<label class="layui-form-label">备注:</label>
			<div class="layui-input-block">
				<textarea placeholder="请输入内容,最多200个字符" class="layui-textarea" name="description" maxlength="200">${rotatePlan.description}</textarea>
			</div>
		</div>--%>
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>委托单位:</label>
				<div class="layui-input-inline">
					<input type="text" name="entrustCompany" lay-verify="required"
						readonly autocomplete="off" placeholder="--导入--"
						class="layui-input form-control" value="${model.entrustCompany}">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">委托标的:</label>
				<div class="layui-input-inline">
					<input type="text" name="entrustBid" readonly autocomplete="off"
						placeholder="--导入--" class="layui-input form-control"
						value="${model.entrustBid}">
				</div>
			</div>
		</div>


		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">委托数量(吨):</label>
				<div class="layui-input-inline">
					<input name="entrustNum" autocomplete="off" placeholder="--导入--"
						class="layui-input form-control" readonly
						value="${model.entrustNum}">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>实施单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="exploitingEntity"
						placeholder="--导入--" autocomplete="off" lay-verify="required"
						value="${model.exploitingEntity}" readonly>
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>数量合计(吨):</label>
				<div class="layui-input-inline">
					<input name="totalNum" autocomplete="off" placeholder="--导入--"
						class="layui-input form-control" readonly
						value="${model.totalNum}">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>竞得价合计(元/吨):</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="totalCompetitivePrice"
						placeholder="--导入--" autocomplete="off" lay-verify="required"
						value="${model.totalCompetitivePrice}" readonly>
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>标的物总价合计(元):</label>
				<div class="layui-input-inline">
					<input name="totalBidPrice" autocomplete="off" placeholder="--导入--"
						class="layui-input form-control" readonly
						value="${model.totalBidPrice}">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>占用保证金合计(元):</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="totalBail"
						placeholder="--导入--" autocomplete="off" lay-verify="required"
						value="${model.totalBail}" readonly>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">经办人:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="operator"
						placeholder="请输入经办人" autocomplete="off" value="${model.operator}"
						readonly>
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">经办部门:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="department"
						placeholder="请输入经办部门" autocomplete="off"
						value="${model.department}" readonly>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">经办时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="handleTime"
						placeholder="请输入经办时间" autocomplete="off"
						value='<fmt:formatDate value="${model.handleTime}" pattern="yyyy-MM-dd" />'
						readonly>
				</div>
			</div>

		</div>


	<div class="layui-row title">
		<h5>招标结果明细</h5>
	</div>



		<table class="layui-table">
			<thead>
				<tr>
					<td align="center">标段</td>
					<td align="center">竞得单位</td>
					<td align="center">数量(吨)</td>
					<td align="center">起始价(元/吨)</td>
					<td align="center">竞得价(元/吨)</td>
					<td align="center">标的物总价(元)</td>
					<td align="center">占用保证金(元)</td>

				</tr>
			</thead>
			<tbody data-bind="foreach:inviteDetail">
				<tr>
					<td data-bind="text:bidSerial" style="text-align:right"></td>
					<td data-bind="text:competitiveUnit" style="text-align:left"></td>
					<td data-bind="text:num" style="text-align:right"></td>
					<td data-bind="text:startingPrice" style="text-align:right"></td>
					<td data-bind="text:competitivePrice" style="text-align:right"></td>
					<td data-bind="text:bidPrice" style="text-align:right"></td>
					<td data-bind="text:bail" style="text-align:right"></td>
				</tr>
			</tbody>
		</table>
		<div class="layui-row text-center"
			data-bind="visible:inviteDetail().length==0">暂未导入明细数据</div>

		<div class="layui-form-item text-center">
				
				<button class=" layui-btn layui-btn-primary layui-btn-small" lay-submit="" lay-filter="save" data-gather="0">保存</button>
				<button class=" layui-btn layui-btn-primary layui-btn-small" lay-submit="" lay-filter="save" data-gather="1">提交</button>
				<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="cancel">取消</button>
				
		</div>
	</form>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<div class="layui-form" id="search" lay-filter="search">
						<div class="layui-form-item">
							<!--  <div class="layui-inline">
								<label class="layui-form-label">标的物类别:</label>
								<div class="layui-input-inline">
									<select class="layui-input" name="bidType" lay-filter="aihao"
										id="state">
										<option></option>
										<option>竞价销售</option>
										<option>招标采购</option>
										<option>内部销售</option>
										<option>协议销售</option>
									</select>
								</div>
							</div>-->
							<div class="layui-inline">
								<label class="layui-form-label">招标/卖出人:</label>
								<div class="layui-input-inline">
									<input class="layui-input" name="tenderee" autocomplete="off">
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">粮食品种:</label>
								<div class="layui-input-inline">
									<select lay-verify="required" name="foodType"
										lay-filter="foodType">
										<option value="">--请选择--</option>
										<c:forEach items="${grainTypes }" var="item">
											<option value="${item.value}">${item.value}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">经办时间:</label>
								<div class="layui-input-inline">
									<input class="layui-input" name="createDate" id="createDate"
										autocomplete="off">
								</div>
							</div>
							<div class="layui-inline">
							<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload"
									data-bind="click:function(){$root.queryPageList();}">查询</button>
							</div>
							<div class="layui-inline">
								<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload"
										data-bind="click:function(){$root.clear();}">清空</button>
							</div>
						</div>
					</div>

					<table class="layui-table">
						<thead>
							<tr>
								<td data-bind="visible:searchlist().length!=0"></td>
								<td align="center">标的物名称</td>
								<td align="center">标的物类别</td>
								<td align="center">招标人/卖出人</td>
								<td align="center">粮食品种</td>
								<td align="center">数量合计(吨)</td>
								<td align="center">经办人</td>
								<td align="center">经办时间</td>
							</tr>
						</thead>
						<tbody data-bind="foreach:searchlist">
							<tr>

								<td><input type="radio" name="radio"
									data-bind="click:function(){$root.choose($data);return true;}" /></td>
								<td data-bind="text:bidName" align="left"></td>
								<td data-bind="text:bidType" align="left"></td>
								<!-- ko if:bidType=="招标采购" -->
								<td data-bind="text:tenderee" align="left"></td>
								<!-- /ko -->
								<!-- ko if:bidType!="招标采购" -->
								<td data-bind="text:saler" align="left"></td>
								<!-- /ko -->
								<td data-bind="text:foodType" align="left"></td>
								<td data-bind="text:total" align="right"></td>
								<td data-bind="text:creator" align="left"></td>
								<td data-bind="text:createDate" align="center"></td>
							</tr>
						</tbody>
						
					</table>
					<div class="layui-row text-center"
						data-bind="visible:searchlist().length==0">未找到相关标的</div>
					<div class="layui-row">
						<div id="pagination" class=""></div>
					</div>
				</div>
				<div class="modal-footer">
                	
                	<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal" data-bind="click:function(){$root.confirmChoose();}">确定</button>
                	<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal">取消</button>
            	</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>




<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotateinvite/add.js"></script>

<script>
	var isedit = ${isEdit};
	var id = '${model.id}'||0;
	var inviteSerial = '${model.inviteSerial}'||'';
	var currentBid=${cf:toJSON(currentBid)};
	var inviteDetail=${cf:toJSON(inviteDetail)};
	if (isedit) {
		$('.layui-form-item select[name="inviteType"]').val("${model.inviteType}");
	}
	var vm = new Add(isedit,id,inviteSerial,inviteDetail,currentBid);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();




</script>
<%@include file="../common/AdminFooter.jsp"%>