<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/AdminHeader.jsp"%>
<div class="row clear-m">
	<ol class="breadcrumb">


<c:if test="${type==''}">
	<li>仓储管理</li>
	<li>粮油情监测管理</li>
	<li><a href="${ctx }/storageGrainInspection.shtml">粮情检测记录</a></li>

</c:if>
<c:if test="${type=='dc'}">
	<li>代储监管</li>
	<li>报表台账</li>

	<li><a href="${ctx }/storageGrainInspection.shtml">粮情检测记录</a></li>
</c:if>
	</ol>
</div>

<style>
.layui-form-label{
	width:200px;
	text-align:right;
}
</style>

<div class="container-box clearfix" style="padding: 10px">
	<!--检验结果表-->
    <form class="layui-form" id="form" lay-filter="form">
    	<input type="hidden" name="id" value="${grainInspection.id }"/>
		<input type="hidden" value="${type}" id="type" name="type">
        <div class="layui-form-item">
        	<div class=" layui-inline">
	        	<label class="layui-form-label"><span class="red">*</span>所属库点：</label>
					<div class="layui-input-inline">
						<input type="hidden" name="warehouseCode"
							   <c:if test="${auvp eq 'a' }">value="${warehouseShort }"</c:if>
							   <c:if test="${auvp ne 'a' }">value="${grainInspection.warehouseCode }"</c:if>
						/>
						<input type="hidden" name="warehouseId"
							   <c:if test="${auvp eq 'a' }">value="${user.wareHouseId }"</c:if>
							   <c:if test="${auvp ne 'a' }">value="${grainInspection.warehouseId }"</c:if>
						/>
						<input lay-verify="required" class="layui-input" autocomplete="off" name="warehouse" readonly
							<c:if test="${auvp eq 'a' }">value="${user.shortName }"</c:if>
							<c:if test="${auvp ne 'a' }">value="${grainInspection.warehouse }"</c:if>
						>
				</div>
			</div>
			
			<div class=" layui-inline">
            	<label class="layui-form-label"><span class="red">*</span>仓房编号：</label>
	             <div class="layui-input-inline">
	             	<select name="encode"class="layui-input" lay-verify="required" lay-filter="encode">
	           			<option value=""></option>
	           			<c:forEach items="${storehouseEncodeArray }" var="item">
	           				<option value="${item }" <c:if test = "${grainInspection.encode eq item }">selected</c:if>>${item }</option>
	           			</c:forEach>
	            	</select>
	            </div>
            </div>
            
        </div>
        <div class=" layui-form-item">
        	<div class=" layui-inline">
            	<label class="layui-form-label"><span class="red">*</span>填报日期：</label>
            	<div class="layui-input-inline">
            		<input lay-verify="required" type="text" class="layui-input date-need" 
            		placeholder="&#45;&#45;请选择&#45;&#45;" name="reportDate" value="<fmt:formatDate value='${grainInspection.reportDate }' 
            		type='date' pattern='yyyy-MM-dd'/>" readonly/>
            	</div>
            </div>
            <div class=" layui-inline">
            	<label class="layui-form-label"><span class="red">*</span>天气：</label>
            	<div class="layui-input-inline">
            		<select name="weather" lay-verify="required">
            			<option value=""></option>
            			<option value="阴" <c:if test = "${grainInspection.weather eq '阴' }">selected</c:if>>阴</option>
            			<option value="晴" <c:if test = "${grainInspection.weather eq '晴' }">selected</c:if>>晴</option>
						<option value="雨" <c:if test = "${grainInspection.weather eq '雨' }">selected</c:if>>雨</option>
						<option value="雪" <c:if test = "${grainInspection.weather eq '雪' }">selected</c:if>>雪</option>
            		</select>
                </div>
            </div>
        </div>
        <div class=" layui-form-item">
        	<div class=" layui-inline">
            	<label class="layui-form-label"><span class="red">*</span>实际数量（吨）：</label>
            	<div class="layui-input-inline">
            		<input lay-verify="number" type="text" id="actualAmount" maxlength="10" oninput="optionProperties(this.id);" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);"  style="background:#CCCCCC" step="0.1" class="layui-input" name="quantity" value="${grainInspection.quantity }" placeholder="--请输入--"/>
            	</div>
        	</div>
			<div class=" layui-inline">
					<label class="layui-form-label"><span class="red" id="wt">*</span>仓温（℃）：</label>
				<div class="layui-input-inline">
					<input lay-verify="required" id="bg01" type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" placeholder="--请输入--"
						   name="storehouseTemp" value="${grainInspection.storehouseTemp }"/>
				</div>
			</div>
        	<%--<div class=" layui-inline">
             <label class="layui-form-label"><span class="red"></span>水分（%）：</label>
             	<div class="layui-input-inline">
             		<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
             		name="dew" value="${grainInspection.dew }"/>
             	</div>
         	</div>--%>
        </div>
			<%--<div class=" layui-form-item">
				&lt;%&ndash;<div class=" layui-inline">
            	<label class="layui-form-label"><span class="red"></span>杂质（%）：</label>
            	<div class="layui-input-inline">
            		<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
            		name="impurity" value="${grainInspection.impurity }"/>
            	</div>
            </div>&ndash;%&gt;
			</div>--%>
			<div class=" layui-form-item">
				<div class=" layui-inline">
	            	<label class="layui-form-label"><span class="red" id="at">*</span>气温（℃）：</label>
	                <div class="layui-input-inline">
	                	<input lay-verify="required" id="bg02" type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" placeholder="--请输入--"
	                	name="temperature" value="${grainInspection.temperature }"/>
	                </div>
				</div>
                <div class=" layui-inline">
                	<label class="layui-form-label"><span class="red" id="wet">*</span>仓湿（RH%）：</label>
                	<div class="layui-input-inline">
                		<input lay-verify="required" id="bg03" type="text" onkeyup="clearNoNum1(this);" onblur="checkAmounts(this);" class="layui-input" placeholder="--请输入--"
                		name="storehouseWet" value="${grainInspection.storehouseWet }"/>
                	</div>
                </div>
            </div>
            <div class=" layui-form-item">
            	<div class=" layui-inline">
                	<label class="layui-form-label"><span class="red" id="qet">*</span>气湿（RH%）：</label>
                	<div class="layui-input-inline">
                		<input lay-verify="required" id="bg04" type="text" onkeyup="clearNoNum1(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" placeholder="--请输入--"
                		name="airWet" value="${grainInspection.airWet }"/>
                	</div>
            	</div>

				<div class=" layui-inline">
					<label class="layui-form-label"><span class="red" id="gva">*</span>粮食品种：</label>
					<div class="layui-input-inline">
						<select name="grainType" lay-verify="required" lay-filter="grainType" id="bg05">
							<option value="">--请选择--</option>
							<c:forEach var="item" items="${grainTypes}">
								<option value="${item.value}" <c:if test = "${grainInspection.grainType eq item.value }">selected</c:if>>${item.value}</option>
							</c:forEach>
						</select>
					</div>
				</div>
            </div>
            
            <!-- <fieldset class="layui-elem-field layui-field-title">
  				<legend>粮温检查情况：</legend>
			</fieldset> -->
			
			<div class="layui-row title">
				<h5>粮温检查情况：</h5>
			</div>

			<table class="layui-table" id="temp">
				<thead>
				<tr>
					<th style="width:10%;text-align: center">层数</th>
					<th style="text-align: center">最高(℃)</th>
					<th style="text-align: center">最低(℃)</th>
					<th style="text-align: center">平均(℃)</th>
				</tr>
				</thead>
				<!-- 表格内容start -->
				<tbody id="materialDetail" class="text-center">
				<c:forEach items="${storageGrainInspectionTemps}" var="storageGrainInspectionTemp" varStatus="idxStatus">

					<tr><td style="width:6%" ><input type="hidden" name="storageGrainInspectionTemp[${idxStatus.index}].placeId" value="${storageGrainInspectionTemp.placeId}"lay-verify="" style="width:0px;"/>第${idxStatus.count}层</td>
						<td ><input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" name="storageGrainInspectionTemp[${idxStatus.index}].topMax" value="${storageGrainInspectionTemp.topMax}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
						<td ><input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" name="storageGrainInspectionTemp[${idxStatus.index}].topMin" value="${storageGrainInspectionTemp.topMin}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
						<td ><input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" name="storageGrainInspectionTemp[${idxStatus.index}].topAvg" value="${storageGrainInspectionTemp.topAvg}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
						<%--<input type="hidden" name="storageGrainInspectionTemp[${idxStatus.index}].p_id" value="${storageGrainInspectionTemp.p_id}" lay-verify="" class="layui-input" placeholder=""/>--%>
					</tr>

				</c:forEach>


				</tbody>
				<!-- 表格内容 end -->
				<td>整仓平均(℃)</td>
				<%--<td colspan="3" style="padding: 0"></td> <input  class="layui-input" style="width: 100%; height: 100%;margin: 0;border: 0"/>--%>
				<td colspan="3"><input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" name="temperatureAvg" class="layui-input" placeholder="--请输入--" value="${grainInspection.temperatureAvg }" /></td>
			</table>

		<button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="addMaterialName();">增加一层</button>
		<button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="lessMaterialName();">删除最后一层</button>

		<%--层数做成表格--%>
		<%--&nbsp;&nbsp;<span class="title">第1层</span>
			
           	<div class="layui-form-item">
           		<div class="layui-inline">
	           		<div class="layui-inline">
	           			<label class="layui-form-label"><span class="red"></span>最高温（℃）：</label>
	           			<div class="layui-input-inline">
		           			<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
		           			name="topMax" value="${grainInspection.topMax }"/>
		           		</div>
	           		</div>  
	           		<div class="layui-inline">
	           			<label class="layui-form-label"><span class="red"></span>最低温（℃）：</label>
	           			<div class="layui-input-inline">
	           				<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
	           				name="topMin" value="${grainInspection.topMin }"/>
	           			</div>
	           		</div>
	           		<div class="layui-inline" >
	           			<label class="layui-form-label"><span class="red"></span>平均温（℃）：</label>
	           			<div class="layui-input-inline">
		           			<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
		           			name="topAvg" value="${grainInspection.topAvg }" onblur="calculateAverage()"/>
	           			</div>
	           		</div>
           		</div>
           	</div>
           	<!-- <div class="layui-row title">
				<h5>中上层</h5>
			</div> -->
			
			<!-- <div class="layui-row title">
				<h5>粮温检查情况：</h5>
			</div> -->
			&nbsp;&nbsp;<span class="title">第2层</span>

          	<div class="layui-form-item">
            	<div class="layui-inline">
            		<label class="layui-form-label"><span class="red"></span>最高温（℃）：</label>
            		<div class="layui-input-inline">
	            		<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
	            		name="topMiddleMax" value="${grainInspection.topMiddleMax }" />
	            	</div>
	            </div>
           		<div class="layui-inline">
            		<label class="layui-form-label"><span class="red"></span>最低温（℃）：</label>
            		<div class="layui-input-inline">
	            		<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
	            		name="topMiddleMin" value="${grainInspection.topMiddleMin }"/>
	            	</div>
            	</div>
            	<div class="layui-inline">
            		<label class="layui-form-label"><span class="red"></span>平均温（℃）：</label>
            		<div class="layui-input-inline">
	            		<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
	            		name="topMiddleAvg" value="${grainInspection.topMiddleAvg }" onblur="calculateAverage()"/>
	            	</div>
            	</div>
            </div>
	        <!-- <div class="layui-row title">
				<h5>粮温检查情况：</h5>
			</div> -->
			
			&nbsp;&nbsp;<span class="title">第3层</span>
            <!-- <div class="layui-row title">
				<h5>中下层</h5>
			</div> -->
			
			<div class="layui-form-item">
				<div class="layui-inline">
	            	<label class="layui-form-label"><span class="red"></span>最高温（℃）：</label>
            		<div class="layui-input-inline">
            			<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
            			name="lowMiddleMax" value="${grainInspection.lowMiddleMax }"/>
            		</div>
            	</div>
				<div class="layui-inline">
	            	<label class="layui-form-label"><span class="red"></span>最低温（℃）：</label>
            		<div class="layui-input-inline">
            			<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
            			name="lowMiddleMin" value="${grainInspection.lowMiddleMin }"/>
            		</div>
            	</div>
            	<div class="layui-inline">
	            	<label class="layui-form-label"><span class="red"></span>平均温（℃）：</label>
            		<div class="layui-input-inline">
            			<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
            			name="lowMiddleAvg" value="${grainInspection.lowMiddleAvg }" onblur="calculateAverage()"/>
            		</div>
            	</div>
           	</div>
				
			<!-- <div class="layui-row title">
				<h5>下层</h5>
			</div> -->
			&nbsp;&nbsp;<span class="title">第4层</span>
			<div class="layui-form-item">
            	<div class="layui-inline">
            		<label class="layui-form-label"><span class="red"></span>最高温（℃）：</label>
            		<div class="layui-input-inline">
            			<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
            			name="lowMax" value="${grainInspection.lowMax }"/>
            		</div>
            	</div>
           	
            	<div class="layui-inline">
            		<label class="layui-form-label"><span class="red"></span>最低温（℃）：</label>
            		<div class="layui-input-inline">
            			<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
            			name="lowMin" value="${grainInspection.lowMin }"/>
            		</div>
            	</div>

            	<div class="layui-inline">
            		<label class="layui-form-label"><span class="red"></span>平均温（℃）：</label>
            		<div class="layui-input-inline">
            			<input type="number" step="0.1" class="layui-input" placeholder="--请输入--"
            			name="lowAvg" value="${grainInspection.lowAvg }" onblur="calculateAverage()"/>
            		</div>
            	</div>
           	</div>
            <div class=" layui-form-item">
            	<div class=" layui-inline">
            		<label class="layui-form-label"><span class="red"></span>整仓平均粮温（℃）：</label>
            		<div class="layui-input-inline">
            			<input type="text" class="layui-input" placeholder="--请输入--"
            			name="temperatureAvg" value="${grainInspection.temperatureAvg }" readOnly/>
            		</div>
            	</div>

				&lt;%&ndash;去除粮温是否异常选项&ndash;%&gt;
				&lt;%&ndash;<div class=" layui-inline">
				<label class="layui-form-label">粮温是否异常：</label>
				<div class="layui-input-inline">
					<input type="radio" name="temperatureAbnormal" value="1" title="是"/>
					<input type="radio" name="temperatureAbnormal" value="0" title="否" checked=""/>
				</div>&ndash;%&gt;
			</div>
            </div>--%>
		<div class="layui-row title">
			<h5>气体浓度：</h5>
		</div>
		<div class=" layui-form-item">
			<div class=" layui-inline">
				<label class="layui-form-label"><span class="red"></span>氧气(%)：</label>
				<div class="layui-input-inline">
					空间：
					<input  type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="spaceOxy" value="${grainInspection.spaceOxy }" placeholder="--请输入--"/>
					粮堆：
					<input  type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" name="grainBulkOxy" value="${grainInspection.grainBulkOxy }" placeholder="--请输入--"/>
				</div>
			</div>
			<div class=" layui-inline">

				<label class="layui-form-label"><span class="red"></span>磷化氢(ppm)：</label>
				<div class="layui-input-inline">
					空间：
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" placeholder="--请输入--"
						   name="spacePhosphine" value="${grainInspection.spacePhosphine }"/>
					粮堆：
					<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" class="layui-input" placeholder="--请输入--"
						   name="grainBulkPhosphine" value="${grainInspection.grainBulkPhosphine }"/>
				</div>
			</div>

		</div>





            
            <div class="layui-row title">
			</div>
            
            <div class=" layui-form-item">
				<div class=" layui-inline" style="height: 5%">
	                <label class="layui-form-label">虫害检测方式：</label>
					<div class="layui-input-inline">
					    <nobr>
							<input type="checkbox" name="pestCheckTypeList" value="过筛检测" title="过筛检测" lay-skin="primary"/>
							<input type="checkbox" name="pestCheckTypeList" value="诱捕检测" title="诱捕检测" lay-skin="primary"/>
							<input type="checkbox" name="pestCheckTypeList" value="空间目测" title="空间目测" lay-skin="primary"/>
							<input type="hidden" name="pestCheckTypeList" value="abc" title=""/>
							<input type="hidden" name="pestCheckTypeList" value="abc" title=""/>
					    </nobr>

						<%--<select name="pestCheckType">
            				<option value=""></option>
            				<option value="过筛检测" <c:if test = "${grainInspection.pestCheckType eq '过筛检测' }">selected</c:if>>过筛检测</option>
            				<option value="诱捕检测" <c:if test = "${grainInspection.pestCheckType eq '诱捕检测' }">selected</c:if>>诱捕检测</option>
            				<option value="空间检测" <c:if test = "${grainInspection.pestCheckType eq '空间检测' }">selected</c:if>>空间检测</option>
            			</select>--%>
					</div>
				</div>
            </div>

		<div class=" layui-form-item">
			<div class=" layui-inline" style="height: 5%">
				<label class="layui-form-label" style="width:200px">虫害采样部位：</label>
				<div class="layui-input-inline">
					<nobr>
						<input type="checkbox" value="仓房四角" name="pestSampleSiteList" lay-skin="primary" title="仓房四角"/>
						<input type="checkbox" value="检查门" name="pestSampleSiteList" lay-skin="primary" title="检查门"/>
						<input type="checkbox" value="窗户口" name="pestSampleSiteList" lay-skin="primary" title="窗户口"/>
						<input type="checkbox" value="通风口" name="pestSampleSiteList" lay-skin="primary" title="通风口"/>
						<input type="checkbox" value="檐墙" name="pestSampleSiteList" lay-skin="primary" title="檐墙"/>
						<input type="checkbox" value="山墙" name="pestSampleSiteList" lay-skin="primary" title="山墙"/>
						<input type="checkbox" value="粮堆" name="pestSampleSiteList" lay-skin="primary" title="粮堆"/>
						<input type="hidden" name="pestSampleSiteList" value="abc" title=""/>
						<input type="hidden" name="pestSampleSiteList" value="abc" title=""/>
					</nobr>
						<%--<select name="pestSampleSite">
							<option value=""></option>
							<option value="仓房四角" <c:if test = "${grainInspection.pestSampleSite eq '仓房四角' }">selected</c:if>>仓房四角</option>
							<option value="检查门" <c:if test = "${grainInspection.pestSampleSite eq '检查门' }">selected</c:if>>检查门</option>
							<option value="窗户口" <c:if test = "${grainInspection.pestSampleSite eq '窗户口' }">selected</c:if>>窗户口</option>
							<option value="通风口" <c:if test = "${grainInspection.pestSampleSite eq '通风口' }">selected</c:if>>通风口</option>
							<option value="檐墙" <c:if test = "${grainInspection.pestSampleSite eq '檐墙' }">selected</c:if>>檐墙</option>
							<option value="山墙" <c:if test = "${grainInspection.pestSampleSite eq '山墙' }">selected</c:if>>山墙</option>
							<option value="粮堆" <c:if test = "${grainInspection.pestSampleSite eq '粮堆' }">selected</c:if>>过筛检测</option>

						</select>--%>
				</div>
			</div>
		</div>
            <div class=" layui-form-item">
                <div class=" layui-inline">
                	<label class="layui-form-label"><span class="red"></span>检测点数（个）：</label>
                	<div class="layui-input-inline">
                		<input lay-verify="customIntegerNumber" type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" class="layui-input" placeholder="--请输入--"
                		name="checkNum" value="${grainInspection.checkNum }" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0"/>
                	</div>
                </div>
                <div class=" layui-inline">
                	<label class="layui-form-label"><span class="red"></span>其中有害虫点数（个）：</label>
                	<div class="layui-input-inline">
	                	<input lay-verify="customIntegerNumber" type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="1" class="layui-input" placeholder="--请输入--"
	                	name="pestSpot" value="${grainInspection.pestSpot }" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="required;integer;length[1~10]" min="0"/>
                	</div>
                </div>
                
            </div>
            <div class=" layui-form-item">
            	<div class=" layui-inline">
            		<label class="layui-form-label"><span class="red"></span>发现虫害位置：</label>
                	<div class="layui-input-inline">
                		<input lay-verify="" type="text" maxlength="15" class="layui-input" placeholder="--请输入--"
                		name="pestInsect" value="${grainInspection.pestInsect }"/>
                	</div>
            	</div>
            	<div class=" layui-inline">
            		<label class="layui-form-label"><span class="red"></span>虫害名称：</label>
            		<div class="layui-input-inline">
            			<input lay-verify="" maxlength="15" type="text" class="layui-input" placeholder="--请输入--"
            			name="pestNames" value="${grainInspection.pestNames }"/>
            		</div>
            	</div>
           	</div>
            <div class=" layui-form-item">
            	<div class=" layui-inline">
	                <label class="layui-form-label">最高害虫密度（头/kg）：</label>
	            	<div class="layui-input-inline">
	            		<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="1" class="layui-input" placeholder="--请输入--"
	            		name="pestDensity" value="${grainInspection.pestDensity }"/>
	            	</div>
            	</div>
            	<div class=" layui-inline">
	            	<label class="layui-form-label">其中主要害虫密度（头/kg）：</label>
	            	<div class="layui-input-inline">
	            		<input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="1" class="layui-input" placeholder="--请输入--"
	            		name="majorPestDensity" value="${grainInspection.majorPestDensity }"/>
	            	</div>
	            </div>
            </div>
            <div class=" layui-form-item">
                <div class=" layui-inline" style="height: 5%">
                	<label class="layui-form-label"><span class="red"></span>判定虫粮等级：</label>
                	<div class="layui-input-inline">
						<nobr>

							<input type="checkbox" name="pestLevel" lay-filter="radioFilter" value="基本无虫粮"<c:if test="${grainInspection.pestLevel== '基本无虫粮'}">checked="checked"</c:if> title="基本无虫粮" lay-skin="primary"/>
							<input type="checkbox" name="pestLevel" lay-filter="radioFilter" value="一般虫粮"<c:if test="${grainInspection.pestLevel== '一般虫粮'}">checked="checked"</c:if> title="一般虫粮" lay-skin="primary"/>
							<input type="checkbox" name="pestLevel" lay-filter="radioFilter" value="严重虫粮"<c:if test="${grainInspection.pestLevel== '严重虫粮'}">checked="checked"</c:if> title="严重虫粮" lay-skin="primary"/>
							<input type="checkbox" name="pestLevel" lay-filter="radioFilter" value="危险虫粮"<c:if test="${grainInspection.pestLevel== '危险虫粮'}">checked="checked"</c:if> title="危险虫粮" lay-skin="primary"/>

						</nobr>

	                   <%--<select name="pestLevel" lay-verify="required">
            				<option value=""></option>
            				<option value="基本无虫粮" <c:if test = "${grainInspection.pestLevel eq '基本无虫粮' }">selected</c:if>>基本无虫粮</option>
            				<option value="一般虫粮" <c:if test = "${grainInspection.pestLevel eq '一般虫粮' }">selected</c:if>>一般虫粮</option>
            				<option value="严重虫粮" <c:if test = "${grainInspection.pestLevel eq '严重虫粮' }">selected</c:if>>严重虫粮</option>
            			</select>--%>
                	</div>
                </div> <br>
                <%--<div class=" layui-inline" style="height: 5%">--%>
                	<%--<label class="layui-form-label"><span class="red"></span>熏蒸措施：</label>--%>
                 	<%--<div class="layui-input-inline">--%>
						<%--<nobr>--%>
							<%--<input type="radio" name="suffocate" value="已熏蒸" title="已熏蒸" lay-skin="primary"/>--%>
							<%--<input type="radio" name="suffocate" value="未熏蒸" title="未熏蒸" lay-skin="primary"/>--%>
						<%--</nobr>--%>

                 		<%--&lt;%&ndash;<select name="suffocate" lay-verify="required">--%>
            				<%--<option value=""></option>--%>
            				<%--<option value="已熏蒸" <c:if test = "${grainInspection.suffocate eq '已熏蒸' }">selected</c:if>>已熏蒸</option>--%>
            				<%--<option value="未熏蒸" <c:if test = "${grainInspection.suffocate eq '未熏蒸' }">selected</c:if>>未熏蒸</option>--%>
            			<%--</select>&ndash;%&gt;--%>
                	<%--</div>--%>
            	<%--</div>--%>
            </div>
            
            
            <!-- <fieldset class="layui-elem-field layui-field-title">
  				<legend>粮情变化情况：</legend>
			</fieldset> -->
           <%-- <div class="layui-row title">
				<h5>粮情变化情况：</h5>
			</div>--%>
            <%--<div class=" layui-form-item">
            	<div class=" layui-inline">
                	<label class="layui-form-label">粮食有无发现发热：</label>
                    <div class="layui-input-inline">
						<input type="radio" name="heat" value="1" title="有" lay-skin="primary"/>
						<input type="radio" name="heat" value="0" title="无" lay-skin="primary"/>
					</div>
                </div>
                <div class=" layui-inline">
	                <label class="layui-form-label">粮食有无发现霉变：</label>
		            <div class="layui-input-inline">
						<input type="radio" name="rot" value="1" title="有" lay-skin="primary"/>
						<input type="radio" name="rot" value="0" title="无" lay-skin="primary"/>
		            </div>
                </div>
            </div>--%>
           
            <!-- <fieldset class="layui-elem-field layui-field-title">
  				<legend>仓房安全情况：</legend>
			</fieldset> -->
			<div class="layui-row title">
				<h5>仓房安全情况：</h5>
			</div>
            <div class=" layui-form-item">
            	<div class=" layui-inline" style="height: 5%">
            		<label class="layui-form-label" style="width:200px"><span class="red">*</span>仓房设施方面：</label>
            		<div class="layui-input-inline">
						<nobr>
            				<input  type="checkbox" name="shedLeakage"<c:if test="${grainInspection.shedLeakage== '1'}">checked="checked"</c:if> lay-filter="radioFilter" value="1" title="有" lay-skin="primary"/>
							<input  type="checkbox" name="shedLeakage"<c:if test="${grainInspection.shedLeakage== '0'}">checked="checked"</c:if> lay-filter="radioFilter" value="0" title="无" lay-skin="primary" />
						</nobr>
					</div>
            	</div>
                <div class=" layui-inline" style="height: 5%">
                	<label class="layui-form-label" style="width:200px"><span class="red">*</span>漏雨防潮方面：</label>
                    <div class="layui-input-inline">
						<nobr>
                    		<input type="checkbox" name="wallLeakage"<c:if test="${grainInspection.wallLeakage== '1'}">checked="checked"</c:if> lay-filter="radioFilter" value="1" title="有" lay-skin="primary"/>
							<input type="checkbox" name="wallLeakage"<c:if test="${grainInspection.wallLeakage== '0'}">checked="checked"</c:if> lay-filter="radioFilter" value="0" title="无" lay-skin="primary" />
						</nobr>
					</div>
                </div>
            </div>
            <div class=" layui-form-item" >
            	<div class=" layui-inline" style="height: 5%">
            		<label class="layui-form-label" style="width:200px"><span class="red">*</span>防火安全方面：</label>
					<div class="layui-input-inline">
						<nobr>
							<input type="checkbox" name="doorLeakage"<c:if test="${grainInspection.doorLeakage== '1'}">checked="checked"</c:if> lay-filter="radioFilter" value="1" title="有" lay-skin="primary"/>
							<input type="checkbox" name="doorLeakage"<c:if test="${grainInspection.doorLeakage== '0'}">checked="checked"</c:if> lay-filter="radioFilter" value="0" title="无" lay-skin="primary" />
						</nobr>
					</div>
                </div>
                <div class=" layui-inline" style="height: 5%">
                	<label class="layui-form-label" style="width:200px"><span class="red">*</span>用电安全方面：</label>
                	<div class="layui-input-inline">
						<nobr>
                			<input type="checkbox" name="shedCrack"<c:if test="${grainInspection.shedCrack== '1'}">checked="checked"</c:if> lay-filter="radioFilter" value="1" title="有" lay-skin="primary"/>
                			<input type="checkbox" name="shedCrack"<c:if test="${grainInspection.shedCrack== '0'}">checked="checked"</c:if> lay-filter="radioFilter" value="0" title="无" lay-skin="primary"/>
						</nobr>
                	</div>
            	</div>
            </div>
           	<%--<div class=" layui-form-item">
            	<div class=" layui-inline">
            		<label class="layui-form-label" style="width:200px"><span class="red"></span>墙体、地坪有无发现裂缝：</label>
                    <div class="layui-input-inline">
	                    <input type="radio" name="wallCrack" value="1" title="有" lay-skin="primary"/>
	                    <input type="radio" name="wallCrack" value="0" title="无" lay-skin="primary" />
                    </div>
                </div>
            	<div class=" layui-inline">
            		<label class="layui-form-label" style="width:200px"><span class="red"></span>门窗有无发现裂缝：</label>
            		<div class="layui-input-inline">
	            		<input type="radio" name="doorCrack" value="1" title="有" lay-skin="primary"/>
	            		<input type="radio" name="doorCrack" value="0" title="无" lay-skin="primary" />
            		</div>
            	</div>
            </div>--%>
           <%-- <div class=" layui-form-item">
            	<div class=" layui-inline">
            		<label class="layui-form-label" style="width:200px"><span class="red"></span>仓内照明是否故障：</label>
                    <div class="layui-input-inline">
                    	<input type="radio" name="light" value="1" title="是" lay-skin="primary"/>
                		<input type="radio" name="light" value="0" title="否" lay-skin="primary"/>
                	</div>
                </div>
            	<div class=" layui-inline">
            		<label class="layui-form-label" style="width:200px"><span class="red"></span>上下楼梯是否安全：</label>
	               	<div class="layui-input-inline">
	               		<input type="radio" name="stairs" value="1" title="是" lay-skin="primary"/>
	                	<input type="radio" name="stairs" value="0" title="否" lay-skin="primary" />
	                </div>
	            </div>
			</div>--%>
			<%--<div class=" layui-form-item">
                <div class=" layui-inline">
                	<label class="layui-form-label" style="width:200px"><span class="red"></span>辅助设施是否完好：</label>
	                <div class="layui-input-inline">
		                <input type="radio" name="facilities" value="1" title="是" lay-skin="primary"/>
	                	<input type="radio" name="facilities" value="0" title="否" lay-skin="primary" />
                	</div>
                </div>
            </div>--%>
            <!-- <fieldset class="layui-elem-field layui-field-title">
  				<legend>仓内清卫情况：</legend>
			</fieldset> -->
			<div class="layui-row title">
				<h5>鼠雀卫生情况：</h5>
			</div>
            <div class=" layui-form-item">
                <div class=" layui-inline" style="height: 5%">
                	<label class="layui-form-label"><span class="red"></span>仓内有无发现鼠雀：</label>
                	<div class="layui-input-inline">
						<nobr>
                			<input type="checkbox"<c:if test="${grainInspection.mouse== '1'}">checked="checked"</c:if> name="mouse" lay-filter="radioFilter" value="1" title="有" lay-skin="primary"/>
                			<input type="checkbox"<c:if test="${grainInspection.mouse== '0'}">checked="checked"</c:if> name="mouse" lay-filter="radioFilter" value="0" title="无" lay-skin="primary"/>
						</nobr>
                	</div>
                </div>
               <%-- <div class=" layui-inline">
	                <label class="layui-form-label"><span class="red"></span>仓内有无发现蛛网：</label>
	                <div class="layui-input-inline">
	                	<input type="radio" name="cobweb" value="1" title="有"/>
	                	<input type="radio" name="cobweb" value="0" title="无"  checked=""/>
                	</div>
            	</div>--%>
            </div>
            <div class=" layui-form-item">
                <div class=" layui-inline" style="height: 5%">
					<label class="layui-form-label"><span class="red"></span>仓内卫生情况：</label>
                	<div class="layui-input-inline">
						<nobr>
                			<input type="checkbox" name="hygiene"<c:if test="${grainInspection.hygiene== '1'}">checked="checked"</c:if> lay-filter="radioFilter" value="1" title="好" lay-skin="primary" />
                			<input type="checkbox" name="hygiene"<c:if test="${grainInspection.hygiene== '0'}">checked="checked"</c:if> lay-filter="radioFilter" value="0" title="差" lay-skin="primary"  />
						</nobr>
               		</div>
            	</div>

            </div>
            <div class="layui-row title">
	</div>
		<div class=" layui-form-item">

            	<div class=" layui-inline">
            		<label class="layui-form-label"><span class="red">*</span>检查情况评估：</label>
            		<div class="layui-input-inline">
            			<input type="radio" lay-filter="erweima" name="checkSituation"<c:if test="${grainInspection.checkSituation== '1'}">checked="checked"</c:if> value="1" title="粮情稳定，储存安全" />
						<nobr><input type="radio"
									 lay-filter="erweima"
									 name="checkSituation"
									 <c:if test="${grainInspection.checkSituation== '0'}">checked="checked"</c:if> value="0" title="存在隐患，处理意见："/>
								<input name="advice" value="${grainInspection.advice}" maxlength="200" type="text" id="advice"/></nobr>
                	</div>
                </div>
            </div>
            
            <div class=" layui-form-item">
            	<div class=" layui-inline">
            		<label class="layui-form-label"><span class="red">*</span>检查性质：</label>
                	<div class="layui-input-inline">
                		<select name="checkProperty" lay-verify="required">
            				<option value=""></option>
            				<option value="上级单位检查" <c:if test = "${grainInspection.checkProperty eq '上级单位检查' }">selected</c:if>>上级单位检查</option>
            				<option value="月普查" <c:if test = "${grainInspection.checkProperty eq '月普查' }">selected</c:if>>月普查</option>
            				<option value="季鉴定" <c:if test = "${grainInspection.checkProperty eq '季鉴定' }">selected</c:if>>季鉴定</option>
            				<option value="保管员自查" <c:if test = "${grainInspection.checkProperty eq '保管员自查' }">selected</c:if>>保管员自查</option>
            			</select>
                	</div>
            	</div>
            	<div class=" layui-inline">
					<label class="layui-form-label"><span class="red">*</span>检查负责人：</label>
                	<div class="layui-input-inline">
						<input lay-verify="required" type="text" maxlength="5" class="layui-input" placeholder="--请输入--" name="checkCharge" value="${grainInspection.checkCharge}"/>
                		<%--<select name="checkCharge" lay-verify="required" >
								<option value=""></option>
								<c:forEach items="${sysUserList}" var="user">
									<option value="${user.name}"<c:if test = "${grainInspection.checkCharge eq user.name }">selected</c:if>>${user.name}</option>
								</c:forEach>

            				&lt;%&ndash;&lt;%&ndash; <option value=""></option>&ndash;%&gt;
            				&lt;%&ndash;<option value="张某" <c:if test = "${grainInspection.checkCharge eq '张某' }">selected</c:if>>张某</option>&ndash;%&gt;
            				&lt;%&ndash;<option value="李某" <c:if test = "${grainInspection.checkCharge eq '李某' }">selected</c:if>>李某</option> &ndash;%&gt;&ndash;%&gt;
            			</select>--%>
            		</div>
                </div>
            </div>
            <div class=" layui-form-item">
                <div class=" layui-inline">
                	<label class="layui-form-label"><span class="red">*</span>检查人员：</label>
                	<div class="layui-input-inline">
                		<input lay-verify="required" type="text" maxlength="100" class="layui-input" placeholder="--请输入--"
                		name="checker" value="${grainInspection.checker }"/>
                	</div>
                </div>
                <div class=" layui-inline">
                	<label class="layui-form-label"><span class="red">*</span>保管员：</label>
                	<div class="layui-input-inline">
                		<input lay-verify="required" type="text" class="layui-input" readonly name="keeper"
                		<c:if test="${auvp ne 'a' }">value="${grainInspection.keeper }"</c:if>
                		<c:if test="${auvp eq 'a' }">value="${user.name }"</c:if>/>
                	</div>
            	</div>
            </div>
            <div class=" layui-form-item">
                <label class="layui-form-label" style="width:200px">备注：</label>
                <div class="layui-input-inline">
                	<textarea class="layui-textarea" placeholder="--限500字--" name="remark"  style="width:800px" maxlength="400">${grainInspection.remark }</textarea>
                </div>
            </div>
            <p name="prompt">备注：带有<span class="red">*</span>为必填项！</p>
	        <div class="layui-form-item">
				<div class="layui-input-block" style="text-align: center;">
	        		<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="submit_btn" lay-submit lay-filter="submit_btn">保存<c:if test="${auvp eq 'u' }">更改</c:if></button>
	            	<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="cancel_btn"
	            		onclick="cancelOperate('${auvp }', '${ctx }/storageGrainInspection.shtml')">取消</button>
				</div>
	        </div>
    </form>
