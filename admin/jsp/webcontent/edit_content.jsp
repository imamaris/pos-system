<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.webcontent.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ taglib uri="/WEB-INF/tlds/FCKeditor.tld" prefix="FCK" %>

<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
ContentBean bean = (ContentBean) returnBean.getReturnObject("Content");
WebManager web = new WebManager();
TreeMap cat_list = (TreeMap) returnBean.getReturnObject("Categories");
%>


<html>
<head>
<%@ include file="/lib/header.jsp"%>

<script type="text/javascript" src="<%= request.getContextPath() %>/fckeditor/fckeditor.js"></script>
<script type="text/javascript">

var bIsLoaded = false ;

function FCKeditor_OnComplete( editorInstance )
{
	if ( bIsLoaded )
		return ;

	var oCombo = document.getElementById( 'cmbLanguages' ) ;
	
	var aLanguages = new Array() ;
	
	for ( code in editorInstance.Language.AvailableLanguages )
		aLanguages.push( { Code : code, Name : editorInstance.Language.AvailableLanguages[code] } ) ;

	aLanguages.sort( SortLanguage ) ;

	for ( var i = 0 ; i < aLanguages.length ; i++ )
		AddComboOption( oCombo, aLanguages[i].Name + ' (' + aLanguages[i].Code + ')', aLanguages[i].Code ) ;
	
	oCombo.value = editorInstance.Language.ActiveLanguage.Code ;
	
//	document.getElementById('eNumLangs').innerHTML = '(' + aLanguages.length + ' languages available!)' ;
	
	bIsLoaded = true ;
}

function SortLanguage( langA, langB )
{
	return ( langA.Name < langB.Name ? -1 : langA.Name > langB.Name ? 1 : 0 ) ;
}

function AddComboOption(combo, optionText, optionValue)
{
	var oOption = document.createElement("OPTION") ;

	combo.options.add(oOption) ;

	oOption.innerHTML = optionText ;
	oOption.value     = optionValue ;
	
	return oOption ;
}

function ChangeLanguage( languageCode )
{
	//window.location.href = window.location.pathname + "?" + languageCode ;
        document.postmsg.action= "?" + languageCode;
        document.postmsg.target=""; 
        document.postmsg.formaction.value= "";
        document.postmsg.submit();
}

function openPreviewWindow()
{
         window.open('about:blank','previewWindow','resizable=yes,scrollbars=yes,menubar=0,status=1,toolbar=0,location=0,width=800,height=480');

         document.postmsg.action="<%=Sys.getControllerURL(WebManager.TASKID_CONTENT_PREVIEW,request)%>";
         document.postmsg.target="previewWindow";
         document.postmsg.formaction.value= "";
         setTimeout('document.postmsg.submit()',500);
}

function submitPost()
{
         document.postmsg.action="<%=Sys.getControllerURL(WebManager.TASKID_CONTENT_EDIT_SUBMIT,request)%>";
         document.postmsg.target="";
         document.postmsg.formaction.value= "submit";
         if(validateForm()){            
            return true;
         }else{
         	return false;
         }
}

function validateForm()
{
        if(document.postmsg.Topic.value.length == 0){
           document.postmsg.Topic.focus();
           alert('Please specify a Topic!');
           return false;
        }
        return true;
}
</script>

</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label code="WEB_EDIT_CONTENT"/></div>

<form name="postmsg" action="" method="post" onSubmit="return submitPost();">
<input type="hidden" name="formaction">
<input type="hidden" name="ContentID" value="<%=bean.getContentID()%>">
<%@ include file="/lib/return_error_msg.jsp"%>

<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label code="WEB_CONTENT_DETAILS"/></td>
			  	  	</tr>
				  	<tr>
			  			<td class="td1" width="250"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.DEFAULT_CATEGORY_NAME%>"/>:</td>
			      		<td><std:input name="CatID" type="select" options="<%=cat_list %>" value="<%=bean.getCategoryID()%>"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="250"><span class="required note">* </span><i18n:label code="WEB_TOPIC_NAME"/>:</td>
			      		<td><std:input type="text" size="60" maxlength="200" name="Topic" value="<%= web.convertSpecialChars(bean.getTopic())%>"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="250"><i18n:label code="WEB_SOURCE"/> (<i18n:label code="GENERAL_IF_ANY"/>):</td>
			      		<td><std:input type="text" size="60" maxlength="200" name="Source" value="<%=web.convertSpecialChars(bean.getSource())%>"/></td>
			  		</tr>
			  		<tr>
						<td class="td1"><span class="required note">* </span><i18n:label code="WEB_POST_DATE"/>:</td>
			      		<td><std:input type="date" name="PostDate" value="<%=bean.getPostDate()%>"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
			      		<td>
			      			<select name="Status">
			      				<option value="A" <%=(bean.getStatus().equalsIgnoreCase("A"))?"selected":""%>><i18n:label code="GENERAL_ACTIVE"/></option>
			      				<option value="I" <%=(bean.getStatus().equalsIgnoreCase("I"))?"selected":""%>><i18n:label code="GENERAL_INACTIVE"/></option>
			      			</select>
			      		</td>
			  		</tr> 				

				</table>
			</td>
		</tr>	
	</table>
	<p />
	<div align=right>
        <table cellpadding="0" cellspacing="0" border="0" >
		<tr >
			<td>
				Toolbar language:&nbsp;
			</td>
			<td>
				<select id="cmbLanguages" onchange="ChangeLanguage(this.value);">
				</select>
			</td>
		</tr>
	</table>
	</div>
	<FCK:editor id="Contents" basePath="<%= (request.getContextPath() + "/fckeditor/") %>"
				width="100%"
				height="400"
				autoDetectLanguage="true"
				defaultLanguage="en"
				imageBrowserURL="<%= (request.getContextPath() + "/fckeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector") %>"
				linkBrowserURL="<%= (request.getContextPath() + "/fckeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector") %>"
				flashBrowserURL="<%= (request.getContextPath() + "/fckeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=connectors/jsp/connector") %>"
				imageUploadURL="<%= (request.getContextPath() + "/fckeditor/editor/filemanager/upload/simpleuploader?Type=Image") %>"
				linkUploadURL="<%= (request.getContextPath() + "/fckeditor/editor/filemanager/upload/simpleuploader?Type=File") %>"
				flashUploadURL="<%= (request.getContextPath() + "/fckeditor/editor/filemanager/upload/simpleuploader?Type=Flash") %>"><%=web.convertToHTMLTag(bean.getContents())%>
	</FCK:editor>

	<p>
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" >
  	<input class="textbutton" type="button" onClick="openPreviewWindow();" value="<i18n:label code="GENERAL_BUTTON_PREVIEW"/>">
  	
</form>
</html>