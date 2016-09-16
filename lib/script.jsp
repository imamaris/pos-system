<script language=Javascript>

/*============================================================================
 *  Useful script functions
 ===========================================================================*/

var email = /^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
var zipcode = /^\d{5}(-\d{4})?$/;
var phone = /^\d+$/;
//var money = /^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{1,2})?$/;
var date = /^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|([1-3][0-9]))\/((\d{4}))$/;
var ccard = /^((4\d{3})|(5[1-5]\d{2})|(6011))-?\d{4}-?\d{4}-?\d{4}|3[4,7]\d{13}$/;
var cvv = /^\d{3,4}$/;
var ccexp = /^(([1-9])|(0[1-9])|(1[0-2]))\/(((0[1-9])|([1-3][0-9])))$/;
var ccexp2 = /^((0[1-9])|(1[0-2]))((0[1-9])|([1-3][0-9]))$/;
var numeric = /^\d/;

/*============================================================================
 *  Identity No / IC related
 ===========================================================================*/

 // Restrict user from entering '-' on IC
function enterIC(obj, country) {
	
  var result = obj.value;
	
	if (country.value == 'MY') {
	  if (result.indexOf("-") >= 0) {
	    var parseStr = "";
	    
	    for (var i=0; i<result.length; i++) {
	      if (result.charAt(i) != "-")
	       parseStr = parseStr + result.charAt(i);
	    }
	    
	    result = parseStr;
	    obj.value = result;
	  }
	}
}

function validateIC(obj, country) {
	validated = true;

	var validMYIC = /^\d{6}-\d{2}-\d{4}$/;
	var validSGIC = /^[a-zA-Z]{1}\d{7}[a-zA-Z]{1}$/;

	// Error messages
	var MYErrorMsg = "Please fill in your New IC No. in a valid format,\ne.g. 810231-07-4123."
	var SGErrorMsg = "Please fill in your IC No. in a valid format,\ne.g. S1234567D."

	if (country.value == 'MY') {
		if (vl.value == '000000-00-0000') {
			alert(MYErrorMsg);
			focusAndSelect(obj);
			return false;
		} else if (!validMYIC.test(Trim(obj.value))) {
			alert(MYErrorMsg);
			focusAndSelect(obj);
			return false;
		}
	} else if (country.value=='SG') {
		if (!validSGIC.test(Trim(obj.value))) {
			alert(SGErrorMsg);
			focusAndSelect(obj);
			return false;
		}
	}
}

function validateOldIC(obj, country) {
	validated = true;

	var validMYOLDIC = /^\D{1}\d{7}$/;

	// Error messages
	var MYErrorMsg = "Please fill in your Old IC No. in a valid format,\ne.g. A2388098."

	if (country.value == 'MY') {
		if (!validMYIC.test(Trim(obj.value))) {
			alert(MYErrorMsg);
			focusAndSelect(obj);
			return false;
		}
	}
}

/*============================================================================
 *  Password related
 ===========================================================================*/
 
function validatePassword(objPassowrd, objConfirmPassword) {
	if (objPassowrd.value.length < 4) {
		alert("<%=lang.display("MSG_JS_PASSWD_ATLEAST")%>");
		focusAndSelect(objPassowrd);
		validated = false;
		return false;
	}	
 	
  if (objPassowrd.value == objConfirmPassword.value) {
		validated = true;
		return true;
	} else {
		focusAndSelect(objConfirmPassword);
		alert("<%=lang.display("MSG_JS_PASSWD_NOTMATCH")%>");
		validated = false;
		return false;
	}
}

function countPassword(obj) {
	if (obj.value.length < 4  || obj.value.length > 10 ) {
		alert("<%=lang.display("MSG_JS_PASSWD_ATLEAST")%>");
		focusAndSelect(obj);	
		return false;
	}
	return true;
}
 
/*============================================================================
 *  Payment Mode related
 ===========================================================================*/
 
// luhn cc validator
function ccValidator(ccnum) {
	var checkSum = 0;
	var iMult = 0;
	if(ccnum.length <= 0) return false;
	for(var i=ccnum.length;i>0;i--) {
		iDigit = (iMult % 2 + 1) * parseInt(ccnum.substring(i-1,i));
		checkSum += (iDigit > 9) ? (iDigit - 9) : iDigit;
		iMult++;
	}//for
	return (checkSum % 10 == 0) && (checkSum > 0);
} //ccValidator
      
