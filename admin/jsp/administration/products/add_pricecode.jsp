<%@ page import="com.ecosmosis.orca.pricing.*"%>
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

<form name="add" action="<%=Sys.getControllerURL(PriceCodeManager.TASKID_ADD_NEW_PRICECODE,request)%>" method="post">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.ADD_PRICE_CODE%>"/></div>

<table><tr><td height="10"></td></tr></table>

<br>
	
<table width="100%">
	 <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE_CODE_ID%>"/> (2-5 <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CHARS%>"/>):</td>
	 	<td><input type="text" name="pricecode" value="" size="5" maxlength="5"></td>
	 </tr>
 	 <tr>
	 	<td class="td1" width=""180""><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
	 	<td><input type="text" name="name" value="" size="60" maxlength="200"></td>
	 </tr>
	 <!--
	 <tr>
	 	<td class="td1" width=""180""><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.CONTROL_LOCATION%>"/>:</td>
	 	<td>
	 		<select name="locationid">
					<%@ include file="/common/select_locations.jsp"%>
	   		</select>
	 	</td>
	 </tr>
	 --> 
	 <tr>
	 	<td class="td1" width=""180""><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.CURRENCY%>"/>:</td>
	 	<td>
	 		<select name="currency">
					<%@ include file="/common/select_currency.jsp"%>
	   		</select>
	 	</td>
	 </tr>  
	 <tr>
	 	<td class="td1" width=""180""><i18n:label code="GENERAL_TYPE"/>:</td>
	 	<td>
	 		<select name="type">
					<%@ include file="/common/select_pricecode_types.jsp"%>
	   		</select>
	 	</td>
	 </tr>

<!--	 	 	
	  <tr>
	 	<td class="td1" width=""180""><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.COPY_PRICING_INFO_FROM%>"/>:</td>
	 	<td>
	 		<select name="currency">
					<%@ include file="/common/select_pricecode.jsp"%>
	   		</select>
	 	</td>
	 </tr>
-->

</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_ADD"/>" onclick="return confirmSubmit()"></td></tr>
</table>

<std:input type="hidden" name="locationid" value="HQ"/>

</form>

 </body>
</html>