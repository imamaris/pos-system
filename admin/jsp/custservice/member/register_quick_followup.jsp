<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%
	int size = 40;
	
  MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  MemberBean bean = (MemberBean) returnBean.getReturnObject(MemberManager.RETURN_MBRBEAN_CODE);

  AddressBean address = null;
  PayeeBankBean payeeBank = null;
  SpouseBean spouse = null;
  BeneficiaryBean bf = null;
  
  boolean canView = false;
  
	if (bean != null) {
		address = bean.getAddress();
		payeeBank = bean.getPayeeBank();
		spouse = bean.getSpouse();
		bf = bean.getBeneficiary();
	 	canView = true;
 	}
%>

<html>
<head>
  <title></title>

	<%@ include file="/lib/header.jsp"%>
	<%@ include file="/lib/select_locations.jsp"%>
	<%@ include file="/lib/select_banks.jsp"%>
	  
  <script language="javascript">
  
		function doSubmit(thisform) {
			
    	if (!validateText(thisform.AddressLine1)) {
				alert("<i18n:label code="MSG_ENTER_ADDRESS"/>");
				return;
			} else {
				thisform.MailAddressLine1.value = thisform.AddressLine1.value;
			}
			
			if (validateTextNoFocus(thisform.AddressLine2)) {
				thisform.MailAddressLine2.value = thisform.AddressLine2.value;
			}
			
			/*if (!validateZipCode(thisform.ZipCode)) {
				alert("Please enter ZipCode.");
				return;
			} else {
				thisform.MailZipCode.value = thisform.ZipCode.value;
			}*/
			
			thisform.MailZipCode.value = thisform.ZipCode.value;
			
			if (!validateObj(thisform.CountryID, 1)) {
				alert("<i18n:label code="MSG_ENTER_COUNTRY"/>");
				return;
			} else {
				thisform.MailCountryID.value = thisform.CountryID.options[thisform.CountryID.selectedIndex].value;
			}
			
			if (!validateObj(thisform.StateID, 0)) {
				alert("<i18n:label code="MSG_ENTER_STATE"/>");
				return;
			} else {
				thisform.MailStateID.value = thisform.StateID.options[thisform.StateID.selectedIndex].value;
			}
			
			if (!validateObj(thisform.CityID, 0)) {
				alert("<i18n:label code="MSG_ENTER_CITY"/>");
				return;
			} else {
				thisform.MailCityID.value = thisform.CityID.options[thisform.CityID.selectedIndex].value;
			}
			
			/*if (!isDate(thisform.DobStr)) {
				alert("Invalid DOB.");
				focusAndSelect(thisform.DobStr);
      	return;
    	}*/
      
    	if (thisform.NationalityID != null) {
	    	if (!validateObj(thisform.NationalityID, 1)) {
					alert("<i18n:label code="MSG_ENTER_NATIONALITY"/>");
					return;
				}
			}
			
			if (thisform.Gender != null) {	
				if ((!thisform.Gender[0].checked) && (!thisform.Gender[1].checked)) {
	        alert("<i18n:label code="MSG_ENTER_GENDER"/>");
	        focusAndSelect(thisform.Gender[0]);
	        return;
	    	}
  		}
  	
			/*if (!validateObj(thisform.Race, 1)) {
				alert("Please select a Race.");
				return;
			}*/ 
			
			if (thisform.Marital != null) {
				if ((!thisform.Marital[0].checked) && (!thisform.Marital[1].checked)) {
	        alert("<i18n:label code="MSG_ENTER_MARITAL"/>");
	        focusAndSelect(thisform.Marital[0]);
	        return;
	    	}
  		}
    	
    	/*if (!validateObj(thisform.PayoutCurrency, 1)) {
				alert("Please select a Payout Currency.");
				return;
			}*/
					
			thisform.submit();
		}
		
  </script>	
</head>

