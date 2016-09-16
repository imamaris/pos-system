<%@page import="com.ecosmosis.orca.qwallet.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	QuotaWalletBean[] beans = (QuotaWalletBean[]) returnBean.getReturnObject(QuotaWalletManager.RETURN_WALLETLIST_CODE);
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><i18n:label code="STOCKIST_QUOTA_BALANCE_RPT"/></div>
 	<form method="post" name="quotalist" action="<%=Sys.getControllerURL(QuotaWalletManager.TASKID_BALANCEREPORT_BY_DATE, request)%>">
 	
 	<table class="listbox" width=500>
	 <tr>
	 	<td width="100" class="odd"><i18n:label code="GENERAL_ORDERBY"/></td>
	 	<td>
	 		<select name="orderby">
					<option value="bv desc"><i18n:label code="STOCKIST_QUOTA_PV_DESCEND"/></option>
					<option value="bv"><i18n:label code="STOCKIST_QUOTA_PV_ASCEND"/></option>
					<option value="qw_ownerid"><i18n:label code="STOCKIST_ID"/></option>
	   		</select>
	   		&nbsp<input type="submit" value="<i18n:label code="GENERAL_BUTTON_PROCEED"/>">
	 	</td>
	 </tr> 
	</table>
    </form>

<%  boolean zeroFound = false;	
if (beans != null && beans.length == 0)
	zeroFound = true; 	

	if (zeroFound) { 
%>
  	<table><tr><td><i18n:label code="MSG_NO_RECORDFOUND"/></td></tr></table>  
<% } %>

<% if (canView) { 
	
	double[] total = new double[10];
	
%>    
<table><tr><td><i18n:label code="GENERAL_TOTAL_RECORDSFOUND"/> : <%=beans.length%></td></tr></table>

<table class="listbox" width="60%">
		  <tr class="boxhead" valign=top>
		  		<td align="right"><i18n:label code="GENERAL_NUMBER"/></td>
		  		<td><i18n:label code="STOCKIST_ID"/></td>
		  		<td><i18n:label code="GENERAL_NAME"/></td>
		  		<td align="right"><i18n:label code="STOCKIST_QUOTA_BALANCE"/></td>
		  </tr>
		  
<%		  for (int i=0 ; i<beans.length; i ++) {

	 	total[0] += beans[i].getBvBalance();
	 	total[1] += beans[i].getBv1Balance();
	 	total[2] += beans[i].getBv2Balance();
	 	total[3] += beans[i].getBv3Balance();
	 	total[4] += beans[i].getBv4Balance();
	 	
	 	total[5] += (total[0]+total[1]+total[2]+total[3]+total[4]);
	
%>
		  <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td align="right"><%=(i+1)%>.</td>
		  		<td><%=beans[i].getOwnerID()%></td>
		  		<td><%=beans[i].getOwnerName()%></td>
		  		<td align="right"><std:currencyformater code="" value="<%=beans[i].getBvBalance()%>"></std:currencyformater></td>
		  </tr>	

<% } // end for %>	

		 <tr class="boxhead">
		  		<td colspan="3">&nbsp;</td>
		  		<td align="right"><std:currencyformater code="" value="<%=total[0]%>"></std:currencyformater></td>
		 </tr>

		  
</table>
<br>
<input type=button class=noprint value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
<% } // end canView %>
	
	</body>
</html>
