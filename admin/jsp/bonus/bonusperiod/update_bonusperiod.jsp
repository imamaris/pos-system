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
		<td width="200"  class="odd">Initial Date</td>
		<td><%=bean.getPeriodID()%></td>
	</tr>		
	<tr>
		<td width="200" class="odd">Status Initial</td>
		<td><std:input type="select" name="status" options="<%=bonusstatuslist%>" value="<%=Integer.toString(bean.getPeriodstatus())%>"/></td>
	</tr> 
	<tr>
		<td width="200" class="odd">Status Active</td>
		<td><std:input type="select" name="recordstatus" options="<%=recordstatuslist%>" value="<%=bean.getStatus()%>"/></td>
	</tr> 
</table>

      <std:input type="hidden" name="startdate" value="<%=bean.getStartDate()%>"/>
      <std:input type="hidden" name="enddate" value="<%=bean.getEndDate()%>"/>
      <std:input type="hidden" name="periodtype" value="<%=Integer.toString(bean.getType())%>"/>
      <std:input type="hidden" name="bonusmonth" value="<%=bean.getBonusMonth()%>"/>
      <std:input type="hidden" name="bonusyear" value="<%=bean.getBonusYear()%>"/>   
      

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