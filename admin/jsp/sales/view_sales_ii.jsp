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

  boolean canView = bean != null;
%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>

</head>

<body>
<div class="functionhead"><i18n:label code="SALES_ORDER_VIEW"/>  for Chi Network</div>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<br>

<table width="100">
	<tr>
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT_RECP"/>" onClick="javascript:popupViewSmallReceipt('<%=Sys.getControllerURL(CounterSalesManager.TASKID_DOC_CB_RECEIPT_TYPEII,request) %>&SalesID=<%= bean.getSalesID() %>')">
		</td>
		<!-- td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT_COMP"/>" onClick="javascript:popupViewDoc('<%=Sys.getControllerURL(CounterSalesManager.TASKID_DOC_CB_TYPEII,request) %>&SalesID=<%= bean.getSalesID() %>')">
		</td -->

		<% 
			if (bean.isImmediateDelivery() && bean.isDisplayDelivery()) {
		%>
		
		<!--td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT_DO"/>" onClick="javascript:popupViewDoc('<%=Sys.getControllerURL(CounterSalesManager.TASKID_DOC_SALESDO,request) %>&SalesID=<%= bean.getSalesID() %>')">
		</td -->
		
		<% 
			}
		%>

		<%
			if (bean.getStatus() != CounterSalesManager.STATUS_ACTIVE && adjstBean != null) {
				
				String printTitle = (bean.getStatus() == CounterSalesManager.STATUS_FULL_REFUNDED) ? "GENERAL_BUTTON_PRINT_REFUNDCN" : "GENERAL_BUTTON_PRINT_CN";
		%>
		
		<!--td>
			<input class="noprint textbutton" type="button" value="<%= lang.display(printTitle) %>" onClick="javascript:popupViewDoc('<%= Sys.getControllerURL(CounterSalesManager.TASKID_DOC_CN,request) %>&SalesID=<%= adjstBean.getSalesID() %>')">
		</td-->
		
		<%
			}
		%>
		
		<td>&nbsp;</td>
	</tr>
</table>

<table class="tbldata" width="600">
	<tr>
		<td width="300" valign=top>
			 <%@ include file="/admin/jsp/sales/view_sales_parties.jsp"%>
		</td>
		<td width="300" valign=top>
			<%@ include file="/admin/jsp/sales/view_sales_document.jsp"%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
		  <%@ include file="/admin/jsp/sales/view_sales_delivery.jsp"%>
		</td>
	</tr>
	<tr>
		<td valign=top>
			 <%@ include file="/admin/jsp/sales/view_sales_trx.jsp"%>
		</td>
		<td valign=top>
			<%@ include file="/admin/jsp/sales/view_sales_status.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/sales/view_sales_cart_ii.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<!-- tr valign=top>
		<td colspan="2" width="500">
		  <%@ include file="/admin/jsp/sales/view_sales_payment.jsp"%>
		</td>
	</tr -->
	<tr>
		<td colspan="2" width="500">
			<%@ include file="/admin/jsp/sales/view_sales_remark.jsp"%>
		</td>
	</tr>
</table>
<%
	} // end canView
%>