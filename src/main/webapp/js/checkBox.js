/**
 * Created by MCC on 2017/2/28.
 */
$(function(){
    //点击多选按钮选中和取消选中当前行；
    $(".check_box_btn").click(function () {
        var src = $(this).attr("src");
        if (src == "../images/check_box.png") {
            $(this).attr("src", "../images/check_box_ok.png");
            $(this).parent().parent().addClass("checked_tr")
        } else {
            $(this).attr("src", "../images/check_box.png")
            $(this).parent().parent().removeClass("checked_tr")
        };
        //当按钮全部选中的时候复选框选中，反之则取消选中；
        if ($(".check_box_btn").length == $(".checked_tr").length) {
            $(".CheckBox").attr("src", "../images/check_box_ok.png");
        } else {
            $(".CheckBox").attr("src", "../images/check_box.png");
        };
    })
    //全选列表，全不选列表；
    $(".CheckBox").click(function () {
        if ($(this).attr("src") == "../images/check_box.png") {
            $(this).attr("src", "../images/check_box_ok.png");
            $(this).parents("table").find(".check_box_btn").attr("src", "../images/check_box_ok.png");
            $(this).parents("table").find(".check_box_btn").parent().parent().addClass("checked_tr")

        } else {
            $(this).attr("src", "../images/check_box.png");
            $(this).parents("table").find(".check_box_btn").attr("src", "../images/check_box.png");
            $(this).parents("table").find(".check_box_btn").parent().parent().removeClass("checked_tr");
        };
    });

    //点击删除删除相应的行；
    $(".remove_btn").click(function(){
        if($(".checked_tr").length<=0) {
            layer.alert("请选择要删除的内容！",{
               offset:['172px','35%']
            })
        }else{
            layer.confirm('你确定要删除吗？', {
                btn: ['删除','取消'],  //按钮,
                offset:['172px','35%']
            }, function() {
                layer.msg('删除成功！', {icon: 1,offset:['172px','35%']});
                $(".checked_tr").remove();
            });
        };
    });

    //点击编辑为空的提示；
    $(".compile").on("click",operation)//编辑
    $(".detail_btn").on("click",operation)//查看
    function operation(){
       var text = $(this).text();
        if($(".checked_tr").length<=0) {
            layer.alert("请选择要"+text+"的内容！",{
                offset:['172px','35%']
            })
        }else if($(".checked_tr").length>1){
            layer.alert("只能选择其中的一条信息哦！",{
                offset:['172px','35%']
            })
        }else{
            window.location.href=$(this).attr("data-href");
        };
    }
    $("#addlist").click(function(){
        window.location.href="financing.html";
    });
    //点击差值比较为空的提示；
    $(".compare").on("click",show)//编辑
    function show(){
        var text = $(this).text();
        if($(".checked_tr").length<=0) {
            layer.alert("请选择要"+text+"的数据！",{
                offset:['172px','35%']
            })
        }else if($(".checked_tr").length==2){
            window.location.href=$(this).attr("data-href")
        }else{
            layer.alert("请选择其中的两条信息哦！",{
                offset:['172px','35%']
            })
        };
    }
    //点击清空按钮；
    $(".delete").on("click",operation1)//编辑
    function operation1(){
        // $("input[name='delete']").val("");
        $("input").val("");
    }
    //马婵:取得地址栏参数判断页面类型
    if(GetQueryString("type")==1){
        $(".type").html("新增");
    }else if(GetQueryString("type")==2){
        $(".type").html("编辑");
    }else if(GetQueryString("type")==3){
        $(".type").html("查看");
    };
    //删除本行内容
    $(".remove_tr").click(function(){
        $(this).parents("tr").remove();
    })

    //默认填写日期
    var input_date=getNowFormatDate();
    var day = new Date();
    var year=day.getFullYear()
    var month=day.getMonth();
    $(".input-date").attr('placeholder',input_date)
    $(".year").attr('placeholder',year)
    $(".input-month").attr('placeholder',year +'-'+ month)
});
function getNowFormatDate()
{
    var day = new Date();
    var Year = 0;
    var Month = 0;
    var Day = 0;
    var CurrentDate = "";
    //初始化时间
    //Year     = day.getYear();//有火狐下2008年显示108的bug
    Year       = day.getFullYear();//ie火狐下都可以
    Month      = day.getMonth()+1;
    Day        = day.getDate();
    CurrentDate += Year + "-";
    if (Month >= 10 )
    {
        CurrentDate += Month + "-";
    }
    else
    {
        CurrentDate += "0" + Month + "-";
    }
    if (Day >= 10 )
    {
        CurrentDate += Day ;
    }
    else
    {
        CurrentDate += "0" + Day ;
    }
    return CurrentDate;
}
//计算折合率
Calculation($("#ac1"),$("#eq1"))
Calculation($("#ac2"),$("#eq2"))
Calculation($("#ac3"),$("#eq3"))
Calculation($("#ac4"),$("#eq4"))
Calculation($("#ac5"),$("#eq5"))
Calculation($("#ac6"),$("#eq6"))
Calculation($("#ac7"),$("#eq7"))
Calculation($("#ac8"),$("#eq8"))
function Calculation(actual,equivalent){
    equivalent.focus(function(){
        var num01 = parseInt(actual.val());
        var num02 = 0.2
        equivalent.val(num01*num02);
    })
}