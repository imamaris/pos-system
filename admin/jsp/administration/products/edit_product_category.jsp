<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");
	boolean canView = false;
	
	int language_types = 0;
	String default_locale = null;
	ProductCategoryBean[] default_list = null;

	if (languagebeans != null && languagebeans.length > 0)
	{
	 	canView = true;
	    language_types = languagebeans.length;
	    default_locale = languagebeans[0].getLocaleStr();
	    default_list = (ProductCategoryBean[]) returnBean.getReturnObject(default_locale);
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
		
		function insert() {
			var thisform = frmProductCatEdit;
			var status = thisform.hidStatus.value;
			thisform.Status.value = status;
		}
	</script>
</head>

<body onLoad="self.focus(); insert();">

<div class="functionhead"><i18n:label code="PRODUCT_EDIT_CAT"/></div>

<form name="frmProductCatEdit" action="<%=Sys.getControllerURL(ProductCategoryManager.TASKID_PRODUCT_CAT_EDIT,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label code="PRODUCT_CAT_DETAILS"/></td>
			  	  	</tr>
			  	  	
			  	  	<% for (int i=0;i<default_list.length;i++) { %>
				  	<tr>
			  			<td class="td1" width="200"><span class="required note">* </span><i18n:label code="PRODUCT_DEFAULT_CATNAME"/>:</td>
			      		<td><std:input type="text" size="50" name="DefaultMsg" value="<%=default_list[i].getDefaultMsg()%>"/></td>
			  		</tr>
			  		<%
			  		int temp = default_list[i].getOrderSeq();
			  		int temp2 = default_list[i].getCatID();
			  		String orderSeq = Integer.toString(temp);
			  		String catID = Integer.toString(temp2);
			  		%>
			  		<tr>
						<td class="td1" width="200"><i18n:label code="GENERAL_ORDER"/>:</td>
			      		<td><std:input type="text" maxlength="5" size="5" name="OrderSeq" value="<%= orderSeq %>"/></td>
			  		</tr>
			  		<std:input type="hidden" name="CatID" value="<%=catID%>"/>
			  		<std:input type="hidden" name="hidStatus" value="<%=default_list[i].getStatus()%>"/> 
			  		<tr>
			  			<td class="td1" width="200"><i18n:label code="GENERAL_STATUS"/>:</td>
			      		<td>
			      			<select name="Status">
			      				<option value="A"><i18n:label code="GENERAL_ACTIVE"/></option>
			      				<option value="I"><i18n:label code="GENERAL_INACTIVE"/></option>
			      			</select>
			      		</td>
			  		</tr>
	 				
	 				<% for (int j=0;j<language_types;j++) { 
	 					ProductCategoryBean[] list = (ProductCategoryBean[]) returnBean.getReturnObject(languagebeans[j].getLocaleStr());
	 					String locale_value = "";
	 					if (list[i] != null)
						 	locale_value = list[i].getName();
	 				%>
					
					<tr>
	 					<td class="td1" width="200"><i18n:label code="PRODUCT_LOCALE_CATNAME"/><br>(<%=languagebeans[j].getLocaleStr()%>):</td>
	 					<td><input type="text" name="<%=languagebeans[j].getLocaleStr()%>" value="<%= locale_value %>" size="50" maxlength="250"></td>
	 				</tr>
	 	
					<% } // end for loop %>
					
					<% } // end for loop %>

				</table>
			</td>
		</tr>	
	</table>
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>

	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
  	<input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
  	
</form>
</html>