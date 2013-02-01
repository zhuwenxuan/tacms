(function(){
    var dialog="",
            cname = "",
            layoutid = $("layoutid").value,
            subpath = $("subpath").value;
    function $(id){
        return document.getElementById(id);
    }
    String.prototype.trim = function(){
        return this.replace(/(^[ \t\n\r]+)|([ \t\n\r]+$)/g, '');
    }
    //获得可编辑模板
    function getTpls(){
        var allTpl = domUtils.getElementsByTagName(document.body,"div"),
                tpls = [];
        for(var i=0,tpl;tpl=allTpl[i++];){
            if(/edui-tpl/ig.test(tpl.className)){
                tpls.push(tpl);
            }
        }
        return tpls;
    }
    //创建按钮
    function createButton(id,className){
        var btn = document.createElement("div");
        btn.id = id;
        btn.className = className;
        return btn;
    }
    function renderBtn(){
        var tpls = getTpls();
        for(var i=0,tpl;tpl=tpls[i++];){
            cname = tpl.className.match(/edui-tpl-([\w]+)/i)[1];
            var upbtn = createButton(cname+"_up_btn","btn");
            upbtn.innerHTML = "修改";
            var delbtn = createButton(cname+"_del_btn","btn");
            delbtn.innerHTML = "删除";
            var addbtn = createButton(cname+"_add_btn","btn");
            addbtn.innerHTML = "添加";
            upbtn.onclick = function(){
                cname = this.id.match(/([^_.*]+)_/i)[1];
                window.cname = cname;
                var show = $(cname+"_show");
                if(!show.innerHTML.trim()){
                    alert("微件不存在，不可修改");
                }else{
                    var obj = {
                        iframeUrl:subpath+"/Theme/Layout/toEditWidget?layoutid="+layoutid+"&position="+cname,
                        title:"修改微件"
                    };
                    createDialog(obj);
                }
            };
            delbtn.onclick = function(){
                cname = this.id.match(/([^_.*]+)_/i)[1];
                window.cname = cname;
                var obj = {
                    url:subpath+"/Theme/Layout/deleteWidgetHtml",
                    data:{
                        'layoutid':layoutid,
                        'position':cname
                    },
                    onsuccess:function(xhr){
                        var show = $(cname+"_show");
                        if(show){
                            show.innerHTML = "";
                        }
                    }
                };
                sendAction(obj);
            };
            addbtn.onclick =function(){
                cname = this.id.match(/([^_.*]+)_/i)[1];
                window.cname = cname;
                var show = $(cname+"_show");
                if(show.innerHTML.trim()){
                    alert("微件已存在，不可在添加");
                }else{
                    var obj = {
                        url:subpath+"/Theme/Layout/listWidget",
                        onsuccess:function(xhr){
                            var obj = eval('('+xhr.responseText+')');
                            var listWidget = [],
                                    dialogObj = {
                                        title:"选择微件"
                                    };
                            for(var i=0,item;item=obj[i++];){
                                listWidget.push("<span onclick='changeWidget(\""+item+"\",\""+cname+"\")'>"+item+"</span><br>");
                            }
                            dialogObj.dialogContent = listWidget.join("");
                            createDialog(dialogObj);
                        }
                    };
                    sendAction(obj);
                }
            }
            tpl.appendChild(addbtn);
            tpl.appendChild(upbtn);
            tpl.appendChild(delbtn);
        }
    }
    //选择微件
    function changeWidget(wname,position){
        window.wname= wname;
        var obj = {
            iframeUrl:subpath+"/Theme/Layout/toAddWidget?wname="+wname+"&position="+position,
            title:"添加微件"
        };
        createDialog(obj);
    }
    //创建dialog
    function createDialog(dialogObj){
        //实例化dialog
        dialog&&dialog.dispose();
        dialog = new XF.ui.Dialog({
            title:dialogObj.title,
            content:dialogObj.dialogContent,
            iframeUrl:dialogObj.iframeUrl,
            buttons:[
                {
                    className:'edui-okbutton',
                    label:'确认',
                    onclick:function () {
                        dialogObj.onok&&dialogObj.onok.call(this);
                        dialog.close(true);
                    }
                },
                {
                    className:'edui-cancelbutton',
                    label:"取消",
                    onclick:function () {
                        dialogObj.oncancel&&dialogObj.oncancel.call(this);
                        dialog.close(false);
                    }
                }
            ]
        });
        dialog.open();
    }

    //发送请求
    function sendAction(obj){
        XF.ajax.request(obj.url,{
            data:obj.data,
            onsuccess:function(xhr){
                obj.onsuccess.call(this,xhr);
            },
            onerror:function(){
                obj.onerror.call(this);
            }
        });
    }
    renderBtn();
    window.changeWidget = changeWidget;
    window.subpath = subpath;
    window.layoutid = layoutid;
})();