function setBackFill(settings) {
    this.init(settings)
}

setBackFill.prototype = {
    init: function (settings) {
        this.settings = $.extend({
            getSelectedId: '', //获得需要的id
            getSelectedName: [], //需要的选着
            getUnSelectedName: [], //不需要的
            whereName:"",
            getPathPrefix: '',
            back:'',
            selfDefinedParam:[], //自定义参数
            callBack:'',
        }, settings);
        this.settings.back ?  this.backPageParams() :this.setSessionStorage()
    },
    setParams:function () {
        var th = this
        if(!th.settings.getSelectedId) return
        th.settings.getSelectedName = []; //获得 Select Input 需要  选中的
        th.settings.getUnSelectedName = [];  //不需要 Select Input 选中的
        th.settings.parentGet = document.getElementById(th.settings.getSelectedId)
        th.settings.getPathPrefix = location.href.split('?')[0].split('\/') //获得路径
        th.settings.getPathPrefix = th.settings.getPathPrefix[th.settings.getPathPrefix.length - 1].split('.')[0]
            + '_' + th.settings.getPathPrefix[th.settings.getPathPrefix.length - 2]
        $(th.settings.parentGet.querySelectorAll('input')).each(function (i, value) {
            th.settings.getSelectedName.unshift({'input': value.getAttribute('name')})
        })
        $(th.settings.parentGet.querySelectorAll('select')).each(function (i, value) {
            th.settings.getSelectedName.unshift({'select': value.getAttribute('name')})
        })
    },
    setSessionStorage: function () {
        var th = this
        th.setParams();
        //移除数组的方法
        th.settings.getSelectedName =
            th.settings.getUnSelectedName.length ?
                th.removeArray(th.settings.getSelectedName, th.settings.getUnSelectedName)
                : th.settings.getSelectedName
        // sessionStorage 赋值
        for (var k = 0; k < th.settings.getSelectedName.length; k++) {
            for (var key in th.settings.getSelectedName[k]) {
                if (key == 'input' || key == 'select') {
                    sessionStorage.setItem('"' + th.settings.getPathPrefix + '_' + th.settings.whereName +'_'+
                        th.settings.getSelectedName[k][key] + '"',
                        $(key + '[name="' + th.settings.getSelectedName[k][key] + '"]').val())
                }
            }
        }

        //自定义参数
        if(th.settings.selfDefinedParam!= []){
            for (var keu in th.settings.selfDefinedParam) {
                for (var ku in th.settings.selfDefinedParam[keu]) {
                    sessionStorage.setItem('"' + th.settings.getPathPrefix + '_' +ku,
                        th.settings.selfDefinedParam[keu][ku]);
                }
            }
        }

    },
    //移除数组的方法
    removeArray : function(oldArr, removeArr) {
        for (var s = 0; s < removeArr.length; s++) {
            for (var g = 0; g < oldArr.length; g++) {
                if (JSON.stringify(oldArr[g]) == JSON.stringify(removeArr[s])) {
                    oldArr.splice(g, 1)
                }

            }
        }
        return oldArr;
    },
    backPageParams : function () {
        var th = this
        th.setParams();
        for (var k = 0; k < th.settings.getSelectedName.length; k++) {
            for (var key in th.settings.getSelectedName[k]) {
                if(key == 'input' || key == 'select'){
                    $(key+'[name="'+th.settings.getSelectedName[k][key]+'"]').val(
                        sessionStorage.getItem('"'+th.settings.getPathPrefix +'_'+ th.settings.whereName +'_'+
                            th.settings.getSelectedName[k][key]+'"'))
                }
            }
        }
        //自定义参数 回填
        if(th.settings.selfDefinedParam!= []){
            for (var keu in th.settings.selfDefinedParam) {
                for (var ke in th.settings.selfDefinedParam[keu]) {
                    th.settings.selfDefinedParam[keu][ke]= sessionStorage.getItem(
                        '"' + th.settings.getPathPrefix + '_' +
                        ke + '"'
                    )
                }
            }
        }
    }
}