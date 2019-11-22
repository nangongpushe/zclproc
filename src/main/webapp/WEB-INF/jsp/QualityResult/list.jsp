<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="sampleNo"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="reportUnit"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="variety"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="storeEncode"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="quantity"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="harvestYear"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="testDate"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="testEndDate"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="status"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="mainTester"]{
		text-align: left;
	}

</style>
<div class="row clear-m">
	<ol class="breadcrumb">
	<c:if test="${type==''}">
		<li>质量管理</li>
		<li>检验任务</li>
		<li class="active">
		检验结果</li>
		</c:if>
		<c:if test="${type=='dc'}">
		<li>代储监管</li>
		<li>报表台账</li>
		<li class="active">
		质量检测报告</li>
		</c:if>
		
	</ol>
</div>
<div class="" id="self-cover-grain" style="">
	<div class="dialogsCont-" style="">
		<div class="grain-cont-detail"></div>
		<a class="cancalButtons" onclick="displayNone()" style="">返回</a>
	</div>
</div>

<style>
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

	<div class="layui-form noprint" id="search">

		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align: right">检测单位</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="acceptedUnit" id="acceptedUnit" autocomplete="off"/>
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label " style="text-align:right">受检单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="reportUnit" id="reportUnit"
						autocomplete="off">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label " style="text-align:right">样品编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="sampleNo"
						id="sampleNo" autocomplete="off">
				</div>
			</div>
			<%--<div class="layui-inline">
				<label class="layui-form-label ">粮食品种:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="variety"
						id="variety" autocomplete="off">
				</div>
			</div>--%>
			<div class="layui-inline">
				<label class="layui-form-label " style="text-align:right">粮油品种:</label>
					<div class="layui-input-inline">
						<select name="variety" id="variety">
							<option></option>
							<c:forEach items="${varietyList }" var="item">
								<option value="${item.value }">${item.value }</option>
							</c:forEach>
						</select>
					</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label " style="text-align:right">检测开始时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="testDate"
						id="testDate" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label " style="text-align:right">仓号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="storeEncode"
						id="storeEncode" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label " style="text-align:right">主检人:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="mainTester"
						id="mainTester" autocomplete="off">
						<%--<select name="creator" id="creator">--%>
							<%--<option></option>--%>
							<%--<c:forEach items="${userList }" var="item">--%>
								<%--<option value="${item.id }">${item.name }</option>--%>
							<%--</c:forEach>--%>
						<%--</select>--%>
				</div>
			</div>
                <div class="layui-inline">
                    <label class="layui-form-label " style="text-align:right">收获年份:</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" name="harvestYear"
                               id="harvestYear" autocomplete="off">
                        <%-- name="creator"--%>

                    </div>
                </div>

			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
			</div>
		</div>

	</div>
			<div class="layui-form-item"  style="height:25px">
				<button class="layui-btn layui-btn-primary layui-btn-small" lay-event="add" onclick="add();">新增</button>
				<button class="layui-btn layui-btn-primary layui-btn-small" onclick="exportExcel();">导出</button>
			</div>
	<!-- layui表格 -->
	<table lay-filter="test" id="mytable"></table>
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
		{{#  if(d.status == '待提交'){ }}
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="submit">提交</a>
		{{#  } }} 
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="print">打印</a>
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="excel">导出</a>
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
	</script>
</div>



<script>
	var form=layui.form;
	form.render();
	
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/QualityResult/list.shtml?checkType=1',
		 /* width:1100,*/
		 method:'post',
		cols : [[
            {field:'sampleNo',title: '样品编号',width:200,fixed: true,align : 'center'},
 			/*{field:'reportSerial',title: '检测报告编号',width:150,fixed: true}, */
			{field:'acceptedUnit',title:'检测单位',width:200,align:'center'},
 			{field:'reportUnit',title: '受检单位',width:150,align : 'center'},
 			{field:'variety',title: '粮油品种',width:150,align : 'center'},
            {field:'storeEncode',title: '仓号',width:150,align : 'center'},
 			{field:'quantity',title: '数量(吨)',width:150,align : 'center'},
            {field:'harvestYear',title: '收获年份',width:150,align : 'center'},
            {field:'testDate',title: '检测开始时间',width:150,align : 'center'},
            {field:'testEndDate',title: '检测结束时间',width:150,align : 'center'},
 			{field:'status',title:'状态',width:150,align : 'center'},
 			{field:'mainTester',title: '主检人',width:150,align : 'center'},
			{width : 160,align : 'center',toolbar : '#barDemo',title: '操作',width:450},
			
		]],//设置表头
/* 		request : {
		
			pageName : 'page', 
			limitName : 'pageSize'
		}, */
		page:true,//开启分页
/* 		limit:10, */
		id:'myTableID',
		done:function(res,curr,count){
            $("[data-field='quantity']").children().each(function (index) {
                if(index!=0){
                    let number = Number($(this).text());
                    $(this).text(number.toFixed(3));
                }

            });
		},
	});
function add(){
location.href = "${ctx}/QualityResult/addPage.shtml?type="+'${type}';
}
function exportExcel(){
location.href = "${ctx}/QualityResult/exportAllExcel.shtml?checkType=1&creator=&reportUnit="+$('#search #reportUnit').val()+
				"&sampleNo="+($('#search #sampleNo').val()+
				"&acceptedUnit="+$("#search #acceptedUnit").val()+
				"&variety="+($('#search #variety').val()))+
				"&storeEncode="+($('#search #storeEncode').val())+
				"&mainTester="+($('#search #mainTester').val())+
				"&testDate="+($('#search #testDate').val())+"&export=all&checkType=1";
}
table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'detail') {
		
			/*location.href = "${ctx}/QualityResult/detailPage.shtml?id="
					+ data.id+"&type="+'${type}';*/
            layer.load(2, {time: 6000});
            $('#self-cover-grain').css({'display':'block'})
            $('#self-grain-cover').css({'display':'block'})
            $('.grain-cont-detail').load("${ctx}/QualityResult/detailPage.shtml",
                {id:data.id,type:$("#type").val(),Projectile:'Projectile'})
		} else if (obj.event === 'del') {
			layer.confirm('您确认要删除该检验报告么?', function(index) {
				$.post("${ctx}/QualityResult/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					layer.open({
					  title: '提示信息'
					  ,content: result.msg
					}); 
						table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
								reportUnit : $('#search #reportUnit').val(),
								acceptedUnit : $("#search #acceptedUnit").val(),
								sampleNo : $('#search #sampleNo').val(),
								variety : $('#search #variety').val(),
                                storeEncode : $('#search #storeEncode').val(),
								mainTester : $('#search #mainTester').val(),
                                harvestYear : $('#search #harvestYear').val(),
								testDate : $('#search #testDate').val(),
							}
						});
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/QualityResult/editPage.shtml?id="
					+ data.id+"&type="+'${type}';
		}else  if(obj.event === 'print'){
			location.href = "${ctx}/QualityResult/print.shtml?id="
					+ data.id+"&name="+encodeURI(encodeURI("检验结果"))+"&type="+'${type}';
            /*layer.load(2, {time: 1000});
            $('#self-cover-grain').css({'display':'block'})
            $('#self-grain-cover').css({'display':'block'})
            $('.grain-cont-detail').load("${ctx}/QualityResult/print.shtml",
                {id:data.id,name:encodeURI(encodeURI("检验结果")),type:$("#type").val(),Projectile:'Projectile'})*/
		}else if (obj.event === 'excel') {
			location.href = "${ctx}/QualityResult/exportExcel.shtml?id="
				    + data.id;
		}else if (obj.event === 'text') {
			location.href = "${ctx}/QualityResult/excel.shtml?id="
				    + data.id;
		}else if(obj.event === 'submit'){
			layer.confirm('您确认要提交该检验报告么?', function(index) {
				$.post("${ctx}/QualityResult/submit.shtml", {
					id : data.id,type:'${type}'
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					layer.open({
					  title: '提示信息'
					  ,content: result.msg
					}); 
					table.reload("myTableID", {
						method: 'post', //如果无需自定义HTTP类型，可不加该参数
						where : {
							reportUnit : $('#search #reportUnit').val(),
                            acceptedUnit : $("#search #acceptedUnit").val(),
							sampleNo : $('#search #sampleNo').val(),
							variety : $('#search #variety').val(),
                            storeEncode : $('#search #storeEncode').val(),
							mainTester : $('#search #mainTester').val(),
                            harvestYear : $('#search #harvestYear').val(),
							testDate : $('#search #testDate').val(),
						}
					});
				});
			});
		}
	});
	

	//搜索
	$('#search button').click(function() {
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				reportUnit : $('#search #reportUnit').val(),
				sampleNo : $('#search #sampleNo').val(),
                acceptedUnit : $("#search #acceptedUnit").val(),
				variety : $('#search #variety').val(),
                storeEncode : $('#search #storeEncode').val(),
				mainTester : $('#search #mainTester').val(),
                harvestYear : $('#search #harvestYear').val(),
				testDate : $('#search #testDate').val(),
			}
		});
	});
 layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#testDate',
            range: true,
            done: function(value,date,endDate){
                console.log(value);
            }
        });
    });
    layui.laydate.render({
        elem:$('[name="harvestYear"]')[0],
        type:"year",
        format:"yyyy",

    });

</script>
<%@include file="../common/AdminFooter.jsp"%>