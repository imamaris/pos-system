<%@page import="com.ecosmosis.orca.counter.salessubmission.ExcelUploadManager"%>
<%@page import="com.ecosmosis.orca.product.ProductBean"%>
<%@page import="com.ecosmosis.orca.counter.sales.CounterSalesOrderBean"%>
<%@page import="com.ecosmosis.mvc.sys.SystemConstant"%>
<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<%@page import="com.ecosmosis.orca.qwallet.QuotaWalletBean"%>
<%@page import="com.ecosmosis.orca.qwallet.QuotaWalletManager"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<% 
	MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ProductBean[] products = (ProductBean[]) returnBean.getReturnObject(ExcelUploadManager.RETURN_PRODUCTS_CODE); 
	CounterSalesOrderBean[] salesBeans = (CounterSalesOrderBean[]) returnBean.getReturnObject(ExcelUploadManager.RETURN_SUBMISSIONS_CODE); 
	StockistBean stockist = (StockistBean) returnBean.getReturnObject(StockistManager.RETURN_STKBEAN_CODE);
	QuotaWalletBean wallet = (QuotaWalletBean) returnBean.getReturnObject(QuotaWalletManager.RETURN_WALLETBEAN_CODE);
	
	double balance = (wallet!=null)?wallet.getBvBalance():0d;
	String priceCode = (String)returnBean.getReturnObject("PriceCode");

	boolean canView = (products!=null && products.length > 0 && salesBeans!=null && salesBeans.length > 0);
%>
<script language="Javascript">
	
	function process(){	
	
		if(confirm('<i18n:label code="MSG_CONFIRM_IMPORT_SALES"/>')){
			document.getElementById('btnSubmit').disabled = true;
			document.getElementById('btnCancel').disabled = true;
			return true;
		}else
			return false;
	}
	function cancelAction(){	
	
		if(confirm('<i18n:label code="MSG_CANCEL_IMPORT"/>')){
			
			location.href="<%=Sys.getControllerURL(ExcelUploadManager.TASKID_EXCEL_SELECT_STOCKIST, request)%>&StockistID=<%=stockist.getStockistCode()%>";
			return true;
		}else
			return false;
	}
</script>
</head>
<body>
<script language=Javascript src="<%= request.getContextPath()%>/lib/no_right_click.js"></script>
<div class="functionhead">Sales Submission > Select Stockist > Upload > Data</div>

<form name="frm" action="<%=Sys.getControllerURL(ExcelUploadManager.TASKID_EXCEL_IMPORT_DATA,request)%>" method="post" onSubmit="return process();">

<c:if test="<%=canView%>" >
	<table class="noprint">
		<tr>
			<td align="right"><b><i18n:label code="STOCKIST_ID"/>:</b></td>
	    	<td>
		    	<std:text value="<%=stockist.getStockistCode()%>" />
	    	</td>
		</tr>
		<tr>
			<td align="right"><b><i18n:label code="GENERAL_NAME"/> :</b></td>
	    	<td>
		    	<std:text value="<%=stockist.getName()%>" />	
	    	</td>
		</tr>
		<tr>
			<td align="right"><b><i18n:label code="PRICE_CODE"/>:</b></td>
	    	<td>
	    		<std:text value="<%=priceCode%>" />	
	    	</td>
		</tr>
		<tr>
			<td align="right"><b>Latest Quota Balance:</b></td>
	    	<td>
	    		<std:currencyformater code="" value="<%=balance%>" />	
	    	</td>
		</tr>
		<tr>
			<td colspan=2>&nbsp;</td>
		</tr>
	</table>
	

	<table class="listbox" >
			<tr class="boxhead" valign=top>
				<td width="5%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
				<td><i18n:label code="BONUS_PERIOD"/></td>
				<td><i18n:label code="SALES_TRX_DATE"/></td>
				<td><i18n:label code="MEMBER_NUMBER"/></td>
<%
				for(int i=0; i<products.length; i++){
%>				
				<td nowrap><%=products[i].getSkuCode()%></td>	
<%				} %>			
				<td><i18n:label code="GENERAL_TOTAL"/> PV</td>
				<td><i18n:label code="GENERAL_TOTAL"/></td>
				<td><i18n:label code="GENERAL_REMARK"/></td>
			</tr>
			
<%				
			   int grand_bv = 0;
			   double grand_amount = 0d;
			   for(int i=0; i< salesBeans.length; i++){
%>
			<tr class="<%= ((i%2)==0)?"odd":"even"%>" valign=top>
				<td align=right><%= (i+1) %>.</td>				
				<td nowrap><%=salesBeans[i].getBonusPeriodID()%></td>
				<td nowrap><fmt:formatDate value="<%=salesBeans[i].getTrxDate()%>" pattern="<%=SystemConstant.DEFAULT_DATEFORMAT%>"/>   </td>
				<td nowrap><%=salesBeans[i].getCustomerID()%></td>

<%				
				int total_bv = 0;
				double total_amount = 0d;
				for(int p=0; p<products.length; p++){
%>	
<%			
					int qty = 0;
					for(int j=0; j<salesBeans[i].getItemArray().length; j++){						
						
						if(products[p].getProductID() == (salesBeans[i].getItemArray()[j].getProductID())){
							
							qty = salesBeans[i].getItemArray()[j].getQtyOrder();
							total_bv += qty * salesBeans[i].getItemArray()[j].getBv1();
							total_amount += qty * salesBeans[i].getItemArray()[j].getUnitPrice();
							break;
						}							
					} // end for salesBeans[i].getItemArray()	
%>				
						<td align=right><%=qty%></td>
<%				} //end for products%>	

				<td align=right><std:bvformater value="<%=total_bv%>" /></td>				
				<td align=right><std:currencyformater value="<%=total_amount%>" code=""/></td>
				<td align=left><std:text defaultvalue="-"  value="<%=salesBeans[i].getRemark()%>" /></td>	
			</tr>
			
<%			
					grand_bv += total_bv;
					grand_amount += total_amount;
			}//end for 
%>			
			<tr class="boxhead" valign=top>			
				<td colspan="<%=(4+products.length)%>" align=right>Total&nbsp;</td>
				<td align=right><std:bvformater value="<%=grand_bv%>" /></td>				
				<td align=right><std:currencyformater value="<%=grand_amount%>" code=""/></td>
				<td align=left>&nbsp;</td>	
			</tr>
	</table>	

<input type=hidden name="StockistID" value="<%=stockist.getStockistCode()%>">

<br>
<input id="btnSubmit" type="submit" value="<i18n:label code="GENERAL_BUTTON_IMPORT"/>">
<input id="btnCancel" type="button" value="<i18n:label code="GENERAL_BUTTON_CANCEL"/>" onClick='cancelAction();'>

</c:if>



</form>     
<%@ include file="/lib/return_error_msg.jsp"%>
</body>
</html>