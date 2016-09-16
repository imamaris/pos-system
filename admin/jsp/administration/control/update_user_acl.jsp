<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.users.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);	
	AdminLoginUserBean userBean = (AdminLoginUserBean) returnBean.getReturnObject("UserBean");
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

function getGroup(){
var myform = document.groupform;
myform.submit();
}

// -->
</script>

 
<%@ include file="/lib/header.jsp"%>

</head>
 <body>
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<div class="functionhead">Update Admin ACL</div>

<form name="addform" action="<%=Sys.getControllerURL(AdminManager.TASKID_ADMIN_UPDATE_ACL_SETTINGS_SUBMIT,request)%>" method="post">	
<input type="hidden" name="memberid" value="<%=userBean.getUserId()%>">

<table width=100%>	
		<tr>
		  <td  width="180" class="td1"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.USER_ID%>"/> </td>
		     <td>: <b><%=userBean.getUserId()%></b></td>
		</tr>
		<tr >
		  <td  width="180" class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
		     <td>: <b><%=userBean.getUserName()%></b></td>
		</tr>
	  <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.WORKING_OUTLET%>"/></td>
	 	<td>: <b><%=userBean.getOutletID()%></b>
	 		
	 	</td>
	 </tr> 
	 <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.MGMT_HIERARCHY%>"/></td>
	 	<td>: <b><%=userBean.getOperationLocationBean().getName()%> (<%=userBean.getOperationLocationBean().getLocationID()%>)</b>
	 </tr> 

	 
	  <tr><td>&nbsp</td></tr>
	   <tr><td>&nbsp</td></tr>

</table>

<table width=700 border="0" cellspacing="0" cellpadding="0" >	 
	 <tr>
	 	<td align="left"><b><u>System Access Rights<u/></b></td>
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
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" onclick="return confirmSubmit()"></td></tr>
</table>

</form>

 </body>
</html>