<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.users.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
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
	var myform = document.addform;
	if(!validateId(myform.id)){
		
		alert("<%=lang.display("MSG_INVALID_ID")%>");
		myform.id.focus();
		return false;
		
	}else{	
		var agree=confirm("<%=lang.display("MSG_CONFIRM")%>");
		if (agree)
			return true;
		else
			return false;
	}
		
}


function checkKey(obj,str) {
	checkAll(obj.checked,str);
}
		
function checkAll(checked,str)  {
	var numOfSessions = document.addform.accesslist.length;
    var chkstr = str.toString();	
	if(numOfSessions > 1)
	{
			for(var i=0; i<numOfSessions; i++)
			{
				  chk1 = document.addform.accesslist[i].value.substring(0,chkstr.length);
				  if (chk1 == chkstr)
			      	document.addform.accesslist[i].checked = checked;
		    }
	}
	else
	{
		 chk1 = document.addform.accesslist.value.substring(0,chkstr.length-1);
		 if (chk1 == chkstr)
	     	document.addform.accesslist.checked = checked;
	}
}


// -->
</script>
</head>
 
 <body>
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<form name="addform" action="<%=Sys.getControllerURL(AdminManager.TASKID_ADD_USERGROUP,request)%>" method="post" onSubmit="return confirmSubmit();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.ADD_NEW_ADMIN_USR_GRP%>"/></div>

<br>
	
<table width=500>
	 <tr>
	 	<td nowrap class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.GROUP_ID%>"/>:</td>
	 	<td nowrap><std:input type="text" name="id" value="" size="10" maxlength="10" /> ( 4-10 <i18n:label code="GENERAL_ALPHANUM"/> ) </td>
	 </tr>
 	 <tr>
	 	<td nowrap class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.GROUP_NAME%>"/>:</td>
	 	<td nowrap><std:input type="text" name="name" value="" size="50" maxlength="50"/> ( 3-50 <i18n:label code="GENERAL_CHAR"/> ) </td>
	 </tr>	 
	  <tr><td>&nbsp;</td></tr>
	   <tr><td>&nbsp;</td></tr>

</table>

<table width=600 border="0" cellspacing="0" cellpadding="0" >	 
	 <tr>
	 	<td align="left"><b><u><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.SYSTEM_ACCESS_RIGHT%>"/><u/></b></td>
	 </tr>
	  <tr><td>&nbsp;</td></tr>	 
	 <tr>
	 	<td colspan>
	 			<%@ include file="/common/select_functions.jsp"%>
	 	</td>
	 </tr> 
	 
</table>
	 
<table width=600 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_ADD"/>"></td></tr>
</table>

</form>

 </body>
</html>