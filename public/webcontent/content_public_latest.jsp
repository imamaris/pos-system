<%@page import="com.ecosmosis.orca.webcontent.*"%>
<%@page import="com.ecosmosis.mvc.manager.MvcReturnBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/lib/header_no_auth_without_css.jsp"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ContentBean[] beans = (ContentBean[])returnBean.getReturnObject("ContentList");
%> 

<title>PT CHi Indonesia</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script language="JavaScript" type="text/JavaScript">
<!--
//-->
</script>
<link href="<%= request.getContextPath() %>/public/webcontent/chi/chi.css" rel="stylesheet" type="text/css" />
<body>

<div id="datacontainer" style="position:absolute; left:0px; top:0px; width:367; height: 74;" onMouseover="scrollspeed=0" onMouseout="scrollspeed=cache">

<!-- ADD YOUR SCROLLER CONTENT INSIDE HERE -->

<table cellpadding="0" cellspacing="0" border="0" width="367" height="74">
<%
if(beans!=null){	
	for(int j=0; j<beans.length; j++){
%>
<tr>
	<td>
		<a href="<%=Sys.getControllerURL(WebManager.TASKID_CONTENT_DISPLAY_PUBLIC,request)%>&ID=<%=beans[j].getContentID()%>" target="_blank" class="text11grey">
		<u><%=beans[j].getTopic()%></u>
		</a>
	</td>
	<td class="text11grey"><%=beans[j].getPostDate()%></td>
</tr>
<tr><td height="10"></td></tr>
<% }}%>

</table>
</div>

<script type="text/javascript">

/***********************************************
* IFRAME Scroller script- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/

//Specify speed of scroll. Larger=faster (ie: 5)
var scrollspeed=cache=1

//Specify intial delay before scroller starts scrolling (in miliseconds):
var initialdelay=800

function initializeScroller(){
dataobj=document.all? document.all.datacontainer : document.getElementById("datacontainer")
dataobj.style.top="5px"
setTimeout("getdataheight()", initialdelay)
}

function getdataheight(){
thelength=dataobj.offsetHeight
if (thelength==0)
setTimeout("getdataheight()",10)
else
scrollDiv()
}

function scrollDiv(){
dataobj.style.top=parseInt(dataobj.style.top)-scrollspeed+"px"
if (parseInt(dataobj.style.top)<thelength*(-1))
dataobj.style.top="5px"
setTimeout("scrollDiv()",50)
}

if (window.addEventListener)
window.addEventListener("load", initializeScroller, false)
else if (window.attachEvent)
window.attachEvent("onload", initializeScroller)
else
window.onload=initializeScroller

</script>
</body>
</html>
