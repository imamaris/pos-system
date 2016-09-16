<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.stockist.*"%>
<%@ page import="com.ecosmosis.orca.outlet.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.pricing.product.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%
  int itemId = 0;

  CounterSalesOrderBean bean = CounterSalesManager.getSalesInfoFromSession(request);	
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

  ProductCategoryBean[] catBeans = (ProductCategoryBean[]) returnBean.getReturnObject("CategoryList"); 
  ProductBean[] itemBeans = (ProductBean[]) returnBean.getReturnObject("ProductList"); 
  OutletPaymentModeBean[] paymodeList = (OutletPaymentModeBean[]) returnBean.getReturnObject("PaymentModeList");
  
  String discountObj = (String) returnBean.getReturnObject("StockistDiscountValue");
  if (discountObj == null)
  	discountObj = "0.0";
   
  String typeObj = (String) returnBean.getReturnObject("StockistTypeValue");
  if (typeObj == null)
  	typeObj = "";
        
  boolean canView = itemBeans != null && paymodeList != null;
  
%>

<link href="<%= request.getContextPath() %>/lib/tabStyle.css" REL="stylesheet" TYPE="text/css"/>

<html>
<head>
<title></title>

<%@ include file="/lib/header.jsp"%>
<%@ include file="/lib/counter.jsp"%>

<script language=Javascript src="<%= request.getContextPath() %>/lib/tab.js"></script>
<%@ include file="/lib/shoppingCart.jsp"%>

<script language="javascript">
  <!--
	var selectedUnit = 0;
	var selectedFocUnit = 0;
	
	function doSubmit(thisform) {
		var vl;
		
		// Qty Order
		if (selectedUnit == 0 && selectedFocUnit == 0) {
			alert("No Sales Order Info");
			return;
		}

		// Amount
		var amtPaid = replacePriceValue(amountPaid.innerText);
		amtPaid = amtPaid * 1;
		
		var grdTotal = replacePriceValue(Grandtotal.innerText);
		grdTotal = grdTotal * 1;
		
		if (grdTotal > 0)
                {
			if (amtPaid < grdTotal) {
				alert("<i18n:label code="MSG_PAYMENT_NOT_ENOUGH"/>");
				return;
			}
		} 
                else 
                {
			if (amtPaid > 0) {
				alert("<i18n:label code="MSG_NO_PAYMENT"/> " + grdTotal);
				return;
			}
		}

		if (confirm('<i18n:label code="MSG_CONFIRM"/>')) {
			thisform.action = "<%=Sys.getControllerURL(CounterSalesManager.TASKID_STOCKIST_SALES_FORM,request)%>";
			thisform.submit();
		} 
		
	} // end validateForm
	
	/*===========================================================================*
 	 *  Stockist Commission Discount
     *===========================================================================*/
	function setPercentage(thisform,total) {
        
                var percentage = <%= discountObj %>;
                        
                if ((percentage > 5)) {
                   if ((total >= 5000000)) {                                   
                       percentage = percentage * 1;
                       }
                   else 
                       {
                       percentage = 0;
                       }
                   
                    }
                       
                else
                   {
                   if ((total >= 2000000)) {                                   
                       percentage = percentage * 1;
                       }
                   else 
                       {
                       percentage = 0;
                       }
                                       
                    }                       

                    var discountVal = Math.round((percentage/100)*total);
                    thisform.DiscountRate.value = percentage;	 	
                    thisform.DiscountAmount.value = discountVal;	 	
                    DiscountRateDisp.innerText = percentage;
                    DiscountAmountDisp.innerText = formatAmount(thisform.DiscountAmount.value);
                    
              }        
	
  //-->
  </script>

</head>

<body onLoad="self.focus(); init();">

<div class="functionhead"><i18n:label code="SALES_STOCKIST"/> - <i18n:label code="SALES_ORDER_FORM"/></div>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="frmSalesOrder" action="" method="post">

