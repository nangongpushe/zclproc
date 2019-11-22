<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader_Main.jsp"%>


	<div class="pageloader iframe_box" >
		<iframe <%-- src="${ctx }/Home/welcome.shtml" --%> class="embed-responsive-item myFrame" name="myFrameName" id="childFrame" scrolling="auto" src="" style="height:100%!important"></iframe>
	</div>

<script>
	//debugger;
	var W = (document.documentElement.clientWidth || document.body.clientWidth),
	H = (document.documentElement.clientHeight || document.body.clientHeight);
/* 	console.log(W+ " "+ H); */
	window.onresize = function() {
		//debugger;
		W = (document.documentElement.clientWidth || document.body.clientWidth),
		H = (document.documentElement.clientHeight || document.body.clientHeight) ;
		/* console.log(W+ " "+ H); */
		$(".embed-responsive").css({
			"min-width" : W-260,
			"height" :H-60,
// 			"min-height":H-59,
// 			"max-height":H-59
		});
		$("#left-nav").css({
			"height":H-60
		});
	};
	$(".embed-responsive").css({
		"min-width" : W-260,
		"height" :H-60,
// 		"max-height":H-59,
// 		"min-height":H-59
	});
	$("#left-nav").css({
		"height":H-60
	});

	// 	$("#page-contont").height($(window).height() - $(".top-nav").innerHeight());
	// 	$("#page-contont").attr("min-heigth",
	// 			$(window).height() - $(".top-nav").innerHeight());
	// 	$('#left-nav li a[data-url]').click(function(e) {
	// 		e.preventDefault();

	// 		loadPage(this);
	// 	});

	//如果使用ajax load加载局部页函数,
	//注意:如果已加载的局部页，有局部刷新并且其中按钮要跳转，需重新绑定click事件
	//(如表格异步刷新，需要对操作按钮重新绑定click事件或者使用onclick="loadPage(this)")
	// 	function loadPage(elem){
	// 		debugger;
	// 		var url = $(elem).attr('data-url');
	// 		if(!url)
	// 			url=$(elem).attr('href');
	// 		if (url && url != "#" && url != "javascript:void(0);") {
	// 			$("div.pageloader").load(url,function(){
	// 				$('#page-wrapper a').click(function(e) {
	// 					e.preventDefault();
	// 					loadPage(this);
	// 				});
	// 			});
	// 		}

	// 	}
</script>

<%@include file="../common/AdminFooter_Main.jsp"%>