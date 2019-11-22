<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="../common/AdminHeader.jsp" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style type="text/css">

#data-result tr
td[name='scheme-type']{
    text-align: left;
    padding-left: 1%;
}
#data-result tr
td[name='library-id']{
    text-align: left;
    padding-left: 1%;
}
#data-result tr
td[name='bran-number']{
    text-align: left;
    padding-left: 1%;
}
#data-result tr
td[name='food-type']{
    text-align: left;
    padding-left: 1%;
}
#data-result tr
td[name='ogirin']{
    text-align: left;
    padding-left: 1%;
}
#data-result tr
td[name='planLevel']{
    text-align: left;
    padding-left: 1%;
}
#data-result tr
td[name='realContainer']{
    text-align: right;
    padding-right: 1%;
}
#data-result tr
td[name='realStorage']{
    text-align: right;
    padding-right: 1%;
}


#outSide{
	width:94%;
	margin-left:2%;
	padding:1%;
	background:#fff;
	border-top:2px solid #23b7e5;
}

.infoArea{
	width:100%;
	padding:20px 0;
	border-bottom: 2px solid #e2e2e2;
}

.title{
	color: #23b7e5;
	font-weight:bold;
}

#infoArea{
	margin-top:20px;
	margin-left:4%;
}

#infoArea span{
	padding-right:100px;
}

.requiredData{
	color:red;
}

#mainInfo{
	margin-top:20px;
	margin-left:2.5%;
}

#mainInfo>div{
	padding:10px 0;
	width:100%;
}

#mainInfo>div span{
	width:10%;
	display:inline-block;
	text-align:center;
}

.inputArea{
	width:89%;
	padding:5px;
	outline: none;
	border:1px solid #ccc;
	resize: none;
}

.buttonArea{
	padding:5px 15px;
	background:#009688;
	border:none;
	color:#fff;
	cursor:pointer;
	display:inline-block;
	margin: 6px 0;
}

#listArea{
	padding:20px 0;
	width:100%;
}

table{
	margin-top:20px;
	width:100%;
	text-align:center;
}

table thead{
	background:#f2f2f2;
}

table tr td{
	width:6%;
	font-size:0.9em;
	border:1px solid #e2e2e2;
	padding:10px 0;
}

#listArea table tr td:first-child{
	width:4%
}

#bottom-button{
	text-align:right;
	padding-right:20px;
	margin-top:20px;
}

#bottom-button>div{
	margin-right:10px;
}

#template-tr{
	display:none;
}
#float-alert1{
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:RGBA(0,0,0,0.75);
	z-index:400;
	display:none;
}

#float-alert2{
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:RGBA(0,0,0,0.75);
	z-index:400;
	display:none;
}

#table-wapper{
	display:none;
	margin:0 auto;
	margin-top:100px;
	background:#fff;
	border-top:1px solid RGB(42, 180, 168);
	padding:1%; 
	width:75%;
	height:550px;
} 

#table-wapper2{
	display:none;
	margin:0 auto;
	margin-top:50px;
	background:#fff;
	border-top:1px solid RGB(42, 180, 168);
	padding:1%; 
	width:75%;
	height:550px;
	overflow-y:auto;
} 

#table-wapper table{
	margin:0;
	border-bottom:none;
}

#table-wapper2 table{
	margin:0;
	border-bottom:none;
}

#table-wapper table td:first-child{
	width:3%;
}

#close-float-alert1,#close-float-alert2{
	position:relative;
	left:88.5%;
	font-size: 30px; 
	color:RGB(42, 180, 168);
	cursor: pointer;
}

#schemeDetail-data-list input[type=checkbox]{
	width:50%;
	outline:none;
}

#out-table{
	height:385px;
	overflow:auto;
	margin-top:20px;
}

.hide-field{
	display:none;
}

