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
			if (!validateText(thisform.ProductCode)) {
					alert("<i18n:label code="MSG_ENTER_PRODUCTCODE"/>");
					thisform.ProductCode.focus();
					return;
			}  
			if (!validateText(thisform.ProductName)) {
					alert("<i18n:label code="MSG_ENTER_PRODUCTNAME"/>");
					thisform.ProductName.focus();
					return;
			}  
			if (!validateText(thisform.Description)) {
					alert("<i18n:label code="MSG_ENTER_PRODUCTDESC"/>");
					thisform.Description.focus();
					return;
			}  
			if (thisform.Status.value == "default") {
					alert("<i18n:label code="MSG_SELECT_STATUS"/>");
					return;
			}  
			if (thisform.CatID.value == "default") {
					alert("<i18n:label code="MSG_SELECT_PRODUCTCAT"/>");
					return;
			}
			var safeStr = parseInt(thisform.SafeLevel.value);
			var safe = thisform.SafeLevel.value;
			if (safe != "" && isNaN(safeStr)) {
					alert("<i18n:label code="MSG_ENTER_INTEGER"/>");
					thisform.SafeLevel.select();
					return;
			}
			var prioStr = parseInt(thisform.PriorityLevel.value);
			var prio = thisform.PriorityLevel.value;
			if (prio != "" && isNaN(prioStr)) {
					alert("<i18n:label code="MSG_ENTER_INTEGER"/>");
					thisform.PriorityLevel.select();
					return;
			}
			var salesStr = parseInt(thisform.UnitSales.value);
			var sales = thisform.UnitSales.value;
			if (sales != "" && isNaN(salesStr)) {
					alert("<i18n:label code="MSG_ENTER_INTEGER"/>");
					thisform.UnitSales.select();
					return;
			}
			var baseStr = parseInt(thisform.BaseValue.value);
			var base = thisform.BaseValue.value;
			if (base != "" && isNaN(baseStr)) {
					alert("<i18n:label code="MSG_ENTER_INTEGER"/>");
					thisform.BaseValue.select();
					return;
			}
			// checkbox value inventory
			var yes = "Y";
			var no = "N";
			
			if (thisform.InventoryChk.checked == true) {
				thisform.InventoryCtrl.value = yes;
			} else {
				thisform.InventoryCtrl.value = no;
			}
			// checkbox value register
			var yes = "Y";
			var no = "N";
			
			if (thisform.RegisterChk.checked == true) {
				thisform.Register.value = yes;
			} else {
				thisform.Register.value = no;

			}
			thisform.submit();
		}
		
		function insert() {
			var thisform = frmProductEdit;
			var status = thisform.hidStatus.value;
			var cat = thisform.hidCat.value;
			var prio = thisform.hidPrio.value;
			var invent = thisform.hidInvent.value;
			var reg = thisform.hidReg.value;
			
			thisform.CatID.value = cat;
			thisform.PriorityLevel.value = prio;
			
			if (status == "Active")
				thisform.Status.value = "A";
			else
				thisform.Status.value = "I";
				
			if (invent == "Yes")
				thisform.InventoryChk.checked = true;
			else
				thisform.InventoryChk.checked = false;
				
			if (reg == "Yes")
				thisform.RegisterChk.checked = true;
			else
				thisform.RegisterChk.checked = false;
		}
	</script>
</head>

<body onLoad="self.focus(); insert();">

<div class="functionhead"><i18n:label code="PRODUCT_EDIT"/></div>

<form name="frmProductEdit" action="<%=Sys.getControllerURL(ProductManager.TASKID_SINGLE_PRODUCT_EDIT,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>

