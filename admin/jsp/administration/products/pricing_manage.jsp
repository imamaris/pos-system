<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.pricing.*"%>
<%@ page import="com.ecosmosis.orca.pricing.product.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ProductBean[] productBeans = (ProductBean[]) returnBean.getReturnObject("PricingHistory");
	ProductBean productBean = (ProductBean) returnBean.getReturnObject("Product");
	
	String priceCode = request.getParameter("pricecode");
	String type = request.getParameter("type");
	
	boolean canView = true;
	
	//if (pricingBeans != null && pricingBeans.length>0)
	//{
	//	canView = true;
	//}
	
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function submitEdit() 
		{	
			var thisform = document.frmEditPricing;
			thisform.action = '<%=Sys.getControllerURL(ProductPricingManager.TASKID_PRICING_MANAGE,request)%>';
			thisform.submit();
		}
		function submitAdd() 
		{	
			var thisform = document.frmAddPricing;
			thisform.action = '<%=Sys.getControllerURL(ProductPricingManager.TASKID_PRICING_MANAGE,request)%>';
			thisform.submit();
		}
                
		function viewAddTable(productid,promotional)
		{
			var thisform = document.frmAddPricing;
			thisform.ProductID.value = productid;
			thisform.Price.value = "";
			thisform.Tax.value = "";
			thisform.BV1.value = "";
			thisform.BV2.value = "";
			thisform.BV3.value = "";
			thisform.BV4.value = "";
			thisform.BV5.value = "";
			document.getElementById("EditTable").style.display = "none";
			document.getElementById("AddTable").style.display = "";
		}
		function showEditTable(priceid,pricecode,productid,status,promotional,count,total)
		{
			frmEditPricing.ProductID.value = productid;
			frmEditPricing.PriceID.value = priceid;
			frmEditPricing.PriceCode.value = pricecode;
			frmEditPricing.Status.value = status;
			frmEditPricing.Promotional.value = promotional;
			for (i=1; i<=total; i++)
			{
				document.getElementById(i).style.display = "none";
			}
			document.getElementById(count).style.display = "";
			document.getElementById("AddTable").style.display = "none";
			document.getElementById("EditTable").style.display = "";	
		}
	</script>
	<title>Manage Pricing</title>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.MANAGE_PRICING%>"/></div>

<%@ include file="/lib/return_error_msg.jsp"%>

