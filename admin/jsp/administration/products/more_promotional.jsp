<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.pricing.*"%>
<%@ page import="com.ecosmosis.orca.pricing.product.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ProductPricingBean[] pricingBeans = (ProductPricingBean[]) returnBean.getReturnObject("PricingHistory");
	ProductBean productBean = (ProductBean) returnBean.getReturnObject("Product");
	
	boolean canView = false;
	if (pricingBeans != null)
		canView = true;
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead">Promotional Pricing Listing</div>

<%@ include file="/lib/return_error_msg.jsp"%>

<% if (canView) { %>
	<form name="frmAddPricing1" action="" method="post">
	<table class="tbldata" width="600">
	  	<tr>
  			<td align="right" width="150">SKU Code:</td>
      		<td width="450"><%= productBean.getSkuCode() %></td>
  		</tr>
  		<tr>
  			<td align="right" width="150">Product Name:</td>
      		<td width="450"><%= (productBean.getProductDescription().getLocale())!=null||(productBean.getProductDescription().getLocale().length())>0 ? productBean.getProductDescription().getName():productBean.getDefaultName()%></td>
  		</tr>
  		<tr>
  			<td align="right" width="150">Description:</td>
      		<td width="450"><%= (productBean.getProductDescription().getLocale())!=null||(productBean.getProductDescription().getLocale().length())>0 ? productBean.getProductDescription().getDescription():productBean.getDefaultDesc()%></td>
  		</tr>
  	</table>
  	<!-- product pricing history -->
	<table class="tbldata" width="700" cellspacing="1">
		<tr class="head" valign=top align="center">
			<td>No.</td>
			<td>Price Code</td>
			<td>Effective Date</td>
			<td>Price</td>
			<td>Tax</td>
			<td>BV1</td>
			<td>BV2</td>
			<td>BV3</td>
			<td>BV4</td>
			<td>BV5</td>
			<td>Status</td>
		</tr>
		<%
		if (pricingBeans.length<=0) {
		%>
		<tr><td colspan="6"><span class="required note">Record Not Exist !!</span></td></tr>
		<%
		} // end if
		%>
		<%
		for (int i=0;i<pricingBeans.length;i++) { 
		%>
		<tr class="<%= (i%2 == 0) ? "even" : "odd"%>">
			<td><%=(i+1)%></td>
			<td><%=pricingBeans[i].getPriceCode()%></td>
			<td><%=pricingBeans[i].getStartDate()%> to <%=pricingBeans[i].getEndDate()%></td>
			<td><%=pricingBeans[i].getPrice()%></td>
			<td><%=pricingBeans[i].getTax()%></td>
			<td><%=pricingBeans[i].getBv1()>0?String.valueOf(pricingBeans[i].getBv1()):"--"%></td>
			<td><%=pricingBeans[i].getBv2()>0?String.valueOf(pricingBeans[i].getBv2()):"--"%></td>
			<td><%=pricingBeans[i].getBv3()>0?String.valueOf(pricingBeans[i].getBv3()):"--"%></td>
			<td><%=pricingBeans[i].getBv4()>0?String.valueOf(pricingBeans[i].getBv4()):"--"%></td>
			<td><%=pricingBeans[i].getBv5()>0?String.valueOf(pricingBeans[i].getBv5()):"--"%></td>
			<td><%=pricingBeans[i].getStatus()%></td>
		</tr>
		<%
		} // end for
		%>
	</table>
	</form>

<% } // end if canView %>
</html>