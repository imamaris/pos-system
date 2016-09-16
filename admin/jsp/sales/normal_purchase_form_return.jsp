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

// boolean canView = itemBeans != null && paymodeList != null;	
boolean canView = paymodeList != null;	
%>

<link href="<%= request.getContextPath() %>/lib/tabStyle.css" REL="stylesheet" TYPE="text/css"/>

<html>
    <head>
        <title></title>
        
        <%@ include file="/lib/header.jsp"%>
        <%@ include file="/lib/counter.jsp"%>
        
        
        <%@ include file="/lib/shoppingCart.jsp"%>
        
        
        
        <script type="text/javascript">
    
function showEmp(i, tanggal, lokasi, sku_kode)
{ 

if(document.getElementById("icode_"+i).value!="-1")
{
    xmlHttp=GetXmlHttpObject();

    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return
        
    }
 
    var url="NoUse.jsp";
    // url=url+"?sku_kode="+sku_kode;
    url=url+"?sku_kode="+sku_kode+"&tanggal="+tanggal+"&lokasi="+lokasi;

    
 xmlHttp.onreadystatechange=function() {
    if (xmlHttp.readyState==4) {
        // alert(tanggal);
      stateChanged(i, tanggal, lokasi, xmlHttp.responseText);      
    }
  };
  
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
else
{
   alert("Please Fill Product Code 1 ...");
}

}

