//<script>
// variables globales
window.isIE = '\v'=='v';;
window.req;
window.wlurl;
window.glr=0 ;  // variable donde se gurdar el renglon a actualizar
window.passData ; // variable donde se guardan todos los datos de la format
window.__eventocontinua = false;   // resultado o respuesta de haber llamado un objeto en el servidor
window.Cambiosize = 0;
window.autocomplete = "";
window._aa_ ;  // variable para la altaautomatica
window._aad_ ;  // variable para altaadjuntar

     window.showModalDialog = function (url,w,h,titulo,wlventana) 
     { 
       if (!wlventana) { wlventana=0; }
       if (wlventana==0)
       { return dhtmlmodal.open(titulo, 'div', url, titulo, 'width='+w+'px,height='+h+'px,center=1,resize=1,scrolling=1')  }
       if (wlventana==1)
       { return dhtmlwindow.open(titulo, 'div', url, titulo, 'width='+w+'px,height='+h+'px,center=1,resize=1,scrolling=1')  }
       if (wlventana==2)
       { window.open(url, '_blank',  'width='+w+'px,height='+h+'px,center=1,resize=1,scrolling=1'); return true;  }
     }
/*
   quita la function del string
  */
window.quitaf = function(str) { 
   x=str.substring(str.indexOf('{')+1);
   x=x.substring(0,x.length-2);
  return x; 
} 

window.tra_anc = function() {
       console.log('entro');
}
   
/*
   funcion para quitar el enter en los campos texto y de un click en el primer boton
  */
window.quitaenter = function(field) {
        if (isIE)
        {
           if (event.keyCode==13) {event.keyCode=9; return event.keyCode }
           return event.keyCode;
        }

        var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
        if (keyCode == 13) {
                var i;
                for (i = 0; i < field.form.elements.length; i++)
                {
                        if (field == field.form.elements[i])
                                break;
                }
                //i = (i + 1) % field.form.elements.length;
                for (i =  i +1 ; i < field.form.elements.length; i++)
                {
                     console.log('id='+field.form.elements[i].id+' tabindex='+field.form.elements[i].tabIndex+' name='+field.form.elements[i].name);
                     if (field.form.elements[i].tabIndex>=0 && field.form.elements[i].tabIndex!='undefined' 
                         && (field.form.elements[i].name.indexOf('wl_')>=0 || field.form.elements[i].type=="button"))
                     {
                         field.form.elements[i].focus();
                         break;
                     }
                }
                return false;
        }
        else
        return event.keyCode;
}

/*
    funcion para salir del sistema
   */
window.salir = function(){
       mensajee= window.confirm('Desea salir del sistema?' );
       if (mensajee){   
           if (window.navigate) {  window.navigate('index.php'); }
           else { location.assign('index.php'); }
       }
       else { return;}
} 

window.armaImgPdf = function(archivo)
{
        archivoarr=archivo.split('.');
        if (archivoarr[1]=='jpg')
        {
                eventos_servidor("",0,"armaImgPdf","","",document.body.clientWidth,document.body.clientHeight);
        }       else    {
                open ('upload_ficheros/'+archivo,'x');
        }
}

