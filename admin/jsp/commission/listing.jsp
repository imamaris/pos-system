<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@page import="com.ecosmosis.orca.bonus.commision.CommissionBean"%>
<%@ page import="com.ecosmosis.orca.bonus.chi.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	CommissionBean[] beans = (CommissionBean[]) returnBean.getReturnObject("BonusList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusPeriodList");	
	String periodid = request.getParameter("periodid");
	
	String rptTitle = (String) returnBean.getReturnObject("ReportTitle");	
  String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
  
  int taskID = 0;
	if (task != null) 
		taskID = Integer.parseInt(task);
%> 


<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><%= rptTitle %></div>
 	<form method="post" name="bonuslist" action="<%=Sys.getControllerURL(taskID,request)%>">
 	
 	<table class="listbox" width=350>
	 <tr>
	 	<td width="100" class="odd">Bonus Period</td>
	 	<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=periodid%>"/> &nbsp<input type="submit" value="GO"></td>
	 </tr> 
	</table>
    </form>

<% if (canView) { %>    
<table><tr><td>Total Records Found : <%=beans.length%></td></tr></table>
<table class="listbox" width="100%">
		  <tr class="boxhead">
		  		<td align="right">No.</td>
		  		<td align="left">Stockist ID</td>
		  		<td align="left" width="200">Name</td>
		  		<td align="left">Distr ID</td>
		  		<td align="center">Cur<br>Rank</td>
		  		<td align="center">Effv<br>Rank</td>
		  		<td align="right">Total<br>Stockist Sales<br>(In Rp)</td>
		  		<td align="right" nowrap>Stockist<br>Commission Payout<br>(In Rp)</td>
		  </tr>
		  
<%		  
			double[] total = new double[3];
			for (int i=0 ; i<beans.length; i ++) {
		
				total[0] += beans[i].getTotalStockistSales();
				total[1] += beans[i].getTotalStockistBonus();
				
%>
		   <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td align="right"><%=(i+1)%>.</td>
		  		<td><std:link taskid="<%=BonusMasterReportManager.TASKID_ADMIN_COMMS_VIEW_STMT%>" text="<%=beans[i].getStockistCode()%>" params="<%="StockistID="+beans[i].getStockistCode()+"&periodid="+periodid%>" /></td>
		  		<td><%=beans[i].getStockistName()%></td>
		  		<td><std:link taskid="<%=BonusMasterReportManager.TASKID_ADMIN_VIEW_STMT%>" text="<%=beans[i].getMemberID()%>" params="<%="memberid="+beans[i].getMemberID()+"&periodid="+periodid%>" /></td>		  		
		  		<td align="center"><%=BonusConstants.defineShortRank(beans[i].getCurrentRank())%></td>
		  		<td align="center"><%=BonusConstants.defineShortRank(beans[i].getEffRank())%></td>
		  		<td align="right"><std:currencyformater code="" value="<%=(beans[i].getTotalStockistSales())%>" /> </td>
		  		<td align="right" nowrap><std:currencyformater code="" value="<%=(beans[i].getTotalStockistBonus())%>" /></td>
		  </tr>	

<% } // end for %>	

		<tr class="boxhead">
		  		<td>&nbsp;</td>
		  		<td>&nbsp;</td>
		  		<td>&nbsp;</td>
		  		<td align="center">&nbsp;</td>
		  		<td align="center">&nbsp;</td>
		  		<td align="center">&nbsp;</td>
		  		<td align="right"><std:currencyformater code="" value="<%=(total[0])%>" /></td>		
		  		<td align="right"><std:currencyformater code="" value="<%=(total[1])%>" /></td>
		  </tr>
		  
</table>
<br>
<input type=button name="btnPrint" value="PRINT" onClick="window.print();">
<% } // end canView %>
	
	</body>
</html>
