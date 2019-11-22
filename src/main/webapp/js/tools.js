function detectZoom (){
    	  var ratio = 0,
    	    screen = window.screen,
    	    ua = navigator.userAgent.toLowerCase();
    	   
    	   if (window.devicePixelRatio !== undefined) {
    	      ratio = window.devicePixelRatio;
    	  }
    	  else if (~ua.indexOf('msie')) {
    	    if (screen.deviceXDPI && screen.logicalXDPI) {
    	      ratio = screen.deviceXDPI / screen.logicalXDPI;
    	    }
    	  }
    	  else if (window.outerWidth !== undefined && window.innerWidth !== undefined) {
    	    ratio = window.outerWidth / window.innerWidth;
    	  }
    	     
    	   if (ratio){
    	    ratio = Math.round(ratio * 100);
    	  }
    	     
    	   return ratio;
    	};
    	
    	$(window).on('resize',function(){
    	      isScale();
    	});
    	//判断PC端浏览器缩放比例不是100%时的情况
    	function isScale(){
    	  var rate = detectZoom();
    	  if(rate != 100){
    	    //如何让页面的缩放比例自动为100,'transform':'scale(1,1)'没有用，又无法自动条用键盘事件，目前只能提示让用户如果想使用100%的比例手动去触发按ctrl+0
    	    //console.log(1)
    		layer.msg('当前页面不是100%显示，请按键盘ctrl+0恢复100%显示标准，以防页面显示错乱！');
    	  }
    	}
    
    $(document).ready(function () {
   	  $('body').css('zoom', 'reset');
   	  $(document).keydown(function (event) {
   	    //event.metaKey mac的command键
   	    if ((event.ctrlKey === true || event.metaKey === true)&& (event.which === 61 || event.which === 107 || event.which === 173 || event.which === 109 || event.which === 187  || event.which === 189)){
   	      event.preventDefault();
   	    }
   	  });
   	  $(window).bind('mousewheel DOMMouseScroll', function (event) {
   	    if (event.ctrlKey === true || event.metaKey) {
   	       event.preventDefault();
   	    }
   	  });
   	});