<body>

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.COMPLETE_FULL_REG%>"/></div>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<form name="frmEdit" action="<%=Sys.getControllerURL(MemberManager.TASKID_COMPLETE_INCOMPLETE_REG,request)%>" method="post">

	<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>

	<table class="tbldata" width="100%">
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    <td><%= (bean.getMemberID() != null) ? bean.getMemberID() : "Pending" %></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/>:</td>
                        <td><%= (bean.getJoinDate() != null) ? Sys.getDateFormater().format(bean.getJoinDate()): "" %></td>
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
		
		<%
			if (bean.getType().equals(MemberManager.MBRTYPE_COMPANY)) {
		%>
			
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_DATE%>"/>:</td>
			<td><std:input type="date" name="CompanyRegDateStr" value="<%= (bean.getCompanyRegDate() != null) ? Sys.getDateFormater().format(bean.getCompanyRegDate()): "" %>" size="<%= size %>"/></td>
		</tr>
		
		<%
			}
		%>
		
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
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MAILING_ADD%>"/>:</td>
			<td><std:input type="text" name="AddressLine1" value="<%= (address.getMailAddressLine1() != null) ? address.getMailAddressLine1() : "" %>" size="<%= size %>" maxlength="30"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><std:input type="text" name="AddressLine2" value="<%= (address.getMailAddressLine2() != null) ? address.getMailAddressLine2() : "" %>" size="<%= size %>" maxlength="30"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ZIP_CODE%>"/>:</td>
			<td><std:input type="text" name="ZipCode" value="<%= (address.getMailZipCode() != null) ? address.getMailZipCode() : "" %>" size="<%= size %>" maxlength="5"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/>:</td>
			<td><std:input type="select_country" name="CountryID" form="frmEdit" value="<%= (address.getCountryID() != null) ? address.getCountryID() : "" %>"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATE%>"/>:</td>
			<td><std:input type="select_state" name="StateID" form="frmEdit" value="<%= (address.getStateID() != null) ? address.getStateID() : "" %>"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CITY%>"/>:</td>
			<td><std:input type="select_city" name="CityID" form="frmEdit" value="<%= (address.getCityID() != null) ? address.getCityID() : "" %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_OFF%>"/>:</td>
			<td><std:input type="text" name="OfficeNo" value="<%= bean.getOfficeNo() != null ? bean.getOfficeNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_HOME%>"/>:</td>
			<td><std:input type="text" name="HomeNo" value="<%= bean.getHomeNo() != null ? bean.getHomeNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<!--
		<tr>
			<td align="right"><i18n:label code="GENERAL_NO_FAX"/>:</td>
			<td><std:input type="text" name="FaxNo" value="<%= bean.getFaxNo() != null ? bean.getFaxNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		-->
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MOBILE_NO%>"/>:</td>
			<td><std:input type="text" name="MobileNo" value="<%= bean.getMobileNo() != null ? bean.getMobileNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL%>"/>:</td>
			<td><std:input type="text" name="Email" value="<%= bean.getEmail() != null ? bean.getEmail() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.OCCUPATION%>"/>:</td>
			<td><std:input type="text" name="Occupation" value="<%= (bean.getOccupation() != null) ? bean.getOccupation() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DOB%>"/>:</td>
			<td>
				<std:input type="date" name="DobStr" value="<%= (bean.getDob() != null) ? Sys.getDateFormater().format(bean.getDob()) : "" %>" size="<%= size %>"/>
				&nbsp; (YYYY-MM-DD)
			</td>
		</tr>
		
		<%
			if (!bean.getType().equals(MemberManager.MBRTYPE_COMPANY)) {
		%>
		
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NATIONALITY%>"/>:</td>
			<td><std:input type="select_nationality" name="NationalityID" form="frmEdit" value="<%= (bean.getNationalityID() != null) ? bean.getNationalityID() : ""  %>"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.GENDER%>"/>:</td>
			<td>
				<std:input type="radio" name="Gender" value="M"   status="<%= bean.getGender() != null && bean.getGender().equals("M") ? "checked" : "" %>"/>&nbsp; <i18n:label code="GENERAL_MALE"/> &nbsp;&nbsp;&nbsp;
	      <std:input type="radio" name="Gender" value="F" status="<%= bean.getGender() != null && bean.getGender().equals("F") ? "checked" : "" %>"/>&nbsp; <i18n:label code="GENERAL_FEMALE"/>
	    </td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MARRIAGE%>"/>:</td>
			<td>
				<std:input type="radio" name="Marital" value="M" status="<%= bean.getMarital() != null && bean.getMarital().equals("M") ? "checked" : "" %>"/>&nbsp; <i18n:label code="GENERAL_YES"/> &nbsp;&nbsp;&nbsp;
				<std:input type="radio" name="Marital" value="S"  status="<%= bean.getMarital() != null && bean.getMarital().equals("S") ? "checked" : "" %>"/>&nbsp;  <i18n:label code="GENERAL_NO"/>
	    </td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CHILDREN%>"/>:</td>
			<td>
				<std:input type="radio" name="Children" value="0" status="<%= bean.getChildren() == 0 ? "checked" : "" %>"/>&nbsp; 0 &nbsp;&nbsp;&nbsp;
				<std:input type="radio" name="Children" value="1" status="<%= bean.getChildren() == 1 ? "checked" : "" %>"/>&nbsp; 1 &nbsp;&nbsp;&nbsp;
				<std:input type="radio" name="Children" value="2" status="<%= bean.getChildren() == 2 ? "checked" : "" %>"/>&nbsp; 2 &nbsp;&nbsp;&nbsp;
				<std:input type="radio" name="Children" value="3" status="<%= bean.getChildren() == 3 ? "checked" : "" %>"/>&nbsp; >=3
	    </td>
		</tr>
		
		<%
			}
		%>
		
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TAX_REG%>"/>:</td>
			<td><std:input type="text" name="IncomeTaxNo" value="<%= bean.getIncomeTaxNo() != null ? bean.getIncomeTaxNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td colspan="2">&nbsp</td>
		</tr>
		
		<%
			if (!bean.getType().equals(MemberManager.MBRTYPE_COMPANY)) {
		%>
		
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.SPOUSE_NAME%>"/>:</td>
			<td><std:input type="text" name="SpouseName" value="<%= (spouse.getSpouseName() != null) ? spouse.getSpouseName() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.SPOUSE_IC_NO%>"/>:</td>
			<td><std:input type="text" name="SpouseNric" value="<%= (spouse.getSpouseNric() != null) ? spouse.getSpouseNric() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.SPOUSE_DOB%>"/>:</td>
			<td>
				<std:input type="date" name="SpouseDobStr" value="<%= (spouse.getSpouseDob() != null) ? Sys.getDateFormater().format(spouse.getSpouseDob()): "" %>" size="<%= size %>"/>
				&nbsp; (YYYY-MM-DD)
			</td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BENEFICIARY_NAME%>"/>:</td>
			<td><std:input type="text" name="BfName" value="<%= (bf.getBfName() != null) ? bf.getBfName() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td colspan="2">&nbsp</td>
		</tr>
		
		<%
			}
		%>
		
		<!--
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.PAYOUT_CURRENCY%>"/>:</td>
			<td><std:input type="select_currency" name="PayoutCurrency" form="frmEdit" value="<%= bean.getPayoutCurrency() != null ? bean.getPayoutCurrency() : "" %>" size="<%= size %>"/></td>
		</tr>
		-->
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BANK%>"/>:</td>
			<td><std:input type="select_bank" name="BankID" form="frmEdit" value="<%= payeeBank.getBankID() != null ? payeeBank.getBankID() : "" %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BANK_ACCOUNT_HOLDER%>"/>:</td>
			<td><std:input type="text" name="BankPayeeName" value="<%= (payeeBank.getBankPayeeName() != null) ? payeeBank.getBankPayeeName() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BANK_ACCOUNT_NO%>"/>:</td>
			<td><std:input type="text" name="BankAcctNo" value="<%= (payeeBank.getBankAcctNo() != null) ? payeeBank.getBankAcctNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BRANCH%>"/>:</td>
			<td><std:input type="text" name="BankBranch" value="<%= (payeeBank.getBankBranch() != null) ? payeeBank.getBankBranch() : "" %>" size="<%= size %>"/></td>
		</tr>
		<!--
		<tr>
			<td align="right">Bank Account Type:</td>
			<td><std:input type="text" name="BankAcctType" value="<%= (payeeBank.getBankAcctType() != null) ? payeeBank.getBankAcctType() : "" %>" size="<%= size %>"/></td>
		</tr>
		-->
	</table>
  
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="MailAddressLine1"/> 
	<std:input type="hidden" name="MailAddressLine2"/>
	<std:input type="hidden" name="MailZipCode"/> 
	<std:input type="hidden" name="MailCountryID"/>
	<std:input type="hidden" name="MailStateID"/> 
	<std:input type="hidden" name="MailCityID"/>
  <std:input type="hidden" name="MemberID" value="<%= bean.getMemberID() %>"/> 
   
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" onClick="doSubmit(this.form);"> 
</form>

<% 
	} // end canView
%>

</body>
</html>