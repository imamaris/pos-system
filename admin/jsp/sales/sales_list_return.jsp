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
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

Map trxTypeMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_TRXTYPELIST_CODE);

Map sellerMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SELLERLIST_CODE);

Map bonusPeriodMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_BNSPERIODLIST_CODE);

Map deliveryStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_DELIVERYSTATUS_CODE);

Map trxStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_STATUS_CODE);

Map orderByMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_ORDERBY_CODE);

Map recordsMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SHOWRECS_CODE);

ArrayList confirmBonusPeriodList = (ArrayList) returnBean.getReturnObject(CounterSalesManager.RETURN_CFIMBNSPERIODLIST_CODE);

CounterSalesOrderBean[] beans = (CounterSalesOrderBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SALESLIST_CODE);

boolean canView = beans != null;
%>

<html>
    <head>
        <title></title>
        
        <%@ include file="/lib/header.jsp"%>
        
        <script language="javascript">
    
  	function doSubmit(thisform) {
			
    	thisform.submit();
  	}      	 
        </script>
        
    </head>
    
    <body>
        
        <div class="functionhead">Sales Return</div>
        
        <form name="frmSearch" action="<%=Sys.getControllerURL(CounterSalesManager.TASKID_SALES_LIST_RETURN,request)%>" method="post" onSubmit="return doSubmit(document.frmSearch);">
            
            
            <table border="0">
                
                <tr>
                    <td class="td1"><i18n:label code="SALES_REFERENCE"/> :</td>
                    <td><std:input type="text" name="TrxDocNo" value="" size="30" maxlength="20"/></td>
                    <td>&nbsp;</td>
                    <td class="td1">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                
            </table>
            
            <br>
            
            <std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
            
            <input class="textbutton" type="submit" value="    OK   ">
        </form>
        
        <hr>
        
        <br>
        
        <%@ include file="/lib/return_error_msg.jsp"%>
        
        <% 
        if (canView) {
        %>
        
        <form name="frmList" action="" method="post">
            
            <table class="listbox" width="80%">
                <tr class="boxhead" valign=top>
                    <td>Sales <br> Return</td>
                    <td><i18n:label code="SALES_REFERENCE"/></td>
                    <td><i18n:label code="GENERAL_CUSTOMER"/></td>
                    <td><i18n:label code="SALES_TRX_DATE"/></td>
                    <td>Doc. Date</td>
                    <td align="right"><i18n:label code="GENERAL_NET_TOTAL"/></td>
                    <td><i18n:label code="GENERAL_STATUS"/></td>
                </tr>
                
                <%
                double grdTotalBV = 0.0d;
                double grdNetSales = 0.0d;
                
                boolean isOutletSales = false;
                boolean isStockistSales = false;
                boolean isActive = false;
                boolean isNew = false;
                boolean isBonusConfirmed = false;
                
                for (int i=0; i<beans.length; i++) {
                    
                    String rowCss = "";
                    
                    if((i+1) % 2 == 0)
                        rowCss = "even";
                    else
                        rowCss = "odd";
                    
                    isBonusConfirmed = false;
                    
                    if (beans[i].getSellerTypeStatus().equalsIgnoreCase(CounterSalesManager.TYPE_OUTLET)) {
                        isOutletSales = true;
                    } else {
                        isOutletSales = false;
                    }
                    
                    if (beans[i].getSellerTypeStatus().equalsIgnoreCase(CounterSalesManager.TYPE_STOCKIST)) {
                        isStockistSales = true;
                    } else {
                        isStockistSales = false;
                    }
                    isActive = beans[i].getStatus() == CounterSalesManager.STATUS_ACTIVE;
                    isNew = beans[i].isTodayTrx();
                    
                    if (isActive) {
                        grdTotalBV += beans[i].getTotalBv1();
                        
                        grdNetSales += beans[i].getNetSalesAmount();
                        
                        if (beans[i].getBonusPeriodID() != null && confirmBonusPeriodList.contains(beans[i].getBonusPeriodID())) {
                            isBonusConfirmed = true;
                        }
                        
                    } else {
                        rowCss = "alert";
                    }
                %>
                
                <tr class="<%= rowCss %>" valign=top>
                    
                    <% 
                    if (isOutletSales && isActive) {
                    %>
                    
                    
                    <td align="center">
                        <%      if ( isNew ) {    %>
                        -
                        <%      }  else { %>	
                        <small><std:link text="<%=("<li>" + lang.display("Process"))%>" taskid="<%= CounterSalesManager.TASKID_REFUND_SALES %>" params="<%=("SalesID="+beans[i].getSalesID())%>" /></small>
                        
                        <%
                        } // end return
                        %>       
                        
                    </td>                    
                    
                    
                    
                    <%
                    } else {
                    %>
                    
                    <td align="center">-</td>
                    
                    <%
                    } // end refund action
                    %>   
                    
                    
                    <td align="center" nowrap><std:text value="<%= beans[i].getTrxDocNo() %>" defaultvalue="-"/></td>
                    
                    <td nowrap>
                        <std:text value="<%= beans[i].getCustomerID() %>"/>
                        <% if (beans[i].getCustomerID() != null) { %>
                        <br>
                        <% } %>
                        <std:text value="<%= beans[i].getCustomerName() %>"/>
                    </td>
                    <td align="center" nowrap><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= beans[i].getTrxDate() %>" /></td>
                    <td align="center" nowrap><std:text value="<%= beans[i].getBonusPeriodID() %>" defaultvalue="-"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= beans[i].getNetSalesAmount() %>"/></td>
                    <td align="center" nowrap>
                        <%= CounterSalesManager.defineTrxStatusName(beans[i].getStatus()) %>
                        </td>
                    
                    
                </tr>
                
                <% 
                } // end for 
                %>
                
                
            </table>  
            
        </form>
        
        <% 
        } // end canView
        %>
        
    </body>
</html>