</div>

<script src="${ctx}/js/app/storage/common.js"></script>

<script>
    function clearNoNum1(obj){
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
        if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
            obj.value= parseFloat(obj.value);
        }
        if(obj.value<0){
            obj.value=0;
        }else if(obj.value>100){
            obj.value=100;
        }
    }
    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
        if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
            obj.value= parseFloat(obj.value);
        }
    }
    function checkAmounts(obj) {
        var reg = /[A-Za-z]+/;
        var optionNum = $(obj).val();
        if (reg.test(optionNum)) {
            alert("只能输入数字");
            $(obj).val("");
        }

    }

if ('${auvp }' !== 'a') {
    /*$("input:checkbox[value=${grainInspection.pestLevel }]").attr('checked','true');
    $("input:checkbox[name='shedLeakage'][value=${grainInspection.shedLeakage }]").attr('checked','true');
    $("input:checkbox[name='wallLeakage'][value=${grainInspection.wallLeakage }]").attr('checked','true');
    $("input:checkbox[name='doorLeakage'][value=${grainInspection.doorLeakage }]").attr('checked','true');
    $("input:checkbox[name='shedCrack'][value=${grainInspection.shedCrack }]").attr('checked','true');
    $("input:checkbox[name='mouse'][value=${grainInspection.mouse }]").attr('checked','true');
    $("input:checkbox[name='hygiene'][value=${grainInspection.hygiene }]").attr('checked','true');
	$("input[name='checkSituation'][value=${grainInspection.checkSituation }]").attr("checked",true);
    $("input[name='pestCheckTypeList'][value=${grainInspection.pestCheckTypeList }]").attr("checked",true);
    $("input[name='pestSampleSiteList'][value=${grainInspection.pestSampleSiteList }]").attr("checked",true);*/
   /* $("input[name='temperatureAvg']").val(${grainInspection.checkSituation });*/
    //为所有checkbox赋值
	var arr = new Array();
 	<c:forEach items="${grainInspection.pestSampleSiteList }" var="t">  
		arr.push("${t}");
		//console.log("${t}");
	</c:forEach>
 	for (i in arr) {
 		$("input:checkbox[value=" + arr[i] + "]").attr('checked','true');
 	}

 	//虫害检测方式
 	var arr1 = new Array();
 	<c:forEach items="${grainInspection.pestCheckTypeList}" var="u">
    	arr1.push("${u}")
	</c:forEach>
	for (j in arr1) {
        $("input:checkbox[value=" + arr1[j] + "]").attr('checked','true');
	}

 	<%--/* $("textarea[name=remark]").val("${grainInspection.remark }"); */--%>
}

