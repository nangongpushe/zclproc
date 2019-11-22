<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp"%>
<style>
	#repairTable + .layui-form .layui-table-body td[data-field="repairDate"]{
		text-align: center;
	}
	#repairTable + .layui-form .layui-table-body td[data-field="projectName"]{
		text-align: left;
	}
	#repairTable + .layui-form .layui-table-body td[data-field="construction"]{
		text-align: left;
	}
	#repairTable + .layui-form .layui-table-body td[data-field="effect"]{
		text-align: left;
	}
	#repairTable + .layui-form .layui-table-body td[data-field="remark"]{
		text-align: left;
	}
</style>
<style type="text/css">
	.layui-form-label{
		text-align:right;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li>仓房管理</li>
		<li><a href="${ctx }/storageOilcan.shtml">油罐信息管理</a></li>
		<li class="activity">油罐信息表</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
	<form class="layui-form" id="oilcanData">
		<input name="id" value="${oilcan.id }" type="hidden">
		<div class="layui-row layui-col-space1">
			<div class="layui-col-md6">
				<label class="layui-form-label"><span class="red">*</span>所属库点：</label>
				<div class="layui-input-inline">
					<c:if test="${auvp eq 'a' }">
						<input lay-verify="required" class="layui-input" autocomplete="off" name="warehouse" readonly
														value="${user.shortName }" maxlength="50"/>
						<input type="hidden" name="warehouseCode" value="${user.originCode }">
						<input type="hidden" name="warehouseId" value="${user.wareHouseId }">
					</c:if>
					<c:if test="${auvp ne 'a' }">
						<input lay-verify="required" class="layui-input" autocomplete="off" name="warehouse" readonly
														value="${oilcan.warehouse }" maxlength="50"/>
						<input type="hidden" name="warehouseCode" value="${oilcan.warehouseCode }">
						<input type="hidden" name="warehouseId" value="${oilcan.warehouseId }">
					</c:if>
				</div>
			</div>
			<div class="layui-col-md6">
				<label class="layui-form-label"><span class="red">*</span>油罐编号：</label>
				<div class="layui-input-inline">
					<input lay-verify="required" class="layui-input" autocomplete="off"
						placeholder="--请输入--" name="oilcanSerial"
						value="${oilcan.oilcanSerial }" maxlength="20" onkeyup="this.value=this.value.toUpperCase()"/>
				</div>
			</div>
		<!-- </div>
		<div class="layui-row layui-col-space1"> -->
			<div class="layui-col-md6">
				<label class="layui-form-label"><span class="red">*</span>油罐类型：</label>
				<div class="layui-input-inline">
					<select lay-verify="required" name="oilcanType">
						<option value=""></option>
						<c:forEach items="${typeDict }" var="item">
							<option value="${item.value }"
								<c:if test="${oilcan.oilcanType eq item.value }">selected</c:if>>${item.value }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-col-md6">
				<label class="layui-form-label"><span class="red">*</span>油罐状态：</label>
				<div class="layui-input-inline">
					<select lay-verify="required" name="oilcanStatus">
						<option value=""></option>
						<c:forEach items="${statusDict }" var="item">
							<option value="${item.value }"
								<c:if test="${oilcan.oilcanStatus eq item.value }">selected</c:if>>${item.value }</option>
						</c:forEach>
					</select>
				</div>
			</div>
		<!-- </div>
		<div class="layui-row layui-col-space1"> -->
			
		
		<div class="layui-col-md6">
				<label class="layui-form-label"><span class="red"></span>油罐名称：</label>
				<div class="layui-input-inline">
					<input lay-verify="" class="layui-input" autocomplete="off"
						id="oilcanName" placeholder=""
						name="oilcanName" value="${oilcan.oilcanName }" maxlength="20" />
				</div>
			</div>
				<div class="layui-col-md6">
				<label class="layui-form-label"><span class="red">*</span>交付使用日期：</label>
				<div class="layui-input-inline">
				<input lay-verify="required" class="layui-input date-need" autocomplete="off" readonly
						id="deliverDateId" placeholder="&#45;&#45;请选择&#45;&#45;"
						name="deliverDate" value="${oilcan.deliverDate }" />
				</div>
				</div>
		</div>
		<!-- <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  			<legend>结构</legend>
		</fieldset> -->
		<div class="layui-row title">
			<h5>结构</h5>
		</div>
		<div class="layui-row layui-col-space1">
			<div class="layui-col-md6">
				<label class="layui-form-label">罐体：</label>
				<div class="layui-input-inline">
					<input lay-verify="" class="layui-input" autocomplete="off"
						placeholder="--请输入--" name="oilcanBody"
						value="${oilcan.oilcanBody }" maxlength="20"/>
				</div>
			</div>
			<div class="layui-col-md6">
				<label class="layui-form-label">灌顶：</label>
				<div class="layui-input-inline">
					<input lay-verify="" class="layui-input" autocomplete="off"
						placeholder="--请输入--" name="oilcanTop"
						value="${oilcan.oilcanTop }" maxlength="20"/>
				</div>
			</div>
		<!-- </div>
			<div class="layui-row layui-col-space1"> -->
				<div class="layui-col-md6">
					<label class="layui-form-label">地面：</label>
					<div class="layui-input-inline">
						<input lay-verify="" class="layui-input" autocomplete="off"
							placeholder="--请输入--" name="oilcanFloor"
							value="${oilcan.oilcanFloor }" maxlength="20"/>
					</div>
				</div>
				
					<div class="layui-col-md6">
						<label class="layui-form-label"><span class="red">*</span>设计容量(t)：</label>
						<div class="layui-input-inline">
							<input onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" maxlength="10" lay-verify="required|customNumber" class="layui-input"
								autocomplete="off" placeholder="--请输入--" name="designedCapacity"
								value="${oilcan.designedCapacity }"  onchange = "numberFixed(this,3)"  onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" />
						</div>
					</div>
				<!-- </div>
				<div class="layui-row layui-col-space1"> -->
					<div class="layui-col-md6">
						<label class="layui-form-label"><span class="red">*</span>核定容量(t）：</label>
						<div class="layui-input-inline">
							<input onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" maxlength="10" lay-verify="required|customNumber" class="layui-input"
								autocomplete="off" placeholder="--请输入--"
								name="authorizedCapacity" value="${oilcan.authorizedCapacity }" onchange = "numberFixed(this,3)" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" />
						</div>
					</div>
				</div>
				<!-- <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  					<legend>罐外</legend>
				</fieldset> -->
				<div class="layui-row title">
					<h5>罐外</h5>
				</div>
				<div class="layui-row layui-col-space1">
					<div class="layui-col-md6">
						<label class="layui-form-label"><span class="red">*</span>罐高(m)：</label>
						<div class="layui-input-inline">
							<input lay-verify="required" class="layui-input"
								autocomplete="off" placeholder="--请输入--" name="oilcanHeigh"
								value="${oilcan.oilcanHeigh }" maxlength="20" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
						</div>
					</div>
					<div class="layui-col-md6">
						<label class="layui-form-label"><span class="red">*</span>罐内径(m)：</label>
						<div class="layui-input-inline">
							<input lay-verify="required|customNumber" class="layui-input"
								autocomplete="off" placeholder="--请输入--"
								name="oilcanInnerDiameter"
								value="${oilcan.oilcanInnerDiameter }" maxlength="20" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
						</div>
					</div>
				<!-- </div>

				<div class="layui-row layui-col-space1"> -->
					<div class="layui-col-md6">
						<label class="layui-form-label"><span class="red">*</span>罐外径(m)：</label>
						<div class="layui-input-inline">
							<input lay-verify="required|customNumber" class="layui-input"
								autocomplete="off" placeholder="--请输入--"
								name="oilcanOuterDiameter"
								value="${oilcan.oilcanOuterDiameter }" maxlength="20" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
						</div>
					</div>

					<div class="layui-col-md6">
						<label class="layui-form-label"><span class="red">*</span>设计装油线高(m)：</label>
						<div class="layui-input-inline">
							<input lay-verify="required|customNumber" class="layui-input"
								autocomplete="off" placeholder="--请输入--" name="designedOilLine"
								value="${oilcan.designedOilLine }" maxlength="20" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
						</div>
					</div>
				<!-- </div>
				<div class="layui-row layui-col-space1"> -->
					<div class="layui-col-md6">
						<label class="layui-form-label"><span class="red">*</span>实际装油线高(m)：</label>
						<div class="layui-input-inline">
							<input lay-verify="required|customNumber" class="layui-input"
								autocomplete="off" placeholder="--请输入--"
								name="authorizedOilLine" value="${oilcan.authorizedOilLine }" maxlength="20" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
						</div>
					</div>
				</div>
				<!-- <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  					<legend>其他</legend>
				</fieldset> -->
				<div class="layui-row title">
					<h5>其他</h5>
				</div>
				<div class="layui-row layui-col-space1">
				<div class="layui-col-md6">
						<label class="layui-form-label"><span class="red"></span>油罐经度：</label>
						<div class="layui-input-inline">
							<input  class="layui-input"
								autocomplete="off" placeholder="--请输入--"
								name="longitude"
								value="${oilcan.longitude }" maxlength="20" type="number" step="0.00000000000000001"/>
						</div>
					</div>

					<div class="layui-col-md6">
						<label class="layui-form-label"><span class="red"></span>油罐维度：</label>
						<div class="layui-input-inline">
							<input  class="layui-input"
								autocomplete="off" placeholder="--请输入--" name="latitude"
								value="${oilcan.latitude }" maxlength="20" type="number" step="0.00000000000000001"/>
						</div>
					</div>
					<div class="layui-col-md6">
						<label class="layui-form-label">隔热措施：</label>
						<div class="layui-input-inline">
							<input lay-verify="" class="layui-input" autocomplete="off"
								placeholder="--请输入--" name="heatInsulation"
								value="${oilcan.heatInsulation }" maxlength="200" />
						</div>
					</div>
					<div class="layui-col-md6">
						<label class="layui-form-label" style="text-align:right">
							<span class="red">*</span>是否停用：</label>
						<div class="layui-input-inline">
							<select  lay-verify="required" id="isStop"
									 name="isStop">
								<option <c:if test="${oilcan.isStop == 'N'}">selected="selected"</c:if>   value="N">否</option>
								<option <c:if test="${oilcan.isStop == 'Y'}">selected="selected"</c:if>  value="Y">是</option>
							</select>
							<%--<select  lay-verify="required" id="isStop"
									 name="isStop">
								<c:if test="${oilcan.isStop == 'N'}"    >
									<option selected="selected" value="N">否</option>
								</c:if>
								<c:if test="${oilcan.isStop != 'N'}"    >
									<option  value="N">否</option>
								</c:if>
								<c:if test="${oilcan.isStop == 'Y'}"    >
									<option selected="selected" value="Y">是</option>
								</c:if>
								<c:if test="${oilcan.isStop != 'Y'}"    >
									<option  value="Y">是</option>
								</c:if>
							</select>--%>
						</div>
					</div>
				</div>
		
		<p name="prompt">
			备注：带有<span class=red>*</span>为必填项！
		</p>
		
		<%-- <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
		onclick="window.location.href='${ctx}/storageOilcan/addRepairPage.shtml?oilcanId=${oilcan.id }'">新建维修记录</button> --%>
		
		<table lay-filter="operation" id="repairTable"></table>
		<c:if test="${auvp eq 'u'}">
			<script type="text/html" id="operationColId">
            	<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
            	<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
        </script>
		</c:if>
	<p class="btn-box text-center">
			<button type="button" class="layui-btn layui-btn-primary layui-btn-small"
				onclick="cancelOperate('${auvp }', '${ctx}/storageOilcan.shtml')" name="cancelBtn">取消</button>
			<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="submitBtn" lay-submit lay-filter="submit_btn">保存</button>
		</p>
	</form>
</div>
<script src="${ctx}/js/app/storage/common.js"></script>
<script>
    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
        if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
            obj.value= parseFloat(obj.value);
        }
    }
    function checkAmounts(obj) {
        var reg = /[A-Za-z]+/;
        var optionNum = $(obj).val();
        if (reg.test(optionNum)) {
            alert("只能输入数字");
            $(obj).val("");
        }
    }
