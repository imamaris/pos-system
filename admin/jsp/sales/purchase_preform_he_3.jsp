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
	// document.getElementById("IdCust").value ="";
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
	 
	document.getElementById("custContact").focus(); 

document.getElementById("NmCust").value ="";
	// document.getElementById("IdCust").value ="";
	document.getElementById("NetPrice").value ="";	

document.getElementById("IdCrm").value ="";	 
document.getElementById("ValidCrm").value ="";	 
document.getElementById("SegmentationCrm").value ="";	 
	
 }
 else if(strar.length>1)
 {
	var strname = strar[1];
			
	// document.getElementById("IdCust").value= strar[1];
	document.getElementById("NmCust").value= strar[2];
document.getElementById("NetPrice").value= strar[3];
	
document.getElementById("IdCrm").value = "";
document.getElementById("ValidCrm").value = "";
document.getElementById("SegmentationCrm").value = "";	 
	
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
  stateChanged2(i, xmlHttp.responseText);
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

function stateChanged2(i, text) 
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

function showPin(i, sku_kode)
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
alert("Please Fill PIN Number ...");
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
	 
	document.getElementById("icode3").focus(); 

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

<body onLoad="self.focus();">

<div class="functionhead">Sales Entry</div>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="frmSalesOrder" action="<%=Sys.getControllerURL(taskID,request)%>" method="post" onSubmit="return doSubmit(document.frmSalesOrder);">
    
    
    <p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>
    
    <table class="tbldata">
        
        <tr>
            <td colspan="8">
                <table width="100%">
                    <tr valign="top">
                        <td > 
                            <table width="100%">  
                                <tr valign="top">
                                    <td class="td1"> Customer Search : </td>
                                    <td><std:memberidsales name="custID" form="frmSalesOrder"  value="<%= custID %>" />                                          
                                    </td>
                                    
                                    <%
                                    System.out.println("chek nilai custID "+ custID);
                                    %>                                      
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
                                <tr >
                                    <td class="td1"><span class="required note">* </span>Doc. Date :</td>
                                    <td valign="top" ><std:input type="date" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/> yyyy-mm-dd</td>
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
                                    <td class="td1"><span class="required note">* </span>Sales Person ID :</td>          
                                    <td><std:input type="select" name="Salesman" options="<%= staffMap %>" value="<%=request.getParameter("Salesman") %>" /></td>
                                </tr>
                                <tr>               
                                    <td ><td>
                                    <td >
                                        <%= custAlamat %>
                                    </td>
                                    <input type="hidden" name="CustAlamat" value="<%= custAlamat %>" />   
                                </tr>   
                                
                                
                            </table>                        
                        </td>
                        <td>
                            <table width="100%" >    
                                <tr valign="top">
                                    <td colspan="3" height="20" align="center" > <font color="blue"> <b> Special Entry by Previllage Card </b> </font></td>
                                </tr>
                                <tr valign="top">
                                    <td colspan="3" height="20" align="center" ></td>
                                </tr>                                   
                                <tr valign="top">
                                    <td class="td1"><font color="blue"> Previllage Card : </font>
                                    </td>                                    
                                    <td> <font color="blue"> 
                                            <std:input type="radio" name="Type" value="1" status="onClick=\"javascript:showMenu('N');\" checked"/>Swipe Card 
                                            <std:input type="radio" name="Type" value="2" status="onClick=\"javascript:showMenu('C');\""/>Input PIN 
                                        </font>
                                    </td>   
                                    
                                    <td >
                                        
                                    </td>                                    
                                </tr>
                                <tr>
                                    <td colspan="3" >	
                                        <div id='menuN' style="display: visible;">                   
                                            <table >
                                                <tr>
                                                    <td width="45%"></td>
                                                    <td align="left">
                                                        <input type="text" name="icode2" id="icode2" value="<%= custCRM %>" onkeyup="showCard(<%= 1%>, this.value);" size="25" maxlength="15">             
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
                                    <td colspan="3" >	
                                        <div id='menuC' style="display: none;">
                                            <table >
                                                <tr>
                                                    <td width="70%"></td>
                                                    <td align="left">  
                                                        <input type="password" name="icode3" id="icode3" value="" onkeyup="showPin(<%= 1%>, this.value);" size="4" maxlength="4"> 
                                                    </td>  
                                                </tr>
                                            </table>
                                        </div>
                                    </td>                                                                        
                                </tr>
                                
                                
                                <tr>
                                    <td class="td1" > <font color="blue">  Previllage Swipe : </font></td>   
                                    <td >
                                        <input size="5" type="text" name="refNo_<%= i%>" id="scanVal<%= i%>" onkeyup="split_char(<%= i%>);"/>                        
                                        <input type="hidden" name="tempVal<%= i%>" id="tempName<%= i%>" value=" "/>                 
                                    </td>  
                                    <td></td>
                                </tr> 
                                
                                
                                <tr>
                                    <td class="td1" > <font color="blue">  Previllage No. : </font></td>   
                                    <td >
                                        <input type="text" name="IdCrm" id="IdCrm" value="<%= custCRM %>" size="25" maxlength="25" disabled>
                                            <input type="hidden" name="CustomerCRM" />
                                        <input type="hidden" name="CustCRM" value="<%= custCRM %>" />                 
                                    </td>
                                    <td></td>
                                </tr> 
                                
                                <tr>
                                    <td class="td1" > <font color="blue">  Valid to : </font></td> 
                                    <td>
                                        <input type="text" name="ValidCrm" id="ValidCrm" value="<%= custValid %>" size="25" maxlength="25" disabled>
                                            <input type="hidden" name="CustomerValid" />
                                        <input type="hidden" name="CustValid" value="<%= custValid %>" />  
                                    </td>
                                    <td></td>
                                </tr> 
                                <tr>
                                    <td class="td1" >  <font color="blue">  Segmentation : </font></td> 
                                    <td >
                                        <input type="text" name="SegmentationCrm" id="SegmentationCrm" value="<%= custSegmentation %>" size="25" maxlength="25" disabled>
                                            <input type="hidden" name="CustomerSegmentation" />
                                        <input type="hidden" name="CustSegmentation" value="<%= custSegmentation %>" />  
                                    </td>
                                    <td></td>
                                </tr> 
                                
                            </table>   
                            
                        </td>
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

