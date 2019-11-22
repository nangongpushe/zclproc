function Main(){
    this.list=ko.observableArray([]);
    this.total=0;
    this.pagesize=pagesize||10;
    this.pageindex=1;
}

Main.prototype={
    initPage:function(){
        var self=this;
        //日期选择器
        layui.laydate.render({
            elem:"#dealDate",
            type:"date",
            format:"yyyy-MM-dd",
        });
        //form渲染
        layui.form.render("select","search");
//		self.queryPageList();
        self.renderLayTable();
    },

    init:function(object){
        object.dealDate=Date_format(object.dealDate,true);
    },
    renderLayTable:function(){
        var self=this;
        var width=($('.container-box').innerWidth()-50)/8+1;
        layui.table.render({
            elem:"#mainTable",
            loading:true,
            cols:[[
                {field:"dealSerial",title:"成交明细号",width:width,fixed:true,sort:true, align:'center'},
                {field:"grainType",title:"粮食品种",width:width, align:'center'},
                {field:"inviteType",title:"招标类别",width:width, align:'center'},
                {field:"dealDate",title:"竞价交易时间",width:width,templet: '#dealDateFormat', align:'center'},
                {field:"gather",title:"汇总人",width:width,sort:true, align:'center'},
                {field:"status",title:"分发状态",width:width,sort:true, align:'center'},
                {fixed: 'right',title:"操作", width:width, align:'center', toolbar: '#barDemo'}
            ]],
            url:"../rotateSum/listPagination.shtml",
            method:"POST",
            request : {
                pageName : 'pageIndex',
                limitName : 'pageSize'
            },
            page:true,//开启分页
            limit:pagesize,
            limits:[10],
            id:'myTableID',
            done:function(res,curr,count){
            },
        });
        layui.table.on('tool(table)',function(obj){
            var data =obj.data;
            var layEvent=obj.event;
            var tr=obj.tr;
            if(layEvent=='detail'){
                self.show(data);
            }
        });
    },

    queryPageList:function(){
        var self=this;
        layui.table.reload("myTableID",{
            method:"POST",
            where:{
                grainType:$('[name="grainType"]').val(),
                inviteType:$('select[name="inviteType"]').val(),
                dealDate:$('[name="dealDate"]').val(),
            }
        });
    },
    clear:function () {
        $('[name="grainType"]').val("");
        $('select[name="inviteType"]').val("");
        $('[name="dealDate"]').val("");
        var form = layui.form;
        form.render();
    },
    show:function(data) {
        let width = $("#page-wrapper").innerWidth();
        let height = $("#page-wrapper").innerHeight();
        var url = "../rotateSum/view.shtml?";
        $.post(url, {sid:data.id,type:self.type}, function(str) {
            layer.open({
                type : 1,
                content : str,
                area:[width,height]
            });
        });
    },
};