layui.use(['form','laydate'],function() {
	var form = layui.form,
	laydate = layui.laydate;
	
	//为需要date的input渲染日历
	$('.date-need').each(function(){
		laydate.render({
			elem: this,
			format : 'yyyy年MM月dd日'
		});
	});

    //自定义验证规则
    form.verify({
        //非零开头的最多带两位小数的数字
        customNumber: function(value){
            if(value.length!=0){
                if(!(/^\d+(\.\d+)?$/.test(value))){
                    return '只能输入大于0的数';
                }
            }
        }});
	
	form.render(); 
	
	form.on('submit(submit_btn)',function(){
		var oilcanData = JSON.stringify($('#oilcanData').serializeObject());
			//console.log(oilcanData);
		$.ajax({
			type : 'POST',
			url : '${ctx }/storageOilcan/save.shtml?auvp=${auvp}',
			dataType : "json",
			contentType : "application/json",
			data : oilcanData,
			error : function(request) {
				if (request.responseText) {
					layer.open({
						type : 1,
						area : [ '700px', '430px' ],
						fix : false,
						content : request.responseText
					});
				}
			},
			success : function(result) {
				if(result.success) {
					layer.msg(result.msg, {icon : 1, time : 1000}, function(){
						location.href = '${ctx }/storageOilcan.shtml';
					});
				} else {
					layer.msg(result.msg, {icon : 2, time : 1000});
				}	
			}
		});
	});
});

