<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@page import="com.ecosmosis.orca.bonus.chi.BonusConstants"%>
<html>
<head>
  <title></title>

	<%@ include file="/lib/header.jsp"%>
	<%@ include file="/lib/select_locations.jsp"%>

<%
	int size = 40;
	int memberIDLength = 12;
	
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  MemberBean bean = (MemberBean) returnBean.getReturnObject(MemberManager.RETURN_MBRBEAN_CODE);
  double[] values = ((double[]) returnBean.getReturnObject(MemberManager.RETURN_MBRBONUS_MAINT_CODE));
  Map rankings = (Map) returnBean.getReturnObject(MemberManager.RETURN_MBRRANKS_CODE);
  
  boolean canView = bean != null && !bean.isHidden();
%>	  
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

	function isInteger(val){
		if(val==null){return false;}
		if (val.length==0){return false;}
		for (var i = 0; i < val.length; i++) {
			var ch = val.charAt(i)
			if (i == 0) {
				continue;
			}
	
			if (ch < "0" || ch > "9") {
				return false;
			}
		}
		return true;
	}		

  function doSubmit(thisform) {
	
	var rank = thisform.Rank.value*1;
	var newrank = thisform.NewRank.value*1;
	
	if(!isInteger(thisform.MINPBV.value)){
			
		alert('<i18n:label code="MSG_QTY_POSITIVE_INTEGER"/>');	
		thisform.MINPBV.focus();		
		return false;
	}
	if(!isInteger(thisform.MINPGBV.value)){
		
		alert('<i18n:label code="MSG_QTY_POSITIVE_INTEGER"/>');	
		thisform.MINPGBV.focus();		
		return false;
	}
	
	if(rank > newrank)	
		return confirm('<i18n:label code="MSG_CONFIRM_DOWNGRADE_DISTR"/>');
	
	else if(rank == newrank){
		
		alert('<i18n:label code="MSG_NEWRANK_SAME"/>')
		return false;
	}
	else{		
  	    return confirm('<i18n:label code="MSG_PROCEED_CHANGE"/>');
  	}
  }	
  </script>	
</head>

<body onLoad="document.frmSearch.MemberID.focus();">

<div class="functionhead"><i18n:label code="DISTRIBUTOR_SET_RANK"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(MemberManager.TASKID_CHANGE_RANKING, request)%>" method="post" onSubmit="return doSearch(document.frmSearch);">

	<table class="noprint">
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    <td><std:memberid name="MemberID" form="frmSearch"/></td>
		</tr>
	</table>
	
	<br>

	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" >
</form>

<hr class=noprint>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<% 
	if (canView) {
%>

<form name="frmEdit"  action="<%=Sys.getControllerURL(MemberManager.TASKID_CHANGE_RANKING_SUBMIT, request)%>" method="post" onSubmit="return doSubmit(document.frmEdit);">
	<table class="tbldata" width="100%">
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="DISTRIBUTOR_INFO"/></td>
  	</tr>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    	<td>
	    	<%= bean.getMemberID() %>
	    	<input type=hidden name="MemberID" value="<%= bean.getMemberID() %>" >
	    	</td>
		</tr>
		<tr valign="top">
			<td align="right" width="180"><i18n:label code="GENERAL_NAME"/>:</td>
			<td><std:text value="<%= bean.getName() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_TYPE%>"/>:</td>
			<td><%= MemberManager.defineMbrType(bean.getType()) %></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/>:</td>
			<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getJoinDate() %>" /></td>
		</tr>

		<tr>
			<td align="right" width="180"><i18n:label code="DISTRIBUTOR_UPLINE_ID"/>:</td>
			<td><std:text value="<%= bean.getIntroducerID() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_PLACEMENT_ID"/>:</td>
			<td><std:text value="<%= bean.getPlacementID() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right">&nbsp;</td>
			<td><b>&nbsp;</b></td>
		</tr>
		<tr>
			<td align="right"><b><i18n:label code="DISTRIBUTOR_CURRENT_RANK"/>:</b></td>
			<td>
			<b><std:text value="<%= BonusConstants.defineRank(bean.getBonusRank()) %>" defaultvalue="-"/></b>
			<input type=hidden name="Rank" value="<%= bean.getBonusRank() %>" >
			</td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_NEW_RANK"/>:</td>
			<td><std:input type="select" name="NewRank" options="<%=rankings %>" value="<%=String.valueOf(bean.getBonusRank())%>" /></td>
		</tr>
		<tr>
			<td align="right"><b><i18n:label code="DISTRIBUTOR_MIN_CURRENT_PBV"/>:</b></td>
			<td>
			<b>
			<% if(values!=null && values[0] > 0){%>
			<std:bvformater value="<%= values[0] %>"></std:bvformater>
			<%}else{ %>
			-
			<%}%>
			</b>
			</td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_MIN_NEW_PBV"/>:</td>
			<td><std:input type="text" name="MINPBV" value="" /></td>
		</tr>
		<tr>
			<td align="right"><b><i18n:label code="DISTRIBUTOR_MIN_CURRENT_PGBV"/>:</b></td>
			<td>
			<b>
			<% if(values!=null && values[1] > 0){%>
			<std:bvformater  value="<%= values[1] %>"></std:bvformater>
			<%}else{ %>
			-
			<%}%>
			</b>
			</td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_MIN_NEW_PGBV"/>:</td>
			<td><std:input type="text" name="MINPGBV" value="" /></td>
		</tr>
	</table>
	
	<br>
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>"> 
</form>

<% 
	} // end canView
%>
</body>
</html>		


