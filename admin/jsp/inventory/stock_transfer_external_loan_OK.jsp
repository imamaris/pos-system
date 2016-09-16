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

	 if (unit > bal){
	    
	     alert("<i18n:label code="STOCK_NOT_ENOUGH"/>");
	     // eval("thisform.iqty_" + idx ).value = "";
	     // thisform.qty_[idx].focus();  
             return false;
	 }
	 
  }  
    sumTotalQuantity();  
    return true;
}

 function sumTotalQuantity(){
 
   var thisform = document.ops_inventory;
   var counter = 0;
 
       for(var i=1; i < 6; i++){
	  qty_i = eval("thisform.qty_" + i ).value;		             
          if(qty_i != 0)
              counter++;           
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
 
function showEmp1(i, tanggal, lokasi, kategori, sku_kode)
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
 
    var url="NoUseLoanOut.jsp";       
    url=url+"?sku_kode="+sku_kode+"&tanggal="+tanggal+"&lokasi="+lokasi+"&kategori="+kategori+"&echo=" + echo;
    echo = echo + 1;       

    
 xmlHttp.onreadystatechange=function() {
    if (xmlHttp.readyState==4) {
        // alert(tanggal);
      stateChanged(i, tanggal, lokasi, kategori, xmlHttp.responseText);      
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

function stateChanged(i, tanggal, lokasi, kategori, text) 
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
                
                // add field
                document.getElementById("iqty_"+i).value= strar[10];
                
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
        
        // alert(j);
        // alert(k);
        
	// document.getElementById("irefkit_"+j).value ="";
	document.getElementById("inamekit_"+j).value ="";
	document.getElementById("icode_"+j).value ="";
	document.getElementById("iname_"+j).value ="";	         
        document.getElementById("Qty_"+j).value ="";	
        document.getElementById("iqty_"+j).value ="";	
        
        // document.getElementById("irefkit_"+k).value ="";
	document.getElementById("inamekit_"+k).value ="";
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
	document.getElementById("inamekit_"+j).value ="";
	document.getElementById("icode_"+j).value ="";
	document.getElementById("iname_"+j).value ="";	         
        document.getElementById("Qty_"+j).value ="";	
        document.getElementById("iqty_"+j).value ="";	
        
	// document.getElementById("irefkit_"+k).value ="";
	document.getElementById("inamekit_"+k).value ="";
	document.getElementById("icode_"+k).value ="";
	document.getElementById("iname_"+k).value ="";	         
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
	document.getElementById("iname_"+j).value = strarkit[4];
        document.getElementById("Qty_"+j).value = "1"; 
        document.getElementById("iqty_"+j).value = strarkit[5]; 
        
        // document.getElementById("ikit_"+k).value= strarkit[12];        
	// document.getElementById("irefkit_"+k).value = strarkit[7];
	document.getElementById("inamekit_"+k).value = strarkit[7];
	document.getElementById("icode_"+k).value = strarkit[9];
	document.getElementById("iname_"+k).value = strarkit[10];
        document.getElementById("Qty_"+k).value = "1"; 
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

  for (int i = 1; i < 7; i++)
  {
    startCal.add(Calendar.DAY_OF_MONTH, 1);
  }
  
  String awal1 = Sys.getDateFormater().format(startCal.getTime());

  System.out.println("Nilai awal "+awal1);
  
%>

<body onLoad="self.focus();document.ops_inventory.icode_1.focus();sumTotalQuantity();">
    
<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead>Stock Loan</div>

<form name="ops_inventory" action="<%=Sys.getControllerURL(InventoryManager.TASKID_STOCK_TRANSFER_EXTERNAL_LOAN, request)%>" method="post">
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
                <td><b><i18n:label code="GENERAL_FROM"/></b></td>
		<td>: 
        	<std:input type="select" name="id" options="<%=stores%>" status="onChange=searchInventory();"/> 
        	<b><%=from.getStoreID()%></b><input type=hidden name="_id" value="<%=from.getStoreID()%>">
        </td>
        <td>&nbsp;</td>
                <td><b><i18n:label code="GENERAL_TO"/></b></td>    
		<td align="left">: 
                 <%= custName %> </td> 	
                
                <std:input type="hidden" name="custID" value="<%= custID %>" /> 
                <std:input type="hidden" name="custName" value="<%= custName %>" /> 
                
	</tr>
	
</table>
<br>
            
            <table class="listbox" width="550">
                
                
                <tr class="boxhead" valign="top" >
                    <td nowrap>Serial <br> Number</td>
                    <td nowrap>Brand</td>
                    <td >Reference <br> Description</td>
                    <td >Reference Number</td>
                    <td align="center" nowrap><i18n:label code="PRODUCT_UNIT_PRICE"/> <br>(SGD)</td>
                    <td align="center" nowrap><i18n:label code="GENERAL_QTY"/></td>            
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
                        <input type="text" name="icode_<%= i%>" id="icode_<%= i%>" value="" onKeyUp="showEmp1(<%= i%>, '<%= Sys.getDateFormater().format(new Date()) %>', '<%= outletFrom.getOutletID() %>', '<%= cat %>', this.value);" onblur="showKit2(<%= i%>,  '<%= Sys.getDateFormater().format(new Date()) %>', '<%= outletFrom.getOutletID() %>', this.value);"  size="10" maxlength="50" >                         
                        <input type="hidden" id="code_<%= i%> " value="icode_<%= i%>" >                        
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
                        <input type="text" class="boxcontent" name="iprice_<%= i%>" id="iprice_<%= i%>" value="" disabled size="10" maxlength="10">
                        <input type="hidden"  id="price_<%= i%>" value="iprice_<%= i%>" > 
                    </td> 
                    
                    <td align=right>
                        <input type=text name="qty_<%= i%>" maxlength=8 size=5 style="text-align:right" onKeyUp="validateQty( <%=i%>, this)">
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
                                <td nowrap >KIT Desc </td>
                                <td nowrap >Ref Number</td>
                                <td nowrap >Description</td>
                                <td align="center" >Qty</td> 
                                <td align="center" >Stock</td> 
                            </tr> 
                            
                            
                            <%            
                            int ulangkit = 11;
                            
                            for(int j=6;j< ulangkit ; j++) {    
                            %>
                            
                            <tr>  
                                
                                <td > 
                                    <input type="text" class="boxcontent" name="inamekit_<%= j%>" id="inamekit_<%= j%>" value="" size="10" disabled >
                                        <input type="hidden" name="namekit_<%= j%>"  id="namekit_<%= j%>" value="inamekit_<%= j%>" > 
                                </td>  
                                <td > 
                                    <input  type="text" class="boxcontent" name="icode_<%= j%>" id="icode_<%= j%>" value="" size="10">                                        
                                </td>
                                <td > 
                                    <input type="text" class="boxcontent" name="iname_<%= j%>" id="iname_<%= j%>" value="" disabled >
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
                        <table class="listbox"  width="300">
                            
                            <tr class="boxhead" valign="top" >
                                <td nowrap >KIT Desc </td>
                                <td nowrap >Ref Number</td>
                                <td nowrap >Description</td>
                                <td align="center" >Qty</td>  
                                <td align="center" >Stock</td> 
                            </tr> 
                            
                            
                            <%            
                            int ulangkit2 = 16;
                            
                            for(int j=11;j< ulangkit2 ; j++) {    
                            %>
                            
                            <tr >  
                                
                                <td > 
                                    <input type="text" class="boxcontent" name="inamekit_<%= j%>" id="inamekit_<%= j%>" value="" size="10" disabled >
                                        <input type="hidden" name="namekit_<%= j%>"  id="namekit_<%= j%>" value="inamekit_<%= j%>" > 
                                </td>  
                                <td >  
                                    <input  type="text" class="boxcontent" name="icode_<%= j%>" id="icode_<%= j%>" value="" size="10">    
                                </td>
                                <td > 
                                    <input type="text" class="boxcontent" name="iname_<%= j%>" id="iname_<%= j%>" value="" disabled >
                                        <input type="hidden" name="name_<%= j%>"  id="name_<%= j%>" value="iname_<%= j%>" > 
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

</p>
<table width="70%">
  	<tr valign=top>
     <td align=left>
     <b><i18n:label code="GENERAL_REMARK"/> :</b>
      </td>
  	</tr>
  	<tr valign=top>
     <td align=left>
      <textarea name="Remark" rows="5" cols="50"></textarea>
      </td>
  	</tr>
  	<tr valign=top>
     <td align=right>
      <input type=submit name=btnSubmit value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">      	
      </td>
  	</tr>
</table>
  	
</form>
</body>
</html>