div.notclick{
	pointer-events: none;
}
.layui-form-select .layui-input{
	padding-right: 815px;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>轮换方案</li>
		<li>创建方案</li>
		<li class="active">
		<c:choose>
			<c:when test="${scheme.id != null}">编辑</c:when>
			<c:otherwise>新增</c:otherwise>
		</c:choose>
		</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<span class="title">填报人信息</span>
		<div id="infoArea">
			<span>经办部门：${scheme.department }</span>
			<span>经办人：${scheme.creater }</span>
			<span>经办时间：<fmt:formatDate value="${scheme.createTime }" pattern="yyyy年MM月dd日"/> </span>
		</div>
	</div>
	<form action="Create.shtml" method="Post" enctype="multipart/form-data">
	<div id="dataArea" class="infoArea">
		<span class="title">轮换方案信息</span>
		<div id="mainInfo" >
			<div class="layui-form">
				<span style="text-align:right"><b class="requiredData">*</b>所属计划/方案：</span>
				<div  class="layui-inline">
					<select class="inputArea" id="souce-plan" name="planMainId" lay-verify="required" lay-filter="parent" lay-search>
						<option value="">--搜索选择--</option>
						<c:forEach items="${souce }" var="item">
							<option <c:if test="${scheme.planMainId eq item.key}">SELECTED</c:if> value="${item.key }">${item.value }</option>
						</c:forEach>
					</select>
					<%--<select class="inputArea" id="souce-plan" name="originId" lay-verify="required" lay-filter="parent" lay-search>
						<option value="">--搜索选择--</option>
						<c:forEach items="${souce }" var="item">
							<option <c:if test="${scheme.originId eq item.key}">SELECTED</c:if> value="${item.key }">${item.value }</option>
						</c:forEach>
					</select>--%>
				</div>
			</div>
			<div>
				<span style="text-align:right"><b class="requiredData">*</b>计划年份：</span>
				<span name="year" style="margin:0;padding:0;text-align:left;">${scheme.year}</span>
			</div>
			<div>
				<span style="text-align:right"><b class="requiredData">*</b>方案名称：</span>
				<input class="inputArea" type="text" value="${scheme.schemeName }" autocomplete="off" maxlength="45" placeholder="请输入标题"  name="schemeName">
			</div>
			<div>
				<span style="text-align:right"><b class="requiredData">*</b>轮换类别：</span>
				<select class="inputArea" id="scheme-type" name="schemeType">
				</select>
			</div>
			<div>
				<span style="text-align:right"><b class="requiredData">*</b>轮换方式：</span>
				<select class="inputArea" id="rotate-type" name="rotateType" >
				</select>
			</div>
			<div>
				<span style="text-align:right">附件：</span>
				<%--<div class="buttonArea" id="add-annex">${filename.fileName eq null ? '添加附件' : filename.fileName}</div>--%>
				<div class="buttonArea" id="add-annex">添加附件</div>
				<span id="fileName">
					<a href="${ctx }/sysFile/download.shtml?fileId=${scheme.annex}" style="margin:0 10px;">${filename.fileName}</a>
				</span>
                <input type="hidden" name="annex" value="${scheme.annex}"/>
				<input type="file"  style="display:none;" id="file-input" name="file">
                <div style="display:inline-block;font-size:20px;" id="openExce">
					<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${filename.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
						预览
					</a>
					<a href="javascript:openAnnex('${scheme.annex}')" id="openFile" style="display: none">
						预览
					</a>
                    <input type="button" id="delFileBtn" <c:if test="${empty filename.fileName}">style="display: none" </c:if>  onclick="resetFileInput();"  value="删除"/>
                </div>

            </div>
			<div>
				<span style="position:relative;bottom:4em;text-align: right">备注：</span>
				<textarea rows="4" class="inputArea" style="width:88%" name="description" maxlength="200">${scheme.description}</textarea>
			</div>
		</div>
	</div>
	<div id="listArea">
		<div class="buttonArea" id="add-list">新增</div>
		<table>
			<thead>
				<tr>
					<td style="min-width: 50px">批次</td>
					<td style="min-width: 120px">竞价时间</td>
					<td class="year-scheme" style="min-width: 50px">方案类别</td>
					<td class="year-scheme" style="min-width: 116px">轮换方式</td>

					<td class="normal-scheme" style="min-width: 120px">轮换开始时间</td>
					<td class="normal-scheme" style="min-width: 120px">轮换结束时间</td>
					<td style="min-width: 60px">企业</td>
					<td>库点</td>
					<td>仓房</td>
					<td>粮食品种</td>
					<td>收获年份</td>
					<td>产地</td>
					<td >计划等级</td>
					<td >存储方式</td>
					<td class ="qualityDetail" style="min-width: 60px">质量详情</td>
					<td style="min-width: 60px">数量(t)</td>
					<td class ="qualityDetail"  style="min-width: 50px">实际仓容</td>
					<td class ="outKu" style="min-width: 50px">实际库存</td>
					<td class="normal-scheme"  style="min-width: 50px">剩余计划数量</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-result">
				<tr id="template-tr">
					<td name="batch"><input style="width:80%" type="number" oninput="if(value.length>11)value=value.slice(0,11)" class="inputArea"></td>
					<td name="bidding-time"><input style="width:80%" class="inputArea timeNeed"></td>
					<td name="scheme-type" class="year-scheme">
					</td>
					<td name="rotate-type" class="year-scheme">
						<select style="width:80%" class="inputArea">
							<option>竞价销售</option>
							<option>协议销售</option>
							<option>内部招标</option>
							<%--<option>其他</option>--%>
							<option>招标采购</option>
							<option>订单采购</option>
							<option>进口粮采购</option>
						</select>
					</td>

					<td name="start-time" class="normal-scheme"><input style="width:80%" class="inputArea timeNeed "></td>
					<td name="end-time" class="normal-scheme"><input style="width:80%" class="inputArea timeNeed"></td>
                    <td name="enterpriseId" style="display: none"></td>
					<td name="enterpriseName"></td>
					<td name="library-id">

						<%--<select class="inputArea">--%>
						<%--<c:forEach items="${basepoint }" var="point">--%>
							<%--<option>${point }</option>--%>
						<%--</c:forEach>--%>
						<%--</select>--%>
						<input style="width:80%" type="text" class="inputArea">
					</td>
					<td name="bran-number">
						<%--<select class="inputArea">--%>
						<%--<option value="">请选择</option>--%>
						<%--<c:forEach items="${storehouse }" var="house">--%>
							<%--<option tag="${house.warehouse }" style="display:none">${house.encode }</option>--%>
						<%--</c:forEach>--%>
						<%--</select>--%>
							<input style="width:80%" type="text" class="inputArea">
					</td>
					<td name="food-type"><input style="width:80%" type="text" class="inputArea"></td>
					<td name="yield-time">
						<input class="inputArea yearNeed"/>
					</td>
					<td name="ogirin">
					</td>
					<td name="planLevel"></td>
					<td name="storeType"></td>
					<td name="qualityDetail" class ="qualityDetail">
						<textarea type="text" class="inputArea qualityDetail1" /></textarea>
					</td>
					<td name="rotate-number">
						<input type="number" class="inputArea" step="0.001" oninput="if(value.length>11)value=value.slice(0,11)" onchange = "numberFixed(this,3)"/>
					</td>
					<td  name="realContainer" class ="qualityDetail"></td>
					<td  name="realStorage" class="outKu"></td>
					<td name="restNumber" class="normal-scheme"></td>
					<td>
						<div class="buttonArea quality-detail">质量详情</div>
						<div class="buttonArea remove-detail">删除</div>
					</td>
				</tr>
				<c:forEach items="${scheme.schemeDetail }" var="item">
				<tr class="data-tr" tag="${item.planDetailId }">
					<td name="batch"><input style="width:80%" class="inputArea" type="number" oninput="if(value.length>10)value=value.slice(0,10)" value="${item.schemeBatch}"></td>
					<td name="bidding-time"><input style="width:80%" class="inputArea timeNeed" value="<fmt:formatDate value="${item.biddingTime }" pattern="yyyy-MM-dd"/>"></td>
					<td name="scheme-type" class="year-scheme">
						${item.schemeType}
					</td>
					<td name="rotate-type"  class="year-scheme">
						<select style="width:80%" class="inputArea">
						<c:choose>
							<c:when test="${item.schemeType.trim() eq '出库'}">
							<option <c:if test="${item.rotateType eq '竞价销售' }">selected</c:if>>竞价销售</option>
							<option <c:if test="${item.rotateType eq '协议销售' }">selected</c:if>>协议销售</option>
							<option <c:if test="${item.rotateType eq '内部招标' }">selected</c:if>>内部招标</option>
							<%--<option <c:if test="${item.rotateType eq '其他' }">selected</c:if>>其他</option>--%>
							</c:when>
							<c:when test="${item.schemeType.trim() eq '入库'}">
							<option <c:if test="${item.rotateType eq '招标采购' }">selected</c:if>>招标采购</option>
							<option <c:if test="${item.rotateType eq '订单采购' }">selected</c:if>>订单采购</option>
							<option <c:if test="${item.rotateType eq '进口粮采购' }">selected</c:if>>进口粮采购</option>
							</c:when>
						</c:choose>
						</select>
					</td>
					<td name="start-time" class="normal-scheme"><input style="width:80%" class="inputArea timeNeed" value="<fmt:formatDate value="${item.startTime }" pattern="yyyy-MM-dd"/>"></td>
					<td name="end-time" class="normal-scheme"><input style="width:80%" class="inputArea timeNeed" value="<fmt:formatDate value="${item.endTime }" pattern="yyyy-MM-dd"/>"></td>
                    <td name="enterpriseId" style="display: none">${item.enterpriseId}</td>
                    <td name="enterpriseName">${item.enterpriseName}</td>
					<td name="library-id">
						${item.libraryId}
						<%--<c:forEach items="${basepoint }" var="point">--%>
							<%--<c:if test="${item.libraryId eq point}">--%>
								<%--<input style="width:80%" type="text" class="inputArea" disabled="disabled" value="${point}"/>--%>
							<%--</c:if>--%>
						<%--</c:forEach>--%>
					</td>
					<td name="bran-number">
						${item.branNumber }
					</td>
					<td name="food-type">${item.foodType }</td>
					<td name="yield-time">
					${item.yieldTime }
					</td>
					<td name="ogirin">
						${item.ogirin }
					</td>

						<td  name="planLevel">${item.planLevel }</td>
					<td  name="storeType">${item.storeType }</td>
					<td class="qualityDetail"  name="qualityDetail">
							<%--${item.qualityDetail }--%>

                        <c:if test="${item.schemeType.trim() eq '出库'}">

                        </c:if>
                        <c:if test="${item.schemeType.trim() eq '入库'}">
                            <textarea type="text" class="inputArea"/>${item.qualityDetail}</textarea>
                        </c:if>
					</td>
					<td name="rotate-number">
						<input type="number" class="inputArea" value="${item.rotateNumber }" oninput="if(value.length>10)value=value.slice(0,10)" onchange = "numberFixed(this,3)"/>
					</td>
					<td  class="qualityDetail" name="realContainer">
						${item.realContainer }
					</td>
					<td class="outKu" name="realStorage">
						${item.realStorage }
					</td>
					<td class="normal-scheme" name="restNumber">
							${item.restNumber }
					</td>
					<td>
						<c:if test="${item.schemeType.trim() eq '出库'}">
						<div class="buttonArea quality-detail">质量详情</div>
						</c:if>

						<div class="buttonArea remove-detail">删除</div>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="bottom-button">
			<div class="buttonArea" id="save">
			<c:choose>
				<c:when test="${scheme.id != null }">
					编辑
				</c:when>
				<c:otherwise>
					保存
				</c:otherwise>
			</c:choose>
			</div>
			<%--<c:choose>--%>
				<%--<c:when test="${scheme.state == '待提交'}">--%>
					<%--<div class="buttonArea" id="submit">提交</div>--%>
				<%--</c:when>--%>
			<%--</c:choose>--%>
			<div class="buttonArea" id="cancel">取消</div>
		</div>
	</div>
	</form>
</div>
<div id="float-alert1">
	<div id="table-wapper">
		<span class="title">明细选择</span>
		<i id="close-float-alert1" class="layui-icon">&#x1006;</i>
		<div style="margin:10px 0">
			粮食品种：
			<%--<input id="filter-grainType" style="width:15%;" class="inputArea"/>--%>
			<select id="filter-grainType" style="width:15%;" class="inputArea">
				<option value="">全部</option>
				<c:forEach items="${dictType}" var="dict">
					<option value="${dict.value}">${dict.value}</option>
				</c:forEach>
			</select>
			<%--库点：--%>
			<%--<select id="filter-receivePlace" style="width:15%;" class="inputArea">--%>
				<%--<option value="">全部</option>--%>
			<%--<c:forEach items="${basepoint }" var="point">--%>
				<%--<option>${point }</option>--%>
			<%--</c:forEach>--%>
			<%--</select>--%>
			<%--库点类型：--%>
			<%--<select class="inputArea" id="warehouse_type" style="width: 15%;">--%>
				<%--<option selected="selected">--请选择--</option>--%>
				<%--<option value="储备库">直属</option>--%>
				<%--<option value="代储库">代储</option>--%>
			<%--</select>--%>
			轮换类型：
			<select class="inputArea" id="rotate_type" style="width: 15%;">
				<option value="">全部</option>
				<option value="轮入">轮入</option>
				<option value="轮出">轮出</option>
			</select><br/>
			产地：
			<input id="orign" style="width:15%;" class="inputArea"/>
			<%--仓房编号：--%>
			<%--<input id="warehouse_code" style="width:15%;" class="inputArea"/>--%>
			收获年份：
			<input id="yield_Time" style="width:15%;" class="inputArea"/>

			<div id="filter-Button" style="margin-left:20px;" class="buttonArea">搜索</div>
		</div>
		<form id="out-table">
		<table>
			<thead>
				<tr>
					<td style="text-align: center">
                        选择<input type="checkbox" name="" id ="checkAll">
                    </td>
					<td style="text-align: center">轮换类别</td>
					<td style="text-align: center">粮食品种</td>
					<td style="text-align: center">企业</td>
					<td style="text-align: center">库点</td>
					<td style="text-align: center">仓房</td>
					<td style="text-align: center">收获年份</td>
					<td style="text-align: center">产地</td>
					<td style="text-align: center">计划轮换出入库数量</td>
					<td style="text-align: center">计划剩余数量</td>
					<td style="text-align: center">实际仓容</td>
					<td style="text-align: center">实际库存量</td>
					<td style="text-align: center">质量等级</td>
					<td style="text-align: center">存储方式</td>
					<td style="text-align: center">质量详情</td>
				</tr>
				<tr id="soure-template" style="display:none" >
					<td><input type="checkbox" name=""></td>
					<td style="text-align: left" name='rotateType'></td>
					<td style="text-align: left" name="foodType"></td>
                    <td style="display: none" name="enterpriseId"></td>
					<td style="text-align: left" name="enterpriseName"></td>
					<td style="text-align: left" name="libraryId"></td>
					<td style="text-align: left" name="branNumber"></td>
					<td style="text-align: center" name="yieldTime"></td>
					<td style="text-align: left" name="ogirin"></td>
					<td style="text-align: right" name="rotateNumber"></td>
					<td style="text-align: right" name="restNumber"></td>
					<td style="text-align: right" name="realContainer"></td>
					<td style="text-align: right" name="realStorage"></td>
					<td style="text-align: left" name="planLevel"></td>
					<td style="text-align: left" name="storeType"></td>
					<td style="text-align: left" name="qualityDetail"></td>
				</tr>
			</thead>
			<tbody id="schemeDetail-data-list">

			</tbody>
		</table>
		</form>
		<div style="text-align:right;margin-top:20px;">
			<div class="buttonArea" id="add-tolist">添加</div>
		</div>
	</div>
</div>
<div id="float-alert2">
	<div id="table-wapper2">
		<span class="title">质量明细</span>
		<i id="close-float-alert2" class="layui-icon">&#x1006;</i>
		<p>入库质检</p>
		<table>
			<thead>
				<tr>
					<td>检测项名称	</td>
					<td>等级</td>
					<td>标准值</td>
					<td>检测值</td>
					<td>结论</td>
				</tr>
				<tr id="soure-template2" style="display:none" >
					<td name='name'></td>
					<td name="level"></td>
					<td name="stand"></td>
					<td name="value"></td>
					<td name="commend"></td>
				</tr>
			</thead>
			<tbody id="schemeDetail-data-list2">

			</tbody>
		</table>

		<p>出库质检</p>
		<table>
			<thead>
				<tr>
					<td>检测项名称</td>
					<td>等级</td>
					<td>标准值</td>
					<td>检测值</td>
					<td>结论</td>
				</tr>
				<tr id="soure-template3" style="display:none" >
					<td name='name'></td>
					<td name="level"></td>
					<td name="stand"></td>
					<td name="value"></td>
					<td name="commend"></td>
				</tr>
			</thead>
			<tbody id="schemeDetail-data-list3">

			</tbody>
		</table>
	</div>
</div>
<script>

    var form=layui.form;
    form.render();
    document.getElementById("file-input").addEventListener("change",function () {
        $("#delFileBtn").attr("style","display:block;");
    });
    function resetFileInput(){
        $("#file-input").val("");
        $("#add-annex").html("添加附件");
        $("input[name='annex']").val("");
        $("#delFileBtn").hide();
        $("#openExce a").html("");
        $("#fileName").html("");
    }

    if ("${scheme.annex}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
    //,"出入库"
	var SchemeType = ["入库","出库","出入库","年度轮换方案"];
	var InRotateType = ["全部","竞价销售","协议销售","内部招标","其他","招标采购","订单采购","进口粮采购"];
    var OutInRotateType = ["竞价销售","协议销售","其他"];
	var defaultSchemeType = "${scheme.schemeType}";
	var defaultRotateType = "${scheme.rotateType}";

	var oldSchemeType;
	var oldRotateType;

	var yearMapper = {
	<c:forEach items="${yearmapper}" var="year">
		"${year.key }":"${year.value }",
	</c:forEach>
	};

	var planUrl = "${ctx}/rotatePlan/DetailList.shtml";//根据计划详情主表id获取计划详情明细
    var planMainUrl = "${ctx}/rotatePlan/mainDetailList.shtml";//根据计划申报主表id获取计划详情明细
	var schemeUrl = "${ctx}/RotateScheme/Detail.shtml";
	var urlMapper = {"Plan":planMainUrl,"Scheme":schemeUrl}

	var laydate=layui.laydate;

	$(function(){
		$("span[name='year']").text(yearMapper[$("#souce-plan").find("option:selected").val()]);

		// 初始化表头显示
		if($("#scheme-type").val() == '年度轮换方案'){
			$(".year-scheme").show();
			$(".normal-scheme").hide();
		}else{
			$(".year-scheme").hide();
			$(".normal-scheme").show();
		};

		if($("#scheme-type").val() == '年度轮换方案'||$("#scheme-type").val() == '出库'){
	    	$(".outKu").show();
		}else{
		    $(".outKu").hide();
		}

		for(var i=0;i<SchemeType.length;i++){
			var option = document.createElement("option");
			$(option).html(SchemeType[i]);
			if(SchemeType[i] == defaultSchemeType){
				$(option).attr("selected","selected");
			}
			$("#scheme-type").append($(option));
		}

		<c:if test="${scheme.id != null}">
			$(".data-tr").find(".timeNeed").each(function(){
				laydate.render({
					elem:$(this)[0],
					type:"date",
					format:"yyyy-MM-dd",
					trigger: 'click'
				});
			});
			$(".data-tr").find(".yearNeed").each(function(){
				laydate.render({
					elem:$(this)[0],
					type:"year",
					trigger: 'click'
				});
			});
		</c:if>

		// $("td[name='bran-number']").each(function(){
		// 	var libraryId = $(this).prev().val();
		// 	$(this).find("select>option").each(function(){
		// 		if($(this).text() == '请选择')
		// 			return true;
		// 		if($(this).attr("tag") == libraryId){
		// 			$(this).show()
		// 		}else{
		// 			$(this).hide();
		// 		}
		// 	});
		// });

		checkSchemeType($("#souce-plan"));
		CheckRotateType();
		firstTime = true;
	});

	function IsYearScheme(){
		return $("#souce-plan").find("option:selected").text().indexOf("(年度方案)") != -1;
	}

	var rotateNum;
	$("td[name='rotate-number']>input").focus(function(){
		rotateNum = $(this).val();
	});

	$("td[name='rotate-number']>input").blur(function(){
        if($("#scheme-type").val() != '年度轮换方案'){
			//剩余计划数量
			var restNumber =$(this).parent().parent().find("td[name='restNumber']").html();
			restNumber = Number($.trim(restNumber));
			var val = Number($(this).val());//本次子方案的数量
			/*var currentVal = Number($(this).attr("currentVal"));//与该条子方案中的计划详情子id相同的轮换数量总和
			var maxVal = Number($(this).attr("maxVal"));//所选计划详情子表中的计划数量
			var val = Number($(this).val());//本次子方案的数量
			var unDealTotalCount = 0;
			//根据该条子方案的计划详情带出轮换结束时间+允许逾期天数<当前时间且没有生成成交明细的总和
			var a =$(this).parent().parent().attr("tag");
			$.ajax({
				url:"${ctx}/RotateScheme/unDealTotalCountByPlanDetailId.shtml",//根据计划详情子id查出该计划详情子id关联的未成交的方案数量
				data:{
					"pd_id":a
				},
				async:false,
				type:"post",
				success:function(data){
					unDealTotalCount = data;
				}
			});
			//根据该条子方案的计划详情带出轮换结束时间<当前时间且没有生成成交明细的总和
			if((currentVal + val-unDealTotalCount) > maxVal){
				layer.msg("轮换数量总和不能超过计划规定数,余量为"+(maxVal - currentVal+unDealTotalCount)+"吨",{icon:0});
				$(this).find("input").val(rotateNum);
			}*/
			if(val>restNumber){
				layer.msg("轮换数量总和不能超过计划规定数,余量为"+restNumber+"吨",{icon:0});
			}
		}
	});

	$("#scheme-type").click(function(){
		oldSchemeType = $(this).val();
	});

	$("#scheme-type").change(function(){
		CheckRotateType();
	});

	$("#souce-plan").change(function(){
		if($(".data-tr").length > 0){
			$(".data-tr").remove();
		}
		checkSchemeType($(this));
		CheckRotateType();
	});

    var asked = false;
	$("#souce-plan").focus(function(){
		var self  = $(this);
		if(!asked){
			$(self).attr("disabled","disabled");
			var index = layer.confirm('更改所属计划/方案会清空方案详情，要继续吗？', {
				btn: ['是','否']
			}, function(){
			  	asked = true;
			  	$(self).removeAttr("disabled");
			  	layer.close(index);
			}, function () {
                asked = false;
                $(self).removeAttr("disabled");
            });
		}
	});

	$("#rotate-type").click(function(){
		oldRotateType = $(this).val();
	});

	function checkSchemeType(ele){
        form.on('select(parent)', function (data) {
            category = data.value;
            //console.log(category);

		$("span[name='year']").html(yearMapper[category]);
			if($(ele).find("option:selected").text().indexOf("(年度方案)")!=-1){
				$("#scheme-type").find("option").remove();
				for(var i=0;i<2;i++){
					var option = document.createElement("option");
					if(SchemeType[i] == defaultSchemeType){
						$(option).attr("selected","selected")
					}
					$(option).html(SchemeType[i])
					$("#scheme-type").append($(option));
				}
			}else{
				$("#scheme-type").find("option").remove();
				for(var i=0;i<SchemeType.length;i++){
					var option = document.createElement("option");
					if(SchemeType[i] == defaultSchemeType){
						$(option).attr("selected","selected")
					}
					$(option).html(SchemeType[i])
					$("#scheme-type").append($(option));
				}
			}
        })
	}

	function CheckDetailRotate(ele){
		if(ele!=null){
			var rotateele = $(ele).find("td[name='rotate-type']").find("select");
			if($(ele).find("td[name='scheme-type']").html() == '入库'){
				$(rotateele).empty();
				for(var i=5;i<InRotateType.length;i++){
					var option = document.createElement("option");
					$(option).html(InRotateType[i]);
					$(rotateele).append($(option));
				}
			}else{
				$(rotateele).empty();
				for(var i=1;i<5;i++){
					var option = document.createElement("option");
					$(option).html(InRotateType[i]);
					$(rotateele).append($(option));
				}
			}
		}
	}

	function CheckRotateType(){
		var schemeval = $.trim($("#scheme-type").val());
		if(schemeval == '入库'){
			var containOtherVal = false;
			$(".data-tr").find("td[name='scheme-type']").each(function(){
			    debugger
				if($.trim($(this).html()) != $("#scheme-type").val()){
					containOtherVal = true;
					return;
				}
			});
			if(containOtherVal){
				layer.msg("无法更改轮换类别为"+$("#scheme-type").val()+"，因详情存在非"+$("#scheme-type").val()+"的数据",{icon:0});
				$("#scheme-type").val(oldSchemeType)
				CheckRotateType();
				return;
			}
			$(".year-scheme").hide();
			$(".normal-scheme").show();
            $(".qualityDetail").show();
            $(".outKu").hide();
			$("#rotate-type").find("option").remove();
			for(var i=5;i<InRotateType.length;i++){
				var option = document.createElement("option");
				$(option).html(InRotateType[i]);
				if(defaultRotateType == InRotateType[i])
					$(option).attr("selected","selected");
				$("#rotate-type").append($(option));
			}
		}else if(schemeval == '出库'){
			var containOtherVal = false;
			$(".data-tr").find("td[name='scheme-type']").each(function(){
				if($.trim($(this).html()) != $("#scheme-type").val()){
					containOtherVal = true;
					return;
				}
			});
			if(containOtherVal){
				layer.msg("无法更改轮换类别为"+$("#scheme-type").val()+"，因详情存在非"+$("#scheme-type").val()+"的数据",{icon:0});
				$("#scheme-type").val(oldSchemeType)
				CheckRotateType();
				return;
			}
			$(".year-scheme").hide();
			$(".normal-scheme").show();
            $(".qualityDetail").hide();
            $(".outKu").show();
			$("#rotate-type").find("option").remove();
			for(var i=1;i<5;i++){
				var option = document.createElement("option");
				$(option).html(InRotateType[i]);
				if(defaultRotateType == InRotateType[i])
					$(option).attr("selected","selected");
				$("#rotate-type").append($(option));
			}
		}else if(schemeval == '出入库'){
            $(".year-scheme").show();
            $(".normal-scheme").show();
            $(".qualityDetail").show();
            $(".outKu").show();
            $("#rotate-type").find("option").remove();
            var option = document.createElement("option");
            $(option).html(InRotateType[0]);
            if(defaultRotateType == InRotateType[0])
                $(option).attr("selected","selected");
            $("#rotate-type").append($(option));
        } else{
			$(".year-scheme").show();
			$(".normal-scheme").hide();
            $(".qualityDetail").show();
            $(".outKu").show();
			$("#rotate-type").find("option").remove();
			var option = document.createElement("option");
			$(option).html(InRotateType[0]);
			if(defaultRotateType == InRotateType[0])
				$(option).attr("selected","selected");
			$("#rotate-type").append($(option));
		}
	}

	$("#add-annex").click(function(){
		$("#file-input").click();
        $("#openExce a").html("");
    });

	$("#file-input").change(function(){
		var filename = $(this).val().split("\\");
		$("#fileName").html(filename[filename.length - 1]);
	});

	var isSendingRequest = false;//save按钮点击状态
	$("#save,#submit,#agree").click(function(){
		var currBtn = $(this).addClass("notclick");
		var patchAll = true;
		$("#souce-plan").removeAttr("disabled");
		$(".requiredData").parent().parent().find("input,select").each(function(){
			if($(this).val() == ""){
				layer.msg("*项为必填项,请补全相关信息",{icon:0});
				patchAll = false;
				return false;
			}
		});
		$(".data-tr").each(function(){
			$(this).find("input,select").each(function(){
				if($(this).parent().css("display") == 'none'){
                    return true;
				}

				if($(this).val() == ""){
					layer.msg("*项为必填项,请补全相关信息",{icon:0});
					patchAll = false;
					return false;
				}
			});

		});

		if(!patchAll){//判断是否有未填写必填内容
		    // layer.closeAll("loading");
            currBtn.removeClass("notclick");
            return;
		}


		var flage = false;
        if($("#scheme-type").val() != '年度轮换方案'){
			$(".data-tr").each(function(){
				var restNumber =$(this).find("td[name='restNumber']").html();
				restNumber = Number($.trim(restNumber));
				var obj = $(this).find("td[name='rotate-number']>input");
				var val = Number(obj.val());//本次子方案的数量
				/*//	判断轮换量总和是否满足条件
				var obj = $(this).find("td[name='rotate-number']>input");
				rotateNum = obj.val();
				var currentVal = Number(obj.attr("currentVal"));//与该条子方案中的计划详情子id相同的轮换数量总和
				var maxVal = Number(obj.attr("maxVal"));//所选计划详情子表中的计划数量
				var val = Number(obj.val());//本次子方案的数量
				var unDealTotalCount = 0;
				//根据该条子方案的计划详情带出轮换结束时间+允许逾期天数<当前时间且没有生成成交明细的总和
				$.ajax({
					url:"${ctx}/RotateScheme/unDealTotalCountByPlanDetailId.shtml",//根据计划详情子id查出该计划详情子id关联的未成交的方案数量
					data:{
						"pd_id":$(this).attr("tag")
					},
					type:"post",
					async:false,
					success:function(data){
						debugger
						//$(template).find("td[name='rotate-number']").find("input").attr("currentVal",data);
						unDealTotalCount = data;
					}
				});

				if((currentVal + val - unDealTotalCount) > maxVal){
					flage = true
					layer.msg("轮换数量总和不能超过计划规定数",{icon:0});
					return false;
				};*/
				if(val>restNumber){
					flage = true
					layer.msg("轮换数量总和不能超过计划规定数",{icon:0});
					return false;
				}
			});
		}
        if(flage){
            currBtn.removeClass("notclick");
            return;
		};

		var detailData = [];
		$(".data-tr").each(function(){
		    // 判断是否为年度轮换
			if($("select[name='schemeType']").val()=='年度轮换方案'){
				// 所属库点
                var libraryId = "";
                // 判断selece对象是否存在
                var libaraySelect = $(this).find("td[name='library-id']").find("select");
                if(libaraySelect.length == 0){
                    libraryId = $.trim($(this).find("td[name='library-id']").html());
                }else{
                    libraryId = libaraySelect.val();
                }

                // 仓房编号
                var branNumber = "";
                var branNumberNode = $(this).find("td[name='bran-number']"); 	//
                if(branNumberNode.find("select").length == 0 && branNumberNode.find("input").length == 0){
                    branNumber = $.trim($(this).find("td[name='bran-number']").html());
                }else if(branNumberNode.find("select").length > 0){
                    branNumber = branNumberNode.find("select").val();
                }else if(branNumberNode.find("input").length>0){
                    branNumber = branNumberNode.find("input").val();
				}


				let rotateType = $(this).find("td[name='rotate-type'] select option:selected").val();
                if(rotateType == "招标采购" && (branNumber == null||branNumber == "" || libraryId == null || libraryId == "")){
                    flage = true;
					return false;
				}


                // 粮食品种
                var foodType = "";
                // 判断input对象是否存在
                var foodTypeSelect = $(this).find("td[name='food-type']").find("input");
                if(foodTypeSelect.length == 0 ){
                    foodType = $.trim($(this).find("td[name='food-type']").html());
                }else{
                    foodType = foodTypeSelect.val();
                }

                // 收获年份
                var yieldTime = "";
                // 判断input对象是否存在
                var yieldTimeSelect = $(this).find("td[name='yield-time']").find("input");
                if(yieldTimeSelect.length == 0 ){
                    yieldTime = $.trim($(this).find("td[name='yield-time']").html());
                }else{
                    yieldTime = yieldTimeSelect.val();
                }
                var biddingtime = $(this).find("td[name='bidding-time']").find("input").val().split("\-");
				detailData.push({
                    "schemeBatch":$(this).find("td[name='batch']").find("input").val(),
                    "biddingTime":new Date(biddingtime[0],Number(biddingtime[1] - 1),biddingtime[2]),
                    "schemeType":$.trim($(this).find("td[name='scheme-type']").html()),
                    "rotateType":$.trim($(this).find("td[name='rotate-type']").find("select").val()),
                    "enterpriseId":$.trim($(this).find("td[name='enterpriseId']").html()),
                    "libraryId":libraryId,
                    "branNumber":branNumber,
                    "foodType":foodType,
                    "yieldTime":yieldTime,
                    "ogirin":$.trim($(this).find("td[name='ogirin']").html()),
                    "planLevel":$(this).find("td[name='planLevel']").html(),
                    "storeType":$.trim($(this).find("td[name='storeType']").html()),
                    "qualityDetail":$(this).find("td[name='qualityDetail']").find("textarea").val(),
                    "planDetailId":$(this).attr("tag"),
                    "rotateNumber":$(this).find("td[name='rotate-number']").find("input").val(),
                    "realContainer":$.trim($(this).find("td[name='realContainer']").html()),
                    "realStorage":$.trim($(this).find("td[name='realStorage']").html()),
				});
			}else{
			    debugger
                var biddingtime = $(this).find("td[name='bidding-time']").find("input").val().split("\-");
                var starttime = $(this).find("td[name='start-time']").find("input").val().split("\-");
                var endtime = $(this).find("td[name='end-time']").find("input").val().split("\-");
                var currentTime1 = Date.parse(new Date(biddingtime[0],Number(biddingtime[1] - 1),biddingtime[2]));
                var currentTime2 = Date.parse(new Date(starttime[0],Number(starttime[1] - 1),starttime[2]));
                var currentTime3 = Date.parse(new Date(endtime[0],Number(endtime[1] - 1),endtime[2]));

				// 所属库点
                var libraryId = "";
                // 判断selece对象是否存在
                var libaraySelect = $(this).find("td[name='library-id']").find("select");
                if(libaraySelect.length == 0){
                    libraryId = $.trim($(this).find("td[name='library-id']").html());
                }else{
                    libraryId = libaraySelect.val();
                }
                // 仓房编号
                var branNumber = "";
                var branNumberNode = $(this).find("td[name='bran-number']"); 	//
                if(branNumberNode.find("select").length == 0 && branNumberNode.find("input").length == 0){
                    branNumber = $.trim($(this).find("td[name='bran-number']").html());
                }else if(branNumberNode.find("select").length > 0){
                    branNumber = branNumberNode.find("select").val();
                }else if(branNumberNode.find("input").length > 0){
                    branNumber = branNumberNode.find("input").val();
                }

				if($("select[name='schemeType']").val()=='出入库'){
                    let rotateType = $(this).find("td[name='rotate-type'] select option:selected").val();
                    if(rotateType == "招标采购" && (branNumber == null||branNumber == "" || libraryId == null || libraryId == "")){
                        flage = true;
                        return false;
                    }
				}else{
                    let rotateTypeTemp = $("#rotate-type option:selected").val();
                    if(rotateTypeTemp == "招标采购" && (branNumber == null||branNumber == "" || libraryId == null || libraryId == "")){
                        flage = true;
                        return false;
                    }
				}




                // 粮食品种
                var foodType = "";
                // 判断input对象是否存在
                var foodTypeSelect = $(this).find("td[name='food-type']").find("input");
                if(foodTypeSelect.length == 0 ){
                    foodType = $.trim($(this).find("td[name='food-type']").html());
                }else{
                    foodType = foodTypeSelect.val();
                }

                // 收获年份
                var yieldTime = "";
                // 判断input对象是否存在
                var yieldTimeSelect = $(this).find("td[name='yield-time']").find("input");
                if(yieldTimeSelect.length == 0 ){
                    yieldTime = $.trim($(this).find("td[name='yield-time']").html());
                }else{
                    yieldTime = yieldTimeSelect.val();
                }

			detailData.push({
				"schemeBatch":$(this).find("td[name='batch']").find("input").val(),
				"biddingTime":new Date(biddingtime[0],Number(biddingtime[1] - 1),biddingtime[2]),
				"rotateType":$(this).find("td[name='rotate-type']").find("select").val(),
				"schemeType":$.trim($(this).find("td[name='scheme-type']").html()),
				"startTime":new Date(starttime[0],Number(starttime[1] - 1),starttime[2]),
				"endTime":new Date(endtime[0],Number(endtime[1] - 1),endtime[2]),
                "enterpriseId":$.trim($(this).find("td[name='enterpriseId']").html()),
                "libraryId":libraryId,
				"branNumber":branNumber,
				"realContainer":$(this).find("td[name='realContainer']").html(),
				"realStorage":$(this).find("td[name='realStorage']").html(),
                "foodType":foodType,
                "yieldTime":yieldTime,
				"ogirin":$.trim($(this).find("td[name='ogirin']").html()),
				"rotateNumber":$(this).find("td[name='rotate-number']").find("input").val(),
				"planLevel":$(this).find("td[name='planLevel']").html(),
                "storeType":$.trim($(this).find("td[name='storeType']").html()),
               /* "qualityDetail":$(this).find("td[name='qualityDetail']").html(),*/
                "qualityDetail":$(this).find("td[name='qualityDetail']").find("textarea").val(),
				"planDetailId":$(this).attr("tag"),
			});
				debugger
            if(currentTime2>currentTime3){
               // alert("轮换结束时间要大于轮换开始时间");
                layer.msg("轮换结束时间要大于轮换开始时间",{icon:0});
                patchAll = false;
                return;
            }
            if (currentTime2<=currentTime1&&currentTime1<=currentTime3){

            }else{

               if(!isNaN(currentTime1)&&!isNaN(currentTime2)&&!isNaN(currentTime3)){
               		//alert("竞价时间要大于轮换开始时间，且要小于结束时间");
	            	layer.msg("竞价时间要大于轮换开始时间且要小于结束时间",{icon:0});
	            	patchAll = false;
	                return;
               }

            }
            }
		});

		if(flage){
            layerMsgError("招标采购所对应的明细中，库点仓号不能为空");
            currBtn.removeClass("notclick");
            return;
		}

		if(!patchAll){
            //时间之间的判断
            currBtn.removeClass("notclick");
            return;
		}

		if(detailData.length == 0){
			layer.msg("请添加明细信息",{icon:0});
            currBtn.removeClass("notclick");
			return;
		}
		if($(this).html().indexOf('保存')!=-1){
			if(!isSendingRequest){
                var loadingIndex = layer.load(2);
			    isSendingRequest = true;
                $("form").ajaxSubmit({
                    type:"post",
                    data:{
                        "year":$("span[name='year']").html(),
                        "originType":$("#souce-plan").find("option:selected").text().indexOf("(年度方案)")!=-1?2:1,
                        "state":"待提交",
                        "detailList":JSON.stringify(detailData)
                    },
                    success:function(data){
                        // layer.close(loadingIndex);
                        isSendingRequest = false;

                        if(data.success){
                            layer.msg("信息保存成功",{icon:1},function(){
                                window.location.href = "${ctx}/RotateScheme/List.shtml?view=create&type=ProviceUnit";
                            });
                        }else{
                            layer.close(loadingIndex);
                            layer.msg(data.msg,{icon:2})
                            currBtn.removeClass("notclick");
                        }
                    },
                    error:function(xhr,status,err){
                        layer.close(loadingIndex);
                        isSendingRequest = false;
                        currBtn.removeClass("notclick");
                    }
                });
			}else{
			    layer.msg("重复提交请求",{time:2000});
			    isSendingRequest = false;//重置
            }

		}else if($(this).html().indexOf('提交')!=-1 || $(this).html().indexOf('同意')!=-1){
			var way = $("#save").html().indexOf("保存")!=-1 ? "Create.shtml" : "Edit.shtml";
			var statemap = {"提交":"OA审核中","同意":"审核通过"};
			$("form").ajaxSubmit({
				url:way,
				type:"post",
				data:{
					"id":"${scheme.id }",
					"year":$("span[name='year']").html(),
					"originType":$("#souce-plan").find("option:selected").text().indexOf("(年度方案)")!=-1?2:1,
					"detailList":JSON.stringify(detailData),
					"state":statemap[$(this).html()],
				},
				success:function(data){
                    currBtn.removeClass("notclick");
					if(data.success){
						layer.msg("信息提交成功",{icon:1},function(){
							window.location.href = "${ctx}/RotateScheme/List.shtml?view=create&type=ProviceUnit";
						});
					}else{
					    if(data.msg==""||data.msg==null){
                            layer.msg("信息提交失败",{icon:2})
                        }else {
                            layer.msg(data.msg,{icon:2})
                        }
					}
				}
			});
		}else if($(this).html().indexOf('编辑')!=-1){
			$("form").ajaxSubmit({
				url:"Edit.shtml",
				type:"post",
				data:{
					"id":"${scheme.id }",
					"year":$("span[name='year']").html(),
					"originType":$("#souce-plan").find("option:selected").text().indexOf("(年度方案)")!=-1?2:1,
					"detailList":JSON.stringify(detailData),
				},
				success:function(data){
                    currBtn.removeClass("notclick");
					if(data.success){
					    debugger
						layer.msg("信息保存成功",{icon:1},function(){
							window.location.href = "${ctx}/RotateScheme/List.shtml?view=create&type=ProviceUnit";
						});
					}
				}
			});
		}else{
            currBtn.removeClass("notclick");
			return false;
		}
	});

	$("#add-list").click(function(){
		var type = IsYearScheme()?"Scheme":"Plan";
		$.ajax({
			type:"post",
			data:{
				"sid":$("#souce-plan").val()
			},
			url:urlMapper[type],
			success:function(data){
				if(type == 'Plan'){
					for(var i = 0;i<data.length;i++){
						if($("#scheme-type").val() == '出入库'||$("#scheme-type").val() == '年度轮换方案' || ($("#scheme-type").val()=='入库'?'轮入':'轮出')==data[i]["rotateType"]){
							var datatr = $("#soure-template").clone(true);
							$(datatr).attr("tag",data[i]["id"])
							$(datatr).find("td[name='foodType']").html(data[i]["foodType"]);
                            $(datatr).find("td[name='enterpriseId']").html(data[i]["enterpriseId"]);
							$(datatr).find("td[name='enterpriseName']").html(data[i]["enterpriseName"]);
							$(datatr).find("td[name='branNumber']").html(data[i]["barnNumber"]);
							$(datatr).find("td[name='libraryId']").html(data[i]["libraryName"]);
							$(datatr).find("td[name='yieldTime']").html(data[i]["yieldTime"]);
							$(datatr).find("td[name='ogirin']").html(data[i]["orign"]);
                            $(datatr).find("td[name='restNumber']").html(data[i]["restNumber"]);
							$(datatr).find("td[name='rotateNumber']").html(data[i]["rotateNumber"]);
							$(datatr).find("td[name='realContainer']").html(data[i]["approvalCapacity"]);
							$(datatr).find("td[name='realStorage']").html(data[i]["realCapacity"]);
							$(datatr).find("td[name='planLevel']").html(data[i]["quality"]);
                            $(datatr).find("td[name='storeType']").html(data[i]["storeType"]);
							$(datatr).find("td[name='rotateType']").html(data[i]["rotateType"]);
                            $(datatr).find("td[name='qualityDetail']").html(data[i]["qualityDetail"]);
							$("#schemeDetail-data-list").append($(datatr));
							$(datatr).show();
						}
					}
				}else if(type == 'Scheme'){
					for(var i = 0;i<data.length;i++){
						if($("#scheme-type").val() == '出入库'||$("#scheme-type").val() == '年度轮换方案' || (data[i].schemeType == $("#scheme-type").val() && data[i].rotateType == $("#rotate-type").val())){
							var datatr = $("#soure-template").clone(true);
							$(datatr).attr("tag",data[i]["dId"]);
							$(datatr).find("td[name='foodType']").html(data[i]["foodType"]);
                            $(datatr).find("td[name='enterpriseName']").html(data[i]["enterpriseName"]);
							$(datatr).find("td[name='branNumber']").html(data[i]["branNumber"]);
							$(datatr).find("td[name='libraryId']").html(data[i]["libraryId"]);
							$(datatr).find("td[name='yieldTime']").html(data[i]["yieldTime"]);
							$(datatr).find("td[name='ogirin']").html(data[i]["ogirin"]);
							$(datatr).find("td[name='rotateNumber']").html(data[i]["rotateNumber"]);
							$(datatr).find("td[name='realContainer']").html(data[i]["realContainer"]);
							$(datatr).find("td[name='realStorage']").html(data[i]["realStorage"]);
							$(datatr).find("td[name='planLevel']").html(data[i]["planLevel"]);
                            $(datatr).find("td[name='storeType']").html(data[i]["storeType"]);
                            $(datatr).find("td[name='qualityDetail']").html(data[i]["qualityDetail"]);
							$(datatr).find("td[name='rotateType']").html(data[i]["schemeType"]);
							$("#schemeDetail-data-list").append($(datatr));
							$(datatr).show();
						}
					}
				}
			}
		});
		$("#float-alert1").slideToggle(500,function(){
			$("#table-wapper").slideToggle(500);			
		});
	});
	
	$(".remove-detail").click(function(){
		$(this).parent().parent().hide(500,function(){
			$(this).remove();
		})
	});
	
	$(".quality-detail").click(function(){
		var planId = $(this).parent().parent().attr("tag");
		var storehouse = $(this).parent().parent().find("[name='bran-number']").html();
        storehouse=$.trim(storehouse);
		$.ajax({
			url:"${ctx}/rotatePlan/GetQualityInfo.shtml",
			type:"post",
			data:{
				"planDetailid":planId,
				"storehouse":storehouse,
			},
			success:function(data){
				data = data.data;
				$("#schemeDetail-data-list2,#schemeDetail-data-list3").empty();
				if(data.In != null){
					var inData = typeof(data.In.qualityResultItems) != "undefined" ? data.In.qualityResultItems : data.In.qualityThirdItems;
					for(var i=0;i<inData.length;i++){
						var dataTamplate = $("#soure-template2").clone();
						$(dataTamplate).find("td[name='name']").html(inData[i].itemName);
						$(dataTamplate).find("td[name='level']").html(inData[i].grade);
						$(dataTamplate).find("td[name='stand']").html(inData[i].standard);
						$(dataTamplate).find("td[name='value']").html(inData[i].result);
						$(dataTamplate).find("td[name='commend']").html(inData[i].remark);
						$("#schemeDetail-data-list2").append(dataTamplate);
						$(dataTamplate).show();
					}
				}else{
					$("#schemeDetail-data-list2").append("<td colspan='5'>无对应数据</td>")
				}

				if(data.Out != null){
					var inData = typeof(data.Out.qualityResultItems) != "undefined" ? data.Out.qualityResultItems : data.Out.qualityThirdItems;
					for(var i=0;i<inData.length;i++){
						var dataTamplate = $("#soure-template3").clone();
						$(dataTamplate).find("td[name='name']").html(inData[i].itemName);
						$(dataTamplate).find("td[name='level']").html(inData[i].grade);
						$(dataTamplate).find("td[name='stand']").html(inData[i].standard);
						$(dataTamplate).find("td[name='value']").html(inData[i].result);
						$(dataTamplate).find("td[name='commend']").html(inData[i].remark);
						$("#schemeDetail-data-list3").append(dataTamplate);
						$(dataTamplate).show();
					}
				}else{
					$("#schemeDetail-data-list3").append("<td colspan='5'>无对应数据</td>")
				}
				$("#float-alert2").slideToggle(500,function(){
					$("#table-wapper2").slideToggle(500);			
				});
			}
		});
	});

	$("#close-float-alert2").click(function(){
		$("#table-wapper2").slideToggle(500,function(){
			$("#float-alert2").slideToggle(500);			
		});
	});
	
	$("#close-float-alert1").click(function(){
		$("#table-wapper").slideToggle(500,function(){
			$("#float-alert1").slideToggle(500,function(){
				$("#schemeDetail-data-list").find("tr").remove();
			});			
		});
	});
	//全选
    $("#checkAll").click(function () {
        if(this.checked){
            //$("#schemeDetail-data-list").find("input[type='checkbox']").prop("checked",true);
            $("#schemeDetail-data-list").find("tr:visible").find('input[type="checkbox"]').prop('checked',true)
        }else{
            $("#schemeDetail-data-list").find("input[type='checkbox']").prop("checked",false);
        }
    })
	$("#add-tolist").click(function(){
		var type = IsYearScheme()?"Scheme":"Plan";
		$("#schemeDetail-data-list").find("input[type='checkbox']:checked").each(function(){
			if($(this).prop("checked")){
				var trdata = $(this).parent().parent();
				/* if($(".data-tr[tag='"+$(trdata).attr("tag")+"']").length > 0)
					return; */
				var template = $("#template-tr").clone(true);
				$(template).attr("tag",$(trdata).attr("tag"));
                $(template).find("td[name='library-id']").html($(trdata).find("td[name='libraryId']").html());
                $(template).find("td[name='food-type']").html($(trdata).find("td[name='foodType']").html());
                $(template).find("td[name='enterpriseId']").html($(trdata).find("td[name='enterpriseId']").html());
                $(template).find("td[name='enterpriseName']").html($(trdata).find("td[name='enterpriseName']").html());
                $(template).find("td[name='yield-time']").html($(trdata).find("td[name='yieldTime']").html());
				$(template).find("td[name='ogirin']").html($(trdata).find("td[name='ogirin']").html());
				$(template).find("td[name='rotate-number']").find("input").val($(trdata).find("td[name='rotateNumber']").html());
				$(template).find("td[name='bran-number']").html($(trdata).find("td[name='branNumber']").html());
                $(template).find("td[name='storeType']").html($(trdata).find("td[name='storeType']").html());
				if($("#scheme-type").val()=="年度轮换方案"||"出入库" == $("#scheme-type").val()){
                    $(template).find("td[name='realContainer']").html($(trdata).find("td[name='realContainer']").html());	// 实际仓容
                    $(template).find("td[name='realStorage']").html($(trdata).find("td[name='realStorage']").html());	// 实际库存量
				}else if($(trdata).find("td[name='rotateType']").html()=="轮入"||$(trdata).find("td[name='rotateType']").html()=="入库"){
                    $(template).find("td[name='realContainer']").html($(trdata).find("td[name='realContainer']").html());	// 实际仓容
                    $(template).find("td[name='realStorage']").hide();	// 实际库存量
				}else{
                    $(template).find("td[name='realStorage']").html($(trdata).find("td[name='realStorage']").html());	// 实际库存量
                    $(template).find("td[name='realContainer']").hide();	// 实际仓容
				}
                if($("#scheme-type").val()=="入库"||"出库" == $("#scheme-type").val()||"出入库" ==$("#scheme-type").val()){
                    $(template).find("td[name='restNumber']").html($(trdata).find("td[name='restNumber']").html());	// 剩余计划数量
                }

                if($(trdata).find("td[name='rotateType']").html()=="轮入"||$(trdata).find("td[name='rotateType']").html()=="入库"){
                    $(template).find("td[name='qualityDetail']").find("textarea").val($(trdata).find("td[name='qualityDetail']").html());
                }else{
                    $(template).find("td[name='qualityDetail']").find("textarea").hide();

				}
				$(template).find("td[name='rotate-number']").find("input").attr("maxVal",$(trdata).find("td[name='rotateNumber']").html());
				debugger
				$.ajax({
					url:"${ctx}/RotateScheme/PlanTotalCount.shtml",
					data:{
						"pd_id":$(trdata).attr("tag")
					},
					type:"get",
					success:function(data){
					    debugger
						$(template).find("td[name='rotate-number']").find("input").attr("currentVal",data);
					}
				});
				$(template).find("td[name='planLevel']").html($(trdata).find("td[name='planLevel']").html());

				$(template).find("td[name='scheme-type']").html(type=='Plan'?($(trdata).find("td[name='rotateType']").html() == '轮出'?"出库":"入库"):$(trdata).find("td[name='rotateType']").html());
				$(template).addClass("data-tr");
				if($(trdata).find("td[name='rotateType']").html()=="轮入" || $(trdata).find("td[name='rotateType']").html()=="入库"){
                    $(template).find(".quality-detail").addClass("hide-field");
                }

				$("#data-result").append($(template));
				CheckDetailRotate($(template));
				$(template).show();
				
				$(template).find(".timeNeed").each(function(){
					laydate.render({
						elem:$(this)[0],
						type:"date",
						trigger: 'click',
						format:"yyyy-MM-dd"
					});
				});
				$(template).find(".yearNeed").each(function(){
					laydate.render({
						elem:$(this)[0],
						trigger: 'click',
						type:"year"
					});
				});
			}
		});
		$("#close-float-alert1").click();
	});
	
	$("#filter-Button").click(function(){
        var grainType = $("#filter-grainType").val();
        // var receivePlace = $("#filter-receivePlace").val();
        // var warehouse_type = $("#warehouse_type").val();
        var rotate_type = $("#rotate_type").val();
        var orign = $("#orign").val();
        var storeType = $("#storeType").val();
        // var warehouse_code = $("#warehouse_code").val();
        var yield_Time = $("#yield_Time").val();

        $("#schemeDetail-data-list").find("input[type='checkbox']").each(function() {
			$(this).parent().parent().show();
        });

		$("#schemeDetail-data-list").find("input[type='checkbox']").each(function(){

			var trdata = $(this).parent().parent();
			var tempgrain = $(trdata).find("td[name='foodType']").html();
			var tempreceive = $(trdata).find("td[name='libraryId']").html();
			// var tempWarehouseType = $(trdata).find("td[name='rotateType']").html();
            var tempRotateType = $(trdata).find("td[name='rotateType']").html();
            var tempOrign = $(trdata).find("td[name='ogirin']").html();
            var tempWarehouseCode = $(trdata).find("td[name='branNumber']").html();
            var tempYieldTime = $(trdata).find("td[name='yieldTime']").html();

			if(tempgrain.indexOf(grainType) == -1){
				$(trdata).hide();
				return;
			}
			// else if(tempreceive.indexOf(receivePlace) == -1){
			// 	$(trdata).hide();
			// 	return;
			// }
			else if(tempRotateType.indexOf(rotate_type) == -1){
                $(trdata).hide();
                return;
            }
			// else if(tempWarehouseType.index(warehouse_type) == -1){
            //     $(trdata).hide();
            //     return;
			// }

			else if(tempOrign.indexOf(orign) == -1){
                $(trdata).hide();
                return;
            }
			// else if(tempWarehouseCode.indexOf(warehouse_code) == -1){
            //     $(trdata).hide();
            //     return;
            // }
			else if(tempYieldTime.indexOf(yield_Time) == -1){
                $(trdata).hide();
                return;
            }
			$(trdata).show();
		});
	});
	
	$("#cancel").click(function(){
		layer.confirm('你确定要放弃编辑吗？', {
			btn: ['是','否']
		}, function(){
		  	window.location.href = "${ctx}/RotateScheme/List.shtml?view=create&type=ProviceUnit";
		}, function(){
		  
		});
	});

    function numberFixed(obj,op){
        number = $(obj).val();
        if(number==null ||number =="" ){
            return
        }
        number = parseFloat(number).toFixed(op);
        $(obj).val(number);
    }

    // 判断所有输入必须为正数
    $("input[type='number']").blur(function () {
		let number = Number($(this).val());
		if(number < 0){
		    layerMsgError("输入有误请重新输入");
		    $(this).val("");
		}
    });
</script>
<%@ include file="../common/AdminFooter.jsp" %>