$(function() {
	var auvp = '${auvp}';
	if (auvp === 'u') {
		$('#submitBtn').text('保存更改');
		var table = layui.table;
		//执行渲染
		table.render({
			elem : '#repairTable',
			url : '${ctx}/storageOilcanRepair/list.shtml?oilcanId=${oilcan.id }',
			method : "POST",
			cols : [ [
				{
					field : 'repairDate',
					title : '日期',
					width : 200,
                    align:'center'
				},
				{
					field : 'projectName',
					title : '项目',
					width : 200,
                    align:'center'
				},
				{
					field : 'construction',
					title : '检查维修情况摘要',
					width : 300,
                    align:'center'
				},
				{
					field : 'effect',
					title : '效果',
					width : 300,
                    align:'center'
				},
				{
					field : 'remark',
					title : '记事',
					width : 500,
                    align:'center'
				},
				{
					fixed : 'right',
					width : 160,
					align : 'center',
					toolbar : '#operationColId',
					title : '操作'
				},
			] ], //设置表头
			request : {
				pageName : 'page',
				limitName : 'pageSize'
			},
			page : true, //开启分页
			limit : 10,
			id : 'repairTableId',
			done : function(res, curr, count) {},
		});
	} else if (auvp === 'v') {
		$('input').attr('disabled', 'disabled');
		$('.btn.dropdown-toggle').css('display', 'none');
		$('button[name=saveBtn]').css('display', 'none'); //保存按钮
		$('button[name=cancelBtn]').text('返回'); //取消按钮
		$('#submitBtn').css('display', 'none'); //提交按钮
		$('p[name=prompt]').css('display', 'none'); //备注文字
		var table = layui.table;
		//执行渲染
		table.render({
			elem : '#repairTable',
			url : '${ctx}/storageOilcanRepair/list.shtml?oilcanId=${oilcan.id }',
			method : "POST",
			cols : [ [
				{
					field : 'repairDate',
					title : '日期',
					width : 200
				},
				{
					field : 'projectName',
					title : '项目',
					width : 200
				},
				{
					field : 'construction',
					title : '检查维修情况摘要',
					width : 300
				},
				{
					field : 'effect',
					title : '效果',
					width : 300
				},
				{
					field : 'remark',
					title : '记事',
					width : 500
				},

			] ], //设置表头
			request : {
				pageName : 'page',
				limitName : 'pageSize'
			},
			page : true, //开启分页
			limit : 10,
			id : 'repairTableId',
			done : function(res, curr, count) {},
		});
	}
	//监听工具条
	table.on('tool(operation)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'del') {
			layer.confirm('确认删除吗？', function(index) {
				$.post("${ctx}/storageOilcanRepair/remove.shtml", {
					id : data.id
				}, function(result) {
					if (result.success) {
						obj.del();
					}
					layer.msg(result.msg, {
						time : 1000,
						icon : 1
					});
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/storageOilcanRepair/editPage.shtml?id="
			+ data.id;
		}
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
</script>