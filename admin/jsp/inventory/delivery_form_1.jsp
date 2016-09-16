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
  CounterSalesOrderBean adjstBean = null;
  
  boolean canView = bean != null;
  
  String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
  
  int taskID = 0;
	if (task != null) 
		taskID = Integer.parseInt(task);
%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	<!--
	
	function calcKIV(idx) {
		var isOneItem = false;
		
		var qty = document.frmDelivery.PrdtQtyIssued[idx];
		var qtyLeft = document.frmDelivery.PrdtQtyLeft[idx];
		var kiv = PrdtKIV[idx];
		
		if (qty == null) {
			qty = document.frmDelivery.PrdtQtyIssued;
		}		
		if (qtyLeft == null) {
			qtyLeft = document.frmDelivery.PrdtQtyLeft;
		}
		if(kiv == null){
			kiv = PrdtKIV;
		}
		
		var unit = qty.value;
		
		if (qty == null) {
			isOneItem = true;
		}
		
		if (isNaN(unit)) {
			alert("<i18n:label code="MSG_INVALID_QUANTITY"/>");
			qty.value = "0";
			qty.focus();
			//return;
		}
	
		if (qtyLeft.value - qty.value < 0 ) {
			alert("<i18n:label code="MSG_QTYISSUE_GREATER_QTYBO"/>");
			qty.value = "0";
			kiv.innerText = qtyLeft.value;
			qty.focus();
		} else {
			kiv.innerText = qtyLeft.value - qty.value;
		}
                
                
		if (unit.length == 0) {
			qty.value = "0";
		}
		
		if (isOneItem) {
			totalIssue.innerText = document.frmDelivery.PrdtQtyIssued.value * 1;
			totalKIV.innerText = PrdtKIV.innerText * 1;
		} else {
			calcTotalQty();
		}
	}

	function calcTotalQty() {
		totalQty = 0;
		totalKiv = 0;
		
		var thisform = document.frmDelivery;
		
		if (thisform.PrdtQtyIssued.type == "text") {
			
			// Single product
			totalQty += thisform.PrdtQtyIssued.value * 1;
			totalKiv += PrdtKIV.innerText * 1;
			
		} else {
			
			// Multiple product
			for (var i=0; i < thisform.PrdtQtyIssued.length; i++) {
				totalQty += thisform.PrdtQtyIssued[i].value * 1;
				totalKiv += PrdtKIV[i].innerText * 1;
			}
			
		}
		
		totalIssue.innerText = totalQty;
		totalKIV.innerText = totalKiv;
	}
	
	function doSubmit(thisform) {

		var issuedQty = totalIssue.innerText * 1;
		
		if (issuedQty <= 0) {
			alert("Please enter Qty Issue !!!");
			return;
		}

		if (confirm("<i18n:label code="MSG_CONFIRM_ISSUE_DO"/>"))
	    thisform.submit(); 
		else
			alert('<i18n:label code="MSG_CANCEL_ISSUE_DO"/>');
	}
	//-->
	</script>
		
</head>

<body onLoad="calcTotalQty();">

