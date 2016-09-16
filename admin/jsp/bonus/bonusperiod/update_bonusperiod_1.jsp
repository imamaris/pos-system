<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bvwallet.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BonusPeriodBean bean = (BonusPeriodBean) returnBean.getReturnObject("BonusPeriodBean");
	TreeMap bonusstatuslist = (TreeMap) returnBean.getReturnObject("BonusStatusList");
	TreeMap types = (TreeMap) returnBean.getReturnObject("PeriodTypeList");
	TreeMap recordstatuslist = (TreeMap) returnBean.getReturnObject("StatusList");
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
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<div class="functionhead">Update Initial Date</div>

<form name="add" action="<%=Sys.getControllerURL(BonusPeriodManager.TASKID_UPDATE_BONUSPERID_SUBMIT,request)%>" method="post">
<std:input name="periodid" type="hidden" value="<%=bean.getPeriodID()%>"/>
	
<table class="listbox" width=600>
	<tr>
		<td width="200"  class="odd"><i18n:label code="BONUS_PERIOD_ID"/></td>
		<td><%=bean.getPeriodID()%></td>
	</tr>	
	<tr>
		<td width="200"  class="odd"><i18n:label code="GENERAL_DATE_START"/> (<%= SystemConstant.DEFAULT_DATEFORMAT %>)</td>
		<td><std:input type="date" value="<%=bean.getStartDate()%>" name="startdate"  size="12"/></td>
	</tr>	
	<tr>
		<td width="200"  class="odd"><i18n:label code="GENERAL_DATE_END"/> (<%= SystemConstant.DEFAULT_DATEFORMAT %>)</td>
		<td><std:input type="date" value="<%=bean.getEndDate()%>" name="enddate" size="12"/></td>
	</tr>	
	<tr>
		<td width="200" class="odd"><i18n:label code="BONUS_PERIOD_TYPE"/></td>
		<td><std:input type="select" name="periodtype" options="<%=types%>" value="<%=Integer.toString(bean.getType())%>"/></td>
	</tr> 
	<tr>
		<td width="200"  class="odd"><i18n:label code="BONUS_MONTH"/> / <i18n:label code="BONUS_YEAR"/></td>
		<td><std:input type="select" name="bonusmonth" options="<%=months%>" value="<%=bean.getBonusMonth()%>"/><std:input type="select" name="bonusyear" options="<%=years%>" value="<%=bean.getBonusYear()%>"/></td>
	</tr>	
	<tr>
		<td width="200" class="odd"><i18n:label code="BONUS_PERIOD_STATUS"/></td>
		<td><std:input type="select" name="status" options="<%=bonusstatuslist%>" value="<%=Integer.toString(bean.getPeriodstatus())%>"/></td>
	</tr> 
	<tr>
		<td width="200" class="odd"><i18n:label code="GENERAL_STATUS"/></td>
		<td><std:input type="select" name="recordstatus" options="<%=recordstatuslist%>" value="<%=bean.getStatus()%>"/></td>
	</tr> 
</table>

<table width=500 border="0" cellspacing="0" cellpadding="0" >
	<tr><td>&nbsp</td></tr>
	<tr class="head">
		<td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" onclick="return confirmSubmit()"></td>
	</tr>
</table>

</form>

<br>

</body>
</html>