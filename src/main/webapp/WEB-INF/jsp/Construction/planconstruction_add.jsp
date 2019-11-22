<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/AdminHeader.jsp" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style type="text/css">
	#outSide{
		width:94%;
		margin-left:2%;
		padding:1%;
		background:#fff;
		border-top:2px solid #23b7e5;
	}
	
	.infoArea{
		width:100%;
		padding:20px 0;
		border-bottom: 2px solid #e2e2e2;
	}
	
	.title{
		color:RGB(25,174,136);
		font-weight:bold;
	}
	
	#infoArea{
		margin-top:20px;
		margin-left:4%;
	}
	
	#infoArea span{
		padding-right:100px;
	}
	
	.requiredData{
		color:red;
	}
	
	#mainInfo{
		margin-top:20px;
		margin-left:2.5%;
	}
	
	#mainInfo>div{
		padding:10px 0;
		width:100%;
	}
	
	#mainInfo>div span{
		width:10%;
		display:inline-block;
		text-align:center;
	}
	
	.inputArea{
		width:89%;
		padding:5px;
		outline: none;
		border:1px solid #ccc;
		resize: none;
	}
	
	.buttonArea{
		padding:5px 15px;
		background:#009688;
		border:none;
		color:#fff;
		cursor:pointer;
		display:inline;
	}
	
	#listArea{
		padding:20px 0;
		width:100%;
	}
	
	table{
		margin-top:20px;
		width:100%;
		text-align:center;
	}
	
	thead{
		background:#f2f2f2;
	}
	
	table tr td{
		width:6.5%;
		border:1px solid #e2e2e2;
		padding:10px 0;
	}
	
	#bottom-button{
		text-align:right;
		padding-right:20px;
		margin-top:20px;
	}
	
	#bottom-button>div{
		margin-right:10px;
	}
	
	#template-tr{
		display:none;
	}
	
#float-alert{
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:RGBA(0,0,0,0.75);
	z-index:400;
	display:none;
}

#table-wapper{
	display:none;
	margin:0 auto;
	margin-top:100px;
	background:#fff;
	border-top:1px solid RGB(42, 180, 168);
	padding:1%; 
	width:38.5%;
	height:200px;
} 

#table-wapper>textarea{
	margin-top:10px;
	width:99%;
}

