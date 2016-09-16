<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@page import="com.ecosmosis.orca.webcontent.WebManager"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>

<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
%>


<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			if (!validateText(thisform.CategoryName)) {
					alert("<i18n:label code="MSG_ENTER_CAT_NAME"/>");
					return;
			}  
			thisform.submit();
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label code="WEB_ADD_CATEGORY"/></div>

<form name="frmProductCatRegister" action="<%=Sys.getControllerURL(WebManager.TASKID_CONTENT_CAT_ADD_SUBMIT,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label code="WEB_CATEGORY_DETAILS"/></td>
			  	  	</tr>
				  	<tr>
			  			<td class="td1" width="250"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.DEFAULT_CATEGORY_NAME%>"/>:</td>
			      		<td><std:input type="text" size="50" name="CategoryName"/></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ORDER%>"/>:</td>
			      		<td><std:input type="text" maxlength="4" size="3" value="1" name="Order"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
			      		<td>
			      			<select name="Status">
			      				<option value="A"><i18n:label code="GENERAL_ACTIVE"/></option>
			      				<option value="I"><i18n:label code="GENERAL_INACTIVE"/></option>
			      			</select>
			      		</td>
			  		</tr> 				

				</table>
			</td>
		</tr>	
	</table>
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name=""/> 

	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
  	<input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
  	
</form>
</html>