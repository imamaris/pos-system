<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bvwallet.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

String custSegmentation = (String) returnBean.getReturnObject("CustomerSegmentation");
String custCRM = (String) returnBean.getReturnObject("CustomerCRM");
String custValid = (String) returnBean.getReturnObject("CustomerValid");
String custPin = (String) returnBean.getReturnObject("CustomerPin");
String custName = (String) returnBean.getReturnObject("CustomerName");

Map staffMap = (Map) returnBean.getReturnObject(BvWalletManager.RETURN_STAFFLIST_CODE);
String StaffName = request.getParameter("StaffName");

%>


<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<html>
    <head>
        <script LANGUAGE="JavaScript">
var echo = 0;

function confirmSubmit()
{
	var agree=confirm("Confirm ?");
	if (agree)
		return true ;
	else
		return false ;
}

 
function showMenu(val) {
		if (val == 'N') {
			document.getElementById('menuN').style.display = 'block';
			document.getElementById('menuC').style.display = 'none';
		} 
		
		if (val == 'C') {
			document.getElementById('menuC').style.display = 'block';
			document.getElementById('menuN').style.display = 'none';
		}
}

function showEmp2(i, sku_kode)
{ 

if(document.getElementById("custContact").value!="-1")
{
xmlHttp=GetXmlHttpObject();

if (xmlHttp==null)
{
	alert ("Browser does not support HTTP Request");
	return        
}

var url="NoUsePreformID.jsp";
url=url+"?sku_kode="+sku_kode;

xmlHttp.onreadystatechange=function() {
if (xmlHttp.readyState==4) {
  stateChanged2(i, xmlHttp.responseText);
}
};

xmlHttp.open("GET",url,true);
xmlHttp.send(null);
}

else

{
alert("Please Fill Sales Return Number ...");
}

}

function stateChanged2(i, text) 
{ 
document.getElementById("custID").value ="";
document.getElementById("NmCust").value ="";
document.getElementById("NetPrice").value ="";	 
	
document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 
document.getElementById("custContact").value ="";	 

if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
{ 

var showdata = xmlHttp.responseText; 
// alert(showdata);
var strar = showdata.split(":");

 if(strar.length==1)
 {
	 
	document.getElementById("custContact").focus(); 

document.getElementById("NmCust").value ="";
	document.getElementById("custID").value ="";
	document.getElementById("NetPrice").value ="";	

document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 
document.getElementById("custContact").value ="";

 }
 else if(strar.length>1)
 {
	var strname = strar[1];
			
	document.getElementById("custID").value= strar[1];
	document.getElementById("NmCust").value= strar[2];
document.getElementById("NetPrice").value= strar[3];
	
document.getElementById("IdCrm").value = "";
document.getElementById("ValidCrm").value = "";
document.getElementById("SegmentationCrm").value = "";	 
document.getElementById("custContact").value = strar[7];	
 }

}
}

function showCard(i, sku_kode)
{ 

if(document.getElementById("icode2").value!="-1")
{
xmlHttp=GetXmlHttpObject();

if (xmlHttp==null)
{
	alert ("Browser does not support HTTP Request");
	return        
}

var url="NoUsePreformCrm.jsp";
url=url+"?sku_kode="+sku_kode;

xmlHttp.onreadystatechange=function() {
if (xmlHttp.readyState==4) {
  stateChanged3(i, xmlHttp.responseText);
}
};

xmlHttp.open("GET",url,true);
xmlHttp.send(null);
}

else

{
alert("Please Fill CRM Number ...");
}

}

function stateChanged3(i, text) 
{ 
	// document.getElementById("IdCust").value ="";
document.getElementById("NmCust").value ="";
document.getElementById("NetPrice").value ="";	 
	
document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 

document.getElementById("CustContact").value = "";
document.getElementById("CustPin").value = "";	 
	
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
{ 

var showdata = xmlHttp.responseText; 
// alert(showdata);
var strar = showdata.split(":");

 if(strar.length==1)
 {
	 
	document.getElementById("icode2").focus(); 

document.getElementById("NmCust").value ="";
	// document.getElementById("IdCust").value ="";
	document.getElementById("NetPrice").value ="";	

document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 

document.getElementById("CustContact").value = "";
document.getElementById("CustPin").value = "";	 
	
 }
 else if(strar.length>1)
 {
	var strname = strar[1];
			
	// document.getElementById("IdCust").value= strar[1];
	document.getElementById("NmCust").value= strar[2];
document.getElementById("NetPrice").value= strar[3];
	
document.getElementById("IdCrm").value = strar[4];
document.getElementById("ValidCrm").value = strar[5];
document.getElementById("SegmentationCrm").value = strar[6];	 
document.getElementById("CustContact").value = strar[7];
document.getElementById("CustPin").value = strar[8];	 

	
 }

}
}

