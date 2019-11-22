<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="UTF-8">
<title>进度上报</title>
<%@include file="/common.jsp"%>
<script src="${ctx }/laydate/laydate.js"></script>
<script src="${ctx }/js/checkBox.js"></script>
<script src="${ctx }/plugins/laypage/laypage.js"></script>
<script
	src="${ctx }/plugins/bootstrap-3.3.5-dist/js/bootstrap-select.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">
</head>
<style>
/*高级搜索*/
.more_search {
	cursor: pointer;
}

.more_search:hover {
	color: #13c19f;
}

.search-item .pull-left {
	/*width: 50%;*/
	
}

.layui-form-label {
	width: 114px;
	/*padding: 9px 15px;*/
}

.more_search_box {
	background: #fff;
	width: 100%;
	position: absolute;
	top: 0;
	left: 0;
	display: none;
	border: 1px solid #ddd;
	padding-bottom: 10px;
	z-index: 111;
}

.more_search_box .layui-form-select {
	width: 61%;
}

.more_search_box .layui-form-mid {
	margin-right: 13px;
	padding: 12px 0;
}

.more_search_box .layui-input, .layui-textarea {
	width: 99%;
}

.layui-form-radio span {
	font-size: 12px;
}

.layui-form-radio i {
	font-size: 20px;
}
/*下拉框*/
.dropdown-menu {
	width: 100%;
}

.dropdown-menu>li ~li {
	border-top: none;
}

.dropdown-menu a {
	padding: 3px !important;
	text-align: left;
}

.dropdown-menu>li>a:focus, .dropdown-menu>li>a:hover {
	background-color: transparent !important;
}

.Group .layui-unselect {
	display: none;
}

.Group ~.Group {
	display: none;
}

.layui-input-block {
	max-width: 115px;
}
/*弹框*/
.alert_box {
	width: 400px;
	background-color: white;
	position: absolute;
	top: 100px;
	left: 50%;
	margin-left: -200px;
	padding: 20px;
}

.alert_box h5 {
	font-weight: bold;
	font-size: 14px;
}

.btn-box {
	padding: 20px 0;
	border-top: 2px solid #ccc;
	text-align: right;
}

.mask_1, .mask_2, .mask_3 {
	display: none;
}

