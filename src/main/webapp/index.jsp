<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>xxx生产管理系统</title>
    <%@include file="/common.jsp"%>
    <!-- 公共CSS样式 -->
    <link rel="stylesheet" href="css/index.css"/>

</head>
<body style="">
<div class="navbar navbar-default navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand slideLeft" href="#">
                <span class="logo_box">
                    <img class="logo" alt="Brand" src="images/logo.png">
                    <img class="logo-single" alt="Brand" src="images/logo-single.png">
                </span>
            </a>
            <ul class="nav navbar-nav navbar-right account">
                <li class="slide stretch"><a href="javascript:;"><em class="glyphicon glyphicon-menu-hamburger"></em></a></li>
            </ul>
        </div>
        <ul class="nav navbar-nav navbar-right account">          
            <li>
                <a href="javascript:;"><span style="margin-right: 20px;font-size: 12px">张三</span><em class="glyphicon glyphicon-user"></em></a>
                <ul class="service">
                    <li><a href="javascript:;"><i class="glyphicon glyphicon-user"></i><span>张三</span></a></li>
                    <li><a href="javascript:;"><i class="glyphicon glyphicon-log-out"></i><span>退出</span></a></li>
                </ul>
            </li>
            <li class="information">
                <a href="javascript:;"><em class="glyphicon glyphicon-bell"></em></a>
                <div class="header-message-num">2</div>
            </li>
            <li><a href="javascript:;"><em class="glyphicon glyphicon-resize-full"></em></a></li>
        </ul>
    </div>
</div>
<!-- 消息任务窗口 -->
<div class="task_window">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
      <ul class="layui-tab-title">
        <li class="layui-this">系统公告</li>
        <li>代办事项</li>
      </ul>
      <div class="layui-tab-content" style="height: 100px;">
        <div class="layui-tab-item layui-show">
        </div>
        <div class="layui-tab-item">
        </div>
      </div>
    </div> 
