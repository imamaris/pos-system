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
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
OutletBean seller = (OutletBean) returnBean.getReturnObject("SellerBean");
// SalesmanBean salesman = (SalesmanBean) returnBean.getReturnObject("SalesmanBean");

OutletBean shipByOutlet = (OutletBean) returnBean.getReturnObject("ShipperBy");

String custContact = (String) returnBean.getReturnObject("CustomerContact");

String custID = (String) returnBean.getReturnObject("CustomerID");
String custName = (String) returnBean.getReturnObject("CustomerName");

String taskTitle = (String) returnBean.getReturnObject("TaskTitle");

String salesID = (String) returnBean.getReturnObject("SalesID");
String salesman = (String) returnBean.getReturnObject("Salesman");

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
 
        var url="NoUseReturn.jsp";
        url=url+"?sku_kode="+sku_kode;
        
        xmlHttp.onreadystatechange=function() {
            if (xmlHttp.readyState==4) {
                //alert("sini");
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
    document.getElementById("NoCust").value ="";
    document.getElementById("NmCust").value ="";
    document.getElementById("NoSales").value ="";
    document.getElementById("NmSales").value ="";
    document.getElementById("NetPrice").value ="";	 
    document.getElementById("HpCust").value ="";    

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    { 
        var showdata = xmlHttp.responseText; 
        //alert(showdata);
        var strar = showdata.split(":");

        if(strar.length==1)
        {
            document.getElementById("icode").focus(); 
            document.getElementById("NoCust").value ="";
            document.getElementById("NmCust").value ="";
            document.getElementById("NoSales").value ="";
            document.getElementById("NmSales").value ="";
            document.getElementById("NetPrice").value ="";	
            document.getElementById("HpCust").value ="";
            
        } else if(strar.length>1){
            var strname = strar[1];

            document.getElementById("NoCust").value= strar[5];
            document.getElementById("NmCust").value= strar[6];
            document.getElementById("NoSales").value= strar[3];
            document.getElementById("NmSales").value= strar[4];
            document.getElementById("NetPrice").value= strar[7];
            document.getElementById("HpCust").value= strar[8];
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

function trim(str){
    return str.replace(/^\s+|\s+$/g,'');
}
</SCRIPT>

<script language="javascript">
  
function doSubmit(thisform) {

    thisform.Salesman.value = thisform.NoSales.value;
    thisform.BonusEarnerID.value = thisform.NoSales.value;
    thisform.CustomerID.value = thisform.NoCust.value;

    thisform.CustomerName.value = thisform.NmCust.value;
    thisform.CustomerContact.value = thisform.HpCust.value;
    thisform.CustomerDeposit.value = thisform.NetPrice.value;
    thisform.InvoiceReturn.value = thisform.icode.value;

if (thisform.CustomerName != null) {
    if (!validateText(thisform.CustomerName)) {
            alert("<i18n:label code="MSG_ENTER_CUST_NAME"/>");
            return false;
        } 
    }

    thisform.submit();
} 
	
</SCRIPT>

</head>

<body onLoad="self.focus();">

<div class="functionhead">Sales Invoice Return </div>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="frmSalesOrder" action="<%=Sys.getControllerURL(taskID,request)%>" method="post" onSubmit="return doSubmit(document.frmSalesOrder);">
    
    <p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>
    
            <table class="tbldata">
                <tr>
                    <td class="td1"><i18n:label code="SALES_TRX_DATE"/>:</td>
                    <td colspan="2" ><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= new java.util.Date() %>" /></td>
                </tr>
                <tr>
                    <td class="td1">Boutique:</td>
                    <td colspan="2" ><%= seller != null ? seller.getOutletID() : "-" %> - <std:text value="<%= loginUser.getUserName().toUpperCase()%>"/> </td> 
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
                    <td class="td1">Sales Return No. :</td>
                    <td td colspan="2">
                        <input type="text" name="icode" id="icode" value="" onKeyUp="showEmp(<%= 1%>, this.value);" size="20" maxlength="20"> 
                        <input type="hidden" id="code" value="icode" >  
                        <input type="hidden" name="InvoiceReturn">
                    </td>
                </tr>
                
                
                <%
                }
                %>
                
            </table>    
   
   <table>    
     <hr>
     <br>
     <tr>                        
            <td align="center"> Customer No. </td>    
            <td align="center"> Name </td>  
            <td align="center"> Contact </td>  
            <td align="center"> Nilai Deposit </td>
            <td align="center"> Sales ID</td>  
            <td align="center"> Sales Name </td>          
        </tr>      
       
     <tr>                        
            <td> 
                <input type="text" name="NoCust" id="NoCust" value="" disabled size="25" maxlength="25">
                <std:input type="hidden" name="CustomerID" />
                
            </td>    
            <td> 
                <input type="text" name="NmCust" id="NmCust" value="" disabled size="25" maxlength="25">
                <input type="hidden" name="CustomerName" />
                <input type="hidden" name="CustName" value="<%= custName %>" />  
                
            </td>                
            <td> 
                <input type="text" name="HpCust" id="HpCust" value="" disabled size="25" maxlength="25">
                <std:input type="hidden" name="CustomerContact" />
            </td>       
            <td> 
                <input type="text" name="NetPrice" id="NetPrice" value="" disabled size="25" maxlength="25">
                <input type="hidden" name="CustomerDeposit">
            </td>                            
            <td> 
                <input type="text" name="NoSales" id="NoSales" value="" disabled size="25" maxlength="25">
                <input type="hidden" name="Salesman" />
                <input type="hidden" name="BonusEarnerID" />
                
            </td>              
            <td> 
                <input type="text" name="NmSales" id="NmSales" value="" disabled size="25" maxlength="25">
            </td>              
        
        </tr>
       
       
       
            <input type="hidden" name="PriceCode" value="RTL" />

    </table>
    
    <br>
    
    <std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
    
    
    <std:input type="hidden" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/>
    
    <std:input type="hidden" name="SellerID" value="<%= seller.getOutletID() %>" />
    <std:input type="hidden" name="ShipOptionStr" value="<%= String.valueOf(CounterSalesManager.SHIP_OWN_PICKUP) %>" />
    <std:input type="hidden" name="ShipByOutletID" value="<%= shipByOutlet.getOutletID() %>" />
    
    <input class="textbutton" type="submit" value="  OK   " >
</form>

