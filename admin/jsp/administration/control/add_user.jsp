<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.users.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	TreeMap groups = (TreeMap) returnBean.getReturnObject("UserGroupList");
	
%>


<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script LANGUAGE="JavaScript">
<!--
function confirmSubmit()
{
	var agree=confirm("<%=lang.display("MSG_CONFIRM")%>");
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

function confirmProceed(thisform) {

  	if(!validateAdminUserId(thisform.id)){
  		
  		alert("<%=lang.display("MSG_INVALID_USERID")%>");
		focusAndSelect(thisform.id);
		return false;
  	}
  	
   	if (!countPassword(thisform.password)) {
			return false;
  	}
	if(thisform.name.value == ''){  		
  		alert("<%=lang.display("MSG_INVALID_NAME")%>");
  		focusAndSelect(thisform.name);
		return false;
  	}  	  	
  	
	if(confirm("<%=lang.display("MSG_CONFIRM")%>"))
	    return true;
	else
	    return false;    
}	
// -->
</script>

</head>
 <body>
 
<%@ include file="/general/mvc_return_msg.jsp"%>



<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.ADD_NEW_ADMIN_USR%>"/></div>

<br>

<form name="groupform" action="<%=Sys.getControllerURL(AdminManager.TASKID_ADD_USER,request)%>" method="post" >	
<table width=100%>
	 <tr>
	 	<td class="td1" width="180"><i18n:label code="<%=ControlCtrMessageTag.USR_GRP_ID%>"/></td>
	 	<td><std:input type="select" name="usergroup" options="<%=groups%>" value="<%=request.getParameter("usergroup")%>" status="onChange=getGroup();" /></td>
	 </tr>
</table>
</form>

<form name="addform" action="<%=Sys.getControllerURL(AdminManager.TASKID_ADD_USER,request)%>" method="post" onSubmit="return confirmProceed(document.addform);">	
<table width=100%>	
	 <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.USER_ID%>"/> (4-10 <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CHARS%>"/>):</td>
	 	<td><input type="text" name="id" value="" size="10" maxlength="10"></td>
	 </tr>
	  <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.PASSWORD%>"/> (4-10 <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CHARS%>"/>):</td>
	 	<td><input type="password" name="password" value="" size="10" maxlength="10"></td>
	 </tr>
 	 <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/>:</td>
	 	<td><input type="text" name="name" value="" size="50" maxlength="50"></td>
	 </tr>
	  <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.WORKING_OUTLET%>"/>:</td>
	 	<td>
	 		<select name="outletid">
	 			 <%@ include file="/common/select_outlets.jsp"%>
	   		</select>
	 	</td>
	 </tr> 
	 <tr>
	 	<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.MGMT_HIERARCHY%>"/>:</td>
	 	<td>
	 		<select name="mgmt_locid">
	 			 <%@ include file="/common/select_locations.jsp"%>
	   		</select>
	 	</td>
	 </tr> 

	 
	  <tr><td>&nbsp</td></tr>
	   <tr><td>&nbsp</td></tr>

</table>

<table width=700 border="0" cellspacing="0" cellpadding="0" >	 
	 <tr>
	 	<td align="left"><b><u><i18n:label code="ADMIN_SYS_ACCESS_RIGHTS"/><u/></b></td>
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
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_ADD"/>" ></td></tr>
</table>

</form>

</body>
</html>