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
  int memberIDLength = 12;
	
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
  String memberID = (String) returnBean.getReturnObject("MemberID");
  String introducerID = (String) returnBean.getReturnObject("IntroducerID");
  String introducerName = (String) returnBean.getReturnObject("IntroducerName");
  String introducerContact = (String) returnBean.getReturnObject("IntroducerContact");
  String placementID = (String) returnBean.getReturnObject("PlacementID");
  
  String bonusDate = (String) returnBean.getReturnObject("BonusDateStr");
  String joinDateStr = (String) returnBean.getReturnObject("JoinDateStr");
  String type = (String) returnBean.getReturnObject("Type");
  String Register  = (String) returnBean.getReturnObject("Register");
          
  String name = (String) returnBean.getReturnObject("Name");
  String password = (String) returnBean.getReturnObject("Password");

  String identityNo = (String) returnBean.getReturnObject("IdentityNo");
  String identityType = (String) returnBean.getReturnObject("IdentityType");
  
  String chkIntrID = (String) returnBean.getReturnObject("ChkIntrID");
	String chkPlaceID = (String) returnBean.getReturnObject("ChkPlaceID");
	String noPin = (String) returnBean.getReturnObject("nopin");
	String bonusPeriodID = (String) returnBean.getReturnObject("BonusPeriodID");
