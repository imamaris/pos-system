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
OutletBean shipByOutlet = (OutletBean) returnBean.getReturnObject("ShipperBy");

String custID = (String) returnBean.getReturnObject("CustomerID");
String taskTitle = (String) returnBean.getReturnObject("TaskTitle");
String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);

String salesID = (String) returnBean.getReturnObject("SalesID");
String salesman = (String) returnBean.getReturnObject("Salesman");

int taskID = 0;
if (task != null)
    taskID = Integer.parseInt(task);
%>

<html>
<head>
    <title></title>
    
    <%@ include file="/lib/header.jsp"%>
    
    <script language="javascript">
  
		function doSubmit(thisform) {
			

                
                        
			if (thisform.CustomerContact = null) {
					alert("Invalid Mobile No.");
					focusAndSelect(thisform.CustomerContact);
					return false;
                        }
              

			if (thisform.Salesman = null) {
					alert("Invalid Sales ID.");
					focusAndSelect(thisform.Salesman);
					return false;
		  	} else {
			  	thisform.BonusEarnerID.value = thisform.Salesman.value;
                                                                
                        }
                        
                        
                if (!validateObj(thisform.PriceCode, 1)) {
				alert("<i18n:label code="MSG_SELECT_PRICECODE"/>");
				return false;
			}
                        
                        
	  	
	  	thisform.submit();
		} 
	
    </script>	
</head>

<body onLoad="self.focus();">

<div class="functionhead"><%= taskTitle %> - <i18n:label code="SALES_SALES_PREFORM"/></div>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="frmSalesOrder" action="<%=Sys.getControllerURL(taskID,request)%>" method="post" onSubmit="return doSubmit(document.frmSalesOrder);">
    
    <p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>
    
    <table class="tbldata">
        <tr>
            <td class="td1"><i18n:label code="SALES_TRX_DATE"/>:</td>
            <td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= new java.util.Date() %>" /></td>
        </tr>
        <tr>
            <td class="td1"><i18n:label code="SALES_COUNTER"/>:</td>
            <td><%= seller != null ? seller.getOutletID() : "-" %></td>
        </tr>
        
        <%
        if (taskID == CounterSalesManager.TASKID_MEMBER_SALES_PREFORM ||
        taskID == CounterSalesManager.TASKID_MEMBER_SALES_PREFORM_FULL_DELIVERY) {
        %>
        <tr>
            <td class="td1"><span class="required note">* </span><i18n:label code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
            <td>
                <std:memberid name="CustomerID" form="frmSalesOrder" value="<%= custID %>"/>
            </td>
        </tr>
        <tr>
            <td class="td1"><span class="required note">* </span>Bonus Date:</td>
            <td><std:input type="date" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/></td>
        </tr>
        
        <%
        } else {
        %>
        
        <tr>
            <td class="td1"><span class="required note">* </span><i18n:label code="GENERAL_NAME"/>:</td>
            <td>
                <std:input type="text" name="CustomerName"/>
            </td>
        </tr>
        <tr>
            <td class="td1">Mobile No :</td>
            
            <td>
                <std:input type="text" name="CustomerContact"/>
                <a href="javascript:popupSmall('<%=Sys.getControllerURL(MemberManager.TASKID_SEARCH_MEMBERS_BY_USR,request) %>&FormName=frmSalesOrder&ObjName=CustomerContact')">
                    <img border="0" alt='Search Customer' src="<%= Sys.getWebapp() %>/img/lookup.gif"/> Search Customer
                </a>                                
            </td>
            
        </tr>
        
        <%
        }
        %>
        

        <tr>
            <td class="td1"><span class="required note">* </span>Sales ID:</td>
            <td>
                <std:input type="text" name="Salesman"/>
                <a href="javascript:popupSmall('<%=Sys.getControllerURL(SalesmanManager.TASKID_SEARCH_MEMBERS_BY_USR,request) %>&FormName=frmSalesOrder&ObjName=CustID')">
                    <img border="0" alt='Search Sales' src="<%= Sys.getWebapp() %>/img/lookup.gif"/> Search Sales
                </a>
                
            </td>
        </tr>
        
        <tr>
            <td class="td1"><span class="required note">* </span><i18n:label code="PRICE_CODE"/>:</td>
            <td>
                <select name="PriceCode">
                    <%@ include file="/common/select_pricecode.jsp"%>
                </select>
            </td>
        </tr>
        <tr>
            <td class="td1"><i18n:label code="DELIVERY_BY"/>:</td>
            <td><%= shipByOutlet.getSalesStoreCode() %></td>
        </tr>
    </table>
    
    <br>

    <std:input type="hidden" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/>
    <std:input type="hidden" name="Salesman" />		
    
    <std:input type="hidden" name="CustomerContact" />

    <std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
    <std:input type="hidden" name="BonusEarnerID" />
    <std:input type="hidden" name="SellerID" value="<%= seller.getOutletID() %>" />
    <std:input type="hidden" name="ShipOptionStr" value="<%= String.valueOf(CounterSalesManager.SHIP_OWN_PICKUP) %>" />
    <std:input type="hidden" name="ShipByOutletID" value="<%= shipByOutlet.getOutletID() %>" />
    
    <input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>

