<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-header th{
		text-align: center;
	}

	#mytable + .layui-form .layui-table-body tr td[data-field='socialCreditCode']{
		text-align: right;
	}

	#mytable + .layui-form .layui-table-body tr td[data-field='organizationCode']{
		text-align: right;
	}

	#mytable + .layui-form .layui-table-body tr td[data-field='telephone']{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body tr td[data-field='employedNum']{
		text-align: right;
	}



</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>客户管理</li>
		<li class="active">客户信息</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	<div class="layui-form" id="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">客户名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="clientName" id="clientName"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">企业性质:</label>
				<div class="layui-inline" >
				<select   name="enterpriseNature" id="enterpriseNature">
					<option value="">--请选择--</option>
					<c:forEach items="${enterpriseNature}" var="enterpriseNature">
						<option value="${enterpriseNature.value}" >${enterpriseNature.value}</option>
					</c:forEach>
				</select>
				</div>
			</div>
			
			<div class="layui-inline">
                    <label class="layui-form-label ">从事行业：</label>
                    
                    <div class="layui-inline" >
                        <select class="layui-input" name="industry" id="industry" lay-verify=""  lay-filter="aihao">
                        	<option value=""></option>
                            <option value="仓储类">仓储类</option>
                            <option value="加工类">加工类</option>
                            <option value="贸易类">贸易类</option>
                            
                        </select>
                    </div>
                     </div>
            <div class="layui-inline">
                    <label class="layui-form-label ">黑名单：</label>
                    
                <div class="layui-inline" >
					<select class="layui-input" name="blacklist" id="blacklist" lay-filter="aihao" id="state">
						<option value=""></option>
						<option value="2">是</option>
						<option value="1">否</option>
					</select>
				</div>
				</div>
			<div class="layui-inline">
			<div class="layui-inline" >
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
	        </div>
	        </div>
	        
		</div>
	<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" lay-event="add" onclick="add();">新增</button>
				<button class="layui-btn layui-btn-primary layui-btn-small" onclick="exportExcel();">导出</button>
				<button class="layui-btn layui-btn-primary layui-btn-small" lay-event="inblackList" id="inblackList" onclick="inblackList();">加入黑名单</button>
				<button class="layui-btn layui-btn-primary layui-btn-small" lay-event="outblackList" id="outblackList" onclick="outblackList();">移除黑名单</button>
				<div class="layui-btn layui-btn-primary layui-btn-small" id="importExcel">导入</div>
					<input name="file" id="importId" type="hidden">
				<a id="afileName" style="color:red;margin:auto 20px;" href="${ctx}/CustomerInformation/download.shtml" >模版下载</a>
	</div>
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
var blackList="";

	var form=layui.form;
	form.render();
	
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/CustomerInformation/list.shtml',
		 /* width:1100, */ 
		method:'post',
		cols : [[
			{checkbox:true,width:69,align : 'center',fixed: true},
 			{field:'clientName',title: '客户名称',width:150},
 			{field:'socialCreditCode',title: '企业统一社会信用代码',width:150},
 			{field:'organizationCode',title: '企业注册号',width:150},
 			{field:'registType',title: '登记注册类型',width:150},
 			{field:'extraQualification',title: '是否具备储备粮代储资格',width:150},
 			{field:'personIncharge',title: '法定代表人',width:150},
 			{field:'telephone',title: '企业电话',width:150},
 			{field:'contactor',title: '企业联系人',width:150},
 			{field:'employedNum',title: '企业从事人员数',width:150},
 			{field:'blacklist',title: '状态',width:150},
 			{field:'enterpriseNature',title: '企业性质',width:150},
 			{field:'industry',title: '从事行业',width:150},
			{width : 160,align : 'center',toolbar : '#barDemo',title: '操作',width:290,fixed: 'right'},  
	                 
		]] ,//设置表头
		page:true,//开启分页
		id:'myTableID',
		done:function(res,curr,count){
		    /*$('.layui-table-main').find('.layui-table-cell').each(function (i, v) {
                $(v).attr('contenteditable',true)
            })*/
		},
	});
	//搜索
	$('#search button').click(function() {
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				clientName : $('#search #clientName').val(),
				enterpriseNature : $('#search #enterpriseNature').val(),
				industry : $('#search #industry').val(),
				blacklist : $('#search #blacklist').val(),
			}
		});
	});
