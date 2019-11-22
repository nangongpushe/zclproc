/**
 * Created by MCC on 2017/1/17.
 */
$(function () {
    //当input获得焦时去掉placeholder；
    $("input").on("focus",function(){
        $(this).attr("placeholder"," ");
    });
    //提交订单
    $("#submit").click(function(){
        if(!$("#username").val()) {
            layer.alert("请输入用户名！");
            return false;
        }else if(!$("#password").val()) {
            layer.alert("请输入密码！");
            return false;
        }else{
            $(".myfrom").submit();
        };
    });
});
