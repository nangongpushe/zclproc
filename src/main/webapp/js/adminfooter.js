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