function stateChanged(i, tanggal, lokasi, text) 
{ 
        // alert(tanggal);
	document.getElementById("ibrand_"+i).value ="";
	document.getElementById("iname_"+i).value ="";
	document.getElementById("iserial_"+i).value ="";
	document.getElementById("iprice_"+i).value ="";	 
        
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  var showdata = xmlHttp.responseText; 
  // alert(showdata);
  var strar = showdata.split(":");
	
	 if(strar.length==1)
	 {
         
        document.getElementById("icode_"+i).focus(); 

	document.getElementById("ibrand_"+i).value ="";
	document.getElementById("iname_"+i).value ="";
	document.getElementById("iserial_"+i).value ="";
	document.getElementById("iprice_"+i).value ="";	
        
	 }
	 else if(strar.length>1)
	 {
		var strname = strar[1];
		
                document.getElementById("iname_"+i).value= strar[3];
		document.getElementById("ibrand_"+i).value= strar[4];
                document.getElementById("iprice_"+i).value= strar[5];  
                document.getElementById("iserial_"+i).value= strar[6];
                document.getElementById("icode_"+i).value= strar[10];
                                
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



function split_char(i)
{
    
               var x1 = document.getElementById('paymode_'+i).value;
               var y1 = x1.substr(0,4);
               // alert (y1);
 
   if ( y1 == "CASH")
     {
       alert("Payment CASH not use SWAP ")
       document.getElementById("amount_"+i).focus(); 
     }
  else 
     {
	var a;
        var b;
	var form=document.getElementById('scanVal'+i);        
        var form_card=document.getElementById('scanVal'+i);
	
        var form_temp=document.getElementById('tempName'+i);
                
        var form_nama=document.getElementById('valName'+i);
	var form_valid=document.getElementById('valValid'+i);
        
        var form_card=document.getElementById('valCard'+i);
        
	var hidden=form.value;
  
        a=form.value.replace("<STX>","").replace("<CR>","").replace("<ETX>","").split("^");
        b=form.value.replace("<STX>","").replace("<CR>","").replace("<ETX>","").split("^");

                form_temp.value=a[0].replace(/^\s+/,"");
                
		var cc=b[0].replace(/[^\d.]/gi,"");
		var th=cc.substr(16,2);
		var bl=cc.substr(18,2);
		var th2="20".concat(th);
                form_valid.value=th2+"-"+bl+"-01";                
                
                var cc=a[0].replace(/[^\d.]/gi,"");
		form_nama.value=form_temp.value.substr(18,30);      
                form.value=form_temp.value;                     
                
                var ee = form_temp.value;
                var dig1 = ee.substr(2,4);
                var dig2 = ee.substr(6,4);
                var dig3 = ee.substr(10,4);
                var dig4 = ee.substr(14,4);
                form_card.value= dig1+"-"+dig2+"-"+dig3+"-"+dig4;                
                
                if (form_valid.value.length < 10)                
                {
                 // alert("disana");
                 form_valid.value="2012-01-01";
                 form_nama.value="<%= bean.getCustomerName() %>";  
                    var gg = form_temp.value;
                    var dig1 = gg.substr(0,4);
                    var dig2 = gg.substr(4,4);
                    var dig3 = gg.substr(8,4);
                    var dig4 = gg.substr(12,4);
                    form_card.value= dig1+"-"+dig2+"-"+dig3+"-"+dig4;    

                }    
                
           }    
                  
}


function valDate(obj){
        var dtCh= "-";
	var dtStr = obj.value
	var msg = "Invalid date!"
	
	var daysInMonth = DaysArray(12)
	
        var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
        
        /*
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
        */

        var strYear=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strDay=dtStr.substring(pos2+1)
        
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
        
	if (pos1==-1 || pos2==-1) {
		focusAndSelect(obj);
            alert(msg);
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		focusAndSelect(obj);
            alert(msg);
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		focusAndSelect(obj);
        alert(msg);
		return false
	}
	if (strYear.length != 4 || year==0){
		focusAndSelect(obj);
    alert(msg);
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		focusAndSelect(obj);
    alert(msg);
		return false
	}
        
	return true
}



function valDate(obj){
        var dtCh= "-";
	var dtStr = obj.value
	var msg = "Invalid date!"
	
	var daysInMonth = DaysArray(12)
	
        var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
        
        /*
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
        */

        var strYear=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strDay=dtStr.substring(pos2+1)
        
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
        
	if (pos1==-1 || pos2==-1) {
		focusAndSelect(obj);
            alert(msg);
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		focusAndSelect(obj);
            alert(msg);
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		focusAndSelect(obj);
        alert(msg);
		return false
	}
	if (strYear.length != 4 || year==0){
		focusAndSelect(obj);
    alert(msg);
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		focusAndSelect(obj);
    alert(msg);
		return false
	}
        
	return true
}

        </script>
        
        
        <script language="javascript">

	var selectedUnit = 0;
	var selectedFocUnit = 0;
        var selectedDiscUnit = 0;
	
	function doSubmit(thisform) {
		var vl;
		
                thisform.brand.value = document.getElementById("ibrand_1").value; 
                
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
                    <td> <std:text value="<%= bean.getBonusEarnerID() %>" /></td> 
                    <input type="hidden" name="isales" value="<%= bean.getBonusEarnerID() %>"/>
                    
                    
                </tr>
                <tr>
                    <td class="td1">Name :</td>
		<td><std:text value="<%= bean.getCustomerName() %>"/></td>
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
                    <td >&nbsp;</td>  
                    <td align="left" >Sales Return Ref.  <std:text value="<%= bean.getAdjstRefNo()%>"/>
                    <input type="hidden" name="InvoiceReturn" value="<%= bean.getAdjstRefNo()%>" />
                     </td>
                    <td></td>    
                    <td align="right"></td>                     
                    <td> <input type="hidden" name="irate" value="1" size="6"/> </td>  
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
                    <td align="right" nowrap><i18n:label code="PRODUCT_UNIT_PRICE"/> <br> (Rp)</td>
                    <td align="center" nowrap><i18n:label code="GENERAL_QTY"/></td>            
                    <td align="center" nowrap>Disc (Rp)</td>
                    <td align="center" nowrap>Disc (%)</td>
                    <td align="right" >Net Price<br>(<%= bean.getLocalCurrencySymbol() %>)</td>
                    <td align="center" nowrap>Sales ID</td>
                </tr>  
                
                <%            
                int ulang = 8;
                
                for(int i=1;i< ulang ; i++) {    
                %>
                
                <input type="hidden" name="ulangi" value="<%= ulang %>" /> 
                
                <tr>

                    <td >
                        <input type="text" name="icode_<%= i%>" id="icode_<%= i%>" value="" onKeyUp="showEmp(<%= i%>, '<%= Sys.getDateFormater().format(bean.getBonusDate()) %>', '<%= bean.getSellerID() %>', this.value);" size="10" maxlength="30"> 
                        <input type="hidden" id="code_<%= i%> " value="icode_<%= i%>" >                        
                    </td>
                    
                    <td >    
                        <input  type="text"  class="boxcontent" name="ibrand_<%= i%>" id="ibrand_<%= i%>" value="" disabled size="5" maxlength="5">
                        <input type="hidden" id="brand_<%= i%>" value="ibrand_<%= i%>" > 
                    </td>
                    
                    <td> 
                        <input  type="text"  class="boxcontent" name="iname_<%= i%>" id="iname_<%= i%>" value="" disabled size="25" maxlength="25">
                        <input type="hidden" id="name_<%= i%>" value="iname_<%= i%>" > 
                    </td>                    
                    <td > 
                        <input  type="text"  class="boxcontent" name="iserial_<%= i%>" id="iserial_<%= i%>" value="" disabled size="10" maxlength="10">
                        <input type="hidden" id="serial_<%= i%>" value="iserial_<%= i%>" > 
                    </td>                        
                    <td> 
                        <input  type="text"  class="boxcontent" name="iprice_<%= i%>" id="iprice_<%= i%>" value="" disabled size="10" maxlength="10">
                        <input type="hidden" id="price_<%= i%>" value="iprice_<%= i%>" > 
                    </td> 
                    
                    <td align=center>
                        <std:input type="text" name="<%= "Qty_" + i %>" status="<%= "style=text-align:right "  + ("onKeyUp='calcUnit("+ i + ", this)';") %>" size="4" maxlength="4"/>                        
                    </td>

                    <td align=center>
                        <std:input type="text" name="<%= "Foc_" + i %>" status="<%= "style=text-align:right " + ("onblur='calcUnitFoc("+ i + ", this)';") %>" size="10" maxlength="10"/>
                        
                    </td>                    
                    
                    <td> 
                        <std:input type="text" name="<%= "Disc_" + i %>" status="<%= "style=text-align:right " + ("onKeyUp='calcUnitFoc2("+ i + ", this)';") %>" size="10" maxlength="10"/>
                    </td>                                              
                    
                    <td >                        
                        <std:input type="text" name="<%= "Amt_" + i %>" status="<%= "style=text-align:right " + ("onKeyUp='calcUnitFoc3("+ i + ", this)';") %>" size="15" maxlength="15"/>
                        <LABEL ID="<%= "Amt_" + i %>"></LABEL>
                    </td>  
                    
                    <td align=center>                        
                        <input  type="text" name="isales_<%= i%>" id="isales_<%= i%>" value="" size="10" maxlength="10">
                    </td>                     
                </tr> 
                
                <%
                } // loop 3x
                %>                
                
                <input type="hidden" name="brand" />
                
            </table>
            
            <br>
            <table width="800">
                <tr align="right">
                    <td colspan="7" width="500">&nbsp;</td>
                    <td colspan="1" nowrap><b><i18n:label code="GENERAL_GROSS"/> :</b></td>
                    <td><LABEL ID="Total">0.00</LABEL></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="8">&nbsp;</td>
                </tr>
  
                <tr align=right>
                     <td colspan="7" width="500">&nbsp;</td>
                    <td colspan="1" nowrap><b>Deposit Amount :</b></td>                       
                    <td width="30" align="right"><%= bean.getCustomerRemark()%></td>   
                        <std:input type="hidden" name="DeliveryAmount" value="<%= bean.getCustomerRemark()%>"/>                   
                    <td></td>
                </tr>                

                <tr>
                    <td colspan="8">&nbsp;</td>

                        <std:input type="hidden" name="DiscountAmount" value="0"/>
                        <std:input type="hidden" name="DiscountRate" value="0"/>

                </tr>                
                
                <tr align=right>
                    <td colspan="8"><b>Net Price :</b></td>
                    <td><LABEL ID="Grandtotal"> <input type="text" id="Grandtotal" value="" disabled></LABEL></td>
                    <td></td>
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
                    <td width="20%">Amount </td>    
                    <td width="5%">Swipe</td>
                    <td width="30%">Reference No. </td>                    
                    <td width="10%">Expired Card <br> yyyy-mm-dd </td>
                    <td width="5%">Owner Name  </td>
                    
                </tr>                  
                
                <% 
                if (paymodeList != null) {
                    
                    int puter = 8;  
                    
                    for(int i=0; i<puter ; i++) {
                %>
                
                <input type="hidden" name="puteri" value="<%= puter %>" /> 
                
                <tr>		                   
                    <td class="td1">
                        <select name="paymode_<%=i%>" onfocus="seletPaymentMode(this, <%=i%>)">
                            
                            <%     
                            
                            for (int m = 0; m < paymodeList.length; m++) {
                                
                                OutletPaymentModeBean paymode = paymodeList[m];	
                            %>                            
                            
                            <option id="jenis_<%=i%>" value="<%= paymode.getPaymodeDesc()%>><%= paymode.getPaymodeCode()%>><%= paymode.getOutletEdc()%>><%= paymode.getOutletTime()%>><%= paymode.getGroup()%>" <%= m==0? "selected":"" %>><%= paymode.getPaymodeDesc() %> - <%= paymode.getOutletEdc()%> - <%= paymode.getOutletTime()%> </option>                            
                            
                            <% 	
                            } // end for
                            
                            %>                            
                            
                            
                        </select>
                        
                    </td>  
                    
                    <td align="right">
                        
                        <std:input type="text" name="<%= "amount_" + i %>"  status="onKeyUp=\"calcAmountPaid(this);\"" />   
                        
                    </td>            
                                        
                    
                    <td >
                        <input size="5" type="text" name="refNo_<%= i%>" id="scanVal<%= i%>" onkeyup="split_char(<%= i%>);"/>                        
                        <input type="hidden" name="tempVal<%= i%>" id="tempName<%= i%>" value=" "/>                 
                    </td>   
                    <td>
                        <input size="23" class="boxcontent" type="text" name="card_<%= i%>" id="valCard<%= i%>" value="" disabled />
                    </td>                     
                    <td align="center">
                        
                         <input size="10" type="text" name="expired_<%= i%>" id="valValid<%= i%>"  onblur="valDate(this);"  />                   
                    </td>                    
                    <td>
                        <input type="text" name="owner_<%= i%>" id="valName<%= i%>" value="" />
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
                    <td colspan="5">&nbsp;</td>
                </tr>
                
                
                <tr>
                    <td width="130" align="right"><b><i18n:label code="SALES_TOTAL_PAYMENT"/> :</b></td>
                    <td><LABEL ID="amountPaid">0.00</LABEL></td> 
                    <td class="td1" width="130"></td>
                    <td colspan="2"></td>
                </tr> 
                <tr>
                    <td width="130" align="right"><b><i18n:label code="SALES_BALANCE"/> :</b></td>
                    <td><LABEL ID="balance">0.00</LABEL></td>
                    <td class="td1" width="130"></td>
                    <td colspan="2"></td>
                </tr>    
                
                <tr>
                    <td width="130" align="right"><b><i18n:label code="SALES_CHANGE_DUE"/> :</b></td>
                    <td>
                        <LABEL ID="paymentChange">0.00</LABEL>         
                        <std:input type="hidden" name="paymentChangeObj"/> 
                    </td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="5">&nbsp;</td>
                </tr>
                <tr valign=top>
                    <td class="td1" width="130"><i18n:label code="GENERAL_REMARK"/>:</td>
                    <td colspan="4"><textarea name="Remark" cols="40" rows="5"></textarea></td>
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


