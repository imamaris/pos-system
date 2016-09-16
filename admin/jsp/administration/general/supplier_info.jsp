<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.supplier.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	SupplierBean beans = (SupplierBean) returnBean.getReturnObject("List");
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
		function doSubmit(thisform) {	
			thisform.submit();
		}
	</script>
</head>
<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=SupplierMessageTag.SUPPLIER_INFORMATION%>"/></div>

<form name="supplierform" action="<%=Sys.getControllerURL(SupplierManager.TASKID_SUPPLIER_LISTING,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=SupplierMessageTag.SUPPLIER_DETAIL%>"/></td>
			  	  	</tr>
				  	<tr>
						<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/>:</td>
			      		<td><%= beans.getName() %></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
			      		<td><%= beans.getDescription() %></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ADDRESS%>"/>:</td>
			      		<td><%= beans.getAddress().getAddressLine1() %></td>
			  		</tr>
			  		<tr>
			  			<td></td>
			      		<td><%= beans.getAddress().getAddressLine2() %></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ZIP_CODE%>"/>:</td>
			      		<td><%= beans.getAddress().getZipCode() %></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/>:</td>
			      		<td><%= beans.getAddress().getCountryID() %></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATE%>"/>:</td>
			      		<td><%= beans.getAddress().getStateID() %></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CITY%>"/>:</td>
			      		<td><%= beans.getAddress().getCityID() %></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.OFFICE_NO%>"/>:</td>
			      		<td><%= beans.getOfficeNo() %></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.FAX_NO%>"/>:</td>
			      		<td><%= beans.getFaxNo() %></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL%>"/>:</td>
			      		<td><%= beans.getEmail() %></td>
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
						<td><%= beans.getSupervisor().getSuperTitle() %></td>
					</tr>
					<tr>
						<td class="td1" width="180"><i18n:label code="GENERAL_NAME"/>:</td>
						<td><%= beans.getSupervisor().getSuperName() %></td>
					</tr>
					<tr>
						<td class="td1" width="180"><i18n:label code="GENERAL_POSITION"/>:</td>
						<td><%= beans.getSupervisor().getSuperOccupationPosition() %></td>
					</tr>
					<tr>
						<td class="td1" width="180"><i18n:label code="GENERAL_NO_OFFICE"/>:</td>
						<td><%= beans.getSupervisor().getSuperOfficeNo() %></td>
					</tr>
					<tr>
						<td class="td1" width="180"><i18n:label code="GENERAL_NO_FAX"/>:</td>
						<td><%= beans.getSupervisor().getSuperFaxNo() %></td>
					</tr>
					<tr>
						<td class="td1" width="180" ><i18n:label code="GENERAL_NO_MOBILE"/>:</td>
						<td><%= beans.getSupervisor().getSuperMobileNo() %></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center"><br><br><input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_BACK"/>" onClick="doSubmit(this.form);"></td>
		</tr>
	</table>
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
</form>
</html>