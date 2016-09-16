<%@ page import="com.ecosmosis.orca.pricing.*"%>

<%
	PriceCodeBean[] pricecodebeans = (PriceCodeBean[]) returnBean.getReturnObject("PriceCodeList");
%>

<% 
	if (pricecodebeans != null) { 
		
		String selected = "";
		
		if (pricecodebeans.length == 1)
			selected = "selected";
%>

	<option value="">[PRICE CODE]</option>
<% 
		for (int i=0;i<pricecodebeans.length;i++) { 
%>
	
	<option value="<%=pricecodebeans[i].getPriceCodeID()%>" <%= selected %>><%=pricecodebeans[i].getPriceCodeID()%> (<%=pricecodebeans[i].getName()%>)</option>
	
<% 
		} // end for 
%>

<% 
	} // end if 
%>
