function Main(type){

	this.list=ko.observableArray([]);
	this.total=0;
	this.pagesize=pagesize;
	this.pageindex=1;
	this.type=type;
}

Main.prototype={
	initPage:function(){
		var self=this;
		layui.laydate.render({
				elem : $('[name="year"]')[0],
				type : "year",
				change: function(value, date, endDate){
					$("#year").val(value);
					if($(".layui-laydate").length){
						$(".layui-laydate").remove();
					}
				},
				format : "yyyy"
		});
		layui.laydate.render({
			elem:$('[name="colletorDate"]')[0],
			type:"date",
			format:"yyyy-MM-dd",	
		});
		layui.form.render("select","search");

		self.renderTable();
		
	},
	
	init:function(data){
		data.colletorDate=Date_format(data.colletorDate,true);
		data.state=ko.observable(data.state);

	},

	renderTable:function(){
		var width=200;
		var self =this;
		layui.table.render({
			elem:"#myTable1",
			loading:true,
			url:'../rotatePlan/declarelist.shtml',
			method:"POST",
			request : {
				pageName : 'pageIndex', 
				limitName : 'pageSize'
			},
			cols:[[
				{field:'planName',title:'计划名称',width:width,align:'center',fixed:true,sort:true},//325
                {field:'planType',title:'计划类型',width:width,align:'center',sort:true},//325
				{field:'year',title:'年份',width:width-100,align:'center',sort:true},//180
				{field:'stockOut',title:'出库总数(吨)',width:width,align:'center',templet:'#stockOut',sort:true},//176
				{field:'stockIn',title:'入库总数(吨)',width:width,align:'center',templet:'#stockIn',sort:true},//174
				{field:'colletor',title:'创建人',width:width-50, align:'center'},//178
				{field:'colletorDate',title:'创建时间',width:width-50,align:'center',templet:'#colletorDateFormat',sort:true},//184
				{field:'state',title:'审批状态',width:width, align:'center'},//160
				{fixed: 'right',title:"操作", width:width, align:'center', toolbar: '#barDemo'}//201
				
			]],
			page:true,//开启分页
			limit:pagesize,
			limits:[10],
			id:"myTable1",
			done: function(res, curr, count){
				$('#myTable1').next().find('a[data-id]').click(function(){
					self.show(this);
				})
			}
		});
		
		layui.table.on('tool(table1)',function(obj){
			var data =obj.data;
			var layEvent=obj.event;
			var tr=obj.tr;
			if(layEvent=='edit'){
				self.edit(data);
			}else if(layEvent=='remove'){
				self.removePlan(data);
			}else if(layEvent=='submit'){
				//去掉oa流程
				//self.submit(obj,data,'OA流程','提交');
                self.submit(obj,data,'待审核','提交');
			}else if(layEvent=='pass'){
				self.submit(obj,data,'审核通过','通过审核');
			}else if(layEvent=='distribute'){
                self.showAllInfo(data);
            }
		});
	},
	
	reloadTable:function(){
		layui.table.reload("myTable1",{
			method:"POST",
			where:{
				year:$('#search [name="year"]').val(),
				colletor:$('#search [name="colletor"]').val(),
				colletorDate:$('#search [name="colletorDate"]').val(),
				state:$('#search [name="state"]').val(),
			}
		});
	},
	
	show:function(elem) {
		let width = $("#page-wrapper").innerWidth();
		let height = $("#page-wrapper").innerHeight();
		var id = $(elem).attr('data-id');
		var rotateType = $(elem).attr('data-type');
		var url = "../rotatePlan/detailview.shtml";
		$.post(url, {sid:id,rotatetype:rotateType}, function(str) {
			layer.open({
				type : 1,
				title:rotateType+"计划明细",
				content : str,
				area:[width,height],
				// maxHeight:400
			});
		});
	},
	edit:function(data){
		location.href = "../rotatePlan/editRotatePlanmain.shtml?sid="+ data.id;
	},
	submit:function(obj,data,state,tip){
		var self=this;
		layer.confirm('确定要继续'+tip+'吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			var loadIndex = layer.load();
			$.ajax({
				url:"../rotatePlan/updateOAState.shtml",
				type:"POST",
				data:{
					'id':data.id,
					'state':state
				},
				success:function(result){
					if(result.success){
						layer.close(loadIndex);
						layerMsgSuccess("操作成功",function(){self.reloadTable();});
					}
				},
				complete:function(){
					layer.close(index);
				}
			});
			
		}, function(index) {//否
			layer.close(index);
		});

	},
	remove:function(data){
		var self=this;
		layer.confirm('确定要删除吗?', {
			icon : 0,
			title : '提示'
		}, function(index) {//是
			$.ajax({
				url:"../rotatePlan/remove.shtml",
				type:"POST",
				data:{
					'sid':data.id
				},
				success:function(result){
					if(result.success){
						layerMsgSuccess("操作成功",function(){
							self.queryPageList();
						});
					}
				}
			});
		}, function(index) {//否
			layer.close(index);
		});

	},

    removePlan:function(data){
        var self=this;
        layer.confirm('确定要删除吗?', {
            icon : 0,
            title : '提示'
        }, function(index) {//是
            $.ajax({
                url:"../rotatePlan/removePlan.shtml",
                type:"POST",
                data:{
                    'sid':data.id
                },
                success:function(result){
                    if(result.success){
                        layerMsgSuccess(result.msg,function(){
                            location.href = "../rotatePlan/declare.shtml"
                        });
                    }else{
                        layerMsgError(result.msg,function(){
                            location.href = "../rotatePlan/declare.shtml"
                        });
					}
                }
            });
        }, function(index) {//否
            layer.close(index);
        });

    },
	add:function(){
		location.href="../rotatePlan/adddeclare.shtml"
	},

    delSearch:function() {
        $("input[name='year']").val("");
        $("input[name='colletor']").val("");
        $("input[name='colletorDate']").val("");
        $("select[name='state']").val("");
        layui.form.render();
    },
    showAllInfo:function(data) {
        var self=this;
        // var width=$('.container-box').innerWidth();
        let width = $("#page-wrapper").innerWidth();
        let height = $("#page-wrapper").innerHeight();
        var url = "../rotatePlan/detailview2.shtml";
        $.post(url, {sid:data.id,type:self.type}, function(str) {
            layer.open({
                type : 1,
                title:"计划明细",
                content : str,
                area:[width,height],
            });
        });
    },
};