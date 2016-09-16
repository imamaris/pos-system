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

  AddressBean address = null;
  
  boolean canView = false;
	if (bean != null && !bean.isHidden()) {
		address = bean.getAddress();
	 	canView = true;
 	}
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
			

	  	
    	if (!validateText(thisform.AddressLine1)) {
				alert("<i18n:label code="MSG_ENTER_ADDRESS"/>");
				return;
			} else {
				thisform.MailAddressLine1.value = thisform.AddressLine1.value;
			}
			
			if (validateTextNoFocus(thisform.AddressLine2)) {
				thisform.MailAddressLine2.value = thisform.AddressLine2.value;
			}
			
			thisform.MailZipCode.value = thisform.ZipCode.value;
			
			if (!validateObj(thisform.CountryID, 1)) {
				alert("<i18n:label code="MSG_ENTER_COUNTRY"/>");
				return;
			} else {
				thisform.MailCountryID.value = thisform.CountryID.options[thisform.CountryID.selectedIndex].value;
			}
			
			if (!validateObj(thisform.StateID, 0)) {
				alert("<i18n:label code="MSG_ENTER_STATE"/>");
				return;
			} else {
				thisform.MailStateID.value = thisform.StateID.options[thisform.StateID.selectedIndex].value;
			}
			
			if (!validateObj(thisform.CityID, 0)) {
				alert("<i18n:label code="MSG_ENTER_CITY"/>");
				return;
			} else {
				thisform.MailCityID.value = thisform.CityID.options[thisform.CityID.selectedIndex].value;
			}
						
    	
  		if (confirm('<i18n:label code="MSG_PROCEED_CHANGE"/>')) {
				thisform.action = "<%=Sys.getControllerURL(MemberManager.TASKID_SPECIAL_EDIT_MEMBER_TAX,request)%>";		
				thisform.submit();
			}
		}
		
  </script>	
</head>

<body>

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.SPECIAL_EDIT_DIST%>"/> - <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TAX_REG%>"/>
</div>

<form name="frmSearch" action="<%=Sys.getControllerURL(MemberManager.TASKID_SPECIAL_EDIT_MEMBER_TAX,request)%>" method="post">

	<table class="noprint">
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    <td>
				<std:input type="text" name="MemberID" size="20" maxlength="<%= memberIDLength %>"/>
				<a href="javascript:popupSmall('<%=Sys.getControllerURL(MemberManager.TASKID_SEARCH_MEMBERS_BY,request) %>&FormName=frmSearch&ObjName=MemberID')">
  				<img border="0" alt='Search Distributor' src="<%= Sys.getWebapp() %>/img/lookup.gif"/>
  			</a>
			</td>
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
	
	<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>
	
	<table class="tbldata" width="100%">
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    <td><%= (bean.getMemberID() != null) ? bean.getMemberID() : "Pending" %></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/>:</td>
	    <td><%= (bean.getJoinDate() != null) ? Sys.getDateFormater().format(bean.getJoinDate()): "" %></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="MBR007"/>:</td>
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
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.IC_NO%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>:</td>
			<td><std:text value="<%= bean.getIdentityNo() %>" defaultvalue="-"/></td>
		</tr>
		
		<%
			if (bean.getType().equals(MemberManager.MBRTYPE_COMPANY)) {
		%>
			
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_DATE%>"/>:</td>
			<td>
				<std:input type="date" name="CompanyRegDateStr" value="<%= (bean.getCompanyRegDate() != null) ? Sys.getDateFormater().format(bean.getCompanyRegDate()): "" %>" size="<%= size %>"/>
				&nbsp; (YYYY-MM-DD)
			</td>
		</tr>	
		
		<%
			}
		%>
		
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
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="ID Original"/>:</td>
			<td><std:text value="<%= bean.getOriginalID() %>" defaultvalue="-"/></td>
		</tr>    
		<tr>
			<td colspan="2">&nbsp</td>
		</tr>                
		<tr valign="top">
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MAILING_ADD%>"/>:</td>
			<td><std:input type="text" name="AddressLine1" value="<%= (address.getMailAddressLine1() != null) ? address.getMailAddressLine1() : "" %>" size="<%= size %>" maxlength="30"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><std:input type="text" name="AddressLine2" value="<%= (address.getMailAddressLine2() != null) ? address.getMailAddressLine2() : "" %>" size="<%= size %>" maxlength="30"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ZIP_CODE%>"/>:</td>
			<td><std:input type="text" name="ZipCode" value="<%= (address.getMailZipCode() != null) ? address.getMailZipCode() : "" %>" size="<%= size %>" maxlength="5"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/>:</td>
			<td><std:input type="select_country" name="CountryID" form="frmEdit" value="<%= (address.getCountryID() != null) ? address.getCountryID() : "" %>"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATE%>"/>:</td>
			<td><std:input type="select_state" name="StateID" form="frmEdit" value="<%= (address.getStateID() != null) ? address.getStateID() : "" %>"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CITY%>"/>:</td>
			<td><std:input type="select_city" name="CityID" form="frmEdit" value="<%= (address.getCityID() != null) ? address.getCityID() : "" %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_OFF%>"/>:</td>
			<td><std:input type="text" name="OfficeNo" value="<%= bean.getOfficeNo() != null ? bean.getOfficeNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_HOME%>"/>:</td>
			<td><std:input type="text" name="HomeNo" value="<%= bean.getHomeNo() != null ? bean.getHomeNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MOBILE_NO%>"/>:</td>
			<td><std:input type="text" name="MobileNo" value="<%= bean.getMobileNo() != null ? bean.getMobileNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL%>"/>:</td>
			<td><std:input type="text" name="Email" value="<%= bean.getEmail() != null ? bean.getEmail() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.OCCUPATION%>"/>:</td>
			<td><std:input type="text" name="Occupation" value="<%= (bean.getOccupation() != null) ? bean.getOccupation() : "" %>" size="<%= size %>"/></td>
		</tr>
		
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TAX_REG%>"/>:</td>
			<td><std:input type="text" name="IncomeTaxNo" value="<%= bean.getIncomeTaxNo() != null ? bean.getIncomeTaxNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td colspan="2">&nbsp</td>
		</tr>
				
	</table>

	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="DisplayName"/> 
	<std:input type="hidden" name="MailAddressLine1"/> 
	<std:input type="hidden" name="MailAddressLine2"/>
	<std:input type="hidden" name="MailZipCode"/> 
	<std:input type="hidden" name="MailCountryID"/>
	<std:input type="hidden" name="MailStateID"/> 
	<std:input type="hidden" name="MailCityID"/>
	<std:input type="hidden" name="MemberID" value="<%= bean.getMemberID() %>"/> 
	
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" onClick="doSubmit(this.form);"> 
</form>

<% 
	} // end canView
%>

</body>
</html>