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
				alert("Please select Price Code.");
					thisform.SkuCode.focus();
			}
			thisform.submit();
		}
		function popitup(url)
		{
			newwindow=window.open(url,'name','height=700,width=750');
			if (window.focus) {newwindow.focus()}
			return false;
		}
		function morePopup(url)
		{
			newwindow=window.open(url,'name','height=700,width=750');
			if (window.focus) {newwindow.focus()}
			return false;
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICING_LISTING%>"/></div>

<form name="frmManagePricing1" action="<%=Sys.getControllerURL(ProductPricingManager.TASKID_PRICING_LISTING,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

	<table class="tbldata" width="500">
	  	<tr>
  			<td align="right" width="80"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE_CODE%>"/>:</td>
      		

                
                <td>RTL</td>
                <std:input type="hidden" name="PriceCode" value="RTL"/>

  		</tr>
  		<tr><td colspan="2"><br><input class="textbutton" type="button" value="   OK   " onClick="doSubmit(this.form);"></td></tr>
  		<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
  	</table>
 </form>
 
 <% if (canView) { %>
  	<!-- product pricing listing -->
	<table class="listbox" width="100%" cellspacing="0">
		<tr>
			<td colspan="7" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRODUCT_PRICING_DETAILS%>"/></td>
		</tr>
		<tr class="boxhead" valign=top align="center">
			<td ><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td nowrap>Product Code</td>
                        <td nowrap>Serial Number</td>
                        <td>Product Name</td>
			<td><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PERMANENT_PRICE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/></td>
		</tr>
		
		<%
		for (int i=0;i<productBeans.length;i++) { 
			
			String rowCss = "";
  		  	
  		  	if((i+1) % 2 == 0)
  	      		rowCss = "even";
  	      	else
  	        	rowCss = "odd";
		%>
		<tr class="<%=rowCss%>">
			<td width="30" align="center" valign="top"><%=(i+1)%></td>
			<td align="center" valign="top"><%=productBeans[i].getProductCode()%></td>
                        <td align="center" valign="top"><%=productBeans[i].getSkuCode()%></td>
			<td align="left" valign="top"><%=productBeans[i].getDefaultDesc()%></td>
                        
			<!-- Permanent Price -->
			<td align="center" valign="top">
			<table width="200" cellspacing="0">
                            
			<%
			if (productBeans[i].getLatestPermanentPricing().getPricingID()>0) {	
			%>
				<tr>
					<td colspan="2"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.EFFECTIVE_PERIOD%>"/>:<br><%= productBeans[i].getLatestPermanentPricing().getStartDate() %> to <%= productBeans[i].getLatestPermanentPricing().getEndDate() %></td>
				</tr>
				<tr>
					<td width="100" align="right"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE%>"/>:</td>
					<td width="100" align="left"><%= productBeans[i].getLatestPermanentPricing().getPrice() %></td>
				</tr>
				<tr>
					<td width="100" align="right"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.TAX%>"/>:</td>
					<td width="100" align="left"><%= productBeans[i].getLatestPermanentPricing().getTax() %></td>
				</tr>
				<%= 
				productBeans[i].getLatestPermanentPricing().getBv1()>0? 
				"<tr><td width='100' align='right'>BV1:</td><td width='100' align='left'>"+String.valueOf(productBeans[i].getLatestPermanentPricing().getBv1())+"</td></tr>" :
				""
				%>
				<%= 
				productBeans[i].getLatestPermanentPricing().getBv2()>0? 
				"<tr><td width='100' align='right'>BV2:</td><td width='100' align='left'>"+String.valueOf(productBeans[i].getLatestPermanentPricing().getBv2())+"</td></tr>" :
				""
				%>
				<%= 
				productBeans[i].getLatestPermanentPricing().getBv3()>0? 
				"<tr><td width='100' align='right'>BV3:</td><td width='100' align='left'>"+String.valueOf(productBeans[i].getLatestPermanentPricing().getBv3())+"</td></tr>" :
				""
				%>
				<%= 
				productBeans[i].getLatestPermanentPricing().getBv4()>0? 
				"<tr><td width='100' align='right'>BV4:</td><td width='100' align='left'>"+String.valueOf(productBeans[i].getLatestPermanentPricing().getBv4())+"</td></tr>" :
				""
				%>
				<%= 
				productBeans[i].getLatestPermanentPricing().getBv5()>0? 
				"<tr><td width='100' align='right'>BV5:</td><td width='100' align='left'>"+String.valueOf(productBeans[i].getLatestPermanentPricing().getBv5())+"</td></tr>" :
				""
				%>
			<%
			} else {
			%>
			<span class="">--</span>
			<%
			}
			%>
			</table>
			</td>
			
                        
			<td align="center" valign="top"><%= productBeans[i].getStatus() %></td>
		</tr>
		<%
		} // end for
		%>


	</table>
	<!-- end listing -->
<% } // end if canView %>
</html>