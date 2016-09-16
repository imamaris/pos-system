<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
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
         
         var iqty1 = eval("thisform.iqty_" + idx ).value;
         var iqty2 = eval("thisform.iqty_" + idx );        
         iqty2.value = iqty1 - unit;        
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

        var url="NoUseTW.jsp";       
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
//mila-020915
function validateSerialNo(i, lokasi){
    var sku_kode = $("#icode_" + i).val();
    var j  = 10;
    var k  = 20;

    j = j + i ;
    k = k + i ;

    if(sku_kode != null && sku_kode != ""){    
        $.post("validateSerialNoTw.jsp",{"lokasi" : lokasi, "sku_kode" : sku_kode}, function(data){
            //alert("data " + trim(data));
            if(trim(data) == "true"){
                //if(!alert("Data Artikel sudah digunakan, harap dicek outstanding TW")){ 
                alert("Article with serial No." + sku_kode + " already in used, kindly check outstanding TW");
                    $("#icode_" + i).val("");
                    $("#ibrand_" + i).val("");
                    $("#iname_" + i).val("");
                    $("#iserial_" + i).val("");
                    $("#iprice_" + i).val("");
                    $("#ipricerp_" + i).val("");
                    $("#iqty_" + i).val("");

                    $("#icode_" + j).val("");
                    $("#qty_" + j).val("");
                    $("#iqty_" + j).val("");
                    
                    $("#icode_" + k).val("");
                    $("#qty_" + k).val("");
                    $("#iqty_" + k).val("");
                //}
            }
        });    
    }
}
function stateChanged(i, tanggal, lokasi, kategori, text) 
{ 
        // alert(tanggal);
	document.getElementById("ibrand_"+i).value ="";
	document.getElementById("iname_"+i).value ="";
	document.getElementById("iserial_"+i).value ="";
	document.getElementById("iprice_"+i).value ="";	 
        document.getElementById("ipricerp_"+i).value= ""; //Updated By Ferdi 2015-06-19
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
        document.getElementById("ipricerp_"+i).value= ""; //Updated By Ferdi 2015-06-19
        document.getElementById("iqty_"+i).value ="";
        
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
        
    }else {
        //alert("Please Fill Product Code 1 ...");
        xmlHttpKit.close;
    }   
}

