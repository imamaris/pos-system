<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.network.sponsortree.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
	int memberIDLength = 12;
	
	int ntwkLevelSel = 5;
	int viewTypeSel = 1;
        StringBuffer sbParam = new StringBuffer(100);
  
	String memberID = request.getParameter("MemberID");
	String ntwkLevel = request.getParameter("NtwkLevel");
        String viewType = request.getParameter("ViewType");
		
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  SponsorTreeStructure network = (SponsorTreeStructure) returnBean.getReturnObject(SponsorTreeManager.RETURN_SPONSORNTWK_CODE);
  
  String hiddenBean = (String) returnBean.getReturnObject("HiddenBean");
  boolean isHidden = hiddenBean != null && hiddenBean.equalsIgnoreCase("Y");
  
  if (ntwkLevel != null)
		ntwkLevelSel = Integer.parseInt(ntwkLevel);

  if (viewType != null)
		viewTypeSel = Integer.parseInt(viewType);
		
  boolean hasParam = !isHidden && memberID != null && memberID.length() > 0;
  boolean canView = network != null && network.getRoot() != null && network.getNetworkSize() > 0;
  
  if (canView) {
	  sbParam.append("&NtwkLevel="+ ntwkLevel)
	  	.append("&ViewType="+ viewType)
	  	.append("&").append(AppConstant.RETURN_SUBMIT_CODE).append("=true");
 	}
%>

<html>
<head>
  <title></title>

	<%@ include file="/lib/header.jsp"%>
	  
  <script language="javascript">
  
		function doSubmit(thisform) {
			
	  	if (!validateMemberId(thisform.MemberID)) {
				alert("<i18n:label code="MSG_INVALID_MEMBERID"/>");
				focusAndSelect(thisform.MemberID);
				return;
	  	}
	  	    		
	  	thisform.submit();
		} 
	
  </script>	
</head>

<body>

<div class="functionhead">
<i18n:label localeRef="mylocale" code="<%=MemberMessageTag.NETWORK_DIAGRAM%>"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(SponsorTreeManager.TASKID_NETWORK_DIAGRAM,request)%>" method="post">

	<table class="noprint" width="100%" border="0">
	  <tr>
	  	<td>
	  		<table class="noprint">
	  			<tr>
						<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
				    <td><std:memberid name="MemberID" form="frmSearch"/></td>
					</tr>
					<tr>
						<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.NETWORK_LEVEL%>"/>:</td>
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
						<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.VIEW_TYPE%>"/>:</td>
				    <td>
				    	<select name="ViewType">
								<option value="1" <%= viewTypeSel == 1 ? "selected" : "" %>><i18n:label code="DISTRIBUTOR_TREEVIEW_EXPLORER"/></option>
								<option value="2" <%= viewTypeSel == 2 ? "selected" : "" %>><i18n:label code="DISTRIBUTOR_TREEVIEW_TEXT"/></option>
			        </select>
						</td>
					</tr>
	  		</table>
	  	</td>
	  	<td/>
	  </tr>
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
</form>

