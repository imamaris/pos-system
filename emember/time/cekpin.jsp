<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="/WEB-INF/tlds/standard.tld" prefix="std" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<%@ page import="com.ecosmosis.mvc.constant.SupportedLocale"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.authentication.*"%>
<%@ page import="java.util.*"%>

<%
String messg = request.getParameter("msg");
boolean hasMesg = messg!=null;
%>


<html>
    <head>
        <title><%= Sys.getAPP_NAME() %></title>        
        
        <script language="JavaScript">
	<!--
	
		function warning() {
			var thisform = window.document.login;
		}
	
	//-->
        </script>
        
        <style type="text/css">
            <!--
body {
	background-color: #DCDCDC;
	background-image: url(../img/back.jpg);        
}
.style1 {color: #0000FF}
.style2 {color: #000000}
            -->
        </style>       
    </head>
    
    <body onLoad="self.focus();document.login.IdCRM.focus();" background-image="url(../img/back.jpg);">
        
        
        
        <table>
            <tr>
                <td class="headerhome" align="center"> 
                </td>
            </tr>
            
        </table>
        
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        
        <center>
            <form name="login" method="post" action="<%=Sys.getControllerURL(HttpAuthenticationManager.MEMBER_CHECK_PIN,request)%>">
                <table cellSpacing=0 cellPadding=0 align=center border=1 background="<%=Sys.getWebapp()%>/img/login_bg.jpg">
                    <tr>
                        <td align="center">
                            <img height="65" src="<%=Sys.getWebapp()%>/img/logo_chi.gif">
                        </td>                        
                    </tr>                    
                    <tr>
                        <td valign="top" align="center">
                            <table cellSpacing="0" cellPadding="5" width="350" border="0">
                                <tr>
                                    <td class="loginhead" colSpan="2" height="25" align="center"><font color="blue" ><b>Check PIN</b></font></td>
                                </tr>
                                
                                <!-- 
	        <tr>
	          <td height="25" align="right" nowrap>Language Preference:</td>
	          <td>
						  <select name="locale">
                                <%						  
                                Locale[] locales = SupportedLocale.getLocales();
                                for (int i=0; i < locales.length; i++) {
                                %>
                                <option value="<%=locales[i].toString()%>" <%=(locales[i] == Locale.CHINA)? "" : "selected" %> > <%= locales[i].getDisplayLanguage(locales[i]) %></option>
                                <% } %>
						  </select>
					 	</td>
				 	</tr>
//-->				 	
                                <tr>
                                    <td height="35" align="right"><font color="blue" ><b>CRM Card :</b></font></td>
                                    <td><input type="text" name="IdCRM" maxlength="15" value="" /></td> 
                                </tr>
                                <tr>
                                    <td height="35" align="right"><font color="blue" ><b>PIN :</b></font></td>
                                    <td><input type="password" name="PinCRM" value=""></td>
                                </tr>
                                <tr>
                                    <td align=right colspan="1">&nbsp;</td>
                                    <td align=left>
                                        <input type="submit" value="Submit" onClick="return warning()">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br>
                <tr>
                    <td>
                    </td>
                </tr>    
                
                
                <c:if test="<%=hasMesg%>">
                    <tr>
                        <td colspan="3" valign="top" align="center"><p><font color="blue" size="4" face="Arial, Helvetica, sans-serif"><%=messg%></font></p></td>
                    </tr>
                </c:if>
                
            </form>
            
        </center>
        
    </body>
</html>
