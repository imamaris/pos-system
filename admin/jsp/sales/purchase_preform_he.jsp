<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.salesman.*"%>

<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.pricing.product.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%

String editURL = Sys.getControllerURL(MemberManager.TASKID_BASIC_EDIT_MEMBER, request);

// MemberBean[] beans = (MemberBean[]) returnBean.getReturnObject(MemberManager.RETURN_MBRLIST_CODE);

MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
OutletBean seller = (OutletBean) returnBean.getReturnObject("SellerBean");

String custContact = (String) returnBean.getReturnObject("CustomerContact");
String custID = (String) returnBean.getReturnObject("CustomerID");

String custAlamat = (String) returnBean.getReturnObject("CustomerAlamat");
String custName = (String) returnBean.getReturnObject("CustomerName");

String custName2 = (String) returnBean.getReturnObject("CustomerName");

String custSegmentation = (String) returnBean.getReturnObject("CustomerSegmentation");
String custCRM = (String) returnBean.getReturnObject("CustomerCRM");
String custValid = (String) returnBean.getReturnObject("CustomerValid");
String custPin = (String) returnBean.getReturnObject("CustomerPin");

System.out.println("Nilai Alamat 2 "+custAlamat +" Nama "+custName +" Segmentation "+custSegmentation);

OutletBean shipByOutlet = (OutletBean) returnBean.getReturnObject("ShipperBy");

Map staffMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_STAFFLIST_CODE);
String StaffName = request.getParameter("StaffName");

String taskTitle = (String) returnBean.getReturnObject("TaskTitle");

String salesID = (String) returnBean.getReturnObject("SalesID");

String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);

String Segment = ""; //Updated By Ferdi 2015-01-21

int taskID = 0;
if (task != null)
    taskID = Integer.parseInt(task);
    
if (custSegmentation != null && custSegmentation.trim().length() > 0) Segment = "Segment : <b>" + custSegmentation + "</b>"; //Updated By Ferdi 2015-01-21
%>

<html>
<head>
    <title></title>
    
    <%@ include file="/lib/header.jsp"%>
    
    
    <SCRIPT>
	
 var echo  = 0;
 
