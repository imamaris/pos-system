<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@page import="com.ecosmosis.orca.member.MemberBean"%>
<%@page import="com.ecosmosis.orca.outlet.store.OutletStoreBean"%>
<html>
<head>
    <%@ include file="/lib/header.jsp"%>
    <%@ include file="/lib/counterhe.jsp"%>                
    <%@ include file="/lib/shoppingCart.jsp"%>
    
    <script language="Javascript">

function isInteger(val){
      if(val==null){return false;}
      if (val.length==0){return false;}
      for (var i = 0; i < val.length; i++) {
            var ch = val.charAt(i)
            if (i == 0 && ch == "-") {
            continue
            }
      if (ch < "0" || ch > "9") {
            return false
      }
}
return true
}
//updated by Mila 22-11-15
function validateLoanIn(i, lokasi, target){
    var sku_kode = $("#icode_" + i).val();
    if(sku_kode != null){    
        if(sku_kode != null && sku_kode != ""){    
            $.post("validateLoanIn.jsp",{"lokasi" : lokasi, "sku_kode" : sku_kode, "target" : target}, function(data){
                //alert("data " + trim(data));
                var dataspl = trim(data).split("|");            
                if(dataspl[0] == "false"){
                    //alert("masuk sini");
                    if(dataspl[1] > 0){
                        $("#istatus_" + i).val("false");
                        //$("#iqty_" + i).val(dataspl[1]);
                        $("#idocsklo_" + i).val(dataspl[2]);
                    }else{                    
                        //$("#iqty_" + i).val(0);
                        $("#idocsklo_" + i).val(null);
                        $("#istatus_" + i).val("false");                   
                    }
                }else{
                    if(dataspl[1] > 0){
                        $("#istatus_" + i).val("true");
                        //$("#iqty_" + i).val(dataspl[1]);
                        $("#idocsklo_" + i).val(dataspl[2]);
                    }
                }
            });    
        }
     }   
}

function validateQty(idx, qty) {

  var thisform = document.ops_inventory;  
  // var unit = qty_[idx].value;
  unit = eval("thisform.qty_" + idx ).value;
  
  if (unit.length > 0){ 
     
     if (isNaN(unit) || unit<=0) {
	     alert("<i18n:label code="MSG_QTY_POSITIVE_INTEGER"/>");
	     // thisform.qty_[idx].value = "";
	     // thisform.qty_[idx].focus();     
             return false;
	 }

	 var bal = 0 ;
	 if(eval("thisform.iqty_" + idx ).value != null){	 
            bal = eval("thisform.iqty_" + idx ).value;
         }else{
            bal = eval("thisform.iqty_" + idx ).value;
	 }
	
	 //To convert strings to numbers	 
	 unit = unit - 0;
	 bal = bal - 0;
         
         if (unit > bal && document.getElementById("istatus_"+idx).value == "false"){	
             alert("Loan Out is not Available!");
             document.getElementById("icode_"+idx).value ="";             
             document.getElementById("ibrand_"+idx).value ="";
             document.getElementById("iname_"+idx).value ="";
             document.getElementById("iserial_"+idx).value ="";
             document.getElementById("iprice_"+idx).value ="";	
             document.getElementById("ipricerp_"+idx).value= "";
             document.getElementById("Qty_" + idx ).value = "";
             document.getElementById("iqty_" + idx ).value = "";
             document.getElementById("icode_"+idx).focus();             
             
             var idy = idx + 20;
             var idz = idx + 40;
             
             document.getElementById("icode_"+idy).value="";              
             document.getElementById("inamekit_"+idy).value ="";
             document.getElementById("Qty_"+idy).value ="";
             document.getElementById("iqty_"+idy).value ="";
             
             document.getElementById("icode_"+idz).value="";             
             document.getElementById("inamekit_"+idz).value="";
              document.getElementById("Qty_"+idz).value ="";
             document.getElementById("iqty_"+idz).value ="";
             
             return;
         } 
    }  
    sumTotalQuantity();  
    return true;
}

 function sumTotalQuantity(){
 
   var thisform = document.ops_inventory;
   var counter = 0;
   var status = false;
 
       for(var i=1; i < 21; i++){
	  qty_i = eval("thisform.qty_" + i ).value;		             
          if(qty_i != 0)
              counter++;     
              
          if(eval("thisform.istatus_" + i).value == "false"){
            offButton(true);
          }else{
            offButton(false);
          }
       }
       
    
    if(counter > 0)
       offButton(false);
    else
       offButton(true);      
 }
 
 
 
 function offButton(isFag){

     var thisform = document.ops_inventory;
     thisform.btnSubmit.disabled = isFag;
 }
 
 function searchInventory(){

  var myform = document.ops_inventory;
  
  if(confirm('<i18n:label code="MSG_CONFIRM"/>'))  {
     myform.action = '<%=Sys.getControllerURL(InventoryManager.TASKID_STOCK_PRE_TRANSFER_EXTERNAL, request)%>%>';
     myform.submit();
  }else{
     myform.id.value = myform._id.value;
  }
 }
            var echo  = 0;
            var echo2 = 0;
 
