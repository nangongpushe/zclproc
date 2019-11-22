<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp"%>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>竞标管理</li>
		<li class="active">标的物明细</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

	<form class="layui-form" lay-filter="form">

		<div class="layui-row title">
			<h5>标的物信息</h5>
		</div>
		<div class="layui-form-item">

			<label class="layui-form-label" style="text-align:right"><span class="red">*</span>标的物名称:</label>
			<div class="layui-input-inline">
				<input type="text" name="bidName" lay-verify="required" value="${model.bidName}"
					autocomplete="off" placeholder="请输入标的物名称" class="layui-input" maxlength="45"/>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>竞价时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="dealDate" value='<fmt:formatDate value="${model.dealDate}" pattern="yyyy-MM-dd" />'
						autocomplete="off" lay-verify="required" >
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>标的物类别:</label>
				<div class="layui-input-inline">
					<select lay-verify="required" name="bidType" lay-filter="bidType" >
						<option value="招标采购">招标采购</option>
						<option value="竞价销售">竞价销售</option>
						<option value="内部招标">内部招标</option>
						<option value="协议销售">协议销售</option>
					</select>
				</div>
			</div>
		</div>
		<!-- ko if: bidType()=='招标采购'-->
		<div class="layui-form-item" id="tenderee" >

			<label class="layui-form-label" style="text-align:right"><span class="red">*</span>招标人:</label>
			<div class="layui-input-inline">
				<input type="text" maxlength="45" name="tenderee"  value='<c:choose><c:when test="${isEdit&&model.tenderee!='--'}">${model.tenderee}</c:when><c:otherwise>浙江省储备粮管理有限公司</c:otherwise></c:choose>' lay-verify="required"
					autocomplete="off" placeholder="请输入招标人" class="layui-input">
			</div>
		</div>

		<div class="layui-form-item" id="foodType" >
			<label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮食品种:</label>
			<div class="layui-input-inline">
				<select lay-verify="required" name="foodType" lay-filter="foodType" >
						<option value="">--请选择--</option>
						<c:forEach items="${grainTypes }" var="item">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
				</select>
			</div>
		</div>
		<!-- /ko -->
		<!-- ko if: bidType()!='招标采购'-->
		<div class="layui-form-item" id="saler" >
			<label class="layui-form-label" style="text-align:right"><span class="red">*</span>卖出人:</label>
			<div class="layui-input-inline">
				<input type="text" name="saler" maxlength="45"  lay-verify="required"
					autocomplete="off" placeholder="请输卖出人" class="layui-input" 
				value='<c:choose><c:when test="${isEdit&&model.saler!='--'}">${model.saler }</c:when><c:otherwise>浙江省储备粮管理有限公司</c:otherwise></c:choose>'>
			</div>
		</div>

		<div class="layui-form-item" id="saleDate">
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>卖出时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="saleDate" id="saleDate"  value='<fmt:formatDate value="${model.saleDate}" pattern="yyyy-MM-dd" />'
						autocomplete="off" lay-verify="required" >
				</div>
			</div>
		</div>
		<!-- /ko -->
		
		<div class="layui-form-item">
			<label class="layui-form-label" style="text-align:right">附件:</label>
			<div class="layui-input-block">
				<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="uploadFile" name="file">
				<c:choose>
				<c:when test="${model.groupID!=null and model.groupID!=''}">
					<i class="layui-icon"></i>上传
				</c:when>
				<c:otherwise>
					<i class="layui-icon"></i>上传
				</c:otherwise>
				</c:choose>
				</button>
				<span id="fileName">
					<a href="${ctx }/sysFile/download.shtml?fileId=${model.groupID}" style="margin:0 10px;">${myFile.fileName}</a>
				</span>
				<%--<div id="afileName" style="display:inline-block;font-size:14px;" >
					<a href="${ctx }/sysFile/download.shtml?fileId=${model.groupID}" style="margin:0 10px;">${myFile.fileName}</a>
				</div>--%>
				<div style="display:inline-block;font-size:20px;" id="openExce">
					<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
						预览
					</a>
					<a href="javascript:openAnnex('${model.groupID}')" id="openFile" style="display: none">
						预览
					</a>
				</div>
				<input class="layui-btn layui-btn-small layui-btn-primary" <c:if test="${!(model.groupID!=null and model.groupID!='')}"> style="display: none" </c:if> type="button" id="clearFileBtn" value="删除"/>

				</div>
			<div class="layui-input-inline">
				<input type="text" name="groupID" readonly style="display:none;" id="fileId"
					autocomplete="off" class="layui-input form-control" value="${model.groupID}">
			</div>
		</div>

		<div class="layui-form-item layui-form-text">
			<label class="layui-form-label" style="text-align:right">备注:</label>
			<div class="layui-input-block">
				<textarea style="resize:none" placeholder="请输入内容" class="layui-textarea" name="remark" maxlength="200">${model.remark}</textarea>
			</div>
		</div>


		
		<hr class="layui-bg-green">
		<!-- ko if: bidType()=='招标采购'-->
		<button type="button" class=" layui-btn layui-btn-primary layui-btn-small " id="file" name="file" >
			采购明细导入
		</button>
		<a class="download" href="../sysFile/downloadTemplate.shtml?filename=标的物明细_采购模板">采购模板下载</a>
		<!-- /ko -->
		<!-- ko if: bidType()!='招标采购'-->
		<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="file" name="file" >
			销售明细导入
		</button>
		<a class="download" href="../sysFile/downloadTemplate.shtml?filename=标的物明细_销售模板">销售模板下载</a>
		<!-- /ko -->
        &nbsp&nbsp
        统一方案
        <input name="coverAll" id="coverAll" type="checkbox" value="1" lay-skin="primary"/>
		<table class="layui-table">
			<thead>
				<tr>
					<td align="center">子方案ID</td>
				<!-- ko if:  $root.bidType()=='招标采购'-->
					<td align="center">标的号</td>
					<td align="center">企业</td>
					<td align="center">库点</td>
					<td align="center">仓房</td>
					<td align="center">数量（吨）</td>
					<td align="center">产地</td>
					<td align="center">收获年份</td>
					<td align="center">包装储粮方式</td>
					<td align="center">粒型</td>
					<td align="center">交货日期起止</td>
					<td align="center">日接受能力（吨）</td>
					<td align="center">运输类型</td>
					<td align="center">所属库点联系人</td>
					<td align="center">联系电话</td>
					<td align="center">质量等级</td>
					<td align="center">货款支付免息截止日期</td>
				<!-- /ko -->
				<!-- ko if:  $root.bidType()!='招标采购'-->
					<td align="center">标的号</td>
					<td align="center">粮食品种</td>
					<td align="center">合计（吨）</td>
					<td align="center">粮食产地</td>
					<td align="center">收获年度</td>
					<td align="center">存储方式</td>
					<td align="center">提货日期起</td>
					<td align="center">提货日期止</td>
					<td align="center">交货所属库点及仓库</td>
					<td align="center">容重（g/L）</td>
					<td align="center">质量等级</td>
				<!-- /ko -->
				</tr>
			</thead>
			<tbody data-bind="foreach:detailList">
				<tr>
					<td>
						<a href="javascript:void(0);" data-bind="text:schemeID,click:function(){$root.showModal($data);},
											style:{color:schemeID() == '--请选择--'?'red':'#404040'}"></a>