<div class="functionhead"><i18n:label code="DELIVERY_ISSUE_FORM"/></div>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<form name="frmDelivery" action="<%= Sys.getControllerURL(taskID,request) %>" method="post" >

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
		<td colspan="2" width="700">
		  <table class="listbox" width="800">
				<tr class="boxhead" valign="top">
					<td width="5%"><i18n:label code="GENERAL_NUMBER"/></td>
					<td width="15%" nowrap><i18n:label code="PRODUCT_CODE"/></td>
					<td nowrap><i18n:label code="PRODUCT_NAME"/></td>
					<td align="right" width="8%" nowrap><i18n:label code="STOCK_BALANCE"/></td>
					<td align="right" width="8%" nowrap><i18n:label code="DELIVERY_QTY_ORDER"/></td>
					<td align="right" width="8%" nowrap><i18n:label code="DELIVERY_QTY_DELIVERED"/></td>
					<td align="right" width="8%" nowrap><i18n:label code="DELIVERY_QTY_LEFT"/></td>
					<td align="right" width="8%" nowrap><i18n:label code="DELIVERY_QTY_ISSUE"/></td>
					<td align="right" width="8%" nowrap><i18n:label code="DELIVERY_QTY_BO"/></td>
				</tr>
				
				<%
					int cnt = 0;
					int pdCnt = 0;
					int totalOrdered = 0;
					int totalDelivered = 0;
					int totalLeft = 0;
					int totalKIV = 0;
					String skuCode = "";
					
					CounterSalesItemBean[] itemSales = bean.getItemArray();
					
					for (int i = 0; i < itemSales.length; i++) {
						
						if (itemSales[i].getDeliveryStatus() == CounterSalesManager.STATUS_DO_COMPLETED)						
						 	continue;
						
						ProductBean product = itemSales[i].getProductBean();
						
						skuCode = product.getSkuCode() + " - " + product.getProductDescription().getName();
						
						if (itemSales[i].getProductType() == ProductManager.TYPE_FOCPRODUCT)
							skuCode += " [FOC]";
		 	
						cnt++;	 	
						
				
				%>
			
				<tr class="odd" valign="top">
					<td><%= cnt %></td>
					<td colspan=3><u><%= skuCode %></u></td>
					<td align="right"><%= itemSales[i].getQtyOrder()%></td>
					<td colspan="4">&nbsp;</td>
				</tr>
		
				<%
					CounterSalesProductBean[] cpb = itemSales[i].getProductArray();
					
					for (int j=0; j <cpb.length; j++,pdCnt++) {
						
						int kiv = 0;
						int left = cpb[j].getQtyKiv();
						int issue = cpb[j].getQtyKiv();
						int delivered = cpb[j].getQtyOrder() - cpb[j].getQtyKiv();
						int balance = cpb[j].getQtyOnHand();
						
						totalOrdered += cpb[j].getQtyOrder();
						totalLeft += left;
						totalDelivered += delivered;
						totalKIV += kiv;
				
						ProductBean component = cpb[j].getProductBean();
				%>
		
				<tr class="even" valign=top>
				  <td width="5%" nowrap><%= cnt +"."+ (j+1) %></td>
				  <td nowrap><%= component.getProductCode() %></td>
				  <td><%= component.getProductDescription().getName() %></td>
				  <td align="right"><b><%= String.valueOf(balance) %></b></td>
				  <td align="right"><%= cpb[j].getQtyOrder() %></td>
				  <td align="right"><%= delivered %></td>
				  <td align="right"><%= cpb[j].getQtyKiv() %></td>
				  <td align="right"><input type=text name="PrdtQtyIssued" value="<%= cpb[j].getQtyKiv() %>" size=5 style="text-align:right" onKeyUp="calcKIV(<%= pdCnt %>)"></td>
				  <td align="right"><label id="PrdtKIV"></label></td>
				</tr>
			
				<std:input type="hidden" name="<%= itemSales[i].getProductID() + "*@" + cpb[j].getProductID() + "*@F" + itemSales[i].getProductType() %>" value="<%= String.valueOf(pdCnt) %>"/> 
				<std:input type="hidden" name="PrdtQtyLeft" value="<%= cpb[j].getQtyKiv() %>"/> 
		
				<% 		
						} // end for cpb
					} // end for itemSales
				%>
				<tr>
					<td colspan="9">&nbsp;</td>
				</tr>
				<tr>
				  <td colspan="4" align="right"><b><i18n:label code="GENERAL_TOTAL"/></b></td>
				  <td align="right"><b><%= totalOrdered %></b></td>
				  <td align="right"><b><%= totalDelivered %></b></td>
				  <td align="right"><b><%= totalLeft %></b></td>
				  <td align="right"><b><Label id="totalIssue"><%= totalDelivered %></b></Label></td>
				  <td align="right"><b><Label id="totalKIV"><%= totalKIV %></b></Label></td>
				</tr>	
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2">
			<table>
				<td class="td1" valign="top"><i18n:label code="DELIVERY_REMARK"/>:</td>
				<td><textarea name="Remark" cols="40" rows="5"></textarea></td>
			</table>
		</td>
	</tr>
</table>	
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="DocID" value="<%= bean.getTrxDocNo() %>"/>
	<std:input type="hidden" name="SalesID" value="<%= bean.getSalesID() != null ? bean.getSalesID().toString() : "" %>"/>
	<std:input type="hidden" name="ShipOptionStr" value="<%= String.valueOf(CounterSalesManager.SHIP_OWN_PICKUP) %>" />
	<std:input type="hidden" name="ShipByOutletID" value="<%= bean.getShipByOutletID() %>" />

	<input class="textbutton" type="button" name="btnSubmit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
</form>
<%
	} // end canView
%>
	