	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>

<style>
	#myTable + .layui-form .layui-table-body td[data-field="payUnit"]{
		text-align: left;
	}
	#myTable + .layui-form .layui-table-body td[data-field="status"]{
		text-align: left;
	}
	#myTable + .layui-form .layui-table-body td[data-field="claimStatus"]{
		text-align: left;
	}
	#myTable + .layui-form .layui-table-body td[data-field="reporter"]{
		text-align: left;
	}
	#myTable + .layui-form .layui-table-body td[data-field="arriveAmount"]{
		text-align: right;
	}
	#myTable + .layui-form .layui-table-body td[data-field="balance"]{
		text-align: right;
	}
	#myTable + .layui-form .layui-table-body td[data-field="payer"]{
		text-align: left;
	}
</style>


<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>货款管理</li>
		<li class="active">货款到账单</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px" id="rotatearrive_main">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<%--<div class="layui-inline">--%>
				<%--<label class="layui-form-label">收款日期:</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input class="layui-input" name="arriveDate" autocomplete="off">--%>
				<%--</div>--%>
			<%--</div>--%>
			<div class="layui-inline">
				<label class="layui-form-label">收款日期:</label>
				<div class="layui-input-inline" style="width: 100px;">
					<input class="layui-input"  name="beginArriveDate" autocomplete="off">
				</div>
				<div class="layui-form-mid">-</div>
				<div class="layui-input-inline" style="width: 100px;">
					<input class="layui-input" name="endArriveDate" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">状态:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="status" lay-filter="status"
						id="inviteType">
						<option></option>
						<option value="待提交">待提交</option>
						<option value="审核中(财务经理)">审核中(财务经理)</option>
						<option value="已通过">已通过</option>
						<option value="已驳回">已驳回</option>
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">货款状态:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="claimStatus" lay-filter="claimStatus"
						id="inviteType">
						<option></option>
						<option>未完成</option>
						<option>已完成</option>
					</select>
				</div>
			</div><br/>
            <div class="layui-inline">
                <label class="layui-form-label">付款人:</label>
                <div class="layui-input-inline">
                    <input class="layui-form layui-input" placeholder="" autocomplete="off" name="payer">
                </div>
            </div>
			<div class="layui-inline">
				<label class="layui-form-label">付款单位:</label>
				<div class="layui-input-inline">
					<input class="layui-form layui-input" placeholder="" autocomplete="off" name="payUnit">
				</div>
			</div>

			<%--<div class="layui-inline">--%>
				<%--<label class="layui-form-label">填报单位:</label>--%>
				<%--<div class="layui-input-inline">--%>
					<%--<input class="layui-form layui-input" placeholder="" autocomplete="off" name="reporter">--%>
				<%--</div>--%>
			<%--</div>--%>
			<div class="layui-inline">
				<label class="layui-form-label">金额:</label>
				<div class="layui-input-inline" style="width: 100px;">
					<input type="number" name="minArriveAmount"  placeholder="" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid">-</div>
				<div class="layui-input-inline" style="width: 100px;">
					<input type="number" name="maxArriveAmount" placeholder="" autocomplete="off" class="layui-input">
				</div>
			</div><br/>
			<div class="layui-inline">
				<label class="layui-form-label">未认领金额:</label>
				<div class="layui-input-inline" style="width: 100px;">
					<input type="number" name="minBalance" placeholder="" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid">-</div>
				<div class="layui-input-inline" style="width: 100px;">
					<input type="number" name="maxBalance" placeholder="" autocomplete="off" class="layui-input">
				</div>
			</div>
			
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.reloadTable();}">查询</button>
			</div>
            <div class="layui-inline">
                <input type="button" class="layui-btn layui-btn-primary layui-btn-small" id="clearAll" value="清空"/>
            </div>
		</div>
	</div>

	<shiro:hasPermission name="RotateArrive:add">
	<button class=" layui-btn layui-btn-primary layui-btn-small" id="add" data-bind="click:function(){$root.add();}">
		<i class="layui-icon">&#xe608;</i> 新增
	</button>
	</shiro:hasPermission>
	<table class="layui-table" lay-filter="table" id="myTable"></table>
	<script type="text/html" id="barDemo">

			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="view">查看</a>
			
			{{#  if(d.status == "待提交" || d.status == "已驳回" || d.status == "已退回"){ }}
			<shiro:hasPermission name="RotateArrive:submit">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="submit" >提交</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="RotateArrive:edit">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit" >编辑</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="RotateArrive:remove">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="remove" >删除</a>
			</shiro:hasPermission>
			{{#  } }}
			{{#  if(d.status ==  "审核中(财务经理)"){ }}
			<shiro:hasPermission name="RotateArrive:audit">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="audit" >审核</a>
			</shiro:hasPermission>
			{{#  } }}

			{{#  if(d.status ==  "审核中(财务总监)"){ }}
			<shiro:hasPermission name="RotateArrive:auditAll">
				<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="audit" >审核</a>
			</shiro:hasPermission>
			{{#  } }}			
  	</script>
  	
	
	<!-- 认领情况列表 -->
	<div class="modal fade" id="outModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog modal-lg" style="width:1250px">
			<div class="modal-content" >
				<div class="modal-header">
				<h4 class="modal-title">认领明细</h4>
				</div>
				<div class="modal-body">
					<table class="layui-table" lay-filter="table1" id="myTable1"></table>
				</div>
				<div class="modal-footer">
					
					<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal">取消</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	
	<!-- 审核列表 -->
	<div class="modal fade" id="outModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog modal-lg" style="width:1250px">
			<div class="modal-content" >
				<div class="modal-header">
				<h4 class="modal-title">认领明细</h4>
				</div>
				<div class="modal-body">
					<table class="layui-table" lay-filter="table1" id="myTable1"></table>
				</div>
				<div class="modal-footer">
					
					<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal">取消</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</div>


<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatearrive/rotatearrive_main.js"></script>
<script type="text/html" id="reportDateFormat">
	{{Date_format(d.reportDate,true)}}
</script>
<script type="text/html" id="arriveDateFormat">
	{{Date_format(d.arriveDate,true)}}
</script>
<script type="text/html" id="approvalDateFormat">
	{{Date_format(d.approvalDate,true)}}
</script>
<%--<script type="text/html" id="beginArriveDateFormat">--%>
	<%--{{Date_format(d.beginArriveDate,true)}}--%>
<%--</script>--%>
<%--<script type="text/html" id="endArriveDateFormat">--%>
	<%--{{Date_format(d.endArriveDate,true)}}--%>
<%--</script>--%>
<script type="text/html" id="claimOfArrive">
{{# if(d.status == '已通过'){ }}
  <a href="javascript:void(0);" data-id="{{d.id}}" class="layui-table-link claimOfArrive" title="查看认领情况">{{d.claimStatus}}</a>
{{#  } else { }}
    {{d.claimStatus}}
  {{#  } }}
</script>
<script type="text/html" id="auditHistory">
  <a href="javascript:void(0);" data-id="{{d.id}}" class="layui-table-link auditHistory" tilte="查看审核记录">{{d.status}}</a>
</script>
<script>
	$(function () {
		$("#clearAll").click(function () {
		    $("input[name='beginArriveDate']").val("");
            $("input[name='endArriveDate']").val("");

            $("select[name='status'] option:selected").attr("selected",false);
            $("select[name='status']").eq(0).attr("selected",true);

            $("select[name='claimStatus'] option:selected").attr("selected",false);
            $("select[name='claimStatus']").eq(0).attr("selected",true);

            $("input[name='payUnit']").val("");
            $("input[name='minArriveAmount']").val("");
            $("input[name='maxArriveAmount']").val("");
            $("input[name='minBalance']").val("");
            $("input[name='maxBalance']").val("");
            $("input[name='payer']").val("");

            layui.form.render();
        });
    });
	var vm = new RotateArrive_Main();
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();



	function Format(datetime,fmt) {
		if(datetime == null){
			return "";
		}
		if (parseInt(datetime)==datetime) {
			if (datetime.length==10) {
				datetime=parseInt(datetime)*1000;
			} else if(datetime.length==13) {
				datetime=parseInt(datetime);
			}
		}
		datetime=new Date(datetime);
		var o = {
			"M+" : datetime.getMonth()+1,                 //月份
			"d+" : datetime.getDate(),                    //日
			"h+" : datetime.getHours(),                   //小时
			"m+" : datetime.getMinutes(),                 //分
			"s+" : datetime.getSeconds(),                 //秒
			"q+" : Math.floor((datetime.getMonth()+3)/3), //季度
			"S"  : datetime.getMilliseconds()             //毫秒
		};
		if(/(y+)/.test(fmt))
			fmt=fmt.replace(RegExp.$1, (datetime.getFullYear()+"").substr(4 - RegExp.$1.length));
		for(var k in o)
			if(new RegExp("("+ k +")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
		return fmt;
	}
</script>
<%@include file="../common/AdminFooter.jsp"%>