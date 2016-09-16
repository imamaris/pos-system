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

String segmen = "";
if(bean.getServiceAgentType().length() > 1)
    //segmen = "Previllage Type : ".concat(" ").concat(bean.getServiceAgentType());
    segmen = bean.getServiceAgentType().concat(" - Customer");
    
String editURL = Sys.getControllerURL(MemberManager.TASKID_BASIC_EDIT_MEMBER, request);

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
        <%@ include file="/lib/counterhe.jsp"%>                
        <%@ include file="/lib/shoppingCart.jsp"%>
        
        
        <script type="text/javascript">    
            var echo  = 0;
            var echo2 = 0;
 
function calcGrandTotal2() {
	var thisform = document.frmSalesOrder;
	selectedUnit = 0;
	selectedFocUnit = 0;
	total = 0;
	bv = 0;
        discount = 0;
	paid = 0;
        
        rate = eval("thisform.irate").value;
        ulang2 = eval("thisform.ulangi").value;
               
	for (var i=1; i < 6; i++) {
		qty = eval("thisform.Qty_" + i ).value;
		price = eval("thisform.iprice_" + i ).value;
                foc = eval("thisform.Foc_" + i ).value;
                
		total += (price * rate * qty) - foc;
		// bv += ProductList[i].bv * qty;
		selectedUnit += qty * 1;
				
		if (eval("thisform.Foc_" + i) != null) {
			focQty = eval("thisform.Foc_" + i).value;
			selectedFocUnit += focQty * 1;
		}
	}

			
	Total.innerText = total == 0 ? "0.00" : formatAmount(total);  //decFormat(total);
	
	try{
		// Set Stockist Commission
		setPercentage(thisform,total);
	}catch(err){
	}
	
	if (total == 0 && selectedFocUnit == 0){
		disableSubmitBtn(true);
	} else {
		disableSubmitBtn(false);
	}
	
	if (thisform.Discount != null) {
		discount = total * (thisform.Discount.value / 100);
		DiscountAmt.innerText = discount == 0 ? "0.00" : decFormat(discount);
	}
	
	if (thisform.DiscountAmount != null) 
		total -= (replacePriceValue(thisform.DiscountAmount.value) * 1);
                
        //alert(total);
						
	if (thisform.AdminAmount != null)
		total += (thisform.AdminAmount.value * 1);

	/*
        if (thisform.DeliveryAmount != null)
		total += (thisform.DeliveryAmount.value * 1);
	*/
        // revisi tuk Deposit amount
	if (thisform.DeliveryAmount != null)
		total += (thisform.DeliveryAmount.value * -1);
                
	if (thisform.AmountReceived != null)
		thisform.TotalAdjustPayment.value = decFormat(thisform.AmountReceived.value - total);				
		
	if (thisform.TotalPaymentAdjust != null)
		total += (thisform.TotalPaymentAdjust.value * 1);
		
	orderPayment = total == 0 ? total : (total - discount);
	Grandtotal.innerText = orderPayment == 0 ? '0.00' : formatAmount(orderPayment); //decFormat(orderPayment);

}            
            
function cekNomor(j)
{ 

var x =  document.getElementById("Qty_"+j).value;

var list = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
var status = true;
for (i=0; i<=x.length-1; i++)
{
if (x[i] in list) cek = true;
else cek = false;
status = status && cek;
}

if (status == false)
{
alert("Please Fill Number ...");
document.getElementById("Qty_"+j).focus(); 
}
else
{
return true;
}

}


function showEmp(i, tanggal, lokasi, sku_kode)
{ 
// var echo = 0;
if(document.getElementById("icode_"+i).value!="-1")
{
    xmlHttp=GetXmlHttpObject();

    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return
        
    }
    var waktu = "<%= bean.getTrxTime() %>";  
    // alert("waktu : "+waktu);
    
    var url="NoUseHe.jsp";       
    // update echo
    url=url+"?sku_kode="+sku_kode+"&tanggal="+tanggal+"&lokasi="+lokasi+"&waktu="+waktu+"&echo="+echo;
    echo = echo + 1;       

    
 xmlHttp.onreadystatechange=function() {
    if (xmlHttp.readyState==4) {
        // alert(tanggal);
      stateChanged(i, tanggal, lokasi, waktu, xmlHttp.responseText);      
    }
  };
  
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
else
{
   // alert("Please Fill Product Code 1 ...");
   xmlHttp.close;
}

}

