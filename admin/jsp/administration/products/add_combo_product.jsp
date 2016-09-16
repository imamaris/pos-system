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
	ProductBean[] default_list = (ProductBean[]) returnBean.getReturnObject("Product");
	
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
			if (!validateText(thisform.SkuCode)) {
					alert("<i18n:label code="MSG_ENTER_SKUCODE"/>");
					thisform.SkuCode.focus();
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
			
			if (checkCount(thisform))
				thisform.submit();
		}
		
		function checkCount(thisform) {

		   var qty = thisform.productQty;
		   var pro = thisform.ProductID;
		   var vchecked = false;
		
		   if(pro!=null){
		       for (var i=0; i <pro.length; i++) {
		           if (pro[i].checked) {
		              vchecked = true;
		    
		              var qtty = eval("thisform.UnitSales_"+ pro[i].value);
		              var order = eval("thisform.OrderSeq_"+ pro[i].value);		              
		              
		              if (qtty.value.length==0 || isNaN(qtty.value) || qtty.value <=0) {
		                  focusAndSelect(qtty);
		                  alert("<i18n:label code="MSG_INVALID_QUANTITY"/>");
		                  return false;
		              }
		              if (order.value.length==0 || isNaN(order.value) || order.value <=0) {
		                  focusAndSelect(order);
		                  alert("<i18n:label code="MSG_INVALID_VALUE"/>");
		                  return false;
		              }
		           }
		       }
		   }
		
		   if (!vchecked) {
		       alert("<i18n:label code="MSG_SELECT_ONEPRODUCT_ATLEAST"/>");
		       return false;
		   }
		
		   return true;
		}
		
		
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.ADD_COMBO_PRODUCT%>"/></div>

<form name="frmProductCatRegister" action="<%=Sys.getControllerURL(ProductManager.TASKID_COMBO_PRODUCT_ADD,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.COMBO_PRODUCT_DETAIL%>"/></td>
			  	  	</tr>
				  	<tr>
			  			<td class="td1" width="200"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.SKU_CODE%>"/>:</td>
			      		<td><std:input type="text" size="15" maxlength="10" name="SkuCode"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="200"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.DEFAULT_COMBO_PRODUCT_NAME%>"/>:</td>
			      		<td><std:input type="text" size="50" name="ProductName"/></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="200" valign="top"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.DEFAULT_DESCRIPTION%>"/>:</td>
			      		<td><textarea cols="50" rows="3" name="Description"></textarea></td>
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
						<td class="td1" width="200"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.REG_PRD%>"/>:</td>
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
	 				<tr>
						<td headers="15"></td>
			      	</tr>
	 	
					<% } // end for loop %>
					
			  		<!--
			  		<tr>
						<td class="td1">Image Path:</td>
			      		<td><std:input type="text" size="50" name="Image"/></td>
			  		</tr>
			  		-->
			  	</table>
			  	<!-- product listing -->
				<table class="listbox" width="100%" cellspacing="0">
					<tr class="boxhead" valign=top align="center">
						<td align=right><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
						<td><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/></td>
						<td><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRODUCT_CODE%>"/></td>
						<td><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRODUCT_NAME%>"/></td>
						<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ORDER%>"/></td>
						<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.QTY%>"/></td>
						<td></td>
					  </tr>
					  
					  <% for (int i=0;i<default_list.length;i++) { 
						    
						  String rowCss = "";
				  		  	
				  		  	if((i+1) % 2 == 0)
				  	      		rowCss = "even";
				  	      	else
				  	        	rowCss = "odd";
				  		  	
					  		int productid = default_list[i].getProductID();
					  		String orderStr = "OrderSeq_" + String.valueOf(productid);
					  		String qtyStr = "UnitSales_" + String.valueOf(productid);
					  		String idStr = "ProductID_" + String.valueOf(productid);
					  %>
					  
					  	  <tr class="<%=rowCss%>" align="center">
							<td align=right><%=(i+1)%>.</td>
							<td align="center"><%=default_list[i].getName()%></td>
							<td align="center"><%=default_list[i].getProductCode()%></td>
							<td align="left"><%=default_list[i].getDefaultName()%></td>
							
							<td><std:input type="text" size="3" name="<%=orderStr%>" value="1"/></td>
							
							<td><std:input type="text" size="3" name="<%=qtyStr%>" value="1"/></td>
							
							<td><input type="checkbox" name="ProductID" value="<%=productid%>"><std:input type="hidden" name="<%=idStr%>" value="<%=String.valueOf(productid)%>"/></td>
						  </tr>	
					  <% } // end for loop %>
				</table>
			  	<!-- end listing -->
			</td>
		</tr>	
	</table>
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="Type" value="<%= ProductManager.PRODUCT_COMBO %>"/> 

	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
  	<input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
  	
</form>
</html>