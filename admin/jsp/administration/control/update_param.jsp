<%@ page import="com.ecosmosis.common.sysparameters.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	TreeMap paramtype = (TreeMap) returnBean.getReturnObject("TypeList");
	TreeMap cattype = (TreeMap) returnBean.getReturnObject("CategoryList");
	SystemParametersBean bean = (SystemParametersBean) returnBean.getReturnObject("ParamBean");
	
%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script LANGUAGE="JavaScript">
<!--
function confirmSubmit(thisform)
{
  	
  	if(!validateValue(thisform.paramvalue)){
  		alert("<i18n:label code="MSG_INVALID_PARAM_VALUE"/>");
		focusAndSelect(thisform.paramvalue);
		return false;
  	}
  	
	var agree=confirm("<i18n:label code="MSG_CONFIRM"/>");
	if (agree)
		return true ;
	else
		return false ;
}

function validateValue(obj) 
{
	var vl = obj.value;
	if (vl == "")
		return false;
	else
		return true;
}


// -->
</script>
</head>

<body>
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<form name="add" action="<%=Sys.getControllerURL(SystemParametersManager.TASKID_UPDATE_SYSPARAM_SUBMIT,request)%>" method="post">
<input type="hidden" name="paramid" value="<%=bean.getParamID()%>">

<div class="functionhead"><i18n:label code="ADMIN_PARAM_UPDATE"/></div>
<br>
	
<table width='70%'>
	 <tr>
	 	<td class="odd" width="180"><i18n:label code="ADMIN_PARAM_ID"/></td>
	 	<td><%=bean.getParamID()%></td>
	 </tr>
 	 <tr>
	 	<td class="odd" width="180"><i18n:label code="GENERAL_TYPE"/></td>
	 	<td><std:input type="select" options="<%=paramtype%>" value="<%=bean.getType()%>"  name="paramtype" /> </td>
	 </tr>
	  <tr>
	 	<td class="odd" width="180"><i18n:label code="GENERAL_CATEGORY"/></td>
	 	<td><std:input type="select" options="<%=cattype%>"  name="cattype" value="<%=bean.getCategory()%>" /> </td>
	 </tr>
	 <tr>
	 	<td class="odd" width="180"><i18n:label code="ADMIN_PARAM_VALUE"/></td>
	 	<td><input type="text" name="paramvalue" value="<%=bean.getValue()%>"  size="50" maxlength="100"></td>
	 </tr>	
	 <tr>
	 	<td class="odd" width="180"><i18n:label code="GENERAL_DESC"/></td>
	 	<td><textarea name="paramdesc" rows="6" cols="70"><%=bean.getDescription()%></textarea></td>
	 </tr>		
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" onclick="return confirmSubmit(document.add)"></td></tr>
</table>

</form>

 </body>
</html>