#close-float-alert{
	position:relative;
	left:84%;
	font-size: 30px; 
	color:RGB(42, 180, 168);
	cursor: pointer;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>基建管理</li>
		<li>年度计划</li>
		<li class="active">
		<c:choose>
			<c:when test="${plan.id != null }">编辑</c:when>
			<c:otherwise>新增</c:otherwise>
		</c:choose>
		</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<span class="title">填报人信息</span>
		<div id="infoArea">
			<span>经办部门：${plan.department }</span>
			<span>经办人：${plan.creator }</span> 
			<span>经办时间：<fmt:formatDate value="${plan.createDate }" pattern="yyyy年MM月dd日"/> </span>
		</div>
	</div>
	<form id="data" action="Add.shtml" method="Post" enctype="multipart/form-data">
	<div id="dataArea" class="infoArea">
		<span class="title">年度方案信息</span>
		<div id="mainInfo">
			<div>
				<span style="text-align: right"><b class="requiredData">*</b>年份：</span>
				<input class="inputArea yearNeed" value='<fmt:formatDate value="${plan.createDate }" pattern="yyyy"/>' name="year"/>
			</div>
			<div>
				<span style="text-align: right"><b class="requiredData">*</b>项目单位：</span>
				<!-- <input class="inputArea" id="souce-plan" name="projectUnit" value="${plan.projectUnit}" readonly/> -->
				<input type="hidden" name="projectUnit" id="projectUnit" value="${plan.projectUnit}">
				
				<select name="warehouseId"class="inputArea"  id="souce-plan" lay-verify="required" lay-filter="encode">
	           			<option value="">请选择</option>
	           			<c:forEach items="${projectUnitList}" var="item">
	           				<option value="${item.warehouseCode}" <c:if test = "${plan.warehouseId eq item.warehouseCode}">selected</c:if>>${item.warehouseShort}</option>
	           			</c:forEach>
	            </select>
				
			</div>
			<div>
				<span style="text-align: right"><b class="requiredData">*</b>投资额度：</span>
				<select class="inputArea" name="fromTarget">
					<option <c:if test="${plan.fromTarget == null }">selected</c:if> value="true">大于10万</option>
					<option <c:if test="${plan.fromTarget == 'base' }">selected</c:if> value="false">小于10万</option>
				</select>
			</div>
		</div>
	</div>
	<div id="listArea">
		<div class="buttonArea" id="add-list">新增</div>
		<div class="buttonArea" id="import-data">导入</div>
		<a class="buttonArea" href="${ctx}/sysFile/downloadTemplate.shtml?filename=年度计划导入模板">模板下载</a>
		<table>
			<thead>
				<tr>
					<td rowspan="2">序号</td>
					<td rowspan="2">项目名称</td>
					<td rowspan="2">建设内容</td>
					<td rowspan="2">建设年限起</td>
					<td rowspan="2">建设年限止</td>
					<td rowspan="2">建设性质</td>
					<td rowspan="2">总投资(万元)</td>
					<td rowspan="2">资金来源</td>
					<td colspan="2">上年底累计完成</td>
					<td colspan="3">本年计划</td>
					<td rowspan="2">备注</td>
					<td rowspan="2">操作</td>
				</tr>
				<tr>
					<td>财务支出(万元)</td>
					<td>投资额(万元)</td>
					<td>财务支出(万元)</td>
					<td>投资额(万元)</td>
					<td>形象进度</td>
				</tr>
			</thead>
			<tbody id="data-result">
				<tr id="template-tr">
					<td name="serial">
						<input class="inputArea"/>
					</td>
					<td name='projectName'>
						<select class="inputArea" id="projectName_tmp">
						<option value="">请选择</option>
						<c:forEach items="${projectList}" var="project">
							<option tag="${project.plannedInvestment }" value="${project.id}">${project.projectName }</option>
						</c:forEach>
						</select>
					</td>
					<td name='constructionContent'>
						<input class="inputArea"/>
					</td>
					<td name='constructionStart'>
						<input class="inputArea timeCheckStart laydate">
					</td>
					<td name='constructionEnd'>
						<input class="inputArea timeCheckEnd laydate">
					</td>
					<td name='constructionNature'>
						<select class="inputArea">
							<option>新建</option>
							<option>续建</option>
							<option>其他</option>
						</select>
					</td>
					<td name='investment'>
						<input class="inputArea" type="number"/>
					</td>
					<td name='fundsProvid'>
						<input class="inputArea"/>
					</td>
					<td name='lastExpend'>
						<input class="inputArea lessZore" tag="notRequired" type="number"/>
					</td>
					<td name='lastInvestment'>
						<input class="inputArea lessZore" tag="notRequired" type="number"/>
					</td>
					<td name='currentExpend'>
						<input class="inputArea lessZore" type="number"/>
					</td>
					<td name='currentInvestment'>
						<input class="inputArea lessZore" type="number"/>
					</td>
					<td name='currentProgress'>
						<input class="inputArea lessZore" tag="notRequired"  maxlength="200" type="text"/>
					</td>
					<td name='remark'>
						<div class="buttonArea remark">备注</div>
						<textarea style="display:none;"></textarea>
					</td>
					<td><div class="buttonArea remove-detail">删除</div></td>
				</tr>
				<c:forEach items="${plan.planDetail }" var="item">
				<tr class="data-tr" tag="${item.id }">
					<td name="serial">
						<input class="inputArea" value="${item.serial }"/>
					</td>
					<td name='projectName'>
						<select class="inputArea">
						<option value="">请选择</option>
						<c:forEach items="${projectList}" var="project">
							<option tag="${project.plannedInvestment }" value="${project.id}" <c:if test="${item.projectName eq project.projectName}">selected</c:if>>${project.projectName }</option>
						</c:forEach>
						</select>
					</td>
					<td name='constructionContent'>
						<input class="inputArea"  value="${item.constructionContent }"/>
					</td>
					<td name='constructionStart'>
						<input class="inputArea timeCheckStart laydate" value="${item.constructionStart}">
					</td>
					<td name='constructionEnd'>
						<input class="inputArea timeCheckEnd laydate" value="${item.constructionEnd}">
					</td>
					<td name='constructionNature'>
						<select class="inputArea">
							<option <c:if test="${item.constructionNature eq '新建' }">selected</c:if>>新建</option>
							<option <c:if test="${item.constructionNature eq '续建' }">selected</c:if>>续建</option>
							<option <c:if test="${item.constructionNature eq '其他' }">selected</c:if>>其他</option>
						</select>
					</td>
					<td name='investment'>
						<input class="inputArea lessZore" value="${item.investment }"/>
					</td>
					<td name='fundsProvid'>
						<input class="inputArea" value="${item.fundsProvid }"/>
					</td>
					<td name='lastExpend'>
						<input class="inputArea lessZore" tag="notRequired" value="${item.lastExpend }" type="number"/>
					</td>
					<td name='lastInvestment'>
						<input class="inputArea lessZore" tag="notRequired" value="${item.lastInvestment }" type="number"/>
					</td>
					<td name='currentExpend'>
						<input class="inputArea lessZore" value="${item.currentExpend }" type="number"/>
					</td>
					<td name='currentInvestment'>
						<input class="inputArea lessZore" value="${item.currentInvestment }" type="number"/>
					</td>
					<td name='currentProgress'>
						<input class="inputArea lessZore" tag="notRequired" value="${item.currentProgress }"/>
					</td>
					<td name='remark'>
						<div class="buttonArea remark">备注</div>
						<textarea style="display:none;">${item.remark }</textarea>
					</td>
					<td><div class="buttonArea remove-detail">删除</div></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="bottom-button">
			<div class="buttonArea" id="save">
			<c:choose>
				<c:when test="${plan.id != null }">
					编辑
				</c:when>
				<c:otherwise>
					保存
				</c:otherwise>
			</c:choose>
			</div>
			<div class="buttonArea" id="cancel">取消</div>
		</div>
	</div>
	</form>
	<form id="file-import" enctype="multipart/form-data">
		<input style="display:none" name="file" type="file" id="import-file"/> 
	</form>