<!-- 						<select data-bind="options:$root.searchlist,
											optionsText:'schemeBatch',
											optionsCaption:'请选择',
											optionsValue:'dId',
											value:schemeID,attr:{'data-index':$index()}" lay-filter="schemeId">
						</select> -->
					</td>
				<!-- ko if: $root.bidType()=='招标采购'-->
					<td data-bind="text:bidSerial.substring(0,45)" align="right"></td>
					<td data-bind="text:enterprise" align="left"></td>
					<td data-bind="text:company" align="left"></td>
					<td data-bind="text:storeHouse" align="left"></td>
					<td data-bind="text:quantity" align="right"></td>
					<td data-bind="text:produceArea" align="left"></td>
					<td data-bind="text:produceYear" align="center"></td>
					<td data-bind="text:packageType" align="left"></td>
					<td data-bind="text:grainShape" align="left"></td>
					<td data-bind="text:deliveryStart+'至'+deliveryEnd" align="left"></td>
					<td data-bind="text:dailyReceptivity" align="right"></td>
					<td data-bind="text:transportType" align="left"></td>
					<td data-bind="text:contact" align="left"></td>
					<td data-bind="text:contactNumber" align="right"></td>
					<td data-bind="text:planLevel" align="left"></td>
					<td data-bind="text:loanPaymentEndDate" align="left"></td>
				<!-- /ko -->
				<!-- ko if: $root.bidType()!='招标采购' -->
					<td data-bind="text:bidSerial" align="right"></td>
					<td data-bind="text:grainType" align="left"></td>
					<td data-bind="text:total" align="right"></td>
					<td data-bind="text:produceArea" align="left"></td>
					<td data-bind="text:warehouseYear" align="center"></td>
					<td data-bind="text:storageType" align="left"></td>
					<td data-bind="text:takeStart" align="center"></td>
					<td data-bind="text:takeEnd" align="center"></td>
					<td data-bind="text:deliveryPlace+storehouse" align="left"></td>
					<td data-bind="text:unitWeight" align="right"></td>
					<td data-bind="text:planLevel" align="left"></td>
				<!-- /ko -->
				</tr>
			</tbody>
		</table>
		<div class="layui-row text-center"
			data-bind="visible:detailList().length==0">暂未导入明细数据</div>
			
		<hr class="layui-bg-green">

		<div class="layui-form-item text-center">

				<button class=" layui-btn layui-btn-primary layui-btn-small " lay-submit="" lay-filter="save">保存</button>
				<button type="button" class=" layui-btn layui-btn-primary layui-btn-small " data-bind="click:function(){$root.cancel();}">取消</button>
		
		</div>

	</form>
	
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">子方案</h4>
				</div>
				<div class="modal-body">