function showPin(i, tanggal, sku_kode)
{ 

if(document.getElementById("icode3").value!="-1")
{
xmlHttp=GetXmlHttpObject();

if (xmlHttp==null)
{
	alert ("Browser does not support HTTP Request");
	return        
}

var url="NoUsePreformPin.jsp";
// url=url+"?sku_kode="+sku_kode;
url=url+"?sku_kode="+sku_kode+"&tanggal="+tanggal+ "&echo=" + echo;    
    
xmlHttp.onreadystatechange=function() {
if (xmlHttp.readyState==4) {
  stateChanged4(i, xmlHttp.responseText);
}
};

xmlHttp.open("GET",url,true);
xmlHttp.send(null);
}

else

{
alert("Please Fill PIN Number ...");
}

}

function stateChanged4(i, text) 
{ 
document.getElementById("custID").value ="";
document.getElementById("NmCust").value ="";
document.getElementById("NetPrice").value ="";	 
	
document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 

document.getElementById("CustContact").value = "";
document.getElementById("CustPin").value = "";	 
	
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
{ 

var showdata = xmlHttp.responseText; 
// alert(showdata);
var strar = showdata.split(":");

 if(strar.length==1)
 {
	 
	document.getElementById("icode3").focus(); 

document.getElementById("NmCust").value ="";
	document.getElementById("custID").value ="";
	document.getElementById("NetPrice").value ="";	

document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 

document.getElementById("CustContact").value = "";
document.getElementById("CustPin").value = "";	
	
 }
 else if(strar.length>1)
 {
	var strname = strar[1];
			
	document.getElementById("custID").value= strar[1];
	document.getElementById("NmCust").value= strar[2];
document.getElementById("NetPrice").value= strar[3];
	
document.getElementById("IdCrm").value = strar[4];
document.getElementById("ValidCrm").value = strar[5];
document.getElementById("SegmentationCrm").value = strar[6];	

document.getElementById("CustContact").value = strar[7];
document.getElementById("CustPin").value = strar[8];	 
	
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

function showCard2(tanggal, sku_kode)
{ 

// alert(tanggal);

if(document.getElementById("IdCrm").value!="-1")
{
xmlHttp=GetXmlHttpObject();

if (xmlHttp==null)
{
	alert ("Browser does not support HTTP Request");
	return        
}

var url="NoUsePreformCrm.jsp";
url=url+"?sku_kode="+sku_kode;

xmlHttp.onreadystatechange=function() {
if (xmlHttp.readyState==4) {
  stateChanged3(tanggal, xmlHttp.responseText);
}
};

xmlHttp.open("GET",url,true);
xmlHttp.send(null);
}

else

{
alert("Please Fill CRM Number ...");
}

}

function stateChanged3(tanggal, text) 
{ 
// document.getElementById("custID2").value ="";
document.getElementById("custID").value ="";
document.getElementById("NmCust").value ="";
// document.getElementById("NetPrice").value ="";	 
	
document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 

// document.getElementById("CustContact").value = "";
// document.getElementById("CustPin").value = "";	 
	
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
{ 

var showdata = xmlHttp.responseText; 
// alert(showdata);
var strar = showdata.split(":");

 if(strar.length==1)
 {

	document.getElementById("IdCrm").focus(); 
        document.getElementById("NmCust").value ="";
	document.getElementById("custID").value ="";
        // document.getElementById("custID2").value ="";
	// document.getElementById("NetPrice").value ="";	

document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 

// document.getElementById("CustContact").value = "";
// document.getElementById("CustPin").value = "";	 

document.getElementById("IdCrm").focus(); 
	
 }
 else if(strar.length>1)
 {
	var strname = strar[1];
			
document.getElementById("custID").value= strar[1];
// document.getElementById("custID2").value= strar[1];
document.getElementById("NmCust").value= strar[2];
// document.getElementById("NetPrice").value= strar[3];	
document.getElementById("IdCrm").value = strar[4];
document.getElementById("ValidCrm").value = strar[5];
document.getElementById("SegmentationCrm").value = strar[6];	 
// document.getElementById("CustContact").value = strar[7];
// document.getElementById("CustPin").value = strar[8];	 

var custID0 = strar[1];
var tanggal0 = strar[5];
  
  // alert("tanggal0 "+tanggal0+ " custID0 "+custID0);
  
  if(custID0.length > 0 && tanggal0 >= tanggal)  
  {
  document.getElementById("findvoucher").disabled = false;
  document.getElementById("findvoucher").focus();
  
  }else{
     alert('The Time Card has not Valid');
     document.getElementById('icode2').focus; 
  }
	
 }

}
}

function split_char()
{
    
	var a;
        var b;
        
	var form=document.getElementById('icode2');  
        var form_temp=document.getElementById('tempName');                

        var form_IdCrm=document.getElementById('IdCrm');
        var hidden=form.value;     
        
        a=form.value.replace("<STX>","").replace("<CR>","").replace("<ETX>","").split("^");
        b=form.value.replace("<STX>","").replace("<CR>","").replace("<ETX>","").split("^");
            
        
        form_temp.value=a[0].replace(/^\s+/,"");
        var aa = form_temp.value;   
        var dig = aa.substr(0,4);
        
        // alert(dig);
        
        if (dig == "%TI-")            
        {        
                // Card No.
                form_temp.value=a[0].replace(/^\s+/,"");
                var dd = form_temp.value;
                var dig4 = dd.substr(1,10);
                form_IdCrm.value= dig4;
        }else{
                // Card No.
                form_temp.value=a[0].replace(/^\s+/,"");
                var dd = form_temp.value;                
                var dig4 = dd.substr(0,15);
                form_IdCrm.value= dig4;          
        
        }                
                
                
                
                
        /*
                // IdCust
                form_temp.value=a[1].replace(/^\s+/,"");
                var ee = form_temp.value;
                var dig5 = ee.substr(0,20);
                form_IdCust.value= dig5;
                
                // Name
                form_temp.value=a[2].replace(/^\s+/,"");
                var ff = form_temp.value;
                var dig6 = ff.substr(0,20);
                form_NmCust.value= dig6;

                // Segmentation
                form_temp.value=a[3].replace(/^\s+/,"");
                var gg = form_temp.value;
                var dig7 = gg.substr(0,10);
                form_SegmentationCrm.value= dig7;

                // Valid thru
                form_temp.value=a[3].replace(/^\s+/,"");
                var hh = form_temp.value;
                var dig8 = hh.substr(0,10);
                //sementara form_ValidCrm.value= dig8;                
                form_ValidCrm.value= '2014-03';    
                
         */       
}


function externalPopup(i) { 
           var cust   = document.getElementById("custID").value;
           var segmen = document.getElementById("SegmentationCrm").value;
           var dtStr = document.getElementById("ValidCrm").value;

           var dtCh= "-";                
           var daysInMonth = DaysArray(12)
           var pos1=dtStr.indexOf(dtCh)
           var pos2=dtStr.indexOf(dtCh,pos1+1)
           var strYear=dtStr.substring(0,pos1)
           var strMonth=dtStr.substring(pos1+1,pos2)
           var strDay=dtStr.substring(pos2+1)   
           
           strYr=strYear
           if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
           if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
           for (var i = 1; i <= 3; i++) {
                if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
           }
                        
           // GrassPeriod
           year=parseInt(strYr);           
           tahun=year+1;
           month=parseInt(strMonth,10)
           day=parseInt(strDay,10)                        
           var gperiod1 = month+"/"+day+"/"+tahun;
           var gperiod2 = new Date(gperiod1);
           
           var d = new Date();                        
           // alert("now : "+d+" g period :"+gperiod2);
           
           if (segmen != "VIP")
              {
               alert("Segmentation should be VIP");
               return false;
              } 
           if (gperiod2 < d)
              {
               alert("The Time Card has Expired");
               return false;
              }   
              
               var skuCode = document.getElementById("OutletID").value;               
               var list = new Array();                             
               popup = window.open("voucher_number_popup.jsp?skuCode=" + skuCode, "popup_id", 
			   "scrollbars,resizable,width=700,height=400");		
			
        }

function externalPopupPIN(i) { 
           var cust1 = document.getElementById("custID").value;
           // var skuCode = document.getElementById("OutletID").value;               
           // var skuCode = "";    
            var skuCode1 = ""; 
            
           var list = new Array();                             
               popup1 = window.open("pin_number_popup.jsp?skuCode=" + skuCode1, "popup_id", 
			   "scrollbars,resizable,width=800,height=400");					
        
          document.getElementById("findvoucher").disabled = false;
          // document.getElementById("findvoucher").focus();                   
        }       
        
        </script>
        
        
        <%@ include file="/lib/header.jsp"%>
        
    </head>
    <body>
        
        <%@ include file="/general/mvc_return_msg.jsp"%>
        
        <form name="add" action="<%=Sys.getControllerURL(BvWalletManager.TASKID_ADD_NEW_BVWALLET_DISTR_ITEM,request)%>" method="post">
            
            <div class="functionhead">Voucher Entry</div>
            <br>
            
            
            <table  class="listbox"  width=600>  
                
                <tr valign="top">
                    <td colspan="2" height="20" align="center" > <font color="blue"> <b> The TIME CARD </b> </font></td>
                </tr>
                
                <tr valign="top">
                    <td width="117" class="odd" align="right">Boutique :</td>
                    <td width="471"> <%= loginUser.getOutletID() %> - <std:text value="<%= loginUser.getUserName().toUpperCase()%>"/> </td>
                    <input type="hidden" name="OutletID" id="OutletID" value="<%= loginUser.getOutletID() %>" /> 
                </tr>        
                
                <tr valign="top">
                    <td valign="center" width="117" class="odd" align="right">Doc Date :</td>
                    <td valign="center" ><std:input type="date" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/></td>
                </tr>
                
                <tr valign="top">
                    <td width="117" class="odd" align="right">Sales Person :</td>          
                    <td><std:input type="select" name="Salesman" options="<%= staffMap %>" value="<%=request.getParameter("Salesman") %>" /></td>
                </tr>
                
                <tr valign="top">
                    <td width="117" class="odd" align="right" ><font color="blue"> Option : </font> </td>                                    
                    <td> <font color="blue"> 
                            <std:input type="radio" name="Type" value="1" status="onClick=\"javascript:showMenu('N');\" checked"/>Swipe Card 
                            <std:input type="radio" name="Type" value="2" status="onClick=\"javascript:showMenu('C');\""/>Input PIN 
                        </font>
                    </td>                                     
                </tr>
                <tr>
                    <td colspan="2" >	
                        <div id='menuN' style="display: visible;">                   
                            <table >
                                <tr>
                                    <td width="113" class="odd" align="right"  ><font color="blue"> Swipe : </font> </td>
                                    <td width="466" align="left">
                                        <input type="password" name="icode2" id="icode2" value="<%= custCRM %>" onKeyUp="split_char();" >  
                                        <input type="hidden" name="tempVal" id="tempName" value=" "/>   
                                        <br>
                                        After SWIPE, Press "Tab" key to get Card No.
                                  </td>                                                                
                                </tr>
                                
                                <input type="hidden" name="CustPin" id="CustPin" value="" disabled>
                                    <std:input type="hidden" name="CustomerPin" />      
                                    <input type="hidden" name="CustContact" id="CustContact" value="" disabled>
                                    <std:input type="hidden" name="CustomerContact" />                                             
                                    
                                    
                                </table>
                        </div>
                    </td>                                                                        
                </tr>                                  
                <tr>
                    <td colspan="2" >	
                        <div id='menuC' style="display: none;">
                            <table >
                                <tr>
                                    <td width="93" class="odd" align="right" ><font color="blue"> PIN : </font> </td>
                                    <td align="left">  
                                        <input type="password" name="icode3" id="icode3" value="" onKeyUp="showPin(<%= 1%>, '9999999', this.value);" size="4" maxlength="4"> 
                                    </td>
                                    <td colspan="2">
                                        <input type="button" value=" Find PIN " onClick="externalPopupPIN(1);" /> 
                                    </td> 
                                    
                                </tr>
                            </table>
                        </div>
                    </td>                                                                        
                </tr>
                
                
                <tr>
                    <td width="117" class="odd" align="right"  > <font color="blue">  Time Card No. : </font></td>   
                    <td align="left" >
                        <input type="text" name="IdCrm" id="IdCrm" value="<%= custCRM %>" readonly size="25" maxlength="25" onKeyUp="showCard2('<%= Sys.getDateFormater().format(new Date()) %>', this.value);" >
                        <input type="hidden" name="CustomerCRM" />
                        <input type="hidden" name="CustCRM" value="<%= custCRM %>" />                 
                    </td>
                </tr> 
                
                <tr>
                    <td width="117" class="odd" align="right" > <font color="blue">  Valid to : </font></td> 
                    <td align="left">
                        <input type="text" name="ValidCrm" id="ValidCrm" readonly value="<%= custValid %>" size="25" maxlength="25">
                        <input type="hidden" name="CustomerValid" />
                        <input type="hidden" name="CustValid" value="<%= custValid %>" />  
                    </td>
                </tr> 
                <tr>
                    <td width="117" class="odd" align="right"  >  <font color="blue">  Segmentation : </font></td> 
                    <td align="left" >
                        <input type="text" name="SegmentationCrm" id="SegmentationCrm" readonly value="<%= custSegmentation %>" size="25" maxlength="25" >
                        <input type="hidden" name="CustomerSegmentation" />
                        <input type="hidden" name="CustSegmentation" value="<%= custSegmentation %>" />  
                    </td>
                </tr> 
                
            </table>   
            
            <br>
            
            <table  class="listbox"  width=600 >
                
                <!--
	<tr>
	 	<td width="200" class="odd">Bonus Period</td>
	 	<td>
	 		<select name="periodid">
                <%@ include file="/common/select_bonusperiod.jsp"%>
	   		</select>
	 	</td>
	 </tr> 
	-->
                
                <tr>
                    <td width="100" class="odd" align="right">Trx Type :</td>
                    <td>
                        <select name="trxtype">
                            <%@ include file="/common/select_bvwallet_trxtypes.jsp"%>
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td width="100" class="odd" align="right">Customer ID :</td>    
                    <td>
                        <input type="text" name="custID" id="custID" readonly value=" " />
                        <input type="hidden" name="custID2" id="custID2" value=" " />
                    </td>
                    
                    <input type="hidden" name="NetPrice" id="NetPrice" value="" size="25" maxlength="25" disabled>
                        <std:input type="hidden" name="CustomerDeposit" />                                
                        
                    </tr>
                
                <td width="100" class="odd" align="right">Name :</td>
                <td >
                    <input type="text" name="NmCust" id="NmCust" readonly value="<%= custName %>" >
                    <input type="hidden" name="CustomerName" />
                    <input type="hidden" name="CustName" value="<%= custName %>" />                                                                                      
                </td>   
                
                
                <input type="hidden" name="bv" value="10" />
                <input type="hidden" name="bv1" value="0" />
                <tr>
                    <td width="100" class="odd" align="right">Voucher No. :</td>
                    
                    <td >
                        <input type="text" name="voucher" id="voucher" value="" size="20" maxlength="20" />
                        <input type="button" value="Find Voucher Number" id="findvoucher" disabled onClick="externalPopup(1);" /> 
                    </td>                    
                </tr>
                
                <tr>
                    <td width="100" class="odd" align="right" >Remark :</td>
                    <td><textarea name="remark" rows="5" cols="50"></textarea></td>
                </tr>
                
            </table>
            
            <table width=500 border="0" cellspacing="0" cellpadding="0" >
                <tr><td>&nbsp</td></tr>
                <tr><td>&nbsp</td></tr>
                <tr class="head"><td align="center"><input type="submit" value="SUBMIT"  id="submit" disabled onClick="return confirmSubmit()"></td></tr>
            </table>
            
        </form>
        
    </body>
</html>