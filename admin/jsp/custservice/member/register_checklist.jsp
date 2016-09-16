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
	String memberIDSel = request.getParameter("MemberID");
	String identityNoSel = request.getParameter("IdentityNo");
	String regFormNoSel = request.getParameter("RegFormNo");
	
	MemberChecklist chkList = null;
	
	if (returnBean != null) {
		chkList = (MemberChecklist) returnBean.getReturnObject(MemberManager.RETURN_MBRCHKLIST_CODE);
	}
	
	if (chkList != null && chkList.hasError()) {	
%>

<!-- Dup formNo -->
<%
		if (chkList.hasDupRegForm()) {
%>

<div class="error note"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DUPLICATE_OF_REG_FORM%>"/> !!</div>

<br>

<table class="listbox" width="700">
	<tr class="boxhead" valign=top>
    <td width="20"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
    <td width="50"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.REG_FORM_NO%>"/></td>
    <td width="100"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/></td>
    <td width="300"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
    <td width="140"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <br> <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/></td>
    <td width="100"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/></td>
    <td width="100"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP%>"/></td>
    <td width="100">Register Type</td>
  </tr>
  
<%		
			MemberBean[] beans = chkList.getDupRegFormList();
			
			for (int i=0; i<beans.length; i++) {
				
				String styleRegFormNo = beans[i].getRegFormNo();
				if (styleRegFormNo.equalsIgnoreCase(regFormNoSel))
					styleRegFormNo = "<b><font color='blue'>" + beans[i].getRegFormNo() + "</font></b>";
								
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
    <td nowrap><%= styleRegFormNo  %></td>
	  <td nowrap><%= beans[i].getMemberID() %></td>
    <td><%= beans[i].getName() %></td>
    <td nowrap><%= beans[i].getIdentityNo() %></td>
    <td align="center" nowrap><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= beans[i].getJoinDate() %>" /></td>
    <td align="center" nowrap><%= MemberManager.defineMbrshipStatus(beans[i].getStatus()) %></td>
    <td align="center" nowrap><%= MemberManager.defineRegisterType(beans[i].getRegister()) %></td>
  </tr>
  
<%		
				} // end for
%>

</table>

<br>


<hr>

<br>

<%		
			} // end if dup
%>

<!-- End dup formNo -->

<!-- Dup Identity -->

<%
		if (chkList.hasIdentityStatus()) {
%>

<div class="error note">!!! Duplicate of Identity</div>

<br>

<table class="listbox" width="700">
  <tr class="boxhead" valign=top>
    <td width="20"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/></td>
    <td width="100"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/></td>
    <td width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
    <td width="140"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <br> <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/></td>
    <td width="100"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/></td>
    <td width="100"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP%>"/></td>
    <td width="100"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_REG%>"/></td>
  </tr>
  
<%		
			Iterator itr = chkList.getIdentityStatusTable().keySet().iterator();
			
			while (itr.hasNext()) {
				String key = (String) itr.next();
				MemberBean[] beans = chkList.getListByIdentityStatus(key);
			
				for (int i=0; i<beans.length; i++) {
					
					String rowCss = "";
					
					String styleID = beans[i].getMemberID();
					if (styleID.equalsIgnoreCase(memberIDSel)) 
						styleID = "<b><font color='blue'>" + beans[i].getMemberID() + "</font></b>";
					
					String styleIdentity = beans[i].getIdentityNo();
					if (styleIdentity.equalsIgnoreCase(identityNoSel)) 
						styleIdentity = "<b><font color='blue'>" + beans[i].getIdentityNo() + "</font></b>";
							
			  	if((i+1) % 2 == 0)
		      	rowCss = "even";
		      else
		        rowCss = "odd";
		
		      if (beans[i].getStatus() != MemberManager.MBRSHIP_ACTIVE)
		        rowCss = "alert";
%>

	<tr class="<%= rowCss %>" valign=top>
    <td><%= i+1 %>.</td>
	  <td nowrap><%= styleID %></td>
    <td><%= beans[i].getName() %></td>
    <td nowrap><%= styleIdentity %></td>
    <td align="center" nowrap><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= beans[i].getJoinDate() %>" /></td>
    <td align="center" nowrap><%= MemberManager.defineMbrshipStatus(beans[i].getStatus()) %></td>
    <td align="center" nowrap><%= MemberManager.defineRegisterType(beans[i].getRegister()) %></td>
  </tr>
  
<%		
					} // end for
				} // end while	
%>

</table>

<%		
			} // end if dup
%>

<!-- End dup Identity -->
                            <table>
                            <br>
                            <tr>
                                <td align="right"><span class="required note">* </span> Are You Sure ? (Different Identity) </td>
                                <td>
                                    <std:input type="radio" name="chek" value="Y" status= "checked" />&nbsp; Yes &nbsp;&nbsp;&nbsp;
                                    <std:input type="radio" name="chek" value="N"/>&nbsp; No
                                </td>
                            </tr>
                            </table>
                            
<br>

<hr>

<br>

<%
	} // end chkList != null
%>

</body>
</html>