/*============================================================================
 *  Member related
 ===========================================================================*/

// Restrict user from entering \s on Id
function enterMemberId(obj) {
  
  var result = obj.value;

  if (result.indexOf(" ") >= 0) {
    var parseStr = "";
    
    for (var i=0; i<result.length; i++) {
      if (result.charAt(i) != " ")
        parseStr = parseStr + result.charAt(i);
    }
    
    result = parseStr;
    obj.value = result;
  }
}

function validateMemberId(obj) {

	var validId = /^([a-z]{2}\d{10})$/i;

	var vl = TrimAll(obj.value);

	if (vl == "")
		return false;
  
	vl = vl.toUpperCase();

	if (vl != "HQ")
		return validId.test(vl);
	else 
		return true;
}

function validateStockistId(obj) {

	var validId = /^([m,M,s,S,f,F]{1}[A-Z|0-9]{5})$/i;

	var vl = TrimAll(obj.value);

	if (vl == "")
		return false;
	
	obj.value = vl.toUpperCase();
	return validId.test(vl);
}

function validateStockistIdOnlyNumbers(obj) {

	var validCode = /^([A-Z|0-9]{5})$/i; // /\d{5}$/;
	
	var vl = TrimAll(obj.value);
	
	obj.value = vl.toUpperCase();
	return validCode.test(vl);
}

function validateStockistUserId(obj) {

	var validId = /^([a-z]{4,10})$/i;

	var vl = TrimAll(obj.value);

	if (vl == "")
		return false;
  
	vl = vl.toUpperCase();

	if (vl != "HQ")
		return validId.test(vl);
	else 
		return true;
}

function validateAdminUserId(obj) {

	var validId = /^([a-z|0-9]{4,10})$/i;

	var vl = TrimAll(obj.value);

	if (vl == "")
		return false;

	obj.value = vl;
	
	if (vl != "HQ")
		return validId.test(vl);
	else 
		return true;
}

// Standard check alphanumeric ony
function validateId(obj) {
	
	var validId = /^([a-z|0-9]{4,10})$/i;

	var vl = obj.value; //TrimAll(obj.value);

	if (vl == "")
		return false;

	obj.value = vl;	
	return validId.test(vl);
}

function validateMemberRegisterFormNo(obj) {
	
	return true;
	
	/*
	var vl = Trim(obj.value);
	
	if (vl == "") {
    alert("Invalid Member Register Form No.");
    focusAndSelect(obj);
    return false;
	} else
		return true;
	*/
}

function validateMemberIntroducer(intrID, intrIdentityNo, missing) {
	
	var chkIntrID = validateText(intrID);
	
	if (missing == "0") { // No missing introducer is allow during registration
	
		if (!chkIntrID)
			return false;
		else 
			return true;
			
	} else {
		
		var chkIntrIdentityNo = validateText(intrIdentityNo);
		
		if (!chkIntrIdentityNo && !chkIntrID)
			return false;
		else
			return true;
			
	}
} 

function validateDupID(memberID, intrID) {
	
	var temp1 = Trim(memberID.value);
	var temp2 = Trim(intrID.value);
	
	if (temp1 == temp2)
		return false;
	else 
		return true;
}

function validateDupIdentity(memberIdentityNo, intrIdentityNo) {
	
	var temp1 = Trim(memberIdentityNo.value);
	var temp2 = Trim(intrIdentityNo.value);
	
	if (temp1 == temp2)
		return false;
	else 
		return true;
}

function updateDob(vl, obj, country) {
	
  var vl = Trim(vl.value);
  
  if (country == 'MY') {
	  if (vl.length == 12) {
		  obj.value = vl.substring(4,6) +"-"+ vl.substring(2,4) +"-19"+ vl.substring(0,2);
	  }
  }
}	

/*============================================================================
 *  Address related
 ===========================================================================*/
 
function validateZipCode(obj) {

	var validCode = /\d{5}$/;
	
	var vl = TrimAll(obj.value);
	
	return validCode.test(vl);
}

/*============================================================================
 *  String related
 ===========================================================================*/

// Remove all spaces in an object value
function TrimObjValue(obj) {
  obj.value = Trim(obj.value);
}
  	  
