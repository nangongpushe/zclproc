<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
	#mainTable + .layui-form .layui-table-body td[data-field="serial"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="warehouse"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="storehouse"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="grainType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="realQuantity"]{
		text-align: right;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="drugName"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="fumigateType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="applyDrugTime"]{
		text-align: right;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="personNumber"]{
		text-align: right;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="circulationType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="totalCirculationStarttime"]{
		text-align: center;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="totalCirculationEndtime"]{
		text-align: center;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="releaseGasDate"]{
		text-align:center;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="releaseGasTime"]{
		text-align: right;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="storeMan"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="storeKeeper"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="reportTime"]{
		text-align: center;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="totalDrugSpace"]{
		text-align: right;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="totalDrugGrain"]{
		text-align: right;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>粮油情检测管理</li>
		<li class="active">熏蒸记录</li>
	</ol>
</div>

<div class="" id="self-cover-grain" style="">
	<div class="dialogsCont-" style="">
		<div class="grain-cont-detail"></div>
		<a class="cancalButtons" onclick="displayNone()" style="">返回</a>
	</div>
</div>
<style>
	#self-grain-cover {
		z-index: 20000000;
		opacity: 0.3;
		background-color: rgb(0, 0, 0);
		position: fixed;
		top: 0px;
		display: none;
		left: 0px;
		width: 100%;
		height: 100%;
	}
	.dialogsCont-{
		padding-top: 10px;
		padding: 0 15px 12px;
		pointer-events: auto;
		user-select: none;
		-webkit-user-select: none;
	}
	.cancalButtons{
		height: 28px;
		display: inline-block;
		line-height: 28px;
		margin: 5px 5px 0;
		padding: 0 15px;
		border: 1px solid #dedede;
		background-color: #fff;
		color: #333;
		position: absolute;
		border-radius: 2px;
		font-weight: 400;
		top: 0;
		right: 16px;
		cursor: pointer;
		text-decoration: none;
	}
	#self-cover-grain {
		z-index: 3;
		overflow: scroll;
		min-width: 260px;
		top: 0;
		margin: 0;
		width: 100%;
		height: 100%;
		padding: 0;
		display: none;
		background-color: #fff;
		position: fixed;
		-webkit-background-clip: content;
		border-radius: 2px;
		box-shadow: 1px 1px 50px rgba(0, 0, 0, .3);
	}
</style>
<script>
    //点击弹框取消按钮
    function displayNone() {
        $('#self-cover-grain').css({'display':'none'})
        $('#self-grain-cover').css({'display':'none'})
        $('.grain-cont-detail').html('')
        //searchReload()
    }
</script>

<div class="container-box clearfix" style="padding: 10px">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">库点:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="warehouse" lay-filter="warehouse" lay-search>
						<option value="">搜索选择</option>
						<%--<c:forEach var="item" items="${warehousesName}">
							<option value="${item}">${item}</option>
						</c:forEach>--%>
						<c:choose>
							<c:when test="${wareHouse==null}">
								<option value="${warehousesId}">${warehousesName}</option>
							</c:when>
							<c:otherwise>
								<c:forEach var="item" items="${wareHouse}">
									<option value="${item.id}"<c:if test="${item.warehouseShort eq warehousesName}">selected</c:if> >${item.warehouseShort}</option>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">仓号:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="storehouse" lay-filter="storehouse" lay-search
					data-bind="options:storehouses,optionsCaption:'搜索选择'">
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">粮食品种:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="grainType">
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${grainTypes}">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">熏蒸方式:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="fumigateType">
						<option value="">--请选择--</option>
						<option value="整仓">整仓</option>
						<option value="局部">局部</option>
						<option value="膜下">膜下</option>
						<option value="空间">空间</option>
						<option value="空仓">空仓</option>
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">环流方式:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="circulationType">
						<option value="">--请选择--</option>
						<option value="连续">连续</option>
						<option value="间断">间断</option>
					</select>
				</div>
			</div>
			
			<%--<div class="layui-inline">--%>
				<%--<label class="layui-form-label">熏蒸操作人:</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input class="layui-input" name="fumigateOperator" autocomplete="off" />--%>
				<%--</div>--%>
			<%--</div>--%>
			
			<div class="layui-inline">
				<label class="layui-form-label">上报日期:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="reportTime" autocomplete="off" />
				</div>
			</div>
			
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.queryPageList();}">查询</button>
				
			</div>
		</div>
	</div>

<shiro:hasPermission name="StorageFumigate:add">
	<button class="layui-btn layui-btn-primary layui-btn-small" id="add" data-bind="click:function(){$root.add();}">
		 新增
	</button>
</shiro:hasPermission>
<shiro:hasPermission name="StorageFumigate:export">
	<button class=" layui-btn layui-btn-primary layui-btn-small btn-operation" data-bind="click:function(){$root.batchExport();}">
	导出
	</button>
</shiro:hasPermission>
	<table class="layui-table" id="mainTable" lay-filter="table"></table>
	<script type="text/html" id="barDemo">
<shiro:hasPermission name="StorageFumigate:view">
		<a class="layui-btn layui-btn layui-btn-mini" lay-event="view">查看</a>
</shiro:hasPermission>
<shiro:hasPermission name="StorageFumigate:edit">
		<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="StorageFumigate:edit">
	    <a class="layui-btn layui-btn layui-btn-mini" lay-event="editadd">复制新增</a>
</shiro:hasPermission>
<shiro:hasPermission name="StorageFumigate:remove">
		<a class="layui-btn layui-btn layui-btn-mini" lay-event="remove">删除</a>
</shiro:hasPermission>
  	</script> 
	
</div>


<script src="../js/knockout-3.4.0.js"></script>

<script src="../js/app/storagefumigate/main.js"></script>
<script type="text/html" id="releaseGasDateFormat">
	{{Date_format(d.releaseGasDate,true)}}
</script>
<script type="text/html" id="reportTimeFormat">
	{{Date_format(d.reportTime,true)}}
</script>
<script>

	var vm = new Main();
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>