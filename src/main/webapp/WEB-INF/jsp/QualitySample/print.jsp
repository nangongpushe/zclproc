<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="../common/AdminHeader.jsp"%>
<style>
    @media print{
        input,.noprint{
            display:none
        }
        .printonly{
            display:block;
            width:100%
        }
    }
    @page {
        size: auto;  /* auto is the initial value */
        margin: 0mm; /* this affects the margin in the printer settings */
    }
</style>
<div class="row clear-m">
  <ol class="breadcrumb noprint">
		<li>位置：</li>
		<li>质量管理</li>
		<li class="active">打印样品信息</li>
	</ol>
	<div class="container-box clearfix" style="padding: 10px">
    <!--检验结果表-->
     <form class="form_input"  action="save.shtml" method="post" enctype="multipart/form-data">
     <input type="hidden" name="auvp" value="${auvp}">
     <input type="hidden" name="id"  value="${QualitySample.id }"/>

        <table class="table table-bordered">
            <!-- 表格内容 start -->
            <tbody>
             <tr>
                    <td class="text-right"><span class="red"></span><b> 样品编号：</b></td>
                    <td>${QualitySample.sampleNo }
                    </td>
                  	 <td class="text-right"><span class="red"></span><b> 数量(吨)：</b></td>
                    <td>${QualitySample.quantity }
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red"></span><b> 样品来源：</b></td>
                    <td>${QualitySample.sampleSouce }
                    </td>
                  	 <td class="text-right"><span class="red"></span><b> 任务执行人：</b></td>
                    <td>${QualitySample.executor }
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red"></span><b> 储存方式：</b></td>
                    <td>${QualitySample.storeType }
                    </td>
                  	 <td class="text-right"><span class="red"></span><b> 仓/罐号：</b></td>
                    <td>${QualitySample.storehouse }
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><span class="red"></span><b> 粮食品种：</b></td>
                    <td>${QualitySample.variety }
                    </td>
                  	 <td class="text-right"><span class="red"></span><b> 收获年份：</b></td>
                    <td>${QualitySample.harvestYear }
                    </td>
                </tr>
                 <tr>
                	<td class="text-right"><span class="red"></span><b> 检验时间：</b></td>
                    <td>${QualitySample.testDate }
                    </td>
                    <td class="text-right"><span class="red"></span><b> 扦样日期：</b></td>
                    <td>${QualitySample.samplingDate }</td>
                </tr> 
                <tr>
                    <td class="text-right"><span class="red"></span><b> 扦样人：</b></td>
                    <td>${QualitySample.samplingPeople }</td>
                    <td class="text-right"><span>&nbsp;&nbsp;</span><b>任务优先级：</b></td>
                    <td colspan="3">${QualitySample.taskPriority }</td>
                  	<%--<td class="text-right"><span class="red"></span><b> 检验人：</b></td>
                    <td>${QualitySample.testPeople }</td>--%>

                </tr>
                <tr>
                    <td class="text-right"><span class="red"></span><b> 产地：</b></td>
                    <td>${QualitySample.origin }
                  	<td class="text-right"><span class="red"></span><b> 检验状态：</b></td>
                    <td>${QualitySample.testStatus }
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><span>&nbsp;&nbsp;</span><b>备注：</b></td>
                    <td colspan="3">${QualitySample.remark }</td>
                </tr>
               <<%--tr>
                   <td class="text-right"><span>&nbsp;&nbsp;</span><b>任务优先级：</b></td>
                   <td colspan="3">${QualitySample.taskPriority }</td>
                </tr>--%>
            <!-- 表格内容 end -->
            </tbody>
        </table>
        <p class="btn-box text-center">
             <button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
            <button type="button" id="btnPrint"  class="layui-btn layui-btn-primary layui-btn-small ">打印</button>
        </p>
  

    </form>
    <div class="jumpPage" id="displayPage"></div>
</div>
</div>

<script>
	
	 $("#cancel").click(function(){
		layer.confirm('您是否要放弃', function(index) {
				history.go(-1);
			});
		
	});

	 $("#btnPrint").click(function(){
		$('#cancel').hide();
		$('#btnPrint').hide();
         window.print();
         $('#cancel').show();
		$('#btnPrint').show();	
	});
	

	
</script>