<!-- 					<div class="layui-form" id="search" lay-filter="search">
						<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">方案名称:</label>
								<div class="layui-input-inline">
									<select class="layui-input" name="schemeId" lay-verify="required" 
									data-bind="options:mainSchemes,optionsCaption:'--请选择--',
												optionsText:'schemeName',optionsValue:'id'">
									</select>
								</div>
								
								<label class="layui-form-label">子方案批号:</label>
								<div class="layui-input-inline">
									<input type="text" name="schemeBatch" lay-verify="required"
										autocomplete="off" class="layui-input">
								</div>
							</div>


							<div class="layui-inline">
								<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload"
									data-bind="click:function(){$root.queryPageList();}">查询</button>
							</div>
						</div>
					</div> -->
					
					<table class="layui-table">
						<thead>
							<tr>
								<td data-bind="visible:schemeDetailList().length!=0"></td>
								<td>方案名称</td>
								<td>子方案ID</td>
								<td>批号</td>
								<td>所属库点</td>
								<td>仓房编号</td>
								<td>粮食品种</td>
								<td>产地</td>
								<td>数量</td>
							</tr>
						</thead>
						<tbody data-bind="foreach:schemeDetailList">
							<tr>
								<td><input type="radio" name="radio"
									data-bind="click:function(){$root.choose($data);return true;}" /></td>
								<td data-bind="text:mainSchemeName"></td>
								<td data-bind="text:dId"></td>
								<td data-bind="text:schemeBatch"></td>
								<td data-bind="text:libraryId"></td>
								<td data-bind="text:branNumber"></td>
								<td data-bind="text:foodType"></td>
								<td data-bind="text:ogirin"></td>
								<td data-bind="text:rotateNumber"></td>
							</tr>
						</tbody>
					</table>
					<div class="layui-row text-center"
						data-bind="visible:schemeDetailList().length==0">未找到相关子方案数据</div>
					<div class="layui-row">
						<div id="pagination" class=""></div>
					</div>
				</div>
				<div class="modal-footer">

					<button type="button"
						class=" layui-btn layui-btn-primary layui-btn-small"
						data-bind="click:function(){$root.confirmChoose();}">确定</button>
					<button type="button"
						class=" layui-btn layui-btn-primary layui-btn-small"
						data-bind="click:function(){$root.hideModal();}">取消</button>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
	
</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatebid/add.js"></script>
<script>
    if ("${model.groupID}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
	var isedit = ${isEdit};
	var id = '${model.id}'||0;
	var bidType='${model.bidType}';
	var detailList=${cf:toJSON(detailList)};
	
	if (isedit) {

		$('.layui-form-item [name="bidType"]').val("${model.bidType}");
		$('.layui-form-item [name="foodType"]').val("${model.foodType}");
		
	}
	var vm = new Add(isedit,id,bidType,detailList);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
	UploadFile();
</script>
<%@include file="../common/AdminFooter.jsp"%>