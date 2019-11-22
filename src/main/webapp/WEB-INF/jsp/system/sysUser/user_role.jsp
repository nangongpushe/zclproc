<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link rel="StyleSheet" type="text/css" href="${ctx }/plugins/zTree_v3/css/metroStyle/metroStyle.css"/>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.exedit.js"></script>

<!-- Modal TREE -->
<div class="modal fade" id="myMenuTree" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
    
    <form action="${ctx }/sysUser/saveUserRole.shtml" method="post">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"></h4>
      </div>
      <div class="modal-body">
      	<input type="text" name="userId" id="userId" hidden>
		<div id="resText"></div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="layui-btn layui-btn-small">确认</button>
        <button class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal">取消</button>
      </div>
     </form>
      
    </div>
  </div>
</div>

<script>

</script>