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
	String DeditURL = Sys.getControllerURL(MemberManager.TASKID_MBRSHIP_EDIT,request);

  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	MemberBean[] beans = (MemberBean[]) returnBean.getReturnObject(MemberManager.RETURN_MBRLIST_CODE);
	
	boolean canView = false;
	if (beans != null && beans.length > 0) {
		canView = true;	
 	}
%>

<html>
<head>
	<title></title>
	
	<%@ include file="/lib/header.jsp"%>
</head>

<body>
  
<div class="functionhead"><i18n:label localeRef="mylocale" code="Paket 1100PV Registration Listing"/></div>	

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<table>
	<tr>
		<td>
			<table class="listbox" width="100">
				<tr>
					<td class="totalhead" width="50"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TOTAL%>"/></td>
					<td width="50"><%= beans.length %></td>
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
  <tr class="boxhead" valign=top>
    <td width="5%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
    <td width="13%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/></td>
    <td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
    <td width="10%"><i18n:label localeRef="mylocale" code="<%= StandardMessageTag.CONTACT_INFORMATION %>" /></td>
    <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/></td>
    <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP%>"/></td>
    <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_REG%>"/></td>
    <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.CREATED%>"/></td>
    <td width="3%"></td>
  </tr>
	
    <%
  	for (int i=0; i<beans.length; i++) { 
    	
			String rowCss = "";
	  	
	  	if((i+1) % 2 == 0)
      	rowCss = "even";
      else
        rowCss = "odd";

      if (beans[i].getStatus() != MemberManager.MBRSHIP_ACTIVE)
        rowCss = "alert";
  %>
	<tr class="<%= rowCss %>" valign=top>
    <td><%= i+1 %>.</td>
	  <td nowrap><%= beans[i].getMemberID() %></td>
    <td><%= beans[i].getName() %></td>
    <td nowrap><%= beans[i].getContactInfo() != null ? beans[i].getContactInfo().replaceAll("\n", "<br>") : "-" %></td>
    <td align="center" nowrap><%= (beans[i].getJoinDate() != null) ? Sys.getDateFormater().format(beans[i].getJoinDate()): "" %></td>
    <td align="center" nowrap><%= MemberManager.defineMbrshipStatus(beans[i].getStatus()) %></td>
    <td align="center" nowrap><%= MemberManager.defineRegisterType(beans[i].getRegister()) %></td>
    <td nowrap>
    	<%= ((beans[i].getStd_createBy() != null) ? beans[i].getStd_createBy() : "" )%>
    </td>	
    <td>
    	<a href="<%= DeditURL %>&MemberID=<%= beans[i].getMemberID() %>">
				<img border="0" alt='Complete Distributor Profile' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/>
			</a>
    </td>
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