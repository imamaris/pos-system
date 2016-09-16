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
int itemId = 0;

CounterSalesOrderBean bean = CounterSalesManager.getSalesInfoFromSession(request);
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

ProductCategoryBean[] catBeans = (ProductCategoryBean[]) returnBean.getReturnObject("CategoryList");
ProductBean[] itemBeans = (ProductBean[]) returnBean.getReturnObject("ProductList");
OutletPaymentModeBean[] paymodeList = (OutletPaymentModeBean[]) returnBean.getReturnObject("PaymentModeList");

Double quotaObj = (Double) returnBean.getReturnObject("QuotaBvBalance");
double quotaBv = 0.0d;
if (quotaObj != null)
    quotaBv = quotaObj.doubleValue();

String taskTitle = (String) returnBean.getReturnObject("TaskTitle");
String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);

int taskID = 0;
if (task != null)
    taskID = Integer.parseInt(task);

boolean canView = itemBeans != null && paymodeList != null;	
%>

<link href="<%= request.getContextPath() %>/lib/tabStyle.css" REL="stylesheet" TYPE="text/css"/>

<html>
<head>
    <title></title>
    
    <%@ include file="/lib/header.jsp"%>
    <%@ include file="/lib/counter.jsp"%>
    
    <script language="Javascript" src="<%= request.getContextPath() %>/lib/tab.js"></script>
    <%@ include file="/lib/shoppingCart.jsp"%>
    
    <script language="javascript">
  <!--
	var selectedUnit = 0;
	var selectedFocUnit = 0;
        var selectedDiscUnit = 0;
	
	function doSubmit(thisform) {
		var vl;
		
		// Qty Order
		if (selectedUnit == 0 && selectedFocUnit == 0 && selectedDiscUnit == 0 ) {
			alert("No Sales Order Info");
			return;
		}

		// Amount
		var amtPaid = replacePriceValue(amountPaid.innerText);
		amtPaid = amtPaid * 1;
		
		var grdTotal = replacePriceValue(Grandtotal.innerText);
		grdTotal = grdTotal * 1;

<%--                
		if (grdTotal > 0) {
			if (amtPaid < grdTotal) {
				alert("<i18n:label code="MSG_PAYMENT_NOT_ENOUGH"/>");
				return;
			}
		}	else {
			if (amtPaid > 0) {
				alert("<i18n:label code="MSG_NO_PAYMENT"/> " + grdTotal);
				return;
			}
		}
--%>

		if (confirm('<i18n:label code="MSG_CONFIRM"/>')) {
			thisform.action = "<%=Sys.getControllerURL(taskID,request)%>";
			thisform.submit();
		}
		  //init();
	} // end validateForm
	
  //-->
    </script>
    
</head>

<body onLoad="self.focus();">

<div class="functionhead">Sales Entry </div>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="frmSalesOrder" action="" method="post">

