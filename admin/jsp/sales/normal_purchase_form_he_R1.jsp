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

System.out.println("Okkkk ");
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
    
function showEmp1(sku_kode)
{ 

if(document.getElementById("icode_1").value!="-1")
{
    xmlHttp=GetXmlHttpObject();

    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return
        
    }
 
    var url="NoUse.jsp";
    url=url+"?sku_kode="+sku_kode;

    xmlHttp.onreadystatechange=stateChanged1; 
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
else
{
   alert("Please Fill Product Code 1 ...");
}

}

function stateChanged1() 
{ 
	document.getElementById("ibrand_1").value ="";
	document.getElementById("iname_1").value ="";
	document.getElementById("iserial_1").value ="";
	document.getElementById("iprice_1").value ="";	 
        
        document.getElementById("ipricerate_1").value ="";
        document.getElementById("iproductID_1").value ="";
        document.getElementById("ipricingID_1").value ="";
        document.getElementById("irate_1").value ="";
        
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  var showdata = xmlHttp.responseText; 
  // alert(showdata);
  var strar = showdata.split(":");
	
	 if(strar.length==1)
	 {
         
        document.getElementById("icode_1").focus(); 

	document.getElementById("ibrand_1").value ="";
	document.getElementById("iname_1").value ="";
	document.getElementById("iserial_1").value ="";
	document.getElementById("iprice_1").value ="";	
        
        document.getElementById("ipricerate_1").value ="";	        
        document.getElementById("iproductID_1").value ="";
        document.getElementById("ipricingID_1").value ="";
        document.getElementById("irate_1").value ="";
        
	 }
	 else if(strar.length>1)
	 {
		var strname = strar[1];
		
                document.getElementById("iname_1").value= strar[3];
		document.getElementById("ibrand_1").value= strar[4];
                document.getElementById("iprice_1").value= strar[5];  
                document.getElementById("iserial_1").value= strar[6];
                document.getElementById("icode_1").value= strar[10];
                                
                document.getElementById("ipricerate_1").value = strar[9];
                document.getElementById("iproductID_1").value = strar[1];
                document.getElementById("ipricingID_1").value = strar[7];
                document.getElementById("irate_1").value = strar[8];
                
                // alert ("iproductID_1 : " + iproductID_1 + "ipricingID_1 : "+ ipricingID_1)
                
                // document.getElementById("iproductID_1").name= "icode_1_".concat(strar[2]).concat("_").concat(strar[1]);
                // document.getElementById("ipricingID_1").name= "iname_1_".concat(strar[2]).concat("_").concat(strar[1]);
                // document.getElementById("brand_1").name= "ibrand_1_".concat(strar[2]).concat("_").concat(strar[1]);
                // document.getElementById("serial_1").name= "iserial_1_".concat(strar[2]).concat("_").concat(strar[1]);
                // document.getElementById("price_1").name= "iprice_1_".concat(strar[2]).concat("_").concat(strar[1]);
                
                // document.getElementById("iname_1").name= "iname_".concat(strar[4]).concat("_").concat(strar[3]);
		// document.getElementById("icode_1").name= "icode_".concat(strar[4]).concat("_").concat(strar[3]);
		// document.getElementById("iprice_1").name= "iprice_".concat(strar[4]).concat("_").concat(strar[3]);
	 }
	
 }
}

function showEmp2(sku_kode)
{ 

if(document.getElementById("icode_2").value!="-1")
{
    xmlHttp=GetXmlHttpObject();

    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return
    }
 
    var url="NoUse.jsp";
    url=url+"?sku_kode="+sku_kode;

    xmlHttp.onreadystatechange=stateChanged2; 
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
else
{
   alert("Please Fill Product Code 2 ...");
}

}

