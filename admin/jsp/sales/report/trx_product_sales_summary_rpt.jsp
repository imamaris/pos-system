<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	String[] selProductIDList	 = (String[]) returnBean.getReturnObject("SelProductIDList");

	ProductBean[] items = (ProductBean[]) returnBean.getReturnObject("ProductFullList");
	
	ProductSalesReportBean rptBean = (ProductSalesReportBean) returnBean.getReturnObject("ProductSalesReport");
	
	boolean canView = rptBean != null;
%>

<html>
<head>
	<title></title>
	
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) {
			
			if (!validateObj(thisform.ProductIDList, 1)) {
				alert("Please select a Product.");
				return false;
			}
			
    	var vl1 = thisform.TrxDateFrom.value;
    	var vl2 = thisform.TrxDateTo.value;
			vl1 = Trim(vl1);
			vl2 = Trim(vl2);
						
    	if (vl1 == "" && vl2 == ""){
    		alert("Please enter Trx Date Selection.");
    		focusAndSelect(thisform.TrxDateFrom);
    		return false;
    	} else {
	    	return true;
    	}
    	
  	}     
	</script>

</head>

<body>
  
<div class="functionhead">Product Sales Summary By Product By Trx Date</div>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="frmSearch" action="<%=Sys.getControllerURL(CounterSalesReportManager.TASKID_TRX_PRODUCT_SALES_SUMMARY_RPT,request)%>" method="post" onSubmit="return doSubmit(document.frmSearch);">
	<table border="0">
	  <tr valign=top>
			<td class="td1">Products:</td>
			<td>
				<select name="ProductIDList" size="10" multiple>
				
				<% if (items != null) { %>
				
					<option value="ALL">ALL</option>
				
				<%
						int curCatID = -1;
				
						for (int i=0; i < items.length; i++) {
				%>
				
				<% 
						if (curCatID != items[i].getCatID()) {
							if (i != 0) {
				%>
								</optgroup>
				<% 
							} // end i != 0
				%>					
							<optgroup label="<%= items[i].getProductCategory().getName() %>">  
				<% 
						} // end diff catID
				%>		
				
					<option value="<%= items[i].getProductID() %>"><%= items[i].getSkuCode() %> - <%= items[i].getProductDescription().getName() %></option>
				
				<% 
							curCatID = items[i].getCatID();
						} // end for
					} // end if
				%>
				
			</td>
			<td>&nbsp;</td>
			<td class="note" colspan="2">
				<small> * To select multiple products, hold <b>CTRL</b> key and click on desired product.</small>
			</td>
		</tr>
	  <tr>
	  	<td class="td1" nowrap>Trx Date From:</td>
	    <td><std:input type="date" name="TrxDateFrom" value="now"/></td>
	    <td>&nbsp;</td>
	    <td class="td1">Trx Date To:</td>
	    <td><std:input type="date" name="TrxDateTo" value="now"/></td>
	  </tr>
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	
	<input class="textbutton" type="submit" value="Submit">
</form>

<hr>

