
     window.WebFX_PopUp="";
     window.WebFX_PopUpcss="";
window.ContextMenu = function(){}
ContextMenu.intializeContextMenu=function(idmenu)
{
try {  // firefox
	document.body.insertAdjacentHTML("BeforeEnd", '<iframe scrolling="no" class="dropdown-menu" marginwidth="0" marginheight="0" frameborder="1" style="position:absolute;display:none;z-index:50000000;" name="WebFX_PopUp_'+idmenu+'" id="WebFX_PopUp_'+idmenu+'" ></iframe>');
        WebFX_PopUp    = document.getElementById("WebFX_PopUp_"+idmenu).contentWindow;
	WebFX_PopUpcss = document.getElementById("WebFX_PopUp_"+idmenu);
	document.body.attachEvent("onmousedown",function(){WebFX_PopUpcss.style.display="none"});
	WebFX_PopUpcss.onfocus  = function(){WebFX_PopUpcss.style.display="inline";;};
	WebFX_PopUpcss.onblur  = function(){WebFX_PopUpcss.style.display="none";;};
	document.body.attachEvent("onblur",function(){WebFX_PopUpcss.style.display="none";})
} catch (err) { alert("error ContextMenu.intializeContextMenu="+err) }
};

window.ContextSeperator = function(){};


ContextMenu.showPopup=function(x,y)
	{
		WebFX_PopUpcss.style.display = "block";
	}

ContextMenu.display=function(popupoptions)
	{
	    var eobj,cmdx,cmdy;
    	eobj = window.event;
        if (!e) var e = window.event;
	if (e.clientX || e.clientY) 	{
		posx = e.clientX ;
		posy = e.clientY ;
	} else 
        if (e.pageX || e.pageY)         {
                posx = e.pageX;
                posy = e.pageY;
        }
        console.log('ClienteX='+e.clientX+' ClienteY='+e.clientY+' pageX='+e.pageX+' pageY='+e.pageY+' screenX='+e.screenX+' screenY='+e.screenY);
        ContextMenu.showPopup(posx,posy);
	ContextMenu.populatePopup(popupoptions,window)
	ContextMenu.fixSize();
	ContextMenu.fixPos(posx,posy);
        eobj.cancelBubble = true;
        eobj.returnValue  = false;
	}

 ContextMenu.getScrollTop=function()
  {
//	  alert('document.body.scrollTop='+document.body.scrollTop+' window.pageXOffset='+window.pageXOffset);
   	return document.body.scrollTop;
	//window.pageXOffset and window.pageYOffset for moz
        //return 0;
 }

   ContextMenu.getScrollLeft=function()
   {
     	return document.body.scrollLeft;
 }

  ContextMenu.fixPos=function(x,y)
  {
  	var docheight,docwidth,dh,dw;	
	docheight = document.body.clientHeight;
	docwidth  = document.body.clientWidth;
	dh = (WebFX_PopUpcss.offsetHeight+y) - docheight;
	dw = (WebFX_PopUpcss.offsetWidth+x)  - docwidth;
	if(dw>0)
	{
	WebFX_PopUpcss.style.left = (x - dw) + ContextMenu.getScrollLeft() + "px";		
	}
	else
	{
	WebFX_PopUpcss.style.left = x + ContextMenu.getScrollLeft() + "px";
        }
	if(dh>0)
	{
		WebFX_PopUpcss.style.top = (y - dh) + ContextMenu.getScrollTop() + "px"
	}
	else
	{
		WebFX_PopUpcss.style.top  = y + ContextMenu.getScrollTop() + "px";
	}
}

	ContextMenu.fixSize=function()
	{
		try
		{
			var body,h,w;
                        h=0; w=0;
			WebFX_PopUpcss.style.width = "10%";
			WebFX_PopUpcss.style.height = "10%";
		        body = WebFX_PopUp.document.body;
			var dummy = WebFX_PopUpcss.offsetHeight + " dummy";
			h = body.scrollHeight + WebFX_PopUpcss.offsetHeight - body.clientHeight;
			w = body.scrollWidth + WebFX_PopUpcss.offsetWidth - body.clientWidth;
			WebFX_PopUpcss.style.height = h + "px";
			WebFX_PopUpcss.style.width = w + "px";
		}
		catch (err)
		{
			alert('error fixsize '+err);
		}
	}
ContextMenu.populatePopup=function(arr,win)
{
       try {  // firefox
		var alen,i,tmpobj,doc,height,htmstr;
		alen = arr.length;
		doc  = WebFX_PopUp.document;
		doc.body.innerHTML  = "";
		if (doc.getElementsByTagName("LINK").length == 0) {
			doc.open();
			doc.write('<html><head><link rel="StyleSheet" type="text/css" href="dist/css/WebFX-ContextMenu.css"></head><body></body></html>');
			doc.close();
		}
		doc.body.className  = "WebFX-ContextMenu-Body" ;
		for(i=0;i<alen;i++)
		{
			if(arr[i].constructor==ContextItem)
			{
				tmpobj=doc.createElement("div");
				tmpobj.noWrap = true;
				tmpobj.className = "WebFX-ContextMenu-Item";
				if(arr[i].disabled)
				{
					htmstr  = '<span class="WebFX-ContextMenu-DisabledContainer"><span class="WebFX-ContextMenu-DisabledContainer">'
					htmstr += arr[i].text+'</span></span>'
					tmpobj.innerHTML = htmstr
					tmpobj.className = "WebFX-ContextMenu-Disabled";
					tmpobj.onmouseover = function(){this.className="WebFX-ContextMenu-Disabled-Over"}
					tmpobj.onmouseout  = function(){this.className="WebFX-ContextMenu-Disabled"}
				}
				else
				{
					tmpobj.innerHTML = arr[i].text;
					tmpobj.onclick = (function (f)
					{	
					 return function () {
							win.WebFX_PopUpcss.style.display='none'
					    		if (typeof(f)=="function"){ f(); }
					 					};
					})(arr[i].action);
					tmpobj.onmouseover = function(){this.className="WebFX-ContextMenu-Over"}
					tmpobj.onmouseout  = function(){this.className="WebFX-ContextMenu-Item"}
				}
				doc.body.appendChild(tmpobj);
			}
			else
			{
				doc.body.appendChild(doc.createElement("div")).className = "WebFX-ContextMenu-Separator";
			}
		}
	} 
catch (err) { alert('error =ContextMenu.populatePopup'+err) }
}

window.ContextItem = function(str,fnc,disabled)
{
	this.text     = str;
	this.action   = fnc; 
	this.disabled = disabled || false;
}
