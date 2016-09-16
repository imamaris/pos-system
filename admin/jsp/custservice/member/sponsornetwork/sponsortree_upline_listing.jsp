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
	
	String memberID = request.getParameter("MemberID");
	
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  SponsorTreeStructure network = (SponsorTreeStructure) returnBean.getReturnObject(SponsorTreeManager.RETURN_SPONSORNTWK_CODE);
  
  String hiddenBean = (String) returnBean.getReturnObject("HiddenBean");
  boolean isHidden = hiddenBean != null && hiddenBean.equalsIgnoreCase("Y");
  
  boolean hasParam = !isHidden && memberID != null && memberID.length() > 0;
  boolean canView = network != null && network.getRoot() != null && network.getUplineLevels() > 1;
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

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.UPLINE_LISTING%>"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(SponsorTreeManager.TASKID_UPLINE_LISTING,request)%>" method="post">

	<table class="noprint">
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    <td><std:memberid name="MemberID" form="frmSearch"/></td>
		</tr>
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	
	<input class="textbutton noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
</form>

<hr class=noprint>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) { 
  	
		MemberBean root = network.getRoot().getMember();
%>  
 
<b><u><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DIST_INFO%>"/></u></b>
<table>
  <tr>
    <td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/></td>
    <td>:</td>
    <td><%=  root.getMemberID() %></td>
  </tr>
  <tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/></td>
		<td>:</td>
    <td><%= (root.getJoinDate() != null) ? Sys.getDateFormater().format(root.getJoinDate()): "" %></td>
	</tr>
  <tr>
    <td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
    <td>:</td>
    <td><%= root.getName() %></td>
  </tr>
  <tr>
    <td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.</td>
    <td>:</td>
    <td><%= root.getIdentityNo() %></td>
  </tr>
  <tr valign="top">
    <td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CONTACT_INFORMATION%>"/></td>
    <td>:</td>
    <td><%= (root.getContactInfo() != null) ? root.getContactInfo().replaceAll("\n", "<br>") : "-" %></td>
  </tr>
  <tr valign="top">
  	<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TOTAL_UPLINES%>"/></td>
    <td>:</td>
    <td><%= network.getUplines() - 1 %></td>
	</tr>
</table>

<br>

<div>
	<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
</div>

<br>
  
<table border="0" width="800">
	<tr class="boxhead" valign=top>
		<td width="5%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
	  <td width="13%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/></td>
	  <td width="30%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
	  <td width="20%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CONTACT_INFORMATION%>"/></td>
	  <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/></td>
	  <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP%>"/></td>
	</tr>

<%
	ArrayList list = network.getUplineLevelList();
	for (int i=0; i<list.size() ; i++) {
		
		SponsorTreeNodeBean[] nodes = (SponsorTreeNodeBean[]) list.get(i);
		
		if (i == list.size() - 1)
			break;
%>

	<tr>
		<td colspan="6">&nbsp;</td>
	</tr>
	<tr class="boxhead">
		<td colspan="6" align="left"><font color="blue"><b><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.LEVEL%>"/> (<%= i+1 %>)</b></font></td>
	</tr>
		
<%
		for (int j=0; j<nodes.length ; j++) {
						
			MemberBean member = nodes[j].getMember();	
			
			String rowCss = "";
			
			if((j+1) % 2 == 0)
      	rowCss = "even";
      else
        rowCss = "odd";

      if (member.getStatus() != MemberManager.MBRSHIP_ACTIVE)
        rowCss = "alert";
%>

	<tr class="<%= rowCss %>" valign=top>
	  <td nowrap><%= j+1 %>.</td>
	  <td nowrap><%= member.getMemberID() %></td>
	  <td><%= member.getName() %></td>
	  <td nowrap><%= member.getContactInfo() != null ? member.getContactInfo().replace("\n", "<br>") : "-" %></td>
	  <td align="center" nowrap><%= (member.getJoinDate() != null) ? Sys.getDateFormater().format(member.getJoinDate()): "" %></td>
	  <td align="center" nowrap><%= MemberManager.defineMbrshipStatus(member.getStatus()) %></td>
	</tr>
	
<%
		} // end for
%>

<%
	} // end for level
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
