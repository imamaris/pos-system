<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.orca.bonus.chi.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BonusPeriodBean[] beans = (BonusPeriodBean[]) returnBean.getReturnObject("BonusPeriodList");
	
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	 	
	java.text.DecimalFormat dollar = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
	
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Bonus Summary Report</div>


<% if (canView) { %>    
<br>
<table class="listbox" width="95%">
		  <tr class="boxhead">
		  		<td>No.</td>
		  		<td>Period ID</td>
		  		<td>Status</td>
		  		<td>Total<br>Members</td>
		  		<td>Total<br>Active<br>Members</td>
		  		<td>Total<br>Company<br>Sales<br>(in Rp)</td>
		  		<td>Total<br>Company<br>BV Sales<br>(in Rp)</td>		  		
		  		<td>Total<br>Company<br>PV</td>
		  		<td>Total<br>Company<br>PV1<br>(Chi Pack)</td>
                                <td>Total<br>Bonus<br>Payout<br>(in Rp)</td>
                                <td>Total<br>Tax<br>(in Rp)</td>
                                <td>Total<br>Admin<br>Fees<br>(in Rp)</td>
                                <td>Total<br>Others<br>Fee<br>(in Rp)</td>
                                <td>Net<br>Payout<br>(in Rp)</td>
                                <td>Stockist<br>Commissions<br>(in Rp)</td>
                                <td>Total<br>Bonus<br>Sharing<br>(in PV)</td>
                                <td>Total<br>Bonus<br>Leadership<br>(in PV)</td>
		  </tr>
		  
<%		  for (int i=0 ; i<beans.length; i++) {	
				double totaldistrbonus = beans[i].getTotalBonus();
				double totalbonus = totaldistrbonus+beans[i].getTotalStockistBonus();
				double net = totaldistrbonus - beans[i].getTotalTax() - beans[i].getTotalAdminFees()- beans[i].getTotalOthersFee();
%>
		  <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td align="center"><%=(i+1)%></td>
		  		<td align="center"><%=beans[i].getPeriodID()%></td>
		  		<td align="center"><%=BonusPeriodManager.defineStatus(beans[i].getPeriodstatus())%>
		  		<td align="right"><%=beans[i].getTotalMembers()%></td>
		  		<td align="right"><%=beans[i].getTotalActiveMembers()%></td>
		  		<td align="right"><%=dollar.format(beans[i].getTotalSales())%></td>
		  		<td align="right"><%=dollar.format(beans[i].getTotalBvSales())%></td>		  		
		  		<td align="right"><%=number.format(beans[i].getTotalBv())%></td>
		  		<td align="right"><%=number.format(beans[i].getTotalBv1())%></td>
                                <td align="right"><%=dollar.format(totaldistrbonus)%></td>
                                <td align="right"><%=dollar.format(beans[i].getTotalTax())%></td>
                                <td align="right"><%=dollar.format(beans[i].getTotalAdminFees())%></td>
                                <td align="right"><%=dollar.format(beans[i].getTotalOthersFee())%></td>                
		  		<td align="right"><%=dollar.format(net)%></td>
		  		<td align="right"><%=dollar.format(beans[i].getTotalStockistBonus())%></td>
		  		<td align="right"><%=dollar.format(beans[i].getTotalCarryForwardBonus1())%></td>
		  		<td align="right"><%=dollar.format(beans[i].getTotalCarryForwardBonus2())%></td>
                            </tr>	

<% } // end for %>	
</table>

<% } // end canView %>
	
	</body>
</html>