function stateChangedKit2(i, tanggal, lokasi, text) 
{ 
    // alert(tanggal); 
    var j  = 0;
    var k  = 0;
        
    if (i == 1 ){
        j = 11 ;
        k = 21 ;
    } else if (i == 2 ){
        j = 12 ;
        k = 22 ;
    } else if (i == 3 ){
        j = 13 ;
        k = 23 ;
    } else if (i == 4 ){
        j = 14 ;
        k = 24 ;
    } else if (i == 5 ){
        j = 15 ;
        k = 25 ;
    }  else if (i == 6 ){
        j = 16 ;
        k = 26 ;
    }  else if (i == 7 ){
        j = 17 ;
        k = 27 ;
    }  else if (i == 8 ){
        j = 18 ;
        k = 28 ;
    } else if (i == 9 ){
        j = 19 ;
        k = 29 ;
    } else{
        j = 20 ;
        k = 30 ;
    } 
           
    // document.getElementById("irefkit_"+j).value ="";
    // document.getElementById("inamekit_"+j).value ="";
    document.getElementById("icode_"+j).value ="";
    // document.getElementById("iname_"+j).value ="";	         
    document.getElementById("Qty_"+j).value ="";	
    document.getElementById("iqty_"+j).value ="";	
        
    // document.getElementById("irefkit_"+k).value ="";
    // document.getElementById("inamekit_"+k).value ="";
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
            // document.getElementById("inamekit_"+j).value ="";
            document.getElementById("icode_"+j).value ="";
            //document.getElementById("iname_"+j).value ="";	         
            document.getElementById("Qty_"+j).value ="";	
            document.getElementById("iqty_"+j).value ="";	
        
            // document.getElementById("irefkit_"+k).value ="";
            // document.getElementById("inamekit_"+k).value ="";
            document.getElementById("icode_"+k).value ="";
            //document.getElementById("iname_"+k).value ="";	         
            document.getElementById("Qty_"+k).value ="";     
            document.getElementById("iqty_"+k).value ="";	
        
	 }         
	 else if(strarkit.length>2)
	 {          
             //Updated By Mila 2016-04-13
            var min_j = 11;
            var min_k = 21;

            for(l=min_j;l<=j;l++)
            {
                var kitBox = $("#icode_" + l).val();

                if(kitBox == strarkit[3]) 
                {
                    var qtyBox = parseInt(document.getElementById("Qty_"+l).value) + 1;
                    document.getElementById("Qty_"+l).value = qtyBox;
                    break;
                }
                else if(l == j)
                {
                    document.getElementById("icode_"+j).value = strarkit[3];
                    //document.getElementById("iname_"+j).value = strarkit[4];
                    document.getElementById("Qty_"+j).value = "1"; 
                    document.getElementById("iqty_"+j).value = strarkit[5];
                }                
            }

            for(m=min_k;m<=k;m++)
            {
                var kitCard = $("#icode_" + m).val();
                
                if(kitCard == strarkit[9]) 
                {
                    var qtyCard = parseInt(document.getElementById("Qty_" + m).value) + 1;
                    document.getElementById("Qty_" + m).value = qtyCard;
                    break;
                }
                else if(m == k)
                {
                    document.getElementById("icode_"+k).value = strarkit[9];
                    //document.getElementById("iname_"+k).value = strarkit[10];
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
function trim(str){
    return str.replace(/^\s+|\s+$/g,'');
}
 </script>
  
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  String id = (String) returnBean.getReturnObject("ID");
  String cat = (String) returnBean.getReturnObject("Category");

  OutletBean outletFrom = (OutletBean) returnBean.getReturnObject("OutletFrom");
  OutletBean outletTo = (OutletBean) returnBean.getReturnObject("OutletTo");
  OutletStoreBean from = (OutletStoreBean) returnBean.getReturnObject("FromStore");
  TreeMap stores = (TreeMap) returnBean.getReturnObject("Stores");
  TreeMap storesTo = (TreeMap) returnBean.getReturnObject("StoresTo");
  
  // InventoryBean[] invenBeans  =  (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
%>

<body onLoad="self.focus();document.ops_inventory.icode_1.focus();sumTotalQuantity();">
    
<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead>Stock Transfer</div>

<form name="ops_inventory" action="<%=Sys.getControllerURL(InventoryManager.TASKID_STOCK_TRANSFER_EXTERNAL_TW, request)%>" method="post">
<std:input type="hidden" name="outletid" value="<%= outletFrom.getOutletID() %>"/>
<table width="70%">
	<tr>
		<td>Doc. Date</td>
		 <td width="30%">:  <fmt:formatDate  pattern="dd MMMM yyyy" type="both" value="<%= new Date()%>" /> </td>                 
		<td>&nbsp;</td>
		<td>Brand</td>
		<td>: <%= cat %> </td>
       </tr>
        
       <tr>
		<td><b>Boutique ID</b></td>
		<td>: <%= outletFrom.getOutletID() %> (<%= outletFrom.getName() %>)</td>
		<td>&nbsp;</td>
		<td><b>Boutique ID</b></td>
		<td>: <%= outletTo.getOutletID() %> (<%= outletTo.getName() %>)</td>
	</tr>
	<tr>
                <td><b><i18n:label code="GENERAL_FROM"/></b></td>
		<td>: 
        	<std:input type="select" name="id" options="<%=stores%>" status="onChange=searchInventory();"/> 
        	<b><%=from.getStoreID()%></b><input type=hidden name="_id" value="<%=from.getStoreID()%>">
        </td>
        <td>&nbsp;</td>
                <td><b><i18n:label code="GENERAL_TO"/></b></td>    
		<td>: 
        	<std:input type="select" name="storeTo" options="<%=storesTo%>"/>         	
        </td>
	</tr>
	
</table>
<br>
    
    <table width="70%" >
        <tr>
            <td>                                    
                
                <table class="listbox" width="450">
                
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
                        <td align="center" nowrap>Stock</td>
                    </tr>                                 
                    
                    <%            
                    String brand = "";
                    String price = "";
                    int ulang = 11;
                    
                    for(int i=1;i< ulang ; i++) {    
                    %>
                   
                    <input type="hidden" name="ulangi" value="<%= ulang %>" /> 
                    
                    <tr >                        
                        <td >
                            <input type="text" name="icode_<%= i%>" id="icode_<%= i%>" value="" onKeyUp="showEmp1(<%= i%>, '<%= Sys.getDateFormater().format(new Date()) %>', '<%= outletFrom.getOutletID() %>', '<%= cat %>', this.value);" onblur="showKit2(<%= i%>,  '<%= Sys.getDateFormater().format(new Date()) %>', '<%= outletFrom.getOutletID() %>', this.value);validateSerialNo(<%= i%>, '<%= outletFrom.getOutletID() %>');"  size="10" maxlength="50" >
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
                            <!-- Updated By Ferdi 2015-06-19 -->
                            <input type="text" class="boxcontent" name="ipricerp_<%= i%>" id="ipricerp_<%= i%>" value="" disabled size="15" maxlength="15" style="text-align:right">
                            <input type="hidden" name="iprice_<%= i%>" id="iprice_<%= i%>" >
                            <input type="hidden"  id="price_<%= i%>" value="iprice_<%= i%>" > 
                            <!-- End Updated -->
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
                                    <td >Reference <br> Number</td>
                                    <td align="center" >Qty</td> 
                                    <td align="center" >Stock</td> 
                                </tr> 
                                
                                
                                <%            
                                int ulangkit = 21;
                                
                                for(int j=11;j< ulangkit ; j++) {    
                                %>
                                
                                <tr>  
                                    <td > 
                                        <input  type="text" class="boxcontent" name="icode_<%= j%>" id="icode_<%= j%>" value="" size="12">                                        
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
                                    <td >Reference <br> Number</td>
                                    <td align="center" >Qty</td>  
                                    <td align="center" >Stock</td> 
                                </tr> 
                                
                                
                                <%            
                                int ulangkit2 = 31;
                                
                                for(int j=21;j< ulangkit2 ; j++) {    
                                %>
                                
                                <tr >                                      
                                    <td >  
                                        <input  type="text" class="boxcontent" name="icode_<%= j%>" id="icode_<%= j%>" value="" size="15">    
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
