<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.pricing.product.*"%>
<%@ page import="com.ecosmosis.orca.ereceipt.EreceiptManager"%>
<%@ page import="com.ecosmosis.orca.ereceipt.EreceiptBean"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>



<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  CounterSalesOrderBean bean = (CounterSalesOrderBean) returnBean.getReturnObject("CounterSalesOrderBean");
  CounterSalesOrderBean adjstBean = (CounterSalesOrderBean) returnBean.getReturnObject("AdjstCounterSalesOrderBean");
  
  OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
  
  //Updated By Ferdi 2015-08-12
  EreceiptManager ercptMgr = new EreceiptManager();
  EreceiptBean[] ercptBean = ercptMgr.getEreceiptConfig();
  int ercptStatus = ercptBean[0].getErcptStatus();
  String ereceiptStatus = ercptMgr.getEreceiptStatus(bean.getTrxDocNo());
  
  MemberManager member = new MemberManager();
  String custEmail = member.getCustomerByID(bean.getCustomerID())[0].getEmail().trim();
  //End Updated
  
  // UtilsManager utilsMgr = new UtilsManager();

  boolean canView = bean != null;

%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>
        <script>
            $(function() {
                $("#custEmail").focus();
                getEmailValidate("<%=custEmail%>");
            });

            function IsEmail(email) {
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                return regex.test(email);
            }

            function updateRemark() {
                var remark = $("#Remark").val();
                $.post("updateRemark.jsp",{"salesID" : "<%=bean.getSalesID()%>", "remark" : remark}, function(data){
                    var status = trim(data);
                    
                    if(status == "success")
                    {
                        alert("Success, Saved!");
                    }else{
                        alert("Failed, Remark can not saved!");
                    }                    
                });

            }
            
            function getEmailValidate(email)
            {
                if(IsEmail(email))
                {
                    $("#btnSendreceipt").attr("disabled",false);
                }
                else
                {
                    $("#btnSendreceipt").attr("disabled",true);
                }
            }

            function sendReceipt()
            {
                var email = $("#custEmail").val();

                if(IsEmail(email))
                {
                    var answer = confirm("Anda yakin ingin kirim e-receipt ke alamat email : " + email);

                    if(answer)
                    {
                        $("#eReceipt").hide();
                        $("#msgProses").html("<img id=autoDSR_load src=<%=request.getContextPath()%>/img/indicator.gif />&nbsp;&nbsp;<b>Please Wait, Send e-receipt</b>&nbsp;&nbsp;");
                        $.post("e-receipt.jsp",{"custEmail" : email, "customerID" : "<%=bean.getCustomerID()%>", "custEmail" : email, "salesID" : "<%=bean.getSalesID()%>", "invoiceNo" : "<%=bean.getTrxDocNo()%>", "userID" : "<%=loginUser.getUserId()%>", "password" : "<%=loginUser.getPassword()%>", "status" : "<%=ercptStatus%>"}, function(data){
                            var result = trim(data);

                            if(result == "success")
                            {
                                $("#msgProses").html("&nbsp;&nbsp;<font color=green><b>e-receipt Sent</b></font>&nbsp;&nbsp;");
                            }
                            else
                            {
                                $("#msgProses").html("&nbsp;&nbsp;<font color=red><b>Send e-receipt Failed !!!</b></font>&nbsp;&nbsp;");
                                $("#eReceipt").show();
                            }
                        });
                    }
                }
                else
                {
                    alert("Failed, Customer Email not Valid !!!");
                }
            }
            
            function sendEDM()
            {
                var email = $("#custEmail").val();

                if(IsEmail(email))
                {
                    var answer = confirm("Anda yakin ingin kirim EDM ke alamat email : " + email);

                    if(answer)
                    {
                        $("#eReceipt").hide();
                        $("#msgProses").html("<img id=autoDSR_load src=<%=request.getContextPath()%>/img/indicator.gif />&nbsp;&nbsp;<b>Please Wait, Send EDM</b>&nbsp;&nbsp;");
                        $.post("e-receipt.jsp",{"custEmail" : email, "customerID" : "<%=bean.getCustomerID()%>", "custEmail" : email, "salesID" : "<%=bean.getSalesID()%>", "invoiceNo" : "<%=bean.getTrxDocNo()%>", "userID" : "<%=loginUser.getUserId()%>", "password" : "<%=loginUser.getPassword()%>", "status" : "<%=ercptStatus%>"}, function(data){
                            var result = trim(data);

                            if(result == "success")
                            {
                                $("#msgProses").html("&nbsp;&nbsp;<font color=green><b>EDM Sent</b></font>&nbsp;&nbsp;");
                            }
                            else
                            {
                                $("#msgProses").html("&nbsp;&nbsp;<font color=red><b>Send EDM Failed !!!</b></font>&nbsp;&nbsp;");
                                $("#eReceipt").show();
                            }
                        });
                    }
                }
                else
                {
                    alert("Failed, Customer Email not Valid !!!");
                }
            }

            function trim(str){
                return str.replace(/^\s+|\s+$/g,'');
            }
        </script>
</head>

<body>

<div class="functionhead"><i18n:label code="SALES_ORDER_VIEW"/></div>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<br>

