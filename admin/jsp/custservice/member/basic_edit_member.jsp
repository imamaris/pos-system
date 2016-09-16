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
	int size = 40;
	int memberIDLength = 12;
	
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  MemberBean bean = (MemberBean) returnBean.getReturnObject(MemberManager.RETURN_MBRBEAN_CODE);
  
  Map OccupationTypeMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_OCCUPATION_CODE);
  Map EthnicTypeMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_ETHNIC_CODE);

  AddressBean address = null;
  PayeeBankBean payeeBank = null;
  SpouseBean spouse = null;
  BeneficiaryBean bf = null;
  
  boolean canView = false;
	if (bean != null && !bean.isHidden()) {
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
	  
  <script language="javascript">
       //Updated By Ferdi 2015-01-23
       $(document).ready(function() {
            $("input:radio[name=Gender][value='<%= bean.getGender() %>']").attr("checked","checked");
            $("input:radio[name=Salutation][value='<%= bean.getTitle() %>']").attr("checked","checked");
            $("input:radio[name=Gender]").change(function(){
                if($(this).val() == "F")
                {
                    $("input:radio[name=Salutation][value='Ms.']").attr("checked","checked");
                }
                else
                {
                    $("input:radio[name=Salutation][value='Mr.']").attr("checked","checked");
                }
            });
        });
        //
	
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
		               
                
		if (!validateObj(thisform.StateID, 1)) {
			alert("<i18n:label code="MSG_ENTER_STATE"/>");
			return;
		} else {
			thisform.MailStateID.value = thisform.StateID.options[thisform.StateID.selectedIndex].value;
		}
		
                /* 0 tdk chek, 1 chek */
		if (!validateObj(thisform.CityID, 1)) {
			alert("<i18n:label code="MSG_ENTER_CITY"/>");
			return;
		} else {
			thisform.MailCityID.value = thisform.CityID.options[thisform.CityID.selectedIndex].value;
		}
                
                //Updated By Ferdi 2015-01-22
                if (!validateObj(thisform.Occupation, 1)) {
                        alert("Please Select Occupation.");
                        return;
                }
                //End Updated
                
                //Updated By Ferdi 2015-01-23
                if (!validateObj(thisform.Ethnic, 1)) {
                        alert("Please Select Ethnic.");
                        return;
                }
                //End Updated
		
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
		
		if (confirm('Confirm Update ?')) {
			thisform.action = "<%=Sys.getControllerURL(MemberManager.TASKID_BASIC_EDIT_MEMBER,request)%>";		
			thisform.submit();
		}
	}
	
  </script>
  
</head>

<body>

<div class="functionhead">Edit Customer</div>