</div>
<div class="content">
    <div class="content-box clearfix">
    	<!-- 左侧导航栏 -->
        <div class="sidebar slideLeft" id="accordion" >
            <ul class="left-menu-ul">
            	<li>
                    <a href="javascript:;"><span class="left-menu-text">测试</span></a>
                   <div class="second-menu second-menu-left-full">
                       <div class="second-menu-wrap">
                           <ul class="second-menu-item">
                               <li class="third-menu-wrap"><a target="myFrameName" href="${ctx }/test.shtml">测试</a>
                               </li>
                           </ul>
                       </div>
                   </div>
                </li>
                <li>
                    <a href="javascript:;"><i class="glyphicon glyphicon-list-alt"></i><span class="left-menu-text">报表台账</span></a>
                   <div class="second-menu second-menu-left-full">
                       <div class="second-menu-wrap">
                           <ul class="second-menu-item">
                               <li class="third-menu-wrap"><a class="third-menu-title">报表管理</a>
                                   <ul class="third-menu-item">
                                       <li><a target="myFrameName" href="html/report_ku_add.html">[库]报表填报</a></li>
                                       <li><a target="myFrameName" href="html/report_search_ku.html">[库]报表查询</a></li>
                                       <li><a target="myFrameName" href="html/report_ku_approval.html">[库]报表审核</a></li>
                                       <li><a target="myFrameName" href="html/report_search.html">[公司]分库查询</a></li>
                                       <li><a target="myFrameName" href="html/report_totle_new.html">[公司]分库审核</a></li>
                                       <li><a target="myFrameName" href="html/report_summary_statistics.html">[公司]汇总审核</a></li>
                                       <li><a target="myFrameName" href="html/report_summary_statistics.html">[公司]汇总查询</a></li>
                                   </ul>
                               </li>
                               <li class="third-menu-wrap"><a class="third-menu-title">统计分析</a>
                                   <ul class="third-menu-item">
                                       <li><a target="myFrameName" href="html/report_inventory_search.html">库存查询</a></li>
                                       <li><a target="myFrameName" href="html/report_inventory_analysis.html">库存统计</a></li>
                                       <li><a target="myFrameName" href="html/report_statistics_circulate.html">流通流向</a></li>
                                       <li><a target="myFrameName" href="html/report_people_analysis.html">人员统计</a></li>
                                   </ul>
                               </li>
                           </ul>
                       </div>
                   </div>
                </li>
                <li>
                    <a href="javascript:;"><span class="left-menu-text">轮换业务</span></a>
                    <!--<a href="javascript:;"><i class="glyphicon glyphicon-refresh"></i><span class="left-menu-text">轮换业务</span></a>-->
                   <div class="second-menu second-menu-left-full">
                       <div class="second-menu-wrap">
                           <!--<ul class="second-menu-item"><span class="second-menu-title">轮换准备</span>-->
                           <ul class="second-menu-item">
                               <li class="third-menu-wrap"><a class="third-menu-title">轮换计划</a>
                                   <ul class="third-menu-item">
                                       <li><a target="myFrameName" href="html/rotate_plan.html">计划申报</a></li>
                                       <li><a target="myFrameName" href="html/rotate_list.html">计划清单</a></li>
                                   </ul>
                               </li>
                               <li class="third-menu-wrap"><a class="third-menu-title">轮换计划详情</a>
                                   <ul class="third-menu-item">
                                       <li><a target="myFrameName" href="html/rotate_plan.html">计划申报</a></li>
                                       <li><a target="myFrameName" href="html/rotate_list.html">计划清单</a></li>
                                   </ul>
                               </li>
                               <li class="third-menu-wrap"><a class="third-menu-title">轮换方案</a>
                                   <ul class="third-menu-item">
                                       <li><a target="myFrameName" href="html/rotate_create_scheme.html">创建方案</a></li>
                                       <li><a target="myFrameName" href="html/rotate_scheme_list.html">方案列表</a></li>
                                   </ul>
                               </li>
                               <li class="third-menu-wrap"><a class="third-menu-title">竞标管理</a>
                                   <ul class="third-menu-item">
                                       <li><a target="myFrameName" href="html/rotate_bid.html">标的物明细</a></li>
                                       <li><a target="myFrameName" href="html/rotate_bidResult.html">成交结果明细</a></li>
                                       <li class="four-menu-wrap"><a class="third-menu-title">招标竞价结果</a>
                                           <ul class="four-menu-item">
                                               <li ><a href="html/maintenance.html" target="myFrameName" >招标采购结果</a></li>
                                               <li ><a href="html/scrap.html" target="myFrameName" >招标销售结果</a></li>
                                               <!--<li ><a href="html/flood_control_materials.html" target="myFrameName" >防汛物资台账</a></li>-->
                                               <!--<li ><a href="html/consumable_inventory.html" target="myFrameName" >易耗品盘点记录</a></li>-->
                                           </ul>
                                       </li>
                                   </ul>
                               </li>
                               <li class="third-menu-wrap"><a class="third-menu-title">通知书管理</a>
                                   <ul class="third-menu-item">
                                       <li><a target="myFrameName" href="html/rotate_storage_notice.html">出库通知书</a></li>
                                       <li><a target="myFrameName" href="html/rotate_storage_notice.html">入库通知书</a></li>
                                       <li><a target="myFrameName" href="##">移库通知书</a></li>
                                       <li><a target="myFrameName" href="##">提货单</a></li>
                                   </ul>
                               </li>
                               <li class="third-menu-wrap"><a class="third-menu-title">货款管理</a>
                                   <ul class="third-menu-item">
                                       <li><a target="myFrameName" href="html/rotate_progress_report.html">货款到帐单</a></li>
                                       <li><a target="myFrameName" href="html/rotate_gather.html">货款认领单</a></li>
                                       <!--<li><a target="myFrameName" href="html/rotate_find.html">[公司]汇总查询</a></li>-->
                                   </ul>
                               </li>
                               <li class="third-menu-wrap"><a class="third-menu-title">执行进度</a>
                                   <ul class="third-menu-item">
                                       <li><a target="myFrameName" href="html/rotate_progress_report.html">[库]进度上报</a></li>
                                       <li><a target="myFrameName" href="html/rotate_gather.html">[公司]进度汇总</a></li>
                                       <li><a target="myFrameName" href="html/rotate_find.html">[公司]汇总查询</a></li>
                                   </ul>
                               </li>
                               <li class="third-menu-wrap"><a class="third-menu-title">商务处理</a>
                                   <ul class="third-menu-item">
                                       <!--<li><a target="myFrameName" href="html/rotate_gather.html">[库]进度上报入库完成</a></li>-->
                                       <!--<li><a target="myFrameName" href="##">[库]合同履行完毕</a></li>-->
                                       <li><a target="myFrameName" href="##">[公司]满仓商务处理</a></li>
                                       <li><a target="myFrameName" href="##">[公司]货款支付审批</a></li>
                                       <li><a target="myFrameName" href="##">[公司]保证金退还联系单</a></li>
                                   </ul>
                               </li>
                               <li class="third-menu-wrap"><a class="third-menu-title">运费管理</a>
                                   <ul class="third-menu-item">
                                       <li class="third-menu-wrap"><a class="third-menu-title">运费采购方案</a></li>
                                       <li class="third-menu-wrap"><a class="third-menu-title">运费成交结果</a></li>
                                       <li class="third-menu-wrap"><a class="third-menu-title">运费审批管理</a></li>
                                   </ul>
                               </li>
                           </ul>
                       </div>    
                   </div>
                </li>
                <!--<li>-->
                    <!--<a href="javascript:;"><span class="left-menu-text">运费管理</span></a>-->
                    <!--&lt;!&ndash;<a href="javascript:;"><i class="glyphicon glyphicon-retweet"></i><span class="left-menu-text">中转业务</span></a>&ndash;&gt;-->
                    <!--<div class="second-menu second-menu-left-full">-->
                        <!--<div class="second-menu-wrap">-->
                            <!--&lt;!&ndash;<ul class="second-menu-item"><span class="second-menu-title">轮换准备</span>&ndash;&gt;-->
                            <!--<ul class="second-menu-item">-->
                                <!--<li class="third-menu-wrap"><a class="third-menu-title">运费采购方案</a></li>-->
                                <!--<li class="third-menu-wrap"><a class="third-menu-title">运费成交结果</a></li>-->
                                <!--<li class="third-menu-wrap"><a class="third-menu-title">运费审批管理</a></li>-->


                            <!--</ul>-->
                        <!--</div>-->
                    <!--</div>-->
                <!--</li>-->

                <li>
                    <a href="javascript:;"><span class="left-menu-text">中转业务</span></a>
                    <!--<a href="javascript:;"><i class="glyphicon glyphicon-equalizer"></i><span class="left-menu-text">基建项目</span></a>-->
                    <div class="second-menu second-menu-left-full">
                        <div class="second-menu-wrap">
                            <!--<ul class="second-menu-item"><span class="second-menu-title">轮换准备</span>-->
                            <ul class="second-menu-item">
                                <li class="third-menu-wrap" style="height: 40px;line-height: 40px"><a class="third-menu-title">中转业务统计</a>
                                    <!--<ul class="third-menu-item">-->
                                        <!--&lt;!&ndash;<li><a href="html/construction_addconstruction.html"  target="myFrameName">所属库</a></li>&ndash;&gt;-->
                                        <!--&lt;!&ndash;<li><a href="html/construction_manageConstruction.html"  target="myFrameName">品种</a></li>&ndash;&gt;-->
                                    <!--</ul>-->
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="javascript:;"><span class="left-menu-text">基建管理</span></a>
                    <!--<a href="javascript:;"><i class="glyphicon glyphicon-equalizer"></i><span class="left-menu-text">基建项目</span></a>-->
                    <div class="second-menu second-menu-left-full">
                        <div class="second-menu-wrap">
                            <!--<ul class="second-menu-item"><span class="second-menu-title">轮换准备</span>-->
                            <ul class="second-menu-item">
                                <li class="third-menu-wrap"><a href="html/construction_addconstruction.html" class="third-menu-title" target="myFrameName">新增项目</a></li>
                                <li class="third-menu-wrap"><a href="html/construction_manageConstruction.html" class="third-menu-title" target="myFrameName">管理项目</a></li>
                                <li class="third-menu-wrap"><a href="html/construction_annualPlan.html"  class="third-menu-title"  target="myFrameName">年度计划</a></li>
                                <li class="third-menu-wrap"><a href="html/construction_bidding.html"  class="third-menu-title" target="myFrameName">招投标</a></li>
                                <li class="third-menu-wrap" ><a href="html/construction_change.html"  class="third-menu-title" target="myFrameName">项目变更</a></li>
                                <li class="third-menu-wrap" ><a href="html/construction_schedule.html"  class="third-menu-title" target="myFrameName">工程进度</a></li>
                                <li class="third-menu-wrap" ><a href="html/construction_check.html"  class="third-menu-title" target="myFrameName">工程验收</a></li>
                                <li class="third-menu-wrap" ><a href="html/construction_SettleAccounts.html"  class="third-menu-title" target="myFrameName">工程结算</a></li>
                                <li class="third-menu-wrap"><a  class="third-menu-title" href="##" >工程拨款</a></li>
                                <li class="third-menu-wrap" ><a  class="third-menu-title" href="##" >工程资料</a></li>
                             </ul>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="javascript:;"><span class="left-menu-text">客户管理</span></a>
                    <!--<a href="javascript:;"><i class="glyphicon glyphicon-user"></i><span class="left-menu-text">客户管理</span></a>-->
                    <div class="second-menu second-menu-left-full">
                        <div class="second-menu-wrap">
                            <!--<ul class="second-menu-item"><span class="second-menu-title">轮换准备</span>-->
                            <ul class="second-menu-item">
                                <li class="third-menu-wrap"><a class="third-menu-title">客户信息</a>
                                    <!--<ul class="third-menu-item">-->
                                    <!--<li><a href="##" >统计分析</a></li>-->
                                    <!--</ul>-->
                                </li>
                                <!--<li class="third-menu-wrap"><a class="third-menu-title">客户回款</a>-->
                                    <!--<ul class="third-menu-item">-->
                                        <!--<li ><a href="html/client_proceeds.html" target="myFrameName" >收款单</a></li>-->
                                        <!--<li ><a href="html/client_ProceedsClaim.html" target="myFrameName">收款认领单</a></li>-->
                                        <!--<li ><a href="html/client_ReturnedMoney.html" target="myFrameName">回款管理</a></li>-->
                                    <!--</ul>-->
                                <!--</li>-->
                                <li class="third-menu-wrap"><a class="third-menu-title">统计分析</a>
                                    <!--<ul class="third-menu-item">&ndash;&gt;-->
                                        <!--<li ><a href="html/client_proceeds.html" target="myFrameName" >收款单</a></li>-->
                                        <!--<li ><a href="html/client_ProceedsClaim.html" target="myFrameName">收款认领单</a></li>-->
                                        <!--<li ><a href="html/client_ReturnedMoney.html" target="myFrameName">回款管理</a></li>-->
                                    <!--</ul>-->
                                </li>

                            </ul>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="javascript:;"><span class="left-menu-text">代储监管</span></a>
                    <!--<a href="javascript:;"><i class="glyphicon glyphicon-bookmark"></i><span class="left-menu-text">代储监管</span></a>-->
                    <div class="second-menu second-menu-left-full">
                        <div class="second-menu-wrap">
                            <!--<ul class="second-menu-item"><span class="second-menu-title">轮换准备</span>-->
                            <ul class="second-menu-item">
                                <li class="third-menu-wrap"><a class="third-menu-title">分片监管</a>
                                    <!--<ul class="third-menu-item">-->
                                        <!--<li ><a href="html/store_supervision.html" target="myFrameName" >企业基本信息</a></li>-->
                                        <!--<li ><a href="html/storage_warehouse.html" target="myFrameName" >库点管理</a></li>-->
                                        <!--&lt;!&ndash;<li ><a href="html/storage_warehouse_barn.html" target="myFrameName" >代储业务信息管理</a></li>&ndash;&gt;-->
                                        <!--&lt;!&ndash;<li ><a href="html/supervision_plan.html" target="myFrameName" >代储监管计划管理</a></li>&ndash;&gt;-->
                                        <!--&lt;!&ndash;<li ><a href="html/superior_unit_declaration.html" target="myFrameName" >年度仓储管理优胜单位申报</a></li>&ndash;&gt;-->
                                    <!--</ul>-->
                                </li>
                                <li class="third-menu-wrap"><a class="third-menu-title">企业信息</a>
                                    <ul class="third-menu-item">
                                        <li ><a href="html/store_supervision.html" target="myFrameName" >企业基本信息</a></li>
                                        <li ><a href="html/storage_warehouse.html" target="myFrameName" >库点管理</a></li>
                                        <!--<li ><a href="html/storage_warehouse_barn.html" target="myFrameName" >代储业务信息管理</a></li>-->
                                        <!--<li ><a href="html/supervision_plan.html" target="myFrameName" >代储监管计划管理</a></li>-->
                                        <!--<li ><a href="html/superior_unit_declaration.html" target="myFrameName" >年度仓储管理优胜单位申报</a></li>-->
                                    </ul>
                                </li>
                                <li class="third-menu-wrap"><a class="third-menu-title">业务信息</a>
                                    <ul class="third-menu-item">
                                        <li ><a href="html/enterprise_inspection.html" target="myFrameName" >考核评分</a></li>
                                        <!--<li ><a href="html/assessment_template.html" target="myFrameName" >考核内容</a></li>-->
                                        <li ><a href="html/problem_feedback.html" target="myFrameName" >问题反馈</a></li>
                                        <!--<li ><a href="html/problem_feedback.html" target="myFrameName" >代储监管计划管理</a></li>-->
                                        <li ><a href="html/superior_unit_declaration.html" target="myFrameName">优胜单位申报</a></li>
                                    </ul>
                                </li>
                                <li class="third-menu-wrap"><a class="third-menu-title">报表台账</a>
                                    <!--与上面的报表台账一样-->
                                    <!--<ul class="third-menu-item">-->
                                        <!--<li ><a href="html/grain_oil_inventory_ledger.html" target="myFrameName">报表</a></li>-->
                                        <!--<li ><a href="html/allocation_cost.html" target="myFrameName" >台账</a></li>-->
                                        <!--粮温信息以图表信息展示-->
                                        <!--<li ><a href="html/grain_inspection.html" target="myFrameName" >粮温信息</a></li>-->
                                        <!--<li class="list-group"><a href="html/quality.html" target="myFrameName" style="padding-left: 40px !important;">质量表</a></li>-->
                                    <!--</ul>-->
                                </li>
                                <li class="third-menu-wrap"><a class="third-menu-title">粮温信息</a></li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="javascript:;"><span class="left-menu-text">物资管理</span></a>
                    <!--<a href="javascript:;"><i class="glyphicon glyphicon-usd"></i><span class="left-menu-text">资产管理</span></a>-->
                    <div class="second-menu second-menu-left-full">
                        <div class="second-menu-wrap">
                            <ul class="second-menu-item">
                                <li class="third-menu-wrap"><a class="third-menu-title" href="html/material_purchasing.html" target="myFrameName" >采购管理</a>
                                   <!--采购管理就是一个信息？-->
                                    <!--<ul class="third-menu-item">-->
                                        <!--<li ><a href="html/material_purchasing.html" target="myFrameName" >物资采购</a></li>-->
                                    <!--</ul>-->
                                </li>
                                <li class="third-menu-wrap"><a class="third-menu-title">库存管理</a>
                                    <!--<ul class="third-menu-item">-->
                                        <!--<li ><a href="html/card_manage.html" target="myFrameName" >卡片管理</a></li>-->
                                        <!--<li ><a href="html/material_detail.html" target="myFrameName" >物资明细</a></li>-->
                                        <!--<li ><a href="html/material_collar.html" target="myFrameName" >物资领用</a></li>-->
                                        <!--<li ><a href="html/material_lend.html" target="myFrameName" >物资借出</a></li>-->
                                        <!--<li ><a href="html/material_allocation.html" target="myFrameName" >物资调拨管理</a></li>-->
                                    <!--</ul>-->
                                </li>
                                <li class="third-menu-wrap"><a class="third-menu-title" href="html/maintenance.html" target="myFrameName" >维修管理</a>
                                    <!--<ul class="third-menu-item">-->
                                        <!--<li ><a href="html/maintenance.html" target="myFrameName" >保养维修管理</a></li>-->
                                        <!--<li ><a href="html/scrap.html" target="myFrameName" >报废管理</a></li>-->
                                        <!--<li ><a href="html/flood_control_materials.html" target="myFrameName" >防汛物资台账</a></li>-->
                                        <!--<li ><a href="html/consumable_inventory.html" target="myFrameName" >易耗品盘点记录</a></li>-->
                                    <!--</ul>-->
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="javascript:;"><span class="left-menu-text">质量管理</span></a>
                    <!--<a href="javascript:;"><i class="glyphicon glyphicon-list-alt"></i><span class="left-menu-text">质量管理</span></a>-->
                    <div class="second-menu second-menu-left-full">
                        <div class="second-menu-wrap">
                            <ul class="second-menu-item">
                                <!--<li class="third-menu-wrap"><a class="third-menu-title">质量管理</a>-->
                                    <!--<ul class="third-menu-item">-->
                                        <li class="third-menu-wrap"><a class="third-menu-title">检验任务</a>
                                            <ul class="third-menu-item">
                                                <li ><a href="html/quality_task_scheme.html" target="myFrameName" >样品信息</a></li>
                                                <li ><a href="html/quality_sample_scheme.html" target="myFrameName" >样品管理</a></li>
                                                <li ><a href="html/quality_bear_scheme.html" target="myFrameName" >检验结果</a></li>
                                            </ul>
                                        </li>
                                        <li class="third-menu-wrap"><a class="third-menu-title">质量档案</a>
                                            <ul class="third-menu-item">
                                                <li ><a href="html/quality_files_scheme.html" target="myFrameName" >检验报告</a></li>
                                                <li ><a href="html/quality_files_scheme.html" target="myFrameName" >结果分析</a></li>
                                            </ul>
                                        </li>
                                        <!--<li ><a href="html/quality_sample_scheme.html" target="myFrameName" >扦样样品管理</a></li>-->
                                        <!--<li ><a href="html/quality_task_scheme.html" target="myFrameName" >检验任务管理</a></li>-->
                                        <!--<li ><a href="html/quality_bear_scheme.html" target="myFrameName" >检验结果管理</a></li>-->
                                        <!--<li ><a href="html/quality_record_scheme.html" target="myFrameName" >第三方质检记录</a></li>-->
                                        <!--<li ><a href="html/quality_quota_scheme.html" target="myFrameName" >等级指标管理</a></li>-->
                                        <!--<li ><a href="html/quality_files_scheme.html" target="myFrameName" >质量档案管理</a></li>-->
                                        <!--<li ><a href="html/quality_mould_scheme.html" target="myFrameName" >粮油检测模板管理</a></li>-->
                                    <!--</ul>-->
                                <!--</li>-->
                            </ul>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="javascript:;"><span class="left-menu-text">仓储管理</span></a>
                    <!--<a href="javascript:;"><i class="glyphicon glyphicon-home"></i><span class="left-menu-text">仓储管理</span></a>-->
                    <div class="second-menu second-menu-left-full">
                        <div class="second-menu-wrap">
                            <ul class="second-menu-item">
                                <li class="third-menu-wrap"><a class="third-menu-title" href="html/storage_place_scheme.html" target="myFrameName" >四化粮库</a>
                                    <!--<ul class="third-menu-item">-->
                                        <!--<li ><a href="html/storage_place_scheme.html" target="myFrameName" >库点管理</a></li>-->
                                        <!--<li ><a href="html/storage_country_scheme.html" target="myFrameName" >全国库存检查</a></li>-->
                                        <!--<li ><a href="##" target="myFrameName" >耗能管理</a></li>-->
                                    <!--</ul>-->
                                </li>
                                <li class="third-menu-wrap"><a class="third-menu-title" href="html/storage_oil_scheme.html" target="myFrameName" >星级粮库</a>
                                    <!--<ul class="third-menu-item">-->
                                        <!--<li ><a href="html/storage_house_scheme.html" target="myFrameName" >仓房信息管理</a></li>-->
                                        <!--<li ><a href="html/storage_tank_scheme.html" target="myFrameName" >油罐信息管理</a></li>-->
                                        <!--<li ><a href="##" target="myFrameName" class="undone" >仓容信息统计</a></li>-->
                                    <!--</ul>-->
                                </li>
                                <li class="third-menu-wrap"><a class="third-menu-title">全国查库</a>
                                    <ul class="third-menu-item">
                                        <li ><a href="html/storage_situation_scheme.html" target="myFrameName" >工作底稿</a></li>
                                        <li ><a href="html/storage_oil_scheme.html" target="myFrameName" >报表</a></li>
                                        <li ><a href="##" >总结</a></li>
                                        <!--<li ><a href="html/storage_machine_scheme.html" target="myFrameName" >机械通风记录</a></li>-->
                                        <!--<li ><a href="html/storage_fumigate_scheme.html" target="myFrameName" >熏蒸记录</a></li>-->
                                        <!--<li ><a href="html/storage_phosphine_scheme.html" target="myFrameName" >磷化氢检测记录</a></li>-->
                                        <!--<li ><a href="html/storage_tickness_scheme.html" target="myFrameName" >氮气浓度检测记录</a></li>-->
                                        <!--<li ><a href="html/storage_cooling_scheme.html" target="myFrameName" >谷物冷却记录</a></li>-->
                                        <!--<li ><a href="##" class="undone"  >粮情三温图</a></li>-->
                                        <!--<li ><a href="##" class="undone" >粮油三温图</a></li>-->
                                    </ul>
                                </li>
                                <li class="third-menu-wrap"><a class="third-menu-title" href="html/storage_oil_scheme.html" target="myFrameName" >作业能耗</a>
                                    <ul class="third-menu-item">
                                        <li ><a href="html/storage_start_scheme.html" target="myFrameName" >通风</a></li>
                                        <li ><a href="html/storage_score_scheme.html" target="myFrameName" >气调</a></li>
                                        <li ><a href="html/storage_ feedback_scheme.html" target="myFrameName">熏蒸</a></li>
                                        <li ><a href="html/storage_score_scheme.html" target="myFrameName" >温控</a></li>
                                        <li ><a href="html/storage_score_scheme.html" target="myFrameName" >出入库</a></li>
                                        <li ><a href="html/storage_score_scheme.html" target="myFrameName" >中转</a></li>
                                    </ul>
                                </li>
                             </ul>
                        </div>
                    </div>
                </li>
            </ul>
    
        </div>
        <!-- 右侧具体内容页 -->
        <div class="embed-responsive">
            <div class="iframe_box">
                <iframe class="embed-responsive-item myFrame" name="myFrameName" id="childFrame" scrolling = " auto " src="" height="100%" ></iframe>
            </div>
        </div>
    </div>
