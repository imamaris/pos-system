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
String memberChek = request.getParameter("Chek") == null ? "" : request.getParameter("Chek");
String Register  = request.getParameter("Register") == null ? "" : request.getParameter("Register");

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
        

<SCRIPT language="JavaScript">

function IsNumeric()
{
var x = document.getElementById("icode").value.split("");
var list = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
var status = true;
for (i=0; i<=x.length-1; i++)
{
if (x[i] in list) cek = true;
else cek = false;
status = status && cek;
}

if (status == false)
{
alert("Please Fill Number ...");
document.getElementById("icode").focus(); 
}
else
{


return true;
}

}
 
</SCRIPT>
        
        <script language="javascript">
                //Updated By Ferdi 2015-01-23
                $(function(){
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

		function showMenuChek(val) {
			if (val == '0') {
				document.getElementById('menu0').style.display = 'block';
			        document.getElementById('menu1').style.display = 'none';
			} 
			
			if (val == '1') {
				document.getElementById('menu0').style.display = 'none';
				document.getElementById('menu1').style.display = 'block';
                                }
                        
		}

                
		function doCopy() {
			
			var thisform = document.frmCreate;
			thisform.IntroducerID.value = thisform.PlacementID.value;
	  	}
	  	
		function doSubmit(thisform) {
                
                       thisform.MobileNo.value = thisform.icode.value;
			
			if (!validateMemberId(thisform.MemberID)) {
				alert("Invalid Distributor ID.");
				focusAndSelect(thisform.MemberID);
				return;
	  	}
                               
    	
			if (!validateMemberRegisterFormNo(thisform.RegFormNo)) {
				alert("Invalid Register Form No.");
				focusAndSelect(thisform.RegFormNo);
				return;
			}
			
			if (thisform.Type[1].checked) {
				
				if (!validateText(thisform.CompanyName)) {
					alert("Please enter Corporation Name.");
					focusAndSelect(thisform.CompanyName);
					return;
				} else {
					thisform.Name.value = thisform.CompanyName.value;
					thisform.DisplayName.value = thisform.CompanyName.value;
					thisform.IdentityType.value = thisform.CompanyIdentityType.value;
				}
				
				if (!validateText(thisform.CompanyRegNo)) {
					alert("Please enter Incorporation No.");
					focusAndSelect(thisform.CompanyRegNo);
					return;
				} else {
					thisform.IdentityNo.value = thisform.CompanyRegNo.value;
				}
				
			} else {
				
				if (!validateText(thisform.MobileNo)) {
					alert("Please enter Mobile No.");
					focusAndSelect(thisform.MobileNo);
					return;
				} 
                                
				if (!validateText(thisform.Name)) {
					alert("Please enter Name.");
					focusAndSelect(thisform.Name);
					return;
				} else {
					thisform.DisplayName.value = thisform.Name.value;
					thisform.IdentityType.value = thisform.IndvIdentityType.options[thisform.IndvIdentityType.selectedIndex].value;
				}
				
			}

			thisform.submit();
		}
		
        </script>
        
    </head>
    
    <body onLoad="self.focus(); init();">
        
        <div class="functionhead">Registration</div>
        
        <form name="frmCreate" action="<%=Sys.getControllerURL(MemberManager.TASKID_FULL_PRE_REG_FORM,request)%>" method="post">
            
            <%@ include file="/lib/return_error_msg.jsp"%>
            
            <%@ include file="/admin/jsp/custservice/member/register_checklist.jsp"%>
            
            <p class="required note">* <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.REQUIRED_FIELD%>"/></p>
            
            <table width="100%">
                <tr>
                    <td>
                        <table class="tbldata" width="100%">
    
                            <std:input type="hidden" name="MemberID" value="IR0000022222"/>	
                            
                            <tr>
                                <td align="right" width="180"><span class="required note">* </span> Mobile Number :</td>
                                
                                <td>
                                    <input type="text" name="icode" id="icode" value="" onblur="IsNumeric();" onKeyPress="return checkNumeric(event)" size="14" maxlength="14"> 
                                    <std:input type="hidden" name="MobileNo" size="14"/>
                                </td>
                            </tr>   
                            
                            
                            <std:input type="hidden" name="nopin" value="f"/>				
                            <std:input type="hidden"  name="Chek" value="0" />	
                            <std:input type="hidden" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/>
                            <std:input type="hidden" name="JoinDateStr" value="<%= Sys.getDateFormater().format(new Date()) %>"/>
                            
                            <tr>
                                <td align="right">Customer Type :</td>
                                <td>
                                    <std:input type="radio" name="Type" value="<%= MemberManager.MBRTYPE_INDIVIDUAL %>" status="onClick=\"javascript:showMenu('N');\" checked"/>Personal &nbsp;&nbsp;&nbsp;
                                    <std:input type="radio" name="Type" value="<%= MemberManager.MBRTYPE_COMPANY %>" status="onClick=\"javascript:showMenu('C');\""/>Company &nbsp;&nbsp;&nbsp;
                                    <!--
                                    <std:input type="radio" name="Type" value="<%= MemberManager.MBRTYPE_STAFF %>" status="onClick=\"javascript:showMenu('N');\""/>Staff &nbsp;&nbsp;&nbsp;
                                    <std:input type="radio" name="Type" value="<%= MemberManager.MBRTYPE_GUESS %>" status="onClick=\"javascript:showMenu('N');\""/>Guess &nbsp;&nbsp;&nbsp;
							-->
                                </td>
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
                        </table>
                    </td>
                </tr>
                
                <tr>
                    <td>	
                        <div id='menuN' style="display: visible;">
                            <table class="tbldata" width="100%">
                                <tr>
                                    <td align="right" width="180"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INDIVIDUAL_NAME%>"/> :</td>
                                    <td><std:input type="text" name="Name" size="<%= size %>"/></td>
                                </tr>
                                <tr>
                                    <td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.IC_NO%>"/> :</td>
                                    <td>
                                        <std:input type="select" name="IndvIdentityType" options="<%= identityTypeMap %>" value="<%= MemberManager.IDENTYPE_NRIC %>"/> - <std:input type="text" name="IdentityNo" size="30" maxlength="30"/>
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
                                    <td align="right" width="180">Corporation Name :</td>
                                    <td><std:input type="text" name="CompanyName" size="<%= size %>"/></td>
                                </tr>
                                <tr>
                                    <td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/> :</td>
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
                                <td align="right" width="180">Customer Status :</td>
                                <td> <div id='menu0' style="display: visible;">
                                        <std:input type="radio" name="Register" value="2" status= "checked"/><i18n:label code="Normal Retail &nbsp;&nbsp;&nbsp;"/>
                                        <std:input type="radio" name="Register" value="5" status=""/><i18n:label code="Staff &nbsp;&nbsp;&nbsp;"/>
                                    </div>
                                </td>
                            </tr>					                                                                                                                                               
                            <tr>

                                <std:input type="hidden" name="PlacementID" value="ID0000022205"/>
                                <std:input type="hidden" name="IntroducerID" value="ID0000022205"/>
                                <std:input type="hidden" name="IntroducerName" value=""/>
                                <std:input type="hidden" name="IntroducerContact" value=""/>
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
            
            <input type="hidden" name="ChkIntrID" value="<%= chkIntrID %>">
            <input type="hidden" name="ChkPlaceID" value="<%= chkPlaceID %>">
            
            <input class="textbutton" type="button" value="Submit" onClick="doSubmit(this.form);">
            <input class="textbutton" type="reset" value="Reset">
            
        </form>
        
    </body>
</html>