<table width="620" border="0">
	<tr>
		<td align="left" valign="top" width="380">
                    <div id="msgProses"></div>
                    <label id="eReceipt">
                        email :
                        <input type="text" name="custEmail" id="custEmail" value="<%= (custEmail != null && custEmail.length() > 0 && !custEmail.equalsIgnoreCase("NULL")) ? custEmail : "" %>" onkeyup="getEmailValidate(this.value)" size="30">
                        <% if(ercptStatus == 1) { %>
                            <input type="button" id="btnSendreceipt" value="<i18n:label code="Send e-receipt"/>" onClick="sendReceipt()" disabled>
                        <% } else if(ercptStatus == 0) { %>
                            <input type="button" id="btnSendreceipt" value="<i18n:label code="Send EDM"/>" onClick="sendEDM()" disabled>
                        <% } %>
                    </label>
                </td>
                
		<% 
                    if (outlet.getOutletID().equalsIgnoreCase("CBPI") || outlet.getOutletID().equalsIgnoreCase("CBPS") || outlet.getOutletID().equalsIgnoreCase("CHPI")) {
		%>

                <td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="Print Invoice"/>" onClick="javascript:popupViewDoc('<%=Sys.getControllerURL(CounterSalesManager.TASKID_DOC_CB_CARTIER,request) %>&SalesID=<%= bean.getSalesID() %>')">
		</td>                
                 
		<% 
		  } else {
		%>
                
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="Print Invoice"/>" onClick="javascript:popupViewDoc('<%=Sys.getControllerURL(CounterSalesManager.TASKID_DOC_CB,request) %>&SalesID=<%= bean.getSalesID() %>')">
		</td>  
                
 		<% 
		  }
		%>               
                
		<% 
			if (bean.isImmediateDelivery() && bean.isDisplayDelivery()) {
		%>
		
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT_DO"/>" onClick="javascript:popupViewDoc('<%=Sys.getControllerURL(CounterSalesManager.TASKID_DOC_SALESDO,request) %>&SalesID=<%= bean.getSalesID() %>')">
		</td>
		
		<% 
			}
		%>

		<%
			if (bean.getStatus() != CounterSalesManager.STATUS_ACTIVE && adjstBean != null) {
				
				String printTitle = (bean.getStatus() == CounterSalesManager.STATUS_FULL_REFUNDED) ? "Print Return" : "Print Void";
		%>
		
		<td>
			<input class="noprint textbutton" type="button" value="<%= lang.display(printTitle) %>" onClick="javascript:popupViewDoc('<%= Sys.getControllerURL(CounterSalesManager.TASKID_DOC_CN,request) %>&SalesID=<%= adjstBean.getSalesID() %>')">
		</td>
		
		<%
			}
		%>
		
		<td align="right">
                    <%  if(ercptStatus == 1) { %>
                        <%=(ereceiptStatus.equalsIgnoreCase("Sent")) ? "<font color=green><b>e-receipt " + ereceiptStatus + "</b></font>" : "" %>
                    <% } else if(ercptStatus == 0) { %>
                        <%=(ereceiptStatus.equalsIgnoreCase("Sent")) ? "<font color=green><b>EDM " + ereceiptStatus + "</b></font>" : "" %>
                    <% } %>
                </td>
	</tr>
</table>


<table class="tbldata" border="0" width="600">                
        
        <tr valign=top>
	  <td colspan=2 align=right><hr></td>
	</tr>
        <tr valign=top>
            <td colspan=2 align=center> <font size="4" style="bold"> INVOICE </font></td>
	</tr>        
        <tr valign=top>
	  <td colspan=2 align=right><hr></td>
	</tr>
        
        <tr>
		<td valign=top>
			<%@ include file="/admin/jsp/sales/view_sales_document_he.jsp"%>
		</td>
	</tr>

        
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/sales/view_sales_cart_he.jsp"%>                  
		</td>
	</tr>

        
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/sales/view_sales_payment_he.jsp"%>                  
		</td>
	</tr>
        <tr>
		<td valign=top width="600">
			<%@ include file="/admin/jsp/sales/view_sales_customer_he.jsp"%>
		</td>
	</tr>        
	<tr>
		<td colspan="2" width="600">
			<%@ include file="/admin/jsp/sales/view_sales_remark_he.jsp"%>
		</td>
	</tr>
        
  	<tr class=printreceipt>
	  <td colspan="2"></td>   
  </tr>  
  
	<tr class=printreceipt align="center">
	  <td colspan="2">Goods/products have been accepted by the customer as being in good condition.</td>   
  </tr>  
	<tr class=printreceipt align="center">
	  <td colspan="2">Goods/products sold are non-refundable, returnable or exchangeable.</td>   
  </tr>  
  	<tr class=printreceipt align="center">
	  <td colspan="2">Thank you for your patronage.</td>   
  </tr>  
  
  	<tr class=printreceipt>
	  <td colspan="2"></td>   
  </tr> 
  
        <tr>
		<td  colspan="2" align="left">Validation No. : <%= bean.getTrxDocNo().getBytes()%> </td>
	</tr>    
  
        <tr>
		<td colspan="2" align="left">Printed By : <%= bean.getStd_createBy() %></td>
	</tr> 
        
</table>	

<%
	} // end canView
%>
	