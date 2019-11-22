<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!-- 左侧导航栏 -->
<nav class="navbar-default navbar-side" role="navigation" id="left-nav">
    <div class="sidebar-collapse">
        <ul class="nav" id="main-menu">
            <!-- 单个菜单项 -->
            <!-- 			<li><a class="" href="index.html"><i
                                class="fa fa-dashboard"></i> 测试</a></li> -->
            <!-- 多菜单 -->
            <!-- 报表 3层-->
            <shiro:hasPermission name="report">
                <li><a href="javascript:void(0);"><i class="fa fa-sitemap"></i> 报表台账<span
                        class="fa arrow"></span> </a>
                    <ul class="nav nav-second-level">
                        <li><a href="javascript:void(0);">填报管理<span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level">
                                <shiro:hasPermission name="/reportMonth/proxyFillMainList.shtml">
                                    <li><a href="${ctx}/reportMonth/proxyFillMainList.shtml" target="myFrameName">[代储]报表填报</a>
                                    </li>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/reportMonth/fillMain.shtml">
                                    <li><a href="${ctx}/reportMonth/fillMain.shtml" target="myFrameName">填报</a></li>
                                </shiro:hasPermission>
                                    <%--<shiro:hasPermission name="/reportMonth/appMain.shtml"><li><a href="${ctx}/reportMonth/appMain.shtml" target="myFrameName">审核</a></li></shiro:hasPermission>--%>
                                <shiro:hasPermission name="/reportMonth/queryMain.shtml">
                                    <li><a href="${ctx}/reportMonth/queryMain.shtml" target="myFrameName">查询</a></li>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/yearReport.shtml">
                                    <li><a href="${ctx}/yearReport.shtml" target="myFrameName">年报填报</a></li>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/reportMonth/appKuMain.shtml">
                                    <li><a href="${ctx}/reportMonth/appKuMain.shtml" target="myFrameName">分库审核</a></li>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/reportMonth/queryKuMain.shtml">
                                    <li><a href="${ctx}/reportMonth/queryKuMain.shtml" target="myFrameName">分库查询</a>
                                    </li>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/reportMonth/appSumMain.shtml">
                                    <li><a href="${ctx}/reportMonth/appSumMain.shtml" target="myFrameName">汇总审核</a></li>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/reportMonth/querySumMain.shtml">
                                    <li><a href="${ctx}/reportMonth/querySumMain.shtml" target="myFrameName">汇总查询</a>
                                    </li>
                                </shiro:hasPermission>
                            </ul>
                        </li>
                        <shiro:hasPermission name="statistics">
                            <li><a href="javascript:void(0);">统计分析<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/kccx.shtml">
                                        <li><a href="${ctx}/kccx.shtml" target="myFrameName">库存查询</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/charts/kctj.shtml">
                                        <li><a href="${ctx}/charts/inventoryStatisticsPieChart.shtml"
                                               target="myFrameName">库存汇总统计</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/charts/kctj.shtml">
                                        <li><a href="${ctx}/charts/kctj.shtml" target="myFrameName">库存分布统计</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/charts/ltlx.shtml">
                                        <li><a href="${ctx}/charts/ltlx.shtml" target="myFrameName">流通流向</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/charts/personInfoIndex.shtml">
                                        <li><a href="${ctx}/charts/personInfoIndex.shtml" target="myFrameName">人员统计</a>
                                        </li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                    </ul>
                </li>
            </shiro:hasPermission>
            <!-- 轮换 4层-->
            <shiro:hasPermission name="rotate">
                <li><a href="javascript:void(0);"><i class="fa fa-sitemap"></i> 轮换业务<span
                        class="fa arrow"></span> </a>
                    <ul class="nav nav-second-level">
                        <shiro:hasPermission name="rotate.planmain">
                            <li><a href="javascript:void(0);">轮换计划<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/rotatePlan/declare.shtml">
                                        <li><a href="${ctx}/rotatePlan/declare.shtml" target="myFrameName">计划申报</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="rotate.plan">
                            <li><a href="javascript:void(0);">轮换计划详情<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/rotatePlan/main.shtml">
                                        <li><a href="${ctx}/rotatePlan/main.shtml" target="myFrameName">计划详情</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotatePlan/main2.shtml">
                                        <li><a href="${ctx}/rotatePlan/main2.shtml" target="myFrameName">计划清单</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="rotate.scheme">
                            <li><a href="javascript:void(0);">轮换方案<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="RotateScheme/List.shtml?view=create&type=ProviceUnit">
                                        <li><a href="${ctx}/RotateScheme/List.shtml?view=create&type=ProviceUnit"
                                               target="myFrameName">创建方案</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="RotateScheme/List.shtml?view=&type=ProviceUnit">
                                        <li><a href="${ctx}/RotateScheme/List.shtml?view=&type=ProviceUnit"
                                               target="myFrameName">方案列表</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="RotateScheme/detailList.shtml">
                                        <li><a href="${ctx}/RotateScheme/detailList.shtml"
                                               target="myFrameName">子方案列表</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="rotate.bid">
                            <li><a href="javascript:void(0);">竞标管理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/rotateBID/main.shtml">
                                        <li><a href="${ctx}/rotateBID/main.shtml" target="myFrameName">标的物明细</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateInvite/main.shtml">
                                        <li><a href="${ctx}/rotateInvite/main.shtml" target="myFrameName">招标结果管理</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateConclute/main.shtml">
                                        <li><a href="${ctx}/rotateConclute/main.shtml" target="myFrameName">成交结果明细</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateRefund/main.shtml">
                                        <li><a href="${ctx}/rotateRefund/main.shtml" target="myFrameName">保证金退还</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateTransaction/main.shtml">
                                        <li><a href="${ctx}/rotateTransaction/main.shtml" target="myFrameName">交易明细</a>
                                        </li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="rotate.notice">
                            <li><a href="javascript:void(0);">通知书管理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="RotateNotif/Out.shtml?type=Warehouse">
                                        <li><a href="${ctx}/RotateNotif/Out.shtml?type=Warehouse" target="myFrameName">出库通知书</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="RotateNotif/In.shtml?type=Warehouse">
                                        <li><a href="${ctx}/RotateNotif/In.shtml?type=Warehouse" target="myFrameName">入库通知书</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="RotateNotif/Move.shtml?type=Warehouse">
                                        <li><a href="${ctx}/RotateNotif/Move.shtml?type=Warehouse" target="myFrameName">移库通知书</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="RotateNotif/Take.shtml?type=Warehouse">
                                        <li><a href="${ctx }/RotateNotif/Take.shtml?type=Warehouse" target="myFrameName">提货单</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="RotateNotif/TakeTotal.shtml">
                                        <li><a href="${ctx}/RotateNotif/TakeTotal.shtml" target="myFrameName">提货单汇总</a>
                                        </li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="rotate.hkgl">
                            <li><a href="javascript:void(0);">货款管理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/rotateArrive/main.shtml">
                                        <li><a href="${ctx}/rotateArrive/main.shtml" target="myFrameName">货款到账单</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateClaim/main.shtml">
                                        <li><a href="${ctx}/rotateClaim/main.shtml" target="myFrameName">货款认领单</a></li>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="/rotateSum/main.shtml">
                                        <li><a href="${ctx}/rotateSum/main.shtml" target="myFrameName">货款汇总</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="rotate.schedule">
                            <li><a href="javascript:void(0);">执行进度<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/rotateSchedule/main.shtml">
                                        <li><a href="${ctx}/rotateSchedule/main.shtml" target="myFrameName">[库]进度上报</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateSchedule/main2.shtml">
                                        <li><a href="${ctx}/rotateSchedule/main2.shtml"
                                               target="myFrameName">[公司]进度查询</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateSchedule/gather_main.shtml">
                                        <li><a href="${ctx}/rotateSchedule/gather_main.shtml" target="myFrameName">[公司]进度汇总</a>
                                        </li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="rotate.sw">
                            <li><a href="javascript:void(0);">商务处理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="RotateProcess/Recording.shtml?type=Total">
                                        <li><a href="${ctx}/RotateProcess/Recording.shtml?type=Total"
                                               target="myFrameName">[公司]商务处理记录</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotatePayment/main.shtml">
                                        <li><a href="${ctx}/rotatePayment/main.shtml"
                                               target="myFrameName">[公司]货款支付审批</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="RotateProcess/Performance.shtml?type=Total">
                                        <li><a href="${ctx}/RotateProcess/Performance.shtml?type=Total"
                                               target="myFrameName">合同履约管理</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="rotate.yf">
                            <li><a href="javascript:void(0);">运费管理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/freightDef.shtml">
                                        <li><a href="${ctx}/freightDef.shtml" target="myFrameName">运费定义</a>
                                        </li>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="/rotateFreight/main.shtml">
                                        <li><a href="${ctx}/rotateFreight/main.shtml" target="myFrameName">运费采购方案</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateFreight/main.shtml?view_type=invite">
                                        <li><a href="${ctx}/rotateFreight/main.shtml?view_type=invite"
                                               target="myFrameName">运费成交结果</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateFreightAPRV/main.shtml">
                                        <li><a href="${ctx}/rotateFreightAPRV/main.shtml"
                                               target="myFrameName">运费审批管理</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateFreightAPRV/agent_main.shtml">
                                        <li>
                                            <a href="${ctx}/rotateFreightAPRV/agent_main.shtml" target="myFrameName">[代储]运费审批管理</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/rotateFreightAPRV/gather_main.shtml">
                                        <li><a href="${ctx}/rotateFreightAPRV/gather_main.shtml" target="myFrameName">运费审批汇总</a>
                                        </li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                    </ul>
                </li>
            </shiro:hasPermission>

            <!-- 中转 -->
            <shiro:hasPermission name="transfer">
                <li>
                    <a href="javascript:void(0);"> <i class="fa fa-sitemap"></i> 中转业务 <span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <shiro:hasPermission name="/Transfer.shtml">
                            <li><a href="${ctx}/Transfer.shtml" target="myFrameName">中转业务记录</a></li>
                        </shiro:hasPermission>
                    </ul>
                </li>
            </shiro:hasPermission>

            <!-- 基建 -->
            <shiro:hasPermission name="construction">
                <li><a href="javascript:void(0);"><i class="fa fa-sitemap"></i> 基建管理<span class="fa arrow"></span> </a>
                    <ul class="nav nav-second-level">
                        <shiro:hasPermission name="Construction/Add/View.shtml">
                            <li><a href="${ctx}/Construction/Add/View.shtml" target="myFrameName">新增项目</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Manage/View.shtml">
                            <li><a href="${ctx}/Construction/Manage/View.shtml" target="myFrameName">管理项目</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Plan/View.shtml">
                            <li><a href="${ctx}/Construction/Plan/View.shtml" target="myFrameName">年度计划</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Plan/View/Collage.shtml">
                            <li><a href="${ctx}/Construction/Plan/View/Collage.shtml" target="myFrameName">年度计划(汇总)</a>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Bidding/View.shtml">
                            <li><a href="${ctx}/Construction/Bidding/View.shtml" target="myFrameName">招投标</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Change/View.shtml">
                            <li><a href="${ctx}/Construction/Change/View.shtml" target="myFrameName">项目变更</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Schedule/View.shtml">
                            <li><a href="${ctx}/Construction/Schedule/View.shtml" target="myFrameName">工程进度</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Schedule/View/Collect.shtml">
                            <li><a href="${ctx}/Construction/Schedule/View/Collect.shtml"
                                   target="myFrameName">工程进度(汇总)</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Schedule/View/Collect.shtml?needreported=true">
                            <li><a href="${ctx}/Construction/Schedule/View/Collect.shtml?needreported=true"
                                   target="myFrameName">工程进度(汇总)</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Acceptance/View.shtml">
                            <li><a href="${ctx}/Construction/Acceptance/View.shtml" target="myFrameName">工程验收</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Balance/View.shtml">
                            <li><a href="${ctx}/Construction/Balance/View.shtml" target="myFrameName">工程结算</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Funds/View.shtml">
                            <li><a href="${ctx}/Construction/Funds/View.shtml" target="myFrameName">工程拨款</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="Construction/Info/View.shtml">
                            <li><a href="${ctx}/Construction/Info/View.shtml" target="myFrameName">工程资料</a></li>
                        </shiro:hasPermission>
                    </ul>
                </li>
            </shiro:hasPermission>

            <!-- 客户 -->
            <shiro:hasPermission name="client">
                <li><a href="javascript:void(0);"><i class="fa fa-sitemap"></i> 客户管理<span class="fa arrow"></span> </a>
                    <ul class="nav nav-second-level">
                        <shiro:hasPermission name="/CustomerInformation.shtml">
                            <li><a href="${ctx}/CustomerInformation.shtml" target="myFrameName">客户信息</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/CustomerInformation/listEcharts.shtml">
                            <li><a href="${ctx}/CustomerInformation/listEcharts.shtml" target="myFrameName">统计分析</a>
                            </li>
                        </shiro:hasPermission>
                    </ul>
                </li>
            </shiro:hasPermission>

            <!-- 代储监管 -->
            <shiro:hasPermission name="store">
                <li><a href="javascript:void(0);"><i class="fa fa-sitemap"></i> 代储监管<span class="fa arrow"></span> </a>
                    <ul class="nav nav-second-level">
                        <shiro:hasPermission name="/StoreSupervise.shtml">
                            <li><a href="${ctx }/StoreSupervise.shtml" target="myFrameName">分片监管</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="store.company">
                            <li><a href="javascript:void(0);">企业信息<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/StoreEnterprise.shtml">
                                        <li><a href="${ctx}/StoreEnterprise.shtml" target="myFrameName">企业基本信息</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/storageWarehouse.shtml?type=dc">
                                        <li><a href="${ctx }/storageWarehouse.shtml?type=dc"
                                               target="myFrameName">库点管理</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/storageStoreHouse.shtml?flag=dc">
                                        <li><a href="${ctx }/storageStoreHouse.shtml?flag=dc"
                                               target="myFrameName">仓房管理</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/storageStoreHouse.shtml?flag=dc">
                                        <li><a href="${ctx }/storageStoreHouse/proxyStorageStoreHouse.shtml"
                                               target="myFrameName">[代储]仓房管理</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/storageStoreHouse/addBatchStorageStoreHouse.shtml">
                                        <li><a href="${ctx }/storageStoreHouse/addBatchStorageStoreHouse.shtml"
                                               target="myFrameName">仓房批量新增</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="store.business">
                            <li><a href="javascript:void(0);">业务信息<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/StoreExamineAgent.shtml">
                                        <li><a href="${ctx}/StoreExamineAgent.shtml" target="myFrameName">考核评分</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StoreFeedBackAgent.shtml">
                                        <li><a href="${ctx}/StoreFeedBackAgent.shtml" target="myFrameName">问题反馈</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StoreWinUnit.shtml">
                                        <li><a href="${ctx}/StoreWinUnit.shtml" target="myFrameName">优胜单位申报</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StoreTemplate.shtml">
                                        <li><a href="${ctx}/StoreTemplate.shtml" target="myFrameName">考评模板表</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="store.report">
                            <li><a href="javascript:void(0);">报表台账<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                        <%--<shiro:hasPermission name="/reportMonth/proxyFillMainList.shtml"><li><a  href="${ctx}/reportMonth/proxyFillMainList.shtml" target="myFrameName">[代储]报表填报</a></li></shiro:hasPermission>--%>
                                    <shiro:hasPermission name="/reportMonth/proxyFillMain.shtml?type=swtz">
                                        <li><a href="${ctx}/reportMonth/proxyFillMain.shtml?type=swtz"
                                               target="myFrameName">库存实物台账</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/reportMonth/proxyFillMain.shtml?type=cbly">
                                        <li><a href="${ctx}/reportMonth/proxyFillMain.shtml?type=cbly"
                                               target="myFrameName">省级储备粮油收支平衡月报表</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/reportMonth/proxyFillMain.shtml?type=sply">
                                        <li><a href="${ctx}/reportMonth/proxyFillMain.shtml?type=sply"
                                               target="myFrameName">企业商品粮油收支平衡月报表</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/storageGrainInspection.shtml?type=dc">
                                        <li><a href="${ctx}/storageGrainInspection.shtml?type=dc" target="myFrameName">粮情检测记录</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/QualityResult.shtml?type=dc">
                                        <li><a href="${ctx}/QualityResult.shtml?type=dc" target="myFrameName">质量检测报告</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/reportMonth/proxyFillMain.shtml?type=xwsw">
                                        <li><a href="${ctx}/reportMonth/proxyFillMain.shtml?type=xwsw"
                                               target="myFrameName">粮食和食用油脂油料销往外省月报表</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/reportMonth/proxyFillMain.shtml?type=swgj">
                                        <li><a href="${ctx}/reportMonth/proxyFillMain.shtml?type=swgj"
                                               target="myFrameName">粮食和食用油脂油料外省购进月报表</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                    </ul>
                </li>
            </shiro:hasPermission>

            <!-- 物资管理-->
            <shiro:hasPermission name="material">
                <li><a href="javascript:void(0);"><i class="fa fa-sitemap"></i> 物资管理<span class="fa arrow"></span> </a>
                    <ul class="nav nav-second-level">
                        <shiro:hasPermission name="/MaterialPurchase.shtml">
                            <li><a href="${ctx}/MaterialPurchase.shtml" target="myFrameName">采购管理</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="material.kc">
                            <li><a href="javascript:void(0);">库存管理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/Consumables.shtml">
                                        <li><a href="${ctx}/Consumables.shtml" target="myFrameName">易耗品入库</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/Durables.shtml">
                                        <li><a href="${ctx}/Durables.shtml" target="myFrameName">设备入库</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/DurablesMaintain.shtml">
                            <li><a href="${ctx}/DurablesMaintain.shtml" target="myFrameName">维修管理</a></li>
                        </shiro:hasPermission>
                    </ul>
                </li>
            </shiro:hasPermission>

            <!-- 质量管理-->
            <shiro:hasPermission name="quality">
                <li><a href="javascript:void(0);"><i class="fa fa-sitemap"></i> 质量管理<span class="fa arrow"></span> </a>
                    <ul class="nav nav-second-level">
                        <shiro:hasPermission name="quality.task">
                            <li><a href="javascript:void(0);">检验任务<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/QualitySample.shtml">
                                        <li><a href="${ctx}/QualitySample.shtml" target="myFrameName">样品信息</a></li>
                                    </shiro:hasPermission>
                                        <%--<shiro:hasPermission name="/QualityTask.shtml"><li><a  href="${ctx}/QualityTask.shtml" target="myFrameName">检验任务</a></li></shiro:hasPermission>--%>
                                    <shiro:hasPermission name="/QualityResult.shtml">
                                        <li><a href="${ctx}/QualityResult.shtml" target="myFrameName">检验结果</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/QualityThird.shtml">
                                        <li><a href="${ctx}/QualityThird.shtml" target="myFrameName">第三方质检记录</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="QualityFile">
                            <li><a href="javascript:void(0);">质量档案<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/QualityFileInfo.shtml">
                                    <li><a href="${ctx}/QualityFileInfo.shtml" target="myFrameName">质量档案信息</a></li>
                                </shiro:hasPermission>
                                    <shiro:hasPermission name="/QualityTemplet.shtml">
                                        <li><a href="${ctx}/QualityTemplet.shtml" target="myFrameName">粮油模板</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/QualityQuota.shtml">
                                        <li><a href="${ctx}/QualityQuota.shtml" target="myFrameName">等级指标管理</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>

                        <shiro:hasPermission name="/QualityResult/QualityResultFile.shtml">
                            <li><a href="${ctx}/QualityResult/QualityResultFile.shtml" target="myFrameName">质检数据导入</a></li>
                        </shiro:hasPermission>


                    </ul>
                </li>
            </shiro:hasPermission>

            <!-- 仓储管理-->
            <shiro:hasPermission name="storage">
                <li><a href="javascript:void(0);"><i class="fa fa-sitemap"></i> 仓储管理<span class="fa arrow"></span> </a>
                    <ul class="nav nav-second-level">
                        <shiro:hasPermission name="/storageWarehouse.shtml?type=cc">
                            <li><a href="${ctx }/storageWarehouse.shtml?type=cc" target="myFrameName">库点管理</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="storage.warehouse">
                            <li><a href="javascript:void(0);">仓房管理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/storageStoreHouse.shtml?flag=cc">
                                        <li><a href="${ctx }/storageStoreHouse.shtml?flag=cc" target="myFrameName">仓房信息管理</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/storageOilcan.shtml">
                                        <li><a href="${ctx }/storageOilcan.shtml" target="myFrameName">油罐信息管理</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="storage.check">
                            <li><a href="javascript:void(0);">粮油情检测管理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">

                                    <shiro:hasPermission name="/storageGrainInspection.shtml">
                                        <li><a href="${ctx }/storageGrainInspection.shtml"
                                               target="myFrameName">粮情检测记录</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/storageGrainInspection/grainInspection.shtml">
                                        <li><a href="${ctx}/storageGrainInspection/grainInspection.shtml"
                                               target="myFrameName">粮情检测记录统计</a></li>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="/storageGrainInspection/threeTempChart.shtml">
                                        <li><a href="${ctx }/storageGrainInspection/threeTempChart.shtml"
                                               target="myFrameName">粮情三温图</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StorageMachineAir/main.shtml">
                                        <li><a href="${ctx }/StorageMachineAir/main.shtml"
                                               target="myFrameName">机械通风记录</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StorageFumigate/main.shtml">
                                        <li><a href="${ctx }/StorageFumigate/main.shtml" target="myFrameName">熏蒸记录</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StoragePhosphine/main.shtml">
                                        <li><a href="${ctx }/StoragePhosphine/main.shtml"
                                               target="myFrameName">磷化氢检测记录</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StorageGaslog/view.shtml">
                                        <li><a href="${ctx }/StorageGaslog/view.shtml" target="myFrameName">氮气浓度检测记录</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StorageCooling/main.shtml">
                                        <li><a href="${ctx }/StorageCooling/main.shtml" target="myFrameName">谷物冷却记录</a>
                                        </li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/ngasOperaRecord.shtml">
                                        <li><a href="${ctx }/ngasOperaRecord.shtml"
                                               target="myFrameName">充氮气调作业记录</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="storage.star">
                            <li><a href="javascript:void(0);">粮库管理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <shiro:hasPermission name="/StorageStarUnit.shtml">
                                        <li><a href="${ctx}/StorageStarUnit.shtml" target="myFrameName">星级粮库申报</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StorageFourUnit.shtml">
                                        <li><a href="${ctx}/StorageFourUnit.shtml" target="myFrameName">四化粮库申报</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StoreExamine.shtml">
                                        <li><a href="${ctx}/StoreExamine.shtml" target="myFrameName">考核评分管理</a></li>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/StoreFeedBack.shtml">
                                        <li><a href="${ctx}/StoreFeedBack.shtml" target="myFrameName">问题反馈表管理</a></li>
                                    </shiro:hasPermission>
                                </ul>
                            </li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/StorageInspect.shtml">
                            <li><a href="${ctx}/StorageInspect.shtml" target="myFrameName">全国查库</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/StorageEnergy.shtml">
                            <li><a href="${ctx}/StorageEnergy.shtml" target="myFrameName">能耗管理</a></li>
                        </shiro:hasPermission>
                    </ul>
                </li>
            </shiro:hasPermission>

            <!-- 系统设置 -->
            <shiro:hasPermission name="system">
                <li><a href="javascript:void(0);"><i class="fa fa-sitemap"></i> 系统管理<span class="fa arrow"></span> </a>
                    <ul class="nav nav-second-level">
                        <shiro:hasPermission name="/sysUser.shtml">
                            <li><a href="${ctx}/sysUser.shtml" target="myFrameName">用户管理</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/sysRole.shtml">
                            <li><a href="${ctx}/sysRole.shtml" target="myFrameName">角色管理</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/sysPermission.shtml">
                            <li><a href="${ctx}/sysPermission.shtml" target="myFrameName">权限菜单管理</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/sysDict.shtml">
                            <li><a href="${ctx}/sysDict.shtml" target="myFrameName">数据字典</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/sysLog.shtml">
                            <li><a href="${ctx}/sysLog.shtml" target="myFrameName">系统日志</a></li>
                        </shiro:hasPermission>
                    </ul>
                </li>
            </shiro:hasPermission>
        </ul>
    </div>
</nav>

