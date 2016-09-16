<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bvwallet.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BvWalletBean[] beans = (BvWalletBean[]) returnBean.getReturnObject("BvWalletList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	 	
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusPeriodList");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Voucher Report</div>
 	<form method="post" name="bonuslist" action="<%=Sys.getControllerURL(BvWalletManager.TASKID_BALANCEREPORT_BY_PERIOD,request)%>">
 	
 	<table class="listbox" width=500>
         
         <std:input type="hidden" name="periodid" value="2013-01-01" />
         
	 <tr>
		<td  width="100" class="odd" align="right"><i18n:label code="GENERAL_FROMDATE"/> :</td>
  		<td><std:input type="date" name="fromdate"  value="now" size="11" />  (yyyy-mm-dd) </td>
	</tr>
	<tr>
		<td  width="100" class="odd" align="right"><i18n:label code="GENERAL_TODATE"/> :</td>
  		<td><std:input type="date" name="todate"  value="now" size="11" />  (yyyy-mm-dd) </td>
	</tr>	         
         
	 <tr>
	 	<td width="100" class="odd" align="right">Order By :</td>
	 	<td>
	 		<select name="orderby">
					<%@ include file="/common/select_bvwallet_orderby.jsp"%>
	   		</select>
	   		&nbsp<input type="submit" value=" GO ">
	 	</td>
	 </tr> 
	</table>
    </form>

<%  boolean zeroFound = false;	
if (beans != null && beans.length == 0)
	zeroFound = true; 	

	if (zeroFound) { 
%>
  	<table><tr><td>No Records Found.</td></tr></table>  
<% } %>

<% if (canView) { 
	
	double[] total = new double[10];
	
%>    
<table><tr><td>Total Records Found : <%=beans.length%></td></tr></table>

<table  class="listbox" width="70%">
		  <tr class="boxhead">
		  		<td align="center" width="5%" >No.</td>
		  		<td align="center" width="15%" >Customer ID</td>                                
		  		<td align="center">Name</td> 
		  		<td nowrap>CRM ID</td>
		  		<td nowrap>Segmentation</td>                                    
		  		<td align="center" width="15%" >Voucher</td>
		  </tr>
		  
<%		  for (int i=0 ; i<beans.length; i ++) {

	 	total[0] += beans[i].getBvBalance()/10;
	 	total[1] += beans[i].getBv1Balance()/10;
	 	total[2] += beans[i].getBv2Balance()/10;
	 	total[3] += beans[i].getBv3Balance()/10;
	 	total[4] += beans[i].getBv4Balance()/10;
	 	
	 	total[5] += (total[0]+total[1]+total[2]+total[3]+total[4]);
	
%>
		  <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td align="center" ><%=(i+1)%></td>
		  		<td><%=beans[i].getOwnerID()%></td>
		  		<td><%=beans[i].getOwnerName()%></td>
		  		<td align="left" ><%=beans[i].getOwnerCRM()%></td>
                                <td align="left" ><%=beans[i].getOwnerSegmentation()%></td>                                
		  		<td align="right"><%=number.format(beans[i].getBvBalance()/10)%></td>		  		
		  </tr>	

<% } // end for %>	

		 <tr class="boxhead">
		  		<td colspan="5">&nbsp;</td>
		  		<td align="right"><%=number.format(total[0])%></td>
		 </tr>

		  
</table>

<% } // end canView %>
	
	</body>
</html>