if ('${auvp }' === 'v') {
	$('input').attr('disabled','disabled');
	$('select').attr('disabled','disabled');
	$('#cancel_btn').text('返回');//取消按钮
    $('#submit_btn').css('display','none');//提交按钮
    $('p[name=prompt]').css('display','none');//备注文字
    $("textarea[name=remark]").attr("disabled","disabled");
}

layui.use(['form', 'laydate'], function(){
	var laydate = layui.laydate,
	form = layui.form;


	$('.date-need').each(function(){
		laydate.render({
			elem: this,
            max : getNowFormatDate()
		});
	});
	
	form.render();

    form.on('radio(erweima)', function (data) {
        if(data.value == '1'){
            //只读
            $('#advice').val("");
            $('#advice').attr('readOnly',true);
        }else if(data.value == '0'){
            $('#advice').attr('readOnly',false);
        }
        //console.log(data.elem);
        //alert(data.value);//判断单选框的选中值
        //console.log(data.value);
        //alert(data.othis);
        //layer.tips('开关checked：' + (this.checked ? 'true' : 'false'), data.othis);
        //layer.alert('响应点击事件');
    });
    form.verify({
        customIntegerNumber: function(value){
            if(value.length!=0){
                if(!(/^\+?[1-9][0-9]*$/.test(value))){
                    return '只能输入正整数';
                }
            }
        }

	});


	form.on('submit(submit_btn)', function(data){
	    debugger;
        /*layer.load(2);*/
        var form = $('#form');
        form.find("#submit_btn").attr("disabled",true);
        var isrepeat = false;
        var postData1 = data.field;
        var postData = {};
        postData.warehouse=postData1.warehouse;
        postData.encode=postData1.encode;
        postData.reportDate=postData1.reportDate;
        var tempForm = form.serializeObject();
		var storageGrainInspectionTemp = [];
		//var temperatureAvg = "";
		for (var i = 0;i< index - 1; i++){
            storageGrainInspectionTemp.push({
				<%--name="['${idxStatus.count}'--%>
               /* p_id : $("[name='storageGrainInspectionTemp["+i+"].p_id']").val(),*/
                placeId : $("[name='storageGrainInspectionTemp["+i+"].placeId']").val(),
                topMax : $("[name='storageGrainInspectionTemp["+i+"].topMax']").val(),
                topMin : $("[name='storageGrainInspectionTemp["+i+"].topMin']").val(),
                topAvg : $("[name='storageGrainInspectionTemp["+i+"].topAvg']").val(),
				});
		}

		tempForm["storageGrainInspectionTemp"] = storageGrainInspectionTemp;

      	var json = JSON.stringify(tempForm);

        //form.serializeObject();

      	//console.log(json);

       var a ="<fmt:formatDate value="${grainInspection.reportDate}" pattern='yyyy-MM-dd'/>"
        $.ajax({
            url:'${ctx }/storageGrainInspection/getTime.shtml?warehouse='+postData.warehouse+'&encode='+postData.encode+'&reportDate='+postData.reportDate,
            type:'post',
            success:function (count) {
                debugger;
                if(count>0){
                    if (postData.warehouse=="${grainInspection.warehouse}"&&postData.encode=="${grainInspection.encode}"&&postData.reportDate==a){
						if ('${auvp }' === 'c'){
                            isrepeat = true;
						}
                    }else {

                        isrepeat = true;
					}
				}else {

				}

               /* $.each(storageGrainInspections, function (index, a) {
                    if(id!=0){
                        if(a.warehouse == postData.warehouse&&a.encode == postData.encode&&a.reportDate == postData.reportDate&&a.id!=id){
                            isrepeat = true;
                            return false;
                        }
                    }else{
                        if(a.warehouse == postData.warehouse&&a.encode == postData.encode&&a.reportDate == postData.reportDate){
                            isrepeat = true;
                            return false;
                        }
                    }

                });*/
                if(isrepeat){
                    layer.confirm('当天已存在粮情检测记录，确定要保存吗?', {
                        icon : 0,
                        title : '提示'
                    }, function() {//是
                       /* self.save();*/
                       // layer.load();
                        $.ajax({
                            type : 'POST',
                            url : '${ctx }/storageGrainInspection/save.shtml?auvp=${auvp}',
                            dataType : "json",
                            contentType : "application/json",
                            data : json,
                            error: function(request) {
                                form.find("#submit_btn").attr("disabled",false);
                                layer.closeAll("loading");
                                if(request.responseText){
                                    layer.open({
                                        type: 1,
                                        area: ['700px', '430px'],
                                        fix: false,
                                        content: request.responseText
                                    });
                                }
                            },
                            success : function(result) {
                                layer.closeAll("loading");
                                if (!result.success) {
                                    form.find("#submit_btn").attr("disabled",false);
                                    layer.alert(result.msg, {icon:2});
                                    return;
                                } else {
                                    layer.msg(result.msg,{time:1000,icon:1},function(){
                                        location.href = '${ctx }/storageGrainInspection.shtml?type='+$("#type").val();
                                    });
                                }
                            }
                        });
                        return false;
                    }, function(index) {//否
                        form.find("#submit_btn").attr("disabled",false);
                       layer.close(index);

                    });
                }else {
                    /*self.save();*/
                    layer.load();
                    $.ajax({
                        type : 'POST',
                        url : '${ctx }/storageGrainInspection/save.shtml?auvp=${auvp}',
                        dataType : "json",
                        contentType : "application/json",
                        data : json,
                        error: function(request) {
                            form.find("#submit_btn").attr("disabled",false);
                            layer.closeAll("loading");
                            if(request.responseText){
                                layer.open({
                                    type: 1,
                                    area: ['700px', '430px'],
                                    fix: false,
                                    content: request.responseText
                                });
                            }
                        },
                        success : function(result) {
                            layer.closeAll("loading");
                            if (!result.success) {
                                form.find("#submit_btn").attr("disabled",false);
                                layer.alert(result.msg, {icon:2});
                                return;
                            } else {
                                layer.msg(result.msg,{time:1000,icon:1},function(){
                                    location.href = '${ctx }/storageGrainInspection.shtml?type='+$("#type").val();
                                });
                            }
                        }
                    });
                    return false;
                }

            }
        })
	});

	form.on('select(encode)', function(data){
		if (data.value === "") {
			$("input[name='quantity']").val("");
			return false;
		}
		$.ajax({
			/* type : 'POST', */
	       	url : '${ctx }/storageGrainInspection/getQuantity.shtml?warehouse='+encodeURI(encodeURI($("input[name='warehouse']").val()))+"&storehouse="+encodeURI(encodeURI(data.value)),
	       	/* data : {
	       		'warehouse' : encodeURI(encodeURI($("input[name='warehouse']").val())),
	       		'storehouse' : encodeURI(encodeURI(data.value)),
	       	}, */
			error: function(request) {
				if(request.responseText){
				    layer.open({
				        type: 1,
				        area: ['700px', '430px'],
				        fix: false,
				        content: request.responseText
				    });
				}
				$("input[name='quantity']").val("");
			},
			success : function(result) {
			    // alert(result.data);
				if (result.success) {
			        if(result.data == 'null'){
                        $("input[name='quantity']").val(0);
					}else{
						document.getElementById("wt").style.display = "";
						$('#bg01').attr('lay-verify','required');
						document.getElementById("at").style.display = "";
						$('#bg02').attr('lay-verify','required');
						document.getElementById("wet").style.display = "";
						$('#bg03').attr('lay-verify','required');
						document.getElementById("qet").style.display = "";
						$('#bg04').attr('lay-verify','required');
						document.getElementById("gva").style.display = "";
						$('#bg05').attr('lay-verify','required');
                        $("input[name='quantity']").val(result.data.quantity);
                        $('select[name="grainType"]').val(result.data.grainType);
                        /*alert(result.data.quantity);
						alert(result.data.grainType);*/
                        layui.form.render('select','form');
                    }
				} else {
					layer.msg(result.msg + '，已经将实际数量置为默认值',{icon : 0});
					document.getElementById("wt").style.display = "none";
					$('#bg01').attr('lay-verify', null);
					document.getElementById("at").style.display = "none";
					$('#bg02').attr('lay-verify', null);
					document.getElementById("wet").style.display = "none";
					$('#bg03').attr('lay-verify', null);
					document.getElementById("qet").style.display = "none";
					$('#bg04').attr('lay-verify', null);
					document.getElementById("gva").style.display = "none";
					$('#bg05').attr('lay-verify', null);
					$("input[name='quantity']").val(0);
                    $('select[name="grainType"]').val('');
                    layui.form.render('select','form');
				}
			}
		});
	});
    form.on('checkbox(radioFilter)', function(){

        var domName = $(this).attr("name");//获取当前单选框控件name 属性值
        var checkedState = $(this).attr("checked");//记录当前选中状态
		if(checkedState!="checked"){
		    var ch = $("input:checkbox[name='" + domName + "']");
		    for(var i=0;i<ch.length;i++) {
                var checked1 = $(ch[i]).attr("checked");
                if (checked1 == "checked") {
                    $(ch[i]).attr("checked", false);
                    var div = ch[i].nextSibling;
                    $(div).attr("class", "layui-unselect layui-form-checkbox");
                }
            }
            $(this).attr("checked",true);
            var div = this.nextSibling;
            $(div).attr("class","layui-unselect layui-form-checkbox layui-form-checked");
		} else{
            $(this).attr("checked",true);
            var div = this.nextSibling;
            $(div).attr("class","layui-unselect layui-form-checkbox layui-form-checked");

		}
    });
});
function save() {
    layer.load();
    $.ajax({
        type : 'POST',
        url : '${ctx }/storageGrainInspection/save.shtml?auvp=${auvp}',
        dataType : "json",
        contentType : "application/json",
        data : json,
        error: function(request) {
            if(request.responseText){
                layer.open({
                    type: 1,
                    area: ['700px', '430px'],
                    fix: false,
                    content: request.responseText
                });
            }
        },
        success : function(result) {
            if (!result.success) {
                layer.alert(result.msg, {icon:2});
                return;
            } else {
                layer.msg(result.msg,{time:1000,icon:1},function(){
                    location.href = '${ctx }/storageGrainInspection.shtml?type='+$("#type").val();
                });
            }
        }
    });
}
function calculateAverage() {
	var lowAvg = Number($('input[name="lowAvg"]').val());
	var lowMiddleAvg = Number($('input[name="lowMiddleAvg"]').val());
	var topMiddleAvg = Number($('input[name="topMiddleAvg"]').val())
	var topAvg = Number($('input[name="topAvg"]').val());
	var avg = ((lowAvg + lowMiddleAvg + topMiddleAvg + topAvg)/4).toFixed(2);
	$('input[name="temperatureAvg"]').val(avg);
}



