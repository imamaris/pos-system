<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<%@page import="com.ecosmosis.orca.counter.salessubmission.ExcelUploadManager"%>
<html>
<head>
  <title></title>

<%@ include file="/lib/header.jsp"%>

<%
	int size = 40;
	
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	StockistBean stockist = (StockistBean) returnBean.getReturnObject(StockistManager.RETURN_STKBEAN_CODE);
	
	boolean canView = stockist != null;
%>
	  
  <script language="javascript">
	 function doSearch(thisform) {
		
		if (!validateStockistId(thisform.StockistID)) {
			alert("<i18n:label code="MSG_INVALID_STOCKISTID"/>");
			focusAndSelect(thisform.StockistID);
			return false;
		}else{			
			return true;
		}  	    		
	} 
  </script>	
  
</head>

<body>
<script language=Javascript src="<%= request.getContextPath()%>/lib/no_right_click.js"></script>
<div class="functionhead"><i18n:label code="STOCKIST_SALES_SUBMISSION"/> > <i18n:label code="STOCKIST_SELECT"/></div>
<form name="frmSearch" action="<%=Sys.getControllerURL(((canView)?ExcelUploadManager.TASKID_EXCEL_UPLOAD:ExcelUploadManager.TASKID_EXCEL_SELECT_STOCKIST), request)%>" method="post" onSubmit="return doSearch(document.frmSearch);">
	<table class="noprint">
		<tr>
			<td align="right"><b><i18n:label code="STOCKIST_ID"/>:</b></td>
	    	<td>
	    	<%if(!canView){%>
		    	<std:stockistid name="StockistID" form="frmSearch"/>
	    	<%}else{%>
		    	<std:text value="<%=stockist.getStockistCode()%>" />
		    	<input type="hidden" name="StockistID" value="<%=stockist.getStockistCode()%>">
		    <%} %>	
	    	</td>
		</tr>
		<%if(canView){%>
		<tr>
			<td align="right"><b><i18n:label code="GENERAL_NAME"/> :</b></td>
	    	<td>
		    	<std:text value="<%=stockist.getName()%>" />	
	    	</td>
		</tr>
		<tr>
			<td colspan=2>&nbsp;</td>
		</tr>		
		<tr>
			<td align="right"><b><i18n:label code="PRICE_CODE"/> :</b></td>
	    	<td>
		    	<select name="PriceCode">
		    	<%for(int i=0; i<stockist.getPriceCodes().length;i++){%>
		    		<option value="<%=stockist.getPriceCodes()[i].getPriceCodeID() %>"><%=stockist.getPriceCodes()[i].getName() %></option>
		    	<%} %>
		    	</select>   
	    	</td>
		</tr>
   	    <%} %>
	</table>
	
	<br>
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" >
</form>

<hr class=noprint>
<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

</body>
</html>		