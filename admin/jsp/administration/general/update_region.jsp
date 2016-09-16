<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LocationBean bean = (LocationBean) returnBean.getReturnObject("LocationBean");
	TreeMap parents = (TreeMap) returnBean.getReturnObject("LocationList");
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

<form name="add" action="<%=Sys.getControllerURL(LocationManager.TASKID_UDPATE_REGION_SUBMIT,request)%>" method="post">
<input type="hidden" name="locid" value="<%=bean.getLocationID()%>">

<div class="functionhead"><i18n:label code="ADMIN_REGION_UPDATE"/></div>
<br>
	
<table width=400 class="listbox">
	<tr>
	 	<td class="odd" width="180"><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.PARENT%>"/>:</td>
	 	<td><std:input type="select" name="parentid" options="<%=parents%>" value="<%=bean.getParentID()%>"/></td>
	 </tr>
      <tr>
	 	<td class="odd" width="200" nowrap><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.LOCATION_ID%>"/> :</td>
	 	<td><%=bean.getLocationID()%></td>
	 </tr>
 	 <tr>
	 	<td class="odd" width="200" nowrap><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/>:</td>
	 	<td><std:input type="text" name="name" value="<%=bean.getName()%>" size="50" maxlength="50" status="onChange=\"toUpperCase(document.add.name)\""/></td>
	 </tr>	
</table>


 
<table width=400 border="0" cellspacing="0" cellpadding="0" >
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" onclick="return confirmSubmit()"></td></tr>
</table>

</form>

 </body>
</html>