function stateChanged2() 
{ 
	document.getElementById("ibrand_2").value ="";
	document.getElementById("iname_2").value ="";
	document.getElementById("iserial_2").value ="";
	document.getElementById("iprice_2").value ="";	 
        
        document.getElementById("ipricerate_2").value ="";
        document.getElementById("iproductID_2").value ="";
        document.getElementById("ipricingID_2").value ="";
        document.getElementById("irate_2").value ="";
        
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  var showdata = xmlHttp.responseText; 
  // alert(showdata);
  var strar = showdata.split(":");
	
	 if(strar.length==1)
	 {
            document.getElementById("icode_2").focus(); 
            
            document.getElementById("ibrand_2").value ="";
            document.getElementById("iname_2").value ="";
            document.getElementById("iserial_2").value ="";
            document.getElementById("iprice_2").value ="";	 
        
            document.getElementById("ipricerate_2").value ="";
            document.getElementById("iproductID_2").value ="";
            document.getElementById("ipricingID_2").value ="";
            document.getElementById("irate_2").value ="";

         }
	 else if(strar.length>1)
	 {
		var strname = strar[1];
		
                document.getElementById("iname_2").value= strar[3];
		document.getElementById("ibrand_2").value= strar[4];
                document.getElementById("iprice_2").value= strar[5];  
                document.getElementById("iserial_2").value= strar[6];
                document.getElementById("icode_2").value= strar[10];
                                
                document.getElementById("ipricerate_2").value = strar[9];
                document.getElementById("iproductID_2").value = strar[1];
                document.getElementById("ipricingID_2").value = strar[7];
                document.getElementById("irate_2").value = strar[8];          
                 
		// document.getElementById("iname_2").name= "iname_".concat(strar[4]).concat("_").concat(strar[3]);
		// document.getElementById("icode_2").name= "icode_".concat(strar[4]).concat("_").concat(strar[3]);
		// document.getElementById("iprice_2").name= "iprice_".concat(strar[4]).concat("_").concat(strar[3]);
	 }
	
 }
}

function showEmp3(sku_kode)
{ 

if(document.getElementById("icode_3").value!="-1")
{
    xmlHttp=GetXmlHttpObject();

    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return
    }
 
    var url="NoUse.jsp";
    url=url+"?sku_kode="+sku_kode;

    xmlHttp.onreadystatechange=stateChanged3; 
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
else
{
   alert("Please Fill Product Code 3 ...");
}

}

