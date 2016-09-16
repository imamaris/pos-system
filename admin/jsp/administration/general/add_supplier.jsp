<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.supplier.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	<%@ include file="/lib/select_locations.jsp"%>
	
	<script language="javascript">
		function doSubmit(thisform) {	
		
			thisform.Suppliercode.value = thisform.Name.value;
			
			if (!validateText(thisform.Name)) {
					alert("<i18n:label code="MSG_INVALID_NAME"/>");
					return;
			} 
			if (!validateText(thisform.AddressLine1)) {
					alert("<i18n:label code="MSG_ENTER_ADDRESS"/>");
					return;
			} 
			if (!validateText(thisform.ZipCode)) {
					alert("<i18n:label code="MSG_ENTER_ZIPCODE"/>");
					return;
			} 
			if (!validateObj(thisform.CountryID, 1)) {
				alert("<i18n:label code="MSG_ENTER_COUNTRY"/>");
				return;
			}
			if (!validateObj(thisform.StateID, 1)) {
				alert("<i18n:label code="MSG_ENTER_STATE"/>");
				return;
			}
			if (!validateObj(thisform.CityID, 1)) {
				alert("<i18n:label code="MSG_ENTER_CITY"/>");
				return;
			}
			if (!validateText(thisform.OfficeNo)) {
					alert("<i18n:label code="MSG_ENTER_OFFICEPHONE"/>");
					return;
			} 
			if (!validateText(thisform.SuperName)) {
					alert("<i18n:label code="MSG_ENTER_CONTACTNAME"/>");
					return;
			}
			if (!validateText(thisform.SuperOfficeNo)) {
					alert("<i18n:label code="MSG_ENTER_CONTACTPHONE"/>");
					return;
			}
			
			thisform.submit();
		}
	</script>
</head>
<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=SupplierMessageTag.CREATE_NEW_SUPPLIER %>"/></div>

<form name="frmSupplierRegister" action="<%=Sys.getControllerURL(SupplierManager.TASKID_SUPPLIER_REG_FORM,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

<p class="required note">* <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.REQUIRED_FIELD %>"/></p>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=SupplierMessageTag.SUPPLIER_DETAIL %>"/></td>
			  	  	</tr>
				  	<tr>
						<td class="td1" width="180"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME %>"/>:</td>
			      		<td><std:input type="text" name="Name" size="40" maxlength="100"/></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION %>"/>:</td>
			      		<td><textarea cols="50" rows="3" name="Description"></textarea></td>
			  		</tr>
			  		<tr>
						<td class="td1"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ADDRESS %>"/>:</td>
			      		<td><std:input type="text" size="40" maxlength="100" name="AddressLine1"/></td>
			  		</tr>
			  		<tr>
			  			<td></td>
			      		<td><std:input type="text" size="40" maxlength="100" name="AddressLine2"/></td>
			  		</tr>
			  		<tr>
						<td class="td1"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ZIP_CODE %>"/>:</td>
			      		<td><std:input type="text" maxlength="20" name="ZipCode"/></td>
			  		</tr>
					<tr>
						<td class="td1"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY %>"/>:</td>
						<td><std:input type="select_country" name="CountryID" form="frmSupplierRegister"/></td>
					</tr>
					<tr>
						<td class="td1"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATE %>"/>:</td>
						<td><std:input type="select_state" name="StateID" form="frmSupplierRegister" /></td>
					</tr>
					<tr>
						<td class="td1"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CITY %>"/>:</td>
						<td><std:input type="select_city" name="CityID" form="frmSupplierRegister"/></td>
					</tr>
			  		<tr>
						<td class="td1"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.OFFICE_NO %>"/>:</td>
			      		<td><std:input type="text" maxlength="50" name="OfficeNo"/></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.FAX_NO %>"/>:</td>
			      		<td><std:input type="text" maxlength="50" name="FaxNo"/></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL %>"/>:</td>
			      		<td><std:input type="text" size="40"  maxlength="50" name="Email"/></td>
			  		</tr>
				</table>
			</td>
		</tr>	
		<tr>
			<td>
				<table class="tbldata" width="100%">
					<tr>
						<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CONTACT_PERSON_DETAILS%>"/></td>
			  		</tr>
					<tr>
						<td class="td1" width="180"><i18n:label code="GENERAL_TITLE"/>:</td>
						<td><std:input type="text" name="SuperTitle" maxlength="10"/></td>
					</tr>
					<tr>
						<td class="td1" width="180"><span class="required note">* </span><i18n:label code="GENERAL_NAME"/></td>
						<td><std:input type="text" size="40" name="SuperName" maxlength="100"/></td>
					</tr>
					<tr>
						<td class="td1" width="180"><i18n:label code="GENERAL_POSITION"/>:</td>
						<td><std:input type="text" size="40"  name="SuperOccupationPosition" maxlength="100"/></td>
					</tr>
					<tr>
						<td class="td1" width="180"><span class="required note">* </span><i18n:label code="GENERAL_NO_OFFICE"/>:</td>
						<td><std:input type="text" name="SuperOfficeNo" maxlength="50"/></td>
					</tr>
					<tr>
						<td class="td1" width="180"><i18n:label code="GENERAL_NO_FAX"/>:</td>
						<td><std:input type="text" name="SuperFaxNo" maxlength="50"/></td>
					</tr>
					<tr>
						<td class="td1" width="180"><i18n:label code="GENERAL_NO_MOBILE"/>:</td>
						<td><std:input type="text" name="SuperMobileNo" maxlength="50"/></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="Suppliercode"/> 
	
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
  <input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
  	
</form>
</html>