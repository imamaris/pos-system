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

String joinDateStr = (String) returnBean.getReturnObject("JoinDateStr");
String type = (String) returnBean.getReturnObject("Type");
String Register  = (String) returnBean.getReturnObject("Register");
String name = (String) returnBean.getReturnObject("Name");
String mobile = (String) returnBean.getReturnObject("MobileNo");
String password = (String) returnBean.getReturnObject("Password");

String Gender = (String) returnBean.getReturnObject("Gender"); //Updated By Ferdi 2015-01-21
String Salutation = (String) returnBean.getReturnObject("Salutation"); //Updated By Ferdi 2015-01-21

String identityNo = (String) returnBean.getReturnObject("IdentityNo");
String identityType = (String) returnBean.getReturnObject("IdentityType");
Map OccupationTypeMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_OCCUPATION_CODE);
Map EthnicTypeMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_ETHNIC_CODE);

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
			
    	
    	            if (!validateMemberRegisterFormNo(thisform.RegFormNo)) {
				alert("Invalid Register Form No.");
				focusAndSelect(thisform.RegFormNo);
				return;
			}
			
			if (!validateText(thisform.Name)) {
				alert("Please enter Name");
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
				alert("Please Select Ethnicity.");
				return;
			}
                        //End Updated
                        
			thisform.MailZipCode.value = thisform.ZipCode.value;
			
			
					
			thisform.submit();
		}
		
        </script>
 
</head>

<body>

