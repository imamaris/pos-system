<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.orca.bonus.chi.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BonusBean[] beans = (BonusBean[]) returnBean.getReturnObject("BonusList");
	
	String title = (String) returnBean.getReturnObject("ReportTitle");
	Integer task = (Integer) returnBean.getReturnObject("TaskID");
	
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusPeriodList");	
	TreeMap orderbys = (TreeMap) returnBean.getReturnObject("OrderByList");
	TreeMap topnumbers = (TreeMap) returnBean.getReturnObject("TopNumberList");
	
	Integer count = (Integer)  returnBean.getReturnObject("Count");
	if (count == null) count = new Integer(0);
	
	java.text.DecimalFormat dollar = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><%=title%></div>
 	<form method="post" name="bonuslist" action="<%=Sys.getControllerURL(task.intValue(),request)%>">
 	
 	<table class="listbox" width=350>
	 <tr>
	 	<td width="100" class="odd">Bonus Period</td>
	 	<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=request.getParameter("periodid")%>"/></td>
	 </tr> 
	 <tr>
	 	<td width="100" class="odd">Top List</td>
	 	<td><std:input type="select" name="topno" options="<%=topnumbers%>" value="<%=request.getParameter("topno")%>"/></td>
	 </tr> 
	 <tr>
	 	<td width="100" class="odd">Order By</td>
	 	<td><std:input type="select" name="orderby" options="<%=orderbys%>" value="<%=request.getParameter("orderby")%>"/> &nbsp<input type="submit" value="GO"></td>
	 </tr> 
	</table>
    </form>

<%  boolean zeroFound = false;	
	if (beans != null && beans.length == 0)
		zeroFound = true; 	

	if (zeroFound) { 
%>
  	<table><tr><td>No Records Found.</td></tr></table>  
<% } %>
    
    
<% if (canView) { %>    

<table class="listbox" width="80%">
		  <tr class="boxhead">
		  		<td align="center">No.</td>
		  		<td align="center">Distr ID</td>
		  		<td align="center" width="200">Name</td>
		  		<td align="center">Rank</td>
		  		<td align="center">PBV<br>
		  		<td align="center">APBV</br>
		  		<td align="center">PGBV<br>
		  		<td align="center">GBV</br>
		  		<td align="center">AGBV</br>
		  </tr>
		  
<%		  
			for (int i=0 ; i<beans.length; i ++) {
%>
		   <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td><%=(i+1)%></td>
		  		<td><%=beans[i].getMemberID()%></td>
		  		<td><%=beans[i].getMemberName()%></td>
		  		<td align="center"><%=BonusConstants.defineShortRank(beans[i].getCurrentRank())%></td>
		  		<td align="right"><%=number.format(beans[i].getPbv())%><br>
		  		<td align="right"><%=number.format(beans[i].getApbv())%></br>
		  		<td align="right"><%=number.format(beans[i].getPgbv())%><br>
		  		<td align="right"><%=number.format(beans[i].getGbv())%></br>
		  		<td align="right"><%=number.format(beans[i].getAgbv())%></br>
		  </tr>	

<% } // end for %>	
		  
</table>

<% } // end canView %>
	
	</body>
</html>
