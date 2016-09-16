<%@ page import="com.ecosmosis.orca.outlet.*"%>


<%
	OutletBean[] outletbeans = (OutletBean[]) returnBean.getReturnObject("OutletList");
%>

<% if (outletbeans != null) { %>
<% for (int i=0;i<outletbeans.length;i++) { %>
<option value="<%=outletbeans[i].getOutletID()%>">(<%=outletbeans[i].getOutletID()%>)&nbsp;<%=outletbeans[i].getName()%> </option>
<% } // end for %>
<% } // end if %>