function stateChanged(i, tanggal, lokasi, waktu, text) 
{ 
    // alert(tanggal);
    document.getElementById("ibrand_"+i).value ="";
    document.getElementById("iname_"+i).value ="";
    document.getElementById("iserial_"+i).value ="";
    document.getElementById("iprice_"+i).value ="";	 
    document.getElementById("ipricerp_"+i).value= ""; //Updated By Ferdi 2015-06-18
    document.getElementById("iqty_"+i).value ="";
    document.getElementById("irate_"+i).value ="";
    document.getElementById("irateCcy_"+i).value ="";
    
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    { 
	
        var showdata = xmlHttp.responseText; 
        // alert(showdata);
        var strar = showdata.split("~");
	
        if(strar.length==1)
        {
         
            document.getElementById("icode_"+i).focus(); 
            document.getElementById("ibrand_"+i).value ="";
            document.getElementById("iname_"+i).value ="";
            document.getElementById("iserial_"+i).value ="";
            document.getElementById("iprice_"+i).value ="";
            document.getElementById("ipricerp_"+i).value= ""; //Updated By Ferdi 2015-06-18
            document.getElementById("iqty_"+i).value ="";
            document.getElementById("irate_"+i).value= "";
            document.getElementById("irateCcy_"+i).value= "";
        
	} else if(strar.length>1) {
             //nety
            var strname = strar[1];
            var ulangi = parseInt(document.getElementById("ulangi").value);
            var itemFormQty = 0;
            var itemStock = 0;
            var numEmptyQty = 0;
                
            for(j=1;j<ulangi;j++)
            {
                itemNumber = document.getElementById("icode_"+j).value;

                //validate if Qty is empty
                if(document.getElementById("Qty_"+j).value == "")numEmptyQty+=1;

                if((itemNumber == document.getElementById("icode_"+i).value) && (itemNumber != "") && (numEmptyQty != 1))
                {
                    itemFormQty += parseInt(document.getElementById("Qty_"+j).value);

                    //Upated By Ferdi 2014-10-10
                    document.getElementById("icode_"+i).value = "";

                    if(isNaN(itemFormQty))
                    {
                        alert("Please Input Qty");
                    }
                    else
                    {
                        alert("Duplicate Entry Serial Number");
                        return;
                    }
                    //End Updated
                }
            }
                
            if(itemFormQty <= strar[10])
            {
                itemStock = strar[10] - itemFormQty;

            var strname = strar[1];    
            document.getElementById("iname_"+i).value= strar[3];
            document.getElementById("ibrand_"+i).value= strar[4];
            document.getElementById("iprice_"+i).value= strar[5];
            document.getElementById("ipricerp_"+i).value= strar[13]; //Updated By Ferdi 2015-06-18
            document.getElementById("iserial_"+i).value= strar[6];
            document.getElementById("icode_"+i).value= strar[12];
            document.getElementById("irate_"+i).value= strar[14];
            document.getElementById("irateCcy_"+i).value= strar[15];

            // nety
            document.getElementById("iqty_"+i).value= itemStock;
            // document.getElementById("stock_"+i).value= strar[10];

            }
        }
    }
}


function stateChangedOld(i, tanggal, lokasi, text) 
{ 
    // alert(tanggal);
    document.getElementById("ibrand_"+i).value ="";
    document.getElementById("iname_"+i).value ="";
    document.getElementById("iserial_"+i).value ="";
    document.getElementById("iprice_"+i).value ="";	 

    document.getElementById("iqty_"+i).value ="";	

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    { 

        var showdata = xmlHttp.responseText; 
        // alert(showdata);
        var strar = showdata.split("~");

        if(strar.length==1)
        {

            document.getElementById("icode_"+i).focus(); 

            document.getElementById("ibrand_"+i).value ="";
            document.getElementById("iname_"+i).value ="";
            document.getElementById("iserial_"+i).value ="";
            document.getElementById("iprice_"+i).value ="";	

            document.getElementById("iqty_"+i).value ="";

        }
        else if(strar.length>1)
        {
            var strname = strar[1];

            document.getElementById("iname_"+i).value= strar[3];
            document.getElementById("ibrand_"+i).value= strar[4];
            document.getElementById("iprice_"+i).value= strar[5];  
            document.getElementById("iserial_"+i).value= strar[6];
            document.getElementById("icode_"+i).value= strar[12];
            document.getElementById("irate_"+i).value= strar[14];
            document.getElementById("irateCcy_"+i).value= strar[15];

            // add field
            document.getElementById("iqty_"+i).value= strar[10];

        }
    }
}

function showVoucher(tanggal, i, sku_kode)
{ 

if(document.getElementById("refNo_"+i).value!="-1")
{
    xmlHttp=GetXmlHttpObject();

    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return        
    }
 
    var url="VoucherHe.jsp";   
    url=url+"?sku_kode="+sku_kode+"&tanggal="+tanggal+ "&echo=" + echo;
    echo2 = echo2 + 1;       

    
    xmlHttp.onreadystatechange=function() {
        if (xmlHttp.readyState==4) {
            // alert(sku_kode);
            stateChangedVoucher(tanggal, i, xmlHttp.responseText);      
        }
    };
  
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
else
{
   // alert("Please Fill Product Code 1 ...");
   xmlHttp.close;
}

}

function stateChangedVoucher(tanggal, i, text) 
{ 
        document.getElementById("amount_"+i).value ="";	
        document.getElementById("amount2_"+i).value ="";	
        document.getElementById("expired_"+i).value ="";	
        document.getElementById("owner_"+i).value ="";	
        // document.getElementById("card_"+i).value ="";	
        
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  var showdata = xmlHttp.responseText; 
  var strar = showdata.split("~");
  // alert(text);
  
	 if(strar.length==1)
	 {         
                document.getElementById("refNo_"+i).focus(); 
                // document.getElementById("card_"+i).value ="";	
                document.getElementById("amount_"+i).value ="";	
                document.getElementById("amount2_"+i).value ="";	
                document.getElementById("expired_"+i).value ="";	
                document.getElementById("owner_"+i).value ="";	
                // alert ("a");
	 }
	 else if(strar.length>1)
	 {
            var strname = strar[1];
            document.getElementById("amount_"+i).value= Number(strar[9]);  
            document.getElementById("amount2_"+i).value= Number(strar[9]);  
            document.getElementById("expired_"+i).value= strar[6];  
            document.getElementById("owner_"+i).value= strar[3];  
            // document.getElementById("card_"+i).value= strar[11];  
            document.getElementById("refNo_"+i).value= strar[11];  
            
             // alert ("b");
     }
	
 }
}

