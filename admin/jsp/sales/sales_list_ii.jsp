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
<%@page import="com.ecosmosis.mvc.sys.SystemConstant"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
	Map trxTypeMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_TRXTYPELIST_CODE);
	
	Map sellerMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SELLERLIST_CODE);
	
	Map bonusPeriodMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_BNSPERIODLIST_CODE);
	
	Map deliveryStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_DELIVERYSTATUS_CODE);
	
	Map trxStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_STATUS_CODE);

	Map orderByMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_ORDERBY_CODE);
	
	Map recordsMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SHOWRECS_CODE);
	
	ArrayList confirmBonusPeriodList = (ArrayList) returnBean.getReturnObject(CounterSalesManager.RETURN_CFIMBNSPERIODLIST_CODE);
	
	CounterSalesOrderBean[] beans = (CounterSalesOrderBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SALESLIST_CODE);
	
    boolean canView = beans != null;
%>

<html>
<head>
<title></title>

	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
    <!--
  	function doSubmit() {
		
		var myform = document.frmSearch;
		myform.action="<%=Sys.getControllerURL(CounterSalesManager.TASKID_SALES_LIST_TYPEII,request)%>";
		myform.target='';
    	myform.submit();
  	}      	 
  	function doPrint() {
		
		window.open('' , 'newWindowPrint', 'menubr=no,resizable=yes,toolbar=no,scrollbars=yes,status=no,width=300,height=600,screenX=0,screenY=0');
		
		var myform = document.frmSearch;
		myform.action="<%=Sys.getControllerURL(CounterSalesManager.TASKID_SALES_LIST_TYPES_PRINT,request)%>&print=chi";
		myform.target='newWindowPrint';
    	myform.submit();
    	
  	}
  	//--> 
	</script>
		
</head>

<body>

<div class="functionhead"><i18n:label code="SALES_LISTING"/> for Chi Network</div>

<form name="frmSearch" action="" method="post" onSubmit="doSubmit();">
	<table border="0">
		<tr>
	    <td class="td1"><i18n:label code="SALES_COUNTER"/>:</td>
			<td><std:input type="select" name="SellerID" options="<%= sellerMap %>" /></td>
			<td>&nbsp;</td>
	    <td class="td1"><i18n:label code="BONUS_PERIOD"/>:</td>
			<td><std:input type="select" name="BonusPeriodID" options="<%= bonusPeriodMap %>" /></td>
	  </tr>
	  <tr>
	    <td class="td1"><i18n:label code="SALES_REFERENCE"/>:</td>
	    <td><std:input type="text" name="TrxDocNo" size="30" maxlength="20"/></td>
	    <td>&nbsp;</td>
	    <td class="td1"><i18n:label code="SALES_TRX_TYPE"/>:</td>
	    <td><std:input type="select" name="TrxType" options="<%= trxTypeMap %>" /></td>
	  </tr>
	  <tr>
	  	<td class="td1"><i18n:label code="GENERAL_ID"/>:</td>
	  	<td><std:memberid name="CustomerID" form="frmSearch"/></td>
	    <td>&nbsp;</td>
	    <td class="td1"><i18n:label code="GENERAL_NAME"/>:</td>
	    <td><std:input type="text" name="CustomerName" size="30" maxlength="50"/></td>
	  </tr>
	  <tr>
	  	<td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_FROM"/>:</td>
	    <td><std:input type="date" name="TrxDateFrom" value="now"/></td>
	    <td>&nbsp;</td>
	    <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_TO"/>:</td>
	    <td><std:input type="date" name="TrxDateTo" value="now"/></td>
	  </tr>
	  <tr>
	  	<td class="td1"><i18n:label code="GENERAL_STATUS"/>:</td>
	    <td><b>Active</b>
	    <input type=hidden name="Status" value="30"></select>
	    </td>
	  	<td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	  </tr>
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
	<input class="textbutton" type="button" value="PRINT RECEIPTS" onClick="doPrint();">
</form>

<hr>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<form name="frmList" action="" method="post">

<table class="listbox" width="70%">
  <tr class="boxhead" valign=top>
    <td><i18n:label code="GENERAL_NUMBER"/></td>
    <td><i18n:label code="SALES_REFERENCE"/></td>
    <td><i18n:label code="GENERAL_CUSTOMER"/></td>
    <td><i18n:label code="SALES_TRX_DATE"/></td>
    <td><i18n:label code="BONUS_PERIOD"/></td>
    <!--td align="right"><i18n:label code="GENERAL_TOTAL"/> PV</td-->
    <td align="right"><i18n:label code="GENERAL_NET_TOTAL"/></td>
  </tr>
	
  <%
  	double grdTotalBV = 0.0d;
  	double grdNetSales = 0.0d;
  	double grdNetSales_Type = 0.0d;
    
  	boolean isOutletSales = false;
  	boolean isStockistSales = false;
  	boolean isActive = false;
  	boolean isNew = false;
  	boolean isBonusConfirmed = false;
  	
  	for (int i=0; i<beans.length; i++) { 
    	
		String rowCss = "";
				
	  	if((i+1) % 2 == 0)
      		rowCss = "even";
	    else
        	rowCss = "odd";
			
	    isBonusConfirmed = false;
	  	
		if (beans[i].getSellerTypeStatus().equalsIgnoreCase(CounterSalesManager.TYPE_OUTLET)) {
			isOutletSales = true;
		} else {
		 	isOutletSales = false;
		}
 		
		if (beans[i].getSellerTypeStatus().equalsIgnoreCase(CounterSalesManager.TYPE_STOCKIST)) {
			isStockistSales = true;
		} else {
			isStockistSales = false;
		}
      	isActive = beans[i].getStatus() == CounterSalesManager.STATUS_ACTIVE;
	  	isNew = beans[i].isTodayTrx();
	  	
      	if (isActive) {
	  		grdTotalBV += beans[i].getTotalBv1();
      	
	  		grdNetSales += beans[i].getChiSalesAmount();
      	
	      	if (beans[i].getBonusPeriodID() != null && confirmBonusPeriodList.contains(beans[i].getBonusPeriodID())) {
	      		isBonusConfirmed = true;
	      	}
      	
  		} else {
        	rowCss = "alert";
    	}
  %>
  
	<tr class="<%= rowCss %>" valign=top>
    <td nowrap><%= i+1 %>.</td>
    <td nowrap>
    	<small><std:link text="<%= beans[i].getTrxDocNo() %>" taskid="<%= CounterSalesManager.TASKID_VIEW_SALES_TYPEII %>" params="<%=("SalesID="+beans[i].getSalesID())%>" /></small>
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
    <!--td align="right" nowrap><std:bvformater value="<%= beans[i].getTotalBv1() %>"/></td-->
    <td align="right" nowrap><std:currencyformater code="" value="<%= beans[i].getChiSalesAmount() %>"/></td>
  </tr>
		    
	<% 
		} // end for 
	%>
	
	<tr class="totalhead">
		<td  colspan="5" align="right"><i18n:label code="GENERAL_GRAND_TOTAL"/></td>
		<!--td align="right"><std:bvformater value="<%= grdTotalBV %>"/></td-->
		<td align="right"><std:currencyformater code="" value="<%= grdNetSales %>"/></td>
	</tr>
		
</table>  
</form>

<% 
	} // end canView
%>

</body>
</html>