function stateChanged3() 
{ 
	document.getElementById("ibrand_3").value ="";
	document.getElementById("iname_3").value ="";
	document.getElementById("iserial_3").value ="";
	document.getElementById("iprice_3").value ="";	 
        
        document.getElementById("ipricerate_3").value ="";
        document.getElementById("iproductID_3").value ="";
        document.getElementById("ipricingID_3").value ="";
        document.getElementById("irate_3").value ="";

	
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  var showdata = xmlHttp.responseText; 
  // alert(showdata);
  var strar = showdata.split(":");
	
	 if(strar.length==1)
	 {
            document.getElementById("icode_3").focus(); 
            
            document.getElementById("ibrand_3").value ="";
            document.getElementById("iname_3").value ="";
            document.getElementById("iserial_3").value ="";
            document.getElementById("iprice_3").value ="";	 
        
            document.getElementById("ipricerate_3").value ="";
            document.getElementById("iproductID_3").value ="";
            document.getElementById("ipricingID_3").value ="";
            document.getElementById("irate_3").value =""; 

	 }
	 else if(strar.length>1)
	 {
		var strname = strar[1];
		
                document.getElementById("iname_3").value= strar[3];
		document.getElementById("ibrand_3").value= strar[4];
                document.getElementById("iprice_3").value= strar[5];  
                document.getElementById("iserial_3").value= strar[6];
                document.getElementById("icode_3").value= strar[10];
                                
                document.getElementById("ipricerate_3").value = strar[9];
                document.getElementById("iproductID_3").value = strar[1];
                document.getElementById("ipricingID_3").value = strar[7];
                document.getElementById("irate_3").value = strar[8];

		
		// document.getElementById("iname_3").name= "iname_".concat(strar[4]).concat("_").concat(strar[3]);
		// document.getElementById("icode_3").name= "icode_".concat(strar[4]).concat("_").concat(strar[3]);
		// document.getElementById("iprice_3").name= "iprice_".concat(strar[4]).concat("_").concat(strar[3]);
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
		// if (selectedUnit == 0 && selectedFocUnit == 0 && selectedDiscUnit == 0 ) {
		//	alert("No Sales Order Info");
		//	return;
		// }

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
                    <td ID="sales"> 
                        <input type="text" name="isales" id="isales" value="<%= bean.getBonusEarnerID() %>" disabled>
                            <input type="hidden" id="sales" value="isales" > 
                    </td>                     
                    
                </tr>
                <tr>
                    <td class="td1">Name :</td>
                    <td> <std:input type="text" name="CustomerName" value="<%= bean.getCustomerName() %>"/></td>   
                    <td>&nbsp;</td>
                    <td class="td1"></td>
                    <td><std:text value="<%= bean.getCustomerContact()%>"/></td>
                    <td >&nbsp;</td>      
                    <td class="td1" >Nama :</td>                    
                    <td width="100"><%= bean.getBonusEarnerName() %></td>                                
                </tr>
                
                <tr>
                    <td class="td1" width="100">Trx Date :</td>
                    <td width="100"><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getTrxDate() %>" /></td>
                    <td>&nbsp;</td>
                    <td class="td1"></td>
                    <td>&nbsp;</td>
                    <td >&nbsp;</td>      
                    <td class="td1" >Rate SGD :</td>
                    <td ID="rate"> 
                        <input type="text" name="irate" id="irate" value="6800" disabled>
                            <input type="hidden" id="rate" value="irate" > 
                    </td>                    
                    
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
            
            <table class="listbox" width="80%">
                
                
                <tr class="boxhead" valign="top" >
                    <td nowrap>Item Number</td>
                    <td nowrap>Brand</td>
                    <td nowrap>Item Description</td>
                    <td nowrap>Product Code/ <br>Serial Number</td>
                    <td align="right" nowrap><i18n:label code="PRODUCT_UNIT_PRICE"/> <br> (SGD)</td>
                    <td align="right" nowrap><i18n:label code="PRODUCT_UNIT_PRICE"/> <br> (<%= bean.getLocalCurrencySymbol() %>)</td>
                    <td align="center" nowrap><i18n:label code="GENERAL_QTY"/></td>            
                    <td align="center" nowrap>Disc (Rp)</td>
                    <td align="center" nowrap>Disc (%)</td>
                    <td align="right" ><i18n:label code="GENERAL_TOTAL_AMOUNT"/><br>(<%= bean.getLocalCurrencySymbol() %>)</td>
                    <td align="center" nowrap>Sales ID</td>
                </tr>  
                
                <%            
                for(int i=1;i<4;i++) {
                    
                    String productid = "";
                    String pricingid = "";
                    String test = "";
                %>
                
                <tr>
                    
                    <td ID="<% out.print( "code_" +i); %>">
                        <input type="text" name="icode_<%= i%>" id="icode_<%= i%>" value="" onKeyUp="showEmp<%= i%>(this.value);" size="10" maxlength="10"> 
                        <input type="hidden" id="code_<%= i%> " value="icode_<%= i%>" > 
                    </td>
                    
                    <td ID="<% out.print( "brand_" +i); %>">    
                        <input  type="text" name="ibrand_<%= i%>" id="ibrand_<%= i%>" value="" disabled size="5" maxlength="5">
                        <input type="hidden" id="brand_<%= i%>" value="ibrand_<%= i%>" > 
                    </td>
                    
                    <td ID="<% out.print( "name_" +i); %>"> 
                        <input  type="text" name="iname_<%= i%>" id="iname_<%= i%>" value="" disabled size="25" maxlength="25">
                        <input type="hidden" id="name_<%= i%>" value="iname_<%= i%>" > 
                    </td>                    
                    <td ID="<% out.print( "serial_" +i); %>"> 
                        <input  type="text" name="iserial_<%= i%>" id="iserial_<%= i%>" value="" disabled size="10" maxlength="10">
                        <input type="hidden" id="serial_<%= i%>" value="iserial_<%= i%>" > 
                    </td>                        
                    <td ID="<% out.print( "price_" +i); %>"> 
                        <input  type="text" name="iprice_<%= i%>" id="iprice_<%= i%>" value="" disabled size="10" maxlength="10">
                        <input type="hidden" id="price_<%= i%>" value="iprice_<%= i%>" > 
                    </td> 
                    <td ID="<% out.print( "pricerate_" +i); %>"> 
                        <input  type="text" name="ipricerate_<%= i%>" id="ipricerate_<%= i%>" value="" disabled size="10" maxlength="10">
                        <input type="hidden" id="pricerate_<%= i%>" value="ipricerate_<%= i%>" > 
                    </td>     
                    
                    <td align=center>
                        <input type="text" name="<%= "Qty_" + i  %>"  status="<%= "style=text-align:right "  + ("onKeyUp='CalcQty("+ i + ", this); noBvCarte("+ i+")';") %>" size="4" maxlength="4"/>

                        <%
                        test = "Qty_"+i ;
                        System.out.println("test " + test);
                        %>
                        
                    </td>
                    
                    <td align=center>
                        <input type="text" name="<%= "Foc_" + i %>" status="<%= "style=text-align:right " + ("onKeyUp='CalcQty("+ i + ", this); noBvCarte("+ i+")';") %>" size="4" maxlength="4"/>
                        
                    </td>
                    
                    <td> 
                        <input type="text" name="<%= "Disc_" + i %>" status="<%= "style=text-align:right " + ("onKeyUp='CalcQty("+ i + ", this); noBvCarte("+ i+")';") %>" size="4" maxlength="4"/>
                    </td>      
                    
                    
                    <td align=right ID="total">
                        <LABEL ID="total"></LABEL>
                        <input type="text" id="<%= "total_" + i %>" name="<% out.print( "total_" + i); %>" value="0"  size="12" maxlength="12">
                        <input type="hidden" id="<%= "Amt_" + i %>" value="1"> 
                    </td>
                    
                    <td ID="<% out.print( "sales_" +i); %>"> 
                        <input  type="text" name="isales_<%= i%>" id="isales_<%= i%>" value="" size="10" maxlength="10">
                        <input type="hidden" id="sales_<%= i%>" value="isales_<%= i%>" > 
                    </td> 
                    
                </tr> 
                <tr>
                    <td ID="<% out.print( "productID_" +i); %>">    
                        <input  type="text" name="iproductID_<%= i%>" id="productID_<%= i%>" value="" disabled size="5" maxlength="5">
                        <input type="hidden" name="productID_<%= i%>" id="productID_<%= i%>" value="iproductID_<%= i%>" > 
                        <%
                        productid = "iproductID_"+i ;
                        System.out.println("productid " + productid);
                        %>
                        
                    </td>
                    <td ID="<% out.print( "pricingID_" +i); %>">  
                        <input  type="text" name="ipricingID_<%= i%>" id="pricingID_<%= i%>" value="" disabled size="5" maxlength="5">
                        <input type="hidden" name="pricingID_<%= i%>"  id="pricingID_<%= i%>" value="ipricingID_<%= i%>" > 
                        <%
                        pricingid = "ipricingID_"+i ;
                        System.out.println("pricingid " + pricingid);
                        %>

                    </td>                    
                    <td ID="<% out.print( "rate_" +i); %>">  
                        <input  type="text" name="irate_<%= i%>" id="rate_<%= i%>" value="" disabled size="5" maxlength="5">
                        <input type="hidden" name="irate_<%= i%>" id="rate_<%= i%>" value="irate_<%= i%>" > 
                    </td>   
                    <td colspan="8">                        
                    </td>
                    
                </tr>
  
                                
                <%
                } // loop 3x
                %>                
                
            </table>
            
            <table>
                <tr align="right">
                    <td align="right" colspan="9">
                    <a href=""> Add Row </a></td>                    
                </tr> 
                
            </table>
            
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
                        
                        <input type="text" name="expired_<%= i%>" value="" size="12" maxlength="12" />
                        
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
                    <td width="130" align="right"><b><i18n:label code="SALES_CHANGE_DUE"/> :</b></td>
                    <td>
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