// Remove all spaces to the right and left of a String
function Trim(str) {

  var res = /^\s+/ig;
  var ree = /\s+$/ig;
	
  var out = str.replace(res,"").replace(ree,"");
  return out;
}

// Removes all spaces in a String
function TrimAll(str) {
	
  var rem = /\s+/ig;
  var out = Trim(str);
	
  out = out.replace(rem, "");
  return out;
}
  
/*============================================================================
 *  Number related
 ===========================================================================*/
  
function isMoney(amt) {
	var x = 1;
	if (isNaN(amt)) {
		x = 0;
		return x;
	} else
		return x;
}

function isPositive(amt) {
	var x = 1;
	if (amt < 0) {
		x = 0;
		return x;
	}
	else
		return x;
}

function isZero(amt) {
	var x = 0;
	if (amt == 0) {
		x = 1;
		return x;
	} else
		return x;
}   
  
/*============================================================================
 *  Date related
 ===========================================================================*/
   
var dtCh= "-";

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}

function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}

function isDate(obj){
	var dtStr = obj.value
	var msg = "Invalid date!"
	
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1) {
		focusAndSelect(obj);
    //alert(msg);
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		focusAndSelect(obj);
    //alert(msg);
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		focusAndSelect(obj);
    //alert(msg);
		return false
	}
	if (strYear.length != 4 || year==0){
		focusAndSelect(obj);
    //alert(msg);
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		focusAndSelect(obj);
    //alert(msg);
		return false
	}
	return true
}

/*============================================================================
 *  Control related
 ===========================================================================*/

function validateText(obj) {
	var temp_str = Trim(obj.value);
		
	if (temp_str == "") {
		obj.value = "";
		focusAndSelect(obj);
  	return false;
	} else {
		obj.value = temp_str;
		return true;
	}
}

function validateTextNoFocus(obj) {
	var temp_str = Trim(obj.value);
	
	if (temp_str == "") {
		obj.value = "";
  	return false;
	} else {
		obj.value = temp_str;
		return true;
	}
}

function validateObj(obj, compulsory) {

	if (getValueFromCtl(obj) == "" && compulsory=="1") {
		obj.focus();
		return false;
	} else {
		return true;
	}
}

function getValueFromCtl(obj) {
	for (var i=0; i < obj.options.length; i++) {		
		if (obj.options[i].selected ) {
			if (obj.options[i].value == "" || obj.options[i].value == "0" || obj.options[i].value == "-" || obj.options[i].value == "00" || obj.options[i].value == "000") {
				return "";
			} else
				return obj.options[i].value;
		}
	}
	
	return "";
}

 
function focusAndSelect(obj) {
  obj.focus();
  obj.select();
}

function loadCombobox(obj, selectedValue) {
	for (var i = 0; i < obj.length; i++) {
		if (obj.options[i].value == selectedValue){
			obj.options[i].selected = true;
			return;
		}
	}
}

function IsOn(oControl) {
	oControl.style.backgroundColor = "#FEE800";
}
	
function IsOff(oControl) {
	oControl.style.backgroundColor = "#000000";
}
 
/*============================================================================
 *  Window related
 ===========================================================================*/

function popupSmall(link) {
  window.open(link , '', 'menubr=no,resizable=no,toolbar=no,scrollbars=yes,status=no,width=500,height=400,screenX=0,screenY=0');
}

function popupViewDoc(link) {
  window.open(link , '', 'menubr=no,resizable=yes,toolbar=no,scrollbars=yes,status=no,width=550,height=600,screenX=0,screenY=0');
}

function popupViewSmallReceipt(link) {
  window.open(link , '', 'menubr=no,resizable=yes,toolbar=no,scrollbars=yes,status=no,width=300,height=600,screenX=0,screenY=0');
}

function popupHelpPage(sURL, iWidth, iHeight) {
	window.open(sURL,"Help","menubar=no,resizable=no,status=no,scrollbars=yes,width=" + iWidth + ",height=" + iHeight + ",location=no");
}

/*============================================================================
 *  Input Validation
 ===========================================================================*/
 
function checkNumeric(e)
{
    var unicode=e.charCode? e.charCode : e.keyCode
    if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
    if (unicode<48||unicode>57) //if not a number
        return false //disable key press
    }
}
</script>  
