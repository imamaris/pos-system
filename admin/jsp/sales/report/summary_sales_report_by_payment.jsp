<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
 <%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.document.*"%>
 <%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.pricing.product.*"%>
 <%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

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
	
	CounterSalesPaymentBean[] beans = (CounterSalesPaymentBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SUMMARY_REPORT_PAYMENT);
        
        CounterSalesPaymentBean[] bean = (CounterSalesPaymentBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SUMMARY_REPORT_PAYMENT_DETAIL);
 
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
     <div class="functionhead"><i18n:label code="SALES REPORT BY PAYMENT"/></div>
    <form name="frmSearch" action="<%=Sys.getControllerURL(CounterSalesManager.RETURN_SUMMARY_REPORT_PAYMENT_ID,request)%>" method="post" onSubmit="return doSubmit(document.frmSearch);">
	
    
        <table border="0">
          <tr>
            <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_FROM"/>:</td>
	    <td><std:input type="date" name="TrxDateFrom" value="now"/></td>
	    <td>&nbsp;</td>
	    <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_TO"/>:</td>
	    <td><std:input type="date" name="TrxDateTo" value="now"/></td>
	  </tr>
	  <tr>
              <td>Selection By:</td>
              <td><std:input type="radio" name="selection" value="1" status="     checked   "/><i18n:label code="Summary"/></td>
              <td><std:input type="radio" name="selection" value="2" status="      unchecked   "/><i18n:label code="Detail"/></td>
          </tr>
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	
	<input class="textbutton" type="submit" value="REPORT PREVIEW">
    </form>
    <div>
            <input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
         </div>
        
        
<hr>

<br>
<% 
	if (canView && beans.length != 0) {
        
        String selection = request.getParameter("selection");
        String date1 = request.getParameter("TrxDateFrom");
        String date2 = request.getParameter("TrxDateTo");
        String exportName = null;
        if(selection.equals("1")){
            exportName = "SUMMARY_SALES_REPORT_BY_PAYMENT"+date1.replaceAll("-","")+"-"+date2.replaceAll("-","")+".xls";
        }else if(selection.equals("2")){
            exportName = "DETAIL_SALES_REPORT_BY_PAYMENT"+date1.replaceAll("-","")+"-"+date2.replaceAll("-","")+".xls";
        }
%>
<div>
            <form name="by_payment_excel_form" action="admin/jsp/sales/report/summary_report_excel.jsp" method="post">
                <input type="hidden" id="tableHTML" name="tableHTML" value="" />
                <input type="hidden" id="fileName" name="fileName" value="<%= exportName %>" />
                <input type="button" onclick="gotoExcel('tableData', 'tableHTML');" value="Export to Excel" />  
            </form>
        </div>
<form name="frmList" action="" method="post">
    <div id="tableData">
        <%
        if(selection.equals("1")){
        %>
        <%@ include file="/admin/jsp/sales/report/summary_sales_report_by_payment_summary.jsp" %>
        <% 
        }else{
        %>
        <%@ include file="/admin/jsp/sales/report/summary_sales_report_by_payment_detail.jsp" %> 
        
        <%
        
        } 
        %>
    </div>
</form>
<%
        }
%>
<script type="text/javascript">  
              function gotoExcel(elemId, frmFldId)
              {  
                  var obj = document.getElementById(elemId);  
                  var oFld = document.getElementById(frmFldId);
                  
                  oFld.value = obj.innerHTML;
                  
                  document.forms["by_payment_excel_form"].submit();
              }  
        </script>
    </body> 
 </html>

 

 
 