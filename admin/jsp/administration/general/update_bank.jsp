<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BankBean bank = (BankBean) returnBean.getReturnObject("BankBean");
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

<form name="add" action="<%=Sys.getControllerURL(BankManager.TASKID_UPDATE_BANK_SUBMIT,request)%>" method="post">
<std:input name="OldBankId" type="hidden" value="<%=bank.getBankID()%>"/>
<div class="functionhead"><i18n:label code="ADMIN_BANK_UPDATE"/></div>
<br>
	
<table width=500>
	<tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/>:</td>
	 	<td>
	 		<select name="countryid">
	 			 <%@ include file="/common/select_locations.jsp"%>
	   		</select>
	 	</td>
	 </tr> 
	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=BankMessageTag.BANK_ID%>"/> (2-5 <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CHARS%>"/>):</td>
	 	<td><std:input name="id" type="text" value="<%=bank.getBankID()%>" size="5" maxlength="5" /></td>
	 </tr>
 	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/>:</td>
	 	<td><std:input type="text" name="name" value="<%=bank.getName()%>" size="50" maxlength="50"/></td>
	 </tr>
	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.OTHER_NAME%>"/>:</td>
	 	<td><std:input type="text" name="othername" value="<%=bank.getOtherName()%>" size="50" maxlength="50"/></td>
	 </tr>	
	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=BankMessageTag.SWIFT_CODE%>"/>:</td>
	 	<td><std:input type="text" name="swiftcode" value="<%=bank.getSwiftCode()%>" size="20" maxlength="20" /></td>
	 </tr>		
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" onclick="return confirmSubmit()"></td></tr>
</table>

</form>

 </body>
</html>