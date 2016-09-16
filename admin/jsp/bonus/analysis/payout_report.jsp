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
	<div class="functionhead">Bonus Payout Report</div>


<% if (canView) { %>    
<br>
<table class="listbox" width="80%">
		  <tr class="boxhead">
		  		<td>No.</td>
		  		<td>Period ID</td>
		  		<td>Status</td>
		  		<td>Total<br>PVV</td>
                <td>Total<br>Monthly<br>Bonus</td>
                <td>Total<br>Annual<br>Bonus</td>
                <td>Total<br>Distr<br>Bonus</td>
                <td>Total<br>Stockist<br>Bonus</td>
                <td>Total<br>Bonus</td>
                <td>Total<br>Bonus<br>Value<br>(in Rp)</td>
                <td>Total<br>Tax<br>(in Rp)</td>
		  </tr>
		  
<%		  for (int i=0 ; i<beans.length; i++) {	
				double totaldistrbonus = beans[i].getTotalMonthlyBonus()+beans[i].getTotalPeriodicalBonus();
				double totalbonus = totaldistrbonus+beans[i].getTotalStockistBonus();
%>
		  <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td align="center"><%=(i+1)%></td>
		  		<td align="center"><%=beans[i].getPeriodID()%></td>
		  		<td align="center"><%=BonusPeriodManager.defineStatus(beans[i].getPeriodstatus())%>
		  		<td align="right"><%=number.format(beans[i].getTotalBv()+beans[i].getTotalBv1())%></td>
                <td align="right"><%=dollar.format(beans[i].getTotalMonthlyBonus())%></td>
                <td align="right"><%=dollar.format(beans[i].getTotalPeriodicalBonus())%></td>
                <td align="right"><%=dollar.format(totaldistrbonus)%></td>
                <td align="right"><%=dollar.format(beans[i].getTotalStockistBonus())%></td>
                <td align="right"><%=dollar.format(totalbonus)%></td>
                <td align="right"><%=dollar.format(totalbonus)%></td>
                <td align="right"<%=dollar.format(beans[i].getTotalTax())%></td>
		  		
		  </tr>	

<% } // end for %>	
</table>

<% } // end canView %>
	
	</body>
</html>
