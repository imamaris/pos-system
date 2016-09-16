<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ProductCategoryBean[] beans = (ProductCategoryBean[]) returnBean.getReturnObject("CatList");
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");

	boolean canView = false;
	
	int language_types = 0;
	String default_locale = null;
	ProductBean[] default_list = null;

	if (languagebeans != null && languagebeans.length > 0)
	{
	 	canView = true;
	    language_types = languagebeans.length;
	    default_locale = languagebeans[0].getLocaleStr();
	    default_list = (ProductBean[]) returnBean.getReturnObject(default_locale);
	}
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>

	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			thisform.submit();
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.SINGLE_PRODUCT_INFO%>"/></div>

<form name="frmProductEdit" action="<%=Sys.getControllerURL(ProductManager.TASKID_SINGLE_PRODUCT_LISTING,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

<% if (canView) {%>  

	<table width="100%">
		<tr>
			<td align="left">
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.SINGLE_PRODUCT_DETAIL%>"/></td>
			  	  	</tr>
			  	  	<% 
			  	  	for (int i=0;i<default_list.length;i++) { 
			  	  	%>
			  	  	<std:input type="hidden" name="ProductID" value="<%= String.valueOf(default_list[i].getProductID()) %>"/> 
			  		<std:input type="hidden" name="hidCat" value="<%= String.valueOf(default_list[i].getCatID()) %>"/> 
					<std:input type="hidden" name="hidStatus" value="<%= default_list[i].getStatus() %>"/>
			  	  	<tr>
			  			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRODUCT_CODE%>"/>:</td>
			      		<td ><%=default_list[i].getProductCode()%></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.DEFAULT_PRODUCT_NAME%>"/>:</td>
			      		<td><%=default_list[i].getDefaultName()%></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DEFAULT_DESCRIPTION%>"/>:</td>
			      		<td><%=default_list[i].getDefaultDesc()%></td>
			  		</tr>
			  		 
			  		<tr>
			  			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
			      		<td><%=default_list[i].getName()%></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
			      		<td><%= default_list[i].getStatus() %></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.UOM%>"/>:</td>
			      		<td><%= String.valueOf(default_list[i].getUom()) %></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.INVENTORY_CONTROL%>"/>:</td>
			      		<td><%= default_list[i].getInventory() %></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.ALERT_LEVEL%>"/>:</td>
			      		<td><%= String.valueOf(default_list[i].getSafeLevel()) %></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRIORITY_LEVEL%>"/>:</td>
			      		<td><%= String.valueOf(default_list[i].getPriorityLevel()) %></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.UNIT_OF_SALES%>"/>:</td>
			      		<td><%= String.valueOf(default_list[i].getQtySale()) %></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.BASE_VALUE%>"/>:</td>
			      		<td><%= String.valueOf(default_list[i].getBaseValue()) %></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.REGISTER_PRODUCT%>"/>:</td>
			      		<td><%= default_list[i].getRegister() %></td>
			  		</tr>
			  		<tr>
	 					<td height="15"></td>
	 				</tr>
			  		<% 
			  		for (int j=0;j<language_types;j++) { 
			  			ProductBean[] list = (ProductBean[]) returnBean.getReturnObject(languagebeans[j].getLocaleStr());
	 					String locale_value = "";
	 					String desc = "";
	 					if (list[i] != null)
						 	locale_value = list[i].getName();
	 						desc = list[i].getDescription();
			  		%>
					<tr>
	 					<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.LOCALE_PRODUCT_NAME%>"/> (<%=languagebeans[j].getLocaleStr()%>):</td>
	 					<td><%= locale_value.length() > 0 ?  locale_value : "--"%></td>
	 				</tr>
	 				<tr>
	 					<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
	 					<td><%= desc.length() > 0 ? desc : "--" %></td>
	 				</tr>
	 				<tr>
	 					<td height="15"></td>
	 				</tr>
	 	
					<% } // end for loop %>
					<% } // end for loop %>
					

			  		<!--
			  		<tr>
						<td class="td1">Image Path:</td>
			      		<td><std:input type="text" size="50" name="Image"/></td>
			  		</tr>
			  		-->
			  	</table>
			</td>
		</tr>	
	</table>
<% } // end if canView %>	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="Type" value="<%= ProductManager.PRODUCT_SINGLE %>"/> 

	<input class="textbutton" type="button" value="Back" onClick="doSubmit(this.form);">
  	
</form>
</html>