td a ~a{
	margin-left: 15px;
}
</style>
<body onload="IFrameResize()">
	<div class="location">
		<span>轮换业务</span><span>/</span><span>轮入管理</span><span>/</span><span>进度上报</span>
	</div>
	<div class="container-box clearfix" style="padding: 10px">
		<div class="layui-form" style="position: relative">
			<div class="more_search_box">
				<form class="layui-form" id="test_query_form">
					<input type="hidden" id="name" name="name">
					<h5 style="margin: 16px;">高级搜索</h5>
					<div class="layui-form-item">
						<label class="layui-form-label ">填报单位：</label>
						<div class="layui-input-block"
							style="max-width: none; padding-left: 0; width: 53%;">
							<select name="" lay-verify="">
								<option value="1">a库</option>
								<option value="2">德清库</option>
								<option value="3">中穗库</option>
								<option value="4">张家口库</option>
								<option value="5">d库</option>
								<option value="6">e库</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label ">品种</label>
						<div class="layui-input-block "
							style="max-width: none; padding-left: 0; width: 53%;">
							<select name="" lay-verify="">
								<option value="1">小麦</option>
								<option value="2">玉米</option>
								<option value="3">晚粳稻</option>
								<option value="4">中晚粳稻</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item search-item ">
						<div class="layui-inline">
							<label class="layui-form-label">累计：</label>
							<div class="layui-input-inline">
								<input type="text" name="title" required="" lay-verify=""
									placeholder="" autocomplete="off" class="layui-input"
									style="width: 100%; margin-top: 7px;">
							</div>
							<div class="layui-form-mid">至</div>

							<div class="layui-input-inline">
								<input type="text" name="title" required="" lay-verify=""
									placeholder="" autocomplete="off" class="layui-input"
									style="width: 100%; margin-top: 7px;">
							</div>
						</div>
					</div>
					<div class="layui-form-item search-item ">
						<div class="layui-inline">
							<label class="layui-form-label">完成率（%）：</label>
							<div class="layui-input-inline">
								<input type="text" name="title" required="" lay-verify=""
									placeholder="" autocomplete="off" class="layui-input"
									style="width: 100%; margin-top: 7px;">
							</div>
							<div class="layui-form-mid">至</div>

							<div class="layui-input-inline">
								<input type="text" name="title" required="" lay-verify=""
									placeholder="" autocomplete="off" class="layui-input"
									style="width: 100%; margin-top: 7px;">
							</div>
						</div>
					</div>
					<div class="layui-form-item"
						style="margin-left: 2%; margin-top: 7px;">
						审核状态： <input type="radio" name="sex" value="1" title="全部">
						<input type="radio" name="sex" value="2" title="待提交" checked>
						<input type="radio" name="sex" value="3" title="审核中"> <input
							type="radio" name="sex" value="4" title="已通过"> <input
							type="radio" name="sex" value="5" title="已签发"> <input
							type="radio" name="sex" value="6" title="已驳回">
					</div>
					<div class="btn_box"
						style="border-top: 1px solid #ddd; padding-top: 10px">
						<button class="layui-btn layui-btn-small"
							style="margin-left: 30px; margin-bottom: 5px;">查询</button>
						<button class="layui-btn layui-btn-small back" type="reset"
							style="margin-left: 30px; margin-bottom: 5px;">取消</button>
						<button class="layui-btn layui-btn-small"
							style="margin-left: 30px; margin-bottom: 5px;" type="reset">清空</button>
					</div>
				</form>
			</div>
			<!--</div>-->
			<div class="subject_content">
				<div class="select_box clearfix">
					<div class="layui-inline">
						<div class="layui-form-item pull-left">
							<label class="layui-form-label">姓名：</label>
							<div class="layui-input-block">
								<input id="name_s" lay-verify="" required="必填df"
									class="layui-input">
							</div>
						</div>
					</div>
					<button class="layui-btn layui-btn-small"
						style="margin-left: 30px; margin-bottom: 5px;"
						onclick="pageQuery();">查询</button>
					<span class="more_search">高级查询</span>
					<button class="layui-btn layui-btn-small pull-right" id="dLabel"
						type="button" style="margin-right: 3%"
						onclick="RedirectUrl('test/addPage.shtml')">新增</button>
					<button class="layui-btn layui-btn-small pull-right import"
						id="dLabel" type="button" style="margin-right: 3%">导入</button>
					<button class="layui-btn layui-btn-small pull-right" id="dLabel"
						type="button" style="margin-right: 3%" onclick="exportExcel();">导出</button>
				</div>
				<table id="example2" class="table  table-hover ">
					<thead>
						<tr>
							<th>编号</th>
							<th>姓名</th>
							<th>年龄</th>
							<th>备注</th>
							<th>操作</th>
						</tr>
					</thead>
					<!-- 表格内容start -->
					<tbody class="text-center">

					</tbody>
					<!-- 表格内容 end -->
				</table>
				<div id="demo" class="pages"></div>
			</div>
			</form>
		</div>
		<div class="mask">
			<div class="mask_color"></div>
			<div class="mask_3">
				<form id="form-import" method="post" enctype="multipart/form-data">
					<div class="alert_box layui-form">
						<h4>导入测试</h4>
						<div class="layui-form-item"></div>
						<div class="layui-form-item">
							<label class="layui-form-label"><span class="red"></span>导入格式：</label>
							<div class="layui-input-block">
								<span>.XLS</span>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label"><span class="red"></span>下载模板：</label>
							<div class="layui-input-block">
								<!-- <button type="button" class="btn btn-big-solid detail_btn" onclick="download()">下载附件</button> -->
								<button type="button" class="btn btn-big-solid"
									onclick="download()">下载附件</button>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label"><span class="red">*</span>导入EXCEL：</label>
							<div class="layui-input-block"
								style="padding-top: 5px; max-width: 300px">
								<input type="file" id="excelFile" name="file" width="300px"
									contentEditable="false" /> <span> </span>
							</div>
						</div>
						<div class="btn-box">
							<button class="layui-btn layui-btn-small confirm"
								onclick="importFile();">导入</button>
							<button class="layui-btn layui-btn-small cancel">取消</button>
						</div>
					</div>
				</form>
			</div>
			<div class="mask_content mask_2"
				style="width: 600px; height: 300px; margin: auto; position: absolute; left: 0; top: 0; bottom: 0; right: 0;">
				<div style="height: 20px; margin-top: 10px;">
					<b class="text-left">&nbsp;审批跟踪状态</b>
					<hr style="color: #B0B0B0">
					<div style="position: absolute; right: 10px; top: 10px;">
						<button class="layui-btn layui-btn-small cancel">取消</button>
					</div>
				</div>
				<div style="margin-left: 50px;">
					<div class="operator_info">
						<div class="layui-inline">
							<div class="layui-form-item ">
								<label class="layui-form-label">2015年05月01日</label>
								<div class="layui-input-block"
									style="height: 28px; line-height: 28px"></div>
							</div>
						</div>
						<div class="layui-inline">
							<div class="layui-form-item ">
								<label class="layui-form-label">当前审批人：</label>
								<div class="layui-input-block"
									style="height: 28px; line-height: 28px">分管领导</div>
							</div>
						</div>
						<div class="layui-inline">
							<div class="layui-form-item ">
								<label class="layui-form-label">审批意见：</label>
								<div class="layui-input-block"
									style="max-width: 300px; height: 28px; line-height: 28px">驳回。&nbsp;轮换计划意见中轮换出入库数量不符，且入库粮食质量参数不达标。</div>
							</div>
						</div>
					</div>
				</div>
				<div style="margin-left: 50px;">
					<div class="operator_info">
						<div class="layui-inline">
							<div class="layui-form-item ">
								<label class="layui-form-label">2017年04月02日</label>
								<div class="layui-input-block"
									style="height: 28px; line-height: 28px"></div>
							</div>
						</div>
						<div class="layui-inline">
							<div class="layui-form-item ">
								<label class="layui-form-label">当前审批人：</label>
								<div class="layui-input-block"
									style="height: 28px; line-height: 28px">仓储部经理</div>
							</div>
						</div>
						<div class="layui-inline">
							<div class="layui-form-item ">
								<label class="layui-form-label">审批意见：</label>
								<div class="layui-input-block"
									style="height: 28px; line-height: 28px">同意。</div>
							</div>
						</div>
					</div>
					<div class="yuan"></div>
					<div style="position: absolute; top: 67px; left: 33px;">
						<hr style="width: 2px; height: 93px; color: #3399CC">
					</div>
					<div class="yuan2"></div>
					<div style="position: absolute; top: 170px; left: 33px;">
						<hr style="width: 2px; height: 93px; color: #3399CC">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script>
  //  高级查询
  $(".more_search").click(function(){
    $(".more_search_box").slideDown("slow")
  })
  $(".back").click(function(){
    $(".more_search_box").slideUp("slow")
  })
  //下拉框复选
  $(window).on('load', function () {
    $(".stair dd").click(function(){
      if($(this).text()=="公司"){
        $(".company").show().siblings(".Group").hide()
      }else if($(this).text()=="所属库"){
        $(".warehouse").show().siblings(".Group").hide()
      }else if($(this).text()=="代储企业"){
        $(".storage_spot").show().siblings(".Group").hide()
      }
    })
    $('#usertype').selectpicker({
      'selectedText': 'cat'
    });
    //选中下拉框将选中的内容显示在分发单位处
    $(".Group li").click(function(){
      var timer = setTimeout(function(){
        $(".Group .dropdown-toggle").each(function(){
          if($(this).attr("title")=="请选择"){
            $(this).attr("title","")
          }
        })
        $(".filter-option").text("请选择")
        $(".department .company").html($(".company .dropdown-toggle").attr("title"));
        $(".department .warehouse").html($(".warehouse .dropdown-toggle").attr("title"));
        $(".department .storage_spot").html($(".storage_spot .dropdown-toggle").attr("title"));
      },5)
    });
    pageQuery();
  });
  
  //分页显示
  function pageQuery(){
  	var queryPara = {
	        page:1,//页码
	        pageSize:10,//行数
	        name:$('#name').val()
 	};
 	layuiPage('example2','${ctx}/test/pageQuery.shtml',queryPara,function(obj){
     	return '<tr>'+
	                 '<td><a href="test/detailPage.shtml?id='+obj.id+'">'+obj.id+'</a></td>'+
	                 '<td>'+(obj.name?obj.name:"")+'</td>'+
	                 '<td>'+obj.age+'</td>'+
	                 '<td>'+obj.note+'</td>'+
	                 '<td><a href="test/editPage.shtml?id='+obj.id+'">编辑</a><a class="send">提交</a><a class="delete" onclick="remove(\''+obj.id+'\')">删除</a></td>'+
	                '</tr>';
	});

  }
  
   //点击删除
  function remove(id){
     removeRecord("test/delete.shtml",id,function(){
     	RedirectUrl("test.shtml");
     })
  }
  
  function exportExcel(){
  		$('#name').val($('#name_s').val());
  		$("#test_query_form").attr('action',"test/exportExcel.shtml");
        $("#test_query_form").submit()
  }
  
  function importFile(){
  	if(window.confirm('是否确定导入?')){
		if(checkExcel("excelFile")){
			$('#form-import').attr("action", 'test/importExcel.shtml').submit();
		}	
	}
  }
  
  function download(){
	window.location.href="test/download.shtml";
	}
  
  //点击提交
  $(".send").click(function(){
    layer.msg('提交成功！', {time: 2000, icon:1});
  })
  //导入
  $(".import").click(function(){
    $(".mask").show();
    $(".mask_3").show();
  })
  //点击取消
  $(".cancel").click(function(){
    $(".mask").hide();
    $(".mask_3").hide();
    $(".mask_2").hide();
  })
  //下拉框正常显示
  layui.use('form', function(){
    var form = layui.form();
  });
</script>