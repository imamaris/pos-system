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
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
  Map mbrshipTypeMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_MBRSHIPTYPE_CODE);
  
  MemberBean bean = (MemberBean) returnBean.getReturnObject(MemberManager.RETURN_MBRBEAN_CODE);
  
  boolean canView = bean != null && !bean.isHidden();
%>

<html>
<head>
  <title></title>

	<%@ include file="/lib/header.jsp"%>
	  
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
		
		if (!validateObj(thisform.Status, 1)) {			
			alert("<i18n:label code="MSG_SELECT_STATUS"/>");
			return;
		}

		if (confirmProceed()) {
			thisform.action = "<%=Sys.getControllerURL(MemberManager.TASKID_MBRSHIP_EDIT,request)%>";		
			thisform.submit();
		}
	}
	
	function confirmProceed() {
	
		if (confirm('<i18n:label code="MSG_PROCEED_CHANGE"/>'))
	  	return true;
	  else
	    return false;    
	}
	
  </script>	
</head>

<body>

<div class="functionhead"><i18n:label code="DISTRIBUTOR_CHANGE_ACCT_STATUS"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(MemberManager.TASKID_MBRSHIP_EDIT,request)%>" method="post">

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
			<td colspan="2" class="sectionhead"><i18n:label code="DISTRIBUTOR_CURRENT_ACCT_INFO"/></td>
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
			<td align="right" width="180"><i18n:label code="GENERAL_STATUS"/>:</td>
			<td><%= MemberManager.defineMbrshipStatus(bean.getStatus()) %></td>
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
			<td align="right"><i18n:label code="GENERAL_REMARK"/>:</td>
			<td><std:text value="<%= bean.getRemark() %>" defaultvalue="-"/></td>
		</tr>
	</table>
	
	<br>
	
	<hr>
	
	<br>

	<table class="tbldata" width="100%">	
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="DISTRIBUTOR_CHANGE_ACCT_INFO"/></td>
  	</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="GENERAL_STATUS"/>:</td>
			<td><std:input type="select" name="Status" options="<%= mbrshipTypeMap %>"/></td>
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
  
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" onClick="doSubmit(document.frmEdit);"> 
</form>

<% 
	} // end canView
%>

</body>
</html>		