<hr class=noprint>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<%
	if (canView) {

		String[] leftSide = new String[200];
		for (int i=0; i<leftSide.length; i++) {
			
		  if (viewTypeSel == 1) {
		 		leftSide[i] = "<img src='" + Sys.getWebapp() + "/img/tree/ftv2blank.gif' width=16 height=22>";
			} else {
				leftSide[i] = "";
			}
		} // end for
%>

<div>
	<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
</div>

<br>

<table>

<%
	int curLevel=0, topLevel=0; 
	String text="", mLink="", iLink="", directLinesText="", downlinesText="";
	
	MemberBean member = null;
	MemberBean parent = null;
    SponsorTreeStructure nodeNetwork = null;
  
	SponsorTreeNodeBean[] nodes = (SponsorTreeNodeBean[]) network.getNetworkNodes();
	
	for (int i=0; i<nodes.length; i++) {
		parent = nodes[i].getParent();
		member = nodes[i].getMember();
		nodeNetwork = nodes[i].getNetwork();
		
		if (i==0) topLevel = nodes[i].getLevel();
		
		curLevel = nodes[i].getLevel() - topLevel;

		if (curLevel > ntwkLevelSel)
			continue;

		if (curLevel >0) {		
			if (viewTypeSel == 1) {
				leftSide[curLevel-1] = "<img src='"+Sys.getWebapp()+ "/img/tree/" + (nodes[i].isLastLevelNode() ? "ftv2lastnode.gif" : "ftv2mnode.gif") +"' width=16 height=22>";
		 	}	else {
			 	leftSide[curLevel-1] = "";
			}
		}
		
		// Introducer
		iLink = " ";
		
		if (parent != null) {

			if (curLevel == 0) {
				iLink = " / " + lang.display("DISTRIBUTOR_UPLINE") + " - <a href='"+Sys.getControllerURL(SponsorTreeManager.TASKID_NETWORK_DIAGRAM,request)+ sbParam.toString() + "&MemberID="+parent.getMemberID()+"'>"+parent.getMemberID()+"</a> " + parent.getName();
			} else {
				iLink = " / " + lang.display("DISTRIBUTOR_UPLINE") + " - " + parent.getMemberID() + " " + parent.getName(); 
			}
							
			if (parent.isHidden() && !member.isHidden()) {
				iLink = " ";
			}
			
		}
		
		boolean isStrike = false;
		if(member != null && member.getStatus() == MemberManager.MBRSHIP_TERMINATED)
			isStrike = true;
		
		// Member
		if (member != null) 
			mLink = "<font color='blue'><a href='"+Sys.getControllerURL(SponsorTreeManager.TASKID_NETWORK_DIAGRAM,request)+ sbParam.toString() + "&MemberID="+nodes[i].getMemberID()+"'>" + ((isStrike)?"<strike>":"") + nodes[i].getMemberID()  +"</a> " +  member.getName() + ((isStrike)?"</strike>":"") + "</font>"; 
		else
			mLink = "<font color='blue'>" + lang.display("GENERAL_UNKNOWN") + "</font>";
		
		// Analysis
		int directLines = 0;
		int downlines = 0;
		int activedownlines = 0;
		
		if (nodeNetwork != null) {
			directLines = nodeNetwork.getDirectLines();
			downlines = nodeNetwork.getDownlines();
			activedownlines = nodeNetwork.getActiveDownlines();
		} 
		
		directLinesText = " / " + "<font color='#800000'>" + lang.display("DISTRIBUTOR_DIRECT_DOWNLINES") + " - " + directLines + "</font>";
		downlinesText = " / " + "<font color='#008000'>" + lang.display("DISTRIBUTOR_DOWNLINES") + " - " + ((activedownlines == 0)?0:(activedownlines - 1)) + "</font>";
		
		text = " L" + curLevel + " " + mLink + iLink + directLinesText + downlinesText;
%>

	<tr>
	  <td nowrap>
			<% // left side image
				 for (int j=0; j< curLevel; j++) out.print(leftSide[j]); 
			%>
			 
			<% 
				if (member.getStatus() == MemberManager.MBRSHIP_ACTIVE) { 
			%>
			
			<% 
					if (viewTypeSel == 1) { 
			%>
			<img src="<%= Sys.getWebapp() %>/img/tree/active.gif"><%= text %>
  		<% 
  				} else { 
	  	%>
  		<%= text %>
  		<% 
  				} // end if
				}	else {
  		%>

  		<% 
  				if (viewTypeSel == 1) { 
	  	%>
			<img src="<%= Sys.getWebapp() %>/img/tree/dormant.gif"><%= text %>
  		<% 
  				} else {
	  	%>
  		<%= text %>
	  	<% 
  				}
	  		} // end status
	  	%>
		</td>
	</tr>
	
<% 
		if (curLevel >0) {	
			if (viewTypeSel == 1) {
				leftSide[curLevel-1] = "<img src='" + Sys.getWebapp() + "/img/tree/"+ (nodes[i].isLastLevelNode()? "ftv2blank.gif" : "ftv2vertline.gif") +"' width=16 height=22>";
			} else {
			  leftSide[curLevel-1] = "";
			}
		}
		
	} // end for loop
%>
			
</table>

<%
	} // end canView
%>

<%
	if (!canView && hasParam) {
%>
	<p><i18n:label code="MSG_NO_RECORDFOUND"/></p>
<%
	}
%>

</body>
</html>    