<%@ page import="com.ecosmosis.orca.pricing.*"%>

<% for (int i=0;i<PriceCodeBean.PRICE_CODE_TYPE.length;i++) { %>
<option value="<%=PriceCodeBean.PRICE_CODE_TYPEID[i]%>"><%=lang.display(PriceCodeBean.PRICE_CODE_TYPE[i])%></option>
<% } // end for %>