function showKit2(i, tanggal, lokasi, sku_kode)
{ 

if(document.getElementById("icode_"+i).value!="-1")

{
    xmlHttpKit=GetXmlHttpObjectKit();

    if (xmlHttpKit==null)
    {
        alert ("Browser does not support HTTP Request");
        return
    }
 
    var url="kit2.jsp";   
    url=url+"?sku_kode="+sku_kode+"&tanggal="+tanggal+"&lokasi="+lokasi + "&echo=" + echo;
    echo = echo + 1;       

    
 xmlHttpKit.onreadystatechange=function() {
    if (xmlHttpKit.readyState==4) {
        // alert(tanggal);
      stateChangedKit2(i, tanggal, lokasi, xmlHttpKit.responseText);      
    }
  };
  
    xmlHttpKit.open("GET",url,true);
    xmlHttpKit.send(null);
}
else
{
   // alert("Please Fill Product Code 1 ...");
   xmlHttpKit.close;
}

}

function stateChangedKit2(i, tanggal, lokasi, text) 
{ 
        // alert(tanggal); 
        var j  = 0;
        var k  = 0;
        
        // alert(i);
         
        if (i == 1 )
        {
          j = 6 ;
          k = 11 ;
        } else if (i == 2 )
        {
          j = 7 ;
          k = 12 ;
        } else if (i == 3 )
        {
          j = 8 ;
          k = 13 ;
        } else if (i == 4 )
        {
          j = 9 ;
          k = 14 ;
        }  else 
        {
          j = 10 ;
          k = 15 ;
        } 
        
        // alert(j);
        // alert(k);
        
	// document.getElementById("irefkit_"+j).value ="";
	// document.getElementById("inamekit_"+j).value ="";
	document.getElementById("icode_"+j).value ="";
	document.getElementById("iname_"+j).value ="";	         
        document.getElementById("Qty_"+j).value ="";	
        document.getElementById("iqty_"+j).value ="";	
        
        // document.getElementById("irefkit_"+k).value ="";
	// document.getElementById("inamekit_"+k).value ="";
	document.getElementById("icode_"+k).value ="";
	document.getElementById("iname_"+k).value ="";	         
        document.getElementById("Qty_"+k).value ="";        
        document.getElementById("iqty_"+k).value ="";	        
        
if (xmlHttpKit.readyState==4 || xmlHttpKit.readyState=="complete")
 { 
	
  var showdatakit = xmlHttpKit.responseText; 
  // alert(showdatakit);

  // var showdata = xmlHttpKit.responseText; 
  // alert(showdata);
  
  var strarkit = showdatakit.split("~");
  // var check = strarkit.length;	
  // alert(check);
  
	 if(strarkit.length==2)
	 {
         
	// document.getElementById("irefkit_"+j).value ="";
	// document.getElementById("inamekit_"+j).value ="";
	document.getElementById("icode_"+j).value ="";
	document.getElementById("iname_"+j).value ="";	         
        document.getElementById("Qty_"+j).value ="";	
        document.getElementById("iqty_"+j).value ="";	
        
	// document.getElementById("irefkit_"+k).value ="";
	// document.getElementById("inamekit_"+k).value ="";
	document.getElementById("icode_"+k).value ="";
	document.getElementById("iname_"+k).value ="";	         
        document.getElementById("Qty_"+k).value ="";     
        document.getElementById("iqty_"+k).value ="";	
        
	 }
         
	 else if(strarkit.length>2)
	 {
            //Updated By Ferdi 2015-06-24
            var min_j = 6;
            var min_k = 11;

            for(l=min_j;l<=j;l++)
            {
                var kitBox = $("#icode_" + l).val();

                if(kitBox == strarkit[3]) 
                {
                    var qtyBox = parseInt($("#Qty_" + l).val()) + 1;
                    
                    $("#Qty_" + l).val(qtyBox);
                    break;
                }
                else if(l == j)
                {
                    document.getElementById("icode_"+j).value = strarkit[3];
                    document.getElementById("iname_"+j).value = strarkit[4];
                    document.getElementById("Qty_"+j).value = "1"; 
                    document.getElementById("iqty_"+j).value = strarkit[5];
                }
            }

            for(m=min_k;m<=k;m++)
            {
                var kitCard = $("#icode_" + m).val();
                
                if(kitCard == strarkit[9]) 
                {
                    var qtyCard = parseInt($("#Qty_" + m).val()) + 1;
                    
                    $("#Qty_" + m).val(qtyCard);
                    break;
                }
                else if(m == k)
                {
                    document.getElementById("icode_"+k).value = strarkit[9];
                    document.getElementById("iname_"+k).value = strarkit[10];
                    document.getElementById("Qty_"+k).value = "1"; 
                    document.getElementById("iqty_"+k).value = strarkit[11];
                }
            }
            //End Updated
        
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

function GetXmlHttpObjectKit()
{
var xmlHttpKit=null;
try
 {
 // Firefox, Opera 8.0+, Safari
 xmlHttpKit=new XMLHttpRequest();
 }
catch (e)
 {
 //Internet Explorer
 try
  {
  xmlHttpKit=new ActiveXObject("Msxml2.XMLHTTP");
  }
 catch (e)
  {
  xmlHttpKit=new ActiveXObject("Microsoft.XMLHTTP");
  }
 }
return xmlHttpKit;
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
       
       document.getElementById("expired_"+i).value = ""; 
       document.getElementById("owner_"+i).value = ""; 
       
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
                 form_valid.value="2013-12-31";
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


        </script>
        
        <script language="javascript">

	var selectedUnit = 0;
	var selectedFocUnit = 0;
        var selectedDiscUnit = 0;
	
	function doSubmit(thisform) {
		var vl;
		
                thisform.brand.value = document.getElementById("ibrand_1").value; 
	        thisform.diskonvoucher.value = thisform.DiscountAmount.value;
			
		$("[name=btnSubmit]").hide(); //Updated by Ferdi 2015-07-02
                        
		// Qty Order
		if (selectedUnit == 0 && selectedFocUnit == 0 && selectedDiscUnit == 0 ) {
			alert("No Sales Order Info");
			$("[name=btnSubmit]").show(); //Updated by Ferdi 2015-07-02
			return;
		 }

		// Amount
		var amtPaid = replacePriceValue(amountPaid.innerText);
		amtPaid = amtPaid * 1;
		
		var grdTotal = replacePriceValue(Grandtotal.innerText);
		grdTotal = grdTotal * 1;

		var payChange = replacePriceValue(paymentChange.innerText);
		payChange = payChange * 1;      
                
		var cekQty = document.getElementById("Qty_1").value; 
		cekQty = cekQty * 1;                                

	var thisform = document.frmSalesOrder;
	jumqty_i = 0;
        jumqty_j = 0;
        jumqty_k = 0;	       
	jumqty_jk = 0;
         
	// chek jumlah qty di master & kit
	for (var i=1; i < 6; i++) {
		qty_i = eval("thisform.Qty_" + i ).value;		      
		jumqty_i += qty_i * 1;
		
        var j  = 0;
        var k  = 0;
          
        if (i == 1 )
        {
          j = 6 ;
          k = 7 ;
        } else if (i == 2 )
        {
          j = 8 ;
          k = 9 ;
        } else if (i == 3 )
        {
          j = 10 ;
          k = 11 ;
        } else if (i == 4 )
        {
          j = 12 ;
          k = 13 ;
        }  else 
        {
          j = 14 ;
          k = 15 ;
        } 
        
		qty_j = 0;
		qty_k = 0;
		qty_jk = 0;
                
                
		qty_j = eval("thisform.Qty_" + j).value;	
		qty_k = eval("thisform.Qty_" + k).value;	
		
		jumqty_j += (qty_j * 1);	
                jumqty_k += (qty_k * 1);	
                jumqty_jk += (qty_j * 1) + (qty_k * 1);	
                             
		
	}                
	
	if(jumqty_jk < (2*jumqty_i) )
	 {
	   thisform.status.value = "0";
	   // alert();
	 } else 
	 {
	   thisform.status.value = "1";
	 }                
               /* sementara diremark
               if(jumqty_k < jumqty_i ) {
                                alert("<i18n:label code="Quantity of Guarante Card is smaller than Quantity of Item Product  "/>");
								$("[name=btnSubmit]").show(); //Updated by Ferdi 2015-07-02
				return;
		}          
               */
                
               if(jumqty_jk > (2*jumqty_i) ) {
                                alert("<i18n:label code="Quantity of Kit Item is greater than Quantity of Item Product  "/>");
								$("[name=btnSubmit]").show(); //Updated by Ferdi 2015-07-02
				return;
		}     

         
         // akhir kit
         
		if (grdTotal > 0) {
			if (amtPaid < grdTotal) {
				alert("<i18n:label code="MSG_PAYMENT_NOT_ENOUGH"/>");
				$("[name=btnSubmit]").show(); //Updated by Ferdi 2015-07-02
				return;
			}
		}	else {
			if (amtPaid > 0) {
				alert("<i18n:label code="MSG_NO_PAYMENT"/> " + grdTotal);
				$("[name=btnSubmit]").show(); //Updated by Ferdi 2015-07-02
				return;
			}
		}
                
               if (payChange > 0) {
				alert("<i18n:label code="MSG_PAYMENT_NOT_ENOUGH"/>");
				$("[name=btnSubmit]").show(); //Updated by Ferdi 2015-07-02
				return;
		}     
                
               if (payChange < 0) {
				alert("<i18n:label code="MSG_PAYMENT_NOT_ENOUGH"/>");
				$("[name=btnSubmit]").show(); //Updated by Ferdi 2015-07-02
				return;
		}                  

               if (cekQty == 0) {
				alert("Quantity Issue is not Null");
				$("[name=btnSubmit]").show(); //Updated by Ferdi 2015-07-02
				return;
		}                 
                
                
		if (confirm('<i18n:label code="MSG_CONFIRM"/>')) {                        
			thisform.action = "<%=Sys.getControllerURL(taskID,request)%>";
			thisform.submit();
		}
                else
                {
                    $("[name=btnSubmit]").show(); //Updated by Ferdi 2015-08-12
                }
		 
	} // end validateForm
	
  //-->
        </script>
        
        
    </head>
    
    <body onLoad="self.focus();">
        
        <div class="functionhead">Sales Entry </div>
        
        <%@ include file="/lib/return_error_msg.jsp"%>
        
        <form name="frmSalesOrder" action="" method="post">
            
            <table class="tbldata" border="0" width="900">
                
                <% if(bean.getServiceAgentType().length() > 1) { %>                
                <tr valign=top>
                    <td align="center" colspan="8"><font color="blue" size="3" ><b> <%= segmen %> </b> </font></td> <td align="right" colspan="2"><font color="blue" >
                            
                                <img border="0" alt='Edit Customer' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/> Product List Discount
                            
                    </font></td>
                </tr>
                <tr><td colspan="10" height="10"></td> </tr>
                <% } %>  
                
                <tr>
                    <td class="td1" width="100">Boutique :</td>
                    <td width="150"><%= bean.getSellerID() %>   
                    <std:input type="hidden" name="ibutik" value="<%= bean.getSellerID() %>"/></td> 
                    
                    <td>&nbsp;</td>
                    <td colspan="2"><std:text value="<%= loginUser.getUserName().toUpperCase()%>"/></td>  
                    <td>&nbsp;</td>
                    <td class="td1" width="75">Sales ID :</td>
                    <td><%= bean.getBonusEarnerID() %>
                    <std:input type="hidden" name="isales" value="<%= bean.getBonusEarnerID() %>"/></td>  
                    
                    <td align="right"><!-- SGD - IDR : --></td> <!-- Updated By Ferdi 2015-06-17 -->
                    <td><!-- <%= bean.getBaseCurrencyRate()%> --></td> <!-- Updated By Ferdi 2015-06-17 -->
                    
                </tr>
                
                <tr>
                    <td class="td1">Name :</td>
                    <td><std:text value="<%= bean.getCustomerName() %>"/></td> 
                    <td>&nbsp;</td>
                    <td colspan="2" ><std:text value="<%= bean.getCustomerContact()%>"/></td>
                    <td >&nbsp;</td>      
                    <td class="td1" >Nama :</td>                    
                    <td ><%= bean.getBonusEarnerName() %></td> 
                    
                    <td align="right"><!-- USD - IDR : --></td> <!-- Updated By Ferdi 2015-06-17 -->
                    <td><!-- <%= bean.getBaseCurrencyRate2()%> --></td> <!-- Updated By Ferdi 2015-06-17 -->  
                    <input type="hidden" name="irate2" value="<%= bean.getBaseCurrencyRate2()%>" />    
                    
                </tr>
                
                <tr>
                    <td class="td1" width="100">Trx Date :</td>
                    <td ><fmt:formatDate pattern="dd MMMM yyyy 'at' hh:mm:ss" type="both" value="<%= bean.getTrxDate() %>" /></td>
                    <td>&nbsp;</td>                     
                    <td align="left" class="td1" colspan="2"></td>                                        
                    
                    <td >&nbsp;</td>      
                    <td class="td1" >Doc. Date :</td>                     
                    <td ><fmt:formatDate pattern="dd MMMM yyyy" type="both" value="<%= bean.getBonusDate() %>" /></td> 
                    <input type="hidden" name="tanggal" value="<%= Sys.getDateFormater().format(bean.getBonusDate()) %>" />                                     
                    <td align="right"></td>                     
                    <td></td>                    
                    
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
            
            <table class="listbox" width="800">
                
                
                <tr class="boxhead" valign="top" >
                    <td nowrap>Serial <br> Number</td>
                    <td nowrap>Brand</td>
                    <td >Reference <br> Description</td>
                    <td >Reference Number</td>
                    <td align="center" nowrap>Unit Price (IDR)</td> <!-- Updated By Ferdi 2015-06-17 -->
                    <td align="center" nowrap><i18n:label code="GENERAL_QTY"/></td>            
                    <td align="center" nowrap>Disc (Rp)</td>
                    <td align="center" nowrap>Disc (%)</td>
                    <td align="center" >Net Price</td> <!-- Updated By Ferdi 2015-06-17 -->
                    <td align="center" nowrap>Sales ID</td>
                    <td align="center" nowrap>Stock</td>
                </tr>                                 
                
                <%            
                String brand = "";
                String price = "";
                int ulang = 6;
                
                for(int i=1;i< ulang ; i++) {    
                %>
                
                <input type="hidden" name="ulangi" value="<%= ulang %>" /> 
                
                <tr >
                    
                    <td >
                        <input type="text" name="icode_<%= i%>" id="icode_<%= i%>" value="" onKeyUp="showEmp(<%= i%>, '<%= Sys.getDateFormater().format(bean.getBonusDate()) %>', '<%= bean.getSellerID() %>', this.value);" onblur="showKit2(<%= i%>, '<%= Sys.getDateFormater().format(bean.getBonusDate()) %>', '<%= bean.getSellerID() %>', this.value);"  size="10" maxlength="50" > 
                        <input type="hidden" id="code_<%= i%>" value="icode_<%= i%>" > 
                        <input type="hidden" name="irate_<%= i%>" id="irate_<%= i%>" />
                        <input type="hidden" name="irateCcy_<%= i%>" id="irateCcy_<%= i%>" />
                    </td>
                    
                    <td >    
                        <input type="text" class="boxcontent" name="ibrand_<%= i%>" id="ibrand_<%= i%>" size="5" value="" disabled >
                            <input type="hidden" name="ibrand_<%= i%>"  id="brand_<%= i%>" value="ibrand_<%= i%>" >                         
                    </td>
                    
                    <td > 
                        <input type="text" class="boxcontent" name="iname_<%= i%>" id="iname_<%= i%>" value="" disabled >
                            <input type="hidden" id="name_<%= i%>" value="iname_<%= i%>" > 
                    </td>                    
                    <td > 
                        <input  type="text" class="boxcontent" name="iserial_<%= i%>" id="iserial_<%= i%>" value="" disabled size="10" maxlength="30">
                        <input type="hidden" name="iserial_<%= i%>" id="iserial_<%= i%>" value="iserial_<%= i%>" > 
                    </td>                        
                    <td>
                        <!-- Updated By Ferdi 2015-06-18 -->
                        <input type="text" class="boxcontent" name="ipricerp_<%= i%>" id="ipricerp_<%= i%>" value="" disabled size="15" maxlength="15" style="text-align:right">
                        <input type="hidden" name="iprice_<%= i%>" id="iprice_<%= i%>">
                        <!-- End Updated -->
                        <input type="hidden"  id="price_<%= i%>" value="iprice_<%= i%>" > 
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
                    
                    <td align=center>                        
                        <input align="center"  type="text" name="iqty_<%= i%>" id="iqty_<%= i%>" value="" size="3" maxlength="3" disabled >
                        </td>
                    
                </tr> 
                
                <%
                } // loop i
                %>    
                
            </table>           
            
            <table width="800">
                
                <tr>
                    <td colspan="12" height="20" align="left"><b>KIT Detail </b></td> 
                </tr>
                
                <tr>
                    
                    <td valign="top">    
                        <table class="listbox"  width="300">
                            
                            <tr class="boxhead" valign="top" >                                
                                <td nowrap >Ref Number</td>
                                <td nowrap >Description </td>
                                <td align="center" >Qty</td> 
                                <td align="center" >Stock</td> 
                            </tr> 
                            
                            
                            <%            
                            int ulangkit = 11;
                            
                            for(int j=6;j< ulangkit ; j++) {    
                            %>
                            
                            <tr>  
                                
                                <td > 
                                    <input  type="text" class="boxcontent" name="icode_<%= j%>" id="icode_<%= j%>" value="" size="12">                                        
                                </td>
                                <td > 
                                    <input type="text" class="boxcontent" name="iname_<%= j%>" id="iname_<%= j%>" value="" disabled >
                                    </td>                                            
                                
                                <td width="2" align="center"> 
                                    <input type="text" align="center" class="boxcontent" name="Qty_<%= j%>" id="Qty_<%= j%>" value=""  size="2" >                                    
                                </td>                                                             
                                
                                <td width="2" align="center"> 
                                    <input type="text" align="center" class="boxcontent" name="iqty_<%= j%>" id="iqty_<%= j%>" value="" size="2" disabled >                                    
                                    </td> 
                                
                                <input type="hidden" name="ibrand_<%= j%>"  value="" >   
                                <input type="hidden" name="iserial_<%= j%>"  value="" >  
                                <input type="hidden" name="iprice_<%= j%>"  value="0" >
                                <input type="hidden" name="ipricerp_<%= j%>"  value="0" > <!-- Updated By Ferdi 2015-06-18 -->
                                <input type="hidden" name="Foc_<%= j%>"  value="0" >  
                                <input type="hidden" name="Disc_<%= j%>"  value="0" >  
                                <input type="hidden" name="Amt_<%= j%>"  value="0" >  
                                <input type="hidden" name="isales_<%= j%>"  value="<%= bean.getBonusEarnerID() %>" >                                                                
                                
                            </tr> 
                            
                            <%
                            } // loop j
                            %>            
                            
                            <input type="hidden" name="ulangi_kit" value="<%= ulangkit %>" /> 
                            
                        </table>
                    </td>
                    
                    
                    <td valign="top">    
                        <table class="listbox"  width="300">
                            
                            <tr class="boxhead" valign="top" >
                                <td nowrap >Ref Number</td>
                                <td nowrap >Description </td>
                                <td align="center" >Qty</td>  
                                <td align="center" >Stock</td> 
                            </tr> 
                            
                            
                            <%            
                            int ulangkit2 = 16;
                            
                            for(int j=11;j< ulangkit2 ; j++) {    
                            %>
                            
                            <tr >  
                                
                                <td >  
                                    <input  type="text" class="boxcontent" name="icode_<%= j%>" id="icode_<%= j%>" value="" size="15">    
                                </td>
                                <td > 
                                    <input type="text" class="boxcontent" name="iname_<%= j%>" id="iname_<%= j%>" value="" disabled >
                                    </td>                                            
                                
                                <td width="2" align="center"> 
                                    <input type="text" align="center" class="boxcontent" name="Qty_<%= j%>" id="Qty_<%= j%>" value=""  size="2" >                                    
                                </td> 
                                
                                <td width="2" align="center"> 
                                    <input type="text" align="center" class="boxcontent" name="iqty_<%= j%>" id="iqty_<%= j%>" value="" size="2" disabled >                                    
                                </td> 
                                
                                <input type="hidden" name="ibrand_<%= j%>"  value="" >   
                                <input type="hidden" name="iserial_<%= j%>"  value="" >  
                                <input type="hidden" name="iprice_<%= j%>"  value="0" >  
                                <input type="hidden" name="ipricerp_<%= j%>"  value="0" > <!-- Updated By Ferdi 2015-06-18 -->
                                <input type="hidden" name="Foc_<%= j%>"  value="0" >  
                                <input type="hidden" name="Disc_<%= j%>"  value="0" >  
                                <input type="hidden" name="Amt_<%= j%>"  value="0" >  
                                <input type="hidden" name="isales_<%= j%>"  value="<%= bean.getBonusEarnerID() %>" >  
                                
                            </tr> 
                            
                            <%
                            } // loop j
                            %>            
                            
                            <input type="hidden" name="ulangi_kit2" value="<%= ulangkit2 %>" /> 
                            <input type="hidden" name="status"  /> 
                            
                        </table>
                    </td>
                    
                    
                    <td valign="top">    
                        
                        
                        <table width="200">    
                            
                            <tr align="right">
                                <td align="right" nowrap><b><i18n:label code="GENERAL_GROSS"/> :</b></td>
                                <td align="right" nowrap><LABEL ID="Total">0.00</LABEL></td>
                            </tr>
                            <tr align="right">
                                <td align="right" nowrap><b>Discount :</b></td>
                                <td align="right" nowrap>0.00</td>
                            </tr>                            
                            <!--
                            change per 15 Nov 2013
                            <tr align=right>
                                <td align="right" nowrap ><b>Voucher Number :</b></td>
                                <td align="right" nowrap> 
                                    <input type="text" name="icode_" id="icode_" value="" onKeyUp="showVoucher('<%= Sys.getDateFormater().format(bean.getBonusDate()) %>', this.value);" onblur="calcGrandTotal2()" size="10" maxlength="50" > 
                                    <input type="hidden" id="code_" name="icode_" value="icode_" >                                             
                                </td>
                            </tr>
                                                        
                            <tr align=right>
                                <td align="right" nowrap ><b>Voucher Value :</b></td>
                                <td align="right" nowrap> 
                                    <input type="text" class="boxcontent" name="DiscountAmount" id="iprice_" value="" disabled  size="10" maxlength="10">
                                    <input type="hidden" id="price_" value="iprice_" >
                                    <input type="hidden" name="diskonvoucher" >
                                </td>
                            </tr>       
                            -->        
                            
                            <std:input type="hidden" name="icode_" value=""/>
                            <std:input type="hidden" name="diskonvoucher" value="0"/>
                            <std:input type="hidden" name="DiscountAmount" value="0"/>
                            <std:input type="hidden" name="DiscountRate" value="0"/>
                            
                            <tr align="right" >
                                <td align="right" nowrap ><b>Net Price :</b></td>
                                <td align="right" nowrap><LABEL ID="Grandtotal"> 
                                <!--    
                                <input type="text" id="Grandtotal" value="" disabled>
                                -->
                            </LABEL></td>
                            </tr>
                            
                        </table>
                        
                        
                    </td>        
                    
                </tr>
            </table>    
            
            <input type="hidden" name="brand" />
            
            <br>
            
            <hr>                
            <br>  
            <u>Payment Information </u>
            <br>
            <br>
            
            <table width="80%" border="0">   

                <tr align="center" valign="top">                    
                    <td width="30%">Payment Type By Voucher </td>
                    <!-- <td width="5%">Currency</td> --> <!-- Updated By Ferdi 2015-06-17 -->
                    <td width="20%">Voucher No. </td>  
                    <td width="20%">Amount (IDR)</td> 
                    <td colspan="2" >Remark </td>                         
                    <td width="10%">Expired <br> yyyy-mm-dd </td>
                    <td width="5%"> </td>                    
                </tr>                  
                
                <% 
                if (paymodeList != null) {
                                
                                for(int i=0; i < 1 ; i++) {                                    
                %>                                
                <tr>		                   
                    <td class="td1">
                        <select name="paymode_<%=i%>" >
                            
                            <%     
                            
                            for (int m = 0; m < paymodeList.length; m++) {
                                
                                OutletPaymentModeBean paymode = paymodeList[m];	
                            
                                if(paymode.getPaymodeDesc().equalsIgnoreCase("VOUCHER"))
                                  {  
                            %>                            
                            
                            <option id="jenis_<%=i%>" value="<%= paymode.getPaymodeDesc()%>><%= paymode.getPaymodeCode()%>><%= paymode.getOutletEdc()%>><%= paymode.getOutletTime()%>><%= paymode.getGroup()%>" <%= m==0? "selected":"" %>><%= paymode.getPaymodeDesc() %> - <%= paymode.getOutletEdc()%> - <%= paymode.getOutletTime()%> </option>                            
                            
                            <% 	
                                 }  // end if                            
                            } // end for
                            
                            %>                            
                            
                            
                        </select>                                                
                    </td>  
                    
                    <!-- Updated By Ferdi 2015-06-17 -->
                    <input type="hidden" name="currency_<%=i%>" value="IDR>1"/>
                    <!-- <td class="td1">
                        <select name="currency_<%=i%>" onchange="seletCurrencyMode(this, <%=i%>)" >
                            <option id="curr_<%=i%>" value="IDR>1" selected >IDR</option>          
                        </select>                        
                    </td> -->
                    <!-- End Updated -->
                    
                    <td align="left">
                        <input  type="text" name="refNo_<%= i%>" id="refNo_<%= i%>" value="" onKeyUp="showVoucher('<%= Sys.getDateFormater().format(bean.getBonusDate()) %>', <%= i%>, this.value);" onblur="calcGrandTotal2()" > 
                    </td> 
                    <td align="right" >                        
                        <input type="text" name="amount_<%= i%>" id="amount_<%= i%>" value="" readonly />     
                    </td>                         
                    <input type="hidden" name="amount2_<%= i%>" id="amount2_<%= i%>" value=""/>
                    <td colspan="2">
                        <input size="32" type="text" name="owner_<%= i%>" id="owner_<%= i%>" value="" readonly />                    
                    </td>                      
                    <td align="center">
                        <input size="10"  type="text" name="expired_<%= i%>" id="expired_<%= i%>" value="" readonly />                    
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
                
                <tr align="center" valign="top">                    
                    <td width="30%">Payment Type </td>
                    <!-- <td width="5%">Currency</td> --> <!-- Updated By Ferdi 2015-06-17 -->
                    <td width="20%">Amount</td> 
                    <td width="20%">Amount (IDR)</td>                       
                    <td width="5%">Swipe</td>
                    <td width="30%">Reference No. </td>                    
                    <td width="10%">Expired Card <br> yyyy-mm-dd </td>
                    <td width="5%">Owner Name  </td>                    
                </tr>                  
                
                <% 
                if (paymodeList != null) {
                                int puter = 16;
                                
                                for(int i=1; i<puter ; i++) {
                %>
                
                <input type="hidden" name="puteri" value="<%= puter %>" /> 
                
                <tr>		                   
                    <td class="td1">
                        
                        <select name="paymode_<%=i%>" onfocus="seletPaymentMode(this, <%=i%>)">
                            
                            <%     
                            
                            for (int m = 0; m < paymodeList.length; m++) {
                                
                                OutletPaymentModeBean paymode = paymodeList[m];	
                            
                                if(!paymode.getPaymodeDesc().equalsIgnoreCase("VOUCHER"))
                                  {  
                            %>                            
                            
                            <option id="jenis_<%=i%>" value="<%= paymode.getPaymodeDesc()%>><%= paymode.getPaymodeCode()%>><%= paymode.getOutletEdc()%>><%= paymode.getOutletTime()%>><%= paymode.getGroup()%>" <%= m==0? "selected":"" %>><%= paymode.getPaymodeDesc() %> - <%= paymode.getOutletEdc()%> - <%= paymode.getOutletTime()%> </option>                            
                            
                            <% 	
                                 }  // end if                            
                            } // end for
                            
                            %>                            
                            
                            
                        </select>
                        
                    </td>  
                    
                    <!-- Updated By Ferdi 2015-06-17 -->
                    <input type="hidden" name="currency_<%=i%>" value="IDR>1"/>
                    <!-- <td class="td1">
                       <select name="currency_<%=i%>" onchange="seletCurrencyMode(this, <%=i%>)" >
                            <option id="curr_<%=i%>" value="IDR>1" selected >IDR</option>          
                            <option id="curr_<%=i%>" value="USD><%= bean.getBaseCurrencyRate2()%>" >USD</option>
                            <option id="curr_<%=i%>" value="SGD><%= bean.getBaseCurrencyRate()%>" >SGD</option>    
                            
                        </select>
                        
                    </td> --> 
                    <!-- End Updated -->
                    <td align="right">
                        
                        <input type="text" name="<%= "amount_" + i %>"  onKeyUp="calcAmountPaid(this, <%= i%>)" />   
                        
                    </td>            
                    <td align="right">
                        <input type="text" name="amount2_<%= i%>" id="amount2_<%= i%>" value="" disabled />     
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
            } //end canView
            %>
            
        </form>
        
    </body>
    <script>
        //Updated By Ferdi 2015-06-04
        var row = parseInt($("[name=ulangi]").val());
        for(var i = 1;i < row;i++)
        {
            document.getElementById("ibrand_"+i).value ="";
            document.getElementById("iname_"+i).value ="";
            document.getElementById("iserial_"+i).value ="";
            document.getElementById("iprice_"+i).value ="";
            document.getElementById("ipricerp_"+i).value =""; //Updated By Ferdi 2015-06-18
            document.getElementById("iqty_"+i).value ="";	
            document.getElementById("Qty_"+i).value ="";
            document.getElementById("Foc_"+i).value ="";
            document.getElementById("Disc_"+i).value ="";
            document.getElementById("Amt_"+i).value ="";
            document.getElementById("isales_"+i).value ="";
        }
        //End Updated
    </script>
</html>