<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<form name="frmEdit" action="" method="post">
	
	<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>
	
	<table class="tbldata" width="100%">
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/> :</td>
	    <td><%= bean.getMemberID() %></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/> :</td>
	    <td><%= (bean.getJoinDate() != null) ? Sys.getDateFormater().format(bean.getJoinDate()): "" %></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="MBR007"/> :</td>
			<td><%= MemberManager.defineMbrshipStatus(bean.getStatus()) %></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_TYPE%>"/> :</td>
			<td><%= MemberManager.defineMbrType(bean.getType()) %></td>
		</tr>
                <!-- Updated By Ferdi 2015-01-21 -->
                <tr>
			<td align="right" width="180"><span class="required note">* </span>Gender :</td>
			<td>
				<std:input type="radio" name="Gender" value="M" status= "checked"/>&nbsp; <i18n:label code="Male"/> &nbsp;&nbsp;&nbsp;
        		        <std:input type="radio" name="Gender" value="F" status= ""/>&nbsp; <i18n:label code="Female"/> &nbsp;&nbsp;&nbsp;
                        </td>
 		</tr>
                <tr>
			<td align="right" width="180"><span class="required note">* </span>Salutation :</td>
			<td>
				<std:input type="radio" name="Salutation" value="Mr." status= "checked"/>&nbsp; <i18n:label code="Mr."/> &nbsp;&nbsp;&nbsp;
        		        <std:input type="radio" name="Salutation" value="Mrs." status= ""/>&nbsp; <i18n:label code="Mrs."/> &nbsp;&nbsp;&nbsp;
                                <std:input type="radio" name="Salutation" value="Ms." status= ""/>&nbsp; <i18n:label code="Ms."/> &nbsp;&nbsp;&nbsp;
                        </td>
 		</tr>
                <!-- End Updated -->
                <tr valign="top">
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INDIVIDUAL%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.CORPORATION_NAME%>"/> :</td>			
                        <td><std:input type="text" name="MemberName" value="<%= (bean.getName() != null) ? bean.getName() : "" %>" size="<%= size %>" maxlength="30"/></td>
		</tr>
                
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DOB%>"/> :</td>
			<td>
				<std:input type="date" name="DobStr" value="<%= (bean.getDob() != null) ? Sys.getDateFormater().format(bean.getDob()): "1970-01-01" %>" size="<%= size %>"/>
				&nbsp; (YYYY-MM-DD)

			</td>
		</tr>                
		<tr valign="top">
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>. :</td>
			<td><std:text value="<%= bean.getIdentityNo() %>" defaultvalue="-"/></td>
		</tr>
		
		<%
			if (bean.getType().equals(MemberManager.MBRTYPE_COMPANY)) {
		%>
			
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_DATE%>"/> :</td>
			<td>
				<std:input type="date" name="CompanyRegDateStr" value="<%= (bean.getCompanyRegDate() != null) ? Sys.getDateFormater().format(bean.getCompanyRegDate()): "" %>" size="<%= size %>"/>
				&nbsp; (YYYY-MM-DD)
			</td>
		</tr>	
		
		<%
			}
		%>
		

		<tr>
			<td colspan="2">&nbsp</td>
		</tr>
		<tr valign="top">
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MAILING_ADD%>"/> :</td>
			<td><std:input type="text" name="AddressLine1" value="<%= (address.getAddressLine1() != null) ? address.getAddressLine1() : "" %>" size="<%= size %>" maxlength="100"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><std:input type="text" name="AddressLine2" value="<%= (address.getAddressLine2() != null) ? address.getAddressLine2() : "" %>" size="<%= size %>" maxlength="100"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ZIP_CODE%>"/> :</td>
			<td><std:input type="text" name="ZipCode" value="<%= (address.getMailZipCode() != null) ? address.getMailZipCode() : "" %>" size="<%= size %>" maxlength="5"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/> :</td>
			<td><std:input type="select_country" name="CountryID" form="frmEdit" value="<%= (address.getCountryID() != null) ? address.getCountryID() : "" %>"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATE%>"/> :</td>
			<td><std:input type="select_state" name="StateID" form="frmEdit" value="<%= (address.getStateID() != null) ? address.getStateID() : "" %>"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CITY%>"/> :</td>
			<td><std:input type="select_city" name="CityID" form="frmEdit" value="<%= (address.getCityID() != null) ? address.getCityID() : "" %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_OFF%>"/> :</td>
			<td><std:input type="text" name="OfficeNo" value="<%= bean.getOfficeNo() != null ? bean.getOfficeNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_HOME%>"/> :</td>
			<td><std:input type="text" name="HomeNo" value="<%= bean.getHomeNo() != null ? bean.getHomeNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<!--
		<tr>
			<td align="right"><i18n:label code="GENERAL_NO_FAX"/> :</td>
			<td><std:input type="text" name="FaxNo" value="<%= bean.getFaxNo() != null ? bean.getFaxNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		-->
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MOBILE_NO%>"/> :</td>
			<td><std:input type="text" name="MobileNo" value="<%= bean.getMobileNo() != null ? bean.getMobileNo() : "" %>" size="<%= size %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL%>"/> :</td>
			<td><std:input type="text" name="Email" value="<%= bean.getEmail() != null ? bean.getEmail() : "" %>" size="<%= size %>"/></td>
		</tr>
                <!-- Updated By Ferdi 2015-01-21 -->
                <tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.OCCUPATION%>"/> :</td>
			<td>
                            <std:input type="select" name="Occupation" options="<%= OccupationTypeMap %>" value="<%= bean.getOccupation() %>"/>
                        </td>
		</tr>
                <tr>
			<td align="right"><span class="required note">* </span>Ethnic :</td>
			<td>
                            <std:input type="select" name="Ethnic" options="<%= EthnicTypeMap %>" value="<%= bean.getEthnic() %>"/>
                        </td>
		</tr>
                <% if(bean.getSegmentationCRM() != null && bean.getSegmentationCRM().trim().length() > 0)
                {
                %>
                <tr>
			<td align="right">Segment :</td>
                        <td><b><%= bean.getSegmentationCRM() %></b></td>
		</tr>
                <%
                }
                %>
                <!-- End Updated -->

		<tr>
			<td colspan="2">&nbsp</td>
		</tr>
		<tr valign="top">
			<td align="right" width="180"><i18n:label code="GENERAL_REMARK"/> :</td>
			<td><textarea name="Remark" rows="5" cols="50"><%= (bean.getRemark() != null) ? bean.getRemark().replaceAll("<br>","\n") : "" %></textarea></td>
		</tr>
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