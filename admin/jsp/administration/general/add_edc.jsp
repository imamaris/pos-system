<%@ page import="com.ecosmosis.common.currency.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


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
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<form name="add" action="<%=Sys.getControllerURL(CurrencyManager.TASKID_ADD_NEW_CURRENCY,request)%>" method="post">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=CurrencyMessageTag.ADD_CURRENCY%>"/></div>

<br>
	
<table width="100%">
	 <tr>
	 	<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=CurrencyMessageTag.CURRENCY_SYMBOL%>"/> (2-10 <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CHARS%>"/>):</td>
	 	<td><input type="text" name="id" value="" size="5" maxlength="5"></td>
	 </tr>
 	 <tr>
	 	<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=CurrencyMessageTag.CURRENCY_NAME%>"/>:</td>
	 	<td><input type="text" name="name" value="" size="50" maxlength="100"></td>
	 </tr>
	 <tr>
	 	<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=CurrencyMessageTag.DISPLAY_FORMAT%>"/>:</td>
	 	<td><input type="text" name="format" value="#,##0.00" size="20" maxlength="20"></td>
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