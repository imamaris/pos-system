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
	int language_types = 0;
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
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
		function sku(thisform)
		{
			var productcode = thisform.ProductCode.value;
			thisform.SkuCode.value = productcode;
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.ADD_SINGLE_PRODUCT%>"/></div>

<form name="frmProductRegister" action="<%=Sys.getControllerURL(ProductManager.TASKID_SINGLE_PRODUCT_ADD,request)%>" method="post">

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
			  	  	<tr>
			  			<td class="td1" width="200"><span class="required note">* </span>Item Code :</td>
			      		<td><std:input type="text" size="30" maxlength="20" name="ProductCode" status="onchange='sku(this.form)'"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.SKU_CODE%>"/>:</td>
			      		<td><std:input type="text" size="20" name="SkuCode" status="readonly"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="200"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.DEFAULT_PRODUCT_NAME%>"/>:</td>
			      		<td><std:input type="text" size="50" name="ProductName"/></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200" valign="top"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DEFAULT_DESCRIPTION%>"/>:</td>
			      		<td><textarea cols="50" rows="2" name="Description"></textarea></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="200"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
			      		<td>
			      			<select name="CatID">
			      				<option value="default" selected>[<i18n:label code="PRODUCT_CAT"/>]</option>
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
			  			<td class="td1" width="200"><span class="required note">* </span><i18n:label code="GENERAL_STATUS"/>:</td>
			      		<td>
			      			<select name="Status">
			      				<option value="A"><i18n:label code="GENERAL_ACTIVE"/></option>
			      				<option value="I"><i18n:label code="GENERAL_INACTIVE"/></option>
			      			</select>
			      		</td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.UOM%>"/>:</td>
			      		<td><std:input type="text" size="10" name="Measurement"/></td>
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
			      		<td><std:input type="text" size="10" name="SafeLevel"/></td>
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
			      		<td><std:input type="text" size="5" name="UnitSales" value="1"/></td>
			  		</tr>
			  		                                       
                                        <std:input type="hidden" value="0" name="BaseValue"/>
                                        
			  		
			  		<tr>
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.REGISTER_PRODUCT%>"/>:</td>
			      		<td>
			      			<input type="checkbox" name="RegisterChk">
			      			<input type="hidden" name="Register">
			      		</td>
			  		</tr>
			  		
			  		<% for (int j=0;j<language_types;j++) { %>
					
					<tr>
	 					<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.LOCALE_PRODUCT_NAME%>"/> (<%=languagebeans[j].getLocaleStr()%>):</td>
	 					<td>
	 						<input type="text" name="<%=languagebeans[j].getLocaleStr()%>" value="" size="50" maxlength="250">
	 					</td>
	 				</tr>
	 				<tr>
	 					<td class="td1" width="200" valign="top"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
	 					<td>
	 						<textarea cols="50" rows="2" name="<%=languagebeans[j].getLocaleStr()%>_desc"></textarea><br><br>
	 					</td>
	 				</tr>
	 	
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