<%@page import="com.ecosmosis.orca.counter.salessubmission.ExcelUploadManager"%>
<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<% 
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	StockistBean stockist = (StockistBean) returnBean.getReturnObject(StockistManager.RETURN_STKBEAN_CODE);
	String priceCode = (String)returnBean.getReturnObject("PriceCode");
%>
<script language="Javascript">
	
	function process(){	
		document.getElementById('btnSubmit').disabled = true;	
		return true;
	}
	
</script>
</head>
<body>
<script language=Javascript src="<%= request.getContextPath()%>/lib/no_right_click.js"></script>
<div class="functionhead"><i18n:label code="STOCKIST_SALES_SUBMISSION"/> > <i18n:label code="STOCKIST_SELECT"/> > <i18n:label code="GENERAL_UPLOAD_FILE"/></div>

	<table class="noprint">
		<tr>
			<td colspan=2>&nbsp;</td>
		</tr>
		<tr>
			<td align="right"><b><i18n:label code="STOCKIST_ID"/> :</b></td>
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
			<td align="right"><b><i18n:label code="PRICE_CODE"/> :</b></td>
	    	<td>
	    		<std:text value="<%=priceCode%>" />	
	    	</td>
		</tr>

	</table>
	
<form name="frm" action="<%=Sys.getControllerURL(ExcelUploadManager.TASKID_EXCEL_UPLOAD_SUBMIT,request)%>" method="post" onSubmit="return process();" enctype="multipart/form-data">
<input type="file" name="file_upload">

<input type="hidden" name="StockistID" value="<%=stockist.getStockistCode()%>">
<std:input type="hidden" name="PriceCode" value="<%=priceCode%>"/>
<input id="btnSubmit" type="submit" value="<i18n:label code="GENERAL_BUTTON_UPLOAD"/>">
</form>     

<small>* <i18n:label code="MSG_SUBMISSION_MAX_UPLOAD"/></small>

<%@ include file="/lib/return_error_msg.jsp"%>

</body>
</html>