function add(){
location.href = "${ctx}/CustomerInformation/addPage.shtml";
}
function exportExcel(){
location.href = "${ctx}/CustomerInformation/exportExcel.shtml?clientName="+encodeURI(encodeURI($('#search #clientName').val()))+
				"&enterpriseNature="+encodeURI(encodeURI($('#search #enterpriseNature').val()))+
				"&industry="+encodeURI(encodeURI($('#search #industry').val()))+
				"&blacklist="+ encodeURI(encodeURI($('#search #blacklist').val()));
}
var upload = layui.upload;
	   //执行实例
  var uploadInst = upload.render({
    elem: '#importExcel' //绑定元素
    ,url: '${ctx}/CustomerInformation/importExcel.shtml' //上传接口
    ,accept: 'file' //普通文件
    ,exts: 'xls|xlsx' //只允许上传xlx和xlsx文件
    ,done: function(res){
      if(res.code==0){
      alert(res.msg);
      /* layer.open({title: '在线调试',content: '可以填写任意的layer代码'}); */
    }else{
    alert(res.msg);
    }     
    location.href = "${ctx}/CustomerInformation.shtml";
    }
    ,error: function(){
      //请求异常回调
    }
  });
table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		blackList=data.blacklist;
		if (obj.event === 'detail') {
		
			location.href = "${ctx}/CustomerInformation/detailPage.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/CustomerInformation/remove.shtml", {
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
								clientName : $('#search #clientName').val(),
								enterpriseNature : $('#search #enterpriseNature').val(),
								industry : $('#search #industry').val(),
								blacklist : $('#search #blacklist').val(),
								
							}
						});
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/CustomerInformation/editPage.shtml?id="
					+ data.id;
		}
		
	});
function inblackList(){
	var checkStatus = table.checkStatus('myTableID');
	var data = checkStatus.data;
	var ids="";
	if(data.length>0){
	var list = new Array();
	for (var i = 0; i < data.length; i++) {
		 if(ids==""){
            ids=data[i].id;
            }else{
            ids+="-"+data[i].id;
            }
	}
	$.post("${ctx}/CustomerInformation/inblacklist.shtml?ids="+ids,{
				}, function(result) { 
	if (result.success) {
	alert("加入黑名单成功");
	}else{
	alert("加入黑名单失败");
	}
		location.href="${ctx}/CustomerInformation.shtml";
});
	//location.href = "${ctx}/CustomerInformation/inblacklist.shtml?ids="+ids;
	}else{
	layer.open({
		title: '提示信息'
		,content: '请勾选记录'
	});
	}

}
function outblackList(){
	var checkStatus = table.checkStatus('myTableID');
	var data = checkStatus.data;
	var ids="";
	if(data.length>0){
	var list = new Array();
	for (var i = 0; i < data.length; i++) {
		 if(ids==""){
            ids=data[i].id;
            }else{
            ids+="-"+data[i].id;
            }
	}
	$.post("${ctx}/CustomerInformation/outblacklist.shtml?ids="+ids,{
				}, function(result) { 
	if (result.success) {
	alert("移除黑名单成功");
	}else{
	alert("移除黑名单失败");
	}
		location.href="${ctx}/CustomerInformation.shtml";
});
//	location.href = "${ctx}/CustomerInformation/outblacklist.shtml?ids="+ids;
	}else{
	layer.open({
		title: '提示信息'
		,content: '请勾选记录'
	});
	}

}
function download(){
	window.location.href="${ctx}/CustomerInformation/download.shtml";
	}
</script>
<%@include file="../common/AdminFooter.jsp"%>