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
#template-tr {
	display: none;
}
#detail-tr {
	display: none;
}
#detail-tr2 {
	display: none;
}

</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>竞标管理</li>
		<li class="active">
		<c:if test="${!isEdit}">
			保证金退还新增
		</c:if>
		<c:if test="${isEdit}">
			保证金退还编辑
		</c:if>
		</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px" id="rotatearrive_add">

	<div class="layui-row title">
		<h5>保证金退还信息</h5>
	</div>
	
	<form class="layui-form"  lay-filter="form1" id="form1">
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" disabled="disabled" name="operator" lay-verify="required" readonly
						   autocomplete="off" value="${serial}" id="serial">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>经办人:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" disabled="disabled" name="operator" lay-verify="required" readonly
						autocomplete="off" value="${modelMain.operator}" id="operator">
				</div>
			</div>
				</div>
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>经办部门:</label>
				<div class="layui-input-inline">
					<%-- <input class="layui-input from-control" name="department" lay-verify="required" <c:if test="${isEdit}">lay-verify="required" readonly autocomplete="off"</c:if>
						autocomplete="off" value="${model.department}"> --%>
					<input class="layui-input from-control" name="department" lay-verify="required" readonly autocomplete="off"
						autocomplete="off" value="${modelMain.department}" id="department">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>经办时间:</label>
				<div class="layui-input-inline">
					<input type="text" name="handleTime" lay-verify="required" id="handleTime"
						autocomplete="off" placeholder="请输入经办时间" class="layui-input"
						value="<fmt:formatDate pattern="yyyy-MM-dd" value="${modelMain.handleTime}" />">
				</div>
			</div>

		</div>

		<%--<div class="layui-form-item">--%>

			<%--<div class="layui-inline layui-col-md5">--%>
				<%--<label class="layui-form-label" style="text-align:right"><span class="red">*</span>标的号:</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input type="text" name="bidSerial" lay-verify="required" readonly--%>
						<%--autocomplete="off" placeholder="--点击选择--"--%>
						<%--class="layui-input form-control" value="${model.bidSerial}">--%>
				<%--</div>--%>
				<%--<div class="layui-form-mid layui-word-aux">--%>
					<%--<a type="button" class="btn btn-link" id="chooseBtn"--%>
						 <%--data-target="#myModal" data-bind="click:function(){$root.showModal();}">选择</a>--%>
				<%--</div>--%>
			<%--</div>--%>
			<%----%>
			<%--<div class="layui-inline layui-col-md5">--%>
				<%--<label class="layui-form-label" style="text-align:right"><span class="red">*</span>单位:</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input type="text" name="company" lay-verify="required" readonly--%>
						<%--autocomplete="off"--%>
						<%--class="layui-input form-control" value="${model.company}">--%>
				<%--</div>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%----%>
		<%--<div class="layui-form-item">--%>
			<%--<div class="layui-inline layui-col-md5">--%>
				<%--<label class="layui-form-label" style="text-align:right"><span class="red">*</span>交易方式:</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input type="text" name="dealType" lay-verify="required" readonly--%>
						<%--autocomplete="off"--%>
						<%--class="layui-input form-control" value="${model.dealType}">--%>
				<%--</div>--%>
			<%--</div>--%>
			<%--<div class="layui-inline layui-col-md5">--%>
				<%--<label class="layui-form-label" style="text-align:right">交易时间:</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input class="layui-input form-control" name="dealDate" autocomplete="off" readonly--%>
					<%--lay-filter="required"	value='<fmt:formatDate pattern="yyyy-MM-dd" value="${model.dealDate}" />'>--%>
				<%--</div>--%>
			<%--</div>--%>

		<%--</div>--%>
		<%----%>
		<%--<div class="layui-form-item">--%>
			<%--<div class="layui-inline layui-col-md5">--%>
				<%--<label class="layui-form-label" style="text-align:right"><span class="red">*</span>数量:</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input class="layui-input form-control" name="dealNumber" autocomplete="off" readonly--%>
					<%--lay-filter="required"	value="${model.dealNumber}">--%>
				<%--</div>--%>
			<%--</div>--%>
			<%--<div class="layui-inline layui-col-md5">--%>
				<%--<label class="layui-form-label" style="text-align:right"><span class="red">*</span>占用保证金(元):</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input class="layui-input form-control" name="dealAmount" autocomplete="off" readonly--%>
					<%--lay-filter="required" value="${model.dealAmount}">--%>
				<%--</div>--%>
			<%--</div>--%>
		<%--</div>--%>

		<%--<div class="layui-form-item">--%>
			<%--<div class="layui-inline layui-col-md5">--%>
				<%--<label class="layui-form-label" style="text-align:right"><span class="red">*</span>保证金退还金额(元):</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input class="layui-input" name="refundAmount" autocomplete="off" lay-filter="required|" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"--%>
						<%--value="${model.refundAmount}" maxlength="15">--%>
				<%--</div>--%>
			<%--</div>--%>
			<%--<div class="layui-inline layui-col-md5">--%>
				<%--<label class="layui-form-label" style="text-align:right">--%>
					<%--<span class="red">*</span>未退还保证金(元):--%>
				<%--</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input class="layui-input form-control" name="surplusBail" autocomplete="off" readonly--%>
						   <%--lay-filter="required" type="" maxlength="15" value="${model.surplusBail}">--%>
				<%--</div>--%>
			<%--</div>--%>
		<%--</div>--%>

		<%--<div class="layui-form-item">--%>
			<%--<div class="layui-inline layui-col-md5">--%>
				<%--<label class="layui-form-label" style="text-align:right">备注:</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<textarea placeholder="最多200字符" class="layui-textarea"--%>
							  <%--name="remark" maxlength="200">${model.remark}</textarea>--%>
				<%--</div>--%>
			<%--</div>--%>
		<%--</div>--%>
		<button class=" layui-btn layui-btn-primary layui-btn-small" id="chooseBtn" data-target="#myModal" data-bind="click:function(){$root.showModal();}">
			<i class="layui-icon">&#xe608;</i> 新增
		</button>
        <div id="hiddenId">
        <input type="text" style="display: none" name="ids" value="${concluteId}"/>
        </div>
        <table class="layui-table">
            <thead>
            <tr>
                <td align="center">单位</td>
                <td align="center">交易时间</td>
                <td align="center">销售或采购</td>
                <td align="center">轮换类型</td>
                <td align="center">标的</td>
                <td align="center">数量(吨)</td>
				<td align="center">占用保证金总额(元)</td>
                <td align="center">未退还保证金总额(元)</td>
				<td align="center">本次保证金退还总额(元)</td>
                <td align="center">备注</td>
                <td align="center">操作</td>
            </tr>
            </thead>
            <tbody id="data-result">
            <tr id="template-tr">
				<%--<td style="display: none" name="id"></td>--%>
                <td align="left" name="clientName">
                </td>
                <td align="center" name="dealDate">
                    <%--<input style="width: 80%" class="inputArea" type="number" oninput="if(value.length>15)value=value.slice(0,15)"/>--%>
                </td>
                <td name="type" align="center">
                    <%--<input style="width: 80%" class="inputArea" maxlength="10"/>--%>
                </td>
                    <td name="dealType" align="center"></td>
                <td name="bidSerial" align="center">
                </td>
                <td name="number"align="center">
                </td>
					<td name="dealAmount"align="center"></td>
					<td name="surplusBail"align="center"></td>
					<td name="refundAmount"align="center">
						<input type="text" style="width: 80%" class="inputArea" name="refund" value="" onfocus="showMultiple(this)"
						onchange="judgeAmount(this)"/>
					</td>
                <td align="left" name="remark">
				<input style="width: 100%" class="inputArea" type="textArea" name="remark"/>
			</td>
                <td name="mark">
                    <button type="button" class="buttonArea remove-detail">删除</button>
					<input type="text" style="display: none" name="id" value="">
                </td>
					<td name="group" style="display: none"></td>
            </tr>
            <c:forEach items="${model }" var="item">
                <tr class="data-tr">
                    <td name="clientName" align="left">${item.company}</td>
                    <td name="dealDate" align="center">${item.dealDates}</td>
                    <td name="type" align="center">${item.type}</td>
                    <td name="dealType" align="center">${item.dealType}</td>
                    <td name="bidSerial" align="center">
                            ${item.bidSerial }
                    </td>
                    <td name="number" align="center">${item.dealNumber}</td>
                    <td name="dealAmount" align="center" >${item.dealAmount}</td>
                    <td name="surplusBail" align="center">
                            ${item.surplusBail}
                    </td>
                    <td name="refundAmount" align="center">
						<input type="text" style="width: 80%" class="inputArea" name="refund" value="${item.refundAmount}" onfocus="showMultiple(this)"
							   onchange="judgeAmount(this)"/>
                    </td>
                    <td name="remark">
						<input style="width:100%" class="inputArea" type="textArea" name="remark" value="${item.remark}"/>
                    </td>
                    <td name="mark" >
					<button type="button" class="buttonArea remove-detail">删除</button>
					<input type="text" style="display: none" name="id" value="${item.concluteDetailId}">
                    </td>
					<td name="group" style="display: none">${item.groupId}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

		<hr class="layui-bg-green">

		<div class="layui-form-item text-center">
			<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="saves" >保存</button>
			<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.cancel();}">取消</button>
		</div>
    </form>
