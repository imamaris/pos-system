<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<table class="tbldata" width="100%">
	<tr>
		<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
                <td><%= bean.getMemberID() %></td>
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
		<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INDIVIDUAL%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.CORPORATION_NAME%>"/>:</td>
		<td><std:text value="<%= bean.getName() %>" defaultvalue="-"/></td>
	</tr>
	<tr valign="top">
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.:</td>
		<td><std:text value="<%= bean.getIdentityNo() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_DATE%>"/>:</td>
		<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getCompanyRegDate() %>" /></td>
	</tr>
	<tr>
		<td align="right" width="180"><i18n:label code="DISTRIBUTOR_UPLINE_ID"/>:</td>
		<td><std:text value="<%= bean.getIntroducerID() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_NAME"/>:</td>
		<td><std:text value="<%= bean.getIntroducerName() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_CONTACT"/>:</td>
		<td><std:text value="<%= bean.getIntroducerContact() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label code="DISTRIBUTOR_PLACEMENT_ID"/>:</td>
		<td><std:text value="<%= bean.getPlacementID() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp</td>
	</tr>
	<tr valign="top">
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MAILING_ADD%>"/>:</td>
		<td><std:text value="<%= address.getMailAddressLine1() %>"/> <br>
				<std:text value="<%= address.getMailAddressLine2() %>"/>
		</td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ZIP_CODE%>"/>:</td>
		<td><std:text value="<%= address.getMailZipCode() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/>:</td>
		<td><%= (address.getMailCountry() != null && address.getMailCountry().getName() != null) ? address.getMailCountry().getName() : "" %></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATE%>"/>:</td>
		<td><%= (address.getMailState() != null && address.getMailState().getName() != null) ? address.getMailState().getName() : "" %></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CITY%>"/>:</td>
		<td><%= (address.getMailCity() != null && address.getMailCity().getName() != null) ? address.getMailCity().getName() : "" %></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_OFF%>"/>:</td>
		<td><std:text value="<%= bean.getOfficeNo() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_HOME%>"/>:</td>
		<td><std:text value="<%= bean.getHomeNo() %>" defaultvalue="-"/></td>
	</tr>
	<!--
	<tr>
		<td align="right"><i18n:label code="GENERAL_NO_FAX"/>:</td>
		<td><std:text value="<%= bean.getFaxNo() %>" defaultvalue="-"/></td>
	</tr>
	-->
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MOBILE_NO%>"/>:</td>
		<td><std:text value="<%= bean.getMobileNo() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL%>"/>:</td>
		<td><std:text value="<%= bean.getEmail() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.OCCUPATION%>"/>:</td>
		<td><std:text value="<%= bean.getOccupation() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DOB%>"/>:</td>
		<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getDob() %>" /></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TAX_REG%>"/>:</td>
		<td><std:text value="<%= bean.getIncomeTaxNo() %>" defaultvalue="-"/>
	</tr>
	<tr>
		<td colspan="2">&nbsp</td>
	</tr>
	<!--
	<tr>
		<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.PAYOUT_CURRENCY%>"/>:</td>
		<td><%= bean.getPayoutCurrency() != null ? bean.getPayoutCurrency() : "" %></td>
	</tr>
	-->
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BANK%>"/>:</td>
		<td><%= (payeeBank.getBankBean() != null && payeeBank.getBankBean().getName() != null) ? payeeBank.getBankBean().getName() : "" %></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BANK_ACCOUNT_HOLDER%>"/>:</td>
		<td><std:text value="<%= payeeBank.getBankPayeeName() %>" defaultvalue="-"/></td>		
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BANK_ACCOUNT_NO%>"/>:</td>
		<td><std:text value="<%= payeeBank.getBankAcctNo() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BRANCH%>"/>:</td>
		<td><std:text value="<%= payeeBank.getBankBranch() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp</td>
	</tr>
	<tr>
		<td align="right"><i18n:label code="GENERAL_REMARK"/>:</td>
		<td><std:text value="<%= bean.getRemark() %>" defaultvalue="-"/></td>
	</tr>
</table>

