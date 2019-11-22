<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="reportSerial"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="reportUnit"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="validType"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="sampleNo"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="variety"]{
		text-align: left;
	}#mytable + .layui-form .layui-table-body td[data-field="storeEncode"]{
		 text-align: left;
	 }
	#mytable + .layui-form .layui-table-body td[data-field="templetNo"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="harvestYear"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="quantity"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="testDate"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="creator"]{
		text-align: left;
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
		<li>质量管理</li>
		<li>质量档案</li>
		<li class="active">质量档案信息</li>
	</ol>
</div>

<%--<div class="" id="self-cover-grain" style="">
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
</script>--%>

<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-form" id="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">检测单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="acceptedUnit" id="acceptedUnit"
						   autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">受检单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="reportUnit" id="reportUnit"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">仓号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="storeEncode"
						id="storeEncode" autocomplete="off">
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
				<label class="layui-form-label ">检测时间:</label>
				<div class="layui-input-inline">
					<input type="text" name="testDate" id="testDate"  class="form-control "/>
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label ">质检类别:</label>
				<div class="layui-input-inline">
					<%--<input type="text" name="warehouseType" id="warehouseType"  class="form-control "/>--%>
					<select name="checkType" id="checkType">
						<option value="">--全部--</option>
						<option value="1">内部质检</option>
						<option value="2">第三方质检</option>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">库点类型:</label>
				<div class="layui-input-inline">
					<%--<input type="text" name="warehouseType" id="warehouseType"  class="form-control "/>--%>
                    <select name="warehouseType" id="warehouseType">
                        <option value="">--全部--</option>
                        <option value="储备库">储备库</option>
                        <option value="代储库">代储库</option>
                    </select>
                </div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">产地:</label>
				<div class="layui-input-inline">
					<input type="text" name="origin" id="origin"  class="form-control "/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">收获年份:</label>
				<div class="layui-input-inline">
					<input type="text" name="harvestYear" id="harvestYear"  class="form-control "/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">检验类型:</label>
				<div class="layui-input-inline">
					<%--<input type="text" name="validType" id="validType"  class="form-control "/>--%>
					<select name="validType" id="validType" class="layui-select">
						<option value=""></option>
						<c:forEach items="${validTypes}" var="item">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<input type="radio" name="isLike" value="0" title="精确查询"/>
				<input type="radio" name="isLike" value="1" checked title="模糊查询">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
			</div>
	</div>


</div>
	<div class="layui-inline">
		<%--<!-- <button class="layui-btn layui-btn-primary layui-btn-small" onclick="exportExcel();">导出</button> -->--%>
		<button class="layui-btn layui-btn-primary layui-btn-small" lay-event="contrast" id="contrast" onclick="contrast();">对比</button>
		<button class="layui-btn layui-btn-primary layui-btn-small" onclick="exportExcel();">导出</button>

	</div>
	<!-- layui表格 -->
	<table lay-filter="test" id="mytable"></table>
	<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="print">查看</a>
	<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="excel">导出</a>
	</script>
</div>



<script>
    function exportExcel(){
        window.location.href = "${ctx}/QualityResult/exportAllExcel.shtml?creator=" +
		"&reportUnit="+$('#search #reportUnit').val()+
            "&validType="+$('#search #validType').val()+
            "&checkType="+$('#search #checkType').val()+
			"&acceptedUnit="+$("#search #acceptedUnit").val()+
            "&storeEncode="+($('#search #storeEncode').val())+
            "&variety="+($('#search #variety').val())+
            "&origin="+($('#search #origin').val())+
            "&warehouseType="+($('#search #warehouseType').val())+
            "&harvestYear="+($('#search #harvestYear').val())+
            "&testDate="+($('#search #testDate').val())+
				"&isLike="+($("#search [name='isLike']:checked").val())

    }
	var form=layui.form;
	form.render();
	
	/*layui.laydate.render({
	   elem: '#testDate',
	   type: 'date',
	   format: 'yyyy-MM-dd'
	});*/