if(typeof HTMLElement!='undefined'&&!HTMLElement.prototype.click)  // por firefox para simular un click
{
	HTMLElement.prototype.click=function(){
	var evt = this.ownerDocument.createEvent('MouseEvents');
	evt.initMouseEvent('click', true, true, this.ownerDocument.defaultView, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
	this.dispatchEvent(evt);
	}
}

window.formResetID = function(idmenu,limpiaralta) {
        formReset($('#formpr_'+idmenu)[0],limpiaralta);
}

window.formReset = function(theForm,limpiaralta)
{
	if (limpiaralta=='t')
  		theForm.reset();
        var qs = '';
        for (e=0;e<theForm.elements.length;e++) {
             if (theForm.elements[e].name!='' && ('cambiarencambios' in theForm.elements[e].dataset)) {
                var str=theForm.elements[e].name;
                var wl=str.replace(/nc_/,"wl_");		  		
                try { objwl=theForm.elements[e];  
	              objwl.readOnly=false; objwl.disabled=false;  
                } catch (err) { };
    }
  }
        var all = document.getElementsByTagName("a");
        for( var i=0; i<all.length; ++i ) {
             if(all[i].name.indexOf("_borrar_")>=0)
             {    all[i].parentNode.removeChild(all[i]); i=-1; }
        }
  return qs
}

function siguienteregistro()
{
	var nr=parseInt(glr)+1;
   	var wlid = 	'cam'+nr;
   	try { document.getElementById(wlid).click() } catch (err) { };   		
}
function anteriorregistro()
{
	var nr=parseInt(glr)-1;
   	var wlid = 	'cam'+nr;
   	try { document.getElementById(wlid).click() } catch (err) { };   		
}
function registroinicial()
{

   	var wlid = 	'cam0';
   	try { document.getElementById(wlid).click() } catch (err) { };   		
}
function registrofinal()
{
	var nr=document.getElementById('tabdinamica').rows.length-2;
   	var wlid = 	'cam'+nr;
   	try { document.getElementById(wlid).click() } catch (err) { };   		
}

	/*	restaura del campos donde los valores del autocomplete
	*/
  window.restaura_autocomplete = function(objeto)
  {
      var nombre=objeto.name.replace(/wl_/,"au_");						  
	  document.getElementById(nombre).value="";
  }
	/*	LLena un campo select con los datos tecleados
	*/  
  window.autollenado = function(objeto,e,sql,filtro)
  {
		if(e.keyCode==13 || e.keyCode==9 || e.keyCode==16 || e.keyCode==48 || e.keyCode==36 || e.keyCode==40 || e.keyCode==38 || e.keyCode==91 || e.keyCode==18)return;	  
		try 
		{ 
			var nombre=objeto.name.replace(/wl_/,"au_");					
			if(e.keyCode==8 || e.keyCode==46 || e.keyCode==37)
			{	
				var len = document.getElementById(nombre).value.length;
				if (len>=1)
				{
					document.getElementById(nombre).value=document.getElementById(nombre).value.substring(0,len-1); 
				}
				if (len==1) return;
			}
			else
			{	document.getElementById(nombre).value+=String.fromCharCode(e.keyCode) ; }
		    pon_Select(sql,'',objeto.name.replace(/wl_/,""),filtro+' like \''+nombre+'%\'',0,1);	  		
		}
		catch (err) { alert('no existe el campo de autollenado'+err.description+'objeto.name'+objeto.name ); }
  }
  window.toggleDiv = function(divid,objeto){
	try {
    	if(document.getElementById(divid).style.display == 'none'){
      		document.getElementById(divid).style.display = 'block';
                objeto.src='images/xp/Lminus.gif';
    	}else{
      		document.getElementById(divid).style.display = 'none';
                objeto.src='images/xp/Lplus.gif';
    	}
	}
	catch(err) 
	{ alert('error en toggleDiv '+err.description); };    
        return false;
  }

/*  20070524
	Funcion que solamente indica que la pantalla sufrio un cambio de pantalla,
	que al cerrarse la ventana manda a actualizar a el servidor el size de la pantalla
	Parametro recibido numero de menu
*/
window.Cambiasize = function(idmenu)
{	stickhead(); // esta line va ligado con sortable_otro.js 20070524
        Cambiosize=idmenu; 
        //eventos_servidor("cambio de size",0,"cambiotamano","",idmenu,document.body.clientWidth,document.body.clientHeight);
}

/*    20071029
 *    se cambio para que en vez de utilizar el onchange se utilizar el keyup
 *    para cambiar de mayusculas a minusculas y viceversa ya que el onchange no funciona
 *    cuando se cambia varias veces en la misma session de mayusculas a minusculas
 */  
window.mayusculas = function(objeto,evento)    
{
	if (evento.keyCode=='37' || evento.keyCode=='36' || evento.keyCode=='8' || evento.keyCode=='46' || evento.keyCode=='39')
	{ }
	else
	{   objeto.value=objeto.value.toUpperCase();  return false; }
}

window.minusculas = function(objeto,evento)    
{
	if (evento.keyCode=='37' || evento.keyCode=='36' || evento.keyCode=='8' || evento.keyCode=='46' || evento.keyCode=='39')
	{ }
	else
	{   objeto.value=objeto.value.toLowerCase();  return true; }
}

/*  20070702
    Da un click al boto de seleccionar para que muestre el renglon en los campos de captura
    recibe el nombre del campo
*/        
window.daunClick = function (wlcampo)
{
	try
	{	document.getElementById(wlcampo).click(); }
	catch (err) { return false; };
}

/*  20070702
    Da un click al boto de seleccionar para que muestre el renglon en los campos de captura
    recibe el nombre del campo
*/        
window.desplega = function(si)
{
	si.focus();
}

window.sumatotales = function(idmenu) {
	try
	{
	    var tfoot = '';
		var tabla=document.getElementById('tabdinamica_'+idmenu);
		if (tabla.rows.length>1)
		{
			var renglon=tabla.insertRow(-1);  // firefox
			header=document.getElementById('tabdinamica_'+idmenu).rows[0];
			for( var i=0; i<header.cells.length ; ++i ) {
				if (header.cells[i].id=='totales')
				{
					var x=renglon.insertCell(i);
					x.innerHTML=dametotalcolumna(i);
					x.style.fontWeight="bold";
					x.style.borderTop="thin solid #0000FF";
				}
				else
				{
					var x=renglon.insertCell(i);
					header.cells[i].name=='noimprime' ? x.name='noimprime' : x.name="";
				}
			}
		}  
	}
	catch(err) { alert('error en sumatotales'+err.description); }
}

window.dametotalcolumna = function(colu)
{
	try
	{
		var vart = 0;
		for( var i=1; i<document.getElementById('tabdinamica').rows.length ; ++i ) {
			if (isNaN(document.getElementById('tabdinamica').rows[i].cells[colu].innerHTML)==false)
			{
				vart = vart + Number(document.getElementById('tabdinamica').rows[i].cells[colu].innerHTML);
			}
		}
		return vart;
	}
	catch (err) { alert('error dametotalcolumna'); return 0; }
}

window.quecamponoimprime = function(theFormName,desplega) {

 theForm = document.getElementById(theFormName);
  var qs = '';
  for (e=0;e<theForm.elements.length;e++) {
    if (theForm.elements[e].name!='' && (theForm.elements[e].name.indexOf('_np_')>=0 || theForm.elements[e].name=='noimprime') ){
	   var str=theForm.elements[e].name;
	   var str1=str.replace(/_np_/,"wl_");
	   x=document.getElementById(str1);	    
    	x.style.display=desplega;		
	   str1=str.replace(/_np_/,"wlt_");
	   x=document.getElementById(str1);	    		
		x.style.display=desplega;			   
    }
  }
  
	var all = document.getElementsByTagName("TABLE");
	for( var i=0; i<all.length; ++i ) {
		if( all[i].name=="noimprime" || all[i].name=="tabbotones") {
			all[i].style.display=desplega
		}
	}  
	var all = document.getElementsByTagName("a");
	for( var i=0; i<all.length; ++i ) {
			all[i].style.display=desplega
	}  	
	var all = document.getElementsByTagName("center");
	for( var i=0; i<all.length; ++i ) {
			all[i].style.display=desplega
	}  	
	var all = document.getElementsByTagName("input");
	for( var i=0; i<all.length; ++i ) {
		if( all[i].type=="button" || all[i].name=="botcam" ) {
			all[i].style.display=desplega
		}
	}  			
	
	var all = document.getElementsByTagName("th");
	for( var i=0; i<all.length; ++i ) {
		if( all[i].name=="noimprime") {
			all[i].style.display=desplega
		}
	}
		
	var all = document.getElementsByTagName("td");
	for( var i=0; i<all.length; ++i ) {
		if( all[i].name=="noimprime") {
			all[i].style.display=desplega
		}
				
	}  			
  return true	
	
}

/*  20070707
    Funcion que la impresion se ve en patalla
*/        
window.imprime = function()
{
try
{
	if (top.frames.length==1)
		{ imprime_sinframes(); }
	else { imprime_conframes(); }
}
	catch(e){alert("Fallo la impresion! " + e.message); 		top.document.getElementById('fs').cols=varcols;	}
}

window.imprime_sinframes = function()
{
var OLECMDID = 7; 
try
{
	var PROMPT = 1; // 1 PROMPT & 2 DONT PROMPT USER 
 	var oWebBrowser = document.getElementById("WebBrowser1");
		alert('entro'); 	
	if(oWebBrowser == null)
	{
		quecamponoimprime('formpr','none');
		var sWebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>'; 
		document.body.insertAdjacentHTML('beforeEnd', sWebBrowser); 		
		oWebBrowser = document.getElementById("WebBrowser1");
		oWebBrowser.ExecWB(7,-1);		
		quecamponoimprime('formpr','');
		oWebBrowser.outerHTML='';
	}
}
	catch(e){ alert("Fallo la impresion sinframes! " + e.description );			quecamponoimprime('formpr',''); oWebBrowser.outerHTML='';}	
}

window.imprime_conframes = function()
{
var OLECMDID = 7; 
/* OLECMDID values: 
* 6 - print 
* 7 - print preview 
* 8 - page setup (for printing) 
* 1 - open window 
* 4 - Save As 
* 10 - properties 
*/
try
{
	varcols=top.document.getElementById('fs').cols;
	varrows=top.document.getElementById('fs').rows;			
	var PROMPT = 1; // 1 PROMPT & 2 DONT PROMPT USER 
 	var oWebBrowser = document.getElementById("WebBrowser1");
	if(oWebBrowser == null)
	{
		quecamponoimprime('formpr','none');
		var sWebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>'; 
		if (top.document.getElementById('fs').cols=='25%,*')
		{ top.document.getElementById('fs').cols='0%,100%'; }
		else
		{ top.document.getElementById('fs').rows='0%,100%'; top.document.getElementById('fs').cols=''; 
		}		
		top.frames('derecho').document.body.insertAdjacentHTML('beforeEnd', sWebBrowser); 
		top.frames('derecho').WebBrowser1.ExecWB(OLECMDID,PROMPT);
		quecamponoimprime('formpr','');
		top.frames('derecho').WebBrowser1.outerHTML="";	
		top.document.getElementById('fs').cols=varcols;		
		top.document.getElementById('fs').rows=varrows;				
	}
}
	catch(e){alert("Fallo la impresion conframes! " + e.message); 		top.document.getElementById('fs').cols=varcols;	}	
}

/*
	Funcion que se ejecuta que acualiza el tano de la forma
*/    
window.Cambiatamano = function(idmenu,height,width)
{
		eventos_servidor("cambio de size",0,"cambiotamano","",idmenu,width,height)		;
}    
        
/*  20070524
	Funcion que se ejecuta al cerrar la ventana y lo unico que hace es actualizar el size de la misma
	si esta fue cambiada
*/    
window.Cierraforma = function()
{
	if (Cambiosize!=0)
	{
		eventos_servidor("cambio de size",0,"cambiotamano","",Cambiosize,document.body.clientWidth,document.body.clientHeight)		;
	}
}    

//  quita los espacios del lado izquierdo y derecho de un string
String.prototype.trim = function()
{
   return this.replace(/(^\s*)|(\s*$)/g, "");
}
//pads left
String.prototype.lpad = function(padString, length) {
        var str = this;
    while (str.length < length)
        str = padString + str;
    return str;
}

//pads right
String.prototype.rpad = function(padString, length) {
        var str = this;
    while (str.length < length)
        str = str + padString;
    return str;
}

// para simula el click en ff
if(typeof HTMLElement!='undefined'&&!HTMLElement.prototype.click)
HTMLElement.prototype.click=function(){
var evt = this.ownerDocument.createEvent('MouseEvents');
evt.initMouseEvent('click', true, true, this.ownerDocument.defaultView, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
this.dispatchEvent(evt);
}



//  20070703 se habilito el popmenu y cambio de color del renglon seleccionado
window.muestra_renglon = function (wlrenglon)
{
   	var wlid = 	'cam'+wlrenglon.id.substring(2);
   	try { document.getElementById(wlid).click() } catch (err) { };   	
}

/* funcion que cambia el color del renglon seleccionado
*/
window.color_renglon = function (wlrenglon)
{
   	color_renglon.poneclase(wlrenglon,'todofoco');
  	var wltabladinamica = document.getElementById('tabdinamica_'+wlrenglon.id.split('_')[1]);
   	var wlTRs = wltabladinamica.getElementsByTagName('tr');
  	for (e=0;e<wlTRs.length;e++) {		
		if (wlTRs[e].className=='todofoco' && wlTRs[e].id!=wlrenglon.id)
		{
				color_renglon.poneclase(wlTRs[e],'');
				wlTRs[e].className='';
				break;   			
		}
  	}  	
  	wlrenglon.className='todofoco';   				
}


color_renglon.poneclase= function(wlrenglon,wlclase)
{
   	var siTD = wlrenglon.getElementsByTagName('td');
   	for (ex=0;ex<siTD.length;ex++) {		
			siTD[ex].className=wlclase;
  	}
}

/*
 funcion que muestra el contextmenu en la tabla de capura
 */
window.contextForTABLE = function(objtabla)
{
	var wlTABLE=document.getElementById("tabbotones");
	var siSelect = wlTABLE.getElementsByTagName('TD');
	var wlstr='';
	if (siSelect.length>0)
	{
  		for (e=0;e<siSelect.length;e++) {		
			wlinput=siSelect[e].getElementsByTagName('INPUT');
			if (wlstr!='') { wlstr=wlstr+','; }
                        var ecode=eval(wlinput[0].onclick) + "_";
			wlstr=wlstr+'new ContextItem("'+wlinput[0].value+'",function(){'+quitaf(ecode)+'})';			
  		}
	        if (wlstr!='') { wlstr=wlstr+','; }
                wlstr=wlstr+'new ContextItem("Salir",function() { salir(); })';
  		wlstr=' window.popupoptions = ['+wlstr+']';
                wlstr=wlstr.replace(/\&quot\;/g,'\'');
		eval(wlstr);
   		ContextMenu.display(popupoptions)		

	}
	return false;
}
/*
   muestra el conextmenu en la tabla de los reglones 
  */
window.contextForTR = function (objtr)
{
	var wlTR=document.getElementById(objtr.id);
	var siSelect = wlTR.getElementsByTagName('SELECT');
	var wlstr='';
	if (siSelect.length>0)
	{
  		for (e=0;e<siSelect[0].length;e++) {		
			if (wlstr!='') { wlstr=wlstr+','; }
			wlstr=wlstr+'new ContextItem("'+siSelect[0].options[e].text+'",function(){'+siSelect[0].options[e].value+'})';
  		}
	}
	var siSelect = wlTR.getElementsByTagName('input');
	if (siSelect.length>0)
	{
  		for (e=0;e<siSelect.length;e++) {		
			if (wlstr!='') { wlstr=wlstr+','; }
                        var ecode=eval(siSelect[e].onclick) + "_";
                        if (siSelect[e].title!='')
			{ wlstr=wlstr+'new ContextItem("'+siSelect[e].title+'",function(){'+quitaf(ecode)+'})'; }
                        else
			{ wlstr=wlstr+'new ContextItem("'+siSelect[e].value+'",function(){'+quitaf(ecode)+'})'; }
  		}
	}
	if (wlstr!='') { wlstr=wlstr+','; }
        wlstr=wlstr+'new ContextItem("Salir",function() { salir(); })';
        wlstr='popupoptions = ['+wlstr+']';
        wlstr=wlstr.replace(/\&quot\;/g,'\'');
        eval(wlstr);
        color_renglon(wlTR);
        ContextMenu.display(popupoptions)		
        var siTD = objtr.getElementsByTagName('TD');
	return false;
}
//  20070703 se habilito el popmenu y cambio de color del renglon seleccionado


window.seguridad = function(campo)
{
		return false;
}

/**				//20070215
  * abre una ventana donde solicita la descripcion de un nuevo registro //20070215
  * @param idmenu  numero //20070215
  * @nombre attnum numero de campo //20070215
  * @fuente_nspname  schema de la fuente //20080115
  * @altaautomatico_idmenu  numero de menu que se abre para dar de alta un registro  //20080115
  * @fuente_campodep   campo dependiente por el cual se selecciona el campo que se acaba de dar de alta
  * @obj  objeto que mando a ejecutar esta funcion
  **/ //20070215
window.altaautomatico = function (idmenu,attnum,dato,fuente,fuente_campodes,fuente_nspname,altaautomatico_idmenu,fuente_campodep,fuente_campofil,obj) //20070215
{ //20070215
try {
	var vfcf="";
	if (fuente_campofil!="")
	   if (document.getElementByID("wl_"+fuente_campofil).value=="")
	   {
	       alert("Primero debe seleccionar el dato de "+document.getElementByID("wlt_"+fuente_campofil).value);
	       return false;
           }
	     
	try { vfcf=	document.getElementByID("wl_"+fuente_campofil).value; } catch(err) { vfcf=''; } ;


	if (altaautomatico_idmenu=="" || altaautomatico_idmenu=="0")
 	{	
                dapi=document.getElementById("altaautomatica_");
                if (dapi!=undefined || dapi!=null)
                { obj.parentNode.removeChild(dapi); return }
	 	//  regresa la descripcion de la alta automatica
                var aa = new altaautomatica();
                obj.parentNode.appendChild(aa.create());
                aa.focus();
                dapi=document.getElementById("altaautomatica_");
                aa.change = function () { des=aa.valor(); 
		                          if (des!='' && des!=null && des!='TECLEE AQUI UNA NUEVA OPCION' && des.trim()!='Teclee aqui una nueva opcion') { 
        	                            wlurl='src/php/xmlhttp.php'
        	                            passData='&opcion=altaautomatico&idmenu='+idmenu+'&attnum='+attnum+"&dato="+dato+"&fuente="+fuente+"&fuente_campodes="+
        	                                    fuente_campodes+"&des="+des+"&fuente_nspname="+fuente_nspname+"&fuente_campofil="+fuente_campofil+
                                                    "&valorfuente_campofil="+vfcf;        
	    	                            CargaXMLDoc();			
    	                                  }	 	
                                          obj.parentNode.removeChild(dapi) ;
                                        }
	}
 	else
 	{	
                //var url='man_menus.php?idmenu='+altaautomatico_idmenu+"&fuente_campofil="+fuente_campofil+"&valorfuente_campofil="+vfcf;
                //var url='man_menus.php?idmenu='+altaautomatico_idmenu+"&filtro="+fuente_campofil+vfcf;
                var url='man_menus.php?idmenu='+altaautomatico_idmenu+(vfcf!='' ? "&filtro="+fuente_campofil+"="+vfcf : "");
                _aa_=dhtmlmodal.open("altaautomatico", "iframe", url, "Alta de una opcion", "width=590px,height=450px,center=1,resize=1,scrolling=0", "recal")
                _aa_.close = function (iden) 
                    {
                      //iden=_aa_.regresa(url);
                      if (iden!='' && iden!=null)
                      {
                         wlurl='src/php/xmlhttp.php'
                         passData='&opcion=buscaaltaautomatico&idmenu='+idmenu+'&attnum='+attnum+"&dato="+dato+"&fuente="+fuente+"&fuente_campodes="+fuente_campodes+"&iden="+iden+"&fuente_nspname="+fuente_nspname+"&fuente_campodep="+fuente_campodep;
                         CargaXMLDoc();
                      }
                      _aa_.hide();
                      return true;
                    } 

 	} 	
    } catch(err) { alert('error en altaautomatico '+err.description); };

} //20070215

window.validafecha = function(wlcampos)
{
		var v = new valcomunes();
		v.valfecha(wlcampos);
}
window.validaEmail = function(wlcampos)
{
                var v = new valcomunes();
                return v.validarEmail(wlcampos);
}
window.validahora = function(wlcampos)
{
                var v = new valcomunes();
                v.valhora(wlcampos);
}

window.despleid = function()
{
var str='';
var listitems= document.getElementsByTagName("div")
for (i=0; i<listitems.length; i++)
{  str= str + 'div ' + i + ' id='+listitems[i].id + ' name=' + listitems[i].name + '\n'; }
return str;
}

window.muestrafecha = function(wlcampos)
{
	try {
	 var wlnombre=wlcampos.name.replace(/fe_/,"wl_");
         x=document.getElementsByName(wlnombre)[0]; //firefox
         dapi=document.getElementById('datePicker_');
         if (dapi!=undefined || dapi!=null)
         { x.parentNode.removeChild(dapi); return }
         var d = new Date();
         if (x.value=='')
         { var dp = new DatePicker(d); } else { 
                 d.setFullYear(x.value.substring(0,4),x.value.substring(5,7)-1,x.value.substring(8,10)); 
                 var dp = new DatePicker(d); }
	 x.parentNode.appendChild(dp.create()); 
         dapi=document.getElementById('datePicker_');
	 dp.onchange = function vales() { x.value = dp.getDate().getFullYear()+'-'+((dp.getDate().getMonth()<9) ? '0' + (dp.getDate().getMonth()+1) : (dp.getDate().getMonth()+1)) +'-'+((dp.getDate().getDate()<10) ? "0"+dp.getDate().getDate():dp.getDate().getDate()); return x.parentNode.removeChild(dapi);};
	} catch(err) { alert('error en muestrafecha '+err.description); };
}

/** 
  *   20070301 Abre una ventana para solicita un texto
  *   @param objecto  objeto del campo
  */
window.muestratexto = function(wlcampos)
{
	var wlnombre=wlcampos.name.replace(/txt_/,"wl_");
        x=document.getElementsByName(wlnombre)[0];
 	var v = showModalDialog('pidetexto.php?valor='+escape(x.value),12,11);		
	try { 
		if (x.readonly!=true && v!=undefined)
		{	x.value=v; }
		}
	catch(err) 
	{ alert('error en muestrafecha '+err.description); };
}	

/// 
//   20070618 Abre una ventana para solicita un dato de busqueda en campos select donde son demasiados
//  parametros wlselect, select sobre el cual se va a generar el campo select del html
//  wlfiltropadre, campos sobres el cual se va hacer el filtro para mostrar los datos
//  wlfiltrohijo,  campo hijo , el valor de la opcion en el select
//  fuentewhere, where sobre el fuente sobre todo para mostrar las opciones que aun no han sido seleccionadas   
//  fuenteevento, el evento donde se va a llenar el campo select 0=carga, 1=cambia el registro padre, 2=on focus, 3=on focus solo la primera vez
//  20070616 sololimite,  0=indica que no  1= si  sololimite quiere decir que en las opciones solo mostro el limite para no   
//  20070616               saturar el browser
//  20080117    fuente_busqueda_idmenu   numero de menu a mostrar para buscar informacion
window.pidebusqueda = function(wlselect,wlfiltropadre,wlfiltrohijo,fuentewhere,fuenteevento,sololimite,fuente_busqueda_idmenu)
{
	try 
	{ 
		if (fuente_busqueda_idmenu=="0" || fuente_busqueda_idmenu=="")
		{
 			var v = showModalDialog('pidebusqueda.php',400,100,'Solicita datos de busqueda');
    		        if (v!='' && v!=null) 
  			{ 
	   			var wlcampo=wlselect.substring(8,wlselect.indexOf(","));	  	
       			        wlcampo=wlcampo+' like \''+v+'%\'';
	   			pon_Select(wlselect,wlfiltropadre,wlfiltrohijo,fuentewhere+wlcampo,fuenteevento,1)			
    		        }
		}
		else
		{
	 		// regresa la identificacion de la alta de un registro
	 		var iden = showModalDialog('man_menus.php?idmenu='+fuente_busqueda_idmenu,400,400,'Solicita datos de busqueda'); 
                        iden.close = function (llave) 
                        {
	 		   if (llave!=undefined)
	   		   { pon_Select(wlselect,wlfiltropadre,wlfiltrohijo,fuentewhere+(fuentewhere=='' ? ' ' : ' and ')+llave,fuenteevento,1); }
                           iden.hide();
                        }

		}
	}
	catch(err) 
	{ alert('error en pidebusqueda '+err.description); };
    return false;
}	
	
/** 
  *   20070301 Muestra el menu que sube un archivo
  *   @param objecto  objeto del campo
  */
window.subearchivo = function(obj)
{
	try 
	{ 	
		var wlnombre=obj.name.replace(/upl_/,"wl_");
		var wlnombreh=obj.name.replace(/upl_/,"uplh_");
                dapi=document.getElementById("altaadjuntara_");
                if (dapi!=undefined || dapi!=null)
                { obj.parentNode.removeChild(dapi); return }
                aa = new altaadjuntara();
                obj.parentNode.appendChild(aa.create());
                dapi=document.getElementById("altaadjuntara_");
                aa.change = function () { des=aa.valor();
	                            	  if (aa.avance().indexOf('Transmitio')>=0)
		                          {	
                                               x=des.split(';');
			                       alert('El archivo se adjunto de forma exitosa con el nombre: '+x[1]); 
			                       obj.abbr=x[0];
			                       document.getElementsByName(wlnombre)[0].value=x[0];
			                       document.getElementsByName(wlnombreh)[0].value=x[1];
		                          } else { document.getElementsByName(wlnombre)[0].value=aa.avance(); }
                                          obj.parentNode.removeChild(dapi) ;
                                        }
                aa.dclick();
	}
	catch(err) 
	{ alert('error en subearchivo '+err.description); 
	};	
}
/* sube como archivo lo del clipboard */
window.subeclb= function(wlcampos)
{
	try 
	{ 	
		var wlnombre=wlcampos.name.replace(/clb_/,"wl_");
		var v = showModalDialog('subeclb.php',45,30,'Sube a archivo lo que esta en memoria');				
		if (v!='' && v!=null && v!=undefined)
			{	
				alert('El archivo se adjunto de forma exitosa con el nombre: '+v); 
				document.getElementById(wlcampos.name).abbr=v;
				document.getElementById(wlnombre).value=v;				
			}
	}
	catch(err) 
	{ alert('error en subearchivo '+err.description); 
	};	
}
window.muestra_image= function(imagen)
{
	alert('debe de mostrar image'+imagen);
}

// esta funcion abre una subvista
// recibe la hoja a abrir, y los campos de la hoja
// evento a ejecutar antes de abrir la subvista
// evento a ejecutar despues de abrir la subvista
window.abre_subvista = function(wlhoja,wlcampos,wleventoantes,wleventodespues,idmenu,wldialogWidth,wldialogHeight,wltitulo)
{
	try
	{
                wlfiltro="";
		if (wleventoantes!="")
		{
			eventos_servidor(wlhoja,wlcampos,wleventoantes,wleventodespues,idmenu,wldialogWidth,wldialogHeight)
		}
		else
		{
	    		if (wldialogHeight!=0 || wldialogWidth!=0)
	    	        {  
                                campos=wlcampos.split('&');
                                for (var x in campos) {
                                     //console.log('campos='+campos[x]);
                                     if (campos[x].indexOf('filtro')>=0) {
                                        wlfiltro='&'+campos[x];
                                     }
                                }
                                muestra_vista(idmenu,'modal-body',wlfiltro,wltitulo);
                                $('#msgModal').modal();
                                setTimeout(function (){
                                       forma = $('#formpr_' + idmenu)[0];
                                       pone_focus_forma(forma);
                                }, 1000);

	                }
		        else
		        {
		    	        wlurl=wlhoja+'?'+wlcampos;		
			        _aa_=showModalDialog(wlurl,100,300,'');			
                                _aa_.onclose=function() {
                                       Cierraforma(); 
                                       return true;
                                 }
			}
		}
	}
	catch(err)
	{
		alert('error en abre_subvista'+err.description+wlurl);
	}
}	

//  ejecuta eventos en el servidor de funciones especificas de la aplicacion del usuario
window.eventos_servidor = function (wlhoja,wlcampos,wleventoantes,wleventodespues,idmenu,wldialogWidth,wldialogHeight)	
{
        wlurl='eventos_servidor.php';
        passData='&opcion='+wleventoantes+'&wlhoja='+                
        		wlhoja+'&wlcampos='+escape(wlcampos)+buildQueryString('formpr')+
        		'&wldialogWidth='+wldialogWidth+'&wldialogHeight='+wldialogHeight+'&idmenu='+idmenu+"&filtro="+escape(armaFiltro('formpr'));  //20070524
        CargaXMLDoc();
}

//  ejecuta eventos en el servidor de funciones especificas de la aplicacion del usuario
window.comandos_servidor = function(wlhoja,wlfuncion,idmenu)	
{
                if (typeof(idmenu)!="object") {
                   forma=$("#formpr_"+idmenu)[0];
                }

        	if (checaobligatorios(forma)==false)	
        	{
           		return;
			}           		

        	if (checanumericos(forma)==false)	
        	{
           		return;
			}           		
        	if (checafechas(forma)==false)	
        	{
           		return;
			}           		

        wlurl=wlhoja  //20071105
        passData='&opcion='+wlfuncion+'&wlhoja='+
        		wlhoja+buildQueryString(forma)+"&filtro="+escape(armaFiltro(forma));
        CargaXMLDoc();
}
	
//  funcion que checa si en el cambio que boton se tecleo para mostrar los datos en los campos de captura
//  recibe el menu o vista sobre el cual va a dar manetenimiento
//  el movimiento que va a efectuar i=insert,d=delete,u=update
//  la llave con la que va a dara de baja o cambio
//  el renglon que va a dar de baja de la tabla
//  el evento para saber que boton fue tecleado del mouse
//  el numero de renglon de la tablas
//  cantidad de columnas en el renglon
window.que_cambio = function(wlmenu,wlmovto,wlllave,wlrenglon,event,nr,nc)
{

			if (event.button==1)
	{
		mantto_tabla(wlmenu,"u",wlllave,wlrenglon);
	}
	else
	{
		muestra_cambio("formpr",nr,nc);
	}
	
}
	
	
	
// esta funcion ejecuta una consulta
// recibe la hoja a abrir, y los campos de la hoja
window.abre_consulta = function(idvista) {
    if (hayalgundatotecleadobus('formpr')!='si')
    {
          alert ('no ha tecleado ningun dato permitido para buscar\n'+'Los datos con asterisco son donde se permiten la busqueda'); return;
    }	
    theForm = document.getElementById('formpr');        //20071107
    filtro=document.createElement("<input>");    //20071107
    filtro.value=idvista;	//20071107
    filtro.id='_idmenu_'; //20071107
    filtro.name='_idmenu_';    //20071107
    theForm.appendChild(filtro); //20071107
    armaFiltro('formpr'); //20071107
    theForm.submit(); //20071107
}	
//  funcion que muestra el registro 2 de la tabla en los campos de pantalla
//  cuando esto sea por medio de una subvista
window.hayunregistro = function(idmenu)
{
                tabla=document.getElementById('tabdinamica_'+idmenu);
		if (tabla!=undefined)
		{
                        if(tabla.rows.length>=2)
                        {
                                try { tabla.style.visibility='visible';        } catch (err) { } ;
                        }
			if(tabla.rows.length==2)
			{
				try { document.getElementById('cam0_'+idmenu).click();	} catch (err) { } ;
			}
		}			
}		

window.pone_focus_formaID = function (idmenu) {
   pone_focus_forma($("#formpr_"+idmenu)[0]);
}

//   pone el focus en el primer campo de la forma		
window.pone_focus_forma = function (theForm='',dedonde)
{
  if (theForm=='') {
     if ('window' in dedonde) {
        return;
     }
     theForm=$(dedonde).closest('form');
  }
  var ele='';
  try 
  {
	  //theForm = document.getElementById(theFormName);	
	  for (e=0;e<theForm.elements.length;e++)
  		{
                        ele=theForm.elements[e];
   			if (ele.name!='' && ele.type!='hidden' && 
   		    	ele.type!='button' && ele.type!='reset'
   		    	&& ele.readOnly!=true
   		    	&& ele.disabled!=true
                        )
   		        {
		   		ele.focus();
		   		//ele.className='foco';
		   		return true;
   			}
		}	
	}
	catch(err)
	{
                alert('error en pone_focus_forma en el campo '+ele.name+' '+err.message);
	}
}
	

// esta funcion arma el querystring
// la copie de utility.js
window.armaFiltro = function(theForm) {
  try {
  var qs = '';
  var tipo = '' ;
   for (e=0;e<theForm.elements.length;e++) {
   if ('busqueda' in theForm.elements[e].dataset) {
	var x=theForm.elements[e];
    	if (x.value!='') {     
           if ('numerico' in theForm.elements[e].dataset) { tipo=0 } else { tipo=2 }
	    	if (tipo==2)
      		{ 
	      		qs+=(qs=='')?' ':' and ';
			if (x.value.indexOf('%')>=0) {
	      		   qs+=x.name.split('__')[0].substring(3)+' like \''+x.value+"'";	      		
			} else
			{
	      		    qs+=x.name.split('__')[0].substring(3)+'=\''+x.value+"'"; //   20071107
			}
	      	}
       }
    }
    }
    return qs;
    } catch (err) { alert('error armaFiltro='+err); }
}	
// funcion que pasa los datos de la forma padre a la forma hijo
// siempre y cuando el nombre de los campos padre se igual a los nombre de los campos hijos
window.fijos = function (theForm)
{
	try
	{
  var qs = '';
  for (e=0;e<theForm.elements.length;e++)
  {
    if (theForm.elements[e].name!='' && theForm.elements[e].name.indexOf('wl_')>=0  )
    {
		if (theForm.elements[e].type=='select-one')
		{
			try
			{
				switch(document.getElementById(theForm.elements[e].name).type)
				{
				case 'select-one':
					var opciones=document.getElementById(theForm.elements[e].name);
					break;
				case 'text':
					document.getElementById(theForm.elements[e].name).value=theForm.elements[e].value;				
					break;
				case 'textarea':
					document.getElementById(theForm.elements[e].name).value=theForm.elements[e].value;				
					break;					
				}
			}
			catch(err)
			{
			}	

		}
		if (theForm.elements[e].type=='text' || theForm.elements[e].type=='textarea')		
		{
			try
			{
				document.getElementById(theForm.elements[e].name).value=theForm.elements[e].value;
			}
			catch(err)
			{ }
		}
    }
}

  }
catch (err)
{ //alert('error fijos'+err.description); 
}  
  return qs
}
	

// esta funcion arma el querystring
// la copie de utility.js
window.buildQueryString = function(theForm) {
  var qs = '';
  for (e=0;e<theForm.elements.length;e++) {
    if (theForm.elements[e].name!='') {
      qs+=(qs=='')?'&':'&'
      /* se hace el split por __ ya que despues de estos caracteres esta el numero de menu */
      qs+=escape(theForm.elements[e].name.split('__')[0])+'='+escape(theForm.elements[e].value)
      }
    }
  return qs
}
/* 20070710  funcion que regresa el onclick de un td 
				esto para armar el oncontextmenu de un popup menu
*/
window.dame_onclick = function(wlonclick)
{
	try {
		var wltextoi=wlonclick.substring(wlonclick.indexOf('onclick')+9);
		var s=wlonclick.substring(wlonclick.indexOf('onclick')+8,wlonclick.indexOf('onclick')+9);
		var wltextof=wltextoi.substring(0,wltextoi.indexOf(s));		
		return wltextof;
	} catch (err) { 
			alert('error dame_onclick'+err.description);
		};	
}
///**********************************   20061102
///  funcion que el camba el onclick
window.cambia_onclick = function(wlonclick,idmenu)
{

	try {
		var obj=document.getElementById("iCambio_"+idmenu);
                if (obj.className=='hidden') { obj.className='visible'; } 
                str=' obj.onclick = function () { ' + wlonclick + ' }';
                eval(str);
	} catch (err) { 
		};
}

//   pone a las imagenes unchecked, excepto cuando fue seleccionado un renglon
//   parametros pasados el nombre de la format
//				wlrenglon el numero de renglon que fue seleccionado
window.pone_unchecked=function(wlrenglon)
{
  try 
  {
	  var theForm = document.getElementsByName('botcam');	
	  
	  for (e=0;e<theForm.length;e++)
  		{
   			if (theForm[e].id.substring(3)!=wlrenglon )
   		    {
			   	theForm[e].src='img/icon_enabled_checkbox_unchecked.gif';
   			}
   			else
   			{
			   	theForm[e].src='img/icon_enabled_checkbox_checked.gif';	   			
   			}
		}	
	}
	catch(err)
	{
		alert('error en pone_unckecked');
	}	

}




// funcion que muestra un registro en el broseo en los campos de captura
// la funcion recibe el nombre de la forma, el renglon y la cantidad de columnas que contiene el renglon
// y tambien la llave del registro que va a actualizar si es que hay cambio
// el menu o tabla que va a cambiar
// evento antes de ejecutar
// evento despues de ejecutar
// movimiento que disparo el muestra_cambio u=update de registro,s=subvista,f=funcion,u1=no se (parace que es update)
// 20071113  se agrego los eventos antes que hay que ejecutar antes de insertar, select,update o delete en el cliente
// 20071113 function muestra_cambio(theFormName,r,ct,wlllave,menu,wleventoantes,wleventodespues,movto) {
window.muestra_cambio = function(theFormName,r,ct,wlllave,menu,wleventoantes,wleventodespues,wleventoantescl,wleventodespuescl,movto,noconfirmamovtos) {	
  // pone el dato de img listo para efectuar el cambio

  if (movto=='B')  //Opcion de busqueda para que funcione esto debe estar definido una campo llave
	{
           var docx=window.parent.document;
           var bus=docx.getElementById("Solicita datos de busqueda");
           bus.close(wlllave)
           return;
       	}    
  glr=r;
  var wlcambio="\\\"";
  wlllave=wlllave.replace(/"/g,wlcambio);
  
  pone_unchecked(r);
  wlonclick="mantto_tabla(\""+menu+"\",\"u\",\""+wlllave+"\","+(r)+",\""+wleventoantes+"\",\""+wleventodespues+"\",\""+wleventoantescl+"\",\""+wleventodespuescl+"\",\""+noconfirmamovtos+"\");return false;";
  cambia_onclick(wlonclick,menu);


  for (e=0;e<ct;e++) {
	  var el="r"+r+"c"+e; // renglon columna que se muestra en la pantalla de captura
	  var elm="cc"+e;   //  campos de la pantalla de captura
		try {
                        var captu=document.getElementById(elm+'_'+menu);
                        var str=captu.name;
                        if ("cambiarencambios" in captu.dataset) {
                            try { captu.readOnly=true; captu.readOnly=true; captu.disabled=true; } catch (err) { };
                        }
                        xelm=document.getElementById(elm+'_'+menu);
                        xel=document.getElementById(el+'_'+menu);
                        if (xelm.type=='text' || xelm.type=='textarea' || xelm.type=='number' || xelm.type=='email' || xelm.type=='tel')
                        {
                                var captu=document.getElementById(elm+'_'+menu);
                                captu.value=document.getElementById(el+'_'+menu).innerText.trim();
                                if(document.getElementById(el+'_'+menu).firstChild.outerHTML.indexOf('<a')>=0 || document.getElementById(el+'_'+menu).firstChild.outerHTML.indexOf('<A')>=0)
                                {
                                   if(document.getElementById(captu.name+"_borrar_"+menu))
                                   {
                                      var ab=document.getElementById(captu.name+"_borrar_"+menu);
                                      ab.parentNode.removeChild(ab);
                                   }
                                   if(captu.value!="")
                                   {
                                      wlele=document.createElement("a");
                                      wlele.setAttribute("id", captu.name+"_borrar_"+menu);
                                      wlele.setAttribute("name", captu.name+"_borrar_"+menu);
                                      wlele.setAttribute("onclick", quitaf(document.getElementById(el+'_'+menu).firstChild.onclick + "_"));
                                      wlele.innerHTML="Ver documento";
                                      captu.parentNode.appendChild(wlele);
                                   }
                                }
                        }
	  		if (xelm.type=='select-one')
	  		{ 
					document.getElementById(elm+'_'+menu).value=busca_ValorOption(document.getElementById(elm+'_'+menu),document.getElementById(el+'_'+menu).innerText,1,document.getElementById(el+'_'+menu).abbr); 
		  		}
	  		if (xelm.type=='checkbox')
	  		{ 
		  		document.getElementById(elm+'_'+menu).value=valor_checkbox_cap(el+'_'+menu,elm+'_'+menu); 
		  	}	
				var captu=document.getElementById(elm+'_'+menu);		  	
	   			var str=captu.name;
	   			var str1=str.replace(/wl_/,"nc_");		  		
                                if ("cambiarencambios" in captu.dataset) {
                                   try { captu.readOnly=true; captu.readOnly=true; captu.disabled=true; } catch (err) { };
                                }
	  	}
  		catch(err)
  		{
  		}
    }
    forma=$('#'+theFormName+'_'+menu)[0];
    pone_focus_forma(forma);

	wlTR=document.getElementById('tr'+r+'_'+menu);    
	color_renglon(wlTR);
	muevea1renglon(r,menu);   //20070808  checar porque parece que esta chafeando esta rutina
}
/*  funcion que mueve el renglon seleccionado a el renglon 1 
     recib el numero de renglon*/
window.muevea1renglon = function(r,menu)
{
	wlTR=document.getElementById('tr'+r+'_'+menu);    	
	var b = document.getElementById('tabdinamica_'+menu).insertRow(1);
   	var wlTDs = wlTR.getElementsByTagName('TD');  	
  	for (e=0;e<wlTDs.length;e++) {		
					wlele=document.createElement("td");   //  al td le quite <td> ya que tronada ff
					wlele.innerHTML=wlTDs[e].innerHTML;
					wlele.className=wlTDs[e].className;
					wlele.id=wlTDs[e].id;					
					wlele.abbr=wlTDs[e].abbr;	//20070815 falta esta linea provocaba undefined en los campos select
					b.appendChild(wlele);					
  	}  		
  	wlid=wlTR.id;
  	wlclassName=wlTR.className;
	b.ondblclick= wlTR.ondblclick;
	b.oncontextmenu= wlTR.oncontextmenu;	
  	var rr=r+1;
	var wl=document.getElementById('tr'+r+'_'+menu).rowIndex;
        document.getElementById('tabdinamica_'+menu).deleteRow(wl);  	
        b.id=wlid;
	b.className=wlclassName;	
}

// de acuerdo al valor de la fila pone checked o unchecked el campo de captura
window.valor_checkbox_cap = function(el,elm)
{
	if(document.getElementById(el).innerText=='t') 
	{   
		document.getElementById(elm).checked=true;
		return 't'; 
	} 
	else { 
		document.getElementById(elm).checked=false;		
		return 'f'; 
		}; 	
}
//   pone el valor de un combo box si checked le pone t si es unchecked le pone f
window.ponvalor_cb = function(cb)
{
	if (cb.checked==true)
	{ cb.value='t'; }
	else
	{ cb.value='f'; }	
}
//   busca el valor de una opcion de acuerdo a un texto
//   recibe opcines, que es el objeto select
//   recibe el texto que va a buscar en el objeto opciones
//   recibe wlalta que indica si no existe el texto en el objeto limpia el objeto y lo da de alta
//           wlalta debe vale 1 para darlo de alta
//   recib wlvalor , que es el valor del texto en el select
window.busca_ValorOption = function(opciones,wltexto,wlalta,wlvalor)
{
	try 
	{
		if (wltexto!="")
		{	  	
	  		for (ee=0;ee<opciones.length;ee++)
	  		{
				if(opciones.options[ee].text==wltexto)
				{
				     //   alert('si encontro');
					return opciones.options[ee].value;
				}
			}
			if (wlalta==1)
			{
	  			if (opciones.length>0	)
	    			  { clearSelect(opciones); }   // si llega a esta instancia no encontro el dato por que lo se supones que es un select que depende de otro
						               // cuando un cambio se ha mostrado puede ser que ya existan
						               // algunos valor en el select por que decidi limpiar este dato
						// 20070810  se modifico para que agregue la opcion selecciones opcion que que funcione el boton limpiar						               
        		        appendToSelect(opciones, wlvalor, document.createTextNode(wltexto)) // 20070810
        		        appendToSelect(opciones, '', document.createTextNode("Selecciona una Opci\u00f3n"),2)      // 20070810  		        
        		        opciones.selectedIndex=0;
        		        return wlvalor;
    		        }
			return -1;
		}        	
		else
		{ return ""; }
	}
	catch(err)
	{
		alert('error en busca_ValorOption '+err.description);
	}
        
}

//   busca la descripcion  de una opcion de acuerdo al valor de la opcion
window.busca_DesOption = function(opciones,wlvalue)
{
	  for (ee=0;ee<opciones.length;ee++) {
			if(opciones.options[ee].value==wlvalue)
			{
				return opciones.options[ee].text;
			}
		}
		return 0;
}

// funcion que checa si hubo algun dato tecleado de los datos de busqueda
window.hayalgundatotecleadobus = function(theForm) {
try {
  //theForm = document.getElementById(theFormName);
  var qs = '';
  for (e=0;e<theForm.elements.length;e++) {
    if (theForm.elements[e].name!='' && theForm.elements[e].name.indexOf('bu_')>=0) {
	   var str=theForm.elements[e].name;
	   var str1=str.replace(/bu_/,"wl_");
		x=document.getElementsByName(str1);
       if (x.value!='' && x.type!='button' && x.type!='hidden' && x.type!='reset' ) {
	      qs='si';
       }
    }
  }
  return qs
} catch (err) { alert('error hayalgundatotecleadobus'+err.message); }

}


// funcion que checa si hubo algun dato tecleado
window.hayalgundatotecleado = function(theForm) {
  ////theForm = document.getElementById(theFormName);
  var qs = '';
  for (e=0;e<theForm.elements.length;e++) {
    if (theForm.elements[e].name!='') {
       if (theForm.elements[e].value!='' && theForm.elements[e].type!='button' && theForm.elements[e].type!='hidden' && theForm.elements[e].type!='reset') {
          qs='si';
       }
    }
  }
  return qs
}

// funcion que checa que existan datos tecleados en los campos obligatorios
window.checaobligatorios = function(theForm) {
	try
	{	
  var qs = '';
    for (e=0;e<theForm.elements.length;e++) {
    if ('obligatorio' in theForm.elements[e].dataset) {
       x=theForm.elements[e];
       if (trim(x.value)=='' ) {
          var str1=x.name.replace(/wl_/,"wlt_");
          alert ('El dato "'+$('#'+str1)[0].innerHTML+'" es obligatorio ');
          x.focus();
          return false;
       }
    }
  }
    return true
}
catch(err)
{ alert('error checaobligatorios='+err+' e='+e+' elementos='+theForm.elements.length+' name='+str1); }
}

// funcion que checa que sean numericos los campos que deben ser numericos
window.checanumericos = function(theForm) {
  //theForm = document.getElementById(theFormName);
  var qs = '';
  for (e=0;e<theForm.elements.length;e++) {
    if (theForm.elements[e].name!='' && ('numerico' in theForm.elements[e].dataset)) {
	    x=theForm.elements[e];	    
	    var vd = new valcomunes();
	    vd.ponnumero(x)
	    if (vd.esnumerico()==false)
	    {   x.focus(); return false; }
    }
  }
  return true
}

// funcion que checa las fechas de los campos 
window.checafechas = function(theForm) {
	try
	{
  //theForm = document.getElementById(theFormName);
  var qs = '';
  for (e=0;e<theForm.elements.length;e++) {
    if (theForm.elements[e].name!='' && theForm.elements[e].name.indexOf('_da_')>=0) {
	   var str=theForm.elements[e].name;
	   var str1=str.replace(/_da_/,"wl_");
	   x=document.getElementsByName(str1)[0];	    
		if (x.outerHTML.indexOf('readOnly')==-1)  // valida siempre y cuando no sea readonly
		{
		   if (x.value!='')   // 20050227
		   {  // 20050227
	    		var vd = new valcomunes();
		    	if (vd.valfecha(x)==false)
	    		{   return false; }
    		} // 20050227
    		else { 	return true; } // 20050227
		}    		
    }
  }
  return true
}
catch (err) { alert('error checafechas'+err.message); }
}


// 20070804 Funcion que ejecuta un evento
//          recibe el objeto que lo disparo 
//          y la funcion a ejecutar
window.eventosparticulares = function(x,evento)
{
	try
	{
	   if (evento.value!='')
	   {
		   codigo="	var vd = new eve_particulares();  if (vd."+evento+"(x)==false)	{   regreso=false;  	}  	else { 	regreso=true; } ";
		   eval(codigo);
		   if (regreso==false) { if(x!=null) {x.focus();};  return false;}
	   }		   
	}
	catch(err)
	{ alert('error eventosparticulares '+err.message+' en evento='+evento); return false; }
	  return true
}

// funcion que checa las fechas de los campos 
window.checaparticulares = function(theForm) {
	try
	{
  //theForm = document.getElementById(theFormName);
  var qs = '';

  for (e=0;e<theForm.elements.length;e++)
  {
    if (theForm.elements[e].name!='' && theForm.elements[e].name.indexOf('_vp_')>=0)
    {

	   var validacion=theForm.elements[e].value;
	   var regreso=false; 
	   var str=theForm.elements[e].name;
	   var str1=str.replace(/_vp_/,"wl_");
	   x=document.getElementById(str1);	    
	   if (x.value!='')
	   {
		   codigo="	var vd = new val_particulares();  if (vd."+validacion+"(x)==false)	{   regreso=false;  	}  	else { 	regreso=true; } ";
		   eval(codigo);
		   if (regreso==false) { x.focus();return false;}
	   }		   
    }
  }
  return true
} catch(err) { alert('error checaparticulares'+err.message); return false; }
}


window.CargaXMLDoc = function() 
{
	try
	{
       if (window.ActiveXObject)
       {
        	isIE = true;
         	req = new ActiveXObject("Msxml2.XMLHTTP");         	
        	if (req)
        	{
            	req.onreadystatechange = querespuesta;
            	req.open("POST", wlurl, false);  // sincrona
                req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");                   	
            	req.send(passData);
        	}
		}        	
		else
		{
    		if (window.XMLHttpRequest) 
    		{
        		req = new XMLHttpRequest();
        		req.open("POST", wlurl, false);  // sincrona
                        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=ISO-8859-1");
                        req.onerror = function () { alert('error'); };
        		req.send(passData);
        		querespuesta();
    		}
    	}
	}
	catch(err)
	{
		alert('error en CargaXMLDoc'+err.description+' wlurl'+wlurl+' '+passData);
	}
}
//  funcion que sirve para poner los datos en un campo select
//  parametros wlselect, select sobre el cual se va a generar el campo select del html
//  wlfiltropadre, campos sobres el cual se va hacer el filtro para mostrar los datos
//  wlfiltrohijo,  campo hijo , el valor de la opcion en el select
//  fuentewhere, where sobre el fuente sobre todo para mostrar las opciones que aun no han sido seleccionadas   
//  fuenteevento, el evento donde se va a llenar el campo select 0=carga, 1=cambia el registro padre, 2=on focus, 3=on focus solo la primera vez
//  20070616 sololimite,  0=indica que no  1= si  sololimite quiere decir que en las opciones solo mostro el limite para no   
//  20070616               saturar el browser
window.pon_Select = function(wlselect,wlfiltropadre,wlfiltrohijo,fuentewhere,fuenteevento,sololimite)
{
	// si ya esta lleno el select y el evento es 3 onfocus solo la primiera vez se sale
	// para no volver a llenar el campo select
	if (fuenteevento==3 && document.getElementsByName("wl_"+wlfiltrohijo)[0].length>=2 && sololimite==0)	
	{  return; }
	var wlvarios="";
	var wlwhere="";
	var wlcomi="";
	try
	{
	  if (wlfiltropadre!='')  // 20070615 Tronaba cuando no traia filtro padre
	  { // 20070615 Tronaba cuando no traia filtro padre
	  		var a = wlfiltropadre.split(',');

	  		for (m=0;m<a.length;m++)
	  		{	
		  		var valor="";
		  		try { valor=document.getElementsByName("au_"+a[m])[0].value } catch (err) { valor=""; }
		  		if (valor=="") { try { valor=document.getElementsByName("wl_"+a[m])[0].value } catch (err) { valor=""; } }	  		
				if(valor!='')
				{
					//  si existe un elemento que sea nu_ es numerico en caso es un string y debe de llevar comillas
					try { if(document.getElementsByName("nu_"+a[m])[0].name!='') { wlcomi=""; } else { wlcomi=""; } } catch (err) { wlcomi="'"; }
					if (wlvarios=="")
					{ wlvarios=a[m]+"="+wlcomi+valor+wlcomi; }
					else
					{  wlvarios=wlvarios+" and "+a[m]+"="+wlcomi+valor+wlcomi; }
    			}	
    			else
    			{   clearSelect(document.getElementsByName("wl_"+wlfiltrohijo)[0]);
	    			return;
    		    }
			}
  	  } // 20070615 Tronaba cuando no traia filtro padre
	  if (fuentewhere!="")
	  {	wlwhere=reemplaza_where(fuentewhere,'formpr');
	  	// 20071015
	  	if (wlwhere==false) { return; } // 20071015
	  }
	  
	  wlvs=wlselect;
	  if (wlvarios!='')
	  	{
                        wlvs=wlvs+' where '+wlvarios+(wlwhere.trim()=='' ? '' : ' and '+wlwhere);
	  		wlurl='src/php/xmlhttp.php';//20071105
	  		passData='&opcion=pon_select&sql='+escape(wlvs)+'&wlfiltropadre='+escape(wlfiltropadre)+'&wlfiltrohijo='+escape(wlfiltrohijo)+'&fuenteevento='+escape(fuenteevento)+'&fuentewhere='+escape(fuentewhere);	  			  		
      		CargaXMLDoc();		  	
  		}
  		else
	  	if (wlvs!='')  	// 20070615 Tronaba cuando no traia filtro padre	
  		{ // 20070615 Tronaba cuando no traia filtro padre
		  	wlvs=wlvs+(wlwhere!='' ? ' where '+wlwhere : '' );   		
	  		wlurl='src/php/xmlhttp.php';//20071105
	  		passData='&opcion=pon_select&sql='+escape(wlvs)+'&wlfiltropadre='+escape(wlfiltropadre)+'&wlfiltrohijo='+escape(wlfiltrohijo)+'&fuenteevento='+escape(fuenteevento); // 20070615 Tronaba cuando no traia filtro padre	  			  		
      		CargaXMLDoc(); // 20070615 Tronaba cuando no traia filtro padre
  		} // 20070615 Tronaba cuando no traia filtro padre
  		else
  		{	  		
	  		clearSelect(document.getElementById("wl_"+wlfiltrohijo));
  		}
	}  
  	catch(err)
  	{
	  	alert('error en pon_select'+err.description+' filtro padre'+wlfiltropadre);
  	}
  	
}
window.reemplaza_where = function(fuentewhere,theFormName)
{
  theForm = document.getElementById(theFormName);
  var qs = '';
  for (e=0;e<theForm.elements.length;e++) {
    if (theForm.elements[e].name!=''&& (theForm.elements[e].name.indexOf('wl_')>=0 || theForm.elements[e].name.indexOf('au_')>=0)) {
		while (fuentewhere.indexOf(theForm.elements[e].name)>=0)
		{
			if (theForm.elements[e].value=='')
			{ alert('Primero debe teclear el dato '+theForm.elements[e].title);theForm.elements[e].focus;return false; }  
			fuentewhere=fuentewhere.replace(theForm.elements[e].name,theForm.elements[e].value);
		}
    }
  }
  return fuentewhere;	
}

//  funcion que checa si fue seleccionado previamente un dato
window.si_Select = function(wlselect,wlfiltro)
{
	try
	{
	  var a = wlfiltro.split(',');
	  for (m=0;m<a.length;m++)
	  {	
		if(document.getElementsByName("wl_"+a[m])[0].value=='')
		{
			alert('Primero debe teclear o seleccionar el dato "'+document.getElementById("wlt_"+a[m]).value+'"');
			return false;
    	}	
	  }
  	}
  	catch(err)
  	{
	  	alert('error en si_select '+wlselect+ ' filtro '+wlfiltro); return false;
  	}


}

// add item to select element the less
// elegant, but compatible way.
//  wlselected si es 1 se pone la opcion selected y defaultselected   20070810
//				si es 2 se pone la opcion defaultselected             20070810
window.appendToSelect= function(wlselect, value, content,wlselected)  //   20070808  se incluyo el wlselected
{
	try   // inclui el try el 20070808
	{
    	var opt;
    	opt = document.createElement("option");
    	opt.value = value;
    	opt.appendChild(content);
    	if (wlselected==1) { opt.defaultSelected=true; opt.selected=true; }  // 20070808
    	if (wlselected==2) { opt.defaultSelected=true; }    	// 20070810
    	wlselect.appendChild(opt);
	}
  	catch(err)
  	{
  	}    	
}

window.buildTopicList=function(wl,des,val) 
{
    var items = req.responseXML.getElementsByTagName("registro");
    for (var i = 0; i < items.length; i++) {
        appendToSelect(wl, getElementTextNS("", val, items[i], 0),  
        document.createTextNode(getElementTextNS("", des, items[i], 
            0)),(items.length==1 ? 1 : 0));            // 20080210
    }
    appendToSelect(wl, "", document.createTextNode("Selecciona una Opci\u00f3n"),(items.length==1 ? 0 : 1)); //   20070808    
    wl.click;
}

/**   20070629
  *  ejecuta un submenu a nivel renglon
  *  lo que ejecuta viene el el value de la opcion
  **/
window.submenus = function(opcion)
{
	var quitareturn=opcion.options[opcion.selectedIndex].value.replace(/return/,"");
	eval(quitareturn);
}

// empty Topics select list content
window.clearSelect = function(wl) {
	try
	{
		wl.innerHTML="";
	}    	
    catch (err)
    {
	    alert ('en clearselect ' + err.description);
    }
}


window.muestra_vista = function (wlmenu,donde='entrada',filtro='',titulo='') {
             try { $("#"+donde).children()[0].remove(); } catch(er) { };
                        wlurl='src/php/xmlhttp.php';//20071105
                        passData='&opcion=muestra_vista&idmenu='+wlmenu+'&donde='+donde+filtro;
                        CargaXMLDoc();
                        return;
}
window.muestra_menus = function (menus,donde='navbarSupportedContentul') {
     console.log('menus'+menus[0]); 
     m=menus[0].getElementsByTagName('menu');
     nav=document.getElementByID(donde);
     /** interactual sobre los menus que no tiene padre */
     for ( var ren in m) {  
         if (typeof(m[ren])=='object') {
            idpadre=m[ren].childNodes[3].innerHTML;
            des=m[ren].childNodes[0].innerHTML
            idmenu=m[ren].childNodes[4].innerHTML
            if (idpadre==0) { /* si el idpadre es creo es un menu padre o se ejecutar una acciones */
               lid=document.createElement('li');
               lid.setAttribute('class','nav-item dropdown');
               ad=document.createElement('a');
               ad.setAttribute('class','nav-link dropdown-toggle');
               ad.setAttribute('id','navbarDropdown_'+idmenu);
               ad.setAttribute('role','button');
               ad.setAttribute('href','#');
               ad.setAttribute('data-toggle','dropdown');
               ad.setAttribute('aria-haspopup',true);
               ad.setAttribute('aria-expanded',false);
               div=document.createElement('div');
               div.setAttribute('class','dropdown-menu');
               div.setAttribute('aria-labelledby','navbarDropdown_'+idmenu);
               div.setAttribute('id','navbarDropdown_id_'+idmenu);
               adt = document.createTextNode(des)
               ad.appendChild(adt) 
               ad.appendChild(div) 
               lid.appendChild(ad) 
               nav.appendChild(lid);
            }
         }
     }
     for ( var ren in m) {
         if (typeof(m[ren])=='object') {
            idpadre=m[ren].childNodes[3].innerHTML;
            des=m[ren].childNodes[0].innerHTML
            idmenu=m[ren].childNodes[4].innerHTML
            if (idpadre!=0) { /* si el idpadre es creo es un menu padre o se ejecutar una acciones */
               ad=document.createElement('a');
               ad.setAttribute('class','dropdown-item');
               ad.setAttribute('href','#');
               ad.setAttribute('onclick',"muestra_vista("+idmenu+");return false;");
               adt = document.createTextNode(des)
               ad.appendChild(adt)
               nav=document.getElementByID('navbarDropdown_id_'+idpadre);
               nav.appendChild(ad);
            }
         }
     }
}
//  recibe el menu o vista sobre el cual va a dar mantenimiento
//  el movimiento que va a efectuar i=insert,d=delete,u=update
//  la llave con la que va a dara de baja o cambio
//  el renglon que va a dar de baja de la tabla
//20071112   se incluyo los eventos a efectuar en el cliente   wleventoantescl, wleventodespuescl
window.mantto_tabla = function (wlmenu,wlmovto,wlllave,wlrenglon,wleventoantes,wleventodespues,wleventoantescl,wleventodespuescl,noconfirmamovto,dedonde='')
{
        if (wlmovto=='d' || wlmovto=='u' || wlmovto=='s' || wlmovto=='S' || wlmovto=='B' )
        {
			wlllave=wlllave.replace(/"/g,"'");
	}			
        forma=$('#formpr_'+wlmenu)[0];
        if (hayalgundatotecleado(forma)!='si' && (wlmovto=='i' || wlmovto=='u' || wlmovto=='I'))
        {
           alert ('no ha tecleado ningun dato'); pone_focus_forma(forma); return;
        }

        if (wleventoantescl!="" && wleventoantescl!=undefined)
        {
	     	if (eventosparticulares(null,wleventoantescl)!=true)
	     	{   return false; }
        }
        
               
        if (wlmovto=='i'|| wlmovto=='u' || wlmovto=='I')
        {
        	if (checaobligatorios(forma)==false)	
        	{
           		return;
			}           		
        }        

        if (wlmovto=='i' || wlmovto=='u' || wlmovto=='I')
        {
        	if (checanumericos(forma)==false)	
        	{
           		return;
			}           		
        }                

        if (wlmovto=='i' || wlmovto=='u' || wlmovto=='I')
        {
        	if (checafechas(forma)==false)	
        	{
           		return;
			}           		
        }                

        if (wlmovto=='i' || wlmovto=='u' || wlmovto=='I')
        {
        	if (checaparticulares(forma)==false)	
        	{
           		return;
			}           		
        }                        
                
        if (wlrenglon==='' && (wlmovto=='u' || wlmovto=='d'))
        {   alert("el numero de renglon de la tabla esta vacio "+wlrenglon); return; }
        else
        {   glr = wlrenglon; }

        if (wlmovto=='d')
        {        
           if (noconfirmamovto.indexOf("d")!=-1)
           { }
           else
           {
                        if (window.confirm("Desea eliminar el registro"))
                        {
                                if (wlllave=='')
                                {
                                        alert('La llave del registro no esta definida'); return;
                                }
                        }
                        else
                        { return;};
            }
        }


        if (wlmovto=='u')
        {
           if (noconfirmamovto.indexOf("u")!=-1)
           {
              if (checaSiCambioAlgo(wlmenu,wlmovto,wlllave,wlrenglon,0)==false)
                 { alert('Usted no ha cambiado ningun dato'); pone_focus_forma(forma); return;}
           }
           else
           {
                if (window.confirm("Desea modificar el registro"))
                {
                        if (checaSiCambioAlgo(wlmenu,wlmovto,wlllave,wlrenglon,0)==false)
                        { alert('Usted no ha cambiado ningun dato'); pone_focus_forma(forma); return;}
                }
                else
                { return;};
            }
        }

        if (wlmovto=='s' || wlmovto=='S' || wlmovto=='f' || wlmovto=='B')
        {        				
		        if (hayalgundatotecleadobus(forma)!='si')
        		{
           			alert ('No ha tecleado ningun dato permitido para buscar\n'+'Los datos con asterisco son los filtros para la busqueda');
					pone_focus_forma(forma);           			
           			return;
        		}	
		}        					
						
		// si es una alta en wlrenglon pone cuantos renglones hay en la tabla esto para generar el row en la alta
		if (wlmovto=='i')
                {
                   if (noconfirmamovto.indexOf("i")!=-1)
                   {    wlrenglon=document.getElementById('tabdinamica_'+wlmenu).rows.length; }
                   else
                   {
                        if (window.confirm("Desea dar de alta el registro"))
                        {
                        try { wlrenglon=document.getElementById('tabdinamica_'+wlmenu).rows.length; } catch (er) { wlrenglon=0 };
                        }
                        else
                        { return;}
                   }

                }
		
		if (wleventoantes!="")
		{
			__eventocontinua=false;
	        wlurl='src/php/eventos_servidor.php';//20071105
	        passData='&opcion='+wleventoantes+'&wlmenu='+wlmenu+'&wlmovto='+wlmovto+buildQueryString(forma)+"&wlllave="+escape(wlllave)+"&wlrenglon="+wlrenglon+"&wleventodespues="+wleventodespues;//20071105
    	    CargaXMLDoc();		
    	    if 	( ! __eventocontinua )
	    	    return;
		}	
		

		if (wlmovto=='S')
			{
	           window.returnValue=armaFiltro('formpr');
	           window.close();
                   //SubMod._ReturnVal=armaFiltro('formpr');
                   //document.getElementById("popCloseBox").click();
        	}
        	
            
        		wlurl='src/php/xmlhttp.php';//20071105
        		passData='&opcion=mantto_tabla&idmenu='+wlmenu+'&movto='+wlmovto+buildQueryString(forma)+"&wlllave="+escape(wlllave)+"&wlrenglon="+wlrenglon+"&wleventodespues="+escape(wleventodespues)+"&filtro="+escape(armaFiltro(forma))+"&noconfirmamovto="+escape(noconfirmamovto);
	        	CargaXMLDoc();			
	        	return;
}
 
//  recibe el renglon de la tabla que se esta actualizando
//            columna del renglon de la tabla que se esta actualizando
//            objeto que se esta actualizando
//            valor del importe del ingresos que se quiere actualizar
//            la atl que quiere actualizar
//            la fecha de cobro que quiere actualizar
window.caping = function(wlrenglon,wlcolumna,wlobjeto,valor,wlatl,wlfcobro)
{
    var vd1 = new valcomunes();
    vd1.ponnumero(wlobjeto);
    if (vd1.esmoneda()==false)
       {  return; }

    if (wlrenglon==0)
    {   alert("el numero de renglon de la tabla esta en ceros"); return; }
    else
    {   glr = wlrenglon; }
    if (valor!="")
    {
        wlurl='xmlhttp.php';        //20071105
        passData='&opcion=caping&atl='+wlatl+'&fcobro='+wlfcobro+'&valor='+valor;        
        CargaXMLDoc();
    }
}


// funcion que pone el mensaje en la siguiente celda donde se capturo el dato
// esto funciona exclusivamente para la captura de ingresos
window.mensajetabla = function(wlmensaje)
{
   var x=document.getElementById('tabdinamica').rows; // obtiene los renglones de la tabla
   var y=x[glr].cells ; // obtiene las celdas del renglon a modificar
   y[3].innerHTML=wlmensaje; // pone el texto en la celda donde debe ir el mensaje
   if (wlmensaje=='Incorrecto Usuario')
   {
       y[3].className="incorrecto";
   }
   if (wlmensaje=='Correcto Usuario')
   {
       y[3].className="correcto";
   }
}

// funcion que pone el mensaje en la siguiente celda donde se capturo el dato
window.bajatabla = function(idmenu)
{
	var wl=document.getElementById('tr'+glr+'_'+idmenu).rowIndex;
        document.getElementById('tabdinamica_'+idmenu).deleteRow(wl);
}
// funcion que da de baja todos los renglones de una tabla
window.bajatodatabla = function()
{
	try
	{
	var nrows=document.getElementById('tabdinamica').rows.length;
	if (nrows>=2)
	{ 
				  for( var i=0; i<nrows-2 ; ++i ) {	              
						var wl=document.getElementById('tr'+i).rowIndex;					  
		              	document.getElementById('tabdinamica').deleteRow(wl);
	              	}
	}
	} catch(err) { alert('error bajatodatabla '+err.message) }

}

// funcion que cambia de color el row cuando cambian un registro
//  recibe el menu, el moviento que va hacer, la llave del cambio y el renglon de la tabla
//  cambiacolor, si es cero no cambia el color en el registro, si es 1 si cambia el color en el registor
window.checaSiCambioAlgo = function(wlmenu,wlmovto,wlllave,wlrenglon,cambiacolor)
{
try {  // firefox

		var regresa=false;	
		var ct=document.getElementById("tr"+wlrenglon+"_"+wlmenu).cells.length;
		for (e=0;e<ct;e++)
		{
	  		var el="r"+wlrenglon+"c"+e;
	  		var elm="cc"+e;
	  		try
	  		{
                                cc_elm=document.getElementById(elm+"_"+wlmenu);
                                cc_el=document.getElementById(el+"_"+wlmenu);
	  			if (cc_elm.type=='text' || cc_elm.type=='password' || cc_elm.type=='textarea')
                {  // 20070630 este inicio de { estaba a partir del siguiente if, esto hacia que no acutalizara bien
                   try { var valorren=cc_el.innerText.trim(); } catch (err) { var valorren=null; }
	  			 if (cc_elm.value.trim()!=valorren)
	  				{	
		  				if (cambiacolor==1)
		  				{
		  					cc_el.innerText=cc_elm.value;
		  					cc_el.className="bg-success text-white";
						}		  				
		  				regresa=true; 
		  			}
	  			}
	  			if (cc_elm.type=='select-one')
	  			{ 
		  			if (cc_elm.value!=busca_ValorOption(cc_elm,cc_el.innerText,0,cc_el.abbr))
	  				{ 	
		  				if (cambiacolor==1)
		  				{		  			
		  					cc_el.innerText=busca_DesOption(cc_elm,cc_elm.value);
		  					cc_el.className="cambiado";		  			
	  					}
		  				regresa=true; 
	  				}
	  			}
	  			if (cc_elm.type=='checkbox')
	  			{ 
		  			if (cc_elm.checked!=nullesfalse(cc_el.innerText))
	  				{	
		  				if (cambiacolor==1)
		  				{
		  					cc_el.innerText=cc_elm.value;
		  					cc_el.className="cambiado";
						}		  				
		  				regresa=true; 
		  			}
	  			}	  			
			}	  			
			catch(err)
			{
			}
    	}
    return regresa;
} catch (err) { alert ('error checaSiCambioAlgo='+err) } // firefox
}

//  convierte un null a false
window.nullesfalse = function(wlvalor)
{
	if (wlvalor=='')
	{	return false; }
	if (wlvalor=='f')
	{	return false; }
	if (wlvalor=='t')
	{	return true; }	
}

// Funcion que mueve el renglon que se desea modificar a los campos de captura para poder ser cambiados
function mueveCambio(wlmenu,wlmovto,wlllave,wlrenglon)
{
        var z=document.getElementById('tr'+wlrenglon);	
}

// Funcion que da de alta un renglon en la tabla donde muestra el registro recien dado de alta
window.altatabla = function(wlrenglon,idmenu)
{
	try
	{
	    if (document.getElementById('tabdinamica_'+idmenu))  {  /* si existe la tabla dinamica crea el renglon */
                var xx = req.responseXML.getElementsByTagName("renglon");              	
                var tr=xx[0].childNodes[0].nodeValue.split(">");        
                var z=xx[0].childNodes[0].nodeValue.split("</td>");
		var b = document.getElementById('tabdinamica_'+idmenu).insertRow(1);			
                try { document.getElementById('tabdinamica_'+idmenu).style.visibility='visible';        } catch (err) { } ;
		var p=0;

			

		var wlbaja = document.getElementById('baja');
		var wlcambio = document.getElementById('cambio');
		for ( x in z)
		{
			var str=z[x];
			if (str!=null && str!='' && str.indexOf("<td")!=-1)
			{			
					wlele=document.createElement("td");
					wlele.innerHTML=str.substring(str.indexOf("<td"));
					b.appendChild(wlele);					
					//  sirve para save si el campo tiene un id si es asi incrementa p que el numero de columna						
					if (str.substring(str.indexOf("<td")).indexOf("id=r")!=-1)
					{
						wlele.id='r'+wlrenglon+'c'+p;
						p=p+1;
					}    	 				
			}
		}	

		if (tr[0].indexOf("ondblclick")!=-1)
			{   
				var pas=tr[0].substring(tr[0].indexOf("ondblclick")+12);
				var pas=pas.substring(0,pas.indexOf("'"));
				b.ondblclick = function() { muestra_renglon(this); }
			}
			
		if (tr[0].indexOf("oncontextmenu")!=-1)
			{   
				var pas=tr[0].substring(tr[0].indexOf("oncontextmenu")+15);
				var pas=pas.substring(0,pas.indexOf("'"));
				b.oncontextmenu= function() { contextForTR(this); return false; } ;
			}
						
		b.id='tr'+wlrenglon;		
		color_renglon(b);
            }
	} catch(err) { alert('error altatabla '+err.message) }	
	

		
}

//  revisa si hay que ejecutar un evento en el servidor despues de haber ejecutado un movimiento+
//  de mantenimiento de una tabla
window.checa_eventodespues = function(wlrespuesta,idmenu=0)
{
  try {
           if (req.responseText.indexOf("<wleventodespues>") != -1)
           {
	      var iden="";  
              var items = req.responseXML.getElementsByTagName("iden");
              if (items.length>0 && items[0].childNodes.length>0) 
              { iden="&iden="+items[0].childNodes[0].nodeValue; }
              	           
              var items = req.responseXML.getElementsByTagName("wleventodespues");
              if (items.length>0 && items[0].childNodes.length>0)
              { 
	            if(items[0].childNodes[0].nodeValue!="")
	            {
        			wlurl='src/php/eventos_servidor.php';
                                forma=$('#formpr_'+idmenu)[0];
        			passData='&opcion='+items[0].childNodes[0].nodeValue+buildQueryString(forma) + iden+"&filtro="+escape(armaFiltro(forma));
        			CargaXMLDoc();	              
    			}
	      } else { }
              return;
           } 	
     } catch (err) { alert(" error checa_eventodespues="+err+"="+req.responseText); }
}

// funcion que maneja la respuesta que regresa el xmlhttp
window.querespuesta = function() 
{
	try
	{
    if (req.readyState == 4)
    {
		window.status='req.readyState'+req.readyState+' req.status='+req.status;	    
        if (req.status == 200)
        {
           if (req.responseText.indexOf("<otrahoja>") != -1)
           {
		var x = req.responseXML;
              var items = req.responseXML.getElementsByTagName("otrahoja");
              if (items.length>0)
              { 
	              wlforma=document.getElementById('formpr');
	              wlforma.action=items[0].childNodes[0].nodeValue;
	              wlforma.submit();
              }
              else {alert('no encontro otrahoja='+req.responseText)}
              return;
           } 
	        	        
           if (req.responseText.indexOf("<muestra_vista>") != -1)
           {
             entrada=document.getElementById('entrada');
             if (req.responseText.indexOf("<donde>") != -1) {
                donde=req.responseXML.getElementsByTagName("donde")[0].innerHTML;
                entrada=document.getElementById(donde);
             }
             try { $(entrada).children()[0].remove(); } catch(er) { };
             html=req.responseXML.getElementsByTagName("muestra_vista")[0].innerHTML;
             html=htmlspecialchars_decode(html);
             parser = new DOMParser();
             doc = parser.parseFromString(html, "text/html");
             entrada.insertAdjacentHTML('afterbegin', html);
             if (req.responseText.indexOf("<menus>") != -1) {
                muestra_menus(req.responseXML.getElementsByTagName("menus"));
             }
             if (req.responseText.indexOf("<idmenu>") != -1) {
                idmenu=req.responseXML.getElementsByTagName("idmenu")[0].innerHTML;
                hayunregistro(idmenu);
                forma=$('#formpr_'+idmenu)[0];
                pone_focus_forma(forma,this)
                console.log('paso pone focus');
             }
             return;
           }

           if (req.responseText.indexOf("<error>") != -1)
           {
              var items = req.responseXML.getElementsByTagName("noconfirma");
              try { var noconfirma=items[0].childNodes[0].nodeValue } catch (err) { var noconfirma=false; };
              if (!noconfirma)
              {
                 var items = req.responseXML.getElementsByTagName("error");
                 if (items.length>0)
                 { alert(items[0].childNodes[0].nodeValue); }
                 else {alert('no encontro el error='+req.responseText)}
              }
              return;
           } 
           
           if (req.responseText.indexOf("<__eventocontinua>") != -1)
           {
              var items = req.responseXML.getElementsByTagName("__eventocontinua");
              if (items.length>0)
              { __eventocontinua=items[0].childNodes[0].nodeValue; }
              else {alert('no encontro el __eventocontinua='+req.responseText)}
              return;
           }            
           
           if (req.responseText.indexOf("<salida>") != -1)
           {
              var items = req.responseXML.getElementsByTagName("salida");
              if (items.length>0)
              { 
	            if (items[0].childNodes[0].nodeValue!='') 
	            {
			  		alert(items[0].childNodes[0].nodeValue);
		  		}
              }
              
              else {alert('no encontro salida='+req.responseText)}
              self.close();
              parent.close();
              return;
           }            

           if (req.responseText.indexOf("<finsession>") != -1)
           {
              alert('Su session caduco '+req.responseText);
              self.close();
              parent.close();
              return;
           }

           
           if (req.responseText.indexOf("<bajaok>") != -1)
           {
              var items = req.responseXML.getElementsByTagName("bajaok");
              alert(items[0].childNodes[0].nodeValue);
              if (req.responseText.indexOf("<idmenu>") != -1) {
                idmenu=req.responseXML.getElementsByTagName("idmenu")[0].innerHTML;
                bajatabla(idmenu);
              }
              return;
           } 
           
           if (req.responseText.indexOf("<continuamovto>") != -1)
           {
	             var desw = req.responseXML.getElementsByTagName("wlmenu");
	            var wlmenu = desw[0].childNodes[0].nodeValue;	           
	            var desw = req.responseXML.getElementsByTagName("wlmovto");
	            var wlmovto = desw[0].childNodes[0].nodeValue;
	            var desw = req.responseXML.getElementsByTagName("wlllave");
	            try { var wlllave = desw[0].childNodes[0].nodeValue; } catch(err) { var wllave = ""; }
	            var desw = req.responseXML.getElementsByTagName("wlrenglon");
	            var wlrenglon = desw[0].childNodes[0].nodeValue;
	            var desw = req.responseXML.getElementsByTagName("wleventodespues");
	            try { var wleventodespues = desw[0].childNodes[0].nodeValue; } catch(err) { var wleventodespues = ""; }
	            wlurl='src/php/xmlhttp.php'; 
                    forma=$('#formpr_'+wlmenu)[0];
	            passData='&opcion=mantto_tabla&idmenu='+wlmenu+'&movto='+wlmovto+buildQueryString(forma)+"&wlllave="+escape(wlllave)+"&wlrenglon="+wlrenglon+"&wleventodespues="+wleventodespues;//20071105
        		CargaXMLDoc();			
        		return;
           }            

           if (req.responseText.indexOf("<abresubvista>") != -1)
           {
	           var desw = req.responseXML.getElementsByTagName("wlhoja");
	           var wlhoja = desw[0].childNodes[0].nodeValue;
	           var desw = req.responseXML.getElementsByTagName("wlcampos");
	           var wlcampos = desw[0].childNodes[0].nodeValue;
	           var desw = req.responseXML.getElementsByTagName("wldialogHeight");
	           var wldialogHeight = desw[0].childNodes[0].nodeValue;
	           var desw = req.responseXML.getElementsByTagName("wldialogWidth");
	           var wldialogWidth = desw[0].childNodes[0].nodeValue;	   
                   var desw = req.responseXML.getElementsByTagName("ventana");
                   try { var wlventana = desw[0].childNodes[0].nodeValue; } catch (err) { var wlventana=0; };
                   var desw = req.responseXML.getElementsByTagName("titulo");
                   try { var wltitulo = desw[0].childNodes[0].nodeValue; } catch (err) { var wltitulo='Subvista'; };
	           if (wldialogHeight!=0 || wldialogWidth!=0)
	           {       
			   		showModalDialog(wlhoja+'?'+wlcampos,wldialogWidth,wldialogHeight,wltitulo,wlventana);
		   	   }
		   	   else
		   	   {
			   		showModalDialog(wlhoja+'?'+wlcampos,100,300,'Subvista');
		   	   }
		   
               return;
           }
/*           
           //  20070616   cuando un select tiene demasiadas opciones el browser se pasma por que se chupa la memoria
           //  20070616   al detectar esto solicita las iniciales de la descripcion                         
           if (req.responseText.indexOf("<pon_selectpasolimite>") != -1)
           {
	           var items = req.responseXML.getElementsByTagName("wlselect");	           
	           var wlselect = items[0].childNodes[0].nodeValue;	           
	           var items = req.responseXML.getElementsByTagName("wlfiltropadre");	           
	           var wlfiltropadre = items[0].childNodes[0].nodeValue;	           	           
	           var items = req.responseXML.getElementsByTagName("wlfiltrohijo");	           
	           var wlfiltrohijo = items[0].childNodes[0].nodeValue;	           	           	           
	           var items = req.responseXML.getElementsByTagName("fuentewhere");	           
	           var fuentewhere = items[0].childNodes[0].nodeValue;	           	           	           	           
	           var items = req.responseXML.getElementsByTagName("fuenteevento");	           
	           var fuenteevento = items[0].childNodes[0].nodeValue;	    
	           var items = req.responseXML.getElementsByTagName("opciones");	           
	           var opciones = items[0].childNodes[0].nodeValue;	    	           
	           var wlcampo=wlselect.substring(8,wlselect.indexOf(","));
			   var des=prompt('Las opciones son bastantes '+opciones+' favor de teclear las dos primeras letras para buscar las opciones que empiezan con estas',''); //20070215	
			   if (des!='' && des!=null) 
		    	{ 
	           			wlcampo=wlcampo+' like \''+des+'%\'';
						pon_Select(wlselect,wlfiltropadre,wlfiltrohijo,fuentewhere+wlcampo,fuenteevento)			
     		    }	                 	           	           	           	           
	           return;
           }
*/           
           if (req.responseText.indexOf("<ponselect>") != -1)
           {
	           var desw = req.responseXML.getElementsByTagName("s_descripcion");	           
	           var des = desw[0].childNodes[0].nodeValue
	           var valw = req.responseXML.getElementsByTagName("s_value");	           
	           var val = valw[0].childNodes[0].nodeValue	           
	           var items = req.responseXML.getElementsByTagName("wlfiltrohijo");
			   var wlhijos=items[0].childNodes[0].nodeValue.split(',');
		       for (m=0;m<wlhijos.length;m++)
	  			{	
            		var wl=document.getElementsByName('wl_'+wlhijos[m])[0];   //firefox
            		clearSelect(wl);
	           		buildTopicList(wl,des,val);
				}	           		
               return;
           }            
                      
           if (req.responseText.indexOf("<altaok>") != -1)
           {
              var items = req.responseXML.getElementsByTagName("idmenu");
              try { var idmenu=items[0].childNodes[0].nodeValue } catch (err) { var idmenu=0; };

              var items = req.responseXML.getElementsByTagName("noconfirma");
              try { var noconfirma=items[0].childNodes[0].nodeValue } catch (err) { var noconfirma=false; };
              if (!noconfirma)
              {
                 var items = req.responseXML.getElementsByTagName("altaok");
                 if (items.length>0)
                 { alert(items[0].childNodes[0].nodeValue); }
                 else {alert('no encontro el altaok '+req.responseText+' elemento'+items.length)}
              }
              var items = req.responseXML.getElementsByTagName("wlrenglon");              
              if (items.length>0)
              { var wlrenglon=items[0].childNodes[0].nodeValue; 
              	altatabla(wlrenglon,idmenu);}
              else {alert('no encontro el altaok '+req.responseText)}
              var limpiaralta=true;
              var items = req.responseXML.getElementsByTagName("limpiaralta");              
              if (items.length>0)
              { limpiaralta=items[0].childNodes[0].nodeValue; }              
              checa_eventodespues(req.responseText,idmenu);   
              forma=$('#formpr_'+idmenu)[0];
              formReset(forma,limpiaralta);
	      pone_focus_forma(forma);   // limpia la pantalla despues de una alta              
              return;
           } 

           if (req.responseText.indexOf("<copiaok>") != -1)
           {
              var items = req.responseXML.getElementsByTagName("idmenu");
              try { var idmenu=items[0].childNodes[0].nodeValue } catch (err) { var idmenu=0; };
              var items = req.responseXML.getElementsByTagName("copiaok");
              if (items.length>0)
              { alert(items[0].childNodes[0].nodeValue); }
              else {alert('no encontro el copia '+req.responseText+' elemento'+items.length)}
              var items = req.responseXML.getElementsByTagName("wlrenglon");              
              if (items.length>0)
              { var wlrenglon=items[0].childNodes[0].nodeValue; 
              	altatabla(wlrenglon,idmenu);}
              else {alert('no encontro el altaok '+req.responseText)}
              var limpiaralta=true;
              var items = req.responseXML.getElementsByTagName("limpiaralta");              
              if (items.length>0)
              { limpiaralta=items[0].childNodes[0].nodeValue; }              
              checa_eventodespues(req.responseText);   
	      pone_focus_forma("formpr");formReset("formpr",limpiaralta);   // limpia la pantalla despues de una alta              
              return;
           } 

           if (req.responseText.indexOf("<consulta>") != -1)
           {
              var items = req.responseXML.getElementsByTagName("idmenu");
              try { var idmenu=items[0].childNodes[0].nodeValue } catch (err) { var idmenu=0; };
	      var x = req.responseXML;
              var items = req.responseXML.getElementsByTagName("noconfirma");
              try { var noconfirma=items[0].childNodes[0].nodeValue } catch (err) { var noconfirma=false; };
              if (!noconfirma)
              {
                 var items = req.responseXML.getElementsByTagName("consulta");
                 if (items.length>0)
                 { alert(items[0].childNodes[0].nodeValue); }
                 else {
	              alert('no encontro consulta lon '+items.length+' len text'+req.responseText.length);
	              alert(req.responseText.substring(1,1000)+' fin='+req.responseText.substring(req.responseText.length-1000));
	              return;
	              }
              }

              var items = req.responseXML.getElementsByTagName("renglones");              
              if (items.length>0)
              { 
                                        try { tb=$("#tabdinamica_"+idmenu)[0]; tb.parentNode.removeChild(tb); } catch (er) { };
                                        entrada=document.getElementById('formpr_'+idmenu);
                                        if (isIE)
					{ entrada.insertAdjacentHTML('beforeEnd', items[0].childNodes[0].nodeValue); }  //  IE
                                        else
                                        { entrada.insertAdjacentHTML('beforeEnd', items[0].textContent); }  //ff
					hayunregistro(idmenu);
					sumatotales(idmenu);	
              }
              else {alert('no encontro renglones '+req.responseText)}

              checa_eventodespues(req.responseText);              
              try { var tadi=document.getElementById("menerror");  tadi.parentNode.removeChild(tadi); } catch (err) { }              
              return;
              
           } 
                                 
           if (req.responseText.indexOf("<altaokautomatica>") != -1)
           {	
	           var desw = req.responseXML.getElementsByTagName("iden");//20080116
	           var des = desw[0].childNodes[0].nodeValue;	           				   //20080116	           
                   var docx=window.parent.document;
                   var dh=docx.getElementById("altaautomatico");
                   dh.close(des);
                   dh.focus();
                   return;
       		}
           
           if (req.responseText.indexOf("<altaautomatico>") != -1)        //20070215
           {//20070215
	            var desw = req.responseXML.getElementsByTagName("des");//20070215
	            var des = desw[0].childNodes[0].nodeValue;	           				//20070215
	            var desw = req.responseXML.getElementsByTagName("dato");//20070215
	            var dato = desw[0].childNodes[0].nodeValue;	           				//20070215	            
	            var desw = req.responseXML.getElementsByTagName("secuencia");//20070215
	            var secuencia = desw[0].childNodes[0].nodeValue;	           				//20070215	            	            
        		var t=document.getElementById(dato);//20070215
        		var a = new Option(des,t.length,true,true);//20070215        		
        		a.value=secuencia;
        		t.add(a);
                        t.focus();
				return;	           //20070215
           }            //20070215
                      

           if (req.responseText.indexOf("<_nada_>") != -1)
           {
	           return;
           }           
                      
           if (req.responseText.indexOf("<cambiook>") != -1)
           {
	            var wlmenu=""
                    var wlmovto="" 
                    var wlllave="" 
                    var wlrenglon=""
        	    var items = req.responseXML.getElementsByTagName("cambiook");				
	            alert(items[0].childNodes[0].nodeValue);
	            var desw = req.responseXML.getElementsByTagName("wlmenu");
                    if (desw[0].childNodes.length>0) //firefox
	                wlmenu = desw[0].childNodes[0].nodeValue;	           
	            var desw = req.responseXML.getElementsByTagName("wlmovto");
                    if (desw[0].childNodes.length>0) //firefox
	                wlmovto = desw[0].childNodes[0].nodeValue;
	            var desw = req.responseXML.getElementsByTagName("wlllave");
                    if (desw[0].childNodes.length>0) //firefox
	                wlllave = desw[0].childNodes[0].nodeValue;	           	            	            	           	       
	            var desw = req.responseXML.getElementsByTagName("wlrenglon");
                    if (desw[0].childNodes.length>0) //firefox
	                wlrenglon = desw[0].childNodes[0].nodeValue;	           	            	            	           	       	            
		    checaSiCambioAlgo(wlmenu,wlmovto,wlllave,wlrenglon,1);
              	    checa_eventodespues(req.responseText);              
    	            return;
           }            
           
           if (req.responseText.indexOf("<mensajetabla>") != -1)
           {
              var items = req.responseXML.getElementsByTagName("mensajetabla");
              mensajetabla(items[0].childNodes[0].nodeValue);
              return;
           } 

			if (req.responseText.indexOf("<generatexto>") != -1)
			{
				var items = req.responseXML.getElementsByTagName("generatexto");
				if (items.length) { alert(items[0].childNodes[0].nodeValue); }
				var desw = req.responseXML.getElementsByTagName("archivo");
				var wlarchivo = desw[0].childNodes[0].nodeValue;
				open(wlarchivo,'nvo');
				return;
			}
                        if (req.responseText.indexOf("<generaexcel>") != -1)
                        {
                                var items = req.responseXML.getElementsByTagName("generaexcel");
                                if (items.length) { alert(items[0].childNodes[0].nodeValue); }
                                var desw = req.responseXML.getElementsByTagName("archivo");
                                var wlarchivo = desw[0].childNodes[0].nodeValue;
                                //alert (wlarchivo);
                                open(wlarchivo,'nvo');
                                return;
                        }
                        if (req.responseText.indexOf("<actualiza>") != -1)
                        {
                                var mensaje = req.responseXML.getElementsByTagName("mensaje");
                                var menu = req.responseXML.getElementsByTagName("menu");
                                if (menu.length)
                                { alert(mensaje[0].childNodes[0].nodeValue); open('man_menus.php?idmenu='+menu[0].childNodes[0].nodeValue,window.name); }
                                return;
                        }

                        if (req.responseText.indexOf("<abremanual>") != -1)
                        {
                                var desw = req.responseXML.getElementsByTagName("abremanual");
                                var wlarchivo = desw[0].childNodes[0].nodeValue;
                                open(wlarchivo,'nvo');
                                //alert (wlarchivo);
                                return;
                        }
           //eventos_servidor('',"No esta progamada la respuesta que envia el servidor="+req.responseText,'Enviaemail','','',0,0);
           alert("No esta progamada la respuesta que envia el servidor="+req.responseText);
        }
        else
        {
            alert("There was a problem retrieving the XML data1:\n"+req.statusText+" "+req.responseText);
        }
    }
	}
	catch (err)
	{
                //eventos_servidor('',"_error que respuesta1 err.description="+err+" req.responseText="+req.responseText,'Enviaemail','','',0,0);
		alert("_error que respuesta1 err.description="+err.message+" req.responseText="+req.responseText);
	}
}
 

// retrieve text of an XML document element, including
// elements using namespaces
function getElementTextNS(prefix, local, parentElem, index) {
    var result = "";
    if (prefix && isIE) {
        result = parentElem.getElementsByTagName(prefix + ":" + local)[index];
    } else {
        result = parentElem.getElementsByTagName(local)[index];
    }
    if (result) {
        if (result.childNodes.length > 1) {
            return result.childNodes[1].nodeValue;
        } else {
        	if (result.childNodes.length == 1) 
        	{ return result.firstChild.nodeValue;  }							
        	else						
        	{ return ""; }
        }
    } else {
        return "n/a";
    }
}
/**
* Muestra informacion de los campos select
*/
function muestraInfo(attnum,fuente_info_idmenu,nombre)
{
        try
        {
                wlpersona=document.getElementById('wl_'+nombre);
                wltpersona=document.getElementById('wlt_'+nombre);
                if (wlpersona.value=='')
                {
                        alert("Primero debe seleccionar el dato de "+wltpersona.value); wltpersona.focus();
                }
                else
                {
                        filtro='id_persona='+wlpersona.value;
                        showModalDialog('man_menus.php?idmenu='+fuente_info_idmenu+'&filtro='+filtro,900,450,'Muestra informacion');
                }
        }
        catch(err) { alert('error en muestraInfo '+err.description); };
}
function actualizaRelog()
{
        try
        {       var wlencaFecha=document.getElementById('wl_encafecha');
                var wlencaHora=document.getElementById('wl_encahora');
                var fechaServidor=new Date();
                var anio=fechaServidor.getFullYear();
                var mes=this.mesesEspanol();
                var dia=fechaServidor.getDate();
                var hora=fechaServidor.getHours();
                var minuto=fechaServidor.getMinutes();
                var segundo=fechaServidor.getSeconds();
                // define fecha
                fechaActual='Fecha: '+((dia < 10) ? '0' : '')+ dia +' de '+mes+' de '+anio;
                wlencaFecha.value=fechaActual;
                // define hora
                horaActual='Hora: '+((hora < 10) ? '0' : '')+ hora+''+((minuto < 10) ? ":0" : ":")+ minuto +''+((segundo < 10) ? ":0" : ":")+ segundo+'   ';
                wlencaHora.value=horaActual;
                setTimeout("actualizaRelog()",1000);
        } catch(err) { alert('error en actualizaRelog '+err.description); };
}
function mesesEspanol ()
{
        var fecha=new Date();
        var mes=new Array(12);
        mes[0]="Enero";
        mes[1]="Febrero";
        mes[2]="Marzo";
        mes[3]="Abril";
        mes[4]="Mayo";
        mes[5]="Junio";
        mes[6]="Julio";
        mes[7]="Agosto";
        mes[8]="Septiembre";
        mes[9]="Octubre";
        mes[10]="Noviembre";
        mes[11]="Diciembre";
        mesActual=mes[fecha.getMonth()];
        return mesActual;
}



