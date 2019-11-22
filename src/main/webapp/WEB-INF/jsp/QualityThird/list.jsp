<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="sampleNo"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="sampleName"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="harvestYear"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="reportUnit"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="acceptedUnit"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="proGrade"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="testDate"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="quantity"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="samplePlace"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="origin"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="storeDate"]{
		text-align: center;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>质量管理</li>
		<li>检验任务</li>
		<li class="active">第三方质检记录</li>
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

	<div class="layui-form" id="search">
		<input type="hidden" value="2" name="checkType" id="checkType">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">样品编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="sampleNo" id="sampleNo"
						autocomplete="off">
				</div>
			</div>
			<%--<div class="layui-inline">
				<label class="layui-form-label ">样品名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="sampleName"
						id="sampleName" autocomplete="off">
				</div>
			</div>--%>
			<div class="layui-inline">
				<label class="layui-form-label ">样品名称:</label>
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
				<label class="layui-form-label ">收获年份:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="harvestYear"
						   id="harvestYear" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">受检单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="reportUnit"
						id="reportUnit" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">抽样地点:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="storeEncode"
						id="storeEncode" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">检验类型:</label>
				<div class="layui-input-inline">
					<select name="validType" id="validType">
						<option value="">--请选择--</option>
						<c:forEach items="${validTypes}" var="item">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
			</div>
		</div>
	</div>
		<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" lay-event="add" onclick="add();">新增</button>
				<button class="layui-btn layui-btn-primary layui-btn-small" onclick="exportExcel();">导出</button>
			</div>


	<!-- layui表格 -->
	<table lay-filter="test" id="mytable"></table>
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
	</script>
</div>

			

<script>
	var form=layui.form;
	form.render();
    layui.use('laydate', function(){
        var laydate = layui.laydate;


        laydate.render({
            elem: '#harvestYear'
            ,type: 'year'
            ,format: 'yyyy' //可任意组合
        });
    });
    var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/QualityThird/list.shtml?checkType=2',
		 /* width:1180,  */
		 method:'post',
		cols : [[
 			{field:'sampleNo',title: '样品编号',width:170,fixed: true,align : 'center'},
 			{field:'variety',title: '样品名称',width:150,align : 'center'},
            {field:'harvestYear',title: '收获年份',width:150,align : 'center'},
            {field:'reportUnit',title: '受检单位',width:150,align : 'center'},
 			{field:'acceptedUnit',title: '承检单位',width:150,align : 'center'},
            {field:'validType',title: '检验类型',width:150,align : 'center'},
 			{field:'proGrade',title: '产品等级',width:150,align : 'center'},
 			{field:'testDate',title: '检验日期',width:150,align : 'center'},
 			{field:'quantity',title: '抽样基数(吨)',width:150,align : 'center'},
 			{field:'storeEncode',title: '抽样地点',width:150,align : 'center'},
 			{field:'origin',title: '粮食产地',width:150,align : 'center'},
 			{field:'storeDate',title: '入库时间',width:150,align : 'center'},
 			/*{field:'qualityDetermin',title: '储存品质',width:150}, */
			{width : 160,align : 'center',toolbar : '#barDemo',title: '操作',width:290,fixed: 'right'}, 
			
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
location.href = "${ctx}/QualityThird/addPage.shtml";
}
function exportExcel(){
location.href = "${ctx}/QualityThird/exportExcel.shtml?checkType=2&creator=&isExport=Y&sampleNo="+$('#search #sampleNo').val()+
				"&variety="+$('#search #variety').val()+
				"&reportUnit="+$('#search #reportUnit').val()+
				"&storeEncode="+$('#search #storeEncode').val()+
				"&harvestYear="+$('#search #harvestYear').val()+
				"&validType="+$( "#search #validType").val()+
   				 "&testDate="+"&page=1&limit=100000";
}
table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'detail') {
		
			/*location.href = "${ctx}/QualityThird/detailPage.shtml?id="
					+ data.id;*/
            layer.load(2, {time: 1000});
            $('#self-cover-grain').css({'display':'block'})
            $('#self-grain-cover').css({'display':'block'})
            $('.grain-cont-detail').load("${ctx}/QualityThird/detailPage.shtml",
                {id:data.id,Projectile:'Projectile'})
		} else if (obj.event === 'del') {
			layer.confirm('确认要删除该记录么 ?', function(index) {
				$.post("${ctx}/QualityThird/remove.shtml", {
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
								sampleNo : $('#search #sampleNo').val(),
								variety : $('#search #variety').val(),
                                harvestYear : $('#search #harvestYear').val(),
							}
						});
				});
			});
		} else if (obj.event === 'edit') {
			/*location.href = "${ctx}/QualityThird/editPage.shtml?id="
					+ data.id;*/
            layer.load(2, {time: 1000});
            $('#self-cover-grain').css({'display':'block'})
            $('#self-grain-cover').css({'display':'block'})
            $('.grain-cont-detail').load("${ctx}/QualityThird/editPage.shtml",
                {id:data.id,Projectile:'Projectile'})
		}
		
	});
	

	//搜索
	$('#search button').click(function() {
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				sampleNo : $('#search #sampleNo').val(),
				variety : $('#search #variety').val(),
				reportUnit : $('#search #reportUnit').val(),
				storeEncode : $('#search #storeEncode').val(),
                harvestYear : $('#search #harvestYear').val(),
                validType :$("#search #validType").val(),
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>