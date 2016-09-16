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

<%@ page import="com.ecosmosis.common.locations.*"%>

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
        <script language=Javascript src="<%= request.getContextPath() %>/lib/tab.js"></script>
        <%@ include file="/lib/shoppingCart.jsp"%>
        
        <%@ include file="/lib/select_locations.jsp"%>
        
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
	
		if (confirm('<i18n:label code="MSG_CONFIRM"/>')) {
			thisform.action = "<%=Sys.getControllerURL(taskID,request)%>";
			thisform.submit();
		} 
		
	} // end validateForm

  //-->
        </script>
        
    </head>
    
    <body onLoad="self.focus(); init();">
        
        <div class="functionhead"><i18n:label code="DISTRIBUTOR_SALESORDER_FORM"/></div>
        
        <%@ include file="/lib/return_error_msg.jsp"%>
        
        <form name="frmSalesOrder" action="" method="post">
            
            <table class="tbldata" border="0" width="1000">
                
                <tr>
                    <td class="td1" width="100">Boutique :</td>
                    <td width="100"><%= bean.getSellerID() %></td> 
                    <td>&nbsp;</td>
                    <td class="td1" width="100">Trx Date :</td>
                    <td width="100"><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getTrxDate() %>" /></td>
                    <td>&nbsp;</td>
                    <td class="td1" width="100">Sales ID :</td>
                    <td width="100"><%= bean.getBonusEarnerID() %></td>         
                    
                </tr>
                <tr>
                    <td class="td1">Customer ID :</td>
                    <td><std:text value="<%= bean.getCustomerID() %>"/></td>             
                    <td>&nbsp;</td>
                    <td class="td1">Price Code :</td>
                    <td><std:text value="<%= bean.getPriceCode() %>"/></td>  
                    <td>&nbsp;</td>
                    <td class="td1" >Nama :</td>
                    <td><std:text value="<%= bean.getBonusEarnerName() %>"/></td>          
                    
                </tr>
                <tr>
                    <td class="td1">Name :</td>
                    <td><std:text value="<%= bean.getCustomerName()%>"/></td>
                    <td>&nbsp;</td>
                    <td class="td1">All amounts in :</td>
                    <td><%= bean.getLocalCurrency() %></td>
                    <td colspan="3">&nbsp;</td>      
                    
                    
                </tr>
                
                <tr>
                    <td class="td1" valign="top">Contacts :</td>
                    <td><std:text value="<%= bean.getCustomerContact()%>"/></td>
                    
                    <td>&nbsp;</td>
                    <td class="td1" valign="top">Delivery By:</td>
                    <td valign="top"><std:text value="<%= bean.getShipByStoreCode() %>"/></td>
                    
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
                            <td align="center" width="8%" nowrap><i18n:label code="GENERAL_QTYFOC"/></td>
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
                        <% if ((itemBeans[i].getQtyOnHand() > 0) |  (itemBeans[i].getType().equalsIgnoreCase(ProductManager.PRODUCT_COMBO))) { %>
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
                                <std:input type="text" name="<%= "Qty_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" status="<%= "style=text-align:right "  + ("onKeyUp='calcUnit1("+ itemId + ", "+ stockBalance + ", this); Cart("+ itemId+")';") %>" size="4" maxlength="4"/>                        
                            </td>
                            <td align=center>
                                <std:input type="text" name="<%= "Foc_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" status="<%= "style=text-align:right " + ("onKeyUp='calcUnitFoc("+ itemId + ", this); Cart("+ itemId+")';")  %>" size="4" maxlength="4"/>
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
                            } // end for IF
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
                    <td colspan="7"><b><i18n:label code="SALES_DISCOUNT_AMOUNT"/>:</b></td>
                    <td><std:input type="text" name="DiscountAmount" status="style=text-align:right onBlur=\"calcDiscountAmount(this);\"" size="20" maxlength="14"/>
                    </td>
                </tr>
                <tr align=right>
                    <td colspan="7"><b>Deposit Amount:</b></td>
                    <td valign="top"><std:bvformater value="<%= quotaBv %>"/></td>
                    
                </tr>          
                <tr align=right>
                    <td colspan="7"><b><i18n:label code="GENERAL_NET_TOTAL"/>:</b></td>
                    <td><LABEL ID="Grandtotal">0.00</LABEL></td>
                </tr>
            </table>
            
            <br>
            
            <hr>
            
            
            
            <b><u>Payment Information</u></b>
            <br>
            <br>
            <table width="700" border="0">
                <tr>
                    <td align="center">Payment Type</td>
                    <td align="center">EDC Type</td>
                    <td align="center">Card Number</td>
                    <td align="center">Payment Time</td>
                    <td align="center">Payment Amount</td>
                    <td align="center"></td>
                </tr>
                
                
                <tr> 
                    <td>
                        <select name= "tipe_payment" >
                            <option value="1" > AR  </option>
                            <option value="2" > CASH  </option>
                            <option value="3" > CREDIT CARD </option>
                            <option value="4" > DEBIT CARD </option>
                            <option value="5" > VOUCHER </option>
                        </SELECT>    
                    </td>    
                    <td>
                        <select name= "tipe_edc" >
                            <option value="1" > EDC BCA BP  </option>
                            <option value="2" > EDC CTBK BP </option>
                            <option value="3" > EDC CITY BANK </option>
                            <option value="4" > EDC BANK MANDIRI </option>
                        </SELECT>    
                    </td>  
                    <td>
                        <std:input type="text" name="card_number" size="30" maxlength="50"/>
                    </td>
                    
                    <td>
                        <select name= "time_payment" >   
                            <option value="1" > AMEX </option>
                            <option value="2" > AR </option>
                            <option value="3" > BCA 12 BLN </option>
                            <option value="4" > BCA 6 BLN </option>
                            <option value="5" > BCA CARD </option>
                            <option value="6" > CASH </option>
                            <option value="7" > DEBIT BCA </option>
                            <option value="8" > DEBIT MEGA </option>
                            <option value="9" > EAZY PAY </option>
                            <option value="10" > EAZY PAY 12 BLN </option>
                            <option value="11" > EAZY PAY 3 BLN </option>
                            <option value="12" > EAZY PAY 6 BLN </option>
                            <option value="13" > MEGA PAY 12 BLN </option>
                            <option value="14" > MEGA PAY 6 BLN </option>
                            <option value="15" > POWERBUY 12 BLN </option>
                            <option value="16" > POWERBUY 6 BLN </option>
                            <option value="17" > VISA/MASTER </option>
                        </SELECT>    
                    </td>   
                    
                    <td>
                        <std:input type="text" name="net_payment" size="20" maxlength="50"/>
                    </td>                        
                    <td>
                        <a href=''>
                            <img border="0" src="<%= Sys.getWebapp() %>/img/money_red.gif"> 
                        </a>
                    </td>                        
                </TR>
                <tr> 
                    <td>
                        <select name= "tipe_payment" >
                            <option value="1" > AR  </option>
                            <option value="2" > CASH  </option>
                            <option value="3" > CREDIT CARD </option>
                            <option value="4" > DEBIT CARD </option>
                            <option value="5" > VOUCHER </option>
                        </SELECT>    
                    </td>    
                    <td>
                        <select name= "tipe_edc" >
                            <option value="1" > EDC BCA BP  </option>
                            <option value="2" > EDC CTBK BP </option>
                            <option value="3" > EDC CITY BANK </option>
                            <option value="4" > EDC BANK MANDIRI </option>
                        </SELECT>    
                    </td>  
                    <td>
                        <std:input type="text" name="card_number" size="30" maxlength="50"/>
                    </td>
                    
                    <td>
                        <select name= "time_payment" >   
                            <option value="1" > AMEX </option>
                            <option value="2" > AR </option>
                            <option value="3" > BCA 12 BLN </option>
                            <option value="4" > BCA 6 BLN </option>
                            <option value="5" > BCA CARD </option>
                            <option value="6" > CASH </option>
                            <option value="7" > DEBIT BCA </option>
                            <option value="8" > DEBIT MEGA </option>
                            <option value="9" > EAZY PAY </option>
                            <option value="10" > EAZY PAY 12 BLN </option>
                            <option value="11" > EAZY PAY 3 BLN </option>
                            <option value="12" > EAZY PAY 6 BLN </option>
                            <option value="13" > MEGA PAY 12 BLN </option>
                            <option value="14" > MEGA PAY 6 BLN </option>
                            <option value="15" > POWERBUY 12 BLN </option>
                            <option value="16" > POWERBUY 6 BLN </option>
                            <option value="17" > VISA/MASTER </option>
                        </SELECT>    
                    </td>   
                    
                    <td>
                        <std:input type="text" name="net_payment" size="20" maxlength="50"/>
                    </td>                        
                    <td>
                        <a href=''>
                            <img border="0" src="<%= Sys.getWebapp() %>/img/money_red.gif"> 
                        </a>
                    </td>                        
                </TR>
                <tr> 
                    <td>
                        <select name= "tipe_payment" >
                            <option value="1" > AR  </option>
                            <option value="2" > CASH  </option>
                            <option value="3" > CREDIT CARD </option>
                            <option value="4" > DEBIT CARD </option>
                            <option value="5" > VOUCHER </option>
                        </SELECT>    
                    </td>    
                    <td>
                        <select name= "tipe_edc" >
                            <option value="1" > EDC BCA BP  </option>
                            <option value="2" > EDC CTBK BP </option>
                            <option value="3" > EDC CITY BANK </option>
                            <option value="4" > EDC BANK MANDIRI </option>
                        </SELECT>    
                    </td>  
                    <td>
                        <std:input type="text" name="card_number" size="30" maxlength="50"/>
                    </td>
                    
                    <td>
                        <select name= "time_payment" >   
                            <option value="1" > AMEX </option>
                            <option value="2" > AR </option>
                            <option value="3" > BCA 12 BLN </option>
                            <option value="4" > BCA 6 BLN </option>
                            <option value="5" > BCA CARD </option>
                            <option value="6" > CASH </option>
                            <option value="7" > DEBIT BCA </option>
                            <option value="8" > DEBIT MEGA </option>
                            <option value="9" > EAZY PAY </option>
                            <option value="10" > EAZY PAY 12 BLN </option>
                            <option value="11" > EAZY PAY 3 BLN </option>
                            <option value="12" > EAZY PAY 6 BLN </option>
                            <option value="13" > MEGA PAY 12 BLN </option>
                            <option value="14" > MEGA PAY 6 BLN </option>
                            <option value="15" > POWERBUY 12 BLN </option>
                            <option value="16" > POWERBUY 6 BLN </option>
                            <option value="17" > VISA/MASTER </option>
                        </SELECT>    
                    </td>   
                    
                    <td>
                        <std:input type="text" name="net_payment" size="20" maxlength="50"/>
                    </td>                        
                    <td>
                        <a href=''>
                            <img border="0" src="<%= Sys.getWebapp() %>/img/money_red.gif"> 
                        </a>
                    </td>                        
                </TR>                    
                <tr> 
                    <td>
                        <select name= "tipe_payment" >
                            <option value="1" > AR  </option>
                            <option value="2" > CASH  </option>
                            <option value="3" > CREDIT CARD </option>
                            <option value="4" > DEBIT CARD </option>
                            <option value="5" > VOUCHER </option>
                        </SELECT>    
                    </td>    
                    <td>
                        <select name= "tipe_edc" >
                            <option value="1" > EDC BCA BP  </option>
                            <option value="2" > EDC CTBK BP </option>
                            <option value="3" > EDC CITY BANK </option>
                            <option value="4" > EDC BANK MANDIRI </option>
                        </SELECT>    
                    </td>  
                    <td>
                        <std:input type="text" name="card_number" size="30" maxlength="50"/>
                    </td>
                    
                    <td>
                        <select name= "time_payment" >   
                            <option value="1" > AMEX </option>
                            <option value="2" > AR </option>
                            <option value="3" > BCA 12 BLN </option>
                            <option value="4" > BCA 6 BLN </option>
                            <option value="5" > BCA CARD </option>
                            <option value="6" > CASH </option>
                            <option value="7" > DEBIT BCA </option>
                            <option value="8" > DEBIT MEGA </option>
                            <option value="9" > EAZY PAY </option>
                            <option value="10" > EAZY PAY 12 BLN </option>
                            <option value="11" > EAZY PAY 3 BLN </option>
                            <option value="12" > EAZY PAY 6 BLN </option>
                            <option value="13" > MEGA PAY 12 BLN </option>
                            <option value="14" > MEGA PAY 6 BLN </option>
                            <option value="15" > POWERBUY 12 BLN </option>
                            <option value="16" > POWERBUY 6 BLN </option>
                            <option value="17" > VISA/MASTER </option>
                        </SELECT>    
                    </td>   
                    
                    <td>
                        <std:input type="text" name="net_payment" size="20" maxlength="50"/>
                    </td>                        
                    <td>
                        <a href=''>
                            <img border="0" src="<%= Sys.getWebapp() %>/img/money_red.gif"> 
                        </a>
                    </td>                        
                </TR>
                <br>
                <tr>
                    <td align="right" colspan="4"><b>Total Payment : </b></td>
                    <td align="Left" >Rp </td>
                    <td></td>
                </tr>
                <tr>
                    <td align="right" colspan="4"><b>Balance : </b></td>
                    <td align="Left" >Rp </td>
                    <td></td>
                </tr>
                <tr>
                    <td align="right" colspan="4"><b>Change Due : </b></td>
                    <td align="Left" >Rp </td>
                    <td></td>
                </tr>    
                
                <tr valign=top>
                    <td class="td1" width="130">Remarks:</td>
                    <td colspan="3"><textarea name="Remark1" cols="40" rows="5"></textarea></td>
                </tr>	     
                
                <br>
                
            </TABLE> 
            
            <hr>                
            <br>  
            <u>Payment Information (Old)</u>
            <br>  
            
            
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
                    <td class="td1Focus"><b><i18n:label code="SALES_BALANCE"/>:</b></td>
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
            
            <table width="700" border="0">
                
                <tr>
                    <td align="center">Payment Type :</td>
                    <td align="center">EDC Type :</td>
                    <td align="center">Card Number :</td>
                    <td align="center">Payment Time :</td>
                    <td align="center">Payment Amount :</td>
                    <td></td>
                    
                </tr>
                
                <tr>
                    <td><std:input type="select_country" name="CountryID1" form="frmSalesOrder"/></td>
                    <td><std:input type="select_state" name="StateID1" form="frmSalesOrder"/></td>
                    <td><std:input type="text" name="reference1" size="30" maxlength="50"/></td>
                    <td><std:input type="select_city" name="CityID1" form="frmSalesOrder"/></td>
                    <td><std:input type="text" name="bayar1" status="onBlur=\"calcAmountPaid(this);\"" size="10"/></td>
                    <td>
                        <a href=''>
                            <img border="0" src="<%= Sys.getWebapp() %>/img/money_red.gif"> 
                        </a>
                    </td>                     
                </tr>
                <tr>
                    <td><std:input type="select_country" name="CountryID2" form="frmSalesOrder"/></td>
                    <td><std:input type="select_state" name="StateID2" form="frmSalesOrder"/></td>
                    <td><std:input type="text" name="reference2" size="30" maxlength="50"/></td>
                    <td><std:input type="select_city" name="CityID2" form="frmSalesOrder"/></td>
                    <td><std:input type="text" name="bayar2" status="onBlur=\"calcAmountPaid(this);\"" size="10"/></td>
                    <td>
                        <a href=''>
                            <img border="0" src="<%= Sys.getWebapp() %>/img/money_red.gif"> 
                        </a>
                    </td>                     
                </tr>                
                
            </table>
            
            <br>
            
            <std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
            <std:input type="hidden" name="CustomerID" value="<%= bean.getCustomerID() %>"/> 
            <std:input type="hidden" name="CustomerName" value="<%= bean.getCustomerName() %>"/> 
            
            <std:input type="hidden" name="TotalBV" value="0"/> 
            <std:input type="hidden" name="TotalItems" value="<%= (itemBeans != null) ? String.valueOf(itemBeans.length) : "0" %>"/> 
            
            <input class="textbutton" type="button" name="btnSubmit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form)">
            
            <%
            } // end canView
            %>
            
        </form>
        
    </body>
</html>