<table class="tbldata" border="0" width="800">
    
    <tr>
        <td class="td1" width="100">Counter :</td>
        <td width="100"><%= bean.getSellerID() %></td>         
        <td>&nbsp;</td>
        <td class="td1"></td>
        <td><std:text value="<%= loginUser.getUserName().toUpperCase()%>"/></td>  
        <td>&nbsp;</td>
        <td class="td1" width="100">Sales ID :</td>
        <td width="100"><%= bean.getBonusEarnerID() %></td>                                
        
    </tr>
    <tr>
        <td class="td1">Name :</td>
        <td> <std:input type="text" name="CustomerName" value="<%= bean.getCustomerName() %>"/></td>   
        <td>&nbsp;</td>
        <td class="td1"></td>
        <td><std:text value="<%= bean.getCustomerContact()%>"/></td>
        <td >&nbsp;</td>      
        <td class="td1" >Nama :</td>
        <td><std:text value="<%= bean.getBonusEarnerName() %>"/></td>                       
        
    </tr>
    
    <tr>
        <td class="td1" width="100">Trx Date :</td>
        <td width="100"><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getTrxDate() %>" /></td>
        <td valign="top"></td>                    
        <td colspan="3">&nbsp;</td>         
        
    </tr>
    
    
    <%
    if (bean.getShipOption() == CounterSalesManager.SHIP_TO_RECEIVER) {
    %>
    
    <tr>
        <td class="td1">Shipping Address:</td>
        <td>Shipping Address Full string</td>
        <td colspan="6">&nbsp;</td>
        
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


<hr>
<br>


<ul id="tablist">       
    <%
    if (catBeans != null) {
        
        for (int x=0; x<catBeans.length; x++) {
    %>
    
    <li>
        <a href="#self" onClick="expandcontent('sc<%= x+1 %>', this)"><%//= catBeans[x].getName() %></a>
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

<table class="listbox" width="100%">
    
    
    <tr class="boxhead" valign="top" >
        <td width="15%" nowrap>Item Number</td>
        <td width="15%" nowrap>Brand</td>
        <td width="25%" nowrap>Item Description</td>
        <td width="15%" nowrap>Product Code/ <br>Serial Number</td>
        <td align="right" width="12%" nowrap><i18n:label code="PRODUCT_UNIT_PRICE"/> <br> (<%= bean.getLocalCurrencySymbol() %>)</td>
        <td align="center" width="8%" nowrap><i18n:label code="GENERAL_QTY"/></td>            
        <td align="center" width="8%" nowrap>Disc (Rp)</td>
        <td align="center" width="8%" nowrap>Disc (%)</td>
        <td align="right" width="12%"><i18n:label code="GENERAL_TOTAL_AMOUNT"/><br>(<%= bean.getLocalCurrencySymbol() %>)</td>
        <td align="center" width="8%" nowrap>Sales ID</td>
    </tr>
    
    
    
    <%
    int no = 0;
    String stockBalance = "";
    String quantity = "";
    
    // nilai sementara ..
    
    String focQty = "10";
    
    
    if (itemBeans != null) {
        
        for (int i = 0; i < itemBeans.length; i++) {
            
            if (itemBeans[i].getCatID() == catBeans[x].getCatID()) {
                
                if (itemBeans[i].getType().equalsIgnoreCase(ProductManager.PRODUCT_SINGLE))
                    stockBalance = String.valueOf(itemBeans[i].getQtyOnHand());
                else
                    stockBalance = "N/A";
                
                
                
                
                int catid = itemBeans[i].getCatID();
                int prodid = itemBeans[i].getProductID();
                String sku_code =  itemBeans[i].getSkuCode();
                
                
                
                // onKeyUp='calcUnitFF("+ itemId + ", "+ catid + ", "+ prodid + ", "+ sku_code + "
    
    %>
    
    
    <input type="hidden" id="<%= "hprice_" + itemBeans[i].getSkuCode() %>" value="<%= itemBeans[i].getCurrentPricing().getPrice() %>">
    <input type="hidden" id="<%= "hcode_" + itemBeans[i].getSkuCode() %>" value="<%= "code_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>">
    <input type="hidden" id="<%= "hname_" + itemBeans[i].getSkuCode() %>" value="<%= "name_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>">
    <input type="hidden" id="<%= "general_" + itemBeans[i].getSkuCode() %>" value="<%= itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>">
    <input type="hidden" id="<%= "hbrand_" + itemBeans[i].getSkuCode() %>" value="<%= itemBeans[i].getProductCategory().getName() %>">
    
    <input type="hidden" id="<%= "hprod_name_" + itemBeans[i].getSkuCode() %>" value="<%= itemBeans[i].getProductDescription().getName() %>">
    
    
    
    <input type="hidden" id="<%= "xname_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value="<%= "name_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>">
    
    
    <tr>
        
        <td ID="<% out.print( "code_" +i); %>">
            <input type="hidden" id="<%= "code_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value="  <%= itemBeans[i].getSkuCode() %>"> 
            <std:input type="text" name="<%= "icode_" + i %>" status="<%= "style=text-align:right "  + ("onKeyUp='calcUnitFF(this,"+ i+")';") %>" size="10" maxlength="10"/>
        </td>
        
        <td ID="<% out.print( "brand_" +i); %>">
            <input type="hidden" id="<%= "brand_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value=" <%= itemBeans[i].getProductCategory().getName() %>"> 
            <input type="text" id="<% out.print( "ibrand_" +i); %>" name="<% out.print( "brand_" +i); %>" value="" disabled size="5" maxlength="5" >
            
        </td>
        
        <td ID="<% out.print( "name_" +i); %>">
            <input type="hidden" id="<%= "name_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value=" <%= itemBeans[i].getProductDescription().getName() %>"> 
            <input type="text" id="<% out.print( "iname_" +i); %>" name="<% out.print( "name_" +i); %>" value="" disabled size="25" maxlength="25">
            
        </td>
        <td align="right" ID="price_D<%= itemBeans[i].getCatID() %>_<%= itemBeans[i].getProductID() %>">
            <input type="hidden" id="<%= "iserial_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value="<%= itemBeans[i].getProductCode() %>"> 
            <input type="text" id="<% out.print( "iserial_" +i); %>" name="<% out.print( "serial_" +i); %>" value="" disabled>
            </td>
        
        <td align="right" ID="price_D<%= itemBeans[i].getCatID() %>_<%= itemBeans[i].getProductID() %>">
            <input type="hidden" id="<%= "price_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value="<%= itemBeans[i].getCurrentPricing().getPrice() %>"> 
            <!-- std:currencyformater code="" value="<%//= itemBeans[i].getCurrentPricing().getPrice() %>"/> -->
            <input type="text" id="<% out.print( "iprice_" +i); %>" name="<% out.print( "price_" +i); %>" value="" disabled size="12" maxlength="12">
        </td>
        
        <td align=center>
            <std:input type="text" name="<%= "Qty_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>"  status="<%= "style=text-align:right "  + ("onKeyUp='calcUnit("+ itemId + ", this); noBvCarte("+ itemId+")';") %>" size="4" maxlength="4"/>
        </td>
        
        <% quantity = "Qty_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID(); %> 
        
        <td align=center>
            <std:input type="text" name="<%= "Foc_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" status="<%= "style=text-align:right " + ("onKeyUp='calcUnitFoc("+ i + ",  "+ quantity + ", this); noBvCart("+ itemId+",this)';")  %>" size="12" maxlength="12"/>
            <input type="hidden" ID="<%= "Foc_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value="0"/> 
            <input type="hidden" ID="<%= "Qty_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value="0"/> 
            
        </td>
        
        <!-- discount % = price / discount-->
        <td align=right>
            <!-- <LABEL ID="Disc1_<%//= itemBeans[i].getCatID()%>_<%//= itemBeans[i].getProductID() %>"></LABEL> -->
            <!--  <input type="hidden" id="<%//= "Disc1_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value="<%//= "Disc_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value="">  -->
                                
            <input type="hidden" idx="<%//= "Disc1_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value=" <%//= //itemBeans[i].getProductDescription().getName() %>"> 
            <input type="text" id="<% //out.print( "Disc1_"+ itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID();%>" name="<% //out.print( "Disc1_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID();%>" value="" disabled size="4" maxlength="4"> 
            
        </td>                                
        
        <std:input type="hidden" name="<%= "Discount_" + itemBeans[i].getProductID() %>" value="<%= focQty %>"/> 
        
        <td align=right ID="total">
            <LABEL ID="total"></LABEL>
            <input type="text" id="<%= "total_" + i %>" name="<% out.print( "total_" + itemBeans[i].getSkuCode()); %>" value="" disabled size="12" maxlength="12">
            <input type="hidden" id="<%= "Amt_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value="1"> 
        </td>
        
        
        <td align=center>
            <std:input type="text" name="<%= "Sales_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" size="12" maxlength="12"/>
            <input type="hidden" ID="<%= "Sales_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" value="0"/> 
            
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

<input type="hidden" name="<%= "Pricing_" + itemBeans[i].getProductID() %>" ID="<%= "Pricing_" + itemBeans[i].getProductID() %>"  value="<%= String.valueOf(itemBeans[i].getCurrentPricing().getPricingID()) %>"/>                


<%   
        } // end for
} // end if
%>

<hr>

<br>

<div>&nbsp;</div>

<p></p>
<table class="outerbox">
    <tr>
        <td bgcolor="#E7E7E7" align="center"><b><i18n:label code="SALES_ORDER_CART"/></b></td>
    </tr>
    <tr>
        <td>
            <table id="Cart" width="700">
                <tr>
                    <td colspan="6"><i18n:label code="MSG_NO_ORDERFOUND"/></td>
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
<br>
<table width="700">
    <tr align="right">
        <td colspan="6" width="500">&nbsp;</td>
        <td colspan="1" nowrap></td>
        <td><font color="#f8f6f9"><LABEL ID="Total">0.00</LABEL></font></td>
    </tr>
    <tr>
        <td colspan="8">&nbsp;</td>
    </tr>
    
    <std:input type="hidden" name="DeliveryAmount" value="0"/>
    
    <std:input type="hidden" name="DiscountAmount" value="0"/>
    
    <tr align=right>
        <td colspan="7"><b>Net Price :</b></td>
        <td><LABEL ID="Grandtotal"> <input type="text" id="Grandtotal" value="" disabled></LABEL></td>
    </tr>
    
</table>

<br>

<hr>                
<br>  
<u>Payment Information </u>
<br>
<br>

<table width="80%" border="0">   
    
    <tr align="center" valign="top">
        
        <td width="30%">Payment Type </td>
        <td width="15%">Amount </td>    
        <td width="20%">Reference No. </td>
        <td width="25%">Expired Card <br> dd-mm-yyyy </td>
        <td width="20%">Owner Name  </td>
    </tr>                  
    
    <% 
    if (paymodeList != null) {
        
        
        for(int i=0;i<4;i++) {
    %>
    
    <tr>		                   
        <td class="td1" width="130">
            <select name="paymode_<%=i%>" onchange="seletPaymentMode(this, <%=i%>)">
                
                <%        
                for (int m = 0; m < paymodeList.length; m++) {
                    
                    OutletPaymentModeBean paymode = paymodeList[m];	
                %>                            
                
                <option value="<%= paymode.getPaymodeDesc()%>><%= paymode.getPaymodeCode()%>><%= paymode.getOutletEdc()%>><%= paymode.getOutletTime()%>><%= paymode.getGroup()%>" <%= m==i? "selected":"" %>><%= paymode.getPaymodeDesc() %> - <%= paymode.getOutletEdc()%> - <%= paymode.getOutletTime()%> </option>
                
                
                <% 	
                } // end for
                %>                            
                
                
            </select>    
            
        </td>  
        
        <td align="right">
            <input type="text" name="amount_<%= i%>" size="12" maxlength="12" value="0" onkeyup="seletPaymentModeWithInput(this, <%=i%>)"/>
            
        </td>            
        
        <td>
            <input type="text" name="refNo_<%= i%>" size="20" maxlength="50" value=""/>
        </td>   
        
        <td align="center">
            
            <std:input type="text" name="expired_<%= i%>" value="" size="12" maxlength="12" />
            
        </td>
        
        <td>
            <input type="text" name="owner_<%= i%>" size="20" maxlength="50" value=""/>
        </td>  
        
    </tr>
    
    
    
    
    <%
        } // loop 5x
        
        
        
    }  // paymodeList != null
    
    
    else { 
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
        <td width="130" align="right"><b><i18n:label code="SALES_TOTAL_PAYMENT"/> :</b></td>
        <td><LABEL ID="amountPaid">0.00</LABEL></td> 
        <td class="td1" width="130"></td>
        <td></td>
    </tr>
    <tr>
        <td width="130" align="right"><b><i18n:label code="SALES_BALANCE"/> :</b></td>
        <td><LABEL ID="balance">0.00</LABEL></td>
        <td class="td1" width="130"></td>
        <td></td>
    </tr>    

    <tr>
        <td class="td1Focus"></td>
        <td class="td2Focus"><font color="#f8f6f9">
                <LABEL ID="paymentChange">0.00</LABEL>
            </FONT>
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
<std:input type="hidden" name="CustomerName" value="<%= bean.getCustomerName() %>"/>


<std:input type="hidden" name="TotalItems" value="<%= (itemBeans != null) ? String.valueOf(itemBeans.length) : "0" %>"/> 


<input class="textbutton" type="button" name="btnSubmit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form)">

<%
} // end canView
%>

</form>

</body>
</html>