</div>

<!-- 首页js -->
<script type="text/javascript">
   
    window.onresize = function(){
        var W = document.documentElement.clientWidth || document.body.clientWidth;//获取屏幕宽度
        $(".embed-responsive").css({"width": W-190});
    }
    $(".embed-responsive").css({"width": W-190});
    var arry = new Array();
    //侧边导航栏显示
    $(".slide").click(function() {
        var _this = $(this);
        if (_this.hasClass("stretch")) {
             $(".left-menu-ul>li").animate({
                "width": "78px"
            })
            $(".navbar-brand").animate({
                "width": "78px"
            }, 400, function () {
                _this.attr("class", "slide shrink");
                $(".logo").hide();
                $(".logo-single").fadeIn()
                $(".left-menu-text").hide();
            })
            $(".embed-responsive").animate({"width":W-108+"px"},400);
            $(".second-menu").animate({
                "left":"78px"
            },400);
        } else {
            $(".left-menu-ul>li").animate({
                "width": "160px"
            })
            $(".logo-single").hide()
            $(".logo").fadeIn()
            $(".navbar-brand").animate({
                "width": "160px"
            }, 400, function () {
                _this.attr("class", "slide stretch")
                $(".left-menu-text").show();

            })
            $(".embed-responsive").animate({"width":W-190+"px"},400);
            $(".second-menu").animate({
                "left":"160px"
            },400);
        }

    })
    //鼠标移上上面导航条下拉列表
    $(".account li").mouseenter(function(){
        $(this).find(".service").show();
    })
    $(".account li").mouseleave(function(){
        $(this).find(".service").hide();
    })
    //鼠标移上左边面导航条下拉列表
    $(".left-menu-ul li").mouseenter(function(){
        $(this).find(".second-menu-left-full").show();
    })
    $(".left-menu-ul li").mouseleave(function(){
        $(this).find(".second-menu-left-full").hide();
    })

    //test
    $(".third-menu-wrap a,.third-menu-item li").mouseenter(function(){
      $(this).parent().find(".third-menu-item").show();
    })
    $(".third-menu-wrap,.third-menu-item li ").mouseleave(function(){
      $(this).parent().find(".third-menu-item").hide();
    })

    $(".four-menu-wrap a,.four-menu-item li").mouseenter(function(){
        $(this).parent().find(".four-menu-item").show();
    })
    $(".four-menu-wrap,.four-menu-item li ").mouseleave(function(){
        $(this).parent().find(".four-menu-item").hide();
    })
    //
