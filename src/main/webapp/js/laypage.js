/**
 * Created by MCC on 2017/1/15.
 */
$(function(){
    laypage({
        cont: 'displayPage',
        pages: 18, //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18
        skin: '#b1cfe4',
        prev: '<', //若不显示，设置false即可
        next: '>', //若不显示，设置false即可
        curr: function(){ //通过url获取当前页，也可以同上（pages）方式获取
            var page = location.search.match(/page=(\d+)/);
            return page ? page[1] : 1;
        }(),
        jump: function(e, first){ //触发分页后的回调
            if(!first){ //一定要加此判断，否则初始时会无限刷新
                location.href = '?page='+e.curr;
            }
        }
    });
    if($("#displayPage1")){
        laypage({
            cont: 'displayPage1',
            pages: 18, //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18
            skin: '#b1cfe4',
            prev: '<', //若不显示，设置false即可
            next: '>', //若不显示，设置false即可
            curr: function(){ //通过url获取当前页，也可以同上（pages）方式获取
                var page = location.search.match(/page=(\d+)/);
                return page ? page[1] : 1;
            }(),
            jump: function(e, first){ //触发分页后的回调
                if(!first){ //一定要加此判断，否则初始时会无限刷新
                    location.href = '?page='+e.curr;
                }
            }
        });
    }
    if($("#displayPage2")) {
        laypage({
            cont: 'displayPage2',
            pages: 18, //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18
            skin: '#b1cfe4',
            prev: '<', //若不显示，设置false即可
            next: '>', //若不显示，设置false即可
            curr: function () { //通过url获取当前页，也可以同上（pages）方式获取
                var page = location.search.match(/page=(\d+)/);
                return page ? page[1] : 1;
            }(),
            jump: function (e, first) { //触发分页后的回调
                if (!first) { //一定要加此判断，否则初始时会无限刷新
                    location.href = '?page=' + e.curr;
                }
            }
        });
    }
})
