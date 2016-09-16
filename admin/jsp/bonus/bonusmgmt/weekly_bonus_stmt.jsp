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
	<div class="functionhead">Weekly Bonus Statement</div>
 	<form method="post" name="bonusstmt" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_ADMIN_WEEKLY_VIEW_STMT,request)%>">
 	
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
		 	<td width="350"><%=member.getMemberID()%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Name</td>
		 	<td width="350"><%=member.getName()%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Mobile Number</td>
		 	<td width="350"><%=member.getMobileNo()%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Address</td>
		 	<td width="350"><%=member.getAddress().getFullAddress()%></td>
		 </tr>	
	</table>
	<br>
	<table class="listbox" width="500">
	 	 <tr class="boxhead">
		 	<td colspan=2">Bonus Status For <%= (period.getPeriodID() +" ("+period.getStartDate()+" - "+period.getEndDate()+")") %></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Investor Type</td>
		 	<td width="350" align="right"><%=BonusConstants.defineType(bean.getStartpack_type())%></td>
		 </tr>		 
		  <tr>
		 	<td width="150" class="odd">PBV</td>
		 	<td width="350" align="right"><%=number.format(bean.getPbv()+bean.getPbv1())%></td>
		 </tr>
	</table>
	<br>
	<table class="listbox" width="500">
	 	 <tr class="boxhead">
		 	<td colspan=2">Bonus Summary</td>
		 </tr>
		 <tr>
		 	<td colspan=2" align="center">Weekly Bonus</td>
		 </tr>
		  <tr>
		 	<td class="odd">&nbsp;</td>
		 	<td align="right" class="odd">In Rp</td>
		 </tr>
		 <tr>
		 	<td class="odd">i) Bonus Sponsor (in Rp)</td>
		 	<td align="right"><%=dollar.format(bean.getBonusSponsor())%></td>
		 </tr>
		 <tr>
		 	<td align="right">Tax </td>
		 	<td align="right"><%=dollar.format(bean.getTax())%></td>
		 </tr>
		 <tr>
		 	<td align="right">Admin Fees </td>
		 	<td align="right"><%=dollar.format(bean.getAdminfees())%></td>
		 </tr>
		 <tr>
		 	<td align="right">Net Payout </td>
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

	<c:if test="<%=bean.getAdjustmentRemark()!=null%>">
		<br>
		<div><font color="red"><%=bean.getAdjustmentRemark()%></font></div>
	</c:if>
<% } // end canView %>
	

	</body>
</html>