<table class="tbldata" border="0" width="500">
	<tr>
		<td class="td1" width="130"><i18n:label code="SALES_COUNTER"/>:</td>
		<td><std:text value="<%= bean.getSellerID() %>"/></td>
	</tr>
	<tr>
		<td class="td1" width="130"><i18n:label code="STOCKIST_ID"/>:</td>
		<td><std:text value="<%= bean.getCustomerID() %>"/> (<%= typeObj %>)</td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="GENERAL_NAME"/>:</td>
		<td><std:text value="<%= bean.getCustomerName() %>"/></td>
	</tr>
	<tr>
		<td class="td1" valign="top"><i18n:label code="GENERAL_CONTACTS"/>:</td>
		<td><%= bean.getCustomerContact() != null ? bean
					.getCustomerContact().replaceAll("\n", "<br>") : "-" %></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>

	<tr>
		<td class="td1" width="130"><i18n:label code="SALES_TRX_DATE"/>:</td>
		<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getTrxDate() %>" /></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="PRICE_CODE"/>:</td>
		<td><std:text value="<%= bean.getPriceCode() %>"/></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="SALES_ALL_AMOUNTS_IN"/> :</td>
		<td><%= bean.getLocalCurrency() %></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="DELIVERY_BY"/>:</td>
		<td>
			<std:text value="<%= bean.getShipByStoreCode() %>"/>
			
			<std:input type="hidden" name="ShipByOutletID" value="<%= bean.getShipByOutletID() %>"/> 
			<std:input type="hidden" name="ShipByStoreCode" value="<%= bean.getShipByStoreCode() %>"/>
		</td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="DELIVERY_METHOD"/>:</td>
		<td>
			<%= CounterSalesManager.defineShippingOptionName(bean.getShipOption()) %>
			
			<std:input type="hidden" name="ShipOptionStr" value="<%= String.valueOf(bean.getShipOption()) %>"/> 
		</td>
	</tr>

	<%
	if (bean.getShipOption() == CounterSalesManager.SHIP_TO_RECEIVER) {
	%>
	<tr>
		<td class="td1"><i18n:label code="SALES_SHIPPING_ADDRESS"/>:</td>
		<td>Shipping Address Full string</td>
	</tr>
	<%
	}
	%>
	
</table>

