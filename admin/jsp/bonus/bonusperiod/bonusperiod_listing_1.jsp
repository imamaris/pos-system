<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BonusPeriodBean[] beans = (BonusPeriodBean[]) returnBean.getReturnObject("BonusPeriodList");
	TreeMap types = (TreeMap) returnBean.getReturnObject("PeriodTypeList");
	TreeMap recordstatuslist = (TreeMap) returnBean.getReturnObject("StatusList");
	
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	 	
	String recordstatus = "A";
	if (request.getParameter("recordstatus") != null)
		recordstatus = request.getParameter("recordstatus");
	 	
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><i18n:label code="BONUS_PERIOD_LIST"/></div>
 	<form method="post" name="list" action="<%=Sys.getControllerURL(BonusPeriodManager.TASKID_BONUSPERID_LISTING,request)%>">
 	<table class="listbox" width=350>
	 <tr>
	 	<td width="120" class="odd"><i18n:label code="BONUS_PERIOD_TYPE"/></td>
	 	<td><std:input type="select" name="periodtype" options="<%=types%>" value="<%=request.getParameter("periodtype")%>"/></td>
	 </tr> 
	 <tr>
	 	<td width="120" class="odd"><i18n:label code="GENERAL_STATUS"/></td>
	 	<td><std:input type="select" name="recordstatus" options="<%=recordstatuslist%>" value="<%=recordstatus%>"/>&nbsp<input type="submit" value="<i18n:label code="GENERAL_BUTTON_GO"/>"></td>
	 </tr>
	</table>
    </form>

<% if (canView) { %>    

<table class="listbox" width="80%">
		  <tr class="boxhead">
		  		<td><i18n:label code="GENERAL_NUMBER"/></td>
		  		<td><i18n:label code="BONUS_PERIOD_ID"/></td>
		  		<td><i18n:label code="BONUS_PERIOD_TYPE"/></td>
		  		<td><i18n:label code="GENERAL_DATE_START"/></td>
		  		<td><i18n:label code="GENERAL_DATE_END"/></td>
		  		<td><i18n:label code="BONUS_MONTH"/></td>
		  		<td><i18n:label code="BONUS_YEAR"/></td>
		  		<td><i18n:label code="BONUS_PERIOD_STATUS"/></td>
		  		<td><i18n:label code="GENERAL_STATUS"/></td>
		  		<td>&nbsp;</td>
		  </tr>
		  
<%		  for (int i=0 ; i<beans.length; i++) {	
%>
		  <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td align="center"><%=(i+1)%></td>
		  		<td align="center"><%=beans[i].getPeriodID()%></td>
		  		<td align="center"><%=BonusPeriodManager.definePeriodType(beans[i].getType())%></td>
		  		<td align="center"><%=beans[i].getStartDate()%></td>
		  		<td align="center"><%=beans[i].getEndDate()%></td>
		  		<td align="center"><%=beans[i].getBonusMonth()%></td>
		  		<td align="center"><%=beans[i].getBonusYear()%></td>
		  		<td align="center"><%=BonusPeriodManager.defineStatus(beans[i].getPeriodstatus())%>
		  		<td align="center"><%=beans[i].getStatus()%></td>
		  		<td align=center><small><std:link text="<%= lang.display("GENERAL_BUTTON_UPDATE") %>" taskid="<%=BonusPeriodManager.TASKID_UPDATE_BONUSPERID%>" params="<%=("periodid="+beans[i].getPeriodID())%>" /></small></td>
		  </tr>	

<% } // end for %>	
</table>

<% } // end canView %>
	
	</body>
</html>
