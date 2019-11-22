<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<HTML>
    <head>
        <meta http-equiv="Content-Type"
              content="application/ms-excel; charset=utf-8"/>
        <style>
            #content td,th{
            text-align:center;
            }
            .title{
            font-size:42px;
            text-align:center;
            }
        </style>
    </head>
    <BODY class="body_MarginLR10px" style="margin-right:0px;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" sheetName="4">

        </table>
    </BODY>

    <BODY class="body_MarginLR10px" style="margin-right:0px;">
        <TABLE width="100%" align="center" sheetName="5">
            <tr>
                <td>
                    <TABLE width="100%" align="center" sheetName="1">
                        <tr><td colspan="6" class="title">提货单</td></tr>
                        <tr></tr>
                        <tr><td colspan="6">${storeEnterprise.enterpriseName }:</td></tr>
                        <tr><td colspan="6">&nbsp;&nbsp;&nbsp;&nbsp;请发给${title}仓库汽车板交货，
                            其他费用按照《买卖合同》和《浙江省省级储备粮网上公开竞价销售规则》等有关规定执行。</td></tr>
                    </TABLE>
                </td>
            </tr>
            <tr>
                <td>
                    <TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01" sheetName="2">
                        <tr>
                            <td class="td_white" colspan="6">
                                <TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
                                    <thead>
                                        <tr >
                                            <th class="text-center">仓号</th><th class="text-center">品种</th><th class="text-center">合同数量</th>
                                            <th class="text-center">已开提货单</th><th class="text-center">本次发货</th><th class="text-center">累计已开提货单</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                            <c:forEach items="${take.rotateTakes }" var="item">
                                            <tr class="text-center active">
                                                <td>${item.storeEncode}</td>
                                                <td>${item.variety }</td>
                                                <td>${item.contract }</td>
                                                <td>${item.ladingBills }</td>
                                                <td>${item.thisShipment }</td>
                                                <td>${item.accumulatedBills }</td>
                                            </tr>
                                            </c:forEach>
                                            <tr class="text-center active">
                                                <td colspan="3">承储单位联系方式：${take.enterpriseTel}</td>
                                                <td colspan="3">公司业务部联系方式：85773087</td>
                                            </tr>
                                    </tbody>
                                </TABLE>
                            </td>
                        </tr>
                    </TABLE>
                </td>
            </tr>
            <tr>
                <td>
                    <TABLE width="100%" align="center" sheetName="3">
                        <tr><td colspan="6">注：本单一式三联，第一联公司存档，第二联交货单位记账，第三联提货凭证。竞价销售公告、
                            标的物明细表、规则、合同等资料请从www.zjlyjy.com上下载。</td></tr>
                        <tr><td colspan="6" style="text-align:right;">浙江省储备粮管理有限公司</td></tr>
                        <tr><td colspan="6" style="text-align:right;margin-right:92px;">业务部&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
                        <tr><td colspan="6" style="text-align:right;margin-right:72px;"><fmt:formatDate value="${take.completeDate}" pattern="yyyy年MM月dd日" />&nbsp;&nbsp;</td></tr>
                    </TABLE>
                </td>
            </tr>
        </TABLE>
    </BODY>
</HTML>

