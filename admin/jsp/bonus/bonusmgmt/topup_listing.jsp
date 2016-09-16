<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.orca.bonus.chi.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BonusBean[] beans = (BonusBean[]) returnBean.getReturnObject("BonusList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusPeriodList");	
	TreeMap orderbys = (TreeMap) returnBean.getReturnObject("OrderByList");
	
	
	Integer count = (Integer)  returnBean.getReturnObject("Count");
	if (count == null) count = new Integer(0);
	
	java.text.DecimalFormat dollar = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Master Top Up Listing</div>
 	<form method="post" name="bonuslist" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_ADMIN_TOPUP_LISTING,request)%>">
 	
 	<table class="listbox" width=350>
	 <tr>
	 	<td width="100" class="odd">Bonus Period</td>
	 	<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=request.getParameter("periodid")%>"/></td>
	 </tr> 
	 <tr>
	 	<td width="100" class="odd">Order By</td>
	 	<td><std:input type="select" name="orderby" options="<%=orderbys%>" value="<%=request.getParameter("orderby")%>"/> &nbsp<input type="submit" value="GO"></td>
	 </tr> 
	</table>
    </form>

<% if (canView) { %>    

<table><tr><td>Total Records Found : <%=count.intValue()%></td></tr></table>

<table class="listbox" width="80%">
		  <tr class="boxhead">
		  		<td align="center">No.</td>
		  		<td align="center">Distr ID</td>
		  		<td align="center" width="200">Name</td>
		  		<td align="center">Old<br>Rank</td>
		  		<td align="center">Cur<br>Rank</td>
		  		<td align="center">Effv<br>Rank</td>
		  		<td align="center">Invstr<br>Type</td>
		  		<td align="center">PBV<br>
		  		<td align="center">PBV1<br>
		  		<td align="center">PGBV<br>
		  		<td align="center">GBV</br>
		  		<td align="center">AGBV</br>
				<td align="center">Highest<br>Rank in</br>Group</td>
				<td align="center">Titanium<br>Lines</td>
				<td align="center">Emperor<br>Lines</td>
		  </tr>
		  
<%		  
			for (int i=0 ; i<beans.length; i ++) {
%>
		   <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td><%=(i+1)%></td>
		  		<td><%=beans[i].getMemberID()%></td>
		  		<td><%=beans[i].getMemberName()%></td>
		  		<td align="center"><%=BonusConstants.defineShortRank(beans[i].getOldRank())%></td>
		  		<td align="center"><%=BonusConstants.defineShortRank(beans[i].getCurrentRank())%></td>
		  		<td align="center"><%=BonusConstants.defineShortRank(beans[i].getEffRank())%></td>
		  		<td align="center"><%=BonusConstants.defineShortType(beans[i].getStartpack_type())%></td>
		  		<td align="right"><%=number.format(beans[i].getPbv())%><br>
		  		<td align="right"><%=number.format(beans[i].getPbv1())%><br>
		  		<td align="right"><%=number.format(beans[i].getPgbv())%><br>
		  		<td align="right"><%=number.format(beans[i].getGbv())%></br>
		  		<td align="right"><%=number.format(beans[i].getAgbv())%></br>
				<td align="center"><%=BonusConstants.defineShortRank(beans[i].getLinetype())%></td>
				<td align="center"><%=beans[i].getTplines()%></td>
				<td align="center"><%=beans[i].getEmplines()%></td>
		  </tr>	

<% } // end for %>	
		  
</table>

<% } // end canView %>
	
	</body>
</html>
