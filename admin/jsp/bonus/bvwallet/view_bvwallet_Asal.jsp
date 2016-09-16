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
	 	<td width="200" class="odd">Customer ID</td>	 	
	 	<td><std:memberid form="bvwallet" name="memberid" value="" /></td>	 	
	 </tr>	
	 <tr>
		<td  width="200" class="odd"><i18n:label code="GENERAL_FROMDATE"/> (<%= SystemConstant.DEFAULT_DATEFORMAT.toUpperCase() %>)</td>
  		<td><std:input type="date" name="fromdate" size="11" /></td>
	</tr>
	<tr>
		<td  width="200" class="odd"><i18n:label code="GENERAL_TODATE"/> (<%= SystemConstant.DEFAULT_DATEFORMAT.toUpperCase() %>)</td>
  		<td><std:input type="date" name="todate" size="11" /> &nbsp<input type="submit" value="<i18n:label code="GENERAL_BUTTON_GO"/>"></td>
	</tr>	 
	</table>
    </form>

<% if (canView) { %>    
<br>
<table width=400 class="listbox">
	 <tr>
	 	<td width="50" class="odd">Customer ID</td>
	 	<td><%=beans[0].getOwnerID()%></td>
	 </tr>
         <tr>
	 	<td width="50" class="odd">Name</td>
	 	<td><%=beans[0].getOwnerName()%></td>
	 </tr>	
</table>

<br>

<table width="80%" class="listbox">
		  <tr class="boxhead">
		  		<td>No.</td>
		  		<td nowrap>Trx ID</td>
		  		<td nowrap>Trx Type</td>
		  		<td nowrap>Trx Date</td>
		  		<td nowrap>Trx Time</td>
		  		<td>Bonus Date</td>
		  		<td>BV IN</td>
		  		<td>BV OUT</td>
		  		<td>BV1 IN</td>
		  		<td>BV1 OUT</td>
		  		<td nowrap>Ref No</td>
		  		<td width="100">Remark</td>
		  </tr>
		  
<%		  for (int i=0 ; i<beans.length; i ++) {
%>
		  <tr class="<%=((i%2==1)?"odd":"even")%>">
		  		<td><%=(i+1)%></td>
		  		<td><%=beans[i].getSeqID()%></td>
		  		<td><%=beans[i].getTrxType()%></td>
		  		<td align="center"><%=beans[i].getTrxDate()%></td>
		  		<td align="center"><%=beans[i].getTrxTime()%></td>
		  		<td align="center"><%=beans[i].getBonusDate()%></td>
		  		<td align="right"><std:bvformater value="<%=beans[i].getBvIn()%>"/></td>
		  		<td align="right"><std:bvformater value="<%=beans[i].getBvOut()%>"/></td>
		  		<td align="right"><std:bvformater value="<%=beans[i].getBvIn1()%>"/></td>
		  		<td align="right"><std:bvformater value="<%=beans[i].getBvOut1()%>"/></td>
		  		<td><%=beans[i].getReferenceNo() != null && beans[i].getReferenceNo().length() > 0 ? beans[i].getReferenceNo() : "" %></td>
		  		<td><%=beans[i].getRemark() != null && beans[i].getRemark().length() > 0 ? beans[i].getRemark() : ""%></td>
		  </tr>	

<% } // end for %>	
</table>

<% } // end canView %>
	
	</body>
</html>
