<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@page import="com.ecosmosis.orca.bonus.commision.CommissionBean"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	CommissionBean[] beans = (CommissionBean[]) returnBean.getReturnObject("BonusList");
	
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	 	
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusPeriodList");	
	TreeMap orderbys = (TreeMap) returnBean.getReturnObject("OrderByList");
	
	Integer count = (Integer)  returnBean.getReturnObject("Count");
	if (count == null) count = new Integer(0);
	
	java.text.DecimalFormat dollar = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
%> 
		
</head>

	<body>
	<div class="functionhead">Stockist Annual Sales Submission Report</div>
 	<form method="post" name="taxlist" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_ADMIN_ANNUAL_STKT_SALES_REPORT, request)%>">
 	
 	<table class="listbox" width=350>
	 <tr>
	 	<td width="100" class="odd" >Bonus Period<br>(From)</td>
	 	<td><std:input type="select" name="fromPeriodid" options="<%=periods%>"/></td>
	 </tr> 
	 <tr>
	 	<td width="100" class="odd" >Bonus Period<br>(To)</td>
	 	<td><std:input type="select" name="toPeriodid" options="<%=periods%>"/></td>
	 </tr> 

	  <tr>
	 	<td width="100" class="odd">Order By</td>
	 	<td><std:input type="select" name="orderby" options="<%=orderbys%>"/> &nbsp<input type="submit" value="GO"></td>
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

<table class="listbox" width="60%">
		  <tr class="boxhead">
		  		<td align="center">No.</td>
		  		<td align="center">Stockist ID</td>
		  		<td align="center" width="200">Name</td>
		  		<td align="center">Distr ID</td>		  		
		  		<td align="center">Annual<br>Total<br>Sales</td>
		  		<td align="center">Annual<br>Total<br>Commission</td>
		  </tr>
		  
<%		  
			double[] subtotal = new double[2];
			
			for (int i=0 ; i<beans.length; i ++) {
				
				subtotal[0] += beans[i].getAnnualSales();
				subtotal[1] += beans[i].getAnnualCommissions();

%>
		   <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td><%=(i+1)%></td>
		  		<td><%=beans[i].getStockistCode()%></td>
		  		<td><%=beans[i].getStockistName()%></td>
		  		<td><%=beans[i].getMemberID()%></td>
		  		<td align="right"><%=dollar.format(beans[i].getAnnualSales())%></td>
		  		<td align="right"><%=dollar.format(beans[i].getAnnualCommissions())%></td>
		  </tr>	

<% } // end for %>
				
 			<tr class="boxhead">
		  		<td >&nbsp;</td>
		  		<td >&nbsp</td>
		  		<td >&nbsp</td>
		  		<td >&nbsp</td>
		  		<td align="right"><%=dollar.format(subtotal[0])%></td>
		  		<td align="right"><%=dollar.format(subtotal[1])%></td>
		  </tr>
  
</table>
<br>
<input type=button name="btnPrint" value="PRINT" onClick="window.print();">


<% } // end canView %>
	
	</body>
</html>
