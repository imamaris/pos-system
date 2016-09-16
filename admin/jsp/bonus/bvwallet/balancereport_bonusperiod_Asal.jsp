<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bvwallet.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BvWalletBean[] beans = (BvWalletBean[]) returnBean.getReturnObject("BvWalletList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	 	
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusPeriodList");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">BV Wallet Balance Report</div>
 	<form method="post" name="bonuslist" action="<%=Sys.getControllerURL(BvWalletManager.TASKID_BALANCEREPORT_BY_PERIOD,request)%>">
 	
 	<table class="listbox" width=500>
	 <tr>
	 	<td width="100" class="odd">Bonus Period</td>
	 	<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=request.getParameter("periodid")%>"/></td>
	 </tr>
	 <tr>
	 	<td width="100" class="odd">Order By</td>
	 	<td>
	 		<select name="orderby">
					<%@ include file="/common/select_bvwallet_orderby.jsp"%>
	   		</select>
	   		&nbsp<input type="submit" value="GO">
	 	</td>
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

<% if (canView) { 
	
	double[] total = new double[10];
	
%>    
<table><tr><td>Total Records Found : <%=beans.length%></td></tr></table>

<table  class="listbox" width="60%">
		  <tr class="boxhead">
		  		<td>No.</td>
		  		<td>ID</td>
		  		<td>Name</td>
		  		<td>BV Balance</td>
		  		<td>BV1 Balance</td>
		  </tr>
		  
<%		  for (int i=0 ; i<beans.length; i ++) {

	 	total[0] += beans[i].getBvBalance();
	 	total[1] += beans[i].getBv1Balance();
	 	total[2] += beans[i].getBv2Balance();
	 	total[3] += beans[i].getBv3Balance();
	 	total[4] += beans[i].getBv4Balance();
	 	
	 	total[5] += (total[0]+total[1]+total[2]+total[3]+total[4]);
	
%>
		  <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td><%=(i+1)%></td>
		  		<td><%=beans[i].getOwnerID()%></td>
		  		<td><%=beans[i].getOwnerName()%></td>
		  		<td align="right"><%=number.format(beans[i].getBvBalance())%></td>
		  		<td align="right"><%=number.format(beans[i].getBv1Balance())%></td>
		  </tr>	

<% } // end for %>	

		 <tr class="boxhead">
		  		<td colspan="3">&nbsp;</td>
		  		<td align="right"><%=number.format(total[0])%></td>
		  		<td align="right"><%=number.format(total[1])%></td>
		 </tr>

		  
</table>

<% } // end canView %>
	
	</body>
</html>
