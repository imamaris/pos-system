<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.helpdesk.category.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			if (!validateText(thisform.DefaultMsg)) {
				alert("Please enter Helpdesk Category Name.");
				return;
			} 
			if (!validateText(thisform.Description)) {
				alert("Please enter Helpdesk Category Description.");
				return;
			} 
			if (!validateText(thisform.OrderSeq)) {
				alert("Please enter Order.");
				return;
			}
			//var orderStr = parseInt(thisform.OrderSeq.value);
			//var order = thisform.OrderSeq.value;
			//if (order != "" && isNaN(orderStr)) {
			//	alert("Please enter integer number.");
			//	thisform.OrderSeq.select();
			//	return;
			//} 
			thisform.submit();
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.ADD_HELP_DESK_CAT%>"/></div>

<form name="frmProductCatRegister" action="<%=Sys.getControllerURL(HelpdeskCategoryManager.TASKID_HELPDESK_CAT_ADD,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<p class="required note">* <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.REQUIRED_FIELD%>"/></p>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
			  	  	<tr>
			  			<td class="td1" width="250"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.DEFAULT_HELP_DESK_CAT_NAME%>"/>:</td>
			      		<td><std:input type="text" size="50" name="DefaultMsg"/></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="250" valign="top"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DEFAULT_DESCRIPTION%>"/>:</td>
			      		<td><textarea cols="50" rows="2" name="Description"></textarea></td>
			  		</tr>
			  		<!--
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ORDER%>"/>:</td>
			      		<td><std:input type="text" maxlength="5" size="3" value="1" name="OrderSeq"/></td>
			  		</tr>
			  		-->
			  		<tr>
			  			<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
			      		<td>
			      			<select name="Status">
			      				<option value="<%=AppConstant.STATUS_ACTIVE%>">Active</option>
			      				<option value="<%=AppConstant.STATUS_INACTIVE%>">Inactive</option>
			      			</select>
			      		</td>
			  		</tr>
	 				
	 				<% for (int j=0;j<languagebeans.length;j++) { %>
					
					<tr>
	 					<td class="td1"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.LOCALE_CATEGORY_NAME%>"/> (<%=languagebeans[j].getLocaleStr()%>):</td>
	 					<td><input type="text" name="<%=languagebeans[j].getLocaleStr()%>" value="" size="50" maxlength="250"></td>
	 				</tr>
	 				<tr>
	 					<td class="td1" width="250" valign="top"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
	 					<td>
	 						<textarea cols="50" rows="2" name="<%=languagebeans[j].getLocaleStr()%>_desc"></textarea><br><br>
	 					</td>
	 				</tr>
	 	
					<% } // end for loop %>

				</table>
			</td>
		</tr>	
	</table>
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="OrderSeq" value="1"/> 

	<input class="textbutton" type="button" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.SUBMIT%>'/>" onClick="doSubmit(this.form);">
  	<input class="textbutton" type="reset" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.RESET%>'/>">
  	
</form>
</html>