<%
	if (canView) {
%>

<div>&nbsp;</div>

<a name="self"></a>

<ul id="tablist">
<%
	if (catBeans != null) {
		
		for (int x=0; x<catBeans.length; x++) {
%>

<li>
	<a href="#self" onClick="expandcontent('sc<%= x+1 %>', this)"><%= catBeans[x].getName() %></a>
</li>

<%
		} // end for
	} // end if
%>
</ul>

<div id="tabcontentcontainer">
<%
	if (catBeans != null) {

		for (int x = 0; x < catBeans.length; x++) {
%>

<div id="sc<%= x+1 %>" class="tabcontent">

<table class="listbox" width="800">
	<tr class="boxhead" valign="top">
		<td width="5%"><i18n:label code="GENERAL_NUMBER"/></td>
		<td width="15%" nowrap><i18n:label code="PRODUCT_SKU_CODE"/></td>
		<td width="25%" nowrap><i18n:label code="PRODUCT_NAME"/></td>
		<td align="right" width="8%" nowrap><i18n:label code="PRODUCT_UNIT_PV"/></td>
		<td align="right" width="12%" nowrap><i18n:label code="PRODUCT_UNIT_PRICE"/> <br> (<%= bean.getLocalCurrencySymbol() %>)</td>
		<td align="right" width="8%" nowrap><i18n:label code="STOCK_BALANCE"/></td>
		<td align="center" width="8%" nowrap><i18n:label code="GENERAL_QTY"/></td>
		<td align="right" width="12%"><i18n:label code="GENERAL_TOTAL_AMOUNT"/><br> (<%= bean.getLocalCurrencySymbol() %>) </td>
	</tr>

<%
			int no = 0;
			String stockBalance = "";
			
			if (itemBeans != null) {

				for (int i = 0; i < itemBeans.length; i++) {
					
					if (itemBeans[i].getCatID() == catBeans[x].getCatID()) {
						
						if (itemBeans[i].getType().equalsIgnoreCase(ProductManager.PRODUCT_SINGLE)) 
							stockBalance = String.valueOf(itemBeans[i].getQtyOnHand());
						else
							stockBalance = "N/A";	
%>

	<tr>
		<td><%= (no + 1) %>.</td>
		<td ID="code_<%= itemBeans[i].getCatID() %>_<%= itemBeans[i].getProductID() %>">
			<%= itemBeans[i].getSkuCode() %>
		</td>
		<td ID="name_<%= itemBeans[i].getCatID()%>_<%= itemBeans[i].getProductID() %>">
			<%= itemBeans[i].getProductDescription().getName() %>
		</td>
		<td align=right ID="bv_<%= itemBeans[i].getCatID() %>_<%= itemBeans[i].getProductID() %>">
			<std:bvformater value="<%= itemBeans[i].getCurrentPricing().getBv1() %>"/>
		</td>
		<td align="right" ID="price_<%= itemBeans[i].getCatID() %>_<%= itemBeans[i].getProductID() %>">
			<std:currencyformater code="" value="<%= itemBeans[i].getCurrentPricing().getPrice() %>"/>
		</td>
		<td align="right" ID="price_<%= itemBeans[i].getCatID() %>_<%= itemBeans[i].getProductID() %>">
		  <b><%= stockBalance %></b>
		</td>
		<td align=center>
			<std:input type="text" name="<%= "Qty_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" status="<%= "style=text-align:right "  + ("onKeyUp='calcUnit1("+ itemId + ", "+ stockBalance + ", this); edp_Cart("+ itemId+")';") %>" size="4" maxlength="4"/>
		</td>
		<td align=right>
			<LABEL ID="Amt_<%= itemBeans[i].getCatID()%>_<%= itemBeans[i].getProductID() %>"></LABEL>
		</td>
	</tr>

	<script>addProduct("<%= itemBeans[i].getProductID() %>",<%= itemBeans[i].getCurrentPricing().getPrice() %>,<%= itemBeans[i].getCurrentPricing().getBv1() %>,"<%= itemBeans[i].getCatID() %>")</script>

<%
						no++;
						itemId++;
						
					} // end match category

				} // end for itemBeans
			} else {
%>

	<tr colspan="7">
		<td class="error" align="center"><i18n:label code="MSG_NO_SKUFOUND"/></td>
	</tr>

<%
			} // end itemBeans == null
%>

</table>
</div>

<%
		} // end catBeans for loop

	} // end catBeans != null
%>
</div>

<%
	if (itemBeans != null) {

		for (int i = 0; i < itemBeans.length; i++) {
%>
	
<std:input type="hidden" name="<%= "Pricing_" + itemBeans[i].getProductID() %>" value="<%= String.valueOf(itemBeans[i].getCurrentPricing().getPricingID()) %>"/> 

<%   
	 	} // end for
 	} // end if 
%>
 
<hr>

<br>

<div>&nbsp;</div>

<table class="outerbox">
	<tr>
		<td bgcolor="#E7E7E7" align="center"><b><i18n:label code="SALES_ORDER_CART"/></b></td>
	</tr>
	<tr>
		<td>
			<table id="Cart" width="700">
				<tr>
					<td colspan="7"><i18n:label code="MSG_NO_ORDERFOUND"/></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<div>&nbsp;</div>

<div>&nbsp;</div>

<table border="0" width="700" border="0">
	<tr align="right">
		<td colspan="6" width="500"><b><i18n:label code="GENERAL_TOTAL"/> PV:</b>&nbsp;&nbsp;<LABEL ID="TotalBV">0</LABEL>&nbsp;&nbsp;</td>
		<td colspan="1" nowrap><b><i18n:label code="GENERAL_GROSS"/>:</b></td>
		<td><LABEL ID="Total">0.00</LABEL></td>
	</tr>
        
	<tr>
		<td colspan="8">&nbsp;</td>
	</tr>
	<tr align=right>
		<td colspan="7"><b><i18n:label code="SALES_DELIVERY_CHARGES"/>:</b></td>
		<td><std:input type="text" name="DeliveryAmount" status="style=text-align:right onBlur=\"calcMiscAmount(this);\"" size="20" maxlength="14"/>
		</td>
	</tr>
	<tr align=right>
		<td colspan="6" align=right><b><i18n:label code="SALES_DISCOUNT_AMOUNT"/>:</b></td>
		
                <td><LABEL ID="DiscountRateDisp">0</LABEL>
		<input type=hidden name="DiscountRate">
		</td>
		
                <td><LABEL ID="DiscountAmountDisp">0</LABEL>
		<input type=hidden name="DiscountAmount">
		</td>
		
		<!--
		<td align=right><std:input size="3" type="text" name="DiscountRate" status="style=text-align:right onFocus=\"blur();\""/> % </td>
		<td><std:input type="text" name="DiscountAmountDisp" status="style=text-align:right  onFocus=\"blur();\" onBlur=\"calcDiscountAmount(this);\"" size="20" maxlength="14"/>
				<input type=hidden name="DiscountAmount">
		</td>
		-->
	</tr>
	<tr align=right>
		<td colspan="7"><b><i18n:label code="GENERAL_NET_TOTAL"/>:</b></td>
		<td><LABEL ID="Grandtotal"> 0.00</LABEL></td>
	</tr>
</table>

<br>

<hr>

<br>

<b><u><i18n:label code="SALES_PAYMENT_INFO"/></u></b>

<table width="700" border="0">
	
	<% 
		if (paymodeList != null) {
			
			for (int m = 0; m < paymodeList.length; m++) { 
				
				OutletPaymentModeBean paymode = paymodeList[m];	
	%>
	
	<tr>		
		<td class="td1" width="130"><%= paymode.getDefaultDesc() %>:</td>
		<td>
			<std:input type="text" name="<%= "Paymode_" + paymode.getPaymodeCode() %>" status="onBlur=\"calcAmountPaid(this);\"" size="10"/>
			
			<a href='javascript:updatePaymodeValue(document.frmSalesOrder.Paymode_<%= paymode.getPaymodeCode() %>);'>
				<img border="0" src="<%= Sys.getWebapp() %>/img/money_red.gif"> 
			</a>
			
		</td>
		<td class="td1" width="130"><i18n:label code="GENERAL_REFERENCE_NUM"/> (<i18n:label code="GENERAL_IF_ANY"/>)</td>
		<td>
			<std:input type="text" name="<%= "PaymodeRef_" + paymode.getPaymodeCode() %>" size="30" maxlength="50"/>
		</td>
	</tr>		
  <script>addPaymode("<%= paymode.getPaymodeCode() %>")</script>
  
	<% 	
			} // end for
	%>
	<%
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
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td class="td1Focus"><b><i18n:label code="SALES_CHANGE_DUE"/>:</b></td>
		<td class="td2Focus">
			<LABEL ID="paymentChange">0.00</LABEL>
			<std:input type="hidden" name="paymentChangeObj"/> 
		</td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr valign=top>
		<td class="td1" width="130"><i18n:label code="GENERAL_REMARK"/>:</td>
		<td colspan="3"><textarea name="Remark" cols="40" rows="5"></textarea></td>
	</tr>	
</table>

<br>

<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
<std:input type="hidden" name="CustomerID" value="<%= bean.getCustomerID() %>"/> 
<std:input type="hidden" name="CustomerName" value="<%= bean.getCustomerName() %>"/> 

<std:input type="hidden" name="TotalItems" value="<%= (itemBeans != null) ? String.valueOf(itemBeans.length) : "0" %>"/> 

<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" name="btnSubmit" onClick="doSubmit(this.form)">

<%
	} // end canView
%>

</form>

</body>
</html>