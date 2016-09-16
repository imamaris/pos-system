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
	<div class="functionhead"><%= rptTitle %></div>
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
		  		<td align="center">Invstr<br>Type</td>
		  		<td align="center">PBV</td>
		  		<td align="center">Bank A/C</td>
		  		<td align="center">Bank Name</td>
		  		<td align="center">A/C Name</td>
		  		<td align="center">Mobile No.</td>
		  		<td align="center" nowrap>Bonus<br>Sponsor<br>(In Rp)</td>
		  		<td align="center" nowrap>Tax<br>(In Rp)</td>
		  		<td align="center" nowrap>Admin<br>Fees<br>(In Rp)</td>
		  		<td align="center" nowrap>Net<br>Payout<br>(In Rp)</td>
		  </tr>
		  
<%		  
			double[] total = new double[5];
			for (int i=0 ; i<beans.length; i ++) {
		
				double netpayout = beans[i].getTotalBonus()  - beans[i].getTax() -  beans[i].getAdminfees();
				
				total[0] += beans[i].getPbv()+beans[i].getPbv1();
				total[1] += beans[i].getBonusSponsor();
				total[2] += beans[i].getTax();
				total[3] += beans[i].getAdminfees();
				total[4] += beans[i].getTotalBonus() - beans[i].getTax() - beans[i].getAdminfees();
				
				
%>
		   <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td><%=(i+1)%></td>
		  		<td><std:link taskid="<%=BonusMasterReportManager.TASKID_ADMIN_WEEKLY_VIEW_STMT%>" text="<%=beans[i].getMemberID()%>" params="<%="memberid="+beans[i].getMemberID()+"&periodid="+periodid%>" /></td>
		  		<td><%=beans[i].getMemberName()%></td>
		  		<td align="center"><%=BonusConstants.defineShortType(beans[i].getStartpack_type())%></td>
		  		<td align="right"><%=number.format(beans[i].getPbv()+beans[i].getPbv1())%><br>
		  		<td><std:text value="<%=beans[i].getMemberBean().getPayeeBank().getBankAcctNo()%>" defaultvalue="-"/></td>
		  		<td>
		  			<%if(beans[i].getMemberBean().getPayeeBank().getBankBean()!=null){%>
			  			<std:text value="<%=beans[i].getMemberBean().getPayeeBank().getBankBean().getName()%>" defaultvalue="-"/>	
		  			<%}else{%>
		  				-
		  			<%}%>
		  		</td>
		  		<td><std:text value="<%=beans[i].getMemberBean().getPayeeBank().getBankPayeeName()%>" defaultvalue="-"/></td>
		  		<td><std:text value="<%=beans[i].getMemberBean().getMobileNo()%>" defaultvalue="-"/></td>
		  		<td align="right"><%=dollar.format(beans[i].getBonusSponsor())%></td>
		  		<td align="right" nowrap><%=dollar.format(beans[i].getTax())%></td>
		  		<td align="right" nowrap><%=dollar.format(beans[i].getAdminfees())%></td>
		  		<td align="right" nowrap><%=dollar.format(netpayout)%></td>
		  </tr>	

<% } // end for %>	

		<tr class="boxhead">
		  		<td>&nbsp;</td>
		  		<td>&nbsp;</td>
		  		<td>&nbsp;</td>
		  		<td>&nbsp;</td>
		  		<td align="right"><std:bvformater value="<%=(total[0])%>"/></td>
		  		<td>&nbsp;</td>
		  		<td>&nbsp;</td>
		  		<td>&nbsp;</td>
		  		<td>&nbsp;</td>
		  		<td align="right"><%=dollar.format(total[1])%></td>
		  		<td align="right"><%=dollar.format(total[2])%></td>
		  		<td align="right"><%=dollar.format(total[3])%></td>
		  		<td align="right"><%=dollar.format(total[4])%></td>
		  </tr>
		  
</table>

<% } // end canView %>
	
	</body>
</html>
