<%@ page import="com.ecosmosis.common.currency.*"%>


<%
	CurrencyBean[] currencybeans = (CurrencyBean[]) returnBean.getReturnObject("CurrencyList");
%>

<% if (currencybeans != null) { %>
<% for (int i=0;i<currencybeans.length;i++) { %>
<option value="<%=currencybeans[i].getSymbol()%>"><%=currencybeans[i].getName()%> (<%=currencybeans[i].getSymbol()%>)</option>
<% } // end for %>
<% } // end if %>