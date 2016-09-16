<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.orca.network.sponsortree.*"%>
<%@ page import="java.util.*"%>

<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>



<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BonusMasterBean[] beans = (BonusMasterBean[]) returnBean.getReturnObject("BonusList");
                	                                        
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
        
        boolean canView = beans != null;
%> 

<html>
<head>
<title></title>

	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
    
  	function doSubmit(thisform) {
			
    	thisform.submit();
  	}      	 
	</script>           
                
</head>

	<body>
	<div class="functionhead">Group Network Analysis (Tabulasi)</div>
        
 	<form name="network" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_ADMIN_REPORT_GROUPNETWORKANALYSIS_TAB,request)%>" method="post" onSubmit="return doSubmit(document.network);">
 	
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
         <std:input type="hidden" name="maxlevel" value="<%= ntwkLevelSel %>"/> 
         
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
    
<% if (canView) { %>    

<table class="listbox" width="100%">
		  <tr class="boxhead">
		  		<td align="center">Level</td>
		  		<td align="center">Distr ID</td>
		  		<td align="center">Name</td>
		  		<td align="center">Stat</td>
		  		<td align="center">Loc</td>     
		  		<td align="center">Upline</td>                                     
                                <td align="center">CurrRank</td>
                                <td align="center">EffRank</td>
                                <td align="center">TuPo</td>
                                <td align="center">PBV<br>
		  		<td align="center">APBV</br>
		  		<td align="center">PGBV<br>
		  		<td align="center">GBV</br>
		  		<td align="center">AGBV</br>
		  </tr>
		  
<%		  
		       int curLevel=0, topLevel=0; 
                       String tuPo = "";
                       
                       for (int i=0 ; i<beans.length; i ++) {
                            	 if (i==0) topLevel = beans[i].getIntroducerLevel();
		                    curLevel = beans[i].getIntroducerLevel() - topLevel;
                                 
                                 if (beans[i].getEffRank()>30){
                                     if (beans[i].getEffRank() < beans[i].getCurrentRank()){
                                        tuPo = "Not OK";
                                     } else {    
                                        tuPo = "OK";
                                     }
                                 } else {
                                     tuPo = "-";
                                 }
                                    
                                 if (curLevel > ntwkLevelSel)
		 	             continue;
%>
		   <tr class="<%=((i%2==1)?"odd":"even")%>" >
                                <td align="center" nowrap>L-<%=number.format(curLevel)%><br>
		  		<td align="center" nowrap><%=beans[i].getMemberID()%></td>
		  		<td align="left" nowrap><%=beans[i].getMemberName()%></td>
		  		<td align="center" nowrap><%=beans[i].getStateID()%></td>
		  		<td align="center" nowrap><%=beans[i].getLocID()%></td>
		  		<td align="center" nowrap><%=beans[i].getIntroducerID()%></td>
                                <td align="center" nowrap><%=BonusMasterConstants.defineShortRank(beans[i].getCurrentRank())%></td>
                                <td align="center" nowrap><%=BonusMasterConstants.defineShortRank(beans[i].getEffRank())%></td>
                                <td align="center" nowrap><%=tuPo%><br>                                
		  		<td align="right" nowrap><%=number.format(beans[i].getPbv())%><br>
		  		<td align="right" nowrap><%=number.format(beans[i].getApbv())%></br>
		  		<td align="right" nowrap><%=number.format(beans[i].getPgbv())%><br>
		  		<td align="right" nowrap><%=number.format(beans[i].getGbv())%></br>
		  		<td align="right" nowrap><%=number.format(beans[i].getAgbv())%></br>
		  </tr>	
		    
	<% 
		} // end for 
	%>
			
</table> 

<% } // end canView %>
	
	</body>
</html>
