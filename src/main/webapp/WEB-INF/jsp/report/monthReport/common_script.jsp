<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<style>
    .panel-menu:hover{color:#606060; text-decoration:underline;font-weight:bold;}
    .content_right {
        border-left: 10px solid white;
    }
    .table>tbody>tr>td{
        padding:0px;
    }
    .header {
        margin: 0 0px;
    }
    .clearfix{
        margin: 0 5px 17px 5px;
        border-bottom: 2px solid #e2e2e2
    }
</style>
<script  src="${ctx}/js/dateUtil.js"></script>
<script  src="${ctx}/js/math.js"></script>
<script language="javascript" type="text/javascript">
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#month'
            ,type:'month'
            ,format: 'yyyy-MM'
            ,done: function(value, date, endDate){
                //console.log(value)
               // console.log('${reportMonth}')
                if(value == '${reportMonth}'){
//                    return;
                }
                if (!value){
                    $('.clearfix button:not(".search")').btnDisabled(true);
                    $('#fill_report').html('<div style="padding-left: 20px">没有数据</div>');
                    return false;
                }

                if(!(toDo=='appSum' || toDo=='querySum') && !$('#reportWarehouse').val()){
                    return;
                }
                loadReport( value);
            }
        });
    });

    //导出
    $('.export').click(function () {
        if($('#reportId').val()){

            if(toDo == 'appSum' || toDo == 'querySum'){
                $('#form-active-add').attr("action", '${ctx}'+exportUrl+'?flag=sum').submit();
            }else{
                if(reportName=='包装物库存月报表' && (toDo != 'fill')){ //bzwReportType为包装报表类型(汇总/详情)
                    $('#form-active-add').attr("action", '${ctx}'+exportUrl+'?bzwReportType='+bzwReportType).submit();
                }else{
                    $('#form-active-add').attr("action", '${ctx}'+exportUrl).submit();
                }

            }
        }else{
            layer.alert('请先保存报表!');
        }
    });

    //选择报表时触发
    var reportName = $('#reportName').val();
    $('#reportName').change(function(){
        reportName = $(this).val();
        if(reportName=='粮油库存实物台账月报表'){
            $('#swtzSearch').show();
        }else{
            $('#swtzSearch').hide();
        }
        var reportMonth = $('#month').val();
        if(!reportMonth) return;
        if(!(toDo=='appSum' || toDo=='querySum') && !$('#reportWarehouse').val()){
            return;
        }
        loadReport(reportMonth);
    });

    //选择库时触发
    $('#reportWarehouse').change(function(){
         var reportMonth = $('#month').val();
//        var reportMonth = $('.reportMonthTemp').val();
//        $('#month').val(reportMonth);
        if(!reportMonth) return;
//        reportName = $('.reportNameTemp').val();
        loadReport(reportMonth);
    });

    //储备粮油表设置年份
    function fill5Year() {
        //    储备粮油表设置年份
        var date=new Date();
        var year=date.getFullYear()
        var year1= year-6;
        var year2= year-5;
        var year3= year-4;
        var year4= year-3;
        var year5= year-2;
        var year6= year-1;
        $(".year1").text(year1+"年及以前")
        $(".year2").text(year2+"年")
        $(".year3").text(year3+"年")
        $(".year4").text(year4+"年")
        $(".year5").text(year5+"年")
        $(".year6").text(year6+"年")
        $(".year").text(year+"年");
    }

    //TABLE鼠标滚动事件
    function scroll() {
        $(".table_tab").scroll(function(){
            var top = $(this).scrollTop();
            var left = $(this).scrollLeft();
            if($(this).scrollTop()>0) {
                $(".public").css({
                    "top":-top+"px"
                });
            }else{
                $(".public").css({
                    "top":0+"px"
                });
            }
            if($(this).scrollLeft()>0){
                $(".header").css({
                    "left":-left+"px"
                });
                $("th").css({
                    "minWidth":"147.2px"
                })
            }else{
                $(".header").css({
                    "left":0+"px"
                });
            }
        });
    }

    /**
     * 自动计算(储备粮油收支月报表、商品粮油收支月报表、销往省外、省外购进)
     * @param disabled
     */
    function autoSum() {
        $('#tr-6 td:not(.active) input').keyup(function () {
            $('#tr-4 input[name='+ $(this).attr("name") +']').val(isNaN($(this).val())?"":$(this).val()); //折合小麦 = 实际小麦*1
            $('#tr-4 input[name='+ $(this).attr("name") +']').keyup();
            $('#tr-5 input[name='+ $(this).attr("name") +']').val(accMul($(this).val(),0.7).toFixed(2));//折合面粉 = 实际小麦*0.7
            $('#tr-5 input[name='+ $(this).attr("name") +']').keyup();
            rowSum($(this).attr("name"),1,4,7,19); //折合原粮合计1 =折合小麦4 + 折合稻谷合计7 + 折合玉米19
            rowSum($(this).attr("name"),3,4,7,19); //谷物合计3 = 折合小麦4 + 折合稻谷合计7 + 折合玉米19
            rowSum($(this).attr("name"),2,4,11,19); //贸易粮合计2 = 折合小麦4 + 折合大米合计11 + 折合玉米19
        });

        $('#tr-16 td:not(.active) input:not(.active)').keyup(function () {
            $('#tr-8 input[name='+ $(this).attr("name") +']').val($(this).val()); //折合早籼稻 = 实际早籼稻*1
            $('#tr-8 input[name='+ $(this).attr("name") +']').keyup();
            $('#tr-12 input[name='+ $(this).attr("name") +']').val(accMul($(this).val(),0.7).toFixed(2)); //折合早籼米 = 实际早籼稻*0.7
            $('#tr-12 input[name='+ $(this).attr("name") +']').keyup();
            rowSum($(this).attr("name"),7,8,9,10); //折合稻谷合计7 = 折合早籼稻8 + 折合中晚籼稻9 + 折合梗稻10
            rowSum($(this).attr("name"),11,12,13,14);  //折合大米合计11 = 折合早籼米12 + 折合中晚籼米13 + 折合粳米14
            rowSum($(this).attr("name"),1,4,7,19); //折合原粮合计1 =折合小麦4 + 折合稻谷合计7 + 折合玉米19
            rowSum($(this).attr("name"),3,4,7,19);  //谷物合计3 = 折合小麦4 + 折合稻谷合计7 + 折合玉米19
            rowSum($(this).attr("name"),2,4,11,19); //贸易粮合计2 = 折合小麦4 + 折合大米合计11 + 折合玉米19
            rowSum($(this).attr("name"),15,16,17,18); //实际稻谷合计15 = 实际早籼稻16 + 实际中晚籼稻17 + 实际粳稻18
        });
        $('#tr-17 td:not(.active) input').keyup(function () {
            $('#tr-9 input[name='+ $(this).attr("name") +']').val($(this).val()); //折合中晚籼稻 = 实际中晚籼稻*1
            $('#tr-9 input[name='+ $(this).attr("name") +']').keyup();
            $('#tr-13 input[name='+ $(this).attr("name") +']').val(accMul($(this).val(),0.7).toFixed(2)); //折合中晚籼米 = 实际中晚籼稻*0.7
            $('#tr-13 input[name='+ $(this).attr("name") +']').keyup();
            rowSum($(this).attr("name"),7,8,9,10); //折合稻谷合计7 = 折合早籼稻8 + 折合中晚籼稻9 + 折合梗稻10
            rowSum($(this).attr("name"),1,4,7,19); //折合原粮合计1 =折合小麦4 + 折合稻谷合计7 + 折合玉米19
            rowSum($(this).attr("name"),3,4,7,19); //谷物合计3 = 折合小麦4 + 折合稻谷合计7 + 折合玉米19
            rowSum($(this).attr("name"),11,12,13,14);  //折合大米合计11 = 折合早籼米12 + 折合中晚籼米13 + 折合粳米14
            rowSum($(this).attr("name"),2,4,11,19); //贸易粮合计2 = 折合小麦4 + 折合大米合计11 + 折合玉米19
            rowSum($(this).attr("name"),15,16,17,18); //实际稻谷合计15 = 实际早籼稻16 + 实际中晚籼稻17 + 实际粳稻18
        });
        $('#tr-18 td:not(.active) input').keyup(function () {
            $('#tr-10 input[name='+ $(this).attr("name") +']').val($(this).val()); ////折合粳稻 = 实际粳稻*1
            $('#tr-10 input[name='+ $(this).attr("name") +']').keyup();
            $('#tr-14 input[name='+ $(this).attr("name") +']').val(accMul($(this).val(),0.7).toFixed(2)); ////折合粳米 = 实际粳稻*0.7
            $('#tr-14 input[name='+ $(this).attr("name") +']').keyup();
            rowSum($(this).attr("name"),11,12,13,14);  //折合大米合计11 = 折合早籼米12 + 折合中晚籼米13 + 折合粳米14
            rowSum($(this).attr("name"),2,4,11,19); //贸易粮合计2 = 折合小麦4 + 折合大米合计11 + 折合玉米19
            rowSum($(this).attr("name"),15,16,17,18); //实际稻谷合计15 = 实际早籼稻16 + 实际中晚籼稻17 + 实际粳稻18
            rowSum($(this).attr("name"),7,8,9,10); //折合稻谷合计7 = 折合早籼稻8 + 折合中晚籼稻9 + 折合梗稻10
            rowSum($(this).attr("name"),1,4,7,19); //折合原粮合计1 =折合小麦4 + 折合稻谷合计7 + 折合玉米19
            rowSum($(this).attr("name"),3,4,7,19); //谷物合计3 = 折合小麦4 + 折合稻谷合计7 + 折合玉米19
        });
        $('#tr-20 td:not(.active) input').keyup(function () {
            $('#tr-19 input[name='+ $(this).attr("name") +']').val($(this).val()); //折合玉米 = 实际玉米*1
            $('#tr-19 input[name='+ $(this).attr("name") +']').keyup();
            rowSum($(this).attr("name"),1,4,7,19); //折合原粮合计1 =折合小麦4 + 折合稻谷合计7 + 折合玉米19
            rowSum($(this).attr("name"),3,4,7,19); //谷物合计3 = 折合小麦4 + 折合稻谷合计7 + 折合玉米19
            rowSum($(this).attr("name"),2,4,11,19); //贸易粮合计2 = 折合小麦4 + 折合大米合计11 + 折合玉米19
        });
        $('#tr-24 td:not(.active) input').keyup(function () {
            $('#tr-23 input[name='+ $(this).attr("name") +']').val($(this).val()); //折合大豆 = 实际大豆*1
            $('#tr-23 input[name='+ $(this).attr("name") +']').keyup();
            rowSum($(this).attr("name"),22,24,25); //豆类合计22 = 实际大豆24+实际豆饼豆柏25
        });
        $('#tr-25 td:not(.active) input').keyup(function () {
            rowSum($(this).attr("name"),22,24,25); //豆类合计22 = 实际大豆24+实际豆饼豆柏25
        });
        $('#tr-31 td:not(.active) input').keyup(function () {
            $('#tr-30 input[name='+ $(this).attr("name") +']').val($(this).val()); //折合菜籽油 = 实际菜籽油
            $('#tr-30 input[name='+ $(this).attr("name") +']').keyup();
        });

        /**
         * 把V1,V2,V3行的值相加到V行
         * @param name input的name
         * @param v 总数显示的行号
         * @param v1 被加的行号
         * @param v2
         */
        function rowSum(name,v, v1,v2,v3){
            var val = $('#tr-'+v1+' input[name='+ name +']').val();
            var val2 = $('#tr-'+v2+' input[name='+ name +']').val();
            val = accAdd(val,val2);
            if(v3){
                var val3 = $('#tr-'+v3+' input[name='+ name +']').val();
                val = accAdd(val,val3);
            }
            $('#tr-'+v+' input[name='+ name +']').val(val);
            $('#tr-'+v+' input[name='+ name +']').keyup();//由于字段计算的字段一般触发不了keyup,只能强迫触发
        }

    }

    function loadReport(month){

        $('#huizongbohui').hide();
        layer.load(2);
        var url = "";

        try{
            if(this_app_ku_mian_j){
                $('.d_isplay_n_o_n_e_cs_').removeClass('display_none_cs')
            }
        }catch(e){
            //console.log('catch')
        }

        if(reportName == '储备粮油收支月报表'){
            url = "${ctx}/reportCbly/"+toDo+"Cbly.shtml";
        }else if(reportName == '商品粮油收支月报表'){
            url = "${ctx}/reportSply/"+toDo+"Sply.shtml";
        }else if(reportName == '销往省外'){
            url = "${ctx}/reportXwsw/"+toDo+"Xwsw.shtml";
        }else if(reportName == '省外购进'){
            url = "${ctx}/reportXwsw/"+toDo+"Xwsw.shtml";
        }else if(reportName == '粮油库存实物台账月报表'){
            url = "${ctx}/reportSwtz/"+toDo+"Swtz.shtml";

            if(toDo=="querySum"){
                url = "${ctx}/reportSwtz/exportSwtzSum1.shtml?state=HZTG";
            }else if(toDo=="appSum"){
                url = "${ctx}/reportSwtz/exportSwtzSum1.shtml?state=HZDS";
            }

        }else if(reportName == '库存包装物出入库明细表'){
            url = "${ctx}/reportBzwcrmx/"+toDo+"Bzwcrmx.shtml";
        } else {
            url = "${ctx}/reportBzw/"+toDo+"Bzw.shtml";
        }

        var   aa=$('#reportId').val();
        var   bb=$('#reportWarehouseId1').val();
        $('#fill_report').load(url,
            {reportMonth : month, reportName : reportName,
                    reportWarehouseId:$('#reportWarehouseId').val(),
                    reportWarehouse:$('#reportWarehouse').val()
            },
            function (responseText,textStatus) {
                $('.clearfix button:not(".search")').btnDisabled(true);
                $('#fill_report input').attr('readOnly',true);
                $('#fill_report select').attr('disabled',true);
                $('#fill_report textarea').attr('readOnly',true);
                $('#leftTable a').hide();
                //$('.addRow').hide();
                if(textStatus == 'success'){
                    if(dataList){
                        init();
                        $('.export').btnDisabled(false);
                        if(reportName == '储备粮油收支月报表'
                            || reportName == '商品粮油收支月报表'
                            || reportName == '销往省外'
                            || reportName == '省外购进'){
                            //自动计算
                            autoSum();
                        }
                        //非填报的行样式修改
                        if(toDo != 'fill'){
                            $('.table_box table tr').addClass('active');
                        }
                    }else if(toDo == 'fill'){
                        //限制数字输入
                        $(".number").keyup(function(){
                            onlyNumber(this);
                            sum(this);
                        }).blur(function(){
                            onlyNumber(this);
                            sum(this);
                        });
                        //填报时间
                        $("#nowMonth").html(new Date().Format("YYYY年M月D日"));
                        $('#fill_report input').attr('readOnly',false);
                        $('#fill_report select').attr('disabled',false);
                        $('#fill_report textarea').attr('readOnly',false);
                        $('#leftTable a').show();
                        $('tr.active input').attr('readOnly',true);
                        $('td.active input').attr('readOnly',true);
                        if(reportName == '粮油库存实物台账月报表' || reportName == '包装物库存月报表'|| reportName == '库存包装物出入库明细表'){
                            $('.addRow').show();
                            $('.copyRow').hide();
                        }else if(reportName == '储备粮油收支月报表' || reportName == '商品粮油收支月报表' || reportName == '销往省外' ||
                            reportName == '省外购进'){
                            //自动计算
                            autoSum();
                        }
                        $('.save').btnDisabled(false);
                    }else{
                        $('#fill_report').html('<div style="padding-left: 20px">没有数据</div>');
                    }
                }else{
                    $('#fill_report').html(responseText);
                }
                scroll();
                layer.closeAll("loading");
            }
        );
    }

    function onlyNumber(obj){
        //得到第一个字符是否为负号
        var t = obj.value.charAt(0);
        //先把非数字的都替换掉，除了数字和.
        obj.value = obj.value.replace(/[^\d\.]/g,'');
        //必须保证第一个为数字而不是.
        obj.value = obj.value.replace(/^\./g,'');
        //保证只有出现一个.而没有多个.
        obj.value = obj.value.replace(/\.{2,}/g,'.');
        //保证.只出现一次，而不能出现两次以上
        obj.value = obj.value.replace('.','$#$').replace(/\./g,'').replace('$#$','.');
        //如果第一位是负号，则允许添加
        if(t == '-'){
            obj.value = '-'+obj.value;
        }
    }

    function sum(obj){

        //处理列合计
//        sumCol的值为需要合计的input序号以,隔开 如(sumCol=(2,5,10-11));
        $(obj).parent().parent().find("input[sumCol]").each(function(){
            var sumCol1 = $(this).attr('sumCol').split(',');

            var total = "";
            for(i in sumCol1){
                // debugger;
                var sumCol2 = sumCol1[i].split('-');
                if(sumCol2.length>1){
                    for(var j=parseInt(sumCol2[0]); j<=parseInt(sumCol2[1]); j++){
                        total = accAdd(total,$(this).parent().parent().find('input:eq('+j+')').val());
                    }
                }else{
                    total = accAdd(total,$(this).parent().parent().find('input:eq('+sumCol1[i]+')').val());
                }
            }
            $(this).val(total);
        });
        //处理列减法运算
        //第一个减去后面几个
        $(obj).parent().parent().find("input[deSumCol]").each(function(){
            var deSumCol = $(this).attr('deSumCol').split(',');
            var total = "";
            for(var i=1;  i<deSumCol.length; i++){
                total = accAdd(total,$(this).parent().parent().find('input:eq('+deSumCol[i]+')').val());
            }
            $(this).val(accSub($(this).parent().parent().find('input:eq('+deSumCol[0]+')').val(),total));
        });

        //处理行合计
//        var col = $(obj).parent().index();
        var name = $(obj).attr('name');
        var sumRow = $('#sumTbody input[name='+name+'][sumRow]').attr('sumRow');
        $('#sumTbody input[name='+name+'][sumRow]').each(function () {
            var sumRow = $(this).attr('sumRow').split(',');
            var total = "";
            for(j in sumRow){
                total = accAdd(total,$('#sumTbody tr:eq('+sumRow[j]+')').find('input[name='+name+']').val());
            }
            $(this).val(total);

            //处理合计的合计(.colSum)
            var colsum = "";
            $(this).parent().parent().find("input[sumRow]").each(function(){
                colsum = accAdd(colsum,$(this).val());
            });
            $(this).parent().parent().find(".colSum").val(colsum);
        });
    }

    /**
     * 按钮是否禁用
     * @param disabled
     */
    $.fn.btnDisabled = function (disabled) {
        $(this).attr('disabled',disabled);
        if(disabled)
            $(this).addClass('layui-btn-disabled');
        else
            $(this).removeClass('layui-btn-disabled');
    }

</script>