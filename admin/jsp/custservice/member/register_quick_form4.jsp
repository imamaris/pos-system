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
  
	String memberType = request.getParameter("Type") == null ? "" : request.getParameter("Type");
        String Register  = request.getParameter("Register");
        String noPin = request.getParameter("nopin");
	
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	
	Map identityTypeMap = (Map) returnBean.getReturnObject(MemberManager.RETURN_IDENTITYTYPE_CODE);
	
	String chkIntrID = "false";
	String chkPlaceID = "false";
	
	if (returnBean != null) {
		chkIntrID = (String) returnBean.getReturnObject("ChkIntrID");
		chkPlaceID = (String) returnBean.getReturnObject("ChkPlaceID");
	}
%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>
		
	<script language="javascript">
	
		function init() {
			var thisform = frmCreate;
			
			var type = '<%= memberType %>';
			var typeValue = "";
			
			if (type == '<%= MemberManager.MBRTYPE_COMPANY %>')
				thisform.Type[1].checked = true;
			else if (type == '<%= MemberManager.MBRTYPE_STAFF %>')
				thisform.Type[2].checked = true;
			else if (type == '<%= MemberManager.MBRTYPE_GUESS %>')
				thisform.Type[3].checked = true;
			else 
				thisform.Type[0].checked = true;
	
			for(var i = 0; i < thisform.Type.length; i++) {
				if(thisform.Type[i].checked) {
					typeValue= thisform.Type[i].value;
					showMenu(typeValue);
					break;
				}
			}	
		}
		
		function showMenu(val) {
			if (val == 'N') {
				document.getElementById('menuN').style.display = 'block';
			  document.getElementById('menuC').style.display = 'none';
			} 
			
			if (val == 'C') {
				document.getElementById('menuC').style.display = 'block';
				document.getElementById('menuN').style.display = 'none';
			}
		}
		
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
				focusAndSelect(thisform.PlacementID);
				return;
			} 
			
			if (!validateDupID(thisform.MemberID, thisform.PlacementID)) {
				alert("<i18n:label code="MSG_PLACEMENT_NOTSAME_ID"/>");
				focusAndSelect(thisform.PlacementID);
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
			
			if (thisform.Type[1].checked) {
				
				if (!validateText(thisform.CompanyName)) {
					alert("<i18n:label code="MSG_ENTER_CORP_NAME"/>");
					focusAndSelect(thisform.CompanyName);
					return;
				} else {
					thisform.Name.value = thisform.CompanyName.value;
					thisform.DisplayName.value = thisform.CompanyName.value;
					thisform.IdentityType.value = thisform.CompanyIdentityType.value;
				}
				
				if (!validateText(thisform.CompanyRegNo)) {
					alert("<i18n:label code="MSG_ENTER_CORP_NUM"/>");
					focusAndSelect(thisform.CompanyRegNo);
					return;
				} else {
					thisform.IdentityNo.value = thisform.CompanyRegNo.value;
				}
				
			} else {
				
				if (!validateText(thisform.Name)) {
					alert("<i18n:label code="MSG_ENTER_NAME"/>");
					focusAndSelect(thisform.Name);
					return;
				} else {
					thisform.DisplayName.value = thisform.Name.value;
					thisform.IdentityType.value = thisform.IndvIdentityType.options[thisform.IndvIdentityType.selectedIndex].value;
				}
				
				if (!validateText(thisform.IdentityNo)) {
					alert("<i18n:label code="MSG_ENTER_IC_NUM"/>");
					focusAndSelect(thisform.IdentityNo);
					return;
				} 
			}
			
			thisform.submit();
		}
		
	</script>
</head>
	
<body onLoad="self.focus(); init();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.QUICK_REG%>"/></div>

