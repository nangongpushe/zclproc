<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@include file="../common/AdminHeader.jsp"%>

<style>
	table#view td{
	width:100px;
	}
</style>

<div class="container clearfix" id="nprint" style="padding: 10px">
	<div style="text-align:center;font-size:1.25em;">
		<span>氮气浓度检测记录</span>
	</div>
	<!-- layui静态表格 -->
	<table class="layui-table" id="view">
		<thead>
			<tr>
				<td style="text-align: center" rowspan="2">检测时间</td>
				<td style="text-align: center" rowspan="2">检测方法和仪器</td>
				<%--<td colspan="2">检测结果</td>--%>
				<td style="text-align: center" rowspan="2">检测人</td>
			</tr>
			<%--<tr>
				<td>磷化氢(ppm)</td>
				<td>含氧量(%)</td>
			</tr>--%>
		</thead>
		<tbody>
			<tr>
				<td style="text-align: center">${gaslog.detectionTime}</td>
				<td style="text-align: left">${gaslog.detectionOperation}</td>
				<%--<td>${gaslog.phosphine}</td>
				<td>${gaslog.oxygen}</td>--%>
				<td style="text-align: left">${gaslog.detectionHumen}</td>
			</tr>
		</tbody>
	</table>
	<table class="layui-table" id="temp">
		<thead>
		<tr>
			<th style="width:10%;text-align: center">检测点</th>
			<th style="text-align: center">检测点浓度(ppm)</th>

		</tr>
		</thead>
		<!-- 表格内容start -->
		<tbody id="materialDetail" class="text-center">
		<c:forEach items="${storageGaslogTemps}" var="storageGaslogTemp" varStatus="idxStatus">

			<tr><td style="width:6%;text-align: left" ><input type="hidden" name="storageGaslogTemp[${idxStatus.index}].placeId" value="${storageGaslogTemp.placeId}"lay-verify="" style="width:0px;"/>${idxStatus.count}</td>
				<td style="text-align: left"><input readonly type="text"  name="storageGaslogTemp[${idxStatus.index}].testing" value="${storageGaslogTemp.testing}"  class="layui-input" lay-verify="required" placeholder="--请输入--"/></td>

			</tr>

		</c:forEach>


		</tbody>
		<!-- 表格内容 end -->
		<td>平均浓度</td>
		<%--<td colspan="3" style="padding: 0"></td> <input  class="layui-input" style="width: 100%; height: 100%;margin: 0;border: 0"/>--%>
		<td colspan="3"><input readonly type="text" lay-verify="required" name="testingavg" class="layui-input" placeholder="--请输入--" value="${gaslog.testingavg }" /></td>
	</table>

	<div style="padding:0 0 5px 5px;">
		<span class="layui-btn layui-btn-primary layui-btn layui-btn-mini" id="print">打印</span>
		<span class="layui-btn layui-btn-primary layui-btn layui-btn-mini" id="cancel">取消</span>
	</div>
</div>
<script>
    $("#cancel").click(function(){
        layer.confirm('确定要取消吗?', {
            icon : 0,
            title : '提示'
        }, function(index) {//是
            location.href = "${ctx}/StorageGaslog/view.shtml";
        }, function(index) {//否
            layer.close(index);
        });
    });
	$("#print").click(function(){
		$(this).hide();
      	window.print();
      	$(this).show();
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>