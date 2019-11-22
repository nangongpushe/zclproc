<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!-- echarts Js -->
<script src="${ctx}/js/echarts.min.js"></script>
<style>
.layui-table-view {
    margin: 10px 10px !important;
}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li>数据字典</li>
		<li class="active">详情</li>
	</ol>
</div>
<div id="outSide">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			<legend>测试charts</legend>
<%-- 			<div class="layui-row">
			<div class="layui-col-md4 layui-col-md-offset8">
				<button class="layui-btn layui-btn-primary" onclick="javascript:window.location.href='${ctx}/sysDict/add.shtml'">添加词典</button>
			</div>	
			</div> --%>
	</fieldset>
		 <div class="row" style="margin:1%;">
            <div class="col-md-6" id="aa" style="height: 400px;border: 1px solid #ddd;
    ">
            </div>
            <div class="col-md-6" id="bb" style="height: 400px;    border: 1px solid #ddd;">
            </div>
            <div class="col-md-12"><div id="table"></div></div>
        </div>
	
 	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width: 600px;height:400px;"></div>
	</div>

<script>
 var myChart1 = echarts.init(document.getElementById('aa'));

        // 指定图表的配置项和数据
        option1 = {

    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
    	left: 'left',
        data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎','百度','谷歌','必应','其他']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : ['周一','周二','周三','周四','周五','周六','周日']
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'直接访问',
            type:'bar',
            data:[320, 332, 301, 334, 390, 330, 320]
        },
        {
            name:'邮件营销',
            type:'bar',
            stack: '广告',
            data:[120, 132, 101, 134, 90, 230, 210]
        },
        {
            name:'联盟广告',
            type:'bar',
            stack: '广告',
            data:[220, 182, 191, 234, 290, 330, 310]
        },
        {
            name:'视频广告',
            type:'bar',
            stack: '广告',
            data:[150, 232, 201, 154, 190, 330, 410]
        },
        {
            name:'搜索引擎',
            type:'bar',
            data:[862, 1018, 964, 1026, 1679, 1600, 1570],
            markLine : {
                lineStyle: {
                    normal: {
                        type: 'dashed'
                    }
                },
                data : [
                    [{type : 'min'}, {type : 'max'}]
                ]
            }
        },
        {
            name:'百度',
            type:'bar',
            barWidth : 5,
            stack: '搜索引擎',
            data:[620, 732, 701, 734, 1090, 1130, 1120]
        },
        {
            name:'谷歌',
            type:'bar',
            stack: '搜索引擎',
            data:[120, 132, 101, 134, 290, 230, 220]
        },
        {
            name:'必应',
            type:'bar',
            stack: '搜索引擎',
            data:[60, 72, 71, 74, 190, 130, 110]
        },
        {
            name:'其他',
            type:'bar',
            stack: '搜索引擎',
            data:[62, 82, 91, 84, 109, 110, 120]
        }
    ]
};


        // 使用刚指定的配置项和数据显示图表。
        myChart1.setOption(option1);
        
         var myChart2 = echarts.init(document.getElementById('bb'));

        // 指定图表的配置项和数据
       option2 = {
    title : {
        text: '某站点用户访问来源',
        subtext: '纯属虚构',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        data: ['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
    },
    series : [
        {
            name: '访问来源',
            type: 'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data:[
                {value:335, name:'直接访问'},
                {value:310, name:'邮件营销'},
                {value:234, name:'联盟广告'},
                {value:135, name:'视频广告'},
                {value:1548, name:'搜索引擎'}
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }
    ]
};


        // 使用刚指定的配置项和数据显示图表。
        myChart2.setOption(option2);

</script>
<%@ include file="../common/AdminFooter.jsp" %>