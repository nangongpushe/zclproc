<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

${fn:trim(num)}




<style type="text/css">
	.redBole{
		color:red;
		font-weight:bold;
	}
	.green-bold{
		color: green;
		font-weight: bold;
	}
    th,td{
        width: 100px!important;
    }
</style>
<input type="hidden" id="reportId"  value="${reportId}">
<div class="content_right tab-content"  style="height: 100%;">
	<div class="text-left time" style="margin: 10px">
		<TABLE width="100%" align="center">
			<tr>
				<td colspan="10" align="center" class="title">浙江省储备粮管理有限公司省级储备粮台账汇总表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span><font color="#6495ed" id="status">【上报待审】</font> </span>	</td>
			</tr>
			<tr style="color:blue"><td colspan="4">统计汇总：浙江</td><td style='mso-number-format:"\@"' colspan="4">${reportMonth}</td><td colspan="2">单位：吨</td></tr>
		</TABLE>
	</div>
	<div class="con_box" style="width: 100%;height: 100%;">
		<div class="table_box tab-pane slide_table"  style="width: 100%;height: 100%;" id="panel-05">
			<!-- 左上角头部固定-->
			<div class="public1" style="width: 200px;height: 28px;">
				<table class="table table-bordered nav_left" style="background-color: white;">
					<tr>
						<th class="td_first text-center" style="background-color: #e7f3f7;">序号</th>
						<th class="td_first text-center" style="background-color: #e7f3f7;">单位名称</th>
					</tr>
				</table>
			</div>
			<!-- 侧列固定-->
			<div class="public" style="height: 100%;padding-bottom: 17px;">
				<table class="table table-bordered nav_left" style="word-wrap: break-word; word-break: break-all;background-color: white;" id="leftTable">
					<tr>
						<th class="td_first text-center" style="background-color: #e7f3f7;"></th>
					</tr>
					<tr class="active green-bold">
						<td class="text-center list_1 thick"></td>
						<td class="text-center list_3 thick">合计</td>
					</tr>

					<c:forEach items="${dataList}" var="data" varStatus="status">
						<tr class="text-center">
							<td class="list_1">${status.count}</td>
							<td class="list_3">${data.key}</td>
						</tr>

					</c:forEach>

				</table>
			</div>
			<!-- 头部固定-->
			<div class="public2" style="border-left: 297px solid white">
				<table class="table table-bordered header" style="word-wrap: break-word; word-break: break-all;border-bottom: 1px solid #7e9bb0">
					<thead>
					<tr>
						<c:forEach items='${fields["粮食"]}' var="field">
							<th rowspan="1" class="text-center">${field}</th>
						</c:forEach>

						<c:forEach items='${fields["早籼"]}' var="field">
							<th rowspan="1" class="text-center">${field}</th>
						</c:forEach>

						<c:forEach items='${fields["粳稻谷"]}' var="field">
							<th rowspan="1" class="text-center">${field}</th>
						</c:forEach>

						<c:forEach items='${fields["稻谷"]}' var="field">
							<th rowspan="1" class="text-center">${field}</th>
						</c:forEach>

						<c:forEach items='${fields["小麦"]}' var="field">
							<th rowspan="1" class="text-center">${field}</th>
						</c:forEach>

						<c:forEach items='${fields["玉米"]}' var="field">
							<th rowspan="1" class="text-center">${field}</th>
						</c:forEach>

						<c:forEach items='${fields["油类"]}' var="field">
							<th rowspan="1" class="text-center">${field}</th>
						</c:forEach>

					</tr>

					</thead>
				</table>
			</div>
			<!-- 表格-->
			<div class="table_tab" style="border-left: 297px solid white;max-height: 100%;">
				<table class="table table-bordered slide_table" style="word-wrap: break-word; word-break: break-all;">
					<!-- 表格内容 start -->
					<tbody id="sumTbody">
					<tr>
						<c:forEach items='${fields["粮食"]}' var="field">
							<th class="text-center"></th>
						</c:forEach>

						<c:forEach items='${fields["早籼"] }' var="field" >
							<td class="text-center" ></td>
						</c:forEach>

						<c:forEach items='${fields["粳稻谷"] }' var="field" >
							<td class="text-center" ></td>
						</c:forEach>

						<c:forEach items='${fields["稻谷"] }' var="field" >
							<td class="text-center" ></td>
						</c:forEach>

						<c:forEach items='${fields["小麦"] }' var="field">
							<td class="text-center" ></td>
						</c:forEach>

						<c:forEach items='${fields["玉米"] }' var="field">
							<td class="text-center" ></td>
						</c:forEach>

						<c:forEach items='${fields["油类"] }' var="field">
							<td class="text-center" ></td>
						</c:forEach>
					</tr>
					<tr>
						<c:forEach items='${fields["粮食"] }' var="field">
							<td class="text-center green-bold">
							<c:if test="${sumData[field]>0}">
								<fmt:formatNumber value="${sumData[field]}" pattern=".###"/></td>
							</c:if>
						</c:forEach>

						<c:forEach items='${fields["早籼"] }' var="field" >
							<td class="text-center green-bold">
							<c:if test="${sumData[field]>0}">
								<fmt:formatNumber value="${sumData[field]}" pattern=".###"/></td>
							</c:if>
							</td>
						</c:forEach>

						<c:forEach items='${fields["粳稻谷"] }' var="field" >
							<td class="text-center green-bold">
							<c:if test="${sumData[field]>0}">
								<fmt:formatNumber value="${sumData[field]}" pattern=".###"/></td>
							</c:if>
							</td>
						</c:forEach>

						<c:forEach items='${fields["稻谷"] }' var="field" >
							<td class="text-center green-bold">
							<c:if test="${sumData[field]>0}">
								<fmt:formatNumber value="${sumData[field]}" pattern=".###"/></td>
							</c:if>
						</c:forEach>

						<c:forEach items='${fields["小麦"] }' var="field">
							<td class="text-center green-bold">
							<c:if test="${sumData[field]>0}">
								<fmt:formatNumber value="${sumData[field]}" pattern=".###"/></td>
							</c:if>
						</c:forEach>

						<c:forEach items='${fields["玉米"] }' var="field">
							<td class="text-center green-bold">
							<c:if test="${sumData[field]>0}">
								<fmt:formatNumber value="${sumData[field]}" pattern=".###"/></td>
							</c:if>
						</c:forEach>

						<c:forEach items='${fields["油类"] }' var="field">
							<td class="text-center green-bold">
							<c:if test="${sumData[field]>0}">
								<fmt:formatNumber value="${sumData[field]}" pattern=".###"/></td>
							</c:if>
						</c:forEach>
					</tr>

					<c:forEach items="${dataList}" var="data" varStatus="status">
						<tr class="text-center active">

							<c:forEach items='${fields["粮食"] }' var="field" varStatus="stat">
								<td class="text-center green-bold">
								<c:if test="${data.value[field] !=0}">
									<fmt:formatNumber value="${data.value[field]}" pattern=".###"/></td>
								</c:if>
							</c:forEach>

							<c:forEach items='${fields["早籼"] }' var="field" varStatus="stat">
								<td class="text-center"  <c:if test="${stat.last}" >
								style="color:green;font-weight:bold"  </c:if> >
								<c:if test="${data.value[field] !=0}">
									<fmt:formatNumber value="${data.value[field]}" pattern=".###"/></td>
								</c:if>

							</c:forEach>

							<c:forEach items='${fields["粳稻谷"] }' var="field" varStatus="stat">
								<td class="text-center"  <c:if test="${stat.last}" >
								style="color:green;font-weight:bold"  </c:if> >
								<c:if test="${data.value[field] !=0}">
									<fmt:formatNumber value="${data.value[field]}" pattern=".###"/></td>
								</c:if>

							</c:forEach>

							<c:forEach items='${fields["稻谷"] }' var="field" varStatus="stat">
								<td class="text-center"  <c:if test="${stat.last}" >
									style="color:green;font-weight:bold"  </c:if> >
									<c:if test="${data.value[field] !=0}">
										<fmt:formatNumber value="${data.value[field]}" pattern=".###"/></td>
									</c:if>

							</c:forEach>
							<c:forEach items='${fields["小麦"] }' var="field" varStatus="stat">
								<td class="text-center"  <c:if test="${stat.last}" >
									style="color:green;font-weight:bold"  </c:if> >
								<c:if test="${data.value[field] !=0}">
									<fmt:formatNumber value="${data.value[field]}" pattern=".###"/></td>
								</c:if>
							</c:forEach>

							<c:forEach items='${fields["玉米"] }' var="field" varStatus="stat">
								<td class="text-center"  <c:if test="${stat.last}" >
								style="color:green;font-weight:bold"  </c:if> >
								<c:if test="${data.value[field] !=0}">
									<fmt:formatNumber value="${data.value[field]}" pattern=".###"/></td>
								</c:if>
							</c:forEach>

							<c:forEach items='${fields["油类"] }' var="field" varStatus="stat">
								<td class="text-center"  <c:if test="${stat.last}" >
									style="color:green;font-weight:bold"  </c:if> >
								<c:if test="${data.value[field] !=0}">
									<fmt:formatNumber value="${data.value[field]}" pattern=".###"/></td>
								</c:if>
							</c:forEach>
						</tr>
					</c:forEach>
					</tbody>
					<!-- 表格内容 end -->
				</table>
			</div>
		</div>
	</div>
</div>
<script language="javascript" type="text/javascript">
    var status = '${status}'; //报表状态
	$("#status").text(status);
    var monthStatus = '${reportMain.reportStatus}'; //月报状态
    $("#reportId").val('${reportId}');
    var exportUrl='${ctx}/reportSwtz/exportSwtzSum.shtml';
    var dataList = '${dataList}';

    // function sumToFirst() {
    //     $('#sumTbody input[sumCol]').each(function () {
    //         var sumCol = $(this).attr('sumCol');
    //         console.log(sumCol);
    //         var sumTotal = 0;
    //         $('#sumTbody input[name='+sumCol+']').not($(this)).each(function () {
    //             sumTotal = accAdd(sumTotal,$(this).val())
    //         });
    //         $(this).val(sumTotal);
    //     });
    // }
    //
    // $(function () {
    //     if(dataList)
    //         sumToFirst()
    // });

</script>