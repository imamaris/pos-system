<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<table class="tbldata" width="100%">
	<tr>
                <td align="right" width="180">Customer ID :</td>
                <td><%= bean.getMemberID() %></td>  
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MOBILE_NO%>"/>:</td>
		<td><std:text value="<%= bean.getMobileNo() %>" defaultvalue="-"/></td>
	</tr>        
	<tr>
		<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/>:</td>
                <td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getJoinDate() %>" /></td>
	</tr>
	<tr>
		<td align="right" width="180"><i18n:label code="MBR007"/>:</td>
		<td><%= MemberManager.defineMbrshipStatus(bean.getStatus()) %></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_TYPE%>"/>:</td>
		<td><%= MemberManager.defineMbrType(bean.getType()) %></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_REG%>"/>:</td>
		<td><%= MemberManager.defineRegisterType(bean.getRegister()) %></td>
	</tr>
        <tr valign="top">
		<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INDIVIDUAL%>"/> :</td>
		<td><std:text value="<%= bean.getName() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right" >Birth Date:</td>
                <td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getDob() %>" /></td>
	</tr>          
        
	<tr valign="top">
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.:</td>
		<td><std:text value="<%= bean.getIdentityNo() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp</td>
	</tr>
	<tr valign="top">
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MAILING_ADD%>"/>:</td>
		<td><std:text value="<%= address.getAddressLine1() %>"/> <br>
				<std:text value="<%= address.getAddressLine2() %>"/>
		</td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ZIP_CODE%>"/>:</td>
		<td><std:text value="<%= address.getMailZipCode() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/>:</td>
		<td><%= (address.getCountry() != null && address.getCountry().getName() != null) ? address.getCountry().getName() : "" %></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATE%>"/>:</td>
		<td><%= (address.getRegion() != null && address.getRegion().getName() != null) ? address.getRegion().getName() : "" %></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CITY%>"/>:</td>
		<td><%= (address.getCity() != null && address.getCity().getName() != null) ? address.getCity().getName() : "" %></td>
	</tr>       
        <tr>
		<td align="right"><i18n:label code="GENERAL_REMARK"/>:</td>
		<td><std:text value="<%= bean.getRemark() %>" defaultvalue="-"/></td>
	</tr>
</table>

