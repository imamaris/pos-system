<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
%>


<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script LANGUAGE="JavaScript">
<!--
function confirmSubmit()
{
	var agree=confirm("<i18n:label code="MSG_CONFIRM"/>");
	if (agree)
		return true ;
	else
		return false ;
}
// -->
</script>
</head>
 <body>
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<form name="add" action="<%=Sys.getControllerURL(OutletManager.TASKID_ADD_NEW_OUTLET,request)%>" method="post">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.ADD_OUTLET%>"/></div>

<br>
	
<table width="100%">
	 <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_ID%>"/> (2-4 <i18n:label code="GENERAL_CHAR"/>):</td>
	 	<td><input type="text" name="id" value="" size="4" maxlength="4"></td>
	 </tr>
 	 <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_NAME%>"/>:</td>
	 	<td><input type="text" name="name" value="" size="60" maxlength="200"></td>
	 </tr>
	 <!--
	 <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.CONTROL_LOCATION%>"/>:</td>
	 	<td>
	 		<select name="control">
					<%@ include file="/common/select_locations.jsp"%>
	   		</select>
	 	</td>
	 </tr> 
  -->
	 <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OPERATION_COUNTRY%>"/>:</td>
	 	<td>
	 		<select name="operation">
					<%@ include file="/common/select_countries.jsp"%>
	   		</select>
	 	</td>
	 </tr> 	
	 
	 <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TYPE%>"/>:</td>
	 	<td>
	 		<select name="type">
				<option value="B"><i18n:label code="OUTLET_BRANCH"/></option>
	   		</select>
	 	</td>
	 </tr> 

</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_ADD"/>" onclick="return confirmSubmit()"></td></tr>
</table>

<std:input type="hidden" name="control" value="HQ"/>

</form>

 </body>
</html>