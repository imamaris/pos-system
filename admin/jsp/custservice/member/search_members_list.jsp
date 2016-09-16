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
	int memberIDLength = 12;
	
	String editURL = Sys.getControllerURL(MemberManager.TASKID_BASIC_EDIT_MEMBER, request);

	MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	Map mbrshipTypeMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_MBRSHIPTYPE_CODE);
        
	Map RegisterTypeMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_REGISTRATION_CODE);
        
	Map memberTypeMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_TYPE_CODE);
	
	Map genderMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_GENDER_CODE);
	
	Map maritalMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_MARITAL_CODE);
	
	Map orderByMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_ORDERBY_CODE);
	
	Map recordsMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_SHOWRECS_CODE);
	
	MemberBean[] beans = (MemberBean[]) returnBean.getReturnObject(MemberManager.RETURN_MBRLIST_CODE);

	boolean canView = beans != null && beans.length > 0;
%>

<html>
<head>
<title></title>

<%@ include file="/lib/header.jsp"%>

	<script language="javascript">
		
  	function doSubmit(thisform) {
			
	  	var memberID = thisform.MemberID.value;
 			
    	thisform.submit();
  	}      	  	 
	</script>
</head>

<body>

<div class="functionhead">Search Customer</div>

<form name="frmSearch" method="post" action="<%=Sys.getControllerURL(MemberManager.TASKID_SEARCH_MEMBERS_LIST,request)%>"	onSubmit="return doSubmit(document.frmSearch);">
<table border="0">
	<tr>
		<td class="td1">Customer No :</td>
		<td><std:input type="text" name="MemberID" size="30" maxlength="<%= memberIDLength %>" /></td>
		<td>&nbsp;</td>
		<td class="td1"><i18n:label code="GENERAL_NAME"/> :</td>
		<td><std:input type="text" name="MemberName" size="30" maxlength="50" /></td>
	</tr>
	<tr>
		<td class="td1"> ID Card :</td>
		<td><std:input type="text" name="IdentityNo" size="30" maxlength="30" /></td>
		<td>&nbsp;</td>
		<td class="td1"><i18n:label code="GENERAL_NO_MOBILE"/> :</td>
		<td><std:input type="text" name="MobileNo" size="30" maxlength="30" /></td>
	</tr>

	<tr>
		<td class="td1"><i18n:label code="GENERAL_BIRTHDATE"/> :</td>
		<td><std:input type="date" name="BirthDate" /></td>
		<td>&nbsp;</td>
		<td class="td1">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="DISTRIBUTOR_JOINED_DATE"/> <i18n:label code="GENERAL_FROM"/> :</td>
		<td><std:input type="date" name="JoinDateFrom" /></td>
		<td>&nbsp;</td>
		<td class="td1"><i18n:label code="DISTRIBUTOR_JOINED_DATE"/> <i18n:label code="GENERAL_TO"/> :</td>
		<td><std:input type="date" name="JoinDateTo" /></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="GENERAL_GENDER"/> :</td>
		<td><std:input type="select" name="Gender" options="<%= genderMap %>"/></td>
		<td>&nbsp;</td>
		<td class="td1"><i18n:label code="GENERAL_MARITAL"/> :</td>
		<td><std:input type="select" name="Marital" options="<%= maritalMap %>"/></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="GENERAL_DISPLAY"/> :</td>
		<td><std:input type="select" name="Limits" options="<%= recordsMap %>"/></td>
		<td>&nbsp;</td>
		<td class="td1"><i18n:label code="GENERAL_ORDERBY"/> :</td>
		<td><std:input type="select" name="OrderBy" options="<%= orderByMap %>"/></td>
	</tr>
</table>

<br>

<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>" />

<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>"></form>

<hr>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<%
if (canView) {
%>

<table>
	<tr>
		<td>
			<table class="listbox" width="100">
				<tr>
					<td class="totalhead" width="50"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TOTAL%>"/></td>
					<td width="50"><%= beans.length %></td>
				</tr>
			</table>
		</td>
		<td>&nbsp;</td>
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
		</td>
	</tr>
</table>

<br>

<table class="listbox" width="100%">
	<tr class="boxhead" valign=top>
		<td width="2%" align="center"><i18n:label localeRef="mylocale" code="<%= StandardMessageTag.NO %>" /></td>
		<td width="10%">Customer No.</td>
		<td width="20%"><i18n:label localeRef="mylocale" code="<%= StandardMessageTag.NAME %>" /></td>		
		<td width="10%">CRM ID</td>
                <td width="10%">Join Date</td>
		<td width="10%"><i18n:label localeRef="mylocale" code="<%= StandardMessageTag.GENDER %>" /></td>
		<td width="10%"><i18n:label code="GENERAL_MARITAL"/></td>
		<td width="10%"><i18n:label localeRef="mylocale" code="<%= StandardMessageTag.CONTACT_INFORMATION %>" /></td>
                <td width="10%">Segment</td>
		<td width="3%">Edit</td>
	</tr>

	<%
	  int cnt = 0;
		for (int i = 0; i < beans.length; i++) {

			String rowCss = "";

			if (beans[i].isHidden())
				continue;
			
			cnt++;
			
			if (cnt % 2 == 0)
				rowCss = "even";
			else
				rowCss = "odd";

			if (beans[i].getStatus() != MemberManager.MBRSHIP_ACTIVE)
			rowCss = "alert";
	%>
	
	<tr class="<%= rowCss %>" valign=top>
		<td width="5%" align="center"><%= cnt %>.</td>
		<td nowrap><%= beans[i].getMemberID() %>
    </td>
		<td><%= beans[i].getName() %></td>
		<td align="center" nowrap><%= (beans[i].getIdCRM() != null) ? beans[i].getIdCRM() : "" %></td>
                <td align="center" nowrap><%= (beans[i].getJoinDate() != null) ? Sys.getDateFormater().format(beans[i].getJoinDate()): "" %></td>
		<td nowrap align="center"><std:text value="<%= beans[i].getGender() %>" defaultvalue="-"/></td>
		<td nowrap align="center"><std:text value="<%= beans[i].getMarital() %>" defaultvalue="-"/></td>
		<td nowrap><%= beans[i].getContactInfo() != null ? beans[i].getContactInfo().replaceAll("\n", "<br>") : "-" %></td>
                <td align="center" nowrap><b><%= beans[i].getSegmentationCRM() %></b></td>
		<td align="center">
    	<a href="<%= editURL %>&MemberID=<%= beans[i].getMemberID() %>">
				<img border="0" alt='Edit Distributor' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/>
			</a>
    </td>
	</tr>

	<%
	} // end for
	%>

</table>

<%
} // canView
%>
