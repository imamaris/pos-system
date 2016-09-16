<%@page import="com.ecosmosis.orca.qwallet.QuotaWalletManager"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script LANGUAGE="JavaScript">
<!--
function confirmSubmit(thisform)
{
  if(doSearch(thisform)){
  
	  var agree=confirm("<i18n:label code="MSG_CONFIRM"/>");
		if (agree)
			return true ;
		else
			return false ;
  }  
  else
  		return false ;
	
}

function doSearch(thisform) {
	
	var unit = thisform.bv.value;
	if (!validateStockistId(thisform.StockistID)) {
		alert("<i18n:label code="MSG_INVALID_STOCKISTID"/>");
		focusAndSelect(thisform.StockistID);
		return false;
	}
	if (unit.length == 0 || (isNaN(unit) || unit<=0)) {
	     alert("<i18n:label code="MSG_AMT_POSITIVE_INTEGER "/>");
	     focusAndSelect(thisform.bv);
	     return false;
  	}
	return true;
} 
// -->
</script>

</head>
 <body>
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<form name="add" action="<%=Sys.getControllerURL(QuotaWalletManager.TASKID_ADD_NEW_WALLET_ITEM, request)%>" method="post" onSubmit="return confirmSubmit(document.add);">

<div class="functionhead"><i18n:label code="STOCKIST_QUOTA_ADD"/></div>
<br>
	
<table  class="listbox"  width=600>

	 <tr>
	 	<td width="200" class="odd"><i18n:label code="GENERAL_TRX_DATE"/></td>
	 	<td><std:input name="trxdate" type="date" value="now" status="onFocus=blur()"/></td>
	 </tr>
	 	
	 <tr>
	 	<td width="200" class="odd"><i18n:label code="GENERAL_TRX_TYPE"/></td>
	 	<td>
	 		<select name="trxtype">
	 			 <%@ include file="/common/select_bvwallet_trxtypes.jsp"%>
	   		</select>
	 	</td>
	 </tr>
	 
	  <tr>
	 	<td width="200" class="odd"><i18n:label code="STOCKIST_ID"/></td>
	 	<td><std:stockistid form="add" name="StockistID" value="" /></td>
	 </tr>	
	 
	 <tr>
	 	<td width="200" class="odd">PV</td>
	 	<td><std:input type="text" name="bv" size="10" maxlength="10" /></td>
	 </tr>
	 
	 <tr>
	 	<td width="150" class="odd"><i18n:label code="GENERAL_REMARK"/></td>
	 	<td><textarea name="remark" rows="5" cols="50"><std:text value="<%=request.getParameter("remark")%>" /></textarea></td>
	 </tr>
	 
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_ADD"/>"></td></tr>
</table>

</form>

 </body>
</html>