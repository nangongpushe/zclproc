<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
.buttonArea{
		padding:5px 15px;
		background:RGB(25,174,136);
		border:none;
		border-radius:5px;
		color:#fff;
		cursor:pointer;
		display:inline;
	}
/* .div{ margin:0 auto;width:400px;height:20px;border:0px solid #000}
.right{width:320px; height:20px;border:0px solid #F00;float:right}  */ 
</style>
<div class="row clear-m">
   <ol class="breadcrumb noprint">
		<li>质量管理</li>
		<li>检验任务</li>
		<li class="active">打印${name}</li>
	</ol>
	<div class="container-box clearfix" style="padding: 10px">
    <!--检验结果表-->
     <form class="form_input"  action="save.shtml" method="post" enctype="multipart/form-data">
     <input type="hidden" name="auvp" value="${auvp}">
     <input type="hidden" name="id"  value="${entity.id }"/>
     <div>
     <div class="div" style="margin:0 auto;width:400px;height:20px;border:0px solid #000">${warehouseName} </div>
     <div class="div" style="margin:0 auto;width:400px;height:20px;border:0px solid #000 ;font-size:25px"><label >粮油质量检测报告</label> </div>
     </div>
     <br>
     <div >
     <label >检测单位(盖章)</label>    <div class="right" style="width:320px; height:20px;border:0px solid #F00;float:right" > <label >NO:${entity.sampleNo }</label></div>
     </div>
        <table class="table table-bordered " id="tableId">
            <!-- 表格内容 start -->
            <tbody>
            <tr>
                <td colspan="4" class="text-center"><span class="red"></span><b>样品名称</b></td>
                <td colspan="4" class="text-center">${entity.variety }</td>
                <td colspan="4" class="text-center"><span class="red"></span><b>仓号</b></td>
                <td colspan="4" class="text-center">${entity.storeEncode }</td>
            </tr>
            <tr>
                <td colspan="4" class="text-center"><span class="red"></span><b>产地</b></td>
                <td colspan="4" class="text-center">${entity.origin }</td>
                <td colspan="4" class="text-center"><span class="red"></span><b>储存方式</b></td>
                <td colspan="4" class="text-center">${entity.storeType }</td>
            </tr>
            <tr>
                <td colspan="4" class="text-center"><span class="red"></span><b>数量(吨)</b></td>
                <td colspan="4" class="text-center">${entity.quantity }</td>
                <td colspan="4" class="text-center"><span class="red"></span><b>质量等级</b></td>
                <td colspan="4" class="text-center">${entityItem[0].grade }</td>
            </tr>
            <tr>
                <td colspan="4" class="text-center"><span class="red"></span><b>收获年份</b></td>
                <td colspan="4" class="text-center">${entity.harvestYear }
                </td>
                <td colspan="4" class="text-center"><span class="red"></span><b>扦样日期</b></td>
                <td colspan="4" class="text-center">${sample.samplingDate }</td>
            </tr>
            <tr>
                <td colspan="4" class="text-center"><span class="red"></span><b>扦样人</b></td>
                <td colspan="4" class="text-center">${sample.samplingPeople }</td>
                <td colspan="4" class="text-center"><span class="red"></span><b>检验日期</b></td>
                <td colspan="4" class="text-center">${entity.testDate }至${entity.testEndDate }</td>
            </tr>
            <tr>
                <td colspan="4" class="text-center"><span class="red"></span><b>检验类型</b></td>
                <td colspan="12" class="text-center">${entity.validType }</td>

            </tr>
            <!-- 表格内容 end -->
            </tbody>
        </table>
        <div class="manage">
        <!-- <body onload="mergeTable(table1,0)"> -->
            <table class="layui-table" id="table1">
						<thead>
							<tr>
								<td colspan="4" class="text-center">检测项名称</td>
								<%--<td colspan="4">等级</td>--%>
								<td colspan="4" class="text-center">最低指标</td>
								<td colspan="4" class="text-center">检测值</td>
								<td colspan="4" class="text-center">单项判定</td>
							</tr>
						</thead>
                <!-- 表格内容start -->
                <tbody id="Detail" class="text-center" >
                <c:forEach items="${entityItem}" var="entityItem">  
                 <tr>
                 	<c:if test="${entityItem.count==''||entityItem.count == null }">
	                <td colspan="4" rowspan="${entityItem.repetition }"  class="text-center">${entityItem.itemName }</td>
                 	</c:if>
	               <%-- <td colspan="4">${entityItem.grade }</td>--%>
	                <td colspan="4" class="text-center">${entityItem.standard }</td>
	                <c:if test="${entityItem.count==''||entityItem.count == null }">
	                <td colspan="4" rowspan="${entityItem.repetition }" class="text-center">${entityItem.result }</td>
	                </c:if>
	                <c:if test="${entityItem.count==''||entityItem.count == null }">
	                <td colspan="4" rowspan="${entityItem.repetition }" class="text-center">${entityItem.remark }</td>
	                </c:if>
                	 
                   </tr>
                    </c:forEach>
                </tbody>
            </table>
         <!--   </body> -->
        </div>
        
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
/* mergeTableqqq(tabObj,0)
function mergeTable(tabObj,colIndex){
            if(tabObj != null){
                var i,j;
                var intSpan;
                var strTemp;
                for(i = 1; i < tabObj.rows.length; i++){
                    intSpan = 1;
                    strTemp = tabObj.rows[i].cells[colIndex].innerText ;
                    for(j = i + 1; j < tabObj.rows.length; j++){
                        if(strTemp == tabObj.rows[j].cells[colIndex].innerText){
                            intSpan++;
                            tabObj.rows[i].cells[colIndex].rowSpan = intSpan;
                            tabObj.rows[j].cells[colIndex].style.display = "none";
                            tabObj.rows[i].cells[3].rowSpan = intSpan;
                            tabObj.rows[j].cells[3].style.display = "none";
                            tabObj.rows[i].cells[4].rowSpan = intSpan;
                            tabObj.rows[j].cells[4].style.display = "none";
                        }else{
                            break;
                        }
                    }
                    i = j - 1;
                }
            }
        } */



//-------------------------------------------------------------------------------------------------------------------------------------------------------
    
 
</script>