<div class="functionhead">Registration </div>

   
        <form name="frmCreate" action="<%=Sys.getControllerURL(MemberManager.TASKID_FULL_REG_FORM,request)%>" method="post">
            
            <%@ include file="/lib/return_error_msg.jsp"%>
            
            <%@ include file="/admin/jsp/custservice/member/register_checklist.jsp"%>
            
            <p class="required note">* <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.REQUIRED_FIELD%>"/></p>

            
            <table width="70%">
                <tr><td valign="top">    
                        <table width="100%">                                           
                            
                            <tr>
                                <td align="right"><span class="required note">* </span>Join Date :</td>
                                <td><std:input type="date" name="JoinDateStr" value="<%= joinDateStr != null ? joinDateStr : "" %>" size="25"/></td>
                            </tr>
                            <tr>
                                <td align="right">Type :</td>
                                <td>
                                    <%= MemberManager.defineMbrType(type) %>
                                    <std:input type="hidden" name="Type" value="<%= type != null ? type : "" %>"/>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Register :</td>
                                <td>
                                    <%= MemberManager.defineRegisterType2(Register) %>
                                    <std:input type="hidden" name="Register" value="<%= Register != null ? Register : "" %>"/>
                                </td>
                            </tr>
                            <tr>
                                
		<tr>
			<td align="right">Gender :</td>
			<td>
                                <%= MemberManager.defineMbrGender(Gender) %>
                                <std:input type="hidden" name="Gender" value="<%= Gender != null ? Gender : "" %>"/>
                        </td>
 		</tr>
                <tr>
			<td align="right">Salutation :</td>
			<td>
                                <%= Salutation %>
                                <std:input type="hidden" name="Salutation" value="<%= Salutation != null ? Salutation : "" %>"/>
                        </td>
 		</tr>
                                <td align="right" ><span class="required note">* </span>Name :</td>
                                <td><std:input type="text" name="Name" value="<%= name != null ? name : "" %>" size="<%= size %>"/></td>
                            </tr>
                            
                            <tr>
                                <td align="right" >Birth Date :</td>
                                <td >
                                    <std:input type="date" name="DobStr" value="1970-01-01" /> &nbsp;  (YYYY-MM-DD)
                                </td>
                            </tr>
                            
                            <%
                            if (type.equals(MemberManager.MBRTYPE_COMPANY)) {
                            %>
                            
                            <tr>
                                <td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.IC_NO%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/> :</td>
                                <td><%= identityNo != null ? identityNo : "" %></td>
                            </tr>                            
                            
                            <tr>
                                <td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_DATE%>"/> :</td>
                                <td>
                                    <std:input type="date" name="CompanyRegDateStr" size="<%= size %>"/>
                                    
                                </td>
                            </tr>
                            
                            <%
                            }
                            %>
                            
                            <tr>
                                <td colspan="2">&nbsp</td>
                            </tr>
                            <tr>
                                <td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MAILING_ADD%>"/> :</td>
                                <td><std:input type="text" name="AddressLine1" value="" size="50" maxlength="100"/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td><std:input type="text" name="AddressLine2" value="" size="50" maxlength="100"/></td>
                            </tr>
                            <tr>
                                <td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ZIP_CODE%>"/> :</td>
                                <td><std:input type="text" name="ZipCode" value="" size="10" maxlength="5"/></td>
                            </tr>
                            <tr>
                                <td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/> :</td>
                                <td><std:input type="select_country" name="CountryID" form="frmCreate"/></td>
                            </tr>
                            <tr>
                                <td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATE%>"/> :</td>
                                <td><std:input type="select_state" name="StateID" form="frmCreate"/></td>
                            </tr>
                            <tr>
                                <td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CITY%>"/> :</td>
                                <td><std:input type="select_city" name="CityID" form="frmCreate"/></td>
                            </tr>

                            <tr>
                                <td align="right" >Mobile Number :</td>
                                <td ><input type="text" name="MobileNo" value="<%= mobile != null ? mobile : "" %>" onKeyPress="return checkNumeric(event)" size="14" maxlength="14"/></td>
                            </tr>
                <!-- Updated By Ferdi 2015-01-21 -->            
		<tr>
			<td align="right">Office Number :</td>
			<td><std:input type="text" name="OfficeNo" size="14" maxlength="14"/></td>
		</tr>
		<tr>
			<td align="right">Home Number :</td>
			<td><std:input type="text" name="HomeNo" size="14" maxlength="14"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL%>"/> :</td>
			<td><std:input type="text" name="Email" size="<%= size %>"/></td>
		</tr>
                
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.OCCUPATION%>"/> :</td>
			<td>
                            <std:input type="select" name="Occupation" options="<%= OccupationTypeMap %>"/>
                        </td>
		</tr>
                <tr>
			<td align="right"><span class="required note">* </span>Ethnicity :</td>
			<td>
                            <std:input type="select" name="Ethnic" options="<%= EthnicTypeMap %>"/>
                        </td>
		</tr>
                <!-- End Updated -->
                
                        </table>
                    </td>
                    <td valign="top">
                        <table  width="100%">                
                            
                            <%
                            if (!type.equals(MemberManager.MBRTYPE_COMPANY)) {
                            %>
                            
                            <std:input type="hidden" name="NationalityID" value=""/>
                            <std:input type="hidden" name="Marital" value=""/>
                            <std:input type="hidden" name="Children" value=""/>
                            
                            <%
                            }
                            %>
                            
                            <std:input type="hidden" name="IncomeTaxNo" value=""/>                           
                            
                            <%
                            if (!type.equals(MemberManager.MBRTYPE_COMPANY)) {
                            %>
                            
                            <tr>
                                <td colspan="2">&nbsp</td>
                            </tr>
                            
                            <%
                            }
                            %>
                            
                            <std:input type="hidden" name="BankID" value=""/>
                            <std:input type="hidden" name="BankID" value=""/>
                            <std:input type="hidden" name="BankPayeeName" value=""/>
                            <std:input type="hidden" name="BankAcctNo" value=""/>
                            <std:input type="hidden" name="BankBranch" value=""/>
  	
                        </table>
                    </td>
                </tr>
            </table>
                 
            
            <br>
            
            <std:input type="hidden" name="SpouseName" value=""/>
            <std:input type="hidden" name="SpouseNric" value=""/>
            <std:input type="hidden" name="SpouseDobStr" value="<%= Sys.getDateTimeFormater().format(new Timestamp(System.currentTimeMillis())) %>"/>
            <std:input type="hidden" name="BfName" value=""/>
            
            
            <std:input type="hidden" name="MemberID" value="IR0000022222"/>			
            <std:input type="hidden" name="nopin" value="f"/>
            
            <std:input type="hidden" name="PlacementID" value="<%= placementID %>"/>
            <std:input type="hidden" name="IntroducerID" value="<%= introducerID %>"/>
            <std:input type="hidden" name="IntroducerContact" value="<%= introducerContact %>"/>
            <std:input type="hidden" name="IntroducerName" value="<%= introducerName %>"/>                
            
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
            
            <input class="textbutton" type="button" value="Submit" onClick="doSubmit(this.form);">
            <input class="textbutton" type="reset" value="Reset">
            
        </form>
        
</body>
</html>