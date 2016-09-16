<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.stmtdetails.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.bonus.chi.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusList");
	int gotStmt = 0;
	
	String specmsg = "";
	
	if (periods != null && periods.size() > 0)
	 	gotStmt = 1;
	else if (periods != null && periods.size() == 0)
	{
	 	gotStmt = 2;
	 	specmsg = "No Bonus Statement For This Member.";
 	}
 	
 	BonusPeriodBean period = (BonusPeriodBean) returnBean.getReturnObject("BonusPeriod");	
	BonusBean bean = (BonusBean) returnBean.getReturnObject("BonusStmt");
	MemberBean member = null;
	boolean canView = false;
	if (bean != null)
	{
	 	canView = true;
	 	member = bean.getMemberBean();
	} 	 	
	
	java.text.DecimalFormat dollar = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat pointvalue = new java.text.DecimalFormat("#,##0.000000");
	java.text.DecimalFormat pvpoint = new java.text.DecimalFormat("#,##0.00");
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Bonus Statement</div>
 	<form method="post" name="bonusstmt" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_ADMIN_VIEW_STMT,request)%>">
 	
 	<%@ include file="/general/mvc_return_msg.jsp"%>
 	
 	<table class="listbox" width=350>
 	 <tr>
	 	<td width="150" class="odd">Member ID</td>
	 	<td><std:memberid form="bonusstmt" name="memberid" value="<%=request.getParameter("memberid")%>" /></td>
	 	<td rowspan="2" align="center"><input type="submit" value="GO"></td>
	 </tr>	

<% if (gotStmt == 1) {%>
	 <tr>
	 	<td width="150" class="odd">Bonus Period</td>
	 	<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=request.getParameter("periodid")%>"/></td>
	 </tr> 
<% } %>
	 
	</table>
    </form>

<%=specmsg%>
    
