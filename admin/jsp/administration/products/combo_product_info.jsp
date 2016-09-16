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
	ProductBean[] subproduct = (ProductBean[]) returnBean.getReturnObject("Product");
	
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

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.COMBO_PRODUCT_INFO%>"/></div>

<form name="frmProductEdit" action="<%=Sys.getControllerURL(ProductManager.TASKID_COMBO_PRODUCT_LISTING,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

<% if (canView) { %>    

	<table class="tbldata" width="100%">
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.COMBO_PRODUCT_DETAIL%>"/></td>
		</tr>
		<std:input type="hidden" name="ProductID" value="<%= String.valueOf(default_list[0].getProductID()) %>"/> 
		<std:input type="hidden" name="hidCat" value="<%= String.valueOf(default_list[0].getCatID()) %>"/> 
		<std:input type="hidden" name="hidStatus" value="<%= default_list[0].getStatus() %>"/>
		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.SKU_CODE%>"/>:</td>
			<td><%=default_list[0].getSkuCode()%></td>
		</tr>
		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.DEFAULT_COMBO_PRODUCT_NAME%>"/>:</td>
			<td><%=default_list[0].getDefaultName()%></td>
		</tr>
		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DEFAULT_DESCRIPTION%>"/>:</td>
			<td><%=default_list[0].getDefaultDesc()%></td>
		</tr>
		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
			<td><%=default_list[0].getCatID()%></td>
		</tr>
		<%
  		String statusVal = "";
  		String statusStr = default_list[0].getStatus();
  		if (statusStr.equals("A"))
  			statusVal = "Active";
  		else
  			statusVal = "Inactive";
  		%>
  		<tr>
  			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
      		<td><%=statusVal%></td>
  		</tr>
  		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.UOM%>"/>:</td>
      		<td><%= String.valueOf(default_list[0].getUom()) %></td>
  		</tr>
  		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.INVENTORY_CONTROL%>"/>:</td>
      		<td><%= default_list[0].getInventory() %></td>
  		</tr>
  		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.ALERT_LEVEL%>"/>:</td>
      		<td><%= String.valueOf(default_list[0].getSafeLevel()) %></td>
  		</tr>
  		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRIORITY_LEVEL%>"/>:</td>
      		<td><%= String.valueOf(default_list[0].getPriorityLevel()) %></td>
  		</tr>
  		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.UNIT_OF_SALES%>"/>:</td>
      		<td><%= String.valueOf(default_list[0].getQtySale()) %></td>
  		</tr>
  		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.REG_PRD%>"/>:</td>
      		<td><%= default_list[0].getRegister() %></td>
  		</tr>
  		<tr>
	 		<td height="15"></td>
	 	</tr>
  		<% 
  		for (int j=0;j<language_types;j++) { 
  			ProductBean[] list = (ProductBean[]) returnBean.getReturnObject(languagebeans[j].getLocaleStr());
				String locale_value = "";
				String desc = "";
				if (list[0] != null)
			 	locale_value = list[0].getName();
					desc = list[0].getDescription();
  		%>
		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.LOCALE_PRODUCT_NAME%>"/> (<%=languagebeans[j].getLocaleStr()%>):</td>
			<td><%= locale_value.length() > 0 ?  locale_value : "--"%></td>
		</tr>
		<tr>
			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
			<td><%= desc.length() > 0 ? desc : "--" %></td>
		</tr>

		<% } // end for loop %>
		<% //} // end for loop %>
		<tr>
	 		<td height="15"></td>
	 	</tr>

  		<!--
  		<tr>
			<td class="td1">Image Path:</td>
      		<td><std:input type="text" size="50" name="Image"/></td>
  		</tr>
  		-->
  	</table>
	
	<!-- sub product listing -->
	<table width="100%" cellspacing="1">
		<tr>
			<td colspan="13" class="sectionhead">Product Details</td>
		</tr>
		<tr class="head" valign=top align="center">
			<td>No.</td>
			<td>Category</td>
			<td>Product<br>Code</td>
			<td>Product<br>Name</td>
			<td>UOM</td>
			<td>Inventory<br>Control</td>
			<td>Alert<br>Level</td>
			<td>Priority<br>Level</td>
			<td>Base<br>Value</td>
			<td>Reg<br>Prd</td>
			<td>Status</td>	
			<td>Unit<br>Sales</td>
		  </tr>
		  
		  <% for (int i=0;i<subproduct.length;i++) { 
		  		int productid = subproduct[i].getProductID();
		  %>
		  
		  	  <tr class="<%= (i%2 == 0) ? "even" : "odd"%>">
				<td align="center"><%=(i+1)%></td>
				<td align="center"><%=subproduct[i].getName()%></td>
				<td align="center"><%=subproduct[i].getProductCode()%></td>
				<td align="center"><%=subproduct[i].getDefaultName()%></td>
				<td align="center"><%=subproduct[i].getUom()%></td>
				<td align="center"><%=subproduct[i].getInventory()%></td>
				<td align="center"><%=subproduct[i].getSafeLevel()%></td>
				<td align="center"><%=subproduct[i].getPriorityLevel()%></td>
				<td align="center"><%=subproduct[i].getBaseValue()%></td>
				<td align="center"><%=subproduct[i].getRegister()%></td>
				<td align="center"><%=subproduct[i].getStatus()%></td>
				<td align="center"><%=subproduct[i].getQtySale()%></td>
				
			  </tr>	
		  <% } // end for loop %>
	</table>

<% } // end if canView %>	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="Type" value="<%= ProductManager.PRODUCT_COMBO %>"/> 

	<input class="textbutton" type="button" value="Back" onClick="doSubmit(this.form);">
  	
</form>
</html>