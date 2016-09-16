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

System.out.println("Nilai Alamat 2 "+custAlamat +" Nama "+custName);

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
        // document.getElementById("IdCust").value ="";
	document.getElementById("NmCust").value ="";
	document.getElementById("NetPrice").value ="";	 
        
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  var showdata = xmlHttp.responseText; 
  // alert(showdata);
  var strar = showdata.split(":");
	
	 if(strar.length==1)
	 {
         
        document.getElementById("icode").focus(); 

	document.getElementById("NmCust").value ="";
        // document.getElementById("IdCust").value ="";
        document.getElementById("NetPrice").value ="";	
	
	 }
	 else if(strar.length>1)
	 {
		var strname = strar[1];
                
        // document.getElementById("IdCust").value= strar[1];
        document.getElementById("NmCust").value= strar[2];
	document.getElementById("NetPrice").value= strar[3];
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

    </SCRIPT>
    
    <SCRIPT language="JavaScript">

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
 
    </SCRIPT>
    
    <SCRIPT language="JavaScript">
 
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

    </SCRIPT>
    
    <script language="javascript">
  
		function doSubmit(thisform) {
			  		
			  	thisform.BonusEarnerID.value = thisform.Salesman.value;
                                thisform.CustomerContact.value = thisform.icode.value;
                                thisform.CustomerID.value = thisform.IdCust.value;
                                
                                thisform.CustomerName.value = thisform.NmCust.value;    
                                thisform.CustomerDeposit.value = thisform.NetPrice.value;                                                   
            
            
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
            <td class="td1">Boutique:</td>
            <td colspan="2" ><%= seller != null ? seller.getOutletID() : "-" %> - <std:text value="<%= loginUser.getUserName().toUpperCase()%>"/> </td> 

            <td class="td1">Customer Search</td>
            <td>
                <std:memberidsales name="custID" form="frmSalesOrder"  value="<%= custID %>" />  

            </td>
            
            <%
              System.out.println("chek nilai custID "+ custID);
            %>  
            
        <td colspan="3">
              
        </td> 
            
        </tr>
       
        <tr>
            <td class="td1"><i18n:label code="SALES_TRX_DATE"/>:</td>
            <td colspan="2" ><fmt:formatDate pattern="dd MMMM yyyy" type="both"  value="<%= new java.util.Date() %>" /></td>
        </tr>
        
        <tr>
            <td class="td1"><span class="required note">* </span>Doc. Date:</td>
            <td><std:input type="date" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/> yyyy-mm-dd</td>
            
        </tr>        
        
        
        <%
        if (taskID == CounterSalesManager.TASKID_MEMBER_SALES_PREFORM ||
        taskID == CounterSalesManager.TASKID_MEMBER_SALES_PREFORM_FULL_DELIVERY) {
        %>
        
        <td class="td1">Mobile No :</td>
        
        <td colspan="2">
            <std:input type="text" name="CustomerContact" value="324324324"/>
            <a href="javascript:popupSmall('<%=Sys.getControllerURL(MemberManager.TASKID_SEARCH_MEMBERS_BY_USR,request) %>&FormName=frmSalesOrder&ObjName=CustomerContact')">
                <img border="0" alt='Search Customer' src="<%= Sys.getWebapp() %>/img/lookup.gif"/> Search Customer
            </a>                
        </td> 
        
        <%
        } else {
        %>        
        
        
        <tr>
            
            <td class="td1"><span class="required note">* </span>Mobile No. :</td> 
            <td colspan="2">
                <input type="text" name="icode" id="icode" value="<%= custContact %>" onkeyup="showEmp(<%= 1%>, this.value);" onkeypress="IsNumeric();" size="25" maxlength="15"> 
                <input type="hidden" name="CustomerContact" />
            </td>
            <td ><span class="required note">* </span>Nama :</td>
            <td colspan="2" >
                <input type="text" name="NmCust" id="NmCust" value="<%= custName %>" onblur="IsName();" size="25" maxlength="25">
                <input type="hidden" name="CustomerName" />
                <input type="hidden" name="CustName" value="<%= custName %>" />  
                
                <a href="<%= editURL %>&MemberID=<%= custID %>">
                    <img border="0" alt='Edit Customer' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/>
                </a>
            </td>   
            
            
            
            
            
            <td align="left">
            </td>
            

            
            <input type="hidden" name="NetPrice" id="NetPrice" value="" size="25" maxlength="25" disabled>
                <std:input type="hidden" name="CustomerDeposit" />
                
            </tr>    
        
        <%
        }
        %>
        
        
        <tr>
            <td class="td1"><span class="required note">* </span>Sales Person ID:</td>          
            <td colspan="2"><std:input type="select" name="Salesman" options="<%= staffMap %>" value="<%=request.getParameter("Salesman") %>" /></td>
            <td ><td>
            <td  >
                <%= custAlamat %>
            </td>
            <input type="hidden" name="CustAlamat" value="<%= custAlamat %>" />   
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

