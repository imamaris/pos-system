<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.stmtdetails.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@page import="com.ecosmosis.orca.bonus.commision.CommissionBean"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.bonus.chi.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusList");
	int gotStmt = 0;
	
	String specmsg = "";
	
	if (periods != null && periods.size() > 0)
	 	gotStmt = 1;
	else if (periods != null && periods.size() == 0)
	{
	 	gotStmt = 2;
	 	specmsg = "No Bonus Statement For This Stockist.";
 	}
 	
 	BonusPeriodBean period = (BonusPeriodBean) returnBean.getReturnObject("BonusPeriod");	
	CommissionBean bean = (CommissionBean) returnBean.getReturnObject("BonusStmt");
	MemberBean member = null;
	StockistBean stockist = null;
	boolean canView = false;
	if (bean != null)
	{
	 	canView = true;
	 	member = bean.getMemberBean();
	 	stockist = bean.getStockist();
	} 	 	
	
	java.text.DecimalFormat dollar = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat pointvalue = new java.text.DecimalFormat("#,##0.000000");
	java.text.DecimalFormat pvpoint = new java.text.DecimalFormat("#,##0.00");
%> 


<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<html>
<head>
  <%@ include file="/lib/header.jsp"%>
  <script language="javascript">
	 function doSearch(thisform) {
		
		if (!validateStockistId(thisform.StockistID)) {
			alert("Invalid Stockist ID.");
			focusAndSelect(thisform.StockistID);
			return false;
		}else{			
			return true;
		}  	    		
	} 
  </script>	
		
</head>

	<body>
	<div class="functionhead">Commission Statement</div>
 	<form method="post" name="stmt" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_ADMIN_COMMS_VIEW_STMT,request)%>" onSubmit="return doSearch(document.stmt);">
 	
 	<%@ include file="/general/mvc_return_msg.jsp"%>
 	
 	<table class="listbox" width=350>
 	 <tr>
	 	<td width="150" class="odd">Stockist ID</td>
	 	<td><std:stockistid form="stmt" name="StockistID"/></td>
	 	<td rowspan="2" align="center"><input type="submit" value="GO"></td>
	 </tr>	

<% if (gotStmt == 1) {%>
	 <tr>
	 	<td width="150" class="odd">Bonus Period</td>
	 	<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=request.getParameter("periodid")%>"/></td>
	 </tr> 
<% } %>
	 
	</table>
    </form>

<%=specmsg%>
    
<% if (canView) { %>    

	<table class="listbox" width="500">
	     <tr class="boxhead">
		 	<td colspan=2">Stockist Information</td>
		 </tr>
	 	 <tr>
		 	<td width="30%" class="odd">Stockist ID</td>
		 	<td><%=bean.getStockistCode()%></td>
		 </tr>
		 <tr>
		 	<td class="odd">Name</td>
		 	<td><%=bean.getStockistName()%></td>
		 </tr>
		 <tr>
		 	<td class="odd">Type</td>
		 	<td><%=StockistManager.defineStockistType(bean.getStockistType())%></td>
		 </tr>
		 <tr>
		 	<td class="odd">Distributor ID</td>
		 	<td><%=stockist.getMemberID()%></td>
		 </tr>
		 <tr>
		 	<td class="odd">Mobile Number</td>
		 	<td><%=stockist.getMobileTel()%></td>
		 </tr>
	</table>
	<br>
	<table class="listbox" width="500">
	 	 <tr class="boxhead">
		 	<td colspan=2">Stockist Commission For <%=period.getPeriodID()%></td>
		 </tr>
		 <tr>
		 	<td class="odd"><b>Stockist Sales</b></td>
		 	<td align="right"><b><std:currencyformater code="" value="<%=(bean.getTotalStockistSales())%>" /></b></td>
		 </tr>
		 <tr>
		 	<td class="odd"><b>Total Commission</b></td>
		 	<td align="right"><b><std:currencyformater code="" value="<%=(bean.getTotalStockistBonus())%>" /></b></td>
		 </tr>
	</table>
	<br>
	<input type=button name="btnPrint" value="PRINT" onClick="window.print();">
<% } // end canView %>
	

	</body>
</html>
