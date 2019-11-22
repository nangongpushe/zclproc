/**
 * 
 */
var mydate={
		getcurrentDate:function(){
			return new Date();
		},
		
		getYear:function(){
			var currentDate=this.getcurrentDate();
			return currentDate.getFullYear();			
		},
		
		getFormatDate:function(format){
			var currentDate=this.getcurrentDate();
		    var o = {  
		            "M+": currentDate.getMonth() + 1, //月份   
		            "d+": currentDate.getDate(), //日   
		            "H+": currentDate.getHours(), //小时   
		            "m+": currentDate.getMinutes(), //分   
		            "s+": currentDate.getSeconds(), //秒   
		            "q+": Math.floor((currentDate.getMonth() + 3) / 3), //季度   
		            "S": currentDate.getMilliseconds() //毫秒   
		        };  
		        if (/(y+)/.test(format)) format = format.replace(RegExp.$1, (currentDate.getFullYear() + "").substr(4 - RegExp.$1.length));  
		        for (var k in o)  
		        if (new RegExp("(" + k + ")").test(format)) format = format.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
		        return format;
		}
}
