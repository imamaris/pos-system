<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bvwallet.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	TreeMap types = (TreeMap) returnBean.getReturnObject("PeriodTypeList");
	TreeMap months = (TreeMap) returnBean.getReturnObject("MonthMaps");
	TreeMap years = (TreeMap) returnBean.getReturnObject("YearMaps");
%>


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
 
<div class="functionhead"><i18n:label code="BONUS_PERIOD_ADD"/></div>

<%@ include file="/general/mvc_return_msg.jsp"%>

<form name="add" action="<%=Sys.getControllerURL(BonusPeriodManager.TASKID_ADD_NEW_BONUSPERID,request)%>" method="post">

<table  class="listbox" width=600>
	<tr>
		<td width="200" class="odd"><i18n:label code="BONUS_PERIOD_ID"/></td>
		<td ><input type="text" name="periodid"  size="12" maxlength="20"></td>
	</tr>	
	<tr>
	<td width="200"  class="odd"><i18n:label code="GENERAL_DATE_START"/> (<%= SystemConstant.DEFAULT_DATEFORMAT %>)</td>
	  <td><std:input type="date" name="startdate"  size="12"/></td>
	</tr>	 
	<tr>
		<td width="200"  class="odd"><i18n:label code="GENERAL_DATE_END"/> (<%= SystemConstant.DEFAULT_DATEFORMAT %>)</td>
		<td><std:input type="date" name="enddate" size="12"/></td>
	</tr>	
	<tr>
		<td width="200" class="odd"><i18n:label code="BONUS_PERIOD_TYPE"/></td>
		<td><std:input type="select" name="periodtype" options="<%=types%>" value="<%=request.getParameter("periodtype")%>"/></td>
	</tr> 
	<tr>
		<td width="200"  class="odd"><i18n:label code="BONUS_MONTH"/> / <i18n:label code="BONUS_YEAR"/></td>
		<td><std:input type="select" name="bonusmonth" options="<%=months%>" value="<%=request.getParameter("bonusmonth")%>"/><std:input type="select" name="bonusyear" options="<%=years%>" value="<%=request.getParameter("bonusyear")%>"/></td>
	</tr>	
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 	<tr><td>&nbsp</td></tr>
 	<tr class="head">
 		<td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_ADD"/>" onclick="return confirmSubmit()"></td>
 	</tr>
</table>

</form>

</body>
</html>