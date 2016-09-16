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

int taskID = 0;
if (task != null)
    taskID = Integer.parseInt(task);
%>

<html>
<head>
    <title></title>
    
    <%@ include file="/lib/header.jsp"%>
    
    
    <SCRIPT>
        
var echo  = 0;
 
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

if(document.getElementById("icode").value!="-1")
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
        
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  var showdata = xmlHttp.responseText; 
  // alert(showdata);
  var strar = showdata.split(":");
	
	 if(strar.length==1)
	 {
       /*  
        document.getElementById("icode").focus(); 
	document.getElementById("NmCust").value ="";
        document.getElementById("NetPrice").value ="";	
       */
       
	document.getElementById("custContact").focus(); 
        document.getElementById("NmCust").value ="";
	document.getElementById("custID").value ="";
	document.getElementById("NetPrice").value ="";	

        document.getElementById("IdCrm").value ="";	 
        document.getElementById("ValidCrm").value ="";	 
        document.getElementById("SegmentationCrm").value ="";	         
	
	 }
	 else if(strar.length>1)
	 {
         /*
		var strname = strar[1];
                document.getElementById("NmCust").value= strar[2];
                document.getElementById("NetPrice").value= strar[3];
         */
	var strname = strar[1];
			
	document.getElementById("custID").value= strar[1];
	document.getElementById("NmCust").value= strar[2];
        document.getElementById("NetPrice").value= strar[3];
	
        document.getElementById("IdCrm").value = "";
        document.getElementById("ValidCrm").value = "";
        document.getElementById("SegmentationCrm").value = "";	          
	 }
	
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

