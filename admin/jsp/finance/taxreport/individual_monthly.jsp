<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BonusMasterBean[] beans = (BonusMasterBean[]) returnBean.getReturnObject("BonusList");
	
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	 	
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusPeriodList");	
	TreeMap orderbys = (TreeMap) returnBean.getReturnObject("OrderByList");
	TreeMap views = (TreeMap) returnBean.getReturnObject("ViewTypeList");
	
	boolean viewDetails = false;
	String viewtype = request.getParameter("viewtype");
	if (viewtype != null && viewtype.equals("B"))
		viewDetails = true;
	
	
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
	<div class="functionhead">Individual Monthly Income Tax Report  (Tax Art 21 Report)</div>
 	<form method="post" name="taxlist" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_ADMIN_INDV_TAX_REPORT ,request)%>">
 	
 	<table class="listbox" width=350>
	 <tr>
	 	<td width="100" class="odd">Bonus Period</td>
	 	<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=request.getParameter("periodid")%>"/></td>
	 </tr> 
	 <tr>
	 	<td width="100" class="odd">View Type</td>
		<td><std:input type="select" name="viewtype" options="<%=views%>" value="<%=request.getParameter("viewtype")%>"/></td>
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

<table class="listbox" width="95%">
		  <tr class="boxhead">
		  		<td align="center">No.</td>
		  		<td align="center">Distr ID</td>
		  		<td align="center" width="200">Name</td>
		  		<td align="center">Tax No.</td>
		  		<td align="center">Tax Group</td>
		  		<td align="center">Total<br>Bonus</td>
		  		<td align="center">Non<br>Taxable<br>Bonus</td>
		  		<td align="center">Annual<br>Non<br>Taxable<br>Bonus</td>
		  		<td align="center">Taxable<br>Bonus</td>
		  		<td align="center">Annual<br>Taxable<br>Bonus</td>
		  		<td align="center">Tax Paid</td>
<% if (viewDetails) { %> <td align="center" width="300">Remark</br> <% } %>
		  </tr>
		  
<%		  
			double[] subtotal = new double[5];
			
			for (int i=0 ; i<beans.length; i ++) {
				
				subtotal[0] += beans[i].getTotalBonus();
				subtotal[1] += beans[i].getNonTaxableIncome();
				subtotal[2] += beans[i].getTaxableIncome();
			    subtotal[3] += beans[i].getTax();
%>
		   <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td><%=(i+1)%></td>
		  		<td><%=beans[i].getMemberID()%></td>
		  		<td><%=beans[i].getMemberName()%></td>
		  		<td align="center"><%=beans[i].getTaxNo()%></td>
		  		<td align="center"><%=beans[i].getTaxGroupName()%></td>
		  		<td align="right"><%=dollar.format(beans[i].getTotalBonus())%></td>
		  		<td align="right"><%=dollar.format(beans[i].getNonTaxableIncome())%></td>
		  		<td align="right"><%=dollar.format(beans[i].getAnnualNonTaxLimit())%></td>
		  		<td align="right"><%=dollar.format(beans[i].getTaxableIncome())%></td>
		  		<td align="right"><%=dollar.format(beans[i].getAnnualTaxedIncome())%></td>
		  		<td align="right"><%=dollar.format(beans[i].getTax())%></td>
<% if (viewDetails) { %> <td align="right"><%=beans[i].getTaxRemark()%></td> <% } %>
		  </tr>	

<% } // end for %>
				
 			<tr class="boxhead">
		  		<td >&nbsp;</td>
		  		<td >&nbsp</td>
		  		<td >&nbsp</td>
		  		<td >&nbsp</td>
		  		<td >&nbsp</td>
		  		<td >&nbsp</td>
		  		<td align="right"><%=dollar.format(subtotal[0])%></td>
		  		<td align="right"><%=dollar.format(subtotal[1])%></td>
		  		<td align="right"><%=dollar.format(subtotal[2])%></td>
		  		<td >&nbsp</td>
		  		<td align="right"><%=dollar.format(subtotal[3])%></td>
<% if (viewDetails) { %> <td>&nbsp</br> <% } %>
		  </tr>

		  	
		  
</table>



<% } // end canView %>
	
	</body>
</html>