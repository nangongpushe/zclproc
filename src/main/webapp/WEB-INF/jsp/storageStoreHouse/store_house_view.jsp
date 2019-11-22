<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@include file="../common/AdminHeader.jsp"%>
<style>
    #optionTable + .layui-form .layui-table-body td[data-field="repairDateStr"]{
        text-align: center;
    }
    #optionTable + .layui-form .layui-table-body td[data-field="projectName"]{
        text-align: left;
    }
    #optionTable + .layui-form .layui-table-body td[data-field="construction"]{
        text-align: left;
    }
    #optionTable + .layui-form .layui-table-body td[data-field="remark"]{
        text-align: left;
    }
</style>
<c:if test="${flag!='dc' }">
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>仓房管理</li>
		<li class="active">仓房信息管理</li>
	</ol>
</div>
</c:if>
<c:if test="${flag=='dc' }">
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>代储监管</li>
		<li>企业信息</li>
		<li>仓房管理</li>
		
	</ol>
</div>
</c:if>
<input type="hidden" id="flag" value="${flag }">

<style type="text/css">
	.layui-form-label{
		text-align:right;
	}
</style>

<div class="container-box clearfix" style="padding: 10px">
		
		<input name="id" value="${storageStoreHouse.id }" type="hidden">
		<table class="table table-bordered" lay-filter="test">
		 <!-- 表格内容 start -->
            <tbody>
            <tr>
                <td class="text-right">所属库点:</td>
                <td>${storageStoreHouse.warehouse }
                </td>
                <td  class="text-right">库点代码:</td>
                <td >${storageStoreHouse.warehouseCode }
                </td>              
            </tr>
            <tr>
                <td class="text-right">仓房名称:</td>
                <td>${storageStoreHouse.storehouseName }
                </td>
                <td  class="text-right">仓房编号:</td>
                <td >${storageStoreHouse.encode }
                </td>              
            </tr>
            <tr>
                <td class="text-right"><b>仓房类型:</b></td>
                <td>${storageStoreHouse.type }
                </td>
                <td  class="text-right"><b>仓房状态:</b></td>
                <td >${storageStoreHouse.status }
                </td>              
            </tr>
            <tr>
                <td class="text-right"><b>启用日期:</b></td>
                <td>${storageStoreHouse.enableDate }
                </td>
                <td  class="text-right"><b>结构:</b></td>
                <td >${storageStoreHouse.structure }
                </td>              
            </tr>
            <tr>
                <td class="text-right"><b>堆粮线高（米）:</b></td>
                <td>${storageStoreHouse.bulkHeight }
                </td>
                <td  class="text-right"><b>仓门数量（扇）:</b></td>
                <td >${storageStoreHouse.gateNum }
                </td>              
            </tr>
            <tr>
                <td class="text-right"><b>建筑面积（长*宽）（㎡）:</b></td>
                <td>${storageStoreHouse.cfa }
				</td>
                <td  class="text-right"><b>筒仓外径(m):</b></td>
                <td >${storageStoreHouse.siloDiameter }</td>              
            </tr>
            <tr>
                <td class="text-right"><span class="red"></span><b>筒仓内径(m):</b></td>
                <td>${storageStoreHouse.siloBore }
				</td>
                <td  class="text-right"><b>筒仓体积(m³):</b></td>
                <td >${storageStoreHouse.siloVolume }
				</td>              
            </tr>
            <tr>
                <td class="text-right"><b>仓门高度(m):</b></td>
                <td>${storageStoreHouse.gateHeight }
				</td>
                <td  class="text-right"><b>仓门宽度(m):</b></td>
                <td >${storageStoreHouse.gateWidth }
				</td>              
            </tr>
            <tr>
                <td class="text-right"><b>檐高(m):</b></td>
                <td>${storageStoreHouse.eavesHeight }
				</td>
                <td  class="text-right"><b>设计容量(t):</b></td>
                <td >${storageStoreHouse.designedCapacity }</td>              
            </tr>
            <tr>
                <td class="text-right"><b>核定容量(t):</b></td>
                <td>${storageStoreHouse.authorizedCapacity }</td>
                <td  class="text-right"><b>粮堆面积（长*宽）（㎡）:</b></td>
                <td >${storageStoreHouse.bulkArea }</td>              
            </tr>
            <tr>
                <td class="text-right"><b>通风口数量（个）:</b></td>
                <td>${storageStoreHouse.ventNum }</td>
                <td  class="text-right"><b>风道类型:</b></td>
                <td >${storageStoreHouse.ductType }</td>              
            </tr>
            <tr>
                <td class="text-right"><b>实仓气密性（S）:</b></td>
                <td>${storageStoreHouse.siloTightness }</td>
                <td  class="text-right"><b>轴流风机数（台）:</b></td>
                <td >${storageStoreHouse.axialNum }</td>              
            </tr>
            
            <tr>
                <td class="text-right"><b>存放类型:</b></td>
                <td>${storageStoreHouse.storeType }</td>
                <td  class="text-right"><b>保管员:</b></td>
                <td >${storageStoreHouse.keeper }</td>              
            </tr>
            <tr>
                <td class="text-right"><b>仓房经度:</b></td>
                <td>${storageStoreHouse.longitude }</td>
                <td  class="text-right"><b>仓房纬度:</b></td>
                <td >${storageStoreHouse.latitude }</td>              
            </tr>
            <tr>
                
                <td  class="text-right"><b>建筑类型:</b></td>
                <td >${storageStoreHouse.buildingType }</td>  
	        	<td class="text-right"><b>仓房高度(m):</b></td>
                <td>${storageStoreHouse.height }</td>            
            </tr>
            <tr>
                <td class="text-right"><b>仓房长度（直径）(m):</b></td>
                <td>${storageStoreHouse.length }</td>
                <td  class="text-right"><span class="red"></span><b>仓房宽度(m):</b></td>
                <td >${storageStoreHouse.width }</td>              
            </tr>
            <tr>
                
                <td class="text-right"><b>注释信息:</b></td>
                <td>
                    <textarea rows="4" name="remark" readonly class="form-control" placeholder="" maxlength="200"  style="resize:none" >${storageStoreHouse.remark }</textarea>
                </td>
                <td class="text-right"><b>隔热措施:</b></td>
                <td >
                    <textarea rows="4" name="heatInsulation" readonly class="form-control" placeholder="" maxlength="200"  style="resize:none" >${storageStoreHouse.heatInsulation }</textarea>
                </td>
                          
            </tr>
            <tr>
                <td class="text-right"><b>是否停用:</b></td>
                <td>
                    <c:if test="${storageStoreHouse.isStop=='N'}">否</c:if>
                    <c:if test="${storageStoreHouse.isStop=='Y'}">是</c:if>
                </td>
                <td class="text-right"><b>排序号:</b></td>
                <td>${storageStoreHouse.orderNo }</td>
            </tr>
            
            </tbody>
         <!-- 表格内容 end -->
		</table>