function IsNumeric()
{
var x = document.getElementById("icode").value.split("");
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
document.getElementById("icode").focus(); 
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

function split_char()
{
    
	var a;
        var b;
        
	var form=document.getElementById('icode2');  
        var form_temp=document.getElementById('tempName');                

        var form_IdCust=document.getElementById('custID');        
        var form_NmCust=document.getElementById('NmCust');
        
        var form_NmCust2=document.getElementById('NmCust2');
        
        var form_IdCrm=document.getElementById('IdCrm');
        var form_SegmentationCrm=document.getElementById('SegmentationCrm');
        var form_ValidCrm=document.getElementById('ValidCrm');

        var hidden=form.value;     
        
        a=form.value.replace("<STX>","").replace("<CR>","").replace("<ETX>","").split("^");
        b=form.value.replace("<STX>","").replace("<CR>","").replace("<ETX>","").split("^");
                                                
                // Card No.
                form_temp.value=a[0].replace(/^\s+/,"");
                var dd = form_temp.value;
                var dig4 = dd.substr(1,10);
                form_IdCrm.value= dig4;

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

                form_NmCust2.value= dig6;

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
                
}

function externalPopupPIN(i) { 
           var cust = document.getElementById("custID").value;
           var skuCode = "";                 
           var list = new Array();                             
               popup = window.open("pin_number_popup.jsp?skuCode=" + skuCode, "popup_id", 
			   "scrollbars,resizable,width=800,height=400");		
			
        }

    </SCRIPT>
    
    <script language="javascript">
  
		function doSubmit(thisform) {
			  	/*	
			  	thisform.BonusEarnerID.value = thisform.Salesman.value;
                                thisform.CustomerContact.value = thisform.icode.value;
                                thisform.CustomerID.value = thisform.IdCust.value;                                
                                thisform.CustomerName.value = thisform.NmCust.value;    
                                thisform.CustomerDeposit.value = thisform.NetPrice.value;                                                   
                                */
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

<body onLoad="self.focus();">

<div class="functionhead"><font color="red">Sales Force</font></div>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="frmSalesOrder" action="<%=Sys.getControllerURL(taskID,request)%>" method="post" onSubmit="return doSubmit(document.frmSalesOrder);">

    
    <p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>


<table class="tbldata">

<tr valign="top">
    <td align="right"><font color="blue"> Option Entry : </font> </td>                                    
    <td align="left" colspan="7"> <font color="blue"> 
            <std:input type="radio" name="Type2" value="1" status="onClick=\"javascript:showMenu2('N2');\" checked"/>Regular 
            <std:input type="radio" name="Type2" value="2" status="onClick=\"javascript:showMenu2('C2');\""/>Special 
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
    <td ><fmt:formatDate pattern="dd MMMM yyyy" type="both"  value="<%= new java.util.Date() %>" /></td>
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
                            <td class="td1"> Customer ID : </td>
                            <td><std:memberidsales name="custID" id="custID" form="frmSalesOrder" onkeyup="showEmp2(<%= 1%>, this.value);"   value="<%= custID %>" />  Customer Search                                        
                            </td>
                            
                            <%
                            System.out.println("chek nilai custID "+ custID);
                            %>                                      
                        </tr>  
                        
                        <tr valign="top">                                  
                            <td class="td1"><span class="required note">* </span>Mobile No. :</td> 
                            <td>
                                <input type="text" name="custContact" id="custContact" value="<%= custContact %>" onkeyup="showEmp(<%= 1%>, this.value);" onkeypress="IsNumeric();" size="25" maxlength="15"> 
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
                                    
                                </td>   
                            
                        </tr>   
                        <tr>               
                            <td ></td>
                            <td >
                                <%= custAlamat %>
                            </td>
                            <input type="hidden" name="CustAlamat" value="<%= custAlamat %>" />   
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
                                            <table >
                                                <tr>
                                                    <td class="td1" width="38%"><font color="blue"> Swipe : </font> </td>
                                                    <td align="left">
                                                        <input type="password" name="icode2" id="icode2" value="<%= custCRM %>" onkeyup="split_char();" >  
                                                        <input type="hidden" name="tempVal" id="tempName" value=" "/>   
                                                        
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
                                    <td colspan="4" >	
                                        <div id='menuC' style="display: none;">
                                            <table >
                                                <tr>
                                                    <td class="td1" width="42%"><font color="blue"> PIN : </font> </td>
                                                    <td align="left">  
                                                        <input type="password" name="icode3" id="icode3" value="" disabled onkeyup="showPin(<%= 1%>, '9999999', this.value);" size="4" maxlength="4"> 
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
                                    <td class="td1" > <font color="blue">  Card No. : </font></td>   
                                    <td >
                                        <input type="text" name="IdCrm" id="IdCrm" value="<%= custCRM %>" size="25" maxlength="25" onkeyup="showCard();" >
                                        <input type="hidden" name="CustomerCRM" />
                                        <input type="hidden" name="CustCRM" value="<%= custCRM %>" />                 
                                    </td>
                                    <td>                                        
                                    </td>
                                </tr>   
                                
                                <tr valign="top">
                                    <td class="td1" ><font color="blue">Nama : </font></td>
                                    <td >
                                        <input type="text" name="NmCust2" id="NmCust2" value="<%= custName2 %>" onblur="IsName();" size="25" maxlength="25">
                                        
                                    </td>  
                                    
                                    <td></td>
                                </tr> 
                                
                                <tr>
                                    <td class="td1" > <font color="blue">  Valid to : </font></td> 
                                    <td>
                                        <input type="text" name="ValidCrm" id="ValidCrm" value="<%= custValid %>" size="25" maxlength="25">
                                        <input type="hidden" name="CustomerValid" />
                                        <input type="hidden" name="CustValid" value="<%= custValid %>" />  
                                    </td>
                                    <td></td>
                                </tr> 
                                <tr>
                                    <td class="td1" >  <font color="blue">  Segmentation : </font></td> 
                                    <td >
                                        <input type="text" name="SegmentationCrm" id="SegmentationCrm" value="<%= custSegmentation %>" size="25" maxlength="25" >
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
    
    <input class="textbutton" type="submit" value="  OK   " onClick="doSubmit(this.form)" >
</form>

