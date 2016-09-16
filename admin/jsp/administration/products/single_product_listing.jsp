<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ProductCategoryBean[] beans = (ProductCategoryBean[]) returnBean.getReturnObject("CatList");
	ProductBean[] default_list = (ProductBean[]) returnBean.getReturnObject("Product");
	boolean canView = false;
	
	if (default_list != null)
		canView = true;
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

	<body>
	<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRODUCT_LISTING%>"/></div>
 	<form name="listcategory" action="<%=Sys.getControllerURL(ProductManager.TASKID_SINGLE_PRODUCT_LISTING,request)%>" method="post">
 	<table width="750">
 		<tr>
 			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TYPE%>"/>:</td>
	 		<td >
	            <select name="Type">
		 		    <option value=""><i18n:label code="GENERAL_ALL"/></option>
					<option value="S"><i18n:label code="PRODUCT_SINGLE"/></option>
					<option value="C"><i18n:label code="PRODUCT_COMBO"/></option>
				</select>&nbsp;&nbsp;
			</td>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
	 		<td >
	            <select name="Status">
		 		    <option value=""><i18n:label code="GENERAL_ALL"/></option>
					<option value="A"><i18n:label code="GENERAL_ACTIVE"/></option>
					<option value="I"><i18n:label code="GENERAL_INACTIVE"/></option>
				</select>
			</td>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
	 		<td >
	            <select name="CatID">
		 		    <option value=""><i18n:label code="GENERAL_ALL"/></option>
					<%
					for (int i=0;i<beans.length;i++) { 
					%>
					<option value="<%=beans[i].getCatID()%>"><%=beans[i].getName()%></option>
					<%
					} // end for
					%>
				</select>
			</td>
	 	</tr> 
	 	<tr>
 			<td align="right"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.INVENTORY_CONTROL%>"/>:</td>
	 		<td >
	            <select name="InventoryCtrl">
		 		    <option value=""><i18n:label code="GENERAL_ALL"/></option>
					<option value="Y"><i18n:label code="GENERAL_YES"/></option>
					<option value="N"><i18n:label code="GENERAL_NO"/></option>
				</select>
			</td>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRIORITY_LEVEL%>"/>:</td>
	 		<td >
	            <select name="PriorityLevel">
		 		    <option value=""><i18n:label code="GENERAL_ALL"/></option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
				</select>&nbsp;&nbsp;
			</td>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.ALERT_LEVEL%>"/>:</td>
	 		<td ><std:input type="text" size="5" name="SafeLevel" value=""/></td>
	 	</tr>  
	 	<tr>
	 		<td><br><input type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form)"></td>
	 	</tr> 
	</table>
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
    </form>

<% if (canView) { %>    
	<table class="listbox" width="80%" cellspacing="0">
		<tr class="boxhead" valign=top align="center">
			<td align=right><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TYPE%>"/></td>
			<td>Item Code</td>
			<td><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRODUCT_NAME%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.UOM%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.INVENTORY_CONTROL%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.ALERT_LEVEL%>"/></td>

			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/></td>	
			<td></td>
		  </tr>
		  
		  <% for (int i=0;i<default_list.length;i++) {
			  	String rowCss = "";
	  		  	
	  		  	if((i+1) % 2 == 0)
	  	      		rowCss = "even";
	  	      	else
	  	        	rowCss = "odd";
	  		  	
		  		int productid = default_list[i].getProductID();
		  		String type =default_list[i].getType();
		  %>
		  
		  	  <tr class="<%= rowCss %>" valign=top>
				<td align=right><%=(i+1)%>.</td>
				<td align="center"><%=default_list[i].getName()%></td>
				<td align="center"><%=default_list[i].getType()%></td>
				<td align="center">
					<%
					if (type != null && type.equalsIgnoreCase("Single"))
					{
					%>
					<a href="<%=Sys.getControllerURL(ProductManager.TASKID_SINGLE_PRODUCT_INFO,request)%>&productid=<%=productid%>">
						<%=default_list[i].getSkuCode()%>
					</a>
					<%
					}
					else
					{
					%>
					<a href="<%=Sys.getControllerURL(ProductManager.TASKID_COMBO_PRODUCT_INFO,request)%>&productid=<%=productid%>">
						<%=default_list[i].getSkuCode()%>
					</a>
					<%
					}
					 %>
					</td>
				
				<td align="left"><%=default_list[i].getDefaultName()%></td>
				<td align="center"><%=default_list[i].getUom()%></td>
				<td align="center"><%=default_list[i].getInventory()%></td>
				<td align="center"><%=default_list[i].getSafeLevel()%></td>

				<td align="center"><%=default_list[i].getStatus()%></td>
				
				<%
					if (type != null && type.equalsIgnoreCase("Single"))
					{
					%>
					<td>
						<a href="<%=Sys.getControllerURL(ProductManager.TASKID_SINGLE_PRODUCT_EDIT,request)%>&productid=<%=productid%>">
							<img border="0" alt='<i18n:label code="PRODUCT_EDIT_SINGLE"/>' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/>
						</a>
					</td>
					<%
					}
					else
					{
					%>
					<td>
						<a href="<%=Sys.getControllerURL(ProductManager.TASKID_COMBO_PRODUCT_EDIT,request)%>&productid=<%=productid%>">
							<img border="0" alt='<i18n:label code="PRODUCT_EDIT_COMBO"/>' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/>
						</a>
					</td>
					<%
					}
					 %>
			  </tr>	
		  <% } // end for loop %>
	</table>

<% } // end if canView %>	
	
	</body>
</html>
