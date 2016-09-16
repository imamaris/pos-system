<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.pricing.product.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.common.staff.*"%>

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

Map staffMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_STAFFLIST_CODE);
String StaffName = request.getParameter("StaffName");


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
		
                var thisform = document.frmSalesOrder;
  		thisform.BonusEarnerID.value = thisform.CustomerID.value;
                
  		if (thisform.CustomerName != null) {
	  		if (!validateText(thisform.CustomerName)) {
					alert("<i18n:label code="MSG_ENTER_CUST_NAME"/>");
					return false;
				} 
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
            <td align="left"><std:input type="select" name="CustomerName" options="<%= staffMap %>" value="<%=request.getParameter("CustomerName")%>" /></td>
	</tr>
        
        <tr>
            <td class="td1"><i18n:label code="GENERAL_CONTACTS"/>:</td>
            <td>
                <std:input type="text" name="CustomerContact" size="40"/>
            </td>
        </tr>
        
        <%
        }
        %>
        
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
    
    <std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
    <std:input type="hidden" name="BonusEarnerID" form="frmSalesOrder" />
    <std:input type="hidden" name="SellerID" value="<%= seller.getOutletID() %>" />
    <std:input type="hidden" name="ShipOptionStr" value="<%= String.valueOf(CounterSalesManager.SHIP_OWN_PICKUP) %>" />
    <std:input type="hidden" name="ShipByOutletID" value="<%= shipByOutlet.getOutletID() %>" />
    
    <input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>

