<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<link rel="stylesheet" href="${ctx }/plugins/bootstrap-3.3.5-dist/css/bootstrap.min.css"/>
<link rel="stylesheet" href="${ctx }/css/table_input.css"/>
<link rel="stylesheet" href="${ctx }/css/commons.css"/>
<link rel="stylesheet" href="${ctx }/plugins/layui/css/layui.css"/>
<link rel="stylesheet" href="${ctx }/css/basis_info.css"/>
<link rel="stylesheet" href="${ctx }/plugins/jQueryValidationEngine-2.6.2/validationEngine.jquery.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">



<%-- <script src="${ctx }/js/jquery.min.js"></script> --%>
<script src="${ctx }/plugins/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
<script src="${ctx }/js/commons.js"></script>
<script src="${ctx }/plugins/layui/layui.js"></script>
<script src="${ctx }/js/layer/layer.js"></script>
<script src="${ctx }/laydate/laydate.js"></script>
<script src="${ctx }/plugins/jQueryValidationEngine-2.6.2/jquery.validationEngine.js"></script>
<script src="${ctx }/plugins/jQueryValidationEngine-2.6.2/jquery.validationEngine-zh_CN.js"></script>

<script src="${ctx }/js/checkBox.js"></script>
<script src="${ctx }/plugins/laypage/laypage.js"></script>
<script src="${ctx }/plugins/bootstrap-3.3.5-dist/js/bootstrap-select.js"></script>

<script src="${ctx }/js/app.js"></script>
<script src="${ctx }/js/nprogress.js"></script>
