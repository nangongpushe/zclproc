var W = document.documentElement.clientWidth || document.body.clientWidth;//获取屏幕宽度
var H = document.documentElement.clientHeight || document.body.clientHeight;//获取屏幕高度
var admin = window.sessionStorage.getItem("admin")
$(function(){
    //下拉选项赋值给输入框
    $(".dropdown-menu a").click(function () {
        $(this).parents(".btn-select").prev().val($(this).text());
        //客户资料从事行业下拉列表
        if($(this).text()=="加工类"){
            $(".industry_sonProject").show();
        }else{
            $(".industry_sonProject").hide();
        };
    });
    $(".list-group>a").click(function(){

    });
    login();
    islogin();
});
// iframe自适应高度
function IFrameResize(){
  // location.reload();
  var obj = window.parent.document.getElementById("childFrame"); //取得父页面IFrame对象
    obj.height = this.document.body.offsetHeight; //调整父页面中IFrame的高度为此页面的高度
    console.log(obj.height);
    //console.log(this.document.body.offsetHeight);
};
//页面跳转
function RedirectUrl(url) {
    window.location.href = url;
}
//获取URL地址参数
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}
function login() {
    $("#close_mask_btn,.login_btn").click(function () {
        if($("#username").val()==""){
            $(".info").find("span").html("请输入用户名!")
        }else if($("#password").val()==""){
            $(".info").find("span").html("请输入密码!")
        }else{
            $(".mask").css({
                "display": "none"
            });
            $("body").css("overflow", "visible");
            var options=$("#admin option:selected");
            var test=options.val()
            sessionStorage.setItem("admin",test);
            sessionStorage.setItem("username", $("#username").val());
            console.log(window.sessionStorage.getItem("admin"))
            location.reload();
        }
    });
    if (admin == "1") {
        $(".ku").show();
        $(".company").hide();
    } else {
        $(".ku").hide();
        $(".company").show();
    }
};
function islogin() {
    var userName = window.sessionStorage.getItem("username");
    if (userName != null) {
        $(".login01").html("欢迎登录");
        $("#name").html(userName);
        $("#exit").show();
        $(".user_picture").find("img").attr("src","images/02.jpg")
        //$(".login01").onclick = null;
    }else{
        $(".login01").html("点此登录");
        $(".login01").click(function(){
            $(".mask").show()
        })
        $("#exit").hide();
        $(".user_picture").find("img").attr("src","images/03.jpg")
    };
    $("#exit").click(function () {
        if($("#login").html()!="点此登录") {
            sessionStorage.removeItem("username");
            $(".login01").html("点此登录");
            $("#name").html("");
            $("#exit").hide();
        };
        location.reload();
    });
}

function saveForm(formId, serviceUrl, fnCallback) {
	layer.load(2);
	if (!$('#' + formId).validationEngine("validate")){
		layer.closeAll('loading');
		return false;
	}
	$.ajax({
        type: "POST",
        url:serviceUrl,
        data:$('#' + formId).serialize(),
        error: function(request) {
        	layer.closeAll('loading');
			//layer.alert("保存失败，请与管理员联系！");
			if(request.responseText){
				layer.open({
					type: 1,
					area: ['700px', '430px'],
					fix: false,
					content: request.responseText
				});
			}
        },
        success: function(data) {
        	layer.closeAll('loading');
			if (!data.success) {
				layer.alert('保存失败!' + data.msg, {icon:2});
				return;
			} else {
				layer.msg('提交成功',{time:1000,icon:1},function(){
					if (typeof (fnCallback) != "undefined")
						fnCallback(data);
				});
			}
        }
    });
}

function removeRecord(url, pks, fnCallback, isConfirm) {
	if (pks.length < 1) {
		layer.msg("请选择需要删除的记录");
		return;
	}

	if (typeof (isConfirm) == "undefined") {
		isConfirm = true;
	}
	if(isConfirm){
		layer.confirm('确实要删除吗？', {
			btn: ['确定','取消'] //按钮
		}, function(index){
			layer.load(2);
			$.ajax({
				"dataType" : "json",
				"type" : "POST",
				"url" : url,
				"data" : {
					"pks" : pks
				},
				"success" : function(data) {
					layer.closeAll('loading');
					layer.close(index);
					if (data.success) {
						layer.msg('删除成功',{time:1000,icon:1},function(){
							if (typeof (fnCallback) != "undefined")
								fnCallback(data);
						});
					} else {
						layer.alert("删除失败，原因：" + data.msg, {icon:2})
					}
				},
				"error" : function(XMLHttpRequest, textStatus, errorThrown) {
					layer.closeAll('loading');
					layer.close(index);
					// layer.alert("删除失败，HTTP错误。", {icon:2});
                    if(XMLHttpRequest.responseText){
                    	layer.open({
        					type: 1,
        					area: ['700px', '430px'],
        					fix: false,
        					content: XMLHttpRequest.responseText
        				});
                    }
				}
			});
		});
	}
	
};

function layuiPage(tableId,queryUrl,queryPara,fnRender){
	 //分页显示
	  layui.use(['laypage', 'layer'], function() {
	    var laypage = layui.laypage
	      , layer = layui.layer;
	      
	    var  resetPage = function(recordCount, pageIndex) {
	        var pages = recordCount % queryPara.pageSize == 0 ? recordCount / queryPara.pageSize : recordCount / queryPara.pageSize + 1;
	        laypage({
	            cont: "demo", //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
	            pages: pages, //通过后台拿到的总页数
	            curr: pageIndex, //当前页
	            jump: function (obj, first) { //触发分页后的回调
	                if (!first) { //点击跳页触发函数自身，并传递当前页：obj.curr
	                    queryPara.page = obj.curr;
	                    pageQuery();
	                }
	            }
	        });
	    }
	   
	  var  pageQuery=function() {
	        $.post(queryUrl, queryPara, function (data) {
	        	var recordCount = data.data.count;
	        	var tbody,obj
	        	for(var i in data.data.records){
	        	obj = data.data.records[i];
	        		tbody += fnRender(obj);
	        	}
	            $("#"+tableId+" tbody").html(tbody);//这里直接可以将对象拼装，或者使用分部视图，将data作为model参数传入分部式图
	             resetPage(recordCount, queryPara.page);
	        });
	    }
	    pageQuery();
	    
	    
	  });
}

function checkExcel(fileId)
{
	var file = document.getElementById(fileId).value;
	
	if(file==null||file==""){
		alert('请选择要导入Excel文件！');
		return false;
	}else{
		if(file.indexOf(".xls")==-1 && file.indexOf(".xlsx")==-1){
			alert('对不起，导入文件格式不对，请选择Excel文件！');
			return false;
		}
	}
	
	return true;
}