<% if (canView) { %>    
	
	<div>
		<input class="noprint textbutton" type="button" value="Print" onclick="window.print()">
	</div>
	
	<c:if test="<%=bean.getAdjustmentRemark()!=null%>">
		<br>
		<div><font color="red"><%=bean.getAdjustmentRemark()%></font></div>
	</c:if>
	
	<br>
	
	<table class="listbox" width="500">
	     <tr class="boxhead">
		 	<td colspan=2">Distributor Information</td>
		 </tr>
	 	 <tr>
		 	<td width="150" class="odd">Distributor ID</td>
		 	<td><%=member.getMemberID()%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Name</td>
		 	<td><%=member.getName()%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Mobile Number</td>
		 	<td><%=member.getMobileNo()%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Address</td>
		 	<td><%=member.getAddress().getFullAddress()%></td>
		 </tr>	
	</table>
	<br>
	<table class="listbox" width="500">
	 	 <tr class="boxhead">
		 	<td colspan=2">Bonus Status For <%=period.getPeriodID()%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Previous Rank</td>
		 	<td align="right"><%=BonusConstants.defineRank(bean.getOldRank())%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Current Rank</td>
		 	<td align="right"><%=BonusConstants.defineRank(bean.getCurrentRank())%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Effective Rank</td>
		 	<td align="right"><%=BonusConstants.defineRank(bean.getEffRank())%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Investor Type</td>
		 	<td align="right"><%=BonusConstants.defineType(bean.getStartpack_type())%></td>
		 </tr>		 
		  <tr>
		 	<td width="150" class="odd">PPV</td>
		 	<td align="right"><%=number.format(bean.getPbv()+bean.getPbv1())%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">PGBV</td>
		 	<td align="right"><%=number.format(bean.getPgbv())%></td>
		 </tr>
		  <tr>
		 	<td width="150" class="odd">GPV</td>
		 	<td align="right"><%=number.format(bean.getGbv())%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">AGPV</td>
		 	<td align="right"><%=number.format(bean.getAgbv())%></td>
		 </tr>
	</table>
	<br>
	<table class="listbox" width="600">
	 	 <tr class="boxhead">
		 	<td colspan=3">Bonus Income Summary For <%=period.getPeriodID()%></td>
		 </tr>
		 <tr>
		 	<td colspan=3" align="center">Monthly Bonus (in PV Points)</td>
		 </tr>
		  <tr>
		 	<td class="odd">&nbsp;</td>
		 	<td align="right" class="odd">In PV</td>
		 	<td align="right" class="odd">In Rp</td>
		 </tr>
		 <tr>
		 	<td class="odd">i) Bonus Sponsor (in Rp)</td>
		 	<td align="right">&nbsp;</td>
		 	<td align="right"><%=dollar.format(bean.getBonusSponsor())%></td>
		 </tr>
		  <tr>
		 	<td class="odd">ii) Bonus Produktivitas (in PV)</td>
		 	<td align="right"><%=pvpoint.format(bean.getBonusProductivity())%></td>
		 	<td align="right"><%=dollar.format(bean.getBonusProductivity() * bean.getPayoutCurrencyRate())%></td>
		 </tr>
		 <tr>
		 	<td class="odd">iii) Bonus Penjualan Terbaik (in PV)</td>
		 	<td align="right"><%=pvpoint.format(bean.getBonusTopPbvSales()+bean.getBonusTopPgbvSales())%></td>
		 	<td align="right"><%=dollar.format((bean.getBonusTopPbvSales()+bean.getBonusTopPgbvSales()) * bean.getPayoutCurrencyRate())%></td>
		 </tr>
		 <tr>
		 	<td class="odd">iv) Bonus Matching (in PV)</td>
		 	<td align="right"><%=pvpoint.format(bean.getBonusMatching())%></td>
		 	<td align="right"><%=dollar.format(bean.getBonusMatching() * bean.getPayoutCurrencyRate())%></td>
		 </tr>
		 <tr>
		 	<td class="odd">v) Bonus Perluasan Pasar (in PV)</td>
		 	<td align="right"><%=pvpoint.format(bean.getBonusMEB())%></td>
		 	<td align="right"><%=dollar.format(bean.getBonusMEB() * bean.getPayoutCurrencyRate())%></td>
		 </tr>
		
		  <tr>
		 	<td colspan=3" align="center">Annual Bonus (in PV Points)</td>
		 </tr>
		  <tr>
		 	<td  class="odd">vi) Bonus Prestasi</td>
		 	<td align="right"><%=dollar.format(bean.getBonusPerformance())%></td>
		 	<td align="right"><%=dollar.format(bean.getBonusPerformance())%></td>
		 </tr>
		  <tr>
		 	<td  class="odd">vii) Accumulated Bonus Prestasi</td>
		 	<td align="right"><%=dollar.format(bean.getCarryForwardBonus1())%></td>
		 	<td align="right"><%=dollar.format(bean.getCarryForwardBonus1())%></td>
		 </tr>
		 <tr>
		 	<td class="odd">viii) Bonus Kepimimpinan</td>
		 	<td align="right"><%=dollar.format(bean.getBonusLeadership())%></td>
		 	<td align="right"><%=dollar.format(bean.getBonusLeadership())%></td>
		 </tr>
		 <tr>
		 	<td class="odd">ix) Accumulated Bonus Kepimimpinan</td>
		 	<td align="right"><%=dollar.format(bean.getCarryForwardBonus2())%></td>
		 	<td align="right"><%=dollar.format(bean.getCarryForwardBonus2())%></td>
		 </tr>
		 <tr>
		 	<td align="right">Total Payout </td>
		 	<td align="right">&nbsp;</td>
		 	<td align="right"><%=dollar.format(bean.getTotalBonus())%></td>
		 </tr>
		 <tr>
		 	<td align="right">Tax </td>
		 	<td align="right">&nbsp;</td>
		 	<td align="right"><%=dollar.format(bean.getTax())%></td>
		 </tr>
		 <tr>
		 	<td align="right">Admin Fee </td>
		 	<td align="right">&nbsp;</td>
		 	<td align="right"><%=dollar.format(bean.getAdminfees())%></td>
		 </tr>
		 <tr>
		 	<td align="right">Net Payout </td>
		 	<td align="right">&nbsp;</td>
		 	<td align="right"><%=dollar.format(bean.getTotalBonus()-bean.getTax() - bean.getAdminfees())%></td>
		 </tr>
	</table>
	<br>
	
	<% if (bean.getBonusSponsor() > 0.0d) { %>
	<table class="listbox" width="75%">
	     <tr class="boxhead">
		 	<td colspan="5">i) Bonus Sponsor Details</td>
		 </tr>
		 <tr class="boxhead">
		 	<td>No.</td>
		 	<td>ID</td>
		 	<td>Name</td>
		 	<td>Level</td>
		 	<td>Bonus<br>(in Rp)</td>
		 </tr>
		 
	<%
		BonusStmtDetailsBean[] dbeans = bean.getDetailsSponsor();
		double subtotal = 0.0d;
		for (int i=0;i<dbeans.length;i++) { 
			subtotal += dbeans[i].getAmount();
	%>
	 <tr class="<%=((i%2==1)?"odd":"even")%>" >
		 	<td align="left" width="25"><%=i+1%></td>
		 	<td align="left" width="75"><%=dbeans[i].getGiverID()%></td>
		 	<td align="left" ><%=dbeans[i].getGiverName()%></td>
		 	<td align="right" width="25"><%=dbeans[i].getLevel()%></td>
		 	<td align="right" width="75"><%=dollar.format(dbeans[i].getAmount())%></td>
	 </tr>	 
    <% } %>
    <tr class="boxhead">
		 	<td colspan="4" align="right">Total</td>
		 	<td align="right"><%=dollar.format(subtotal)%></td>
		 </tr>
	</table>
	<br>
	<% } %>
	
	
	<% if (bean.getBonusProductivity() > 0.0d) { %>
	<table class="listbox" width="75%">
	     <tr class="boxhead">
		 	<td colspan="2">ii) Bonus Produktivitas Details</td>
		 </tr>
		 <tr class="boxhead">
		 	<td>No.</td>
		 	<td>ID</td>
		 	<td>Name</td>
		 	<td>Level</td>
		 	<td>PV</td>
		 	<td>Rate</td>
		 	<td>Bonus<br>(in PV)</td>
		 </tr>
		 
	<%
		BonusStmtDetailsBean[] dbeans = bean.getDetailsProductivity();
		double subtotal = 0.0d;
		for (int i=0;i<dbeans.length;i++) { 
			subtotal += dbeans[i].getAmount();
			double amt = dbeans[i].getAmount();
			
		%>
		 <tr class="<%=((i%2==1)?"odd":"even")%>" >
			 	<td align="left" width="25"><%=i+1%></td>
			 	<td align="left" width="75"><%=dbeans[i].getGiverID()%></td>
			 	<td align="left" ><%=dbeans[i].getGiverName()%></td>
			 	<td align="right" width="25"><%=dbeans[i].getLevel()%></td>
			 	<td align="right" width="25"><%=pvpoint.format(dbeans[i].getBv())%></td>
			 	<td align="right" width="25"><%=number.format(dbeans[i].getRate() * 100)%>%</td>
			 	<td align="right" width="75"><%=pvpoint.format(amt)%></td>
		 </tr>	 
	    <% } %>
    	<tr class="boxhead">
		 	<td colspan="6" align="right">Total</td>
		 	<td align="right"><%=pvpoint.format(subtotal)%></td>
		 </tr>
	</table>
	<br>
	<% } %>
	
	
	<% if (bean.getBonusTopPbvSales() > 0.0d || bean.getBonusTopPgbvSales() > 0.0d) { %>
	
	<table class="listbox" width="75%">
	     <tr class="boxhead">
		 	<td colspan="4">iii) Bonus Penjualan Terbaik</td>
		 </tr>
		 <tr class="boxhead">
		 	<td>Pool</td>
		 	<td>Points</td>
		 	<td>Point<br>Value</td>
		 	<td>Bonus<br>(in PV)</td>
		 </tr>
		
	<% 	 double subtotal = 0.0d; %>
	
	<%
		BonusStmtDetailsBean[] dbeans = bean.getDetailsTopPbvSales();
		if (dbeans != null && dbeans.length > 0)  {
			subtotal += dbeans[0].getAmount();
	%>
	 <tr class="even">
		 	<td align="center">Penjualan Peribadi</td>
		 	<td align="right"><%=number.format(dbeans[0].getPoints())%></td>
		 	<td align="right"><%=pointvalue.format(dbeans[0].getPointvalue())%></td>
		 	<td align="right"><%=pvpoint.format(dbeans[0].getAmount())%></td>
	 </tr>	 
    <% } %>
    
    <%
		BonusStmtDetailsBean[] dbeans2 = bean.getDetailsTopPgbvSales();
		if (dbeans2 != null && dbeans2.length > 0)  {
			subtotal += dbeans2[0].getAmount();
	%>
	 <tr class="even">
		 	<td align="center" >Penjualan Grup Peribadi</td>
		 	<td align="right"><%=number.format(dbeans2[0].getPoints())%></td>
		 	<td align="right"><%=pointvalue.format(dbeans2[0].getPointvalue())%></td>
		 	<td align="right"><%=pvpoint.format(dbeans2[0].getAmount())%></td>
	 </tr>	 
    <% } %>
    
    <tr class="boxhead">
		 	<td colspan="3" align="right">Total</td>
		 	<td align="right"><%=pvpoint.format(subtotal)%></td>
	</tr>
	</table>
	<br>
	<% } %>
	

	<% if (bean.getBonusMatching() > 0.0d) { %>
	<table class="listbox" width="75%">
	     <tr class="boxhead">
		 	<td colspan="5">iv) Bonus Matching Details</td>
		 </tr>
		 <tr class="boxhead">
		 	<td>No.</td>
		 	<td>ID</td>
		 	<td>Name</td>
		 	<td>Level</td>
		 	<td>Bonus<br>(in PV)</td>
		 </tr>
		 
	<%
		BonusStmtDetailsBean[] dbeans = bean.getDetailsMatching();
		double subtotal = 0.0d;
		for (int i=0;i<dbeans.length;i++) { 
			subtotal += dbeans[i].getAmount();
	%>
	 <tr class="<%=((i%2==1)?"odd":"even")%>" >
		 	<td align="left" width="25"><%=i+1%></td>
		 	<td align="left" width="75"><%=dbeans[i].getGiverID()%></td>
		 	<td align="left" ><%=dbeans[i].getGiverName()%></td>
		 	<td align="right" width="25"><%=dbeans[i].getLevel()%></td>
		 	<td align="right" width="75"><%=pvpoint.format(dbeans[i].getAmount())%></td>
	 </tr>	 
    <% } %>
    <tr class="boxhead">
		 	<td colspan="4" align="right">Total</td>
		 	<td align="right"><%=pvpoint.format(subtotal)%></td>
		 </tr>
	</table>
	<br>
	<% } %>
	
	<% if (bean.getBonusMEB() > 0.0d) { %>
	<table class="listbox" width="75%">
	     <tr class="boxhead">
		 	<td colspan="5">v) Bonus Perluasan Pasar Details</td>
		 </tr>
		 <tr class="boxhead">
		 	<td>No.</td>
		 	<td>ID</td>
		 	<td>Name</td>
		 	<td>Level</td>
		 	<td>Points</td>
		 </tr>
		 
	<%
		BonusStmtDetailsBean[] dbeans = bean.getDetailsMEB();
		double subtotal = 0.0d;
		for (int i=0;i<dbeans.length;i++) { 
			subtotal += dbeans[i].getAmount();
			
			if (dbeans[i].getDetailsType() == BonusStmtDetailsBean.TYPE_DISTRIBUTE) {
	%>
	 <tr class="<%=((i%2==1)?"odd":"even")%>" >
		 	<td align="left" width="25"><%=i+1%></td>
		 	<td align="left" width="75"><%=dbeans[i].getGiverID()%></td>
		 	<td align="left" ><%=dbeans[i].getGiverName()%></td>
		 	<td align="right" width="25"><%=dbeans[i].getLevel()%></td>
		 	<td align="right" width="75"><%=pvpoint.format(dbeans[i].getAmount())%></td>
	 </tr>	 
    <% } else if (dbeans[i].getDetailsType() == BonusStmtDetailsBean.TYPE_POINTVALUE) { %>
    <tr class="boxhead">
        <td align="right" colspan="4">Total Points</td>
    	<td align="right"><%=pvpoint.format(dbeans[i].getPoints())%></td>
    <tr>
    <tr class="boxhead">
        <td align="right" colspan="4">Point Value</td>
    	<td align="right"><%=pointvalue.format(dbeans[i].getPointvalue())%></td>
    <tr>
    <tr class="boxhead">
        <td align="right" colspan="4">Total Bonus</td>
    	<td align="right"><%=dollar.format(dbeans[i].getAmount())%></td>
	</tr>
	<% } // end else if%>
	<% } // end for %>
	</table>
 	<% } // end if MEB > 0 %>
	
	<c:if test="<%=bean.getAdjustmentRemark()!=null%>">
		<br>
		<div><font color="red"><%=bean.getAdjustmentRemark()%></font></div>
	</c:if>
<% } // end canView %>
	

	</body>
</html>
