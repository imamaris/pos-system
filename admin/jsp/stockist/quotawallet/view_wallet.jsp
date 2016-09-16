<%@page import="com.ecosmosis.orca.qwallet.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	QuotaWalletBean[] beans = (QuotaWalletBean[]) returnBean.getReturnObject(QuotaWalletManager.RETURN_WALLETLIST_CODE);
	QuotaWalletBean quota = (QuotaWalletBean) returnBean.getReturnObject(QuotaWalletManager.RETURN_WALLETBEAN_CODE);
	boolean canView = false;
	if (quota!=null && beans != null)
	 	canView = true;
	 	
%> 


<html>
<head>
<%@ include file="/lib/header.jsp"%>
		
<script language="Javascript">
		
	function doSearch(thisform) {
		
		if (!validateStockistId(thisform.StockistID)) {
			alert("Invalid Stockist ID.");
			focusAndSelect(thisform.StockistID);
			return false;
		}else{			
			return true;
		}  	    		
	} 
</script>
</head>

<body>
<div class="functionhead"><i18n:label code="STOCKIST_QUOTA_REPORT"/></div>
<form method="post" name="bvwallet" action="<%=Sys.getControllerURL(QuotaWalletManager.TASKID_VIEW_WALLET,request)%>" onSubmit="return doSearch(document.bvwallet);">
	<table class="listbox">
		 <tr>
		 	<td width="200" class="odd"><i18n:label code="STOCKIST_ID"/></td>
		 	<td><std:stockistid form="bvwallet" name="StockistID" /> &nbsp<input type="submit" value="<i18n:label code="GENERAL_BUTTON_PROCEED"/>"></td>
 		</tr>	
	</table>
</form>

<% if (canView) { %>    
<br>
<table width=400 class="listbox">
	 <tr valign=top>
	 	<td width="40%" class="odd" nowrap><i18n:label code="STOCKIST_ID"/></td>
	 	<td><%=quota.getOwnerID()%></td>
	 </tr>
 	 <tr>
	 	<td class="odd"><i18n:label code="GENERAL_NAME"/></td>
	 	<td><%=quota.getOwnerName()%></td>
	 </tr>	
	 <tr>
	 	<td class="odd"><i18n:label code="STOCK_BALANCE"/></td>
	 	<td><std:currencyformater code="" value="<%=quota.getBvBalance()%>"></std:currencyformater></td>
	 </tr>	
</table>

<br>
<br>
<div><b>
 <%
   if(request.getParameter("viewHistory")== null){ 
 %>	
		<i18n:label code="GENERAL_TODAY_TRX"/>
 <%
   }else{
 %>	
   		<i18n:label code="GENERAL_HIST_TRX"/>
 <%} %>
 </b>
</div>
<table width="80%" class="listbox">
		  <tr class="boxhead">
		  		<td align=right><i18n:label code="GENERAL_NUMBER"/></td>
		  		<td nowrap><i18n:label code="GENERAL_TRX_ID"/></td>
		  		<td nowrap><i18n:label code="GENERAL_TRX_TYPE"/></td>
		  		<td nowrap><i18n:label code="GENERAL_TRX_DATE"/></td>
		  		<td nowrap><i18n:label code="GENERAL_TRX_TIME"/></td>
		  		<td align="right"><i18n:label code="GENERAL_IN"/></td>
		  		<td align="right"><i18n:label code="GENERAL_OUT"/></td>
		  		<td nowrap><i18n:label code="GENERAL_REFERENCE_NUM"/></td>
		  		<td width="100"><i18n:label code="GENERAL_REMARK"/></td>
		  </tr>
		  
<%		  
	if(beans.length > 0){
		for (int i=0 ; i<beans.length; i ++) {
%>
		  <tr class="<%=((i%2==1)?"odd":"even")%>">
		  		<td align=right><%=(i+1)%>.</td>
		  		<td><%=beans[i].getSeqID()%></td>
		  		<td align=center><%=beans[i].getTrxType()%></td>
		  		<td align=center><%=beans[i].getTrxDate()%></td>
		  		<td align=center><%=beans[i].getTrxTime()%></td>
		  		<td align="right"><std:currencyformater code="" value="<%=beans[i].getBvIn()%>"></std:currencyformater></td>
		  		<td align="right"><std:currencyformater code="" value="<%=beans[i].getBvOut()%>"></std:currencyformater></td>
		  		<td align=center><std:text value="<%=beans[i].getReferenceNo()%>" defaultvalue="-" /></td>
		  		<td><std:text value="<%=beans[i].getRemark()%>" defaultvalue="-" /></td>
		  </tr>	

<%
		} // end for 
	}else{
%>	

	<tr><td colspan=9 align=center><i18n:label code="MSG_NO_RECORDFOUND"/></td></tr>
<%  } %>
</table>
<br>
<div class=noprint><a href="<%=Sys.getControllerURL(QuotaWalletManager.TASKID_VIEW_WALLET,request)%><%=((request.getParameter("viewHistory")!=null)?"":"&viewHistory")%>&StockistID=<%=quota.getOwnerID()%>"> 
 <%
   if(request.getParameter("viewHistory")== null){ 
 %>	
		<i18n:label code="GENERAL_HIST_TRX_VIEW"/>
 <%
   }else{
 %>	
   		<i18n:label code="GENERAL_TODAY_TRX_VIEW"/>
 <%} %>
</a>
</div>
<br>
<br>
<div><small><i18n:label code="MSG_ALLOW_VIEW_HIST_TRX"/></small></div>
<br>
<input type=button class=noprint value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">

<% 
   } else { 
	   if(request.getParameter("StockistID") != null){ 
%>
	<div align=left><i18n:label code="MSG_NO_RECORDFOUND"/></div>

<% 
        }
   } // end canView 
 %>
	
	</body>
</html>
