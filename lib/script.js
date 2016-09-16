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
		alert('Your password should contain at least 4 to 10 characters for security reasons.');
		focusAndSelect(objPassowrd);
		validated = false;
		return false;
	}	
 	
  if (objPassowrd.value == objConfirmPassword.value) {
		validated = true;
		return true;
	} else {
		focusAndSelect(objConfirmPassword);
		alert('Your password confirmation does not match, please re-enter your password');
		validated = false;
		return false;
	}
}

function countPassword(obj) {
	if (obj.value.length < 4  || obj.value.length > 10 ) {
		alert('Your password should contain at least 4 to 10 characters for security reasons.');
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


function validateZipCode(obj) {

	var validCode = /\d{5}$/;
	
	var vl = TrimAll(obj.value);
	
	return validCode.test(vl);
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
 *  Sort table related
 ===========================================================================*/

//<![CDATA[

//-----------------------------------------------------------------------------
// sortTable(id, col, rev)
//
//  id  - ID of the TABLE, TBODY, THEAD or TFOOT element to be sorted.
//  col - Index of the column to sort, 0 = first column, 1 = second column,
//        etc.
//  rev - If true, the column is sorted in reverse (descending) order
//        initially.
//
// Note: the team name column (index 1) is used as a secondary sort column and
// always sorted in ascending order.
//-----------------------------------------------------------------------------

function sortTable(id, col, rev) {

  // Get the table or table section to sort.
  var tblEl = document.getElementById(id);

  // The first time this function is called for a given table, set up an
  // array of reverse sort flags.
  if (tblEl.reverseSort == null) {
    tblEl.reverseSort = new Array();
    // Also, assume the team name column is initially sorted.
    tblEl.lastColumn = 1;
  }

  // If this column has not been sorted before, set the initial sort direction.
  if (tblEl.reverseSort[col] == null)
    tblEl.reverseSort[col] = rev;

  // If this column was the last one sorted, reverse its sort direction.
  if (col == tblEl.lastColumn)
    tblEl.reverseSort[col] = !tblEl.reverseSort[col];

  // Remember this column as the last one sorted.
  tblEl.lastColumn = col;

  // Set the table display style to "none" - necessary for Netscape 6 
  // browsers.
  var oldDsply = tblEl.style.display;
  tblEl.style.display = "none";

  // Sort the rows based on the content of the specified column using a
  // selection sort.

  var tmpEl;
  var i, j;
  var minVal, minIdx;
  var testVal;
  var cmp;

  for (i = 0; i < tblEl.rows.length - 1; i++) {

    // Assume the current row has the minimum value.
    minIdx = i;
    minVal = getTextValue(tblEl.rows[i].cells[col]);

    // Search the rows that follow the current one for a smaller value.
    for (j = i + 1; j < tblEl.rows.length; j++) {
      testVal = getTextValue(tblEl.rows[j].cells[col]);
      cmp = compareValues(minVal, testVal);
      // Negate the comparison result if the reverse sort flag is set.
      if (tblEl.reverseSort[col])
        cmp = -cmp;
      // Sort by the second column (team name) if those values are equal.
      if (cmp == 0 && col != 1)
        cmp = compareValues(getTextValue(tblEl.rows[minIdx].cells[1]),
                            getTextValue(tblEl.rows[j].cells[1]));
      // If this row has a smaller value than the current minimum, remember its
      // position and update the current minimum value.
      if (cmp > 0) {
        minIdx = j;
        minVal = testVal;
      }
    }

    // By now, we have the row with the smallest value. Remove it from the
    // table and insert it before the current row.
    if (minIdx > i) {
      tmpEl = tblEl.removeChild(tblEl.rows[minIdx]);
      tblEl.insertBefore(tmpEl, tblEl.rows[i]);
    }
  }

  // Make it look pretty.
  makePretty(tblEl, col);

  // Set list sequence.
  setSequence(tblEl, col, rev);

  // Restore the table's display style.
  tblEl.style.display = oldDsply;

  return false;
}

//-----------------------------------------------------------------------------
// Functions to get and compare values during a sort.
//-----------------------------------------------------------------------------

// This code is necessary for browsers that don't reflect the DOM constants
// (like IE).
if (document.ELEMENT_NODE == null) {
  document.ELEMENT_NODE = 1;
  document.TEXT_NODE = 3;
}

function getTextValue(el) {

  var i;
  var s;

  // Find and concatenate the values of all text nodes contained within the
  // element.
  s = "";
  for (i = 0; i < el.childNodes.length; i++)
    if (el.childNodes[i].nodeType == document.TEXT_NODE)
      s += el.childNodes[i].nodeValue;
    else if (el.childNodes[i].nodeType == document.ELEMENT_NODE &&
             el.childNodes[i].tagName == "BR")
      s += " ";
    else
      // Use recursion to get text within sub-elements.
      s += getTextValue(el.childNodes[i]);

  return normalizeString(s);
}

function compareValues(v1, v2) {

  var f1, f2;

  // If the values are numeric, convert them to floats.

  f1 = parseFloat(v1);
  f2 = parseFloat(v2);
  if (!isNaN(f1) && !isNaN(f2)) {
    v1 = f1;
    v2 = f2;
  }

  // Compare the two values.
  if (v1 == v2)
    return 0;
  if (v1 > v2)
    return 1
  return -1;
}

// Regular expressions for normalizing white space.
var whtSpEnds = new RegExp("^\\s*|\\s*$", "g");
var whtSpMult = new RegExp("\\s\\s+", "g");

function normalizeString(s) {

  s = s.replace(whtSpMult, " ");  // Collapse any multiple whites space.
  s = s.replace(whtSpEnds, "");   // Remove leading or trailing white space.

  return s;
}

//-----------------------------------------------------------------------------
// Functions to update the table appearance after a sort.
//-----------------------------------------------------------------------------

// Style class names.
var rowClsNm = "odd";
var colClsNm = "sortedColumn";

// Regular expressions for setting class names.
var rowTest = new RegExp(rowClsNm, "gi");
var colTest = new RegExp(colClsNm, "gi");

function makePretty(tblEl, col) {

  var i, j;
  var rowEl, cellEl;

  // Set style classes on each row to alternate their appearance.
  for (i = 0; i < tblEl.rows.length; i++) {
   rowEl = tblEl.rows[i];
   rowEl.className = rowEl.className.replace(rowTest, "");
    if (i % 2 != 0)
      rowEl.className += " " + rowClsNm;
    rowEl.className = normalizeString(rowEl.className);
    // Set style classes on each column (other than the name column) to
    // highlight the one that was sorted.
    for (j = 1; j < tblEl.rows[i].cells.length; j++) {
      cellEl = rowEl.cells[j];
      cellEl.className = cellEl.className.replace(colTest, "");
      if (j == col)
        cellEl.className += " " + colClsNm;
      cellEl.className = normalizeString(cellEl.className);
    }
  }

  // Find the table header and highlight the column that was sorted.
  var el = tblEl.parentNode.tHead;
  rowEl = el.rows[el.rows.length - 1];
  // Set style classes for each column as above.
  for (i = 1; i < rowEl.cells.length; i++) {
    cellEl = rowEl.cells[i];
    cellEl.className = cellEl.className.replace(colTest, "");
    // Highlight the header of the sorted column.
    if (i == col)
      cellEl.className += " " + colClsNm;
      cellEl.className = normalizeString(cellEl.className);
  }
}

function setSequence(tblEl, col, rev) {

  // Determine whether to start at the top row of the table and go down or
  // at the bottom row and work up. This is based on the current sort
  // direction of the column and its reversed flag.

  var i    = 0;
  var incr = 1;
  if (tblEl.reverseSort[col])
    rev = !rev;
  if (rev) {
    incr = -1;
    i = tblEl.rows.length - 1;
  }

  // Now go through each row (from top to bottom) and display its rank. Note
  // that when two or more rows are tied, the rank is shown on the first of
  // those rows only.

  var rowEl, cellEl;
  var lastRank = 0;
  var _counter = counter;
  // Go through the rows from top to bottom.
  for (i = 0; i < tblEl.rows.length; i++) {
    rowEl = tblEl.rows[i];
    cellEl = rowEl.cells[0];
    // Delete anything currently in the rank column.
    while (cellEl.lastChild != null)
      cellEl.removeChild(cellEl.lastChild);
    // If this row's rank is different from the previous one, Insert a new text
    // node with that rank.
    if (col >= 1 && rowEl.rank != lastRank) {
      cellEl.appendChild(document.createTextNode((_counter++) + "."));
      lastRank = _counter;
    }
  }
}

function setRanks(tblEl, col, rev) {

  // Determine whether to start at the top row of the table and go down or
  // at the bottom row and work up. This is based on the current sort
  // direction of the column and its reversed flag.

  var i    = 0;
  var incr = 1;
  if (tblEl.reverseSort[col])
    rev = !rev;
  if (rev) {
    incr = -1;
    i = tblEl.rows.length - 1;
  }

  // Now go through each row in that direction and assign it a rank by
  // counting 1, 2, 3...

  var count   = 1;
  var rank    = count;
  var curVal;
  var lastVal = null;

  // Note that this loop is skipped if the table was sorted on the name
  // column.
  while (col > 1 && i >= 0 && i < tblEl.rows.length) {

    // Get the value of the sort column in this row.
    curVal = getTextValue(tblEl.rows[i].cells[col]);

    // On rows after the first, compare the sort value of this row to the
    // previous one. If they differ, update the rank to match the current row
    // count. (If they are the same, this row will get the same rank as the
    // previous one.)
    if (lastVal != null && compareValues(curVal, lastVal) != 0)
        rank = count;
    // Set the rank for this row.
    tblEl.rows[i].rank = rank;

    // Save the sort value of the current row for the next time around and bump
    // the row counter and index.
    lastVal = curVal;
    count++;
    i += incr;
  }

  // Now go through each row (from top to bottom) and display its rank. Note
  // that when two or more rows are tied, the rank is shown on the first of
  // those rows only.

  var rowEl, cellEl;
  var lastRank = 0;

  // Go through the rows from top to bottom.
  for (i = 0; i < tblEl.rows.length; i++) {
    rowEl = tblEl.rows[i];
    cellEl = rowEl.cells[0];
    // Delete anything currently in the rank column.
    while (cellEl.lastChild != null)
      cellEl.removeChild(cellEl.lastChild);
    // If this row's rank is different from the previous one, Insert a new text
    // node with that rank.
    if (col > 1 && rowEl.rank != lastRank) {
      cellEl.appendChild(document.createTextNode(rowEl.rank));
      lastRank = rowEl.rank;
    }
  }
}

//]]>

	
  
