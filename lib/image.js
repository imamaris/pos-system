
<!-- Begin
/* This script and many more are available free online at
   The JavaScript Source!! http://javascript.internet.com
   Created by: Abraham Joffe :: http://www.abrahamjoffe.com.au/ 
*/

/***** CUSTOMIZE THESE VARIABLES *****/

// width to resize large images to
var maxWidth=100;

// height to resize large images to
var maxHeight=100;

// valid file types
var fileTypes=["bmp","gif","png","jpg","jpeg"];

// the id of the preview image tag
var outImage="previewTag";

// what to display when the image is not valid
var defaultPic="spacer.gif";

// create a temp Image obj
var globalPic;

// the id of the image preview area
var globalPreviewArea;


/***** DO NOT EDIT BELOW *****/

function previewImage(what, previewArea, defaultPicObj) {
	
	defaultPic = defaultPicObj.value;
	
	var source = what.value;
	source = Trim(source);
	
	var clearAction = false;
	if (source == "")
		clearAction = true;
		
  var ext = source.substring(source.lastIndexOf(".")+1, source.length).toLowerCase();
    
  for (var i=0; i<fileTypes.length; i++) if (fileTypes[i]==ext) break;
  
  globalPreviewArea = previewArea;
  globalPic = new Image();
  
  if (i<fileTypes.length) { 
	  globalPic.src = source; 
	  
	} else {
		
  	globalPic.src = defaultPic;
  	
  	if (!clearAction) {
    	alert("THAT IS NOT A VALID IMAGE\nPlease load an image with an extention of one of the following:\n\n"+fileTypes.join(", "));
  	}
  }
  
  setTimeout("applyChanges()",200);
  
} // end previewImage


function applyChanges() {
	
  //var field=document.getElementById(outImage);
  var field = globalPreviewArea;
  var x = parseInt(globalPic.width);
  var y = parseInt(globalPic.height);
  
  /*if (x>maxWidth) {
    y*=maxWidth/x;
    x=maxWidth;
  }
  
  if (y>maxHeight) {
    x*=maxHeight/y;
    y=maxHeight;
  }*/
  
  field.style.display = (x<1 || y<1) ? "none" : "";
  field.src = globalPic.src;
  field.width = x;
  field.height = y;
  
} // end applyChanges


function Trim(str) {

  var res = /^\s+/ig;
  var ree = /\s+$/ig;
	
  var out = str.replace(res,"").replace(ree,"");
  return out;
}

// End -->