
function Excel_Import(options){
		layui.upload.render({
		elem : options.elem,
		url : options.url,
		data : options.data,
		accept : 'file',
		done : function(res) {
			if (res.success) {
				$("#msg").val(res.msg);
				options.success(res.data);
				layer.msg("数据读取成功", {
					icon : 1
				});

			} else {
				layer.msg(res.msg||"数据读取失败", {
					icon : 2
				});
			}
		},
		error : function(res) {
			layer.msg("数据读取失败", {
				icon : 2
			});
		}
	});
}

function UploadFile(postdata){
	layui.upload.render({
		elem :'#uploadFile',
		url : '../sysFile/uploadFile.shtml',
		data : postdata,
		accept : 'file',
		done : function(res) {
			if (res.code == 0) {
				var fileName = res.data.fileName;
                var suffix = fileName.substring(fileName.indexOf(".")+1)
				$("#openExcel").css("display", "none");
				$("#openFile").css("display", "none");
				$('button#uploadFile').text(fileName);	// 之前注释，把注释取消不确定有什么影响
                $("#fileName").html(fileName);
				$("input#fileId").val(res.data.fileId);
				$("#clearFileBtn").css("display","");
                $("#afileName").attr("style","display:none;");
                $("#delFileBtn").show();
                $("#deleteFile").css("display","");
				layer.msg(res.msg, {
					icon : 1
				});
			} else {
				layer.msg(res.msg, {
					icon : 2
				});
			}
		},
		error : function(res) {
			layer.msg(res, {
				icon : 2
			});
		}
	});
}

function DeleteFile(){
	var id = $("input#fileId").val();
	var sid = $("#sid").val();
    $.ajax({
        type : "POST",
        url : "../rotatePlan/deleteFile.shtml?id="+id+"&sid="+sid,
        success : function(result) {
            if ( result.success ) {
                layerMsgSuccess("删除成功");
                $('button#uploadFile').html("<i class=\"layui-icon\"></i>上传");
                $("input#fileId").val("");
                $('button#deleteFile').hide();
                $('#deleteFile').parent().find("a").html("");
            } else {
                layerMsgError("删除失败");
            }
        }
    });
    layui.upload.render();
}


function layerMsgSuccess(msg,callback){
	layer.msg(msg,{icon:1},callback);
}

function layerMsgError(msg,callback){
	layer.msg(msg,{icon:2},callback);
}
function openAnnex(id) {
    //获取当前网址，如： http://localhost:8083/myproj/view/my.jsp
    var curWwwPath=window.document.location.href;
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht=curWwwPath.substring(0,pos);
    //获取带"/"的项目名，如：/myproj
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    //得到了 http://localhost:8083/myproj
    var realPath=localhostPaht+projectName;
    var winArgs = "'height=1000, width=1500, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no'";
    if(id==""){
    	id=$("input#fileId").val();
	}
    window.open(localhostPaht+projectName+"/sysFile/openFile.shtml?fileId="+id, "newwindow", winArgs);
}