var index = $("#temp>tbody").children("tr").length;
function addMaterialName(){
    var tr =   '<tr id="row"><td style="width:6%" ><input type="hidden" name="storageGrainInspectionTemp['+(index-1)+'].placeId" value='+ index +' style="width:0px;"/>第'+(index)+'层</td>'
        +'<td ><input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" name="storageGrainInspectionTemp['+(index-1)+'].topMax" class="layui-input" lay-verify="number"  placeholder="--请输入--"/></td>'
        +'<td ><input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" name="storageGrainInspectionTemp['+(index-1)+'].topMin" class="layui-input" lay-verify="number"  placeholder="--请输入--"/></td>'
       /* +'<td ><input type="text" name="storageGrainInspectionTemp['+(index-1)+'].p_id" class="layui-input" placeholder=""/></td>'*/
        +'<td ><input type="text" maxlength="5" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" step="0.1" name="storageGrainInspectionTemp['+(index-1)+'].topAvg" class="layui-input" lay-verify="number"  placeholder="--请输入--"/></td> </tr>'

		index++;
    $("#materialDetail").append(tr);
}

function lessMaterialName() {
    if(index >0){
        layer.confirm("确定删除吗？",function (row) {
            var tr= $("#materialDetail tr:last").remove();
            --index;
            layer.close(row);
        });
	}
}
function un(val) {
    //alert(11);
	if(val == '1'){
	    //只读
        $('#advice').val("");
		$('#advice').attr('readOnly',true);
	}else if(val == '0'){
        $('#advice').attr('readOnly',false);
	}
}

