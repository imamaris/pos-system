<%@ page import="com.ecosmosis.common.sysparameters.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	TreeMap paramtype = (TreeMap) returnBean.getReturnObject("TypeList");
	TreeMap cattype = (TreeMap) returnBean.getReturnObject("CategoryList");
%>

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script LANGUAGE="JavaScript">
<!--
function confirmSubmit(thisform)
{
	
	if(!validateID(thisform.paramid)){
  		alert("<i18n:label code="MSG_INVALID_PARAM_ID"/>");
		focusAndSelect(thisform.paramid);
		return false;
  	}
  	
  	if(!validateValue(thisform.paramvalue)){
  		alert("<i18n:label code="MSG_INVALID_PARAM_VALUE"/>");
		focusAndSelect(thisform.paramvalue);
		return false;
  	}
  	
	var agree=confirm("<i18n:label code="MSG_CONFIRM"/>");
	if (agree)
		return true ;
	else
		return false ;
}

function validateID(obj) 
{

	var validId = /^([a-z|0-9|_]{5,30})$/i;
	var vl = TrimAll(obj.value);
	if (vl == "")
		return false;
	obj.value = vl;
	return validId.test(vl);

}

function validateValue(obj) 
{
	var vl = TrimAll(obj.value);
	if (vl == "")
		return false;
	else
		return true;
}


// -->
</script>

</head>
 <body>
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<form name="add" action="<%=Sys.getControllerURL(SystemParametersManager.TASKID_ADD_NEW_SYSPARAM,request)%>" method="post">

<div class="functionhead"><i18n:label code="ADMIN_PARAM_ADD_NEW"/></div>
<br>
	
<table width=60%>
	 <tr>
	 	<td class="odd" width="180"><i18n:label code="ADMIN_PARAM_ID"/></td>
	 	<td><input type="text" name="paramid" value="" size="35" maxlength="30"> (* 5-30 <i18n:label code="GENERAL_ALPHANUM"/>) </td>
	 </tr>
 	 <tr>
	 	<td class="odd" width="180"><i18n:label code="GENERAL_TYPE"/></td>
	 	<td><std:input type="select" options="<%=paramtype%>"  name="paramtype" /> </td>
	 </tr>
	 <tr>
	 	<td class="odd" width="180"><i18n:label code="GENERAL_CATEGORY"/></td>
	 	<td><std:input type="select" options="<%=cattype%>"  name="cattype" /></td>
	 </tr>
	 <tr>
	 	<td class="odd" width="180"><i18n:label code="ADMIN_PARAM_VALUE"/></td>
	 	<td><input type="text" name="paramvalue" size="50" maxlength="100"></td>
	 </tr>	
	 <tr>
	 	<td class="odd" width="180"><i18n:label code="GENERAL_DESC"/></td>
	 	<td><textarea name="paramdesc" rows="6" cols="70"></textarea></td>
	 </tr>		
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_ADD"/>" onclick="return confirmSubmit(document.add)"></td></tr>
</table>

</form>

 </body>
</html>