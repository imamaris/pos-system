<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	int totalBonus = 0;
	int totalCommission = 0;
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusPeriodList");
	String periodIdStr = (String) returnBean.getReturnObject("PeriodID");
	BonusMasterBean[] bonusList = (BonusMasterBean[]) returnBean.getReturnObject("BonusList");
	BonusMasterBean[] commissionList = (BonusMasterBean[]) returnBean.getReturnObject("CommissionList");
	if (commissionList == null)
		commissionList = new BonusMasterBean[0];
	
	if (returnBean.getReturnObject("TotalBonusRecord") != null)
		totalBonus = (Integer) returnBean.getReturnObject("TotalBonusRecord");
	if (returnBean.getReturnObject("TotalCommissionRecord") != null)
		totalCommission = (Integer) returnBean.getReturnObject("TotalCommissionRecord");
	
	String periodid = request.getParameter("periodid");
	
	boolean canView = false;
	if (bonusList != null)
		canView = true;
	
	java.text.DecimalFormat bonusDecimal = new java.text.DecimalFormat("0.00");
%>

<html>
<head>
	<title></title>
	
	<%@ include file="/lib/header.jsp"%>
</head>

<body>
  
<div class="functionhead">Export Bonus</div>	

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="exp_bonus" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_EXPORT_BONUS, request)%>" method="post">
<table class="listbox" width="250">
	<tr>
			<td width="100" class="odd">Bonus Period</td>
			<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=periodid%>"/> &nbsp;<input class="noprint textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_GO"/>"></td>
		</tr>
</table>
<input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>">
</form>
<% if (canView){ %>
<form name="exp_bonus_list" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_EXPORT_BONUS_SUBMIT, request)%>" method="post">
<input type="hidden" name="periodid" value="<%=periodid%>"/>
<table>
	<tr>
		<td>
			<table class="listbox">
				<tr>
					<td class="totalhead" width="170"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TOTAL%>"/> Records Found</td>
					<td width="80"><%= totalBonus + totalCommission %></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<% if (totalBonus > 0 || totalCommission > 0){ %>
		<td>
			<br><input class="noprint textbutton" type="submit" value="EXPORT TEXT FILE">
		</td>
		<% } %>
	</tr>
</table>

<br>

<table class="listbox" width="40%">
	<tr class="boxhead">
		<td><i18n:label code="GENERAL_NUMBER"/></td>
		<td><i18n:label code="BONUS_PERIOD"/></td>
		<td><i18n:label code="MBR003"/></td>
		<td>Total Bonus</td>
	</tr>
	<%
		int count = 0;
		for (int i=0; i<bonusList.length; i++) {
			BonusMasterBean bonus = (BonusMasterBean) bonusList[i];
			++count;
	%>
	<tr class="<%=((i%2==1)?"odd":"even")%>">
		<td><%= count %></td>
		<td><%= bonus.getPeriodID() %></td>
		<td><%= bonus.getMemberID() %></td>
		<td align="right"><std:currencyformater code="" value="<%= bonus.getTotalBonus() %>"/></td>
	</tr>
	<% } %>
	<%
		for (int k=0; k<commissionList.length; k++) {
			BonusMasterBean commission = (BonusMasterBean) commissionList[k];
			++count;
	%>
	<tr class="<%=((k%2==1)?"odd":"even")%>">
		<td><%= count %></td>
		<td><%= commission.getPeriodID() %></td>
		<td><%= commission.getMemberID() %></td>
		<td align="right"><std:currencyformater code="" value="<%= commission.getTotalStockistBonus() %>"/></td>
	</tr>
	<% } %>
</table>
</form>
<% } // end if canview %>
</body>
</html>