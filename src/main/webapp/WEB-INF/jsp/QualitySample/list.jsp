<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="sampleNo"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="sampleSouce"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="storehouse"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="variety"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="harvestYear"]{
		text-align: center;
	}#mytable + .layui-form .layui-table-body td[data-field="quantity"]{
		 text-align: right;
	 }#mytable + .layui-form .layui-table-body td[data-field="samplingDate"]{
		  text-align: center;
	  }
	#mytable + .layui-form .layui-table-body td[data-field="samplingPeople"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="validType"]{
		text-align: left;
	}#mytable + .layui-form .layui-table-body td[data-field="testStatus"]{
		 text-align: left;
	 }

</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>位置：</li>
		<li>质量管理</li>
		<li class="active">样品信息</li>
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
		<div class="layui-form-item">
		<div class="layui-inline">
	   样品编号:
	    
        <div class="layui-inline">
        <input id="sampleNo" name="sampleNo" lay-verify="" required="--请输入--" class="layui-input">
        </div>
        </div>
			<div class="layui-inline">
				样品来源:
				<div class="layui-inline">
					<%--<input id="sampleSouce" name="sampleSouce" lay-verify="" required="--请输入--" class="layui-input">--%>
					<select lay-verify="required" class="form-control" name="sampleSouce" id="sampleSouce" lay-search
							lay-filter="sampleSouce">
						<option value="">--搜索选择--</option>
						<c:forEach items="${storageWarehouses}" var="storageWarehouse">
							<option value="${storageWarehouse.warehouseShort}">${storageWarehouse.warehouseShort}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline"> 粮食品种:
				<div class="layui-inline">
					<select lay-verify="required" class="form-control validate[required]" name="variety" id="variety">
						<option value="">--请选择--</option>
						<c:forEach items="${variety}" var="variety">
							<option value="${variety.value}">${variety.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline"> 样品状态:
				<div class="layui-inline">
					<select lay-verify="required" name="testStatus" class="form-control validate[required]"
							id="testStatus">
						<option value="">--请选择--</option>
						<option value="未检">未检</option>
						<option value="检毕">检毕</option>
						<option value="销毁">销毁</option>
					</select>
				</div>
			</div>
              <%--<div class="layui-inline">
              	 扦样日期:	    
              	<div class="layui-inline">
              		<input id="samplingDate" name="samplingDate" lay-verify="" required="--请选择时间--" class="layui-input">
              	</div>  
              </div>--%>
              <div class="layui-inline">	 
              	 收获年份:
              	<div class="layui-inline">
              		<input id="harvestYear" name="harvestYear" lay-verify="" required="--请输入--" class="layui-input">
              	</div>  
              </div>
              <div class="layui-inline">	 
              	 仓/罐号:	    
              	<div class="layui-inline">
              		<input id="storehouse" name="storehouse" lay-verify="" required="--请输入--" class="layui-input">
              	</div>  
              </div>

			<div class="layui-inline">检验类型:
				<div class="layui-inline">
					<select lay-verify="required" class="form-control validate[required]" name="validType" id="validType">
						<option value="">--请选择--</option>
						<c:forEach items="${validTypes}" var="validType">
							<option value="${validType.value}">${validType.value}</option>
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
		<button class="layui-btn layui-btn-primary layui-btn-small btn-operation"  lay-event="add" onclick="add();">新增</button>
		<button class="layui-btn layui-btn-primary layui-btn-small btn-operation" onclick="exportExcel();">导出</button>
	</div>
	<!-- layui表格 -->
	<table lay-filter="test" id="mytable"></table>
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="print">打印</a>
		{{#  if(d.testStatus=== '检毕'){ }}
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="destroy">销毁</a>
		{{#  } else { }}

		{{#  } }}


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
		url : '${ctx}/QualitySample/pageQuery.shtml',
		/*  width:1180, */ 
		method:'post',
		cols : [[
 			{field:'sampleNo',title: '样品编号',width:150,fixed: true,align :'center'},
			{field:'sampleSouce',title: '样品来源',width:150,align :'center'},
			{field:'storehouse',title: '仓/罐号',width:150,align :'center'},
			{field:'variety',title: '粮食品种',width:150,align :'center'},
            {field:'dealSerial',title: '成交子明细号',width:150,align :'center'},
			{field:'harvestYear',title: '收获年份',width:150,align :'center'},
            {field:'quantity',title: '数量(吨)',width:150,align :'center'},
            {field:'samplingDate',title: '扦样日期',width:150,align :'center'},
			{field:'samplingPeople',title: '扦样人',width:150,align :'center'},
			{field:'validType',title: '检验类型',width:150,align :'center'},
			{field:'testStatus',title: '样品状态',width:150,align :'center'},
			{width : 160,align :'center',toolbar : '#barDemo',title: '操作',width:290,fixed: 'right'},
			
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
location.href = "${ctx}/QualitySample/addPage.shtml";
}
function exportExcel(){
    window.location.href = "${ctx}/QualitySample/exportExcel.shtml?flag=1&sampleNo="+$('#search #sampleNo').val()+
        "&sampleSouce=" +$('#search #sampleSouce').val()+
        "&variety=" +$('#search #variety').val()+
        "&testStatus=" +$('#search #testStatus').val()+
        "&storehouse=" +$('#search #storehouse').val()+
        "&harvestYear=" +$('#search #harvestYear').val()+
        "&validType=" +$('#search #validType').val()+
        "&samplingDate=" +$('#search #samplingDate').val()+
        "&page="+$('.layui-laypage-curr em').eq(1).text()+
        "&pageSize=10";
  //alert(pageSize);
//alert($('.layui-laypage-curr em').eq(1).text());
/*window.location.href = "${ctx}/QualitySample/exportExcel.shtml?flag=1&sampleNo="+encodeURI(encodeURI($('#search #sampleNo').val()))+
						"&sampleSouce=" +encodeURI(encodeURI($('#search #sampleSouce').val()))+
						"&variety=" +encodeURI(encodeURI($('#search #variety').val()))+
						"&testStatus=" +encodeURI(encodeURI($('#search #testStatus').val()))+
						"&storehouse=" +encodeURI(encodeURI($('#search #storehouse').val()))+
						"&harvestYear=" +encodeURI(encodeURI($('#search #harvestYear').val()))+
    					"&validType=" +encodeURI(encodeURI($('#search #validType').val()))+
						"&samplingDate=" +encodeURI(encodeURI($('#search #samplingDate').val()))+
						"&page="+encodeURI(encodeURI($('.layui-laypage-curr em').eq(1).text()))+
						"&pageSize=10";*/
}
table.on('tool(test)', function(obj) {
		var data = obj.data;

		if (obj.event === 'detail') {
		
			/*location.href = "${ctx}/QualitySample/detailPage.shtml?id="
					+ data.id;*/
            layer.load(2, {time: 6000});
            $('#self-cover-grain').css({'display':'block'})
            $('#self-grain-cover').css({'display':'block'})
            $('.grain-cont-detail').load("${ctx}/QualitySample/detailPage.shtml",
                {id:data.id,type:$("#type").val(),Projectile:'Projectile'})
		} else if (obj.event === 'del') {
			layer.confirm(' 您确认要删除该样品么 ?', function(index) {
				$.post("${ctx}/QualitySample/remove.shtml", {
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
							sampleSouce : $('#search #sampleSouce').val(),
							variety : $('#search #variety').val(),
							testStatus : $('#search #testStatus').val(),
							samplingDate : $('#search #samplingDate').val(),
							validType : $('#search #validType').val(),
							}
						});
				});
			});
		} else if (obj.event === 'edit') {
			/*location.href = "${ctx}/QualitySample/editPage.shtml?id="
					+ data.id;*/
            layer.load(2, {time: 6000});
            $('#self-cover-grain').css({'display':'block'})
            $('#self-grain-cover').css({'display':'block'})
            $('.grain-cont-detail').load("${ctx}/QualitySample/editPage.shtml",
                {id:data.id,Projectile:'Projectile'})
		}else  if(obj.event === 'print'){
			location.href = "${ctx}/QualitySample/print.shtml?id="
					+ data.id;
		}else  if(obj.event === 'destroy'){


            layer.confirm(' 您确认要销毁该样品么 ?', function(index) {
                $.post("${ctx}/QualitySample/destroy.shtml", {
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
                            sampleSouce : $('#search #sampleSouce').val(),
                            variety : $('#search #variety').val(),
                            testStatus : $('#search #testStatus').val(),
                            samplingDate : $('#search #samplingDate').val(),
                            validType : $('#search #validType').val(),
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
				sampleNo : $('#search #sampleNo').val(),
				sampleSouce : $('#search #sampleSouce').val(),
				variety : $('#search #variety').val(),
				testStatus : $('#search #testStatus').val(),
				samplingDate : $('#search #samplingDate').val(),
				storehouse: $('#search #storehouse').val(),
				harvestYear: $('#search #harvestYear').val(),
                validType : $('#search #validType').val(),
			}
		});
	});
 function importFile(){
  	if(window.confirm('是否确定导入?')){
		if(checkExcel("excelFile")){
			$('#form-import').attr("action", 'QualitySample/importExcel.shtml').submit();
		}	
	}
  }
 layui.use('laydate', function(){
  var laydate = layui.laydate;
  laydate.render({ 
	  elem: '#samplingDate'
	  ,format: 'yyyy-MM-dd' //可任意组合
	});

});

    layui.laydate.render({
        elem:$('[name="harvestYear"]')[0],
        type:"year",
        format:"yyyy",
        
    });
</script>
<%@include file="../common/AdminFooter.jsp"%>