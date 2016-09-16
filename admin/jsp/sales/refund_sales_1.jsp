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
  OutletPaymentModeBean[] paymodeList = (OutletPaymentModeBean[]) returnBean.getReturnObject("PaymentModeList");
  
  ArrayList confirmBonusPeriodList = (ArrayList) returnBean.getReturnObject(CounterSalesManager.RETURN_CFIMBNSPERIODLIST_CODE);
	
  boolean isBonusConfirmed = false;
  boolean canView = bean != null;
  
  if (canView) {
	  if (bean.getBonusPeriodID() != null) {
  		isBonusConfirmed = confirmBonusPeriodList.contains(bean.getBonusPeriodID());
  	} else {
	  	isBonusConfirmed = true;
		}
  }
%>

<html>
<head>
	<title></title>
	
	<%@ include file="/lib/header.jsp"%>
	<%@ include file="/lib/counter.jsp"%>
	
	<script language="javascript">
	<!--
		function validateForm(thisform) {
			
			// Amount
			if (balance.innerText != 0) {
				alert("<i18n:label code="MSG_PAYMENT_NOT_ENOUGH"/>");
				return false;
			}
			
			if (confirm('<i18n:label code="MSG_CONFIRM"/>')) {
				thisform.action = "<%= Sys.getControllerURL(CounterSalesManager.TASKID_REFUND_SALES,request) %>";
		    thisform.submit(); 
			} else {
				alert('<i18n:label code="MSG_ACTION_CANCEL"/>');
			}
		}
		
	//-->
	</script>

</head>

<body onLoad="self.focus();document.frmSalesOrder.MgmtAmount.focus(); calcRefundBalance();">

<div class="functionhead"><i18n:label code="SALES_REFUND"/></div>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<table class="tbldata" border="0" width="700">
	<tr>
		<td width="400" valign=top>
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
	<tr class="noprint">
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
		<td colspan="2" width="700">
		  <%@ include file="/admin/jsp/sales/view_sales_cart.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign=top>
		<td colspan="2" width="500">
		  <%@ include file="/admin/jsp/sales/view_sales_payment.jsp"%>
		</td>
	</tr>
	<tr>
		<td>
			<table>
				<tr>
					<td class="td1" width="110" valign="top"><i18n:label code="GENERAL_REMARK"/>:</td>
					<td><%= bean.getRemark() != null ? bean.getRemark().replaceAll("\n","<br>") : "-" %></td>
				</tr>
			</table>
		</td>
	</tr>
</table>	


<hr>

<br>

<%
	if (bean.getStatus() == CounterSalesManager.STATUS_ACTIVE) {
%>

<form name="frmSalesOrder" method="post" action="">
	<table class="outerbox" width="700" border="0">
		<tr class="alert">
			<td align="center" colspan="4"><b><i18n:label code="SALES_REFUND"/></b></td>
		</tr>
		
		<%
			if (!isBonusConfirmed) {
		%>
		
		<tr>
			<td class="error note" colspan="4">
				<i18n:label code="MSG_SALES_IN_BONUSPERIOD"/> <%= bean.getBonusPeriodID() %>. <br>
				<i18n:label code="MSG_REFUND_SALES_NOBONUS"/>
			</td>
		</tr>
		
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		
		<%
			}
		%>
		
		<tr>
			<td class="td1" width="130"><i18n:label code="GENERAL_GROSS"/>:
			<td>
				<std:currencyformater code="" value="<%= bean.getNetSalesAmount() %>"/>
				<std:input type="hidden" name="Grandtotal" value="<%= bean.getNetSalesAmount() %>"/>
			</td>
		</tr>
		<tr>
			<td class="td1" width="130"><b><i18n:label code="SALES_DEDUCTION"/> (-)</b></td>
		</tr>
		<tr>
			<td class="td1" valign="top" width="130"><i18n:label code="SALES_MGMT_FEE"/>:
			<td valign="top">
				<std:input type="text" name="MgmtAmount" status="style=text-align:left onBlur=\"calcRefundAmount(this);\"" size="20" maxlength="14"/>
			</td>
		</tr>
		<tr>
			<td class="td1" width="130"><i18n:label code="GENERAL_NET_TOTAL"/>:</td>
			<td><LABEL ID="Refundtotal"> 0.00</LABEL></td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="4"><b><i18n:label code="SALES_PAYMENT_INFO"/></b></td>
		</tr>
		
		<% 
			if (paymodeList != null) {
				
				for (int m = 0; m < paymodeList.length; m++) { 
					
					OutletPaymentModeBean paymode = paymodeList[m];	
		%>
		
		<tr>		
			<td class="td1" width="130"><%= paymode.getDefaultDesc() %>:</td>
			<td>
				<std:input type="text" name="<%= "Paymode_" + paymode.getPaymodeCode() %>" status="onBlur=\"calcRefundAmount(this)\"" size="10"/>
			</td>
			<td class="td1" width="130"><i18n:label code="GENERAL_REFERENCE_NUM"/> (<i18n:label code="GENERAL_IF_ANY"/>)</td>
			<td>
				<std:input type="text" name="<%= "PaymodeRef_" + paymode.getPaymodeCode() %>" size="30" maxlength="50"/>
			</td>
		</tr>		
	  <script>addPaymode("<%= paymode.getPaymodeCode() %>")</script>
	  
		<% 	
				} // end for
			} else { 	
		%>
		
		<tr>
			<td class="error" align="center"><i18n:label code="MSG_NO_PAYMENTFOUND"/></td>
		</tr>
		
		<% 
			}
		%>
		
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<td class="td1" width="130"><b><i18n:label code="SALES_TOTAL_PAYMENT"/>:</b></td>
			<td><LABEL ID="amountPaid">0.00</LABEL></td>
			<td class="td1" width="130"><b><i18n:label code="SALES_BALANCE"/>:</b></td>
			<td><LABEL ID="balance">0.00</LABEL></td>
		</tr>
		<tr valign=top>
			<td class="td1" width="130"><i18n:label code="GENERAL_REMARK"/>:</td>
			<td colspan="3"><textarea name="AdjstRemark" cols="40" rows="5"></textarea></td>
		</tr>

	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="DocID" value="<%= bean.getTrxDocNo() %>"/>
	<std:input type="hidden" name="SalesID" value="<%= bean.getSalesID().toString() %>"/>
	<std:input type="hidden" name="CancelBonus" value="<%= isBonusConfirmed ? "N" : "Y" %>"/>
	
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onclick="validateForm(this.form)">
</form>	

<%
	} // end if active
%>

<%
	} // end canView
%>


	