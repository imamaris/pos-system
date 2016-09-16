<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@page import="com.ecosmosis.orca.webcontent.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ContentCategoryBean bean = (ContentCategoryBean) returnBean.getReturnObject("CategoryBean");
	TreeMap status_list = (TreeMap) returnBean.getReturnObject("Status");
	
	boolean canView = (bean!=null);			
%>	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{				
			
			if (!validateText(thisform.CategoryName)) {
					alert("<i18n:label code="MSG_ENTER_CAT_NAME"/>");
					return false;
			}
			else
				return true;
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label code="WEB_EDIT_CATEGORY"/></div>
<%@ include file="/lib/return_error_msg.jsp"%>

<%if(canView){%>

<form name="frmCatEdit" action="<%=Sys.getControllerURL(WebManager.TASKID_CONTENT_CAT_EDIT_SUBMIT,request)%>" method="post" onSubmit="return doSubmit(document.frmCatEdit);">
<input type=hidden name="CatID" value="<%=bean.getCategoryID() %>">

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
			      		<td><std:input type="text" size="50" name="CategoryName" value="<%=bean.getCategoryName()%>" /></td>
			  		</tr>
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ORDER%>"/>:</td>
			      		<td><std:input type="text" maxlength="4" size="3" name="Order" value="<%=bean.getOrder()%>"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
			      		<td><std:input name="Status" type="select" options="<%=status_list %>" value="<%=bean.getStatus()%>"/></td>
			  		</tr>

				</table>
			</td>
		</tr>	
	</table>
	<br>
	
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" >
  	<input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
  	
</form>
<% } %>
</html>