<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
<!-- 				<div class="modal-header"> -->
<!-- 					<h4>选择对应的成交明细</h4> -->
<!-- 				</div> -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<div class="layui-form" id="search2" lay-filter="search2">
						<div class="layui-form-item">
<!-- 							<div class="layui-inline">
								<label class="layui-form-label">成交子明细号:</label>
								<div class="layui-input-inline">
									<input class="layui-input" name="dealSerial"
										autocomplete="off">
								</div>
							</div> -->
							
							<div class="layui-inline">
								<label class="layui-form-label">标的号:</label>
								<div class="layui-input-inline">
									<input class="layui-input" name="bidSerial"
										autocomplete="off">
								</div>
							</div>

							<div class="layui-inline">
								<label class="layui-form-label">成交单位:</label> 
								<div class="layui-input-inline mySelect">
									<select name="dealUnit" lay-search lay-filter="dealId">
										<option value="">--请选择--</option>
										<c:forEach items="${customers}" var="custom">
											<option value="${custom.clientName}">${custom.clientName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">轮换类型:</label>
								<div class="layui-input-inline">
									<select name="inviteType">
										<option value="">全部</option>
										<option value="竞价销售">竞价销售</option>
										<option value="协议销售">协议销售</option>
										<option value="内部招标">内部招标</option>
										<option value="招标采购">招标采购</option>
										<%--<option value="订单采购">订单采购</option>--%>
										<%--<option value="进口粮采购">进口粮采购</option>--%>
										<%--<option value="其他">其他</option>--%>
									</select>
								</div>
							</div>
							
							<div class="layui-inline">
								<label class="layui-form-label">竞价时间:</label>
								<div class="layui-input-inline">
									<input class="layui-input" name="dealDate"
										autocomplete="off">
								</div>
							</div>

							<div class="layui-inline">
								<button class=" layui-btn layui-btn-primary layui-btn-small"
									data-type="reload"
									data-bind="click:function(){$root.queryPageList(true);}">查询</button>
							</div>
							<div class="layui-inline">
								<button class=" layui-btn layui-btn-primary layui-btn-small"
										data-type="reload"
										data-bind="click:function(){$root.clear();}">清空</button>
							</div>
						</div>
					</div>

					<table class="layui-table">
						<thead>
							<tr>
								<td style="width:80px" data-bind="visible:dealList().length!=0"></td>
								<td align="center">招标名称</td>
								<td align="center">标的号</td>
								<td align="center">轮换类型</td>
								<td align="center">数量(吨)</td>
								<td align="center">占用保证金(元)</td>
								<td align="center">剩余占用保证金(元)</td>
								<td align="center">成交单位</td>
								<td align="center">竞价时间</td>
							</tr>
						</thead>
						<tbody data-bind="foreach:dealList" id="schemeDetail-data-list">
							<tr>
								<td style="width:80px">
									<input type="checkbox" name="check" data-bind="click:function(){$root.choose($data);return true;}" />
									<input type="hidden" data-bind="value:id" name="id"/>
								</td>
								<td data-bind="text:inviteName" align="center" name="inviteName"></td>
								<td style="width:100px;" data-bind="text:bidSerial"  align="center" name="bidSerial"></td>
								<td data-bind="text:inviteType" align="center" name="type"></td>
								<td data-bind="text:quantity" align="center" name="number"></td>
								<td data-bind="text:bail" align="center" name="dealAmount"></td>
								<td data-bind="text:surplusBail" align="center" name="surplusBail"></td>
								<td data-bind="text:dealUnit" align="center" name="clientName"></td>
								<td data-bind="text:dealDate" align="center" name="dealDate"></td>
							</tr>
						</tbody>
					</table>
					<div class="layui-row text-center"
						data-bind="visible:dealList().length==0">无数据</div>
					<div class="layui-row">
						<div id="pagination" class=""></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button"
						class=" layui-btn layui-btn-primary layui-btn-small" id="add-tolist"
						>确定</button>
                    <%--data-bind="click:function(){$root.confirm($element);}"--%>
					<button type="button"
						class=" layui-btn layui-btn-primary layui-btn-small"
						data-dismiss="modal">取消</button>

				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
	<div class="container-box2 clearfix" style="padding: 10px;display: none">
	<table class="layui-table">
			<thead>
			<tr>
				<td>招标名称</td>
				<td>标的号</td>
				<td>轮换类型</td>
				<td>数量(吨)</td>
				<td>占用保证金(元)</td>
				<td>剩余占用保证金(元)</td>
				<td>保证金退还金额(元)</td>
				<td>成交单位</td>
				<td>竞价时间</td>
			</tr>
			</thead>
			<tbody id="amountDetail">
			<tr id="detail-tr">
                <td name="detailId" style="display: none"><input type="text" name="detailId" value=""/></td>
				<td name="id" style="display: none"><input type="text" name="id" value=""/></td>
				<td name="inviteName"></td>
				<td name="bidSerial"></td>
				<td name="inviteType">
				<td name="quantity"></td>
				<td name="bail"></td>
				<td name='surplusBail'></td>
				<td name="refund"><input type="text" name="refund" value="" onchange="judgeAmount(this)"/></td>>
				<td name="clientName"></td>
				<td name="dealDate"></td>
				<%--<td name="type" style="display: none"></td>--%>
				<%--<td name="group" style="display: none"></td>--%>
			</tr>
			<c:forEach items="${model2 }" var="item">
				<tr class="data-tr">
                    <td name="detailId" style="display: none"><input type="text" name="detailId" value="${item.id}"/></td>
					<td name="id" style="display: none"><input type="text" name="id" value="${item.concluteDetailId}"/></td>
					<td name="inviteName" align="left">${item.inviteName}</td>
					<td name="bidSerial" align="center">${item.bidSerial}</td>
					<td name="inviteType" align="center">${item.dealType}</td>
					<td name="quantity" align="center">${item.dealNumber }</td>
					<td name="bail" align="center">${item.dealAmount}</td>
					<td name="surplusBail" align="center">${item.surplusBail}</td>
					<td name="refund" ><input type="text" name="refund" value="${item.refundAmount}" onchange="judgeAmount(this)"/></td>></td>
					<td name="clientName" >${item.company}</td>
					<td name="dealDate" align="center">${item.dealDates}</td>
				</tr>
			</c:forEach>

			</tbody>
		</table>
	</div>
	<div class="container-box3 clearfix" style="padding: 10px;display: none">
		<table class="layui-table">
			<thead>
			<tr>
				<td>招标名称</td>
				<td>标的号</td>
				<td>轮换类型</td>
				<td>数量(吨)</td>
				<td>占用保证金(元)</td>
				<td>剩余占用保证金(元)</td>
				<td>保证金退还金额(元)</td>
				<td>成交单位</td>
				<td>竞价时间</td>
			</tr>
			</thead>
			<tbody id="amountDetail2">
				<tr id="detail-tr2">
                    <td name="detailId" style="display: none"><input type="text" name="detailId" value=""/></td>
					<td name="id" style="display: none"><input type="text" name="id" value=""/></td>
					<td name="inviteName"></td>
					<td name="bidSerial"></td>
					<td name="inviteType">
					<td name="quantity"></td>
					<td name="bail"></td>
					<td name='surplusBail'></td>
					<td name="refund"><input type="text" name="refund" value="" onchange="judgeAmount(this)"/></td>>
					<td name="clientName"></td>
					<td name="dealDate"></td>
					<%--<td name="type" style="display: none"></td>--%>
					<%--<td name="group" style="display: none"></td>--%>
				</tr>
				<c:forEach items="${model2 }" var="item">
					<tr class="data-tr">
                        <td name="detailId" style="display: none"><input type="text" name="detailId" value="${item.id}"/></td>
						<td name="id" style="display: none"><input type="text" name="id" value="${item.concluteDetailId}"/></td>
						<td name="inviteName" align="left">${item.inviteName}</td>
						<td name="bidSerial" align="center">${item.bidSerial}</td>
						<td name="inviteType" align="center">${item.dealType}</td>
						<td name="quantity" align="center">${item.dealNumber }</td>
						<td name="bail" align="center">${item.dealAmount}</td>
						<td name="surplusBail" align="center">${item.surplusBail}</td>
						<td name="refund" ><input type="text" name="refund" value="${item.refundAmount}" onchange="judgeAmount(this)"/></td>></td>
						<td name="clientName" >${item.company}</td>
						<td name="dealDate" align="center">${item.dealDates}</td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
		<div class="modal-footer">
			<button type="button"
					class=" layui-btn layui-btn-primary layui-btn-middle" id="saveAmount"
			>确定</button>
            <button type="button"
                    class=" layui-btn layui-btn-primary layui-btn-middle" id="cancel"
            >取消</button>

		</div>
</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>
<script src="${ctx}/js/app/rotaterefund/add.js"></script>
<script>
	var isedit=${isEdit};
	var id = '${modelMain.id}'||0;

	var vm = new Add(isedit,id);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
    // $('.mySelect').find('input').removeAttr("readonly");


    function judgeType(type){
        var b=false;
        var type1=['招标采购','订单采购','进口粮采购'];
        for(var i=0;i<type1.length;i++){
            if(type1[i]==type){
                b=true;break;
            }
        }
        return b;
    }
    var i=1;
    if($("#data-result").children().length>1){
        i=parseInt($("#data-result").children("tr:last-child").find("td[name='group']")[0].innerText)+1;
	}
    //var j=1;
    $("#add-tolist").click(function () {
        var arr=[];
        var t;
        $("#schemeDetail-data-list").find("input[name='check']").each(function () {
            if ($(this).prop("checked")) {
                var trdata = $(this).parent().parent();
                var data={"inviteName":$(trdata).find("td[name='inviteName']").html(),"clientName":$(trdata).find("td[name='clientName']").html(),
					"dealDate":$(trdata).find("td[name='dealDate']").html(),
				"type":$(trdata).find("td[name='type']").html(),"bidSerial":$(trdata).find("td[name='bidSerial']").html(),
				"number":$(trdata).find("td[name='number']").html(),"dealAmount":$(trdata).find("td[name='dealAmount']").html(),
					"surplusBail":$(trdata).find("td[name='surplusBail']").html(),
				"id":$(trdata).find("input[name='id']")[0].value};
                arr.push(data);
                if(t!=null && t!=$(trdata).find("td[name='type']").html()){
					t=1;
                    return;
				}
				t=$(trdata).find("td[name='type']").html();
            }
        });
        debugger
        if(t==1){
            layer.msg("只能选择相同的轮换类型，请重新选择")
            return;
		}
		if($("#amountDetail").children().length>1 && t!=$($("#amountDetail").find("tr")[1]).find("td[name='inviteType']").html()){
            layer.msg("只能选择相同的轮换类型，请重新选择")
            return;
		}


        let dataMap = new Map();

        arr.forEach( function (item) {
            debugger
            var type=judgeType(item.type)?'购':'销';
            var template = $("#detail-tr").clone(true);
            $(template).find("td[name='id']").find("input[name='id']")[0].value=item.id;
            $(template).find("td[name='inviteName']").html(item.inviteName);
            $(template).find("td[name='bidSerial']").html(item.bidSerial);
            $(template).find("td[name='inviteType']").html(item.type);
            $(template).find("td[name='quantity']").html(item.number);
            $(template).find("td[name='bail']").html(item.dealAmount);
            $(template).find("td[name='surplusBail']").html(item.surplusBail);
            $(template).find("td[name='refund']").find("input[name='refund']")[0].value=item.surplusBail;
            $(template).find("td[name='clientName']").html(item.clientName);
            $(template).find("td[name='dealDate']").html(item.dealDate);
            $(template).attr("style","display:table-row");
            $("#amountDetail").append($(template));



            if(!dataMap.has(item.clientName+item.dealDate+type)){
            dataMap.set(item.clientName+item.dealDate+type,{
                clientName:item.clientName,
				dealDate:item.dealDate,
				type:type,
                dealType:item.type,
				bidSerial:[],
				number:item.number,
				dealAmount:item.dealAmount,
                surplusBail:item.surplusBail,
				ids:[],
				group:i
            })
				i++;
            }else{
                dataMap.get(item.clientName+item.dealDate+type).number=toDecimal3NoZero(parseFloat(dataMap.get(item.clientName+item.dealDate+type).number)+parseFloat(item.number));
                dataMap.get(item.clientName+item.dealDate+type).dealAmount=toDecimal2NoZero(parseFloat(dataMap.get(item.clientName+item.dealDate+type).dealAmount)+parseFloat(item.dealAmount));
                dataMap.get(item.clientName+item.dealDate+type).surplusBail=toDecimal2NoZero(parseFloat(dataMap.get(item.clientName+item.dealDate+type).surplusBail)+parseFloat(item.surplusBail));

            }
            dataMap.get(item.clientName+item.dealDate+type).bidSerial.push(
            item.bidSerial
			)
            dataMap.get(item.clientName+item.dealDate+type).ids.push(
                item.id
            )

            $("#hiddenId").find("input[name='ids']")[0].value=$("#hiddenId").find("input[name='ids']")[0].value+item.id+",";

    })

		console.log(dataMap);
        if($("#data-result").children().length+dataMap.size>6){
            layer.msg("一张联系单上最多有5条明细，请重新选择");
            return;
		}
		debugger
        dataMap.forEach(function (value, key, map) {
            var template = $("#template-tr").clone(true);
            $(template).find("td[name='clientName']").html(value.clientName);
            $(template).find("td[name='dealDate']").html(value.dealDate);
            $(template).find("td[name='type']").html(value.type);
            $(template).find("td[name='dealType']").html(value.dealType);
            $(template).find("td[name='bidSerial']").html(value.bidSerial.toString());
            $(template).find("td[name='number']").html(value.number);
            $(template).find("td[name='dealAmount']").html(value.dealAmount);
            $(template).find("td[name='surplusBail']").html(value.surplusBail);
            $(template).find("td[name='refundAmount']").find("input[name='refund']")[0].value=value.surplusBail;
            //$(template).find("td[name='id']").html(value.ids);
            $(template).find("td[name='mark']").find("input[name='id']")[0].value=value.ids;
            $(template).find("td[name='remark']").find("input").val("");
            $(template).find("td[name='group']").html(value.group);
            //$(template).addClass("data-tr");
            $("#data-result").append($(template));
            $(template).slideToggle(500);
            // debugger
            // $("#amountDetail").find("tr").each(function () {
				// if($(this).find("td[name='clientName']")[0].innerText==value.clientName && $(this).find("td[name='type']")[0].innerText==value.type
				// && $(this).find("td[name='dealDate']")[0].innerText==value.dealDate){
				//     $(this).find("td[name='group']").html(value.group);
				// }
				// console.log($(this).find("td[name='clientName']")[0].innerText);
            // })
        })
        $("#myModal").modal('hide');

    });
    $(".remove-detail").click(function () {
        debugger
        $("#hiddenId").find("input[name='ids']")[0].value=$("#hiddenId").find("input[name='ids']")[0].value.replace($(this).parent().find("input[name='id']")[0].value+",","");
        $(this).parent().parent().hide(500, function () {
            $(this).remove();
        });
        var ids=$(this).parent().find("input[name='id']")[0].value.split(",");
        $("#amountDetail").find("tr").each(function (index,item) {
            var id=$(item).find("input[name='id']")[0].value;
           //console.log($(item).find("input[name='id']")[0].value);
            ids.forEach(function (value) {
                if(id==value){
                    $(item).remove();
				}
			})
        })
        $("#amountDetail2").find("tr").each(function (index,item) {
            var id=$(item).find("input[name='id']")[0].value;
            ids.forEach(function (value) {
                if($(item).find("input[name='id']")[0].value==value){
                    $(item).remove();
                }
            })
        })


    });
    function toDecimal2NoZero(x) {//保留两位小数，同时不补0
        var f = Math.round(x * 100) / 100;
        var s = f.toString();
        return s;
    }
    function toDecimal3NoZero(x) {//保留三位小数，同时不补0
        var f = Math.round(x * 1000) / 1000;
        var s = f.toString();
        return s;
    }


</script>

<%@include file="../common/AdminFooter.jsp"%>