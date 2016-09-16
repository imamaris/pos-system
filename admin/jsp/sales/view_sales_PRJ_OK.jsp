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
  CounterSalesOrderBean bean = (CounterSalesOrderBean) returnBean.getReturnObject("CounterSalesOrderBean");
  CounterSalesOrderBean adjstBean = (CounterSalesOrderBean) returnBean.getReturnObject("AdjstCounterSalesOrderBean");
  
  OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
  
  // UtilsManager utilsMgr = new UtilsManager();

  boolean canView = bean != null;

%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>

</head>

<body>

<div class="functionhead"><i18n:label code="SALES_ORDER_VIEW"/></div>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<br>

<table width="100">
	<tr>
		<td>&nbsp;</td>
                
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT_RECP"/>" onClick="javascript:popupViewSmallReceipt('<%=Sys.getControllerURL(CounterSalesManager.TASKID_DOC_CB_RECEIPT,request) %>&SalesID=<%= bean.getSalesID() %>')">
		</td>              
                
		<% 
			if (bean.isImmediateDelivery() && bean.isDisplayDelivery()) {
		%>
		
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT_DO"/>" onClick="javascript:popupViewDoc('<%=Sys.getControllerURL(CounterSalesManager.TASKID_DOC_SALESDO,request) %>&SalesID=<%= bean.getSalesID() %>')">
		</td>
		
		<% 
			}
		%>

		<%
			if (bean.getStatus() != CounterSalesManager.STATUS_ACTIVE && adjstBean != null) {
				
				String printTitle = (bean.getStatus() == CounterSalesManager.STATUS_FULL_REFUNDED) ? "Print Return" : "Print Void";
		%>
		
		<td>
			<input class="noprint textbutton" type="button" value="<%= lang.display(printTitle) %>" onClick="javascript:popupViewDoc('<%= Sys.getControllerURL(CounterSalesManager.TASKID_DOC_CN,request) %>&SalesID=<%= adjstBean.getSalesID() %>')">
		</td>
		
		<%
			}
		%>
		
		<td>&nbsp;</td>
	</tr>
</table>


<table class="tbldata" border="0" width="600">                
        
        <tr valign=top>
	  <td colspan=2 align=right><hr></td>
	</tr>
        <tr valign=top>
            <td colspan=2 align=center> <font size="4" style="bold"> INVOICE </font></td>
	</tr>        
        <tr valign=top>
	  <td colspan=2 align=right><hr></td>
	</tr>
        
        <tr>
		<td valign=top>
			<%@ include file="/admin/jsp/sales/view_sales_document_he.jsp"%>
		</td>
	</tr>

        
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/sales/view_sales_cart_he.jsp"%>                  
		</td>
	</tr>

        
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/sales/view_sales_payment_he.jsp"%>                  
		</td>
	</tr>
        <tr>
		<td valign=top width="600">
			<%@ include file="/admin/jsp/sales/view_sales_customer_he.jsp"%>
		</td>
	</tr>        
	<tr>
		<td colspan="2" width="600">
			<%@ include file="/admin/jsp/sales/view_sales_remark_he.jsp"%>
		</td>
	</tr>
        
  	<tr class=printreceipt>
	  <td colspan="2"></td>   
  </tr>  
  
	<tr class=printreceipt align="center">
	  <td colspan="2">Goods/products have been accepted by the customer as being in good condition.</td>   
  </tr>  
	<tr class=printreceipt align="center">
	  <td colspan="2">Goods/products sold are non-refundable, returnable or exchangeable.</td>   
  </tr>  
  	<tr class=printreceipt align="center">
	  <td colspan="2">Thank you for your patronage.</td>   
  </tr>  
  
  	<tr class=printreceipt>
	  <td colspan="2"></td>   
  </tr> 
  
        <tr>
		<td  colspan="2" align="left">Validation No. : <%= bean.getTrxDocNo().getBytes()%> </td>
	</tr>    
  
        <tr>
		<td colspan="2" align="left">Printed By : <%= bean.getStd_createBy() %></td>
	</tr> 
        
</table>	

<%
	} // end canView
%>
	