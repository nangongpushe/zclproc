function cancelOperate(auvp, url) {
	if (auvp === 'v') {
		location.href = url;
	} else {
		layer.confirm('您是否要放弃编辑', function(index) {
			location.href = url;
		});
	}
};

$.fn.serializeObject = function(){    
	var o = {};    
	var a = this.serializeArray();    
	$.each(a, function() {    
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
};

//验证输入框最大长度
function maxLengthLimit(value, item, limit){
	var value = $.trim(value);
	var label = $(item).parent().parent().find('label').text();
	if (value.length > limit) {
		return label.substring(0,label.length - 1) + '不可超过' + limit + '个字符'; 
	}
}