%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>
	<%@ include file="/lib/select_locations.jsp"%>
	<%@ include file="/lib/select_banks.jsp"%>
	
	<script language="javascript">

		function doCopy() {
			
			var thisform = document.frmCreate;
			thisform.IntroducerID.value = thisform.PlacementID.value;
	  	}
	  	
		function doSubmit(thisform) {
			
			if (!validateMemberId(thisform.MemberID)) {
				alert("<i18n:label code="MSG_INVALID_MEMBERID"/>");
				focusAndSelect(thisform.MemberID);
				return;
	  	}
		  
	  	if (validateMemberIntroducer(thisform.IntroducerID, null, 0)) {
				if (!validateDupID(thisform.MemberID, thisform.IntroducerID)) {
					alert("<i18n:label code="MSG_UPLINE_NOTSAME_ID"/>");
					focusAndSelect(thisform.IntroducerID);
					return;
		  	}
			}
	  	
	  	if (!validateMemberIntroducer(thisform.PlacementID, null, 0)) {
				alert("<i18n:label code="MSG_ENTER_PLACEMENTID"/>");
				focusAndSelect(thisform.IntroducerID);
				return;
			} 
			
			if (!validateDupID(thisform.MemberID, thisform.PlacementID)) {
				alert("<i18n:label code="MSG_PLACEMENT_NOTSAME_ID"/>");
				focusAndSelect(thisform.IntroducerID);
				return;
	  	}
			
			/*if (!isDate(thisform.JoinDateStr)) {
				alert("Invalid Join Date.");
				focusAndSelect(thisform.JoinDateStr);
      	return;
    	}*/
    	
    	if (!validateMemberRegisterFormNo(thisform.RegFormNo)) {
				alert("<i18n:label code="MSG_INVALID_REGNUM"/>");
				focusAndSelect(thisform.RegFormNo);
				return;
			}
			
			if (!validateText(thisform.Name)) {
				alert("<i18n:label code="MSG_ENTER_NAME"/>");
				focusAndSelect(thisform.Name);
				return;
			} else {
				thisform.DisplayName.value = thisform.Name.value;
			}
				
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
					focusAndSelect(thisform.Gender[0]);
	        alert("<i18n:label code="MSG_ENTER_GENDER"/>");
	        return;
	    	}
  		}
			
			/*if (!validateObj(thisform.Race, 1)) {
				alert("Please select a Race.");
				return;
			}*/ 
			
			if (thisform.Marital != null) {
				if ((!thisform.Marital[0].checked) && (!thisform.Marital[1].checked)) {
					focusAndSelect(thisform.Marital[0]);
	        alert("<i18n:label code="MSG_ENTER_MARITAL"/>");
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

<div class="functionhead">Registration </div>

<form name="frmCreate" action="<%=Sys.getControllerURL(MemberManager.TASKID_FULL_REG_FORM,request)%>" method="post">

	<%@ include file="/lib/return_error_msg.jsp"%>
	
	<%@ include file="/admin/jsp/custservice/member/register_checklist.jsp"%>
		
  <p class="required note">* <i18n:label code="GENERAL_REQUIRED_
  FIELDS"/></p>
         
	<table class="tbldata" width="100%">
  	<tr>
			<td align="right" width="180"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
			<td><std:input type="text" name="MemberID" value="<%= memberID != null ? memberID : "" %>" size="<%= size %>" maxlength="<%= memberIDLength %>"/></td>
		</tr>
		
		<%
			if (noPin == null) {
		%>
		
		<tr>
			<td align="right" width="180"><i18n:label code="DISTRIBUTOR_PIN_CODE"/>:</td>
			<td><I><i18n:label code="MSG_EPIN_NOT_DISPLAY"/></I></td>							
		</tr>
		
		<!-- 
		<tr>
			<td class="td1" width="180"><span class="required note">* </span><i18n:label code="BONUS_PERIOD"/>:</td>
			<td><%= bonusDate %></td>
		</tr>
		 -->
		
		<tr>
	 	    <td align="right" width="180"><span class="required note">* </span> Bonus Date:</td>
	 	    <td><std:input type="date" name="BonusDate" value="<%= bonusDate != null ? bonusDate : "" %>" size="<%= size %>"/>&nbsp; (YYYY-MM-DD)</td>
	    </tr>
		
		<% 
			} else { 
		%>
		
		<std:input type="hidden" name="nopin" value="f"/>
		
		<% 
			} 
		%>
		
		<tr>
			<td align="right" width="180"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/>:</td>
      <td><std:input type="date" name="JoinDateStr" value="<%= joinDateStr != null ? joinDateStr : "" %>" size="<%= size %>"/>&nbsp; (YYYY-MM-DD)</td>
  	</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_TYPE%>"/>:</td>
			<td>
				<%= MemberManager.defineMbrType(type) %>
				<std:input type="hidden" name="Type" value="<%= type != null ? type : "" %>"/>
			</td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_REG%>"/>:</td>
			<td>
				<%= MemberManager.defineRegisterType2(Register) %>
				<std:input type="hidden" name="Register" value="<%= Register != null ? Register : "" %>"/>
			</td>
		</tr>
		<tr>
			<td align="right" width="180"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INDIVIDUAL%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.CORPORATION_NAME%>"/>:</td>
			<td><std:input type="text" name="Name" value="<%= name != null ? name : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.IC_NO%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>:</td>
			<td><%= identityNo != null ? identityNo : "" %></td>
		</tr>
		
		<%
			if (type.equals(MemberManager.MBRTYPE_COMPANY)) {
		%>
		
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_DATE%>"/>:</td>
			<td>
				<std:input type="date" name="CompanyRegDateStr" size="<%= size %>"/>
				&nbsp; (YYYY-MM-DD)
			</td>
		</tr>
		
		<%
			}
		%>
		<tr>
			<td align="right" width="180"><span class="required note">* </span><i18n:label code="DISTRIBUTOR_PLACEMENT_ID"/>:</td>
			<td>
				<std:input type="text" name="PlacementID" value="<%= placementID != null ? placementID : "" %>" size="<%= size %>" maxlength="<%= memberIDLength %>"/>
				<a href="javascript:popupSmall('<%=Sys.getControllerURL(MemberManager.TASKID_SEARCH_MEMBERS_ALL_BY,request) %>&FormName=frmCreate&ObjName=PlacementID')">
  					<img border="0" alt='Search Sponsor' src="<%= Sys.getWebapp() %>/img/lookup.gif"/>
  				</a>
   			</td>
		</tr>		
		<tr>
			<td align="right" width="180"><i18n:label code="DISTRIBUTOR_UPLINE_ID"/>:</td>
			<td>
				<std:input type="text" name="IntroducerID" value="<%= introducerID != null ? introducerID : "" %>" size="<%= size %>" maxlength="<%= memberIDLength %>"/>
				<a href="javascript:popupSmall('<%=Sys.getControllerURL(MemberManager.TASKID_SEARCH_MEMBERS_ALL_BY,request) %>&FormName=frmCreate&ObjName=IntroducerID&PropName=IntroducerName')">
  				<img border="0" alt='Search Introducer' src="<%= Sys.getWebapp() %>/img/lookup.gif"/>
  			</a>
  			&nbsp;&nbsp;
			<a href="Javascript:doCopy();"><small><i18n:label code="DISTRIBUTOR_SAMEAS_PLACEMENT"/></small></a>
			</td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_NAME"/>:</td>
			<td><std:input type="text" name="IntroducerName" value="<%= introducerName != null ? introducerName : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_CONTACT"/>:</td>
			<td><std:input type="text" name="IntroducerContact" value="<%= introducerContact != null ? introducerContact : "" %>" size="<%= size %>"/></td>
		</tr>

    <tr>
			<td colspan="2">&nbsp</td>
		</tr>
  	<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MAILING_ADD%>"/>:</td>
			<td><std:input type="text" name="AddressLine1" value="" size="<%= size %>" maxlength="30"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><std:input type="text" name="AddressLine2" value="" size="<%= size %>" maxlength="30"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ZIP_CODE%>"/>:</td>
			<td><std:input type="text" name="ZipCode" value="" size="<%= size %>" maxlength="5"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/>:</td>
			<td><std:input type="select_country" name="CountryID" form="frmCreate"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATE%>"/>:</td>
			<td><std:input type="select_state" name="StateID" form="frmCreate"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CITY%>"/>:</td>
			<td><std:input type="select_city" name="CityID" form="frmCreate"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_OFF%>"/>:</td>
			<td><std:input type="text" name="OfficeNo" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_HOME%>"/>:</td>
			<td><std:input type="text" name="HomeNo" size="<%= size %>"/></td>
		</tr>
		<!--
		<tr>
			<td align="right"><i18n:label code="GENERAL_NO_FAX"/>:</td>
			<td><std:input type="text" name="FaxNo" size="<%= size %>"/></td>
		</tr>
		-->
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MOBILE_NO%>"/>:</td>
			<td><std:input type="text" name="MobileNo" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL%>"/>:</td>
			<td><std:input type="text" name="Email" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.OCCUPATION%>"/>:</td>
			<td><std:input type="text" name="Occupation" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DOB%>"/>:</td>
			<td>
				<std:input type="date" name="DobStr" size="<%= size %>"/>
				&nbsp; (YYYY-MM-DD)
			</td>
		</tr>
		
		<%
			if (!type.equals(MemberManager.MBRTYPE_COMPANY)) {
		%>
		
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NATIONALITY%>"/>:</td>
			<td><std:input type="select_nationality" name="NationalityID" form="frmCreate"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.GENDER%>"/>:</td>
			<td>
				<std:input type="radio" name="Gender" value="M"/>&nbsp; <i18n:label code="GENERAL_MALE"/> &nbsp;&nbsp;&nbsp;
        		<std:input type="radio" name="Gender" value="F"/>&nbsp; <i18n:label code="GENERAL_FEMALE"/>
      </td>
 		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MARRIAGE%>"/>:</td>
			<td>
				<std:input type="radio" name="Marital" value="M"/>&nbsp; <i18n:label code="GENERAL_YES"/> &nbsp;&nbsp;&nbsp;
				<std:input type="radio" name="Marital" value="S"/>&nbsp; <i18n:label code="GENERAL_NO"/>
      </td>
 		</tr>
 		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CHILDREN%>"/>:</td>
			<td>
				<std:input type="radio" name="Children" value="0"/>&nbsp; 0 &nbsp;&nbsp;&nbsp;
				<std:input type="radio" name="Children" value="1"/>&nbsp; 1 &nbsp;&nbsp;&nbsp;
				<std:input type="radio" name="Children" value="2"/>&nbsp; 2 &nbsp;&nbsp;&nbsp;
				<std:input type="radio" name="Children" value="3"/>&nbsp; >=3
      </td>
 		</tr>
 		
 		<%
			}
 		%>
 		
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TAX_REG%>"/>:</td>
			<td><std:input type="text" name="IncomeTaxNo" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td colspan="2">&nbsp</td>
		</tr>
		
		<%
			if (!type.equals(MemberManager.MBRTYPE_COMPANY)) {
		%>
		
  	<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.SPOUSE_NAME%>"/>:</td>
			<td><std:input type="text" name="SpouseName" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.SPOUSE_IC_NO%>"/>:</td>
			<td><std:input type="text" name="SpouseNric" size="<%= size %>"/></td>
		</tr>
  	<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.SPOUSE_DOB%>"/>:</td>
			<td>
				<std:input type="date" name="SpouseDobStr" size="<%= size %>"/>
				&nbsp; (YYYY-MM-DD)
			</td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BENEFICIARY_NAME%>"/>:</td>
			<td><std:input type="text" name="BfName" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td colspan="2">&nbsp</td>
		</tr>
		
		<%
			}
 		%>
 			
    <!--
  	<tr>
			<td align="right" width="180"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.PAYOUT_CURRENCY%>"/>:</td>
			<td><std:input type="select_currency" name="PayoutCurrency" form="frmCreate" size="<%= size %>"/></td>
		</tr>
		-->
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BANK%>"/>:</td>
			<td><std:input type="select_bank" name="BankID" form="frmCreate"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BANK_ACCOUNT_HOLDER%>"/>:</td>
			<td><std:input type="text" name="BankPayeeName" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BANK_ACCOUNT_NO%>"/>:</td>
			<td><std:input type="text" name="BankAcctNo" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.BRANCH%>"/>:</td>
			<td><std:input type="text" name="BankBranch" size="<%= size %>"/></td>
		</tr>
		<!--
		<tr>
			<td align="right">Bank Account Type:</td>
			<td><std:input type="text" name="BankAcctType" size="<%= size %>"/></td>
		</tr>
		-->
  	
	</table>

	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="IdentityNo" value="<%= identityNo %>"/>
	<std:input type="hidden" name="IdentityType" value="<%= identityType %>"/>
	<std:input type="hidden" name="DisplayName"/> 
	<std:input type="hidden" name="MailAddressLine1"/> 
	<std:input type="hidden" name="MailAddressLine2"/>
	<std:input type="hidden" name="MailZipCode"/> 
	<std:input type="hidden" name="MailCountryID"/>
	<std:input type="hidden" name="MailStateID"/> 
	<std:input type="hidden" name="MailCityID"/>
	<std:input type="hidden" name="RegFormNo" value="<%= Sys.getDateTimeFormater().format(new Timestamp(System.currentTimeMillis())) %>"/>
	<std:input type="hidden" name="RegPrefix" value=""/>
	<std:input type="hidden" name="PayoutCurrency" value="RP"/>
	<std:input type="hidden" name="Password" value="<%= password %>"/>
	<std:input type="hidden" name="BonusPeriodID" value="<%= bonusPeriodID %>"/>
	
	<input type="hidden" name="ChkIntrID" value="<%= chkIntrID %>">
	<input type="hidden" name="ChkPlaceID" value="<%= chkPlaceID %>">
	
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
  <input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
	
</form>

</body>
</html>