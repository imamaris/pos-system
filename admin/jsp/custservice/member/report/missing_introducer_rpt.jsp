<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	MemberBean[] missingBeans = (MemberBean[]) returnBean.getReturnObject("MissingIntroducer");
	MemberBean[] unparseBeans = (MemberBean[]) returnBean.getReturnObject("UnparseTree");
	
	boolean canView = false;
	if (missingBeans != null && missingBeans.length > 0)
	 	canView = true;	 
%>

<html>
<head>
	<title></title>
	
	<%@ include file="/lib/header.jsp"%>
</head>

<body>
  
<div class="functionhead"><i18n:label code="DISTRIBUTOR_UPLINE_MISS_RPT"/></div>	

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<table>
	<tr valign="top">
		<td>
			<table class="listbox" width="150">
				<tr>
					<td class="totalhead" width="130"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TOTAL_MISSING%>"/></td>
					<td width="50"><%= missingBeans.length %></td>
				</tr>
				<tr>
					<td class="totalhead" width="130"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TOTAL_UNPARSE%>"/></td>
					<td width="50"><%= unparseBeans.length %></td>
				</tr>
			</table>
		</td>
		<td>&nbsp;</td>
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
		</td>
	</tr>
</table>

<br>

<% 
	if (canView) { 
%>

<table class="listbox" width="100%">
	<tr class="boxhead">
		<td colspan="8"><i18n:label code="DISTRIBUTOR_UPLINE_MISS_LIST"/></td>
	</tr>	
  <tr class="boxhead" valign=top>
    <td width="5%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
    <td width="13%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/></td>
    <td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
    <td width="13%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <br> <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.</td>
    <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/></td>
    <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP%>"/></td>
    <td width="13%">Upline ID</td>
    <td width="13%">Sponsor ID</td>
  </tr>
	
    <%
  	for (int i=0; i<missingBeans.length; i++) { 
    	
	  	String rowCss = "";
	  	
	  	if((i+1) % 2 == 0)
      	rowCss = "even";
      else
        rowCss = "odd";

      if (missingBeans[i].getStatus() != MemberManager.MBRSHIP_ACTIVE)
        rowCss = "alert";
  %>
	<tr class="<%= rowCss %>" valign=top>
    <td nowrap><%= i+1 %>.</td>
	  <td><%= missingBeans[i].getMemberID() %></td>
    <td><%= missingBeans[i].getName() %></td>
    <td nowrap><%= missingBeans[i].getIdentityNo() %></td>
    <td align="center" nowrap><%= (missingBeans[i].getJoinDate() != null) ? Sys.getDateFormater().format(missingBeans[i].getJoinDate()): "" %></td>
    <td align="center" nowrap><%= MemberManager.defineMbrshipStatus(missingBeans[i].getStatus()) %></td>
    <td nowrap><%= missingBeans[i].getIntroducerID() %></td>
    <td nowrap><%= missingBeans[i].getPlacementID() %></td>
  </tr>
		    
	<% 
		} // end for 
	%>

</table>  

<br>

<hr>

<br>

<table class="listbox" width="100%">
	<tr class="boxhead">
		<td colspan="8"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.UNPARSE_TREE_LISTING%>"/></td>
	</tr>	
  <tr class="boxhead" valign=top>
    <td width="5%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
    <td width="13%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/></td>
    <td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
    <td width="13%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <br> <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.</td>
    <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/></td>
    <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP%>"/></td>
    <td width="13%">Upline ID</td>
    <td width="13%">Sponsor ID</td>
  </tr>

  <%
  	for (int i=0; i<unparseBeans.length; i++) { 
    	
	  	String rowCss = "";
	  	
	  	if((i+1) % 2 == 0)
      	rowCss = "even";
      else
        rowCss = "odd";

      if (unparseBeans[i].getStatus() != MemberManager.MBRSHIP_ACTIVE)
        rowCss = "alert";
  %>
	<tr class="<%= rowCss %>" valign=top>
    <td nowrap><%= i+1 %>.</td>
	  <td><%= unparseBeans[i].getMemberID() %></td>
    <td><%= unparseBeans[i].getName() %></td>
    <td nowrap><%= unparseBeans[i].getIdentityNo() %></td>
    <td align="center" nowrap><%= (unparseBeans[i].getJoinDate() != null) ? Sys.getDateFormater().format(unparseBeans[i].getJoinDate()): "" %></td>
    <td align="center" nowrap><%= MemberManager.defineMbrshipStatus(unparseBeans[i].getStatus()) %></td>
    <td nowrap><%= unparseBeans[i].getIntroducerID() %></td>
    <td nowrap><%= unparseBeans[i].getPlacementID() %></td>
  </tr>
		    
	<% 
		} // end for 
	%>

</table> 

<% 
	} // end canView 
%>

</body>
</html>