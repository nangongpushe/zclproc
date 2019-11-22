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
                        <tr><td colspan="17" class="title">库存包装物出入库明细表</td></tr>
                        <tr></tr>
                        <tr><td colspan="9">填报单位：${userInfo.company}</td><td colspan="6" style='mso-number-format:"\@"'>${reportMain.reportMonth}</td><td colspan="2">单位：条</td></tr>
                    </TABLE>
                </td>
            </tr>
            <tr>
                <td>
                    <TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01" sheetName="2">
                        <tr>
                            <td class="td_white" colspan="16">
                                <TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
                                    <thead>
                                        <tr>
                                            <th rowspan="2" class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;">日期</th>
                                            <th colspan="4" class="text-center">上期库存</th>
                                            <th colspan="4" class="text-center">收入</th>
                                            <th colspan="4" class="text-center">支出</th>
                                            <th colspan="4" class="text-center">结余库存</th>
                                            <th rowspan="2" class="text-center">备注</th>
                                        </tr>
                                        <tr>
                                            <th class="text-center">标新</th>
                                            <th class="text-center">标旧</th>
                                            <th class="text-center">杂袋</th>
                                            <th class="text-center">废袋</th>
                                            <th class="text-center">标新</th>
                                            <th class="text-center">标旧</th>
                                            <th class="text-center">杂袋</th>
                                            <th class="text-center">废袋</th>
                                            <th class="text-center">标新</th>
                                            <th class="text-center">标旧</th>
                                            <th class="text-center">杂袋</th>
                                            <th class="text-center">废袋</th>
                                            <th class="text-center">标新</th>
                                            <th class="text-center">标旧</th>
                                            <th class="text-center">杂袋</th>
                                            <th class="text-center">废袋</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${bzwcrmxList}" var="bzwcrmx">
                                            <tr class="text-center active">
                                                <td>${bzwcrmx.detailDate}</td><td>${bzwcrmx.priorNew}</td>
                                                <td>${bzwcrmx.priorOld}</td><td>${bzwcrmx.priorMixed}</td>
                                                <td>${bzwcrmx.priorWaste}</td><td>${bzwcrmx.incomeNew}</td>
                                                <td>${bzwcrmx.incomeOld}</td><td>${bzwcrmx.incomeMixed}</td>
                                                <td>${bzwcrmx.incomeWaste}</td><td>${bzwcrmx.expendNew}</td>
                                                <td>${bzwcrmx.expendOld}</td><td>${bzwcrmx.expendMixed}</td>
                                                <td>${bzwcrmx.expendWaste}</td><td>${bzwcrmx.balanceNew}</td>
                                                <td>${bzwcrmx.balanceOld}</td><td>${bzwcrmx.balanceMixed}</td>
                                                <td>${bzwcrmx.balanceWaste}</td><td>${bzwcrmx.remark}</td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td>备注</td>
                                            <td colspan="16" align="left">${reportMain.comments}</td>
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
                        <tr><td colspan="9">统计负责人：${reportMain.manager}</td><td colspan="6">填表人：${userInfo.name}</td><td colspan="2">填报日期：<fmt:formatDate value="${ reportMain.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
                    </TABLE>
                </td>
            </tr>
        </TABLE>
    </BODY>
</HTML>