<!-- --------------------------------------------------------------------------------------------------------------------------------- -->		
       <%--  <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6">
        		<span>所属库点：</span>
        		<span>${storageStoreHouse.warehouse }</span>
        	</div>
        	<div class="layui-col-md6">
        		<span>仓房编号：</span>
	        	<span>${storageStoreHouse.encode }</span>
        	</div>
        </div>
        <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6">
	        	<span>仓房类型：</span>
	        	<span>${storageStoreHouse.type }</span>
	        </div>
			<div class="layui-col-md6">
				<span>仓房状态：</span>
				<span>${storageStoreHouse.status }</span>
			</div>
        </div>
        <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6">
	        	<span>启用日期：</span>
	        	<div class="layui-input-inline">
	        		<span>${storageStoreHouse.enableDate }</span>
				</div>
			</div>
			<div class="layui-col-md6">
				<span>结构：</span>
	        	<div class="layui-input-inline">
	        		<span>${storageStoreHouse.structure }</span>
				</div>
			</div>
        </div>
        
        <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6">
	        	<span>粮堆线高（米）：</span>
	        	<span>${storageStoreHouse.bulkHeight }</span>
			</div>
			<div class="layui-col-md6">
				<span>仓门数量（扇）：</span>
				<span>${storageStoreHouse.gateNum }</span>
			</div>
        </div>
        <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6">
	        	<span>建筑面积（长*宽）（㎡）：</span>
	        	<span>${storageStoreHouse.cfa }</span>
			</div>
			<div class="layui-col-md6">    
				<span>筒仓外径：</span>
				<span>${storageStoreHouse.siloDiameter }</span>
			</div>   	
        </div>
        <div class="layui-row layui-col-space1">
       		<div class="layui-col-md6"> 
	        	<span>筒仓内径：</span>
	        	<span>${storageStoreHouse.siloBore }</span>
			</div>
			<div class="layui-col-md6">  
				<span>筒仓体积：</span>
				<span>${storageStoreHouse.siloVolume }</span>
			</div>
        </div>
        <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6"> 
	        	<span>仓门高度：</span>
	        	<span>${storageStoreHouse.gateHeight }</span>
			</div>
			<div class="layui-col-md6"> 
				<span>仓门宽度：</span>
				<span>${storageStoreHouse.gateWidth }</span>
			</div>
        </div>
        <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6"> 
	        	<span>檐高：</span>
	        	<span>${storageStoreHouse.eavesHeight }</span>
			</div>
			<div class="layui-col-md6"> 
				<span>设计容量：</span>
				<span>${storageStoreHouse.designedCapacity }</span>
			</div>
        </div>
        <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6"> 
	        	<span>核定容量：</span>
	        	<span>${storageStoreHouse.authorizedCapacity }</span>
			</div>
			<div class="layui-col-md6"> 
				<span>粮堆面积（长*宽）（㎡）：</span>
				<span>${storageStoreHouse.bulkArea }</span>
			</div>
        </div>
        <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6"> 
	        	<span>通风口数量（个）：</span>
	        	<span>${storageStoreHouse.ventNum }</span>
			</div>
			<div class="layui-col-md6">
				<span>风道类型：</span>
				<span>${storageStoreHouse.ductType }</span>
			</div>
        </div>
        <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6"> 
	        	<span>实仓气密性（S）：</span>
	        	<span>${storageStoreHouse.siloTightness }</span>
			</div>
			<div class="layui-col-md6"> 
				<span>轴流风机数（台）：</span>
				<span>${storageStoreHouse.axialNum }</span>
			</div>
        </div>
        <div class="layui-row layui-col-space1">
        	<div class="layui-col-md6"> 
	        	<span>隔热措施：</span>
	        	<span>${storageStoreHouse.heatInsulation }</span>
			</div>
        </div>
         --%>
        <table lay-filter="operation" id="optionTable"></table>
        <p class="btn-box text-center">
        	<button type="reset" class="layui-btn layui-btn-primary layui-btn-small" name="cancelBtn"
        		onclick="cancelOperate('${auvp }', '${ctx}/storageStoreHouse.shtml?flag=${flag}')">返回</button>
    	</p>
</div>

<script src="${ctx}/js/app/storage/common.js"></script>

<script>
layui.use(['table'],function() {
	var table = layui.table;
	var auvp = '${auvp}';
	if (auvp === 'v') {
		
		$('input').attr('disabled','disabled');
		$('select').attr('disabled','disabled');
		
		table.render({
		    elem : '#optionTable',
		    url : '${ctx}/storageStoreHouseOption/list.shtml?storehouseId=${storageStoreHouse.id }',
		    method : "POST",
		    cols : [[
		        /* {field : 'storehouseId',title: '仓房ID',width:300}, */
		        {field : 'repairDateStr',title : '维修保养日期',width:200, align: 'center'},
		        {field : 'projectName',title : '项目名称',width:300, align: 'center'},
		        {field : 'construction',title : '施工验收情况',width:300, align: 'center'},
		        {field : 'remark',title : '备注（单击可查看全部内容）',width:500, align: 'center'},
		    ]],//设置表头
		    request : {
		        pageName : 'page', 
		        limitName : 'pageSize'
		    },
		    page:true,//开启分页
		    limit:10,
		    id:'optionTableId',
		    done:function(res,curr,count){
		    },
		});
	}
});
</script>