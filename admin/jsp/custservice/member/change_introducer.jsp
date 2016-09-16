<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	int size = 40;
	int memberIDLength = 12;
	
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  MemberBean bean = (MemberBean) returnBean.getReturnObject(MemberManager.RETURN_MBRBEAN_CODE);
  
  boolean canView = bean != null && !bean.isHidden();
  
  String chkIntrID = (String) returnBean.getReturnObject("ChkIntrID");
	String chkPlaceID = (String) returnBean.getReturnObject("ChkPlaceID");
%>

<html>
<head>
  <title></title>

	<%@ include file="/lib/header.jsp"%>
	<%@ include file="/lib/select_locations.jsp"%>
	  
  <script language="javascript">
		
  function doSearch(thisform) {
			
  	if (!validateMemberId(thisform.MemberID)) {
			alert("<i18n:label code="MSG_INVALID_MEMBERID"/>");
			focusAndSelect(thisform.MemberID);
			return false;
  	} else {
	  	return true;
  	}
	} 
		
	function doSubmit(thisform) {
		
		if (!validateMemberIntroducer(thisform.IntroducerID, null, 0)) {
			alert("<i18n:label code="MSG_ENTER_UPLINEID"/>");
			focusAndSelect(thisform.IntroducerID);
			return;
		} 
		
		if (!validateDupID(thisform.MemberID, thisform.IntroducerID)) {
			alert("<i18n:label code="MSG_UPLINE_NOTSAME_ID"/>");
			focusAndSelect(thisform.IntroducerID);
			return;
  	}
	  	
  	if (!validateMemberIntroducer(thisform.PlacementID, null, 0)) {
			alert("<i18n:label code="MSG_ENTER_PLACEMENTID"/>");
			focusAndSelect(thisform.PlacementID);
			return;
		} 
		
		if (!validateDupID(thisform.MemberID, thisform.PlacementID)) {
			alert("<i18n:label code="MSG_PLACEMENT_NOTSAME_ID"/>");
			focusAndSelect(thisform.PlacementID);
			return;
  	}
		
  	if (confirm('<i18n:label code="MSG_PROCEED_CHANGE"/>')) {
  	
  	  thisform.NewSponsorID.value = thisform.PlacementID.value;
  	  thisform.NewUplineID.value = thisform.IntroducerID.value;
  	   
			thisform.action = "<%=Sys.getControllerURL(MemberManager.TASKID_CHANGE_INTRODUCER,request)%>";		
			thisform.submit();
		}
	}
	
  </script>	
</head>

<body>

<div class="functionhead"><i18n:label code="DISTRIBUTOR_CHANGE_UPLINE"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(MemberManager.TASKID_CHANGE_INTRODUCER,request)%>" method="post">

	<table class="noprint">
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    <td><std:memberid name="MemberID" form="frmSearch"/></td>
		</tr>
	</table>
	
	<br>

	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onSubmit="return doSearch(document.frmSearch);">
</form>

<hr class=noprint>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<form name="frmEdit" action="" method="post">
	<table class="tbldata" width="100%">
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="DISTRIBUTOR_UPLINE_INFO"/></td>
  	</tr>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    <td><%= bean.getMemberID() %></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/>:</td>
			<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getJoinDate() %>" /></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_TYPE%>"/>:</td>
			<td><%= MemberManager.defineMbrType(bean.getType()) %></td>
		</tr>
		<tr valign="top">
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INDIVIDUAL%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.CORPORATION_NAME%>"/>:</td>
			<td><std:text value="<%= bean.getName() %>" defaultvalue="-"/></td>
		</tr>
		<tr valign="top">
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.:</td>
			<td><std:text value="<%= bean.getIdentityNo() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="DISTRIBUTOR_UPLINE_ID"/>:</td>
			<td><std:text value="<%= bean.getIntroducerID() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_NAME"/>:</td>
			<td><std:text value="<%= bean.getIntroducerName() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_CONTACT"/>:</td>
			<td><std:text value="<%= bean.getIntroducerContact() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_PLACEMENT_ID"/>:</td>
			<td><std:text value="<%= bean.getPlacementID() %>" defaultvalue="-"/></td>
		</tr>
	</table>
	
	<br>
	
	<hr>
	
	<br>
	
	<table class="tbldata" width="100%">	
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="DISTRIBUTOR_NEWUPLINE_INFO"/></td>
  	</tr>
		<tr>
			<td align="right" width="180"><span class="required note">* </span><i18n:label code="DISTRIBUTOR_UPLINE_ID"/>:</td>
			<td>
				<std:input type="text" name="IntroducerID" value="<%= bean.getIntroducerID() %>" size="<%= size %>" maxlength="<%= memberIDLength %>"/>
				<a href="javascript:popupSmall('<%=Sys.getControllerURL(MemberManager.TASKID_SEARCH_MEMBERS_ALL_BY,request) %>&FormName=frmEdit&ObjName=IntroducerID')">
					<img border="0" alt='Search Upline' src="<%= Sys.getWebapp() %>/img/lookup.gif"/>
				</a>
			</td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_NAME"/>:</td>
			<td><std:input type="text" name="IntroducerName" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_CONTACT"/>:</td>
			<td><std:input type="text" name="IntroducerContact" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label code="DISTRIBUTOR_PLACEMENT_ID"/>:</td>
			<td>
				<std:input type="text" name="PlacementID" value="<%= bean.getPlacementID() %>" size="<%= size %>" maxlength="<%= memberIDLength %>"/>
				<a href="javascript:popupSmall('<%=Sys.getControllerURL(MemberManager.TASKID_SEARCH_MEMBERS_ALL_BY,request) %>&FormName=frmEdit&ObjName=PlacementID')">
  				<img border="0" alt='Search Sponsor' src="<%= Sys.getWebapp() %>/img/lookup.gif"/>
  			</a>
  		</td>
		</tr>
		<tr>
			<td colspan="2">&nbsp</td>
		</tr>
		<tr valign="top">
			<td align="right" width="180"><i18n:label code="GENERAL_REMARK"/>:</td>
			<td><textarea name="Remark" rows="5" cols="50"><%= (bean.getRemark() != null) ? bean.getRemark().replaceAll("<br>","\n") : "" %></textarea></td>
		</tr>
	</table>
  
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="MemberID" value="<%= bean.getMemberID() %>"/> 
  
  <input type="hidden" name="ChkIntrID" value="<%= chkIntrID %>">
	<input type="hidden" name="ChkPlaceID" value="<%= chkPlaceID %>">
	
  <input type="hidden" name="OldSponsorID" value="<%= bean.getPlacementID() %>">
	<input type="hidden" name="OldUplineID" value="<%= bean.getIntroducerID() %>">
	<input type="hidden" name="NewSponsorID" value="">
	<input type="hidden" name="NewUplineID" value="">
	
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" onClick="doSubmit(this.form);"> 
</form>

<% 
	} // end canView
%>

</body>
</html>		