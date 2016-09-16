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

        //Updated by Ferdi 2015-05-29
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_WEEK ,  -5 );
        //End of Updated
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Initial Date Listing</div>
 	<form method="post" name="list" action="<%=Sys.getControllerURL(BonusPeriodManager.TASKID_BONUSPERID_LISTING,request)%>">
 	<table class="listbox" width=350>
	 <tr>
	 	<td width="120" class="odd">Type</td>
	 	<td><std:input type="select" name="periodtype" options="<%=types%>" value="<%=request.getParameter("periodtype")%>"/></td>
	 </tr> 
	 <tr>
	 	<td width="120" class="odd">Status Active</td>
	 	<td><std:input type="select" name="recordstatus" options="<%=recordstatuslist%>" value="<%=recordstatus%>"/>&nbsp<input type="submit" value="<i18n:label code="GENERAL_BUTTON_GO"/>"></td>
	 </tr>
	</table>
    </form>

<% if (canView) { %>    

<table class="listbox" width="80%">
		  <tr class="boxhead">
		  		<td><i18n:label code="GENERAL_NUMBER"/></td>
		  		<td>Initial Date</td>
		  		<td>Type</td>
		  		<td><i18n:label code="GENERAL_DATE_START"/></td>
		  		<td><i18n:label code="GENERAL_DATE_END"/></td>
		  		<td>Month</td>
		  		<td>Year</td>
		  		<td>Initial Status</td>
		  		<td>Process</td>
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
                                <td align="center"><%=BonusPeriodManager.defineStatus(beans[i].getPeriodstatus())%></td>
                                <% 
                                    //Updated by Ferdi 2015-05-28
                                    if(beans[i].getStartDate().compareTo(cal.getTime()) > 0) { 
                                %>
                                    <td align=center><small><std:link text="<%= lang.display("GENERAL_BUTTON_UPDATE") %>" taskid="<%=BonusPeriodManager.TASKID_UPDATE_BONUSPERID%>" params="<%=("periodid="+beans[i].getPeriodID())%>" /></small></td>
                                <% } else { %>
                                    <td align=center>&nbsp;</td>
                                <% } //End Updated %>
		  </tr>	

<% } // end for %>	
</table>

<% } // end canView %>
	
	</body>
</html>
