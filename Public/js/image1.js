var imageUploader1 = {};
(function () {
    var ajax = function() {
    	return {
    		/**
    		 * 向url发送ajax请求
    		 * @param url
    		 * @param ajaxOptions
    		 */
    		request:function(url, ajaxOptions) {
                var ajaxRequest = creatAjaxRequest(),
                    //是否超时
                    timeIsOut = false,
                    //默认参数
                    defaultAjaxOptions = {
                        method:"POST",
                        timeout:5000,
                        async:true,
                        data:{},//需要传递对象的话只能覆盖
                        onsuccess:function() {
                        },
                        onerror:function() {
                        }
                    };

    			if (typeof url === "object") {
    				ajaxOptions = url;
    				url = ajaxOptions.url;
    			}
    			if (!ajaxRequest || !url) return;
    			var ajaxOpts = ajaxOptions ? utils.extend(defaultAjaxOptions,ajaxOptions) : defaultAjaxOptions;

    			var submitStr = json2str(ajaxOpts);  // { name:"Jim",city:"Beijing" } --> "name=Jim&city=Beijing"
    			//如果用户直接通过data参数传递json对象过来，则也要将此json对象转化为字符串
    			if (!utils.isEmptyObject(ajaxOpts.data)){
                    submitStr += (submitStr? "&":"") + json2str(ajaxOpts.data);
    			}
                //超时检测
                var timerID = setTimeout(function() {
                    if (ajaxRequest.readyState != 4) {
                        timeIsOut = true;
                        ajaxRequest.abort();
                        clearTimeout(timerID);
                    }
                }, ajaxOpts.timeout);

    			var method = ajaxOpts.method.toUpperCase();
                var str = url + (url.indexOf("?")==-1?"?":"&") + (method=="POST"?"":submitStr) + "&noCache=" + +new Date;
    			ajaxRequest.open(method, str, ajaxOpts.async);
    			ajaxRequest.onreadystatechange = function() {
    				if (ajaxRequest.readyState == 4) {
    					if (!timeIsOut && ajaxRequest.status == 200) {
    						ajaxOpts.onsuccess(ajaxRequest);
    					} else {
    						ajaxOpts.onerror(ajaxRequest);
    					}
    				}
    			};
    			if (method == "POST") {
    				ajaxRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    				ajaxRequest.send(submitStr);
    			} else {
    				ajaxRequest.send(null);
    			}
    		}
    	};

    	/**
    	 * 将json参数转化成适合ajax提交的参数列表
    	 * @param json
    	 */
    	function json2str(json) {
    		var strArr = [];
    		for (var i in json) {
    			//忽略默认的几个参数
    			if(i=="method" || i=="timeout" || i=="async") continue;
    			//传递过来的对象和函数不在提交之列
    			if (!((typeof json[i]).toLowerCase() == "function" || (typeof json[i]).toLowerCase() == "object")) {
    				strArr.push( encodeURIComponent(i) + "="+encodeURIComponent(json[i]) );
    			}
    		}
    		return strArr.join("&");

    	}

    	/**
    	 * 创建一个ajaxRequest对象
    	 */
    	function creatAjaxRequest() {
    		var xmlHttp = null;
    		if (window.XMLHttpRequest) {
    			xmlHttp = new XMLHttpRequest();
    		} else {
    			try {
    				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    			} catch (e) {
    				try {
    					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    				} catch (e) {
    				}
    			}
    		}
    		return xmlHttp;
    	}
    }();
    var g = $G,
            maskIframe = g( "maskIframe1" ), //tab遮罩层,用来解决flash和其他dom元素的z-index层级不一致问题
            flashObj,               //flash上传对象
            delImgfun,defaultImg,getImgs;
    var flagImg = null;
    imageUploader1.init = function ( opt, callbacks ) {
        getImgs = opt.getImgs;
        delImgfun = opt.delImg;
        defaultImg = opt.defaultImg;
        switchTab( "imageTab1" );
        createFlash( opt, callbacks );
        addUploadListener();
        addScrollListener();
        maskIframe.style.display = "none";
        if(opt.mode=="add"){
            showHead(0);
        }else if(opt.mode=="update"){
            showHead(1);
        }else{
            showHead();
        }
    };
    //点击更改head样式
    function showHead(num){
        var tabElements = g( "imageTab1" ).children,
               tabHeads = tabElements[0].children;
        //head样式更改
        for ( var k = 0, len = tabHeads.length; k < len; k++ ) {
            tabHeads[k].className = "";
            tabHeads[k].style.display = "";
            if(num!=null&&num!=k){
                tabHeads[k].style.display = "none";
            }
        }
        num = num ||0;
        tabHeads[num].className = "focus";
        clickTab(tabHeads[num])
    }
    /**
     * 延迟加载
     */
    function addScrollListener() {
        g( "imageList1" ).onscroll = function () {
            var imgs = this.getElementsByTagName( "img" ),
                    top = Math.ceil( this.scrollTop / 100 ) - 1;
            top = top < 0 ? 0 : top;
            for ( var i = top * 5; i < (top + 5) * 5; i++ ) {
                var img = imgs[i];
                if ( img && !img.getAttribute( "src" ) ) {
                    img.src = img.getAttribute( "lazy_src" );
                    img.removeAttribute( "lazy_src" );
                }
            }
        }
    }
    /**
     * 绑定开始上传事件
     */
    function addUploadListener() {
        g( "upload1" ).onclick = function () {
            flashObj.upload();
            this.style.display = "none";
        };
    }
    /**
     * 图片缩放
     * @param img
     * @param max
     */
    function scale( img, max, oWidth, oHeight ) {
        var width = 0, height = 0, percent, ow = img.width || oWidth, oh = img.height || oHeight;
        if ( ow > max || oh > max ) {
            if ( ow >= oh ) {
                if ( width = ow - max ) {
                    percent = (width / ow).toFixed( 2 );
                    img.height = oh - oh * percent;
                    img.width = max;
                }
            } else {
                if ( height = oh - max ) {
                    percent = (height / oh).toFixed( 2 );
                    img.width = ow - ow * percent;
                    img.height = max;
                }
            }
        }
    }
    /**
        * 创建flash实例
        * @param opt
        * @param callbacks
        */
       function createFlash( opt, callbacks ) {
           var option = {
               createOptions:{
                   id:'flash1',
                   url:opt.flashUrl,
                   width:opt.width,
                   height:opt.height,
                   errorMessage:'Flash插件初始化失败，请更新您的FlashPlayer版本之后重试！',
                   wmode:browser.safari ? 'transparent' : 'window',
                   ver:'10.0.0',
                   vars:opt,
                   container:opt.container
               }
           };
           option = utils.extend( option, callbacks, false );
           flashObj = new baidu.flash.imageUploader( option );
       }


    /**
     * TAB切换
     * @param tabParentId  tab的父节点ID或者对象本身
     */
    function switchTab( tabParentId ) {
        var tabElements = g( tabParentId ).children,
                tabHeads = tabElements[0].children;
        for ( var i = 0, length = tabHeads.length; i < length; i++ ) {
            var head = tabHeads[i];
            head.onclick = function(){
                clickTab(this)
            };
        }
    }
    //切换tab的函数
    function clickTab(obj){
        var tabElements = g( "imageTab1" ).children,
                tabHeads = tabElements[0].children,
                me = obj,
                tabBodys = tabElements[1].children;

        //head样式更改
        for ( var k = 0, len = tabHeads.length; k < len; k++ ) {
            tabHeads[k].className = "";
        }
        me.className = "focus";
        //body显隐
        var tabSrc = me.getAttribute( "tabSrc" );
        for ( var j = 0, length = tabBodys.length; j < length; j++ ) {
            var body = tabBodys[j],
                    id = body.getAttribute( "id" );
            if ( id != tabSrc ) {
                body.style.zIndex = 1;
            } else {
                body.style.zIndex = 200;
                //当切换到本地图片上传时，隐藏遮罩用的iframe
                maskIframe.style.display = id=="local1" ? "none" : "";
                var list = g( "imageList1" );
                list.style.display = "none";
                //切换到图片管理时，ajax请求后台图片列表
                if ( id == "imgManager1" ) {
                    list.style.display = "";
                    //已经初始化过时不再重复提交请求
                    if ( !list.children.length ) {
                        initImgManager();
                    }
                }
            }
        }
    }

    function initImgManager(){
        var imageUrls = getImgs();
        g( "imageList1" ).innerHTML = !length ? "&nbsp;&nbsp;当前未上传过任何图片！" : "";
        if(imageUrls.length){
            for ( var i = 0, ci; ci = imageUrls[i++]; ) {
                var img = document.createElement( "img" );
                var div = document.createElement( "div" );
                var dellink = document.createElement("a");
                var defaultlink = document.createElement("a");
                dellink.innerHTML = "删除";
                dellink.setAttribute("url",mreplace(ci,"s_"));
                defaultlink.innerHTML = "默认";
                defaultlink.setAttribute("url",mreplace(ci,"s_"));
                div.appendChild( img );
                div.appendChild(dellink);
                div.appendChild(defaultlink);
                div.style.display = "none";
                g( "imageList1" ).appendChild( div );
                dellink.onclick = function(){
                    var url = this.getAttribute("url"),
                            tmpurl = url.substring(url.lastIndexOf("/")+1,url.length).replace("s_","");
                    delImgfun(tmpurl);
                    initImgManager();
                };
                defaultlink.onclick = function(){
                    var url = this.getAttribute("url"),
                           tmpurl = url.substring(url.lastIndexOf("/")+1,url.length).replace("s_","");
                    defaultImg(tmpurl);
                    initImgManager();
                };
                img.onload = function () {
                    this.parentNode.style.display = "";
                    var w = this.width, h = this.height;
                    scale( this, 100, 120, 80 );
                    this.title = "原图尺寸:" + w + "X" + h;
                };
                img.onerror = function(){
                	this.parentNode.style.display = "";
                	this.src = "/Public/images/nopic.png";
                	this.height = "74px";
                }
                img.setAttribute( i < 35 ? "src" : "lazy_src",  mreplace(ci,"s_") );
                img.setAttribute( "data_ue_src", mreplace(ci,"s_") );

            }
        }
    }
    function mreplace(str,r){
        return "/Tpl/Uploads/"+r+str;
//        var tmpstr = str.substring(0,str.lastIndexOf("/")+1);
//        return str.replace(tmpstr,tmpstr+r);
    }
})();
