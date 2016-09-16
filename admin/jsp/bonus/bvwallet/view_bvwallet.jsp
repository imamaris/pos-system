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
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Voucher History by Customer</div>
 	<form method="post" name="bvwallet" action="<%=Sys.getControllerURL(BvWalletManager.TASKID_VIEW_BVWALLET,request)%>">
 	<table  class="listbox">
 	 <tr>
	 	<td width="100" class="odd" align="right">Customer ID :</td>	 	
	 	<td><std:memberid form="bvwallet" name="memberid" value="" /></td>	 	
	 </tr>	
	 <tr>
		<td  width="100" class="odd" align="right"><i18n:label code="GENERAL_FROMDATE"/> :</td>
  		<td><std:input type="date" name="fromdate" size="11" />  (yyyy-mm-dd) </td>
	</tr>
	<tr>
		<td  width="100" class="odd" align="right"><i18n:label code="GENERAL_TODATE"/> :</td>
  		<td><std:input type="date" name="todate" size="11" />  (yyyy-mm-dd) </td>
	</tr>	
	<tr>
  		<td colspan="2" align="right" ><input type="submit" value="  <i18n:label code="GENERAL_BUTTON_GO"/>  "></td>
	</tr>        
	</table>
    </form>

<% if (canView) { %>    

<table width="90%" class="listbox">
		  <tr class="boxhead">
		  		<td>No.</td>
		  		<td nowrap>Customer ID</td>
		  		<td nowrap>Name</td>
		  		<td nowrap>CRM ID</td>
		  		<td nowrap>Segmentation</td>                                
		  		<td nowrap>Trx Date</td>
		  		<td nowrap>Trx Time</td>
		  		<td>Doc Date</td>
		  		<td nowrap>Voucher No</td>
		  		<td width="100">Remark</td>
		  </tr>
		  
<%		  for (int i=0 ; i<beans.length; i ++) {
%>
		  <tr class="<%=((i%2==1)?"odd":"even")%>">
		  		<td align="center" ><%=(i+1)%></td>
		  		<td align="left" ><%=beans[i].getOwnerID()%></td>
		  		<td align="left" ><%=beans[i].getOwnerName()%></td>
		  		<td align="left" ><%=beans[i].getOwnerCRM()%></td>
                                <td align="left" ><%=beans[i].getOwnerSegmentation()%></td>
		  		<td align="center"><%=beans[i].getTrxDate()%></td>
		  		<td align="center"><%=beans[i].getTrxTime()%></td>
		  		<td align="center"><%=beans[i].getBonusDate()%></td>
		  		<td><%=beans[i].getReferenceNo() != null && beans[i].getReferenceNo().length() > 0 ? beans[i].getReferenceNo() : "" %></td>
		  		<td><%=beans[i].getRemark() != null && beans[i].getRemark().length() > 0 ? beans[i].getRemark() : ""%></td>
		  </tr>	

<% } // end for %>	
</table>

<% } // end canView %>
	
	</body>
</html>
