<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>

<%
	BonusPeriodBean[] bonusperiodbeans = (BonusPeriodBean[]) returnBean.getReturnObject("BonusPeriodList");
%>

<% if (bonusperiodbeans != null) { %>
<% for (int i=0;i<bonusperiodbeans.length;i++) { %>
<option value="<%=bonusperiodbeans[i].getPeriodID()%>"><%=bonusperiodbeans[i].getPeriodID()%></option>
<% } // end for %>
<% } // end if %>