<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../common/AdminHeader.jsp"%>

<div class="row clear-m">
    <ol class="breadcrumb">


        <c:if test="${type==''}">
            <li>仓储管理</li>
            <li>粮油情监测管理</li>
            <li><a href="${ctx }/ngasOperaRecord.shtml">充氮气调作业记录</a></li>

        </c:if>
        <c:if test="${type=='dc'}">
            <li>代储监管</li>
            <li>报表台账</li>
            <li><a href="${ctx }/ngasOperaRecord.shtml">充氮气调作业记录</a></li>
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

        <input type="hidden" name="id" value="${ngasOperaRecord.id }"/>
        <input type="hidden" value="${type}" id="type" name="type">

        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>所属库点：</span>
                <span>${ngasOperaRecord.warehouse }</span>
            </div>
            <div class="layui-col-md4">
                <span>填报日期：</span>
                <span><fmt:formatDate value='${ngasOperaRecord.reportDate }' type='date' pattern='yyyy-MM-dd'/></span>
            </div>
            <div class="layui-col-md4">
                <span>天气：</span>
                <span>${ngasOperaRecord.weather }</span>
            </div>
        </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>气温（℃）：</span>
                <span>${ngasOperaRecord.temperature }</span>
            </div>
            <div class="layui-col-md4">
                <span>气湿（RH%）：</span>
                <span>${ngasOperaRecord.airWet }</span>
            </div>
            <div class="layui-col-md4">
                <span>风道类型：</span>
                <span>${ngasOperaRecord.windTunnelType }</span>
            </div>
        </div>
        <div class="layui-row ">
        <div class="layui-col-md4">
            <span>充气方式：</span>
            <span>${ngasOperaRecord.gasChargeType }</span>
        </div>
        <div class="layui-col-md4">
            <span>制氮装置：</span>
            <span>${ngasOperaRecord.nmakePlant }</span>
        </div>
        <div class="layui-col-md4">
            <span>散气日期：</span>
            <span>
            <fmt:formatDate value='${ngasOperaRecord.degasDate }' type='date' pattern='yyyy-MM-dd'/>
            </span>
        </div>
    </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>散气方式：</span>
                <span>${ngasOperaRecord.degasType }</span>
            </div>
            <div class="layui-col-md4">
                <span>散气时间(h)：</span>
                <span>${ngasOperaRecord.degasTime }</span>
            </div>
        </div>

        <div class="layui-row title">
            <h5>仓情：</h5>
        </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>仓房类型：</span>
                <span>${ngasOperaRecord.storehouseType }</span>
            </div>
            <div class="layui-col-md4">
                <span>仓房编号：</span>
                <span>${ngasOperaRecord.encode }</span>
            </div>
            <div class="layui-col-md4">
                <span>密封方法：</span>
                <span>${ngasOperaRecord.sealMethod }</span>
            </div>
        </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>仓房结构：</span>
                <span>${ngasOperaRecord.storehouseStructure }</span>
            </div>
            <div class="layui-col-md4">
                <span>气密性(s)：</span>
                <span>${ngasOperaRecord.airTightness }</span>
            </div>
            <div class="layui-col-md4">
                <span>入库时间：</span>
                <span>
                <fmt:formatDate value='${ngasOperaRecord.instoreTime }' type='date' pattern='yyyy-MM-dd'/>
                </span>
            </div>
        </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>仓房总体积(m³)：</span>
                <span>${ngasOperaRecord.storehouseVolume }</span>
            </div>
            <div class="layui-col-md4">
                <span>粮堆体积(m³)：</span>
                <span>${ngasOperaRecord.grainBulkVolume }</span>
            </div>
            <div class="layui-col-md4">
                <span>空间体积(m³)：</span>
                <span>${ngasOperaRecord.spaceVolume }</span>
            </div>
        </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>堆放形式：</span>
                <span>${ngasOperaRecord.stackForm }</span>
            </div>
            <div class="layui-col-md4">
                <span>粮堆高度(m)：</span>
                <span>${ngasOperaRecord.grainHeight }</span>
            </div>
            <div class="layui-col-md4">
                <span>上年度是否熏蒸：</span>
                <span>${ngasOperaRecord.isfumigated }</span>
            </div>
        </div>

        <div class="layui-row title">
            <h5>粮情：</h5>
        </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>粮食品种：</span>
                <span>${ngasOperaRecord.grainType }</span>
            </div>
            <div class="layui-col-md4">
                <span>数量(t)：</span>
                <span>${ngasOperaRecord.quantity }</span>
            </div>
            <div class="layui-col-md4">
                <span>杂质(%)：</span>
                <span>${ngasOperaRecord.impurity }</span>
            </div>
        </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>仓温(℃)：</span>
                <span>${ngasOperaRecord.storehouseTemp }</span>
            </div>
            <div class="layui-col-md4">
                <span>仓湿(RH%)：</span>
                <span>${ngasOperaRecord.storehouseWet }</span>
            </div>
            <div class="layui-col-md4">
                <span>水分(%)：</span>
                <span>${ngasOperaRecord.dew }</span>
            </div>
        </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>最高粮温(℃)：</span>
                <span>${ngasOperaRecord.maxGraintemp }</span>
            </div>
            <div class="layui-col-md4">
                <span>最低粮温(℃)：</span>
                <span>${ngasOperaRecord.minGrainTemp }</span>
            </div>
            <div class="layui-col-md4">
                <span>平均粮温(℃)：</span>
                <span>${ngasOperaRecord.avgGraintemp }</span>
            </div>
        </div>

        <div class="layui-row title">
            <h5>虫情：</h5>
        </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>虫粮等级：</span>
                <span>${ngasOperaRecord.pestLevel }</span>
            </div>
            <div class="layui-col-md4">
                <span>虫害名称：</span>
                <span>${ngasOperaRecord.pestNames }</span>
            </div>
            <div class="layui-col-md4">
                <span>虫害密度(头/kg)：</span>
                <span>${ngasOperaRecord.pestDensity }</span>
            </div>
        </div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>发生部位：</span>
                <span>${ngasOperaRecord.pestInsect }</span>
            </div>
            <div class="layui-col-md4">
                <span>发现虫害时间：</span>
                <span>
                    <fmt:formatDate value='${ngasOperaRecord.findPestTime }' type='date' pattern='yyyy-MM-dd'/>
                </span>
            </div>
        </div>

        <div class="layui-row title">
            <h5>作业情况：</h5>
        </div>
        <table class="layui-table" id="temp">
            <thead>
            <tr>
                <th style="width:10%;text-align: center">阶段</th>
                <th style="text-align:center">目标浓度(%)</th>
                <th style="text-align:center">开始时间</th>
                <th style="text-align:center">结束时间</th>
                <th style="text-align:center">作业用时(h)</th>
                <th style="text-align:center">最高浓度(%)</th>
                <th style="text-align:center">最低浓度(%)</th>
                <th style="text-align:center">平均浓度(%)</th>
            </tr>
            </thead>
            <!-- 表格内容start -->
            <tbody id="materialDetail" class="text-center">

                <c:forEach items="${ngasOperaSituations}" var="ngasOperaSituation" varStatus="idxStatus">
                    <tr>
                        <input type="hidden" name="ngasOperaSituation[${idxStatus.index}].orderNo" value="${ngasOperaSituation.orderNo}"lay-verify="" style="width:0px;"/>
                        <td ><input type="text" step="0.1" name="ngasOperaSituation[${idxStatus.index}].period" value="${ngasOperaSituation.period}"  class="layui-input" placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].targetThickness" value="${ngasOperaSituation.targetThickness}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
                        <td ><input type="text" step="0.1" name="ngasOperaSituation[${idxStatus.index}].startTime" value="<fmt:formatDate value='${ngasOperaSituation.startTime }' type='date' pattern='yyyy-MM-dd'/>"   class="layui-input" placeholder="--请输入--"/></td>
                        <td ><input type="text" step="0.1" name="ngasOperaSituation[${idxStatus.index}].endTime" value="<fmt:formatDate value='${ngasOperaSituation.endTime }' type='date' pattern='yyyy-MM-dd'/>"  class="layui-input" placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].duringTime" value="${ngasOperaSituation.duringTime}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].maxThickness" value="${ngasOperaSituation.maxThickness}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].minThickness" value="${ngasOperaSituation.minThickness}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
                        <td ><input type="number" step="0.1" name="ngasOperaSituation[${idxStatus.index}].avgThickness" value="${ngasOperaSituation.avgThickness}"  class="layui-input" lay-verify="number" placeholder="--请输入--"/></td>
                    </tr>
                </c:forEach>
            </tbody>
            <!-- 表格内容 end -->
        </table>
        <div class="layui-row title"></div>
        <div class="layui-row ">
            <div class="layui-col-md4">
                <span>效果判断：</span>
                <span>${ngasOperaRecord.resultJudge }</span>
            </div>
            <div class="layui-col-md4">
                <span>总能耗（kW.h）：</span>
                <span>${ngasOperaRecord.sumEnergy }</span>
            </div>
            <div class="layui-col-md4">
                <span>吨粮能耗（kW.h/T）：</span>
                <span>${ngasOperaRecord.avgEnergy }</span>
            </div>
        </div>
        <div class="layui-row ">
            <span>备注：</span>
            <p>
                ${ngasOperaRecord.remark }
            </p>
        </div>
        <p class="btn-box text-center">
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="cancel_btn"
                    onclick="cancelOperate('${auvp }', '${ctx }/ngasOperaRecord.shtml?type=${type}')">返回</button>
        </p>

</div>

<script src="${ctx}/js/app/storage/common.js"></script>

<script>



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
                elem: this
            });
        });

        form.render();

        form.on('submit(submit_btn)', function(){
            var form = $('#form');
            var tempForm = form.serializeObject();
            var ngasOperaSituation = [];

            for (var i = 0;i< index; i++){
                ngasOperaSituation.push({
                    orderNo : $("[name='ngasOperaSituation["+i+"].orderNo']").val(),
                    period : $("[name='ngasOperaSituation["+i+"].period']").val(),
                    targetThickness : $("[name='ngasOperaSituation["+i+"].targetThickness']").val(),
                    startTime : $("[name='ngasOperaSituation["+i+"].startTime']").val(),
                    endTime : $("[name='ngasOperaSituation["+i+"].endTime']").val(),
                    duringTime : $("[name='ngasOperaSituation["+i+"].duringTime']").val(),
                    maxThickness : $("[name='ngasOperaSituation["+i+"].maxThickness']").val(),
                    minThickness : $("[name='ngasOperaSituation["+i+"].minThickness']").val(),
                    avgThickness : $("[name='ngasOperaSituation["+i+"].avgThickness']").val()
                })
            }
            tempForm["ngasOperaSituation"] = ngasOperaSituation;
            console.info(tempForm);
            var json = JSON.stringify(tempForm);
            //form.serializeObject();
            //console.log(json);
            $.ajax({
                type : 'POST',
                url : '${ctx }/ngasOperaRecord/save.shtml?auvp=${auvp}',
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
                            location.href = '${ctx }/ngasOperaRecord.shtml?type='+$("#type").val();
                        });
                    }
                }
            });
        });
        /*form.on('submit(submit_btn)', function(){
       /!* $("#submit").click(function(){*!/

            $("#form").ajaxSubmit({
                url:"${ctx }/ngasOperaRecord/save.shtml?auvp=${auvp}'",
                type:"post",

                success:function(data){
                    if(data.success){
                        layer.msg("保存成功！",{icon:1},function(){
                            location.href = "${ctx}/ngasOperaRecord/view.shtml";
                        });
                    }else{
                        layer.msg("保存失败！",{icon:2});
                    }
                },
                error:function(){
                    layer.msg("系统异常！",{icon:2});
                }
            });
        });*/






        form.on('checkbox(radioFilter)', function(){
            var domName = $(this).attr("name");//获取当前单选框控件name 属性值
            var checkedState = $(this).attr("checked");//记录当前选中状态
            if(checkedState!="checked"){
                var ch = $("input:checkbox[name='" + domName + "']");
                for(var i=0;i<ch.length;i++){
                    var checked1 = $(ch[i]).attr("checked");
                    if(checked1=="checked"){
                        $(ch[i]).attr("checked",false);
                        var div = ch[i].nextSibling;
                        $(div).attr("class","layui-unselect layui-form-checkbox");
                    }
                }
                $(this).attr("checked",true);
                var div = this.nextSibling;
                $(div).attr("class","layui-unselect layui-form-checkbox layui-form-checked");
            }else{
                $(this).attr("checked",false);
                var div = this.nextSibling;
                $(div).attr("class","layui-unselect layui-form-checkbox");
            }
        });
    });

    function calculateAverage() {
        var lowAvg = Number($('input[name="lowAvg"]').val());
        var lowMiddleAvg = Number($('input[name="lowMiddleAvg"]').val());
        var topMiddleAvg = Number($('input[name="topMiddleAvg"]').val())
        var topAvg = Number($('input[name="topAvg"]').val());
        var avg = ((lowAvg + lowMiddleAvg + topMiddleAvg + topAvg)/4).toFixed(2);
        $('input[name="temperatureAvg"]').val(avg);
    }



    var index = $("#temp>tbody").children("tr").length;




</script>