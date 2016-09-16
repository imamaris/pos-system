<%@ page import="com.ecosmosis.orca.bvwallet.*"%>

<% for (int i=0;i<BvWalletManager.TRXFROM.length;i++) { %>
<option value="<%=BvWalletManager.TRXFROM[i]%>"><%=BvWalletManager.TRXFROM_STR[i]%></option>
<% } // end for %>
