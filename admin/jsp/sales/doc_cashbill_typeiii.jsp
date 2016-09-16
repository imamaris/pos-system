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
  
  boolean canView = bean != null;
%>

<html>
<head>
	<title>Cash Bill (Type III)</title>

	<%@ include file="/lib/header.jsp"%>

</head>

<body>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<table width="100">
	<tr>
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
		</td>
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onClick="window.close();">
		</td>
	</tr>
</table>
		
<br>

<table class="tbldata" border="0" width="600">
	<tr>
		<td width="300" valign=top>
			 <%@ include file="/admin/jsp/sales/view_sales_parties.jsp"%>
		</td>
		<td width="300" valign=top>
			<%@ include file="/admin/jsp/sales/view_sales_document.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/sales/view_sales_cart_iii.jsp"%>
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
	