function optionProperties(x) {
	var y = document.getElementById(x).value;
	if(y == 0 || y == null) {
		document.getElementById("wt").style.display = "none";
		$('#bg01').attr('lay-verify', null);
		document.getElementById("at").style.display = "none";
		$('#bg02').attr('lay-verify', null);
		document.getElementById("wet").style.display = "none";
		$('#bg03').attr('lay-verify', null);
		document.getElementById("qet").style.display = "none";
		$('#bg04').attr('lay-verify', null);
		document.getElementById("gva").style.display = "none";
		$('#bg05').attr('lay-verify', null);
	}else{
		document.getElementById("wt").style.display = "";
		$('#bg01').attr('lay-verify','required');
		document.getElementById("at").style.display = "";
		$('#bg02').attr('lay-verify','required');
		document.getElementById("wet").style.display = "";
		$('#bg03').attr('lay-verify','required');
		document.getElementById("qet").style.display = "";
		$('#bg04').attr('lay-verify','required');
		document.getElementById("gva").style.display = "";
		$('#bg05').attr('lay-verify','required');
	}
}
    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var seperator2 = ":";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = date.getFullYear() + seperator1 + month
            + seperator1 + strDate + " " + date.getHours() + seperator2
            + date.getMinutes() + seperator2 + date.getSeconds();
        return currentdate;
    }
</script>

