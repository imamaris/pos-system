<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.orca.network.sponsortree.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BonusMasterBean[] beans = (BonusMasterBean[]) returnBean.getReturnObject("BonusList");
                
	boolean canView = false;
	boolean showTotal = false;
        
        if (beans != null && beans.length > 0)
	 	canView = true;
	 	showTotal = true;
	                                        
	String periodid = request.getParameter("periodid");
	String parent = request.getParameter("parent");
        String city = request.getParameter("city");
        
        TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusPeriodList");
	TreeMap parents = (TreeMap) returnBean.getReturnObject("ParentLocationList");
        TreeMap citys = (TreeMap) returnBean.getReturnObject("LocationList");        
        
	int ntwkLevelSel = 5;
	int viewTypeSel = 1;
	String ntwkLevel = request.getParameter("NtwkLevel");
	if (ntwkLevel != null)
		ntwkLevelSel = Integer.parseInt(ntwkLevel);
	
	java.text.DecimalFormat dollar = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Group Network Analysis</div>
 	<form method="post" name="network" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_ADMIN_REPORT_GROUPNETWORKANALYSIS,request)%>">
 	
 	<table class="listbox" width=450>
 	 <tr>
	 	<td width="200" class="odd">Member ID</td>
	 	<td><std:memberid form="network" name="memberid" value="<%=request.getParameter("memberid")%>" /></td>	 	
	 </tr>	
	  <tr>
	 	<td width="200" class="odd">Bonus Period</td>
	 	<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=periodid%>"/></td>
	 </tr> 
	 <tr>
			<td width="200" class="odd"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.NETWORK_LEVEL%>"/>:</td>
	         <td>
	    	         <select name="NtwkLevel">
					<%
							String selected = "";
							for (int i=1; i<=SponsorTreeManager.MAX_NTWKLEVEL; i++) {
								selected = (i == ntwkLevelSel) ? "selected" : "";
					%>
					<option value="<%= i %>" <%= selected %>><%= i %></option>				
					<% } %>   
        		    </select>
			</td>
	 </tr>
	  <tr>
	 	<td width="200" class="odd">State (Sta)</td>
	 	<td><std:input type="select" name="parent" options="<%=parents%>" value="<%=parent%>"/></td>
	 </tr> 
	  <tr>
	 	<td width="200" class="odd">City (Loc)</td>
	 	<td><std:input type="select" name="city" options="<%=citys%>" value="<%=city%>"/> 
                <td rowspan="2" align="center"><input type="submit" value="GO"></td>
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
    
<% if (canView) { %>    

<table>

<%
	int curLevel=0, topLevel=0; 
	String text="", mLink="", iLink="", status="", kota="";
	String[] leftSide = new String[100];
	
	for (int i=0; i<beans.length; i++) {
		
		if (i==0) topLevel = beans[i].getIntroducerLevel();
		curLevel = beans[i].getIntroducerLevel() - topLevel;

		if (curLevel > ntwkLevelSel)
		 	      continue;

		if (curLevel > 0)	
			leftSide[curLevel-1] = "<img src='"+Sys.getWebapp()+ "/img/tree/" + (beans[i].isLastNode() ? "ftv2lastnode.gif" : "ftv2mnode.gif") +"' width=16 height=22>";

		
			String mref = "";
			String iref = "";
		// Introducer
		if (beans[i].getIntroducerID() != SystemConstant.ROOTNODE) {
			if (curLevel == 0) {
					iLink = " | Upline - <a href='"+Sys.getControllerURL(BonusMasterReportManager.TASKID_ADMIN_REPORT_GROUPNETWORKANALYSIS,request)+"&memberid="+beans[i].getIntroducerID()+"&periodid="+periodid+"&NtwkLevel="+ntwkLevelSel+"'>"+beans[i].getIntroducerID()+"</a>";
			} else {
					iLink = " | Upline - " + beans[i].getIntroducerID(); 
		    }
		} else {
			iLink = " ";
		}
	  
		mLink = " <font color='blue'>"+" <a href='"+Sys.getControllerURL(BonusMasterReportManager.TASKID_ADMIN_REPORT_GROUPNETWORKANALYSIS,request)+"&memberid="+beans[i].getMemberID()+"&periodid="+periodid+"&NtwkLevel="+ntwkLevelSel+"'>"+beans[i].getMemberID()+"</a></font>&nbsp;"+beans[i].getMemberName()+" | Sta - "+beans[i].getStateID()+" | Loc - "+beans[i].getLocID();		
		status = " | Rank - "+BonusMasterConstants.defineShortRank(beans[i].getCurrentRank())+"  EFF Rank - "+BonusMasterConstants.defineShortRank(beans[i].getEffRank())
			   +" PS - "+number.format(beans[i].getPbv())+" PS1 - "+number.format(beans[i].getPbv1())+" IPGS - "+number.format(beans[i].getPgbv())+" GS - "+number.format(beans[i].getGbv())
			   +" AGS - "+number.format(beans[i].getAgbv());
		
		
		text = " L" + curLevel + " " + mLink + iLink + status;
                
%>

	<tr>
	  <td nowrap>
			<% // left side image
				for (int j=0; j< curLevel; j++) out.print(leftSide[j]); 
				
				if (beans[i].getPbv()+beans[i].getPbv1() > 0.0) {
			%>
			<img src="<%= Sys.getWebapp()%>/img/tree/active.gif"><%= text %>
			<% } else { %>
			<img src="<%= Sys.getWebapp()%>/img/tree/dormant.gif"><%= text %>
			<% } %>
		</td>
	</tr>
	
<% 
		if (curLevel > 0)
			leftSide[curLevel-1] = "<img src='" + Sys.getWebapp() + "/img/tree/"+ (beans[i].isLastNode()? "ftv2blank.gif" : "ftv2vertline.gif") +"' width=16 height=22>";
	} // end for loop
%>
			
</table>


<% } // end canView %>
	
	</body>
</html>