</div>
<div id="float-alert">
	<div id="table-wapper">
		<span class="title">明细备注</span>
		<i id="close-float-alert" class="layui-icon">&#x1006;</i>
		<textarea rows="4" name="data-show"  maxlength="200" class="inputArea"></textarea>
		<div style="text-align:right;margin-top:10px;">
			<div class="buttonArea" id="add-tolist">确认</div>
		</div>
	</div>
</div>
<script>
	var laydate=layui.laydate;
	laydate.render({
	  elem: '.yearNeed',
	  type: 'year'
	});

	// laydate.render({
	//   elem: '.timeCheckStart',
	//   type: 'year',trigger: 'click'
	// });
    //
	// laydate.render({
	//   elem: '.timeCheckEnd',
	//   type: 'year',trigger: 'click'
	// });

    $(".timeCheckEnd").each(function(){
        laydate.render({
            elem:$(this)[0],
            type:"year",
            format:"yyyy",trigger: 'click'
            ,change: function(value, date, endDate){
                this.elem.val(value);
                if($(".layui-laydate").length){
                    $(".layui-laydate").remove();
                }
                $(".timeCheckEnd").blur();
            }
        });
    });
    $(".timeCheckStart").each(function(){
        laydate.render({
            elem:$(this)[0],
            type:"year",
            format:"yyyy",trigger: 'click'
            ,change: function(value, date, endDate){
                this.elem.val(value);
                if($(".layui-laydate").length){
                    $(".layui-laydate").remove();
                }
                $(".timeCheckStart").blur();
            }
        });
    });

    investmentAmountsListener($(".data-tr>td[name='projectName']").find("select"));
	// $(".data-tr>td[name='projectName']").find("select>option").each(function(){
	// 	if($("[name='fromTarget']").val() == 'true'){
	// 		if(Number($(this).attr('tag')) >= 10){
	// 			$(this).show();
	// 		}else{
	// 			$(this).hide();
	// 		}
	// 	}else{
	// 		if(Number($(this).attr('tag')) < 10){
	// 			$(this).show();
	// 		}else{
	// 			$(this).hide();
	// 		}
	// 	}
	// });
	
	$('#souce-plan').click(function(){
        if($(".data-tr").length > 0){
            layer.msg("请删除相关明细再修改",{time:2000});
            $(this).blur();
            return;
        }
	});

	$('#souce-plan').change(function(){

        if($(this).val() == ""){
            $("#template-tr:not(.data-tr) #projectName_tmp").empty();
            $("#template-tr:not(.data-tr) #projectName_tmp").append("<option value=''>请选择</option>")
            return;
        }

        var selectedOpt = $("#souce-plan option:selected"); //获取选中的项
        $("#projectUnit").val(selectedOpt.text());

        var url = "${ctx}/Construction/listConstructionProjectByProjectUnit.shtml";
        var unitId = $("#souce-plan").val();
        var unitName = $("#projectUnit").val();
        var data = "projectUnitId="+unitId+"&projectUnitName="+unitName;
        layer.load(2);
		$.getJSON(url,data,function(jsonObj){
		    layer.closeAll("loading");
            var selObj = $("#template-tr:not(.data-tr) #projectName_tmp");
            selObj.empty();
            selObj.append("<option value=''>请选择</option>");
			if(jsonObj && jsonObj.length > 0){
			    $.each(jsonObj,function(index){
			       var opt = new Option(jsonObj[index].projectName,jsonObj[index].id);
			       $(opt).attr("tag",jsonObj[index].plannedInvestment || '0');
			       selObj.append($(opt));
				});
                investmentAmountsListener(selObj);
			}else{
			    layer.msg("未查询到相关项目",{time:2000});
			}
		});
    });
    
    

	$(".timeCheckStart").blur(function(){

		var end = $(this).parent().next().find("input");
		if($(end).val() != '' && $(this).val()){
			var st = parseInt($(end).val().replace(/[^0-9]/ig,""));
			var start = parseInt($(this).val().replace(/[^0-9]/ig,""));
		console.log(start,st);
			if(start>st){
				layer.msg("结束时间不能大于开始时间");
				$(this).val("");
			}
		}
	});
	$(".timeCheckEnd").blur(function(){
	   //debugger
		var start = $(this).parent().prev().find("input");
		if($(start).val() != '' && $(this).val()){
			var st = parseInt($(start).val().replace(/[^0-9]/ig,""));
			var end = parseInt($(this).val().replace(/[^0-9]/ig,""));
            if(end<st){
				layer.msg("结束时间不能大于开始时间");
				$(this).val("");
			}
		}
	});


	$("#import-data").click(function(){
		$("#import-file").click();
	});
	
	$("[name='fromTarget']").focus(function(){
		if($(".data-tr").length>0){
			layer.msg("请删除明细后再更改投资额度",{icon:0});
			$(this).attr("disabled","disabled");
		}
	});
	
	$("[name='fromTarget']").change(investmentAmountsListener);

	function investmentAmountsListener(node){

	    var selNode = node;
	    if(selNode.data == null){
            selNode = $("td[name='projectName']").find("select");
		}

	    $(selNode).children().each(function(){
            if($(this).val() == ""){
                return true;
            }

            if($("[name='fromTarget']").val() == 'true'){
                if(Number($(this).attr('tag')) >= 10){
                    $(this).show();
                }else{
                    $(this).hide();
                }
            }else{
                if(Number($(this).attr('tag')) < 10){
                    $(this).show();
                }else{
                    $(this).hide();
                }
            }
		});
        // $("td[name='projectName']").find("select>option").each(function(){
        //     if($(this).val() == ""){
        //         return true;
        //     }
        //
        //     if($("[name='fromTarget']").val() == 'true'){
        //         if(Number($(this).attr('tag')) >= 10){
        //             $(this).show();
        //         }else{
        //             $(this).hide();
        //         }
        //     }else{
        //         if(Number($(this).attr('tag')) < 10){
        //             $(this).show();
        //         }else{
        //             $(this).hide();
        //         }
        //     }
        // });
	}
	
	$("#import-file").change(function(){
		$("#file-import").ajaxSubmit({
			url:"${ctx}/Construction/Plan/ImportExcel.shtml",
			type:"post",
			success:function(data){
				if(data.success){
					var result = data.list;
					for(var i=0;i<result.length;i++){
						var template = $("#template-tr").clone(true);
						$(template).addClass("data-tr");
						$(template).removeAttr("id");
						
						$(template).find("td[name='serial']>input").val(result[i].serial);
						$(template).find("td[name='projectName']>select").find("option").each(function(){if($(this).text() == result[i].projectName)$(this).attr("selected","selected")});
						$(template).find("td[name='constructionContent']>input").val(result[i].constructionContent);
						$(template).find("td[name='constructionStart']>input").val(result[i].constructionStart);
						$(template).find("td[name='constructionEnd']>input").val(result[i].constructionEnd);
						$(template).find("td[name='constructionNature']>select").find("option").each(function(){if($(this).text() == result[i].constructionNature)$(this).attr("selected","selected")});
						$(template).find("td[name='investment']>input").val(result[i].investment);
						$(template).find("td[name='fundsProvid']>input").val(result[i].fundsProvid);
						$(template).find("td[name='lastExpend']>input").val(result[i].lastExpend);
						$(template).find("td[name='lastInvestment']>input").val(result[i].lastInvestment);
						$(template).find("td[name='currentExpend']>input").val(result[i].currentExpend);
						$(template).find("td[name='currentInvestment']>input").val(result[i].currentInvestment);
						$(template).find("td[name='currentProgress']>input").val(result[i].currentProgress);
						$(template).find("td[name='remark']>textarea").html(result[i].remark);
						
						$("#data-result").append($(template));
                        $(".timeCheckStart:last").removeAttr("lay-key");
                        layui.use('laydate', function(){
                            var laydate = layui.laydate;
                            //执行一个laydate实例
                            $('.timeCheckStart').each(function(){
                                laydate.render({
                                    elem: this,
                                    trigger: 'click',
                                    type:"year",
                                    change: function(value, date, endDate){
                                        this.elem.val(value);
                                        if($(".layui-laydate").length){
                                            $(".layui-laydate").remove();
                                        }
                                        $(".timeCheckStart").blur();
                                    }
                                });
                            });
                        });

                        $(".timeCheckEnd:last").removeAttr("lay-key");
                        layui.use('laydate', function(){
                            var laydate = layui.laydate;
                            //执行一个laydate实例
                            $('.timeCheckEnd').each(function(){
                                laydate.render({
                                    elem: this,
                                    trigger: 'click',
                                    type:"year",
                                    change: function(value, date, endDate){
                                        this.elem.val(value);
                                        if($(".layui-laydate").length){
                                            $(".layui-laydate").remove();
                                        }
                                        $(".timeCheckEnd").blur();
                                    }
                                });
                            });
                        });
						$(template).show(500);
					}
					if(data.msg.search("不包含") != -1){
                    	layer.msg("项目列表中不包含所填写的项目名称请在下面重新选择",{icon:0});
                    }
                }else{
					layer.msg(data.msg,{icon:0});
				}
			},
			error:function(){
				layerMsgError("不符合规则的Excel文件");
			}
		});
	});
	
	$("#save").click(function(){
		var patchAll = true;
		$("[name='fromTarget']").removeAttr("disabled");
		$(".requiredData").parent().parent().find("input,select").each(function(){
			if($(this).val() == ""){
				alert("*项为必填项,请补全相关信息");
				patchAll = false;
				return false;
			}
		});
		$(".data-tr").each(function(){
			$(this).find("input").each(function(){
				if($(this).val() == "" && $(this).attr("tag") != 'notRequired'){
					alert("*项为必填项,请补全相关信息");
					patchAll = false;
					return false;
				}
			});
		});
		if($(".data-tr").length == 0){
			layer.msg("明细至少需要一条",{icon:0});
			return false;
		}
		if(!patchAll)
			return;
		var detailData = [];
		var   falg=0;
		$(".data-tr").each(function(){
            var projectName=$(this).find("td[name='projectName']").find("select").val();
            if(projectName==""){
                alert("项目名称不能为空")
                falg=1;
                return false;
            }

            var investment=parseFloat($(this).find("td[name='investment']").find("input").val());
            var currentInvestment=parseFloat($(this).find("td[name='currentInvestment']").find("input").val());
            var currentExpend=parseFloat($(this).find("td[name='currentExpend']").find("input").val());

            if(investment<currentInvestment||investment<currentExpend){
                alert("本年计划投资不可以大于总投资")
				falg=1;
				return false;
			}

            detailData.push({
				"id":$(this).attr("tag") == ""?0:$(this).attr("tag"),
				"serial":Number($(this).find("td[name='serial']").find("input").val()),
				"projectName":$(this).find("td[name='projectName']").find("select option:selected").text(),
                "projectId":$(this).find("td[name='projectName']").find("select").val(),
				"constructionContent":$(this).find("td[name='constructionContent']").find("input").val(),
				"constructionStart":$(this).find("td[name='constructionStart']").find("input").val(),
				"constructionEnd":$(this).find("td[name='constructionEnd']").find("input").val(),
				"constructionNature":$(this).find("td[name='constructionNature']").find("select").val(),
				"investment":parseFloat($(this).find("td[name='investment']").find("input").val()),
				"fundsProvid":$(this).find("td[name='fundsProvid']").find("input").val(),
				"lastExpend":parseFloat($(this).find("td[name='lastExpend']").find("input").val()),
				"lastInvestment":parseFloat($(this).find("td[name='lastInvestment']").find("input").val()),
				"currentExpend":parseFloat($(this).find("td[name='currentExpend']").find("input").val()),
				"currentInvestment":parseFloat($(this).find("td[name='currentInvestment']").find("input").val()),
				"currentProgress":$(this).find("td[name='currentProgress']").find("input").val(),
				"remark":$(this).find("td[name='remark']").find("textarea").val(),
			});
		});
		if(falg==1){
		    return;
		}
		layer.load();
		if($(this).html().indexOf('保存')!=-1){
			$("#data").ajaxSubmit({
				type:"post",
				data:{
					"detailList":JSON.stringify(detailData)
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Plan/View.shtml?identity=${ident}";
						});
					}
				}
			});
		}else if($(this).html().indexOf('编辑')!=-1){
			$("#data").ajaxSubmit({
				url:"Edit.shtml",
				data:{
					"detailList":JSON.stringify(detailData),
					"id":"${plan.id}"
				},
				type:"post",
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Plan/View.shtml?identity=${ident}";
						});
					}
				}
			});
		}else{
			return false;
		}
	});
	
	$("#add-list").click(function(){
		var template = $("#template-tr").clone(true);
		$(template).addClass("data-tr");
        $("#data-result").append($(template));
        $(".timeCheckStart:last").removeAttr("lay-key");
        layui.use('laydate', function(){
            var laydate = layui.laydate;
            //执行一个laydate实例
            $('.timeCheckStart').each(function(){
                laydate.render({
                    elem: this,
                    trigger: 'click',
                    type:"year",
                    change: function(value, date, endDate){
                        this.elem.val(value);
                        if($(".layui-laydate").length){
                            $(".layui-laydate").remove();
                        }
                        $(".timeCheckStart").blur();
                    }
                });
            });
        });
        $(".timeCheckEnd:last").removeAttr("lay-key");
        layui.use('laydate', function(){
            var laydate = layui.laydate;
            //执行一个laydate实例
			//debugger
            $('.timeCheckEnd').each(function(){
                laydate.render({
                    elem: this,
                    trigger: 'click',
                    type:"year",
                    change: function(value, date, endDate){
                        this.elem.val(value);
                        if($(".layui-laydate").length){
                            $(".layui-laydate").remove();
                        }
                        $(".timeCheckEnd").blur();
                    }
                });
            });
        });


		$(template).show(200);
	});
	
	$(".remove-detail").click(function(){
		$(this).parent().parent().hide(200,function(){
			$(this).remove();
		});

		if($(".data-tr").length == 1){
			$("[name='fromTarget']").removeAttr("disabled");
		}
	});
	
	$(".remark").click(function(){
		$(this).attr("tag","true");
		var data = $(this).next("textarea").val();
		$("#table-wapper").find("textarea").val(data);
		$("#float-alert").slideToggle(500,function(){
			$("#table-wapper").slideToggle(500);			
		});
	});
	
	$("#close-float-alert").click(function(){
		$(".remark[tag='true']").removeAttr("tag");
		$("#table-wapper").slideToggle(500,function(){
			$("#float-alert").slideToggle(500);			
		});
	});
	
	$("#add-tolist").click(function(){
		var textarea = $("#table-wapper").find("textarea");
		$(".remark[tag='true']").next("textarea").val($(textarea).val());
		$(".remark[tag='true']").removeAttr("tag");
		$("#table-wapper").slideToggle(500,function(){
			$("#float-alert").slideToggle(500);			
		});
	});
	
	$(".lessZore").blur(function(){
		if($(this).val() != ''){
			var value = parseFloat($(this).val());
			if(value < 0){
				layer.msg("数值不可小于0");
				$(this).val("");
			}
		}
	});

	$("#cancel").click(function(){
		layer.confirm('你确定要放弃编辑吗？', {
			btn: ['是','否']
		}, function(){
		  	window.location.href = "${ctx}/Construction/Plan/View.shtml?identity=${ident}";
		}, function(){
		  
		});
	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>