<form name="frmCreate" action="<%=Sys.getControllerURL(MemberManager.TASKID_QUICK_REG_FORM,request)%>" method="post">
  
	<%@ include file="/lib/return_error_msg.jsp"%>
	
	<%@ include file="/admin/jsp/custservice/member/register_checklist.jsp"%>
		
  <p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>
  
	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
					<tr>
						<td align="right" width="180"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
						<td><std:input type="text" name="MemberID" size="<%= size %>" maxlength="<%= memberIDLength %>"/></td>
					</tr>
					
					<% 
						if (noPin == null) { 
					%>
						
					<tr>
						<td align="right" width="180"><span class="required note">* </span><i18n:label code="DISTRIBUTOR_PIN_CODE"/>:</td>
						<td><input type="password" name="Password"></td>
					</tr>
					<!-- 
					<tr>
						<td class="td1" width="180"><span class="required note">* </span><i18n:label code="BONUS_PERIOD"/>:</td>
						<td><std:bnsperiod_adm_counter/></td>
					</tr>
					 -->
			 	    <tr>
				 	    <td align="right" width="180"><span class="required note">* </span> Bonus Date:</td>
				 	    <td><std:input type="date" name="BonusDate" value="now" size="<%= size %>"/>&nbsp; (YYYY-MM-DD)</td>
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
			      <td>
			      	<std:input type="date" name="JoinDateStr" value="now" size="<%= size %>"/>
			      	&nbsp; (YYYY-MM-DD)
			      </td>
			  	</tr>
					<tr>
						<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_TYPE%>"/>:</td>
						<td>
							<std:input type="radio" name="Type" value="<%= MemberManager.MBRTYPE_INDIVIDUAL %>" status="onClick=\"javascript:showMenu('N');\" checked"/><i18n:label code="DISTRIBUTOR_PERSONAL"/> &nbsp;&nbsp;&nbsp;
							<std:input type="radio" name="Type" value="<%= MemberManager.MBRTYPE_COMPANY %>" status="onClick=\"javascript:showMenu('C');\""/><i18n:label code="DISTRIBUTOR_COMPANY"/> &nbsp;&nbsp;&nbsp;
							<!--
							<std:input type="radio" name="Type" value="<%= MemberManager.MBRTYPE_STAFF %>" status="onClick=\"javascript:showMenu('N');\""/>Staff &nbsp;&nbsp;&nbsp;
							<std:input type="radio" name="Type" value="<%= MemberManager.MBRTYPE_GUESS %>" status="onClick=\"javascript:showMenu('N');\""/>Guess &nbsp;&nbsp;&nbsp;
							-->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>	
				<div id='menuN' style="display: visible;">
					<table class="tbldata" width="100%">
						<tr>
							<td align="right" width="180"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INDIVIDUAL_NAME%>"/>:</td>
							<td><std:input type="text" name="Name" size="<%= size %>"/></td>
						</tr>
						<tr>
							<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.IC_NO%>"/>:</td>
							<td>
				    		<std:input type="select" name="IndvIdentityType" options="<%= identityTypeMap %>" value="<%= MemberManager.IDENTYPE_NRIC %>"/> - <std:input type="text" name="IdentityNo" size="30"/>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div id='menuC' style="display: none;">
					<table class="tbldata" width="100%">
						<tr>
							<td align="right" width="180"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.CORPORATION_NAME%>"/>:</td>
							<td><std:input type="text" name="CompanyName" size="<%= size %>"/></td>
						</tr>
						<tr>
							<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>:</td>
							<td>
								<std:input type="text" name="CompanyRegNo" size="<%= size %>"/>
								<std:input type="hidden" name="CompanyIdentityType" value="<%= MemberManager.IDENTYPE_COMPANY_REGNO %>"/>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<table class="tbldata" width="100%">
					<tr>
						<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_REG%>"/>:</td>
						<td>
						    <std:input type="radio" name="Register" value="0" status=""/><i18n:label code="PAKET 300rb"/>
                                                    <std:input type="radio" name="Register" value="1" status=""/><i18n:label code="PAKET 150rb"/>
						    <std:input type="radio" name="Register" value="2" status=""/><i18n:label code="PAKET 389rb"/>                                                    
						</td>
					</tr>					                                                                       
                                    <tr>
						<td align="right" width="180"><span class="required note">* </span><i18n:label code="DISTRIBUTOR_PLACEMENT_ID"/>:</td>
						<td>
							<std:input type="text" name="PlacementID" size="<%= size %>" maxlength="<%= memberIDLength %>"/>
							<a href="javascript:popupSmall('<%=Sys.getControllerURL(MemberManager.TASKID_SEARCH_MEMBERS_ALL_BY,request) %>&FormName=frmCreate&ObjName=PlacementID')">
  	    						<img border="0" alt='Search Sponsor' src="<%= Sys.getWebapp() %>/img/lookup.gif"/>
    	  					</a>
    	  				</td>
					</tr>					
					<tr>
						<td align="right" width="180"><i18n:label code="DISTRIBUTOR_UPLINE_ID"/>:</td>
						<td>
							<std:input type="text" name="IntroducerID" size="<%= size %>" maxlength="<%= memberIDLength %>"/>
							<a href="javascript:popupSmall('<%=Sys.getControllerURL(MemberManager.TASKID_SEARCH_MEMBERS_ALL_BY,request) %>&FormName=frmCreate&ObjName=IntroducerID&PropName=IntroducerName')">
  	    						<img border="0" alt='Search Introducer' src="<%= Sys.getWebapp() %>/img/lookup.gif"/>
    	  					</a>
    	  					&nbsp;&nbsp;
    	  					<a href="Javascript:doCopy();"><small><i18n:label code="DISTRIBUTOR_SAMEAS_PLACEMENT"/></small></a>
						</td>
					</tr>
					<tr>
						<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_NAME"/>:</td>
						<td><std:input type="text" name="IntroducerName" size="<%= size %>"/></td>
					</tr>
					<tr>
						<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_CONTACT"/>:</td>
						<td><std:input type="text" name="IntroducerContact" size="<%= size %>"/></td>
					</tr>					
				</table>
			</td>
		</tr>
	</table>

	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="DisplayName"/>
	<std:input type="hidden" name="IdentityType"/>  
	<std:input type="hidden" name="RegFormNo" value="<%= Sys.getDateTimeFormater().format(new Timestamp(System.currentTimeMillis())) %>"/>
	<std:input type="hidden" name="RegPrefix" value=""/>
	<std:input type="hidden" name="PayoutCurrency" value="RP"/>
	
	<input type="hidden" name="ChkIntrID" value="<%= chkIntrID %>">
	<input type="hidden" name="ChkPlaceID" value="<%= chkPlaceID %>">

	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
  <input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
	
</form>

</body>
</html>