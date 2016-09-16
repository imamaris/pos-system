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
 	String priceCodeSel = request.getParameter("PriceCode");
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	PriceCodeBean[] priceCodeBeans = (PriceCodeBean[]) returnBean.getReturnObject("PriceCodeList");
	ProductBean[] productBeans = (ProductBean[]) returnBean.getReturnObject("ProductPricingList");

	boolean canView = false;
	if (productBeans != null)
	{
		canView = true;
	}
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			var pricecode = thisform.PriceCode.value;
			if (pricecode == "default")
			{
				alert("<i18n:label code="MSG_SELECT_PRICECODE"/>");
				thisform.PriceCode.focus();
				return false;
			}
			thisform.submit();
		}
		function popitup(url)
		{
			newwindow=window.open(url,'name','scrollbars=1,height=600,width=750');
			if (window.focus) {newwindow.focus()}
			return false;
		}
		function morePopup(url)
		{
			newwindow=window.open(url,'name','scrollbars=1,height=600,width=750');
			if (window.focus) {newwindow.focus()}
			return false;
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.MANAGE_PRICING%>"/></div>

<form name="frmManagePricing1" action="<%=Sys.getControllerURL(ProductPricingManager.TASKID_PRICING_MANAGE_LISTING,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

	<table class="tbldata" width="500">
	  	<tr>
  			<td class="td1" width="100"><i18n:label code="PRICE_CODE"/>:</td>
      		<td width="400">
      			<select name="PriceCode">
      				<option value="default" selected>[<i18n:label code="PRICE_CODE"/>]</option>
      				<%
					for (int i=0;i<priceCodeBeans.length;i++) { 
						
						String selected = "";
						if (priceCodeBeans[i].getPriceCodeID().equals(priceCodeSel))
							selected = "selected";
					%>
					<option value="<%=priceCodeBeans[i].getPriceCodeID()%>" <%= selected %>><%=priceCodeBeans[i].getPriceCodeID()%></option>
					<%
					} // end for
					%>
      			</select>
      		</td>
  		</tr>
  		<tr>
  			<td class="td1"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.EFFECTIVE_DATE%>"/>:</td>
      		<td><std:input type="date" name="Date" size="11" value="<%= Sys.getDateFormater().format(new Date()) %>" maxlength="10"/></td>
  		</tr>
  		<tr><td colspan="2"><br><input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);"></td></tr>
  		<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
  	</table>
 </form>
 
 <% if (canView) { %>
  	<!-- product pricing listing -->
	<table class="listbox" width="700" cellspacing="0">
		<tr>
			<td class="boxhead" colspan="7"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRODUCT_PRICING_DETAILS%>"/></td>
		</tr>
		<tr class="boxhead" valign=top align="center">
			<td width="5%" align=right><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td width="10%"><i18n:label code="PRODUCT_SKU_CODE"/></td>
                        <td width="100%"><i18n:label code="PRODUCT_NAME"/></td>
			<td width="20%"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.CURRENT_PRICE%>"/></td>
			<td width="5%"><i18n:label code="GENERAL_STATUS"/></td>
			<td width="8%"><i18n:label code="PRICE_PERMANENT"/></td>
			<td width="8%"><i18n:label code="PRICE_PROMO"/></td>
		</tr>
		
		<%
		for (int i=0;i<productBeans.length;i++) { 
		%>
		<tr class="<%= (i%2 == 0) ? "even" : "odd"%>">
			<td width="5%" valign="top" align=right><%=(i+1)%>.</td>
			<td valign="top"><%=productBeans[i].getSkuCode()%></td>
                        <td valign="top"><%=productBeans[i].getDefaultDesc()%></td>
			<td valign="top">
				<%
					if (productBeans[i].getCurrentPricing()!=null) {	
				%>
				<table class="tbldata" width=100">
				  <!--
					<tr>
						<td colspan="2"><b><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.EFFECTIVE_PERIOD%>"/>:<br><%= productBeans[i].getCurrentPricing().getStartDate() %> to <%= productBeans[i].getCurrentPricing().getEndDate() %></b></td>
					</tr>
					-->
					<tr>
						<td width="100" align="right"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE%>"/>:</td>
						<td width="100" align="left"><%= productBeans[i].getCurrentPricing().getPrice() %></td>
					</tr>
					<tr>
						<td width="100" align="right"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.TAX%>"/>:</td>
						<td width="100" align="left"><%= productBeans[i].getCurrentPricing().getTax() %></td>
					</tr>
					<%= 
					productBeans[i].getCurrentPricing().getBv1()>0? 
					"<tr><td width='100' align='right'>BV1:</td><td width='100' align='left'>"+String.valueOf(productBeans[i].getCurrentPricing().getBv1())+"</td></tr>" :
					""
					%>
					<%= 
					productBeans[i].getCurrentPricing().getBv2()>0? 
					"<tr><td width='100' align='right'>BV2:</td><td width='100' align='left'>"+String.valueOf(productBeans[i].getCurrentPricing().getBv2())+"</td></tr>" :
					""
					%>
					<%= 
					productBeans[i].getCurrentPricing().getBv3()>0? 
					"<tr><td width='100' align='right'>BV3:</td><td width='100' align='left'>"+String.valueOf(productBeans[i].getCurrentPricing().getBv3())+"</td></tr>" :
					""
					%>
					<%= 
					productBeans[i].getCurrentPricing().getBv4()>0? 
					"<tr><td width='100' align='right'>BV4:</td><td width='100' align='left'>"+String.valueOf(productBeans[i].getCurrentPricing().getBv4())+"</td></tr>" :
					""
					%>
					<%= 
					productBeans[i].getCurrentPricing().getBv5()>0? 
					"<tr><td width='100' align='right'>BV5:</td><td width='100' align='left'>"+String.valueOf(productBeans[i].getCurrentPricing().getBv5())+"</td></tr>" :
					""
					%>
				</table>
				<%
					} else {
				%>
				<span class="">--</span>
				<%
					}
				%>
			</td>
			<td align="center" valign="top"><%= productBeans[i].getStatus() %></td>
			<td valign="top" align="center"><input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_MANAGE"/>" onClick="return popitup('<%=Sys.getControllerURL(ProductPricingManager.TASKID_PRICING_MANAGE,request)%>'+'&productid='+'<%=productBeans[i].getProductID()%>'+'&pricecode='+'<%=priceCodeSel%>'+'&type=N')"/></td>
			<td valign="top" align="center"><input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_MANAGE"/>" onClick="return popitup('<%=Sys.getControllerURL(ProductPricingManager.TASKID_PRICING_MANAGE,request)%>'+'&productid='+'<%=productBeans[i].getProductID()%>'+'&pricecode='+'<%=priceCodeSel%>'+'&type=Y')"/></td>
		</tr>
		<%
		} // end for
		%>


	</table>
	<!-- end listing -->
<% } // end if canView %>
</html>