function showEmp1(i, tanggal, lokasi, kategori, customer, sku_kode, target)
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
 
    var url="NoUseLoan.jsp";       
    url=url+"?sku_kode="+sku_kode+"&tanggal="+tanggal+"&lokasi="+lokasi+"&kategori="+kategori+"&customer="+customer+"&echo=" + echo;
    echo = echo + 1;       
        
    validateLoanIn(i, lokasi, customer);
    
    
 xmlHttp.onreadystatechange=function() {
    if (xmlHttp.readyState==4) {
        // alert(tanggal);
      stateChanged(i, tanggal, lokasi, kategori, customer, xmlHttp.responseText);      
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

function stateChanged(i, tanggal, lokasi, kategori, customer, text) 
{ 
        // alert(tanggal);
	document.getElementById("ibrand_"+i).value ="";
	document.getElementById("iname_"+i).value ="";
	document.getElementById("iserial_"+i).value ="";
	document.getElementById("iprice_"+i).value ="";	 
        document.getElementById("ipricerp_"+i).value= ""; //Updated By Ferdi 2015-06-19
        document.getElementById("iqty_"+i).value ="";	
        document.getElementById("idocsklo_"+i).value ="";	
        
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
        document.getElementById("ipricerp_"+i).value= ""; //Updated By Ferdi 2015-06-19
        document.getElementById("iqty_"+i).value ="";
        //document.getElementById("idocsklo_"+i).value ="";
        
	 }
	 else if(strar.length>1)
	 {
		var strname = strar[1];
		
                //Updated By Milaa
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
                    }                    
                }
                
                //End updated
                if(itemFormQty <= strar[10])
                {
                    itemStock = strar[10] - itemFormQty;

                    var strname = strar[1]; 
                    document.getElementById("iname_"+i).value= strar[3];
                    document.getElementById("ibrand_"+i).value= strar[4];
                    document.getElementById("iprice_"+i).value= strar[5];
                    document.getElementById("ipricerp_"+i).value= strar[13]; //Updated By Ferdi 2015-06-19
                    document.getElementById("iserial_"+i).value= strar[6];
                    document.getElementById("icode_"+i).value= strar[12];

                    // add field
                    document.getElementById("iqty_"+i).value= strar[10];
               }
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
        // var i  = 0;
        var j  = 0;
        var k  = 0;
        
        if (i == 1 )
        {
          j = 21 ;
          k = 41 ;
        } else if (i == 2 )
        {
          j = 22 ;
          k = 42 ;
        } else if (i == 3 )
        {
          j = 23 ;
          k = 43 ;
        } else if (i == 4 )
        {
          j = 24 ;
          k = 44 ;
        } else if (i == 5 )
        {
          j = 25 ;
          k = 45 ;
        }  else if (i == 6 )
        {
          j = 26 ;
          k = 46 ;
        }  else if (i == 7 )
        {
          j = 27 ;
          k = 47 ;
        }  else if (i == 8 )
        {
          j = 28 ;
          k = 48 ;
        } else if (i == 9 )
        {
          j = 29 ;
          k = 49 ;
        } else if (i == 10 )
        {
          j = 30 ;
          k = 50 ;
        } else if (i == 11 )
        {
          j = 31 ;
          k = 51 ;
        } else if (i == 12 )
        {
          j = 32 ;
          k = 52 ;
        } else if (i == 13 )
        {
          j = 33 ;
          k = 53 ;        
        } else if (i == 14 )
        {
          j = 34 ;
          k = 54 ;
        } else if (i == 15 )
        {
          j = 35 ;
          k = 55 ;
        } else if (i == 16 )
        {
          j = 36 ;
          k = 56 ;
        } else if (i == 17 )
        {
          j = 37 ;
          k = 57 ;
        } else if (i == 18 )
        {
          j = 38 ;
          k = 58 ;
        } else if (i == 19 )
        {
          j = 39 ;
          k = 59 ;
        } 
        
        else 
        {
          j = 40 ;
          k = 60 ;
        }        
        
        // alert(j);
        // alert(k);
        
	// document.getElementById("irefkit_"+j).value ="";
	document.getElementById("inamekit_"+j).value ="";
	document.getElementById("icode_"+j).value ="";
	// document.getElementById("iname_"+j).value ="";	         
        document.getElementById("Qty_"+j).value ="";	
        document.getElementById("iqty_"+j).value ="";	
        
        // document.getElementById("irefkit_"+k).value ="";
	document.getElementById("inamekit_"+k).value ="";
	document.getElementById("icode_"+k).value ="";
	// document.getElementById("iname_"+k).value ="";	         
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
	document.getElementById("inamekit_"+j).value ="";
	document.getElementById("icode_"+j).value ="";
	// document.getElementById("iname_"+j).value ="";	         
        document.getElementById("Qty_"+j).value ="";	
        document.getElementById("iqty_"+j).value ="";	
        
	// document.getElementById("irefkit_"+k).value ="";
	document.getElementById("inamekit_"+k).value ="";
	document.getElementById("icode_"+k).value ="";
	// document.getElementById("iname_"+k).value ="";	         
        document.getElementById("Qty_"+k).value ="";     
        document.getElementById("iqty_"+k).value ="";	
        
	 }
         
	 else if(strarkit.length>2)
	 {
		var strname = strarkit[1];
        
        // document.getElementById("ikit_"+j).value= strarkit[6];        
	// document.getElementById("irefkit_"+j).value = strarkit[1];
	document.getElementById("inamekit_"+j).value = strarkit[1];
	document.getElementById("icode_"+j).value = strarkit[3];
	// document.getElementById("iname_"+j).value = strarkit[4];
        document.getElementById("Qty_"+j).value = "0"; 
        document.getElementById("iqty_"+j).value = strarkit[5]; 
        
        // document.getElementById("ikit_"+k).value= strarkit[12];        
	// document.getElementById("irefkit_"+k).value = strarkit[7];
	document.getElementById("inamekit_"+k).value = strarkit[7];
	document.getElementById("icode_"+k).value = strarkit[9];
	// document.getElementById("iname_"+k).value = strarkit[10];
        document.getElementById("Qty_"+k).value = "0"; 
        document.getElementById("iqty_"+k).value = strarkit[11];         
        
        
                                
        // alert ("b");
        
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
function trim(str){
    return str.replace(/^\s+|\s+$/g,'');
}
function doSubmit(thisform) {
    $("[name=btnSubmit]").hide(); //Updated by Ferdi 2015-07-02

    if (confirm('<i18n:label code="MSG_CONFIRM"/>')) {
            thisform.action = "<%=Sys.getControllerURL(InventoryManager.TASKID_STOCK_TRANSFER_EXTERNAL_LOAN_IN,request)%>";
            thisform.submit();
    }
    else{
        $("[name=btnSubmit]").show(); 
    }		 
} 
</script>
    
</head>
<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
String id = (String) returnBean.getReturnObject("ID");
String cat = (String) returnBean.getReturnObject("Category");
String custID = (String) returnBean.getReturnObject("CustomerID");
String custName = (String) returnBean.getReturnObject("CustomerName");
// String reminderDate = (String) returnBean.getReturnObject("ReminderDate");
// String reminderDate = "2012-11-15";

OutletBean outletFrom = (OutletBean) returnBean.getReturnObject("OutletFrom");
OutletStoreBean from = (OutletStoreBean) returnBean.getReturnObject("FromStore");
TreeMap stores = (TreeMap) returnBean.getReturnObject("Stores");

Calendar startCal = Calendar.getInstance();
startCal.setTime(new Date());

for (int i = 1; i < 7; i++) {
    startCal.add(Calendar.DAY_OF_MONTH, 1);
}

String awal1 = Sys.getDateFormater().format(startCal.getTime());

System.out.println("Nilai awal "+awal1);

%>

<body onLoad="self.focus();document.ops_inventory.icode_1.focus();sumTotalQuantity();">

<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead>Stock Loan IN</div>

<form name="ops_inventory" action="<%=Sys.getControllerURL(InventoryManager.TASKID_STOCK_TRANSFER_EXTERNAL_LOAN_IN, request)%>" method="post">
    <std:input type="hidden" name="outletid" value="<%= outletFrom.getOutletID() %>"/>
    <table width="70%">
        <tr>
        <td>Doc. Date</td>
        <td width="30%">:  <fmt:formatDate  pattern="dd MMMM yyyy" type="both" value="<%= new Date()%>" /> </td>                 
        <td>&nbsp;</td>
        <td>Reminder Date</td>
        <td width="30%">:  <fmt:formatDate  pattern="dd MMMM yyyy" type="both" value="<%= startCal.getTime()%>" /> </td>       
        
        <tr>
            <td><b>Boutique ID</b></td>
            <td>: <%= outletFrom.getOutletID() %> (<%= outletFrom.getName() %>)</td>
            <td>&nbsp;</td>
            <td><b>Customer ID</b></td>
            <td>: <%= custID %> </td>
        </tr>
        <tr>
            <td><b><i18n:label code="GENERAL_TO"/></b></td>
            <td>: 
                <std:input type="select" name="id" options="<%=stores%>" status="onChange=searchInventory();"/> 
                <b><%=from.getStoreID()%></b><input type=hidden name="_id" value="<%=from.getStoreID()%>">
            </td>
            <td>&nbsp;</td>
            <td><b><i18n:label code="GENERAL_FROM"/></b></td>    
            <td align="left">: 
            <%= custName %> </td> 	
            
            <std:input type="hidden" name="custID" value="<%= custID %>" /> 
            <std:input type="hidden" name="custName" value="<%= custName %>" /> 
            
        </tr>
        
    </table>
    <br>
    
    
    <table width="100%" >
        <tr>
            <td>                                    
                
                <table class="listbox" width="550">
                    
                    <tr>
                        <td colspan="8" height="20" align="left"><b>Item Product </b></td> 
                    </tr>                    
                    
                    <tr class="boxhead" valign="top" >
                        <td nowrap>Serial <br> Number</td>
                        <td nowrap>Brand</td>
                        <td >Reference <br> Description</td>
                        <td >Reference Number</td>
                        <td align="center" nowrap><i18n:label code="PRODUCT_UNIT_PRICE"/> <br>(IDR)</td> <!-- Updated By Ferdi 2015-06-19 -->
                        <td align="center" nowrap><i18n:label code="GENERAL_QTY"/></td>            
                        <td nowrap><i18n:label code="GENERAL_QTY"/><br> Loan</td>
                    </tr>                                 
                    
                    <%            
                    String brand = "";
                    String price = "";
                    // + 10
                    int ulang = 21;
                    
                    for(int i=1;i< ulang ; i++) {    
                    %>
                    
                    <input type="hidden" name="ulangi" value="<%= ulang %>" /> 
                    
                    <tr >                        
                        <td >
                            <input type="text" name="icode_<%= i%>" id="icode_<%= i%>" value="" onKeyUp="showEmp1(<%= i%>, '<%= Sys.getDateFormater().format(new Date()) %>', '<%= outletFrom.getOutletID() %>', '<%= cat %>', '<%= custID %>', this.value);" onblur="showKit2(<%= i%>,  '<%= Sys.getDateFormater().format(new Date()) %>', '<%= outletFrom.getOutletID() %>', this.value);"  size="10" maxlength="50" >                         
                            <input type="hidden" id="code_<%= i%>" value="icode_<%= i%>" >                                                                               
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
                            <!-- Updated By Ferdi 2015-06-19 -->
                            <input type="text" class="boxcontent" name="ipricerp_<%= i%>" id="ipricerp_<%= i%>" value="" disabled size="15" maxlength="15" style="text-align:right">
                            <input type="hidden" name="iprice_<%= i%>" id="iprice_<%= i%>" >
                            <input type="hidden"  id="price_<%= i%>" value="iprice_<%= i%>" > 
                            <!-- End Updated -->
                        </td> 
                        
                        <td align=right>
                            <input type=text name="qty_<%= i%>" maxlength=8 size=5 style="text-align:right" onKeyUp="validateQty( <%=i%>, this);">
                        </td>                    
                        <td align=center>                        
                            <input align="center"  type="text" name="iqty_<%= i%>" id="iqty_<%= i%>" value="" size="3" maxlength="3" disabled >
                            <input type="hidden" name="idocsklo_<%= i%>" id="idocsklo_<%= i%>"><input type="hidden" name="istatus_<%= i%>" id="istatus_<%= i%>">
                        </td>                        
                    </tr> 
                    
                    <%
                    } // loop i
                    %>    
                    
                </table>
                
            </td>
            <td>
                <table>
                    
                    <tr>
                        <td colspan="12" height="20" align="left"><b>KIT Detail </b></td> 
                    </tr>
                    
                    <tr>
                        
                        <td valign="top">    
                            <table class="listbox" >
                                
                                <tr class="boxhead" valign="top" >
                                    <td nowrap >KIT Desc </td>
                                    <td >Reference <br> Number</td>
                                    <td align="center" >Qty</td> 
                                    <td align="center" >Stock</td> 
                                </tr> 
                                
                                
                                <%   
                                // + 20
                                int ulangkit = 41;
                                // + 10
                                // for(int j=11;j< ulangkit ; j++) {    
                                for(int j=21;j< ulangkit ; j++) {    
                                %>
                                
                                <tr>  
                                    
                                    <td > 
                                        <input type="text" class="boxcontent" name="inamekit_<%= j%>" id="inamekit_<%= j%>" value="" size="10" disabled >
                                            <input type="hidden" name="namekit_<%= j%>"  id="namekit_<%= j%>" value="inamekit_<%= j%>" > 
                                    </td>  
                                    <td > 
                                        <input  type="text" class="boxcontent" name="icode_<%= j%>" id="icode_<%= j%>" value="" size="10">                                        
                                    </td>
                                    <td width="2" align="center"> 
                                        <input type="text" align="center" class="boxcontent" name="qty_<%= j%>" id="qty_<%= j%>" value=""  size="2"  >                                    
                                    </td>                                                             
                                    
                                    <td width="2" align="center"> 
                                        <input type="text" align="center" class="boxcontent" name="iqty_<%= j%>" id="iqty_<%= j%>" value="" size="2" disabled >
                                        </td>                                                                                              
                                    
                                </tr> 
                                
                                <%
                                } // loop j
                                %>            
                                
                                <input type="hidden" name="ulangi_kit" value="<%= ulangkit %>" /> 
                                
                            </table>
                        </td>
                        
                        
                        <td valign="top">    
                            <table class="listbox" >
                                
                                <tr class="boxhead" valign="top" >
                                    <td nowrap >KIT Desc </td>
                                    <td >Reference <br> Number</td>
                                    <td align="center" >Qty</td>  
                                    <td align="center" >Stock</td> 
                                </tr> 
                                
                                
                                <%   
                                // + 20
                                int ulangkit2 = 61;
                                // for(int j=21;j< ulangkit2 ; j++) {     
                                // + 10
                                for(int j=41;j< ulangkit2 ; j++) {    
                                %>
                                
                                <tr >  
                                    
                                    <td > 
                                        <input type="text" class="boxcontent" name="inamekit_<%= j%>" id="inamekit_<%= j%>" value="" size="10" disabled >
                                            <input type="hidden" name="namekit_<%= j%>"  id="namekit_<%= j%>" value="inamekit_<%= j%>" > 
                                    </td>  
                                    <td >  
                                        <input  type="text" class="boxcontent" name="icode_<%= j%>" id="icode_<%= j%>" value="" size="10">    
                                    </td>
                                    <td width="2" align="center"> 
                                        <input type="text" align="center" class="boxcontent" name="qty_<%= j%>" id="qty_<%= j%>" value=""  size="2"  >                                    
                                    </td> 
                                    
                                    <td width="2" align="center"> 
                                        <input type="text" align="center" class="boxcontent" name="iqty_<%= j%>" id="iqty_<%= j%>" value="" size="2" disabled >                                    
                                        </td>                                 
                                    
                                </tr> 
                                
                                <%
                                } // loop j
                                %>            
                                
                                <input type="hidden" name="ulangi_kit2" value="<%= ulangkit2 %>" /> 
                                <input type="hidden" name="status"  /> 
                                
                            </table>
                        </td>
                        
                        
                        <td valign="top">                                                    
                            
                            
                        </td>        
                        
                    </tr>
                </table>    
                
            </td>
        </tr>    
    </table>
    
    </p>
    <table width="50%">
        <tr valign=top>
            <td align=left>
                <b><i18n:label code="GENERAL_REMARK"/> :</b>
            </td>
        </tr>
        <tr valign=top>
            <td align=left>
                <textarea name="Remark" rows="5" cols="50"></textarea>
            </td>
            <td></td>
             <td align=right>
                <!--<input type=submit name=btnSubmit value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">   -->
                <input type="button" name="btnSubmit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form)">
            </td>
        </tr>
    </table>
    
</form>
</body>
</html>
