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
  DeliveryOrderBean doBean = (DeliveryOrderBean) returnBean.getReturnObject("DeliveryOrderBean");
  DeliveryOrderBean adjstBean = (DeliveryOrderBean) returnBean.getReturnObject("AdjstDeliveryBean");
 
  boolean canView = bean != null && doBean != null;
%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>

</head>

<body>

<div class="functionhead"><i18n:label code="DELIVERY_VIEWINFO"/></div>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<table width="100">
	<tr>
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT_COMP"/>" onClick="javascript:popupViewDoc('<%= Sys.getControllerURL(CounterSalesManager.TASKID_DOC_DO,request) %>&SalesID=<%= doBean.getSalesID() %>&DeliveryID=<%= doBean.getDeliveryID() %>')">
		</td>

		<%
			if (adjstBean != null && doBean.getStatus() == CounterSalesManager.STATUS_VOIDED) {
		%>
		
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="SALES_PRINT_GRN"/>" onClick="javascript:popupViewDoc('<%= Sys.getControllerURL(CounterSalesManager.TASKID_DOC_GRN,request) %>&SalesID=<%= adjstBean.getSalesID() %>&DeliveryID=<%= adjstBean.getDeliveryID() %>')">
		</td>
		
		<%
			}
		%>
		
		<td>&nbsp;</td>
	</tr>
</table>

<table class="tbldata" border="0" width="600">
	<tr>
		<td width="300" valign=top>
			 <%@ include file="/admin/jsp/inventory/view_delivery_sales_parties.jsp"%>
		</td>
		<td width="300" valign=top>
			<%@ include file="/admin/jsp/inventory/view_delivery_document.jsp"%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
		  <%@ include file="/admin/jsp/inventory/view_delivery_parties.jsp"%>
		</td>
	</tr>
	<tr class="noprint">
		<td>&nbsp;</td>
		<td valign=top>
			<%@ include file="/admin/jsp/inventory/view_delivery_status.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/inventory/view_delivery_cart.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" width="500">
			<%@ include file="/admin/jsp/inventory/view_delivery_remark.jsp"%>
		</td>
	</tr>
</table>	

<%
	} // end canView
%>
