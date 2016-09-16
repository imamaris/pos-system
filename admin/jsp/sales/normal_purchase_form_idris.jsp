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



<script type="text/javascript">
function showEmp(sku_kode)
{ 
	if(document.getElementById("code_[1]").value!="-1")
	{
 xmlHttp=GetXmlHttpObject()
if (xmlHttp==null)
 {
 alert ("Browser does not support HTTP Request")
 return
 }
var url="GetProduct.jsp"
url=url+"?sku_kode="+sku_kode

xmlHttp.onreadystatechange=stateChanged 
xmlHttp.open("GET",url,true)
xmlHttp.send(null)

	}
	else
	{
		 alert("Please Fill Product Code ...");
	}
}

function stateChanged() 
{ 
	document.getElementById("name_[1]").value ="";
	document.getElementById("price_[1]").value ="";
	
	document.getElementById("name_[2]").value ="";
	document.getElementById("price_[2]").value ="";
	
	
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  var showdata = xmlHttp.responseText; 
    var strar = showdata.split(":");
	
	 if(strar.length==1)
	 {
		  document.getElementById("code_[1]").focus();
		  document.getElementById("name_[1]").value =" ";
	      document.getElementById("price_[1]").value =" ";
		  

	 }
	 else if(strar.length>1)
	 {
		var strname = strar[1];
		
		document.getElementById("price_[1]").value= strar[2];
		document.getElementById("name_[1]").value= strar[1];	
		// name_24_46
		document.getElementById("name_[1]").name= "name_".concat(strar[4]).concat("_").concat(strar[3]);
		document.getElementById("code_[1]").name= "code_".concat(strar[4]).concat("_").concat(strar[3]);
		document.getElementById("price_[1]").name= "price_".concat(strar[4]).concat("_").concat(strar[3]);
	 }
	
 } 
}


// Ajax Script Add By Idris
function showEmp2(sku_kode)
{ 
	if(document.getElementById("code_[1]").value!="-1")
	{
 xmlHttp=GetXmlHttpObject()
if (xmlHttp==null)
 {
 alert ("Browser does not support HTTP Request")
 return
 }
var url="GetProduct.jsp"
url=url+"?sku_kode="+sku_kode

xmlHttp.onreadystatechange=stateChanged2 
xmlHttp.open("GET",url,true)
xmlHttp.send(null)

	}
	else
	{
		 alert("Please Fill Product Code ...");
	}
}

function stateChanged2() 
{ 

	
	document.getElementById("name_[2]").value ="";
	document.getElementById("price_[2]").value ="";

	
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  var showdata = xmlHttp.responseText; 
    var strar = showdata.split(":");
	
         alert("Data " + strar);
         
	 if(strar.length==1)
	 {

		  
		  document.getElementById("code_[2]").focus();
		  document.getElementById("name_[2]").value =" ";
	      document.getElementById("price_[2]").value =" ";

	 }
	 else if(strar.length>1)
	 {
		var strname = strar[1];
		
		
		document.getElementById("price_[2]").value= strar[2];
		document.getElementById("name_[2]").value= strar[1];	
		// name_24_46
		document.getElementById("name_[2]").name= "name_".concat(strar[4]).concat("_").concat(strar[3]);
		document.getElementById("code_[2]").name= "code_".concat(strar[4]).concat("_").concat(strar[3]);
		document.getElementById("price_[2]").name= "price_".concat(strar[4]).concat("_").concat(strar[3]);
	
	 }
	
 } 
}

function GetXmlHttpObject()
{
var xmlHttp=null;
try
 {
 // Firefox, Opera 8.0+, Safari
 xmlHttp=new XMLHttpRequest();
 }
catch (e)
 {
 //Internet Explorer
 try
  {
  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
  }
 catch (e)
  {
  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
 }
return xmlHttp;
}
</script>


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
		 
	} // end validateForm
	
  //-->
  </script>

</head>

<body onLoad="self.focus(); init();">

<div class="functionhead"><%= taskTitle %> - <i18n:label code="SALES_ORDER_FORM"/></div>

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
		<td align="right" width="12%" nowrap><i18n:label code="PRODUCT_UNIT_PRICE"/> <br> (<%= bean.getLocalCurrencySymbol() %>)</td>
                <td align="right" width="8%" nowrap><i18n:label code="STOCK_BALANCE"/></td>
		<td align="center" width="8%" nowrap><i18n:label code="GENERAL_QTY"/></td>            
                <td align="center" width="8%" nowrap>Disc (%) </td>
		<td align="center" width="8%" nowrap>Disc (Rp)</td>
		<td align="right" width="12%"><i18n:label code="GENERAL_TOTAL_AMOUNT"/><br>(<%= bean.getLocalCurrencySymbol() %>)</td>
	</tr>

