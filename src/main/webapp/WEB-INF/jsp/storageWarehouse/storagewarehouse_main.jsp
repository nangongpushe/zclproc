<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/AdminHeader.jsp"%>
<style>
	#wareHouseTable + .layui-form .layui-table-body td[data-field="enterpriseName"]{
		text-align: left;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="warehouseCode"]{
		text-align: left;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="warehouseName"]{
		text-align: left;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="warehouseShort"]{
		text-align: left;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="warehouseNature"]{
		text-align: left;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="warehouseType"]{
		text-align: left;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="completionDate"]{
		text-align: center;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="storageCapacity"]{
		text-align: right;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="acreage"]{
		text-align: right;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="telphone"]{
		text-align: right;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="province"]{
		 text-align: left;
	 }
	#wareHouseTable + .layui-form .layui-table-body td[data-field="city"]{
		text-align: left;
	}
	#wareHouseTable + .layui-form .layui-table-body td[data-field="area"]{
		text-align: left;
	}

	#enterpriseTable2 + .layui-form .layui-table-body td[data-field="enterpriseSerial"]{
		text-align: left;
	}
	#enterpriseTable2 + .layui-form .layui-table-body td[data-field="enterpriseName"]{
		text-align: left;
	}
	#enterpriseTable2 + .layui-form .layui-table-body td[data-field="socialCreditCode"]{
		text-align: left;
	}
	#enterpriseTable2 + .layui-form .layui-table-body td[data-field="province"]{
		text-align: left;
	}
	#enterpriseTable2 + .layui-form .layui-table-body td[data-field="city"]{
		text-align: left;
	}
	#enterpriseTable2 + .layui-form .layui-table-body td[data-field="area"]{
		text-align: left;
	}
	#enterpriseTable2 + .layui-form .layui-table-body td[data-field="personIncharge"]{
		text-align: left;
	}
	#enterpriseTable2 + .layui-form .layui-table-body td[data-field="telephone"]{
		text-align: right;
	}

