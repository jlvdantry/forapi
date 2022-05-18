// -------------------------------------------------------------------
// DHTML Modal window- By Dynamic Drive, available at: http://www.dynamicdrive.com
// v1.0: Script created Feb 27th, 07'
// v1.01 May 5th, 07' Minor change to modal window positioning behavior (not a bug fix)
// v1.1: April 16th, 08' Brings it in sync with DHTML Window widget. See changelog.txt for the later for changes.
// REQUIRES: DHTML Window Widget (v1.01 or higher): http://www.dynamicdrive.com/dynamicindex8/dhtmlwindow/
// -------------------------------------------------------------------

if (typeof dhtmlwindow=="undefined") {
alert('ERROR: Modal Window script requires all files from "DHTML Window widget" in order to work!');
} else { dhtmlwindow.addEvent(window, function(){if (typeof dhtmlmodal!="undefined") dhtmlmodal.adjustveil()}, "resize"); }

window.dhtmlmodal= {
veilstack: 0,
_doc: null,
_fra: null,
open:function(t, contenttype, contentsource, title, attr, recalonload){
       muestra_vista(t,'modal-body','',title,contentsource);
       $('#msgModal').modal();
},


loadveil:function(){
	var d=dhtmlwindow
	d.getviewpoint()
	this.docheightcomplete=(d.standardbody.offsetHeight>d.standardbody.scrollHeight)? d.standardbody.offsetHeight : d.standardbody.scrollHeight
	this.interVeil.style.width=d.docwidth+"px" //set up veil over page
	this.interVeil.style.height=this.docheightcomplete+"px" //set up veil over page
	this.interVeil.style.left=0 //Position veil over page
	this.interVeil.style.top=0 //Position veil over page
	this.interVeil.style.visibility="visible" //Show veil over page
	this.interVeil.style.display="block" //Show veil over page
},

adjustveil:function(){ //function to adjust veil when window is resized
	if (this.interVeil && this.interVeil.style.display=="block") //If veil is currently visible on the screen
		this.loadveil() //readjust veil
},

closeveil:function(){ //function to close veil
	this.veilstack--
	if (this.veilstack==0) //if this is the only modal window visible on the screen, and being closed
		this.interVeil.style.display="none"
},


close:function(t, forceclose){ //DHTML modal close function
	if (typeof forceclose!="undefined")
		t.onclose=function(){return true}
	if (dhtmlwindow.close(t)) //if close() returns true
        	this.closeveil();
},


show:function(t){
	dhtmlmodal.veilstack++
	dhtmlmodal.loadveil()
	dhtmlwindow.show(t)
}
} //END object declaration
