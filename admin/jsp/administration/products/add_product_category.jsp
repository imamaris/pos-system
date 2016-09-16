<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");
	boolean canView = false;
	int language_types = 0;
	if (languagebeans != null && languagebeans.length > 0)
	{
	 	canView = true;
	    language_types = languagebeans.length;
	}
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			if (!validateText(thisform.DefaultMsg)) {
					alert("<i18n:label code="MSG_ENTER_CAT_NAME"/>");
					return;
			}  
			thisform.submit();
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.ADD_PRODCUT_CATEGORY%>"/></div>

<form name="frmProductCatRegister" action="<%=Sys.getControllerURL(ProductCategoryManager.TASKID_PRODUCT_CAT_ADD,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.PRODUCT_CATEGORY_DETAILS%>"/></td>
			  	  	</tr>
				  	<tr>
			  			<td class="td1" width="250"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.DEFAULT_CATEGORY_NAME%>"/>:</td>
			      		<td><std:input type="text" size="50" name="DefaultMsg"/></td>
			  		</tr>
			  		<!--
			  		<tr>
						<td class="td1">Description:</td>
			      		<td><textarea cols="50" rows="3" name="Description"></textarea></td>
			  		</tr>
			  		-->
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ORDER%>"/>:</td>
			      		<td><std:input type="text" maxlength="5" size="3" value="1" name="OrderSeq"/></td>
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
	 				
	 				<% for (int j=0;j<language_types;j++) { %>
					
					<tr>
	 					<td class="td1"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.LOCALE_CATEGORY_NAME%>"/> (<%=languagebeans[j].getLocaleStr()%>):</td>
	 					<td><input type="text" name="<%=languagebeans[j].getLocaleStr()%>" value="" size="50" maxlength="250"></td>
	 				</tr>
	 	
					<% } // end for loop %>

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