<% if (canView) { %>
	<form name="frmAddPricing1" action="" method="post">
	<table class="tbldata" width="100%">
		<tr>
			<td colspan="15" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRODUCT_DETAIL%>"/></td>
		</tr>
	  	<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.SKU_CODE%>"/>:</td>
      		<td><%= productBean.getSkuCode() %></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRODUCT_NAME%>"/>:</td>
      		<td><%= (productBean.getProductDescription().getLocale())!=null&&(productBean.getProductDescription().getLocale().length())>0 ? productBean.getProductDescription().getName():productBean.getDefaultName()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
      		<td><%= (productBean.getProductDescription().getLocale())!=null&&(productBean.getProductDescription().getLocale().length())>0 ? productBean.getProductDescription().getDescription():productBean.getDefaultDesc()%></td>
  		</tr>
  		<tr>
  			<td colspan="2"><input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_ADD"/>" onClick="viewAddTable('<%= productBean.getProductID() %>')" ><br><br></td>
  		</tr>
  	</table>
  	<!-- product pricing history -->
	<table class="listbox" width="700" cellspacing="0">
		<tr>
			<td colspan="15" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRODUCT_PRICING_HISTORY%>"/></td>
		</tr>
		<tr class="boxhead" valign=top align="center">
			<td align=right><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE_CODE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRODUCT_CODE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.EFFECTIVE_PERIOD%>"/></td>
			<td align=right><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE%>"/></td>
			<td align=right><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.TAX%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/></td>
			<td></td>
		</tr>
		<%
		if (productBeans.length<=0) {
		%>
		<tr><td colspan="12"><span class="required note">Record Not Exist !!</span></td></tr>
		<%
		} else {

		for (int i=0;i<productBeans.length;i++) { 
			String rowCss = "";
  		  	
  		  	if((i+1) % 2 == 0)
  	      		rowCss = "even";
  	      	else
  	        	rowCss = "odd";
		%>
		<tr class="<%=rowCss%>">
			<td align=right><%=(i+1)%>.</td>
			<td><%=productBeans[i].getCurrentPricing().getPriceCode()%></td>
			<td><%=productBeans[i].getSkuCode()%></td>
			<td><%=productBeans[i].getCurrentPricing().getStartDate()%> <i18n:label code="GENERAL_TO"/><br><%=productBeans[i].getCurrentPricing().getEndDate()%></td>
			<td align=right><%=productBeans[i].getCurrentPricing().getPrice()%></td>
			<td align=right><%=productBeans[i].getCurrentPricing().getTax()%></td>
			<td><%=productBeans[i].getCurrentPricing().getStatus()%></td>
			<td>
				<img border="0" alt='<i18n:label code="PRICE_EDIT"/>' src="<%= Sys.getWebapp() %>/img/icon_edit.gif" onClick="showEditTable('<%=productBeans[i].getCurrentPricing().getPricingID()%>','<%=productBeans[i].getCurrentPricing().getPriceCode()%>','<%=productBeans[i].getProductID()%>','<%=productBeans[i].getStatus()%>','<%=productBeans[i].getCurrentPricing().getPromotional()%>','<%=(i+1)%>','<%=productBeans.length%>')"/>
			</td>
		</tr>
		<%
		}} // end for
		%>
	</table>
	</form>
	
	<!-- Add Pricing Table default hidden -->
	<form name="frmAddPricing" action="" method="post">
	<table id="AddTable" class="tbldata" width="100%" style="display:none">
	  	<tr>
			<td colspan="15" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.ADD_PRODUCT_PRICING%>"/></td>
		</tr>
		<tr><td height="10"></td></tr>
	  	<tr>
  			<td class="td1" width="90"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE_CODE%>"/>:</td>
      		<td><std:input type="text" name="PriceCode" value="<%=priceCode%>" size="6" status="readonly"/></td>
  		</tr>
  		<tr>
  			<td class="td1" width="90"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.START_DATE%>"/>:</td>
      		<td><std:input type="date" name="StartDate" size="11" value="<%= Sys.getDateFormater().format(new Date()) %>"/></td>
  		</tr>
  		<tr>
  			<td class="td1" width="90"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.END_DATE%>"/>:</td>
      		<td><std:input type="date" name="EndDate" size="11" value="<%= Sys.getDateFormater().format(new Date()) %>"/></td>
  		</tr>
  		<tr>
  			<td class="td1" width="90"><i18n:label code="GENERAL_STATUS"/>:</td>
      		<td>
      			<select name="Status">
      				<option value="A"><i18n:label code="GENERAL_ACTIVE"/></option>
      				<option value="I"><i18n:label code="GENERAL_INACTIVE"/></option>
      			</select>
      		</td>
  		</tr>
  		<tr>
  			<td class="td1" width="90"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE%>"/>:</td>
      		<td><std:input type="text" name="Price" size="8" value="123"/></td>
  		</tr>
  		<tr>
  			<td class="td1" width="90"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.TAX%>"/>:</td>
      		<td><std:input type="text" name="Tax" size="8" value="0.00"/></td>
  		</tr>

                <std:input type="hidden" name="BV1" value="0"/>
                <std:input type="hidden" name="BV2" value="0"/>
                <std:input type="hidden" name="BV3" value="0"/>
                <std:input type="hidden" name="BV4" value="0"/>
                <std:input type="hidden" name="BV5" value="0"/>
                
  		<tr>
  			<td colspan="2">
  				<br><input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="submitAdd();">
  				<input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
  			</td>
  		</tr>
  		<std:input type="hidden" name="ProductID"/>
  		<std:input type="hidden" name="Promotional" value="<%=type%>"/>
  		<std:input type="hidden" name="Type" value="add"/>
  	</table>
	</form>
	
	<!-- Edit Pricing Table default hidden -->
	<form name="frmEditPricing" action="" method="post">
	<table id="EditTable" class="listbox" width="600" style="display:none">
	  	<tr>
			<td colspan="15" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.EDIT_PRODUCT_PRICING%>"/></td>
		</tr>
		<tr class="boxhead" valign=top align="center">
			<td><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE_CODE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.EFFECTIVE_PERIOD%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.TAX%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/></td>
		</tr>
		<%
		if (productBeans.length>0) {

			for (int i=0;i<productBeans.length;i++) { 
			%>
			<tr id="<%=(i+1) %>" class="odd" style="display:none" align="center">
				<td><%=productBeans[i].getCurrentPricing().getPriceCode()%></td>
				<td><%=productBeans[i].getCurrentPricing().getStartDate()%> to <%=productBeans[i].getCurrentPricing().getEndDate()%></td>
				<td><%=productBeans[i].getCurrentPricing().getPrice()%></td>
				<td><%=productBeans[i].getCurrentPricing().getTax()%></td>
				<td><%=productBeans[i].getCurrentPricing().getStatus()%></td>
			</tr>
			<%
			}
		}
		%>
  		
  		<tr>
  			<td class="td1"><i18n:label code="GENERAL_STATUS"/>:</td>
      		<td colspan="9">
      			<select name="Status">
      				<option value="A"><i18n:label code="GENERAL_ACTIVE"/></option>
      				<option value="I"><i18n:label code="GENERAL_INACTIVE"/></option>
      			</select>
      		</td>
  		</tr>
  		<tr>
  			<td colspan="10">
  				<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="submitEdit()">
  				<input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
  			</td>
  		</tr>
  		<std:input type="hidden" name="PriceCode" value=""/>
		<std:input type="hidden" name="PriceID" value=""/>
  		<std:input type="hidden" name="ProductID"/>
  		<std:input type="hidden" name="Promotional"/>
  		<std:input type="hidden" name="Type" value="edit"/>
  	</table>
  	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	</form>
        
        
<% } // end if canView %>
</html>