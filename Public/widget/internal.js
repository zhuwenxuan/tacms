(function () {
    var parent = window.parent;
    //dialog对象
    dialog = parent.$XFUI[window.frameElement.id.replace( /_iframe$/, '' )];
    XF = parent.XF;

    domUtils = XF.domUtils;

    utils = XF.utils;

    browser = XF.browser;

    ajax = XF.ajax;

    $ = function ( id ) {
        return document.getElementById( id )
    };
    //focus元素
    $focus = function ( node ) {
        setTimeout( function () {
            if ( browser.ie ) {
                var r = node.createTextRange();
                r.collapse( false );
                r.select();
            } else {
                node.focus()
            }
        }, 0 )
    };
    window.wsubmit = function(param){
        XF.ajax.request(parent.subpath+"/Theme/Layout/addWidget",{
            data:{
                'layoutid':parent.layoutid,
                'position':parent.cname,
                'name':parent.wname,
                'param':param
            },
            onsuccess:function(xhr){
                var cid = parent.cname+"_show",
                cdiv = parent.document.getElementById(cid);
                cdiv.innerHTML = xhr.responseText;
            }
        });
    }
})();