<% 
	if (canView) {
%>

<div>
	<input class="noprint textbutton" type="button" value="Print" onclick="window.print()">
</div>

<br>

<table class="listbox" width="">
  <tr class="boxhead" valign=top>
    <td width="">SKU</td>
    <td width="">Product</td>
    <td align="right" width="">SAL QTY</td>
		<td align="right" width="">FOC QTY</td>
		<td align="right" width="">SAL QTY <br> (CN)</td>
		<td align="right" width="">FOC QTY <br> (CN)</td>
		<td align="right" width="">BV</td>
		<td align="right" width="">BV <br> (CN)</td>    
		<td align="right" width="">Net <br> BV</td> 
		<td align="right" width="">AMT</td>
		<td align="right" width="">AMT <br> (CN)</td>    
		<td align="right" width="">Net <br> AMT</td>
  </tr>
	
	<%
		int totalQtySalesIn = 0;
		int totalQtyFocIn = 0;
		int totalQtySalesOut = 0;
		int totalQtyFocOut = 0;
		
		double totalAmtIn = 0.0d;
		double totalAmtOut = 0.0d;
		double totalBvIn = 0.0d;
		double totalBvOut = 0.0d;
	
		ProductBean[] productList = rptBean.getProductList();
	
		for (int i = 0; i < productList.length; i++) {
			
			int qtySalesIn = 0;
			int qtyFocIn = 0;
			int qtySalesOut = 0;
			int qtyFocOut = 0;
			
			double amtIn = 0.0d;
			double amtOut = 0.0d;
			double bvIn = 0.0d;
			double bvOut = 0.0d;
			
			ProductBean productBean = productList[i];
			
			String productID = String.valueOf(productBean.getProductID());
			
			ProductSalesReportBean.ProductSalesBean[] salesList = rptBean.getSalesByProduct(productID);
			
			for (int j = 0; j < salesList.length; j++) {
				
				qtySalesIn += salesList[j].getQtySalesIn();
				qtySalesOut += salesList[j].getQtySalesOut();

				qtyFocIn += salesList[j].getQtyFocIn();
				qtyFocOut += salesList[j].getQtyFocOut();
				
				amtIn += salesList[j].getAmtIn();
				amtOut += salesList[j].getAmtOut();
				
				bvIn += salesList[j].getBvIn();
				bvOut += salesList[j].getBvOut();
			}
			
			totalQtySalesIn += qtySalesIn;
			totalQtySalesOut += qtySalesOut;
			
			totalQtyFocIn += qtyFocIn;
			totalQtyFocOut += qtyFocOut;
			
			totalAmtIn += amtIn;
			totalAmtOut += amtOut;
			
			totalBvIn += bvIn;
			totalBvOut += bvOut;
			
			String rowCss = "";
			
	  	if((i+1) % 2 == 0)
      	rowCss = "even";
      else
        rowCss = "odd";
	%>  
	
	<tr class="<%= rowCss %>" valign="top">
		<td><std:text value="<%= productBean.getSkuCode() %>"/></td>
		<td><std:text value="<%= productBean.getProductDescription().getName() %>"/></td>
		<td align="right" nowrap><%= qtySalesIn %></td>
		<td align="right" nowrap><%= qtyFocIn %></td>
		<td align="right" nowrap><%= qtySalesOut %></td>
		<td align="right" nowrap><%= qtyFocOut %></td>
		<td align="right" nowrap><std:bvformater value="<%= bvIn %>"/></td>
		<td align="right" nowrap><std:bvformater value="<%= bvOut %>"/></td>
		<td align="right" nowrap><std:bvformater value="<%= (bvIn - bvOut) %>"/></td>
		<td align="right" nowrap><std:currencyformater code="" value="<%= amtIn %>"/></td>
		<td align="right" nowrap><std:currencyformater code="" value="<%= amtOut %>"/></td>
		<td align="right" nowrap><std:currencyformater code="" value="<%= (amtIn - amtOut) %>"/></td>
	</tr>	

	<% 
		} // end for productList
	%>
	
	<tr>
		<td class="totalhead" colspan="2" align="right">Grand Total</td>
		<td align="right" nowrap><b><%= totalQtySalesIn %></b></td>
		<td align="right" nowrap><b><%= totalQtyFocIn %></b></td>
		<td align="right" nowrap><b><%= totalQtySalesOut %></b></td>
		<td align="right" nowrap><b><%= totalQtyFocOut %></b></td>
		<td align="right"><b><std:bvformater value="<%= totalBvIn %>"/></b></td>
		<td align="right"><b><std:bvformater value="<%= totalBvOut %>"/></b></td>
		<td align="right"><b><std:bvformater value="<%= (totalBvIn - totalBvOut) %>"/></b></td>
		<td align="right" nowrap><b><std:currencyformater code="" value="<%= totalAmtIn %>"/></b></td>
		<td align="right" nowrap><b><std:currencyformater code="" value="<%= totalAmtOut %>"/></b></td>
		<td align="right" nowrap><b><std:currencyformater code="" value="<%= (totalAmtIn - totalAmtOut) %>"/></b></td>
	</tr>
</table>

<%
	} 
%>

	<script language="javascript">
	<% if (selProductIDList != null) { %>
	
		var items = frmSearch.ProductIDList;
		
		<%
			for (int i = 0; i < selProductIDList.length; i++) { 
		%>
			for (var j = 0; j < items.length; j++)
				if (items.options[j].value == '<%= selProductIDList[i] %>') 
					items.options[j].selected = true;
		<%
			}
		%>
	<%
		}
	%>
	</script>
	
	
</body>	
</html>



