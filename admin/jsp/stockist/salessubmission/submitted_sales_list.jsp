<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.pricing.product.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	
  CounterSalesOrderBean[] beans = (CounterSalesOrderBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SALESLIST_CODE);
	
  boolean canView = beans != null;
%>

<html>
<head>
<title></title>

	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
    
  	function doSubmit(thisform) {
			
    	thisform.submit();
  	}      	 
	</script>
		
</head>

<body>

<div class="functionhead">Submitted Sales Listing</div>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<form name="frmList" action="" method="post">
<div>
<b>Batch Number: <%=request.getParameter("BatchNo")%></b><p><p>
</div>

<table class="listbox" width="100%">
  <tr class="boxhead" valign=top>
    <td>No.</td>
    <td>Sales Ref</td>
    <td>Customer</td>
    <td>Trx Date</td>
    <td>Bonus Period</td>
    <td align="right">Total PV</td>
    <td align="right">Net Amount</td>
	<td>Remark</td>
    <td>Status</td>
  </tr>
	
  <%
  	double grdTotalBV = 0.0d;
  	double grdNetSales = 0.0d;
    
  	boolean isOutletSales = false;
  	boolean isActive = false;
  	boolean isNew = false;
  	
  	for (int i=0; i<beans.length; i++) { 
    	
	  	String rowCss = "";
				
	  	if((i+1) % 2 == 0)
      	rowCss = "even";
      else
        rowCss = "odd";
	  	
      if (beans[i].getSellerTypeStatus().equalsIgnoreCase(CounterSalesManager.TYPE_OUTLET)) {
	      isOutletSales = true;
     	} else {
	     	isOutletSales = false;
     	}
      
      isActive = beans[i].getStatus() == CounterSalesManager.STATUS_ACTIVE;
	  	isNew = beans[i].isTodayTrx();
	  	
      if (isActive) {
	  		grdTotalBV += beans[i].getTotalBv1();
      	grdNetSales += beans[i].getNetSalesAmount();
      	
  		} else {
        rowCss = "alert";
    	}
  %>
  
	<tr class="<%= rowCss %>" valign=top>
    <td nowrap><%= i+1 %>.</td>
    <td nowrap>
    	<small><std:link text="<%= beans[i].getTrxDocNo() %>" taskid="<%= CounterSalesManager.TASKID_VIEW_SALES %>" params="<%=("SalesID="+beans[i].getSalesID())%>" /></small>
    </td>
	  <td nowrap>
	  	<std:text value="<%= beans[i].getCustomerID() %>"/>
			<% if (beans[i].getCustomerID() != null) { %>
			<br>
			<% } %>
		  <std:text value="<%= beans[i].getCustomerName() %>"/>
	  </td>
    <td align="center" nowrap><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= beans[i].getTrxDate() %>" /></td>
    <td align="center" nowrap><std:text value="<%= beans[i].getBonusPeriodID() %>" defaultvalue="-"/></td>
    <td align="right" nowrap><std:bvformater value="<%= beans[i].getTotalBv1() %>"/></td>
    <td align="right" nowrap><std:currencyformater code="" value="<%= beans[i].getNetSalesAmount() %>"/></td>
    <td align="left"><std:text value="<%= beans[i].getRemark() %>" defaultvalue="-"/></td>
    <td align="center" nowrap>
    	<%= CounterSalesManager.defineTrxStatusName(beans[i].getStatus()) %>
    </td>
      
  </tr>
		    
	<% 
		} // end for 
	%>
	
	<tr>
		<td class="totalhead" colspan="5" align="right">Grand Total</td>
		<td align="right"><b><std:bvformater value="<%= grdTotalBV %>"/></b></td>
		<td align="right"><b><std:currencyformater code="" value="<%= grdNetSales %>"/></b></td>
		<td align="right">&nbsp;</td>
	</tr>
		
</table>  
</form>
<input type=button value="BACK" onClick="history.back();">
<% 
	} // end canView
%>

</body>
</html>
