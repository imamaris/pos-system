<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.orca.bonus.chi.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BonusBean[] beans = (BonusBean[]) returnBean.getReturnObject("BonusList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusPeriodList");	
	String periodid = request.getParameter("periodid");
	
	String rptTitle = (String) returnBean.getReturnObject("ReportTitle");	        
        // String rptTitle = "MTC Report";
  String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
  
  int taskID = 0;
	if (task != null) 
		taskID = Integer.parseInt(task);
		 
	java.text.DecimalFormat dollar = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat pvpoint = new java.text.DecimalFormat("#,##0.00");
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><%= rptTitle %> </div>        
 	<form method="post" name="bonuslist" action="<%=Sys.getControllerURL(taskID,request)%>">
 	
 	<table class="listbox" width=350>
	 <tr>
	 	<td width="100" class="odd">Bonus Period</td>
	 	<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=periodid%>"/> &nbsp<input type="submit" value="GO"></td>
	 </tr> 
	</table>
    </form>

<% if (canView) { %>    
<table><tr><td>Total Records Found : <%=beans.length%></td></tr></table>
<table class="listbox" width="100%">
		  <tr class="boxhead">
		  		<td align="center">No.</td>
		  		<td align="center">Distr ID</td>
		  		<td align="center" width="200">Name</td>
		  		<td align="center">Old<br>Rank</td>
		  		<td align="center">Cur<br>Rank</td>
		  		<td align="center">Effv<br>Rank</td>
		  		<td align="center">Invstr<br>Type</td>
		  		<td align="center">PBV<br>
		  		<td align="center">PGBV<br>
		  		<td align="center">GBV</br>
		  		<td align="center">AGBV</br>
		  		<td align="center" nowrap>Bonus<br>Sponsor<br>(In Rp)</td>
		  		<td align="center" nowrap>Bonus<br>Produktivitas<br>(In PV)</td>
		  		<td align="center" nowrap>Bonus<br>Jualan<br>Terbaik<br>(In PV)</td>
		  		<td align="center" nowrap>Bonus<br>Matching<br>(In PV)</br>
		  		<td align="center" nowrap>Bonus<br>Luasan<br>Pasar<br>(In PV)</td>
		  		<td align="center" nowrap>Bonus<br>Prestasi<br>(In PV)</td>
		  		<td align="center" nowrap>Bonus<br>Pimpinan<br>(In PV)</td>
		  		<td align="center" nowrap>Total<br>Bonus<br>Payout<br>(In Rp)</td>
		  		<td align="center" nowrap>Tax<br>(In Rp)</td>
		  		<td align="center" nowrap>Admin<br>Fees<br>(In Rp)</td>
		  		<td align="center" nowrap>Net<br>Payout<br>(In Rp)</td>
		  		<td align="center" nowrap>Mbr<br>Reg</td>
		  </tr>
		  
<%		  
			double[] total = new double[15];
			for (int i=0 ; i<beans.length; i ++) {
		
				double netpayout = beans[i].getTotalBonus()  - beans[i].getTax() -  beans[i].getAdminfees();
				
				total[0] += beans[i].getPbv()+beans[i].getPbv1();
				total[1] += beans[i].getBonusSponsor();
				total[2] += beans[i].getBonusProductivity();
				total[3] += (beans[i].getBonusTopPbvSales()+beans[i].getBonusTopPgbvSales());
				total[4] += beans[i].getBonusMatching();
				total[5] += beans[i].getBonusMEB();
				total[6] += beans[i].getBonusLeadership();
				total[7] += beans[i].getBonusPerformance();
				total[8] += beans[i].getTotalBonus();
				total[10] += beans[i].getTax();
				total[11] += beans[i].getTotalBonus() - beans[i].getTax() - beans[i].getAdminfees();
				total[12] += beans[i].getAdminfees();
				
				int regstat = beans[i].getMemberRegStatus();
				String reg = "";
				if (regstat == 0)
					reg = "I";
				
%>
		   <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td><%=(i+1)%></td>
		  		<td><std:link taskid="<%=BonusMasterReportManager.TASKID_ADMIN_VIEW_STMT%>" text="<%=beans[i].getMemberID()%>" params="<%="memberid="+beans[i].getMemberID()+"&periodid="+periodid%>" /></td>
		  		<td><%=beans[i].getMemberName()%></td>
		  		<td align="center"><%=BonusConstants.defineShortRank(beans[i].getOldRank())%></td>
		  		<td align="center"><%=BonusConstants.defineShortRank(beans[i].getCurrentRank())%></td>
		  		<td align="center"><%=BonusConstants.defineShortRank(beans[i].getEffRank())%></td>
		  		<td align="center"><%=BonusConstants.defineShortType(beans[i].getStartpack_type())%></td>
		  		<td align="right"><%=number.format(beans[i].getPbv()+beans[i].getPbv1())%><br>
		  		<td align="right"><%=number.format(beans[i].getPgbv())%><br>
		  		<td align="right"><%=number.format(beans[i].getGbv())%></br>
		  		<td align="right"><%=number.format(beans[i].getAgbv())%></br>
		  		<td align="right"><%=dollar.format(beans[i].getBonusSponsor())%></td>
		  		<td align="right"><%=pvpoint.format(beans[i].getBonusProductivity())%></td>
		  		<td align="right"><%=pvpoint.format(beans[i].getBonusTopPbvSales()+beans[i].getBonusTopPgbvSales())%></td>
		  		<td align="right"><%=pvpoint.format(beans[i].getBonusMatching())%></br>
		  		<td align="right"><%=pvpoint.format(beans[i].getBonusMEB())%></td>
		  		<td align="right"><%=pvpoint.format(beans[i].getBonusLeadership())%></td>
		  		<td align="right"><%=pvpoint.format(beans[i].getBonusPerformance())%></td>
		  		<td align="right"><%=dollar.format(beans[i].getTotalBonus())%></td>
		  		<td align="right" nowrap><%=dollar.format(beans[i].getTax())%></td>
		  		<td align="right" nowrap><%=dollar.format(beans[i].getAdminfees())%></td>
		  		<td align="right" nowrap><%=dollar.format(netpayout)%></td>
		  		<td align="center"><%=reg%></td>
		  </tr>	

<% } // end for %>	

		<tr class="boxhead">
		  		<td>&nbsp;</td>
		  		<td>&nbsp;</td>
		  		<td>&nbsp;</td>
		  		<td align="center">&nbsp;</td>
		  		<td align="center">&nbsp;</td>
		  		<td align="center">&nbsp;</td>
		  		<td align="center">&nbsp;</td>
		  		<td align="right">&nbsp;<br>
		  		<td align="right">&nbsp;<br>
		  		<td align="right">&nbsp;</br>
		  		<td align="right">&nbsp;</br>
		  		<td align="right"><%=dollar.format(total[1])%></td>
		  		<td align="right"><%=pvpoint.format(total[2])%></td>
		  		<td align="right"><%=pvpoint.format(total[3])%></td>
		  		<td align="right"><%=pvpoint.format(total[4])%></br>
		  		<td align="right"><%=pvpoint.format(total[5])%></td>
		  		<td align="right"><%=pvpoint.format(total[6])%></td>
		  		<td align="right"><%=pvpoint.format(total[7])%></td>
		  		<td align="right"><%=dollar.format(total[8])%></td>
		  		<td align="right" nowrap><%=dollar.format(total[10])%></td>
		  		<td align="right" nowrap><%=dollar.format(total[12])%></td>
		  		<td align="right" nowrap><%=dollar.format(total[11])%></td>
		  		<td align="right">&nbsp;</br>
		  </tr>
		  
</table>

<% } // end canView %>
	
	</body>
</html>
