<%@ page import="com.ecosmosis.orca.bvwallet.*"%>

<% for (int i=0;i<BvWalletManager.TRXTYPES.length;i++) { %>
<option value="<%=BvWalletManager.TRXTYPES[i]%>"><%=BvWalletManager.TRXTYPES_STR[i]%></option>
<% } // end for %>