<% if (canView) { %>  

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRODUCT_DETAIL%>"/></td>
			  	  	</tr>
			  	  	<% 
			  	  	for (int i=0;i<default_list.length;i++) { 
			  	  	%>
			  	  	<std:input type="hidden" name="ProductID" value="<%= String.valueOf(default_list[i].getProductID()) %>"/> 
			  		<std:input type="hidden" name="hidCat" value="<%= String.valueOf(default_list[i].getCatID()) %>"/> 
					<std:input type="hidden" name="hidStatus" value="<%= default_list[i].getStatus() %>"/>
					<std:input type="hidden" name="hidPrio" value="<%= String.valueOf(default_list[i].getPriorityLevel()) %>"/>
					<std:input type="hidden" name="hidInvent" value="<%= String.valueOf(default_list[i].getInventory()) %>"/>
					<std:input type="hidden" name="hidReg" value="<%= String.valueOf(default_list[i].getRegister()) %>"/>
			  	  	<tr>
			  			<td class="td1" width="200"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRODUCT_CODE%>"/>:</td>
			      		<td><std:input type="text" size="20" name="ProductCode" value="<%=default_list[i].getProductCode()%>"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="200"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.DEFAULT_PRODUCT_NAME%>"/>:</td>
			      		<td><std:input type="text" size="50" name="ProductName" value="<%=default_list[i].getDefaultName()%>"/></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DEFAULT_DESCRIPTION%>"/>:</td>
			      		<td><textarea cols="50" rows="2" name="Description"><%=default_list[i].getDefaultDesc()%></textarea></td>
			  		</tr>
			  		 
			  		<tr>
			  			<td class="td1" width="200"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
			      		<td>
			      			<select name="CatID">
			      				<option value="default" selected>[<i18n:label code="PRODUCT_CAT"/>]</option>
			      				<%
								for (int k=0;k<beans.length;k++) { 
								%>
								<option value="<%=beans[k].getCatID()%>"><%=beans[k].getName()%></option>
								<%
								} // end for loop
								%>
			      			</select>
			      		</td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="200"><i18n:label code="GENERAL_STATUS"/>:</td>
			      		<td>
			      			<select name="Status">
			      				<option value="A"><i18n:label code="GENERAL_ACTIVE"/></option>
			      				<option value="I"><i18n:label code="GENERAL_INACTIVE"/></option>
			      			</select>
			      		</td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.UOM%>"/>:</td>
			      		<td><std:input type="text" size="10" name="Measurement" value="<%= String.valueOf(default_list[i].getUom()) %>"/></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.INVENTORY_CONTROL%>"/>:</td>
			      		<td>
			      			<input type="checkbox" name="InventoryChk">
			      			<input type="hidden" name="InventoryCtrl">
			      		</td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.ALERT_LEVEL%>"/>:</td>
			      		<td><std:input type="text" size="10" name="SafeLevel" value="<%= String.valueOf(default_list[i].getSafeLevel()) %>"/></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRIORITY_LEVEL%>"/>:</td>
			      		<td>
			      			<select name="PriorityLevel">
			      				<option value="1">1</option>
			      				<option value="2">2</option>
			      				<option value="3">3</option>
			      				<option value="4">4</option>
			      				<option value="5">5</option>
			      			</select>
			      		</td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.UNIT_OF_SALES%>"/>:</td>
			      		<td><std:input type="text" size="5" name="UnitSales" value="<%= String.valueOf(default_list[i].getQtySale()) %>"/></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.BASE_VALUE%>"/>:</td>
			      		<td><std:input type="text" size="5" name="BaseValue" value="<%= String.valueOf(default_list[i].getBaseValue()) %>"/></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.REGISTER_PRODUCT%>"/>:</td>
			      		<td>
			      			<input type="checkbox" name="RegisterChk">
			      			<input type="hidden" name="Register">
			      		</td>
			  		</tr>
			  		<tr><td height="15"></td></tr>
			  		<% 
			  		for (int j=0;j<language_types;j++) { 
			  			ProductBean[] list = (ProductBean[]) returnBean.getReturnObject(languagebeans[j].getLocaleStr());
	 					String locale_value = "";
	 					String desc = "";
	 					if (list[i] != null)
	 					{
						 	locale_value = list[i].getName();
	 						desc = list[i].getDescription();
	 					}
			  		%>
					<tr>
	 					<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.LOCALE_PRODUCT_NAME%>"/> (<%=languagebeans[j].getLocaleStr()%>):</td>
	 					<td>
	 						<input type="text" name="<%=languagebeans[j].getLocaleStr()%>" value="<%= locale_value %>" size="50" maxlength="250">
	 					</td>
	 				</tr>
	 				<tr>
	 					<td class="td1" width="200" valign="top"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
	 					<td>
	 						<textarea cols="50" rows="2" name="<%=languagebeans[j].getLocaleStr()%>_desc"><%= desc %></textarea>
	 					</td>
	 				</tr>
	 				<tr><td height="15"></td></tr>
	 	
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

	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
  	<input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
  	
</form>
</html>