<%
			int no = 0;
			String stockBalance = "";
			String quantity = "";
                        
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
		
		
		<td><input  type="text" name="code_[1]" id="code_[1]" value="" onkeypress="showEmp(this.value);">		</td>
		<td><input  type="text" name="name_[1]" id="name_[1]" value=""></td>
		<td><input  type="text" name="price_[1]" id="price_[1]" value=""></td>

        <td align=center>
			<std:input type="text" name="<%= "Qty_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" status="<%= "style=text-align:right "  + ("onKeyUp='calcUnit("+ itemId + ", this); noBvCart("+ itemId+")';") %>" size="4" maxlength="4"/>
		</td>
                
                <% quantity = "Qty_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID(); %> 
                
		<td align=right>
			<LABEL ID="Disc1_<%= itemBeans[i].getCatID()%>_<%= itemBeans[i].getProductID() %>"></LABEL>
		</td>                                
                <td align=center>
			<std:input type="text" name="<%= "Foc_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" status="<%= "style=text-align:right " + ("onKeyUp='calcUnitFoc("+ itemId + ",  "+ quantity + ", this); noBvCart("+ itemId+")';")  %>" size="15" maxlength="15"/>
		</td>
		<td align=right>
			<LABEL ID="Amt_<%= itemBeans[i].getCatID()%>_<%= itemBeans[i].getProductID() %>"></LABEL>
		</td>
	</tr>

	<tr>
		<td><%= (no + 1) %>.</td>
		
		
		<td><input  type="text" name="code_[2]" id="code_[2]" value="" onkeypress="showEmp2(this.value);">		</td>
		<td><input  type="text" name="name_[2]" id="name_[2]" value=""></td>
		<td><input  type="text" name="price_[2]" id="price_[2]" value=""></td>

        <td align=center>
			<std:input type="text" name="<%= "Qty_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" status="<%= "style=text-align:right "  + ("onKeyUp='calcUnit("+ itemId + ", this); noBvCart("+ itemId+")';") %>" size="4" maxlength="4"/>
		</td>
                
                <% quantity = "Qty_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID(); %> 
                
		<td align=right>
			<LABEL ID="Disc1_<%= itemBeans[i].getCatID()%>_<%= itemBeans[i].getProductID() %>"></LABEL>
		</td>                                
                <td align=center>
			<std:input type="text" name="<%= "Foc_" + itemBeans[i].getCatID() + "_" + itemBeans[i].getProductID() %>" status="<%= "style=text-align:right " + ("onKeyUp='calcUnitFoc("+ itemId + ",  "+ quantity + ", this); noBvCart("+ itemId+")';")  %>" size="15" maxlength="15"/>
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

<div>&nbsp;</div>

<div>&nbsp;</div>

<table width="700">
	<tr align="right">
		<td colspan="6" width="500">&nbsp;</td>
		<td colspan="1" nowrap><b>Net Price :</b></td>
		<td><LABEL ID="Total">0.00</LABEL></td>
	</tr>
	<tr>
		<td colspan="8">&nbsp;</td>
	</tr>
        
        <std:input type="hidden" name="DeliveryAmount" value="0"/>
        
        <std:input type="hidden" name="DiscountAmount" value="0"/>
        
	<tr align=right>
		<td colspan="7"><b>Net Price :</b></td>
		<td><LABEL ID="Grandtotal">0.00</LABEL></td>
	</tr>
        
</table>

<br>

            <hr>                
                <br>  
            <u>Payment Information (Old)</u>
                <br>  
            
            <table width="700" border="0">   
                
                <% 
                if (paymodeList != null) {
                    
                    for(int i=0;i<4;i++)
                        {
                %>
                
                <tr>		                   
                    <td class="td1" width="130">
                        <select name="paymode_<%=i%>">
                            
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
                                
                     <td>
                        <input type="text" name="amount_<%= i%>" size="20" maxlength="50" value="<%= 1000*i%>"/>
                        
                    </td>          
                     <td>
                        <input type="text" name="refNo_<%= i%>" size="20" maxlength="50" value="<%=  i %>"/>
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
