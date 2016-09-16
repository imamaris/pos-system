<%@page import="java.net.URLEncoder"%>
<HTML>
<HEAD>
<TITLE></TITLE>
<%@ include file="/lib/header_no_auth.jsp"%>
<!--
<%@ include file="/general/mvc_return_msg.jsp"%>
//-->

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

<!-- body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" onLoad="top.location.href='<-- %=Sys.getWebapp()%>/emember/time/index.jsp<-- %=((bufferstring123.length() > 0)?"?msg=" + URLEncoder.encode(bufferstring123.toString(),"UTF-8"):"")%>'"> -->

<body background="#00B500" onLoad="top.location.href='<%=Sys.getWebapp()%>/emember/time/cekpin.jsp<%=((bufferstring123.length() > 0)?"?msg=" + URLEncoder.encode(bufferstring123.toString(),"UTF-8"):"")%>'">
    
    <center>   
        
    </center>    
</BODY>
</HTML>