function trim(str){
    return str.replace(/^\s+|\s+$/g,'');
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
						

function showMenu2(val) {
		if (val == 'N2') {
			document.getElementById('menuN2').style.display = 'block';
			document.getElementById('menuC2').style.display = 'none';
		} 
		
		if (val == 'C2') {
			document.getElementById('menuC2').style.display = 'block';
			document.getElementById('menuN2').style.display = 'none';
		}
}

function showEmp(i, sku_kode)
{ 

if(document.getElementById("custContact").value!="-1")
{
xmlHttp=GetXmlHttpObject();

if (xmlHttp==null)
{
	alert ("Browser does not support HTTP Request");
	return        
}

var url="NoUsePreform.jsp";
url=url+"?sku_kode="+sku_kode;

xmlHttp.onreadystatechange=function() {
if (xmlHttp.readyState==4) {
  stateChanged(i, xmlHttp.responseText);
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

function stateChanged(i, text) 
{ 
document.getElementById("custID").value ="";
document.getElementById("NmCust").value ="";
document.getElementById("NetPrice").value ="";	 
	
document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 
document.getElementById("custSegment").innerHTML = ""; //Updated By Ferdi 2015-01-22
	
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
document.getElementById("custSegment").innerHTML = ""; //Updated By Ferdi 2015-01-22
	
 }
 else if(strar.length>1)
 {
	var strname = strar[1];
			
	document.getElementById("custID").value= strar[1];
	document.getElementById("NmCust").value= strar[2];
        document.getElementById("NetPrice").value= strar[3];
	
        document.getElementById("IdCrm").value = "";
        document.getElementById("ValidCrm").value = "";
        document.getElementById("SegmentationCrm").value = strar[6]; //Updated By Ferdi 2015-01-22
        if(strar[6].length > 0) document.getElementById("custSegment").innerHTML = "Segment : <b>" + strar[6] + "</b>"; //Updated By Ferdi 2015-01-22
        
        // document.getElementById("submit").disabled = false;
        // document.getElementById("submit").focus();        
      
  var custID0 = strar[2];
    
  if(custID0.length > 0)  
  {
  document.getElementById("submit").disabled = false;
  // document.getElementById("submit").focus();
  
  }
  
/*   
  else{
     alert('Customer ID not Valid');
     document.getElementById('custID').focus; 
  }        
*/

 }

}
}

function showEmp2(i, sku_kode)
{ 
if(document.getElementById("custID").value!="-1")
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

function showCard(tanggal, sku_kode)
{ 

// alert(tanggal);
var test = trim(sku_kode);

if (test.length > 0)
{

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

// jk kosong
}else{
   alert("Please Fill CRM Number ...");
}

}




function stateChanged3(tanggal, text) 
{ 
document.getElementById("custID2").value ="";
document.getElementById("custID").value ="";
document.getElementById("NmCust2").value ="";
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

	document.getElementById("IdCrm").focus(); 
        document.getElementById("NmCust2").value ="";
	document.getElementById("custID").value ="";
        document.getElementById("custID2").value ="";
	document.getElementById("NetPrice").value ="";	

document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 

document.getElementById("CustContact").value = "";
document.getElementById("CustPin").value = "";	 

document.getElementById("IdCrm").focus(); 
	
 }
 else if(strar.length>1)
 {
	var strname = strar[1];
			
document.getElementById("custID").value= strar[1];
document.getElementById("custID2").value= strar[1];
document.getElementById("NmCust2").value= strar[2];
document.getElementById("NetPrice").value= strar[3];	
document.getElementById("IdCrm").value = strar[4];
document.getElementById("ValidCrm").value = strar[5];
document.getElementById("SegmentationCrm").value = strar[6];	 
document.getElementById("CustContact").value = strar[7];
document.getElementById("CustPin").value = strar[8];	 

var custID0 = strar[1];
var tanggal0 = strar[5];
  
  // alert("tanggal0 "+tanggal0+ " custID0 "+custID0);
  
  if(custID0.length > 0 && tanggal0 >= tanggal)  
  {
  document.getElementById("submit").disabled = false;
  document.getElementById("submit").focus();
  
  }else{
     alert('The Time Card has not Valid');
     document.getElementById('icode2').focus; 
  }
	
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


function IsNumeric()
{
var x = document.getElementById("custContact").value.split("");
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
document.getElementById("custContact").focus(); 
}
else
{
return true;
}

}

function IsName()
{
var x = document.getElementById("NmCust").value.split("");
var status = true;

if (x.length < 1)
{
alert("Please Enter Name ...");
document.getElementById("NmCust").focus(); 
}

else
{
return true;
}

}

function loadImage()
{

  nmCustID0 = document.getElementById("CustAlamat").value;

  if(nmCustID0.length < 1) nmCustID0 = "";  
  var panjang = nmCustID0.length;
  
  // alert(nmCustID0+" panjang : "+panjang);
  
  if(panjang > 0)
    document.getElementById("submit").disabled = false;
  
}


function InActive()
{
  nmCustID0 = document.getElementById("custID").value;
  if(nmCustID0.length < 1) nmCustID0 = document.getElementById("custID2").value;
  
  if(nmCustID0.length > 0)  
  {
  document.getElementById("submit").disabled = false;
  document.getElementById("submit").focus();
  
  }else{
    document.getElementById("custID").focus();
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


 }
          

function externalPopupPIN(tanggal, i) { 
           var cust = document.getElementById("custID").value;
           var skuCode = "";                 
           var list = new Array();                             
               popup = window.open("pin_number_popup.jsp?skuCode=" + skuCode, "popup_id", 
			   "scrollbars,resizable,width=800,height=400");
                           
          document.getElementById("submit").disabled = false;
          // document.getElementById("submit").focus();      
        }

//Updated By Ferdi 2015-05-29
function validateBackDate(thisform)
{
    
    var docDate = $("[name=BonusDate]").val();
    var docDate1 = docDate.split("-");
    var y = docDate1[0];
    var m = docDate1[1];
    var d = docDate1[2];
    var docDate2 = new Date(m + "/" + d + "/" + y);
    var nowDay = new Date();
    var daysAgo = new Date();
    
    daysAgo.setDate(daysAgo.getDate()-5);

    if(docDate2 <= nowDay && docDate2 > daysAgo)
    {
        doSubmit(thisform);
    }
    else
    {
        if(docDate2 > nowDay)
        {
            alert("Failed. Doc Date " + docDate + " More Than Today !!!");
        }
        else
        {
            alert("Failed. Doc Date " + docDate + " More Than 5 Days Ago !!!");
        }
        
        return false;
    }
}
//End Updated

function doSubmit(thisform) {
                
                                                thisform.BonusEarnerID.value = thisform.Salesman.value;
						thisform.CustomerContact.value = thisform.custContact.value;
						thisform.CustomerID.value = thisform.IdCust.value;
						
						thisform.CustomerName.value = thisform.NmCust.value;    
						thisform.CustomerDeposit.value = thisform.NetPrice.value;  
						
						thisform.CustomerCRM.value = thisform.IdCrm.value;  
						thisform.CustomerValid.value = thisform.ValidCrm.value;  
						thisform.CustomerSegmentation.value = thisform.SegmentationCrm.value;  	                                        
						thisform.CustomerPin.value = thisform.CustPin.value;                                                  
  
                                                
if (thisform.CustomerName.value != null) {
	if (!validateText(thisform.CustomerName)) {
			alert("<i18n:label code="MSG_ENTER_CUST_NAME"/>");
			return false;
		} 
	}
		  else
		  {
		  // alert("masuk");
		  }
				

		// var x = document.getElementById("NmCust").value.split("");
		var x = thisform.CustomerName.value = thisform.NmCust.value;
		var status = true;
		
		// alert ("test" + x.length); 
		
		if (x.length < 1 )
		{
			alert("Please Enter Name ...");
			document.getElementById("NmCust").focus(); 
		}
				

thisform.submit();
} 

    </script>	
    
</head>

<body onLoad="loadImage();">

<div class="functionhead">Sales Entry</div>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="frmSalesOrder" action="<%=Sys.getControllerURL(taskID,request)%>" method="post" onSubmit="return validateBackDate(document.frmSalesOrder);"> <!-- Updated By Ferdi 2015-05-29 -->


<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>

<table class="tbldata">

<tr valign="top">
    <td align="right"><font color="blue"> Option Entry : </font> </td>                                    
    <td align="left" colspan="7"> <font color="blue"> 
            <std:input type="radio" name="Type2" value="1" status="onClick=\"javascript:showMenu2('N2');\" checked"/>Regular 
            <std:input type="radio" name="Type2" value="2" status="onClick=\"javascript:showMenu2('C2');\""/>Special (The TIME Card) 
        </font>
    </td>   
</tr>

<tr >
    <td height="20"></td>
    </tr>
    
<tr valign="top">
    <td class="td1">Boutique :</td>
    <td ><%= seller != null ? seller.getOutletID() : "-" %> - <std:text value="<%= loginUser.getUserName().toUpperCase()%>"/> </td>                                     
</tr>
<tr valign="top">
    <td class="td1"><i18n:label code="SALES_TRX_DATE"/> :</td>
    <td ><fmt:formatDate pattern="dd MMMM yyyy 'at' hh:mm:ss" type="both"  value="<%= new java.util.Date() %>" /></td>
</tr> 

<tr>
    <td class="td1"><span class="required note">* </span>Sales Person ID :</td>          
    <td><std:input type="select" name="Salesman" options="<%= staffMap %>" value="<%=request.getParameter("Salesman") %>" /></td>
</tr>                                
<tr >
    <td class="td1"><span class="required note">* </span>Doc. Date :</td>
    <td valign="top" ><std:input type="date" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/> yyyy-mm-dd</td>
</tr>    

<tr>
    
    <td colspan="8">
    <table width="100%">                                
        <tr valign="top">
            <td> 
                
                <div id='menuN2' style="display: visible;">    
                    
                    <table width="100%">  
                        
                        <tr valign="top">
                            <td  nowrap> Customer ID : </td>
                            <td><std:memberidsales name="custID" id="custID" form="frmSalesOrder" onkeyup="showEmp2(<%= 1%>, this.value);"   value="<%= custID %>" />  Customer Search                                        
                            </td>
                            
                            <%
                            System.out.println("chek nilai custID "+ custID);
                            %>                                      
                        </tr>  
                        
                        <tr valign="top">                                  
                            <td class="td1"><span class="required note">* </span>Mobile No. :</td> 
                            <td nowrap>
                                <input type="text" name="custContact" id="custContact" value="<%= custContact %>" onkeyup="showEmp(<%= 1%>, this.value);" onKeyPress="return checkNumeric(event)" size="25" maxlength="15"> <!-- Updated By Ferdi 2015-01-21 -->
                                <input type="hidden" name="CustomerContact" />
                            </td>
                        </tr>
                        <tr valign="top">
                            <td class="td1" ><span class="required note">* </span>Nama :</td>
                            <td >
                                <input type="text" name="NmCust" id="NmCust" value="<%= custName %>" onblur="IsName();" size="25" maxlength="25">
                                <input type="hidden" name="CustomerName" />
                                <input type="hidden" name="CustName" value="<%= custName %>" />  
                                
                                <a href="<%= editURL %>&MemberID=<%= custID %>">
                                    <img border="0" alt='Edit Customer' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/>
                                </a>
                                
                                <input type="hidden" name="NetPrice" id="NetPrice" value="" size="25" maxlength="25" disabled>
                                    <std:input type="hidden" name="CustomerDeposit" />    
                                    
                                <label id="custSegment"><%= Segment %></label> <!-- Updated By Ferdi 2015-01-21 -->
                                </td>   
                            
                        </tr>
                        <tr>               
                            <td ></td>
                            <td >
                                <%= custAlamat %>
                            </td>
                            <input type="hidden" name="CustAlamat" id="CustAlamat" value="<%= custAlamat %>" />   
                        </tr>   
                        
                        
                    </table>                   
                    
                </div>
                
            </td>
            
            <td> <div id='menuC2' style="display: none;">                                                     
                
                <table width="100%" >
                    
                    <tr>
                        
                        <td>
                            <table width="70%" >                                 
                                
                                <tr valign="top">
                                    <td colspan="3" height="20" align="left" > <font color="blue"> <b> The TIME CARD </b> </font></td>
                                </tr>                                
                                <tr valign="top">
                                    <td class="td1"><font color="blue"> Option : </font> </td>                                    
                                    <td> <font color="blue"> 
                                            <std:input type="radio" name="Type" value="1" status="onClick=\"javascript:showMenu('N');\" checked"/>Swipe Card 
                                            <std:input type="radio" name="Type" value="2" status="onClick=\"javascript:showMenu('C');\""/>Input PIN 
                                        </font>
                                    </td>   
                                    
                                    <td >
                                        
                                    </td>                                    
                                </tr>
                                <tr>
                                    <td colspan="4" >	
                                        <div id='menuN' style="display: visible;">                   
                                            <table width="353" >
                                                <tr>
                                                    <td class="td1" width="40%" valign="top"><font color="blue"> Swipe : </font> </td>
                                                    <td align="left" nowrap>
                                                        <input type="password" name="icode2" id="icode2" onkeyup="split_char();" >  
                                                        <input type="hidden" name="tempVal" id="tempName" value=" "/>                                                                                                                      
                                                        <br>
                                                        After SWIPE, Press "Tab" key to get Card No.                                                 </td>                                                               
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
                                    <td colspan="4" >	
                                        <div id='menuC' style="display: none;">
                                            <table >
                                                <tr>
                                                    <td class="td1" width="42%"><font color="blue"> PIN : </font> </td>
                                                    <td align="left">  
                                                        <input type="password" name="icode3" id="icode3" value="" disabled onkeyup="showPin(<%= 1%>, '9999999', this.value);" size="4" maxlength="4"> 
                                                    </td>
                                                    
                                                    <td colspan="2">
                                                        <input type="button" value=" Find PIN " onClick="externalPopupPIN('<%= Sys.getDateFormater().format(new Date()) %>',1);" /> 
                                                    </td>                                                      
                                                    
                                                </tr>
                                            </table>
                                        </div>
                                    </td>                                                                        
                                </tr>                                                                
                                <tr>
                                    <td class="td1" > <font color="blue">  Card No. : </font></td>   
                                    <td >
                                        <input type="text" name="IdCrm" id="IdCrm" readonly value="<%= custCRM %>" size="25" maxlength="25" onkeyup="showCard('<%= Sys.getDateFormater().format(new Date()) %>',this.value);" >
                                        <input type="hidden" name="CustomerCRM" />
                                        <input type="hidden" name="CustCRM" value="<%= custCRM %>" />                 
                                    </td>
                                    <td>                                        
                                    </td>
                                </tr>   
                                <tr valign="top">
                                    <td class="td1" ><font color="blue">Customer ID : </font></td>
                                    <td >
                                        <input type="text" name="custID2" id="custID2" readonly value="" size="25" maxlength="25">
                                        
                                    </td>  
                                    
                                    <td></td>
                                </tr>                                 
                                
                                <tr valign="top">
                                    <td class="td1" ><font color="blue">Nama : </font></td>
                                    <td >
                                        <input type="text" name="NmCust2" id="NmCust2" readonly value=""  size="25" maxlength="25">
                                        
                                    </td>  
                                    
                                    <td></td>
                                </tr> 
                                
                                <tr>
                                    <td class="td1" > <font color="blue">  Valid to : </font></td> 
                                    <td>
                                        <input type="text" name="ValidCrm" id="ValidCrm" readonly value="<%= custValid %>" size="25" maxlength="25">
                                        <input type="hidden" name="CustomerValid" />
                                        <input type="hidden" name="CustValid" value="<%= custValid %>" />  
                                    </td>
                                    <td></td>
                                </tr> 
                                <tr>
                                    <td class="td1" >  <font color="blue">  Segmentation : </font></td> 
                                    <td >
                                        <input type="text" name="SegmentationCrm" id="SegmentationCrm" readonly value="<%= custSegmentation %>" size="25" maxlength="25" >
                                        <input type="hidden" name="CustomerSegmentation" />
                                        <input type="hidden" name="CustSegmentation" value="<%= custSegmentation %>" />  
                                    </td>
                                    <td></td>
                                </tr>
                            </table>
                        </td>
                        
                        <td>
                            <table width="50%" >
                                <tr>
                                    <td></td>  
                                </tr>                               
                            </table> 
                        </td>
                        
                    </tr>    
                </table>   
                
            </td>
            </div>
        </tr>                    
    </table>
    </td>
</tr>


<std:input type="hidden" name="PriceCode" value="RTL" />


</table>

<br>



<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
<std:input type="hidden" name="BonusEarnerID" />


<std:input type="hidden" name="Salesman" />

<std:input type="hidden" name="SellerID" value="<%= seller.getOutletID() %>" />
<std:input type="hidden" name="ShipOptionStr" value="<%= String.valueOf(CounterSalesManager.SHIP_OWN_PICKUP) %>" />
<std:input type="hidden" name="ShipByOutletID" value="<%= shipByOutlet.getOutletID() %>" />

<input class="textbutton"  type="submit" value="  OK   " id="submit"  disabled> <!-- Updated By Ferdi 2015-05-29 -->
</form>

