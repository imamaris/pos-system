<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>

<% for (int i=0;i<BonusPeriodManager.STATUSLIST.length;i++) { %>
<option value="<%=BonusPeriodManager.STATUSLIST[i]%>"><%=BonusPeriodManager.STATUSLIST_STR[i]%></option>
<% } // end for %>