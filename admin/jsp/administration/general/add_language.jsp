<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
%>


<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<html>
<head>
<script LANGUAGE="JavaScript">
<!--
function confirmSubmit()
{
	var agree=confirm("Confirm ?");
	if (agree)
		return true ;
	else
		return false ;
}
// -->
</script>

 
<%@ include file="/lib/header.jsp"%>

</head>
 <body>

<form name="addtask" action="<%=Sys.getControllerURL(LanguageManager.TASKID_ADD_NEW_LANGUAGE,request)%>" method="post">
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=LanguageMessageTag.ADD_LANGUAGE%>"/></div>
<br>
	
<table width=500>
	 <tr>
	 	<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=LanguageMessageTag.LOCALE_ID%>"/>:</td>
	 	<td><input type="text" name="localeid" value="" size="6" maxlength="5"></td>
	 </tr>
 	 <tr>
	 	<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
	 	<td><input type="text" name="description" value="" size="50" maxlength="50"></td>
	 </tr>	
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="ADD" onclick="return confirmSubmit()"></td></tr>
</table>

</form>

 </body>
</html>