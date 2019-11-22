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
#freightDetails td>select{
	display:inline-block;
}
#freightDetails .layui-form-select{
	display: none;
}
 #myTable1 + .layui-form .layui-table-body td[data-field="dealSerial"]{
	 text-align: left;
 }
#myTable1 + .layui-form .layui-table-body td[data-field="inviteType"]{
	text-align: left;
}
#myTable1 + .layui-form .layui-table-body td[data-field="grainType"]{
	text-align: left;
}
#myTable1 + .layui-form .layui-table-body td[data-field="quantity"]{
	text-align: right;
}
#myTable1 + .layui-form .layui-table-body td[data-field="dealUnit"]{
	text-align: left;
}
#myTable1 + .layui-form .layui-table-body td[data-field="dealDate"]{
	text-align: center;
}







</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>运费管理</li>
		<c:if test="${!isEdit }">
			<li class="active">运费方案新增</li>
		</c:if>
		<c:if test="${isEdit }">
			<li class="active">运费方案编辑</li>
		</c:if>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px"
	id="rotateinvite_add">

	<div class="layui-row title">
		<h5>运费方案信息</h5>
	</div>

	<form class="layui-form" lay-filter="search">

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>运费方案名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="freightName" lay-verify="required|textMaxLength"
						autocomplete="off" placeholder="请输入运费方案名称"
						value="${model.freightName}">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>招标单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="inviteUnit" lay-verify="required|textMaxLength"
						autocomplete="off" placeholder="请输入招标单位"
						value="${model.inviteUnit}">
					<%--<select name="inviteUnit" class="layui-select" lay-verify="required">--%>
						<%--<option value=""></option>--%>
						<%--<c:forEach items="${clientNameList}" var="clientName">--%>
							<%--<option value="${clientName}" <c:if test="${model.inviteUnit==clientName}">selected</c:if> >${clientName}</option>--%>
						<%--</c:forEach>--%>
					<%--</select>--%>
				</div>
			</div>
		</div>

		<div class="layui-form-item layui-form-text">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>招标开始时间:</label>
				<div class="layui-input-inline">
					<input type="text" name="inviteTime" lay-verify="required" id="inviteTime"
						autocomplete="off" 
						class="layui-input form-control" value='<fmt:formatDate value="${model.inviteTime}" pattern="yyyy-MM-dd"/>'>
				</div>
			</div>
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>招标截止时间:</label>
				<div class="layui-input-inline">
					<input type="text" name="inviteEndTime" lay-verify="required" id="inviteEndTime"
						   autocomplete="off"
						   class="layui-input form-control" value='<fmt:formatDate value="${model.inviteEndTime}" pattern="yyyy-MM-dd"/>'>
				</div>
			</div>
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">方案文档:</label>
				<div class="layui-input-inline">

					<c:choose>
					<c:when test="${model.groupId!=null and model.groupId!=''}">
						<button type="button"  class=" layui-btn layui-btn-primary layui-btn-small" id="uploadFile" name="file">
						${myFile.fileName}
						</button>
						<div id="afileName" style="display:inline-block;font-size:14px;" >
							<a href="${ctx }/sysFile/download.shtml?fileId=${model.groupId}" style="margin:0 10px;">${myFile.fileName}</a>
						</div>
						<div style="display:inline-block;font-size:20px;" id="openExce">
							<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
								预览
							</a>
							<a href="javascript:openAnnex('${model.groupId}')" id="openFile" style="display: none">
								预览
							</a>
						</div>
					</c:when>
					<c:otherwise>
						<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="uploadFile" name="file">
						<i class="layui-icon"></i>上传
						</button>
					</c:otherwise>
					</c:choose>
					<button type="button"<c:if test="${empty myFile.fileName}"> style="display: none" </c:if> class=" layui-btn layui-btn-primary layui-btn-small" id="deleteFile" data-bind="click:function(){$root.deleteFile();}">
						删除
					</button>
				</div>
				<div class="layui-input-inline">
					<input type="text" name="groupId" readonly style="display:none;" id="fileId"
						autocomplete="off" class="layui-input form-control" value="${model.groupId}">
				</div>
			</div>
		</div>


	<div class="layui-row title">
		<h5>运费方案明细</h5>
	</div>
	
	<button type="button" class="layui-btn layui-btn-primary layui-btn-small"
			 data-bind="click:function(){$root.showModal();}">
		<i class="layui-icon">&#xe608;</i> 新增
	</button>
		<table class="layui-table" id="freightDetails">
			<thead>
				<tr>
					<td align="center">成交子明细号</td>
					<td align="center">轮换方式</td>
					<td align="center">标段</td>
					<td align="center">运输方式</td>
					<td align="center">发货地址</td>
					<td align="center">收货地址</td>
					<td align="center">距离（公里）</td>
					<td align="center">计划数量（吨）</td>
					<td align="center">附件</td>
					<td align="center">备注</td>
					<td align="center">操作</td>
				</tr>
			</thead>
			<tbody data-bind="foreach:freightDetails">
				<tr>
					<td data-bind="text:dealSerial" align="left"></td>
					<td data-bind="text:inviteType" align="left"></td>
					<td align="left">
						<input type="text"  lay-verify="required|textMaxLength" autocomplete="off"
							class="layui-input" data-bind="value:tenders">
					</td>
					
					<td align="left">
						<select class="layui-select" data-bind="options:$root.shipTypes,optionsCaption:'--请选择--',
								value:shipType" lay-verify="required">
						</select>
					</td>
					<td align="left">
						<input type="text"  lay-verify="required|textMaxLength" autocomplete="off"
							class="layui-input" data-bind="value:deliveryAddress" maxlength="100">
					</td>
					<td align="left">
						<input type="text" lay-verify="required|textMaxLength" autocomplete="off"
							class="layui-input" data-bind="value:receiveAddress" maxlength="100" >
					</td>
					<td align="right">
						<input type="text" lay-verify="required|numberMaxLength" autocomplete="off"
							class="layui-input" data-bind="value:distance">
					</td>
					<td data-bind="text:planNumber" align="right"></td>
					<td align="left">
						<button type="button" class=" layui-btn layui-btn-primary layui-btn-small"  name="file" data-bind="attr:{id:'uploadFileForDetail'+$index(),index:$index()}">
							 <!-- ko if:groupId()!=null || groupId()!='' -->
							 	<span data-bind="text:fileName()"></span>
							 <!-- /ko -->
							 <!-- ko if:groupId()==null || groupId()=='' -->
							 	<span data-bind="text:'上传'"></span>
							 <!-- /ko -->
						</button>
						<!-- ko if:groupId()!=null && groupId()!='' -->
						<button class="layui-btn layui-btn-primary layui-btn-small" type="button" data-bind="click:function(){$root.deleteFileForDetail($index())}" >
							删除
						</button>
						<!-- /ko -->
					</td>
					<td align="left">
						<input type="text" autocomplete="off" 
							class="layui-input" data-bind="value:remark" maxlength="200">
					</td>
					<td><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.remove($index())}">删除</a></td>
				</tr>
			</tbody>
		</table>
		<div class="layui-row text-center"
			data-bind="visible:freightDetails().length==0">暂无明细数据</div>

		<div class="layui-form-item text-center">				
				<button class=" layui-btn layui-btn-primary layui-btn-small" lay-submit="" lay-filter="save" data-status="待提交">保存</button>
				<button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small " lay-filter="save" data-status="审核中">提交</button>
				<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.cancel();}">取消</button>
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
					<div class="layui-form" id="search2" lay-filter="search2">
						<div class="layui-form-item">
 							<div class="layui-inline">
								<label class="layui-form-label">成交子明细号:</label>
								<div class="layui-input-inline">
									<input class="layui-input" name="dealSerial"
										autocomplete="off">
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">轮换类型:</label>
								<div class="layui-input-inline">
									<select class="layui-form-select" name="inviteType">
										<option value="">请选择</option>
										<option>招标采购</option>
										<option>订单采购</option>
										<option>进口粮采购</option>
										<option>竞价销售</option>
										<option>协议销售</option>
										<option>内部招标</option>
										<option>其他</option>
									</select>
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">粮食品种:</label>
								<div class="layui-input-inline">
									<%--<input class="layui-input" name="grainType"
										   autocomplete="off">--%>
									<select name="grainType" id="grainType">
										<option></option>
										<c:forEach items="${grainTypes }" var="item">
											<option value="${item.value }">${item.value }</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">成交单位:</label>
								<div class="layui-input-inline">
									<input class="layui-input" name="dealUnit"
										   autocomplete="off">
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">成交时间:</label>
								<div class="layui-input-inline">
									<input class="layui-input" name="dealDate"
										   autocomplete="off">
								</div>
							</div>


							<div class="layui-inline">
								<button class=" layui-btn layui-btn-primary layui-btn-small"
									data-type="reload"
									data-bind="click:function(){$root.reloadTable1();}">查询</button>
							</div>
							<div class="layui-inline">
								<button class=" layui-btn layui-btn-primary layui-btn-small"
										data-type="reload"
										data-bind="click:function(){$root.clear1();}">清空</button>
							</div>
						</div>
					</div>
					
					<table class="layui-table" lay-filter="table1" id="myTable1"></table>
				</div>
				<div class="modal-footer">
                	
                	<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.confirm();}">确定</button>
                	<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.hideModal();}">取消</button>
            	</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>




<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatefreight/add.js"></script>

<script>
    $("#uploadFile").click(function(){
        $("#file-input").click();
        $("#afileName").attr("style","display:none;");
    });

    $("input[name='file']").change(function () {
        alert($(this).val());
		$("#uploadFile").html($(this).val());
    });

    if ("${model.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
    layui.laydate.render({
        elem:$('[name="dealDate"]')[0],
        type:"date",
        format:"yyyy-MM-dd",
    });
    layui.use(['form', 'laydate'], function() {

        var laydate = layui.laydate;
		var form = layui.form;

        //执行一个laydate实例
        laydate.render({
            elem: '#inviteTime' //指定元素
        });

        laydate.render({
            elem: 'input[name="dealDate"]', //指定元素
        	format: 'yyyy-MM-dd'
        });

        form.verify({

			numberMaxLength:function (value) {
				if(value.length > 10){
				    return "请输入10位以下数字";
				}
            },
			textMaxLength:function (value) {
				if(value.length > 30){
				    return "请输入30位以下字符或汉字";
				}
            }


		});
        form.render();

    })

	var isedit = ${isEdit};
	var id = '${model.id}'||0;
	var freightDetails=${cf:toJSON(model.freightDetails)};
	var shipTypes=${cf:toJSON(shipTypes)};
	var vm = new Add(isedit,id,freightDetails,shipTypes);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
	UploadFile();
    $("#btnDelete").click(function(){

	});
</script>
<%@include file="../common/AdminFooter.jsp"%>