layui.use('laydate', function(){
    var laydate = layui.laydate;
    laydate.render({
        elem: '#testDate',
        range: true,
        done: function(value,date,endDate){
            //console.log(value);
        }
    });
});
//日期选择器
var laydate=layui.laydate;
laydate.render({
    elem:"#harvestYear",
    type:"year",
    format:"yyyy",
});
var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/QualityResult/list.shtml',
		 /* width:1100, */ 
		cols : [[
			{checkbox:true,width:69,align : 'center',fixed: true},
 			{field:'reportSerial',title: '检测报告编号',width:150,fixed: true,align : 'center'},
            {field:'acceptedUnit',title: '检测单位',width:150,align : 'center'},
 			{field:'reportUnit',title: '受检单位',width:150,align : 'center'},
            {field:'variety',title: '样品名称',width:150,align : 'center'},
            {field:'storeEncode',title: '仓号',width:150,align : 'center'},
            {field:'quantity',title: '数量(吨)',width:150,align : 'center'},
            {field:'harvestYear',title: '收获年份',width:150,align : 'center'},
            {field:'checkType',title: '质检类别',width:150,align : 'center'},
 			{field:'validType',title: '检验类型',width:150,align : 'center'},
 			{field:'sampleNo',title: '样品编号',width:150,align : 'center'},
 			{field:'templetNo',title: '模板编号',width:150,align : 'center'},
 			{field:'testDate',title: '检测时间',width:150,align : 'center'},
 			{field:'mainTester',title: '主检人',width:150,align : 'center'},
 			{field:'status',title: '状态',width:150,align : 'center'},
			{width : 160,align : 'center',toolbar : '#barDemo',title: '操作',fixed: 'right'},
		]],//设置表头
		page:true,//开启分页
		id:'myTableID',
		done:function(res,curr,count){
            $("[data-field='checkType']").children().each(function(){
                if($(this).text()=='1'){
                    $(this).text("内部质检")
                }else if($(this).text()=='2'){
                    $(this).text("第三方质检")
                }

            });
            $("[data-field='quantity']").children().each(function (index) {
                if(index!=0){
                    let number = Number($(this).text());
                    $(this).text(number.toFixed(3));
                }

            });

		}
	});
table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if(obj.event === 'print'){
			location.href = "${ctx}/QualityResult/print.shtml?id="
					+ data.id+"&name="+encodeURI(encodeURI("质量档案信息"));
            /*layer.load(2, {time: 1000});
            $('#self-cover-grain').css({'display':'block'})
            $('#self-grain-cover').css({'display':'block'})
            $('.grain-cont-detail').load("${ctx}/QualityResult/print.shtml",
                {id:data.id,name:encodeURI(encodeURI("质量档案信息")),Projectile:'Projectile'})*/
		}else if (obj.event === 'excel') {
			location.href = "${ctx}/QualityResult/exportExcel.shtml?id="
				    + data.id;
		}
		
	});
	//搜索
	$('#search button').click(function() {
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				reportUnit : $('#search #reportUnit').val(),
				acceptedUnit : $("#search #acceptedUnit").val(),
                testDate : $('#search #testDate').val(),
				storeEncode : $('#search #storeEncode').val(),
				variety : $('#search #variety').val(),
                warehouseType : $('#search #warehouseType').val(),
                origin : $('#search #origin').val(),
                harvestYear : $('#search #harvestYear').val(),
                validType: $('#search #validType').val(),
                checkType:$(' #checkType').val(),
				isLike:$("[name='isLike']:checked").val(),
			}
		});
	});
function contrast(){
	var checkStatus = table.checkStatus('myTableID');
	var data = checkStatus.data;
	var ids="";
	var str="";
	if(data.length==2){
	var list = new Array();
	for (var i = 0; i < data.length; i++) {
		 if(ids==""){
            ids=data[i].id;
            str=data[i].reportSerial;
            }else{
            ids+="-"+data[i].id;
            str+="-"+data[i].reportSerial;
            }
	}
	toAddSelectContrast(ids+","+str);
	}else{
	layer.open({
		title: '提示信息'
		,content: '对比要选择两条记录'
	});
	}

}
function toAddSelectContrast(val){
	$.colorbox({
		title : '对比数据',
		iframe : true,
		opacity	: 0.2,
		href : "${ctx}/QualityFileInfo/listContrast.shtml?ids="+val,
		innerWidth : '700px',
		innerHeight : '60%',
		close : '×15151',
		fixed : true
	});
}
function toAddSelect(){
	$.colorbox({
		title : '选择粮油数据',
		iframe : true,
		opacity	: 0.2,
		href : "${ctx}/QualityThird/listChoice.shtml?",
		innerWidth : '1100px',
		innerHeight : '80%',
		close : '×15151',
		fixed : true
	});
}
function selectToData(data){
	$("input[name='templetNo']").val(data.templetNo);
	}
    form.render();
</script>
<%--<script type="text/html" id="titleTpl">
	{{#if(d.checkType=='1'){}}
	{{d.reportUnit}}
	{{#}else if
	(d.checkType=='2'){}}
	 {{d.acceptedUnit}}
	{{#}}}
</script>--%>
<%@include file="../common/AdminFooter.jsp"%>