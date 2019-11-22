var W = document.documentElement.clientWidth || document.body.clientWidth;//获取屏幕宽度
var H = document.documentElement.clientHeight || document.body.clientHeight;//获取屏幕高度

//// iframe自适应高度
//function IFrameResize(){
//  // location.reload();
//  var obj = window.parent.document.getElementById("childFrame"); //取得父页面IFrame对象
//    obj.height = this.document.body.offsetHeight; //调整父页面中IFrame的高度为此页面的高度
//    console.log(obj.height);
//    //console.log(this.document.body.offsetHeight);
//
//};

/**
 * 表单保存
 * @param formId
 * @param serviceUrl
 * @param fnCallback
 * @returns {boolean}
 */
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
                layer.alert('操作失败' + data.msg, {icon:2});
                return;
            } else {
                layer.msg('操作成功',{time:1000,icon:1},function(){
                    if (typeof (fnCallback) != "undefined")
                        fnCallback(data);
                });
            }
        }
    });
}

//将form数据封状成json对象
$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
}