//    $(".third-menu-item li").mouseenter(function(){
//      $(this).find(".third-menu-item").show();
//    })
//    $(".third-menu-item li").mouseleave(function(){
//      $(this).find(".third-menu-item").hide();
//    })
    //消息窗口
    layui.use('element', function(){
      var $ = layui.jquery
      ,element = layui.element(); //Tab的切换功能，切换事件监听等，需要依赖element模块
      
      //触发事件
      var active = {
        
        tabChange: function(){
          //切换到指定Tab项
          element.tabChange('demo', '22'); //切换到：用户管理
        }
      };
    });
    //消息窗口显示
    $(".information").click(function(){
        $(".task_window").slideToggle();
    })

    //页面全屏显示
    function fullScreen() {
        var el = document.documentElement;
        var rfs = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullScreen;
        if (typeof rfs != "undefined" && rfs) {
            rfs.call(el);
        } else if (typeof window.ActiveXObject != "undefined") {
        // for Internet Explorer
            var wscript = new ActiveXObject("WScript.Shell");
            if (wscript != null) {
                wscript.SendKeys("{F11}");
            }
        }
    }
    function exit_full_screen(){
        if (document.exitFullscreen) {
            document.exitFullscreen();
        }
        else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        }
        else if (document.webkitCancelFullScreen) {
            document.webkitCancelFullScreen();
        }
        else if (document.msExitFullscreen) {
            document.msExitFullscreen();
        }
    }
</script>
</body>
</html>

