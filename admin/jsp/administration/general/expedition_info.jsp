<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.expedition.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ExpeditionBean beans = (ExpeditionBean) returnBean.getReturnObject("List");
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

<div class="functionhead">EXPEDITION INFORMATION</div>

<form name="supplierform" action="<%=Sys.getControllerURL(ExpeditionManager.TASKID_EXPEDITION_LISTING,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead">Supplier Details</td>
			  	  	</tr>
				  	<tr>
						<td class="td1" width="180">Name</td>
			      		<td><%= beans.getName() %></td>
			  		</tr>
			  		<tr>
						<td class="td1">Description</td>
			      		<td><%= beans.getDescription() %></td>
			  		</tr>
			  		<tr>
						<td class="td1">Address</td>
			      		<td><%= beans.getAddress().getAddressLine1() %></td>
			  		</tr>
			  		<tr>
			  			<td></td>
			      		<td><%= beans.getAddress().getAddressLine2() %></td>
			  		</tr>
			  		<tr>
						<td class="td1">Zip Code</td>
			      		<td><%= beans.getAddress().getZipCode() %></td>
			  		</tr>
			  		<tr>
						<td class="td1">Country</td>
			      		<td><%= beans.getAddress().getCountryID() %></td>
			  		</tr>
			  		<tr>
						<td class="td1">State</td>
			      		<td><%= beans.getAddress().getStateID() %></td>
			  		</tr>
			  		<tr>
						<td class="td1">City</td>
			      		<td><%= beans.getAddress().getCityID() %></td>
			  		</tr>
			  		<tr>
						<td class="td1">Office No</td>
			      		<td><%= beans.getOfficeNo() %></td>
			  		</tr>
			  		<tr>
						<td class="td1">Fax. No.</td>
			      		<td><%= beans.getFaxNo() %></td>
			  		</tr>
			  		<tr>
						<td class="td1">Email</td>
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