<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
%>


<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script LANGUAGE="JavaScript">
<!--

function toUpperCase(obj)
{
	obj.value = obj.value.toUpperCase();
}

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

<form name="add" action="<%=Sys.getControllerURL(LocationManager.TASKID_ADD_NEW_COUNTRY,request)%>" method="post" onSubmit="return confirmSubmit();">
<input type="hidden" name="parentid" value="HQ">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.ADD_COUNTRY%>"/></div>
<br>
	
<table width=500>
	 <tr>
	 	<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.LOCATION_ID%>"/> (2-5 <i18n:label code="GENERAL_CHAR"/>):</td>
	 	<td><input type="text" name="locid" value="" size="7" maxlength="7" onChange="toUpperCase(document.add.locid)"></td>
	 </tr>
 	 <tr>
	 	<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/>:</td>
	 	<td><input type="text" name="name" value="" size="50" maxlength="50" onChange="toUpperCase(document.add.name)"></td>
	 </tr>	
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_ADD"/>" ></td></tr>
</table>

</form>

 </body>
</html>