</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<c:choose>
			<c:when test="${type eq 'dc'}">
				<li>代储管理</li>
				<li>企业信息</li>
				<li class="active">库点管理</li></c:when>
			<c:otherwise>
				<li>仓储管理</li>
				<li class="active">库点管理</li></c:otherwise>
		</c:choose>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
	<!-- <div class="layui-form" id="search">	 -->
	<div id="search"  lay-filter="search">
		<div class="layui-form-item" >
			<c:if test="${type eq 'dc'}">
			<div class="layui-inline">
				<label class="layui-form-label">企业名称：</label>
				<%--<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="enterpriseName" name="enterpriseName">
				</div>--%>
				<div class="layui-input-inline">
				<%--<select class="layui-input" lay-verify="required" class="form-control"  name="enterpriseId" id="enterpriseId" lay-search lay-filter="enterpriseId">
					<option value="">--搜索选择--</option>
					<c:forEach items="${enterprises}" var="enterprise">
						<option value="${enterprise.id}" >${enterprise.enterpriseName}</option>
					</c:forEach>
				</select>--%>
					<input type="hidden" name="enterpriseId" id="enterpriseId">
					<input class="layui-input" autocomplete="off" readonly id="enterpriseName"
						   placeholder="请选择公司..." onclick="addActiveClass(this)"/>
				</div>
			</div>
				<div class="layui-inline">
					<label class="layui-form-label">是否主库：</label>
						<%--<div class="layui-input-inline">
                            <input class="layui-input" autocomplete="off" id="enterpriseName" name="enterpriseName">
                        </div>--%>
					<div class="layui-input-inline">
					<select lay-verify="required" class="form-control"  name="ishost" id="ishost" lay-search lay-filter="ishost">
						<option value="">--全部--</option>
						<option value="Y" >是</option>
						<option value="N" >否</option>
					</select>
					</div>
				</div>


			</c:if>

			<div class="layui-inline">
				<label class="layui-form-label">库点名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="name" name="name">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label">库点简称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="shortName" name="shortName">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="width:200px">企业行政区划：</label>
				<div id="distpicker" class="form-inline" style="width:500px">
					<select class="form-control  pull-left change-filter" style="width: 100px" id="province" name="province"></select>
					<select class="form-control  pull-left change-filter" style="width: 100px" id="city" name="city"></select>
					<select class="form-control  pull-left change-filter" style="width: 100px" id="district" name="area"></select>
			    </div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">是否停用：</label>
				<%--<div class="layui-input-inline">
                    <input class="layui-input" autocomplete="off" id="enterpriseName" name="enterpriseName">
                </div>--%>
				<div class="layui-input-inline">
					<select lay-verify="required" class="form-control"  name="isstop" id="isstop" lay-search lay-filter="isstop">
						<option value="">--全部--</option>
						<option value="Y" >是</option>
						<option value="N" >否</option>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBt">查询</button>
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="cleanBt">清空</button>
			</div>
		</div>
	</div>
	<div class="manage">
	<br>
	<shiro:hasPermission name="StorageWarehouse:add${type }">
		<button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="window.location.href='${ctx }/storageWarehouse/addPage.shtml?auvp=a&type=${type }'">新增</button>
	</shiro:hasPermission>
		<table lay-filter="operation" id="wareHouseTable"></table>
		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
			<shiro:hasPermission name="StorageWarehouse:edit${type}">
  			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="StorageWarehouse:del${type}">
  			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
			</shiro:hasPermission>
		</script>
	</div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:800px;">
		<div class="modal-content">
			<div class="modal-header"><!-- data-dismiss="modal"  -->
				<button type="button" class="close" aria-hidden="true" onclick="removeActiveClass()">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					选择库点
				</h4>
			</div>
			<div class="modal-body">
				<div class="layui-form" id="search1">
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">企业编号：</label>
							<div class="layui-input-inline">
								<input class="layui-input" autocomplete="off" id="enterpriseSerial" name="enterpriseSerial">
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">企业名称：</label>
							<div class="layui-input-inline">
								<input class="layui-input" autocomplete="off" id="enterpriseName1" name="enterpriseName">
							</div>
						</div>
						<div class="layui-inline">
							<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="enterpriseSearch">查询</button>
						</div>
					</div>
				</div>
				<table lay-filter="operation1" id="enterpriseTable2"></table>
				<script type="text/html" id="bar">
					<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="choose">选择</a>
				</script>
			</div>
			<div class="modal-footer">
				<button type="button" class="layui-btn layui-btn-primary layui-btn-small"
						onclick="removeActiveClass()">关闭
				</button>
			</div>
		</div>
	</div>

</div>
<script src="${ctx }/js/cities.data.js"></script>
<script>//省市级联动
$('#distpicker').distpicker({
	autoSelect: false
});
//layui.form.render('select','search');
/*layui.use(['table'], function() {
    var table = layui.table;
    table.render({
        elem : '#enterpriseTable',
        url : '${ctx}/reportMonth/kudianPageQuery.shtml',
        method : "POST",
        cols : [[
            {fixed : 'left', title : '操作', width : 100, align : 'center', toolbar : '#bar'},
            {field : 'warehouseName',title : '库点名称',width:150},
            {field : 'warehouseShort',title : '库点简称',width:150},
            {field : 'enterpriseName',title : '所属企业名称(代储库点用)',width:200}
        ]],//设置表头
        request : {
            pageName : 'page',
            limitName : 'pageSize'
        },
        page:true,//开启分页
        limit:10,
        id:'enterpriseTableId1',
        done:function(res,curr,count){
        },
    });

    //搜索
    $('#enterpriseSearch').click(function() {
        table.reload("enterpriseTableId1", {
            method: 'post', //如果无需自定义HTTP类型，可不加该参数
            where : {
                warehouseName : $('#search #warehouseName').val()
            }
        });
    });

    table.on('tool(operation1)', function(obj) {
        var data = obj.data;
        if (obj.event === 'choose') {
            var warehouseShort = data.warehouseShort;

            $('#reportWarehouse').val(warehouseShort);
            $('#reportWarehouseId').val(data.id);

            $('#reportWarehouse').change();
        }
        $('#myModal0').modal('hide');
    });
    //监听FORM结束

});*/
//代储表格渲染方法
function dcTableRender(table) {
	table.render({
		elem: '#wareHouseTable',
		url: '${ctx}/storageWarehouse/list.shtml?type=dc',
		method : "POST",
		cols: [[{
			field: 'enterpriseName',
			title: '所属企业名称',
			width: 160,
            align:'center'
		},
            {
                field: 'orderNo',
                title: '排序号',
                width: 160,
                align:'center'
            },
		{
			field: 'warehouseCode',
			title: '库点代码',
			width: 100,
            align:'center'
		},
		{
			field: 'warehouseName',
			title: '库点名称',
			width: 100,
            align:'center'
		},
		{
			field: 'warehouseShort',
			title: '库点简称',
			width: 100,
            align:'center'
		},
		{
			field: 'warehouseType',
			title: '库点类别',
			width: 100,
            align:'center'
		},

		{
			field: 'isStop',
			title: '是否停用',
			width: 150,
            align:'center'
		},
		{
			field: 'province',
			title: '省',
			width: 150,
			align:'center'
		},
		{
			field: 'city',
			title: '市',
			width: 150,
			align:'center'
		}, {
			field: 'area',
			title: '区',
			width: 150,
            align:'center'
		},
		{
			fixed: 'right',
			title: '操作',
			width: 200,
			align: 'center',
			toolbar: '#barDemo'
		},
		]],
		//设置表头
		request: {
			pageName: 'page',
			limitName: 'pageSize'
		},
		page: true,
		//开启分页
		limit: 10,
		id: 'wareHouseTableId',
		done: function(res, curr, count) {
            $("[data-field='isStop']").children().each(function(){
                if($(this).text()=='Y'){
                    $(this).text("是")
                }else if($(this).text()=='N'){
                    $(this).text("否")
                }
            })
		},
	});
}
function dcTableRender1(table) {
    table.render({
        elem : '#enterpriseTable2',
        url : '${ctx}/StoreEnterprise/list.shtml',
        method : "POST",
        cols : [[
            /* 			{checkbox : true}, */
            {fixed : 'left', title : '操作', width : 100, align : 'center', toolbar : '#bar'},
            {field : 'enterpriseSerial',title : '企业编号',width:150,align:'center'},
            {field : 'enterpriseName',title : '企业名称',width:150,align:'center'},
            {field : 'socialCreditCode',title : '统一社会信用代码',width:100,align:'center'},
            {field : 'province',title : '行政区划省',width:100,align:'center'},
            {field : 'city',title : '行政区划市',width:100,align:'center'},
            {field : 'area',title : '行政区划区',width:100,align:'center'},
            {field : 'personIncharge',title : '法人代表',width:100,align:'center'},
            {field : 'telephone', title : '联系电话', width:150,align:'center'},
        ]],//设置表头
        request : {
            pageName : 'page',
            limitName : 'pageSize'
        },
        page:true,//开启分页
        limit:10,
        id:'enterpriseTableId2',
        done:function(res,curr,count){
        },
    });

}
//仓储表格渲染方法
function ccTableRender() {
	table.render({
		elem: '#wareHouseTable',
		url: '${ctx}/storageWarehouse/list.shtml?type=cc',
		method : "POST",
		cols: [[{
			field: 'warehouseCode',
			title: '库点代码',
			width: 100,
            align:'center'
		},
		{
			field: 'warehouseName',
			title: '库点名称',
			width: 150,
            align:'center'
		},
		{
			field: 'warehouseShort',
			title: '库点简称',
			width: 100,
            align:'center'
		},
		{
			field: 'warehouseNature',
			title: '库点企业性质',
			width: 150,
            align:'center'
		},
		{
			field: 'warehouseType',
			title: '库点类别',
			width: 150,
            align:'center'
		},
		{
			field: 'completionDate',
			title: '建成日期',
			width: 120,
            align:'center'
		},
		{
			field: 'storageCapacity',
			title: '库点设计仓容(吨)',
			width: 120,
            align:'center'
		},
		{
			field: 'acreage',
			title: '库点面积(平方米)',
			width: 100,
            align:'center'
		},
		{
			field: 'telphone',
			title: '库点电话',
			width: 150,
            align:'center'
		},
		{
			field: 'isStop',
			title: '是否停用',
			width: 150,
			align:'center'
		},
		{
			field: 'province',
			title: '省',
			width: 150,
            align:'center'
		},{
			field: 'city',
			title: '市',
			width: 150,
            align:'center'
		},{
			field: 'area',
			title: '区',
			width: 150,
            align:'center'
		},
		{
			fixed: 'right',
			title: '操作',
			width: 200,
			align: 'center',
			toolbar: '#barDemo'
		},
		]],
		//设置表头
		request: {
			pageName: 'page',
			limitName: 'pageSize'
		},
		page: true,
		//开启分页
		limit: 10,
		id: 'wareHouseTableId',
		done: function(res, curr, count) {
            $("[data-field='isStop']").children().each(function(){
                if($(this).text()=='Y'){
                    $(this).text("是")
                }else if($(this).text()=='N'){
                    $(this).text("否")
                }
            })
		},
	});
}

var table = layui.table;
table.render();
//console.log('${type }');
if ('${type }' === 'dc') {
	dcTableRender(table);
    dcTableRender1(table);
} else if ('${type }' === 'cc') {
	ccTableRender(table);
}

//监听工具条
table.on('tool(operation)',
function(obj) {
	var data = obj.data;
	console.log(data);
	if (obj.event === 'detail') {
		view(data);
		//location.href = "${ctx}/storageWarehouse/viewPage.shtml?type=${type }&id=" + data.id;
		//location.href = "${ctx}/storageWarehouse/viewPage.shtml?type=${type }&id=" + data.id;
	} else if (obj.event === 'del') {
		layer.confirm('确定删除吗？',
		function(index) {
			$.post("${ctx}/storageWarehouse/remove.shtml", {
				id: data.id,type:'${type}'
			},
			function(result) {
				if (result.success) {
					obj.del();
					layer.msg(result.msg, {
						time: 1000,
						icon: 1
					});
				} else {
					layer.msg(result.msg, {
						time: 1000,
						icon: 0
					});
				}

			});
		});
	} else if (obj.event === 'edit') {
		location.href = "${ctx}/storageWarehouse/updatePage.shtml?type=${type }&id=" + data.id;
	}
});

//搜索
$('#searchBt').click(function() {
	table.reload("wareHouseTableId", {
		where: {
			name: $('#search #name').val(),
            shortName: $('#search #shortName').val(),
            ishost:$('#search #ishost').val(),
            enterpriseId: $('#search #enterpriseId').val(),
			province: $('#search #province').val(),
			city: $('#search #city').val(),
			area: $('#search #district').val(),
            isstop:$('#search #isstop').val()
        }
	});
});

$('#cleanBt').click(function() {
	$('#distpicker').distpicker('reset', 1);
	$('#name').val('');
	$('#enterpriseId').val('');
	$('#enterpriseName').val('');
	$('#ishost').val('');
	$('#shortName').val('');
	$("#isstop").val("");
	layui.form.render();
});

function view(data) {
	var url = "${ctx}/storageWarehouse/viewPage.shtml?type=${type }&id=" + data.id;
	$.post(url, /* {id:data.id}, */ function(str) {
		layer.open({
			type : 1,
			title:"查看详情",
			content : str,
			area:['auto','auto']
		});
	});
};


//为当前点击的行新增activeClass
function addActiveClass(obj) {
    $('#myModal').modal({backdrop: 'static'}).modal('show');
}
//移除activeClass
function removeActiveClass(obj) {
    $('#myModal').modal('hide');
    $('.activeEnterprise').removeClass('activeEnterprise');
}
table.on('tool(operation1)', function (obj) {
    var data = obj.data;
    if (obj.event === 'choose') {
        $('#enterpriseName').val(data.enterpriseName);
        $('#enterpriseId').val(data.id);
    }
    $('#myModal').modal('hide');
});
//搜索
$('#enterpriseSearch').click(function() {
    table.reload("enterpriseTableId2", {
        method: 'post', //如果无需自定义HTTP类型，可不加该参数
        where : {
            enterpriseName : $('#search1 #enterpriseName1').val(),
            enterpriseSerial : $('#search1 #enterpriseSerial').val(),
        }
    });
});
</script>
<%@include file="../common/AdminFooter.jsp" %>