<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


        </div><!-- page-wrapper -->
    </div><!-- wrapper -->

<!-- 页脚js -->

<script type="text/html" id="dateTemplate">
	  {{ parseDate(d.createTime)}}
</script>
<link href="${ctx}/js/mCustomScrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/mCustomScrollbar/jquery-ui-1.10.4.min.js"></script>
<script src="${ctx}/js/mCustomScrollbar/jquery.mousewheel.min.js"></script>
<script src="${ctx}/js/mCustomScrollbar/jquery.mCustomScrollbar.min.js"></script>
<script type='text/javascript'>
(function($){
    $(window).load(function(){
        $("#left-nav").mCustomScrollbar({
        	theme:"dark",
        	mouseWheel:{ 
        		scrollAmount: 200
        	}
        });
    });
})(jQuery);
</script>
</body>
</html>

