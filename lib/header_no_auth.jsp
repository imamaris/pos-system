<%@ taglib uri="/WEB-INF/tlds/i18n.tld" prefix="i18n" %>
<%@ taglib uri="/WEB-INF/tlds/standard.tld" prefix="std" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<%@ page import="com.ecosmosis.mvc.authentication.*"%>
<%@ page import="com.ecosmosis.mvc.constant.*"%>
<%@ page import="com.ecosmosis.mvc.authentication.*"%>
<%@ page import="com.ecosmosis.mvc.constant.*"%>
<%@ page import="com.ecosmosis.mvc.controller.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@page import="com.ecosmosis.common.customlibs.I18nLocale"%>
<%@ page import="com.ecosmosis.common.messages.*"%>
<%@ page import="java.util.*"%>

<%
  	Locale currentLocale = SupportedLocale.DEFAULT_LOCALE;

	/* Init Sys class*/
	Sys.getControllerURL(1,request);
	
	// Translator
   	MessageTranslator lang = MsgFactory.getTranslator(currentLocale);
  
   	response.setContentType("text/html; charset=utf-8");
%>

<% if (SystemConstant.ACCESS_SYSTEM_ANNOUCEMENT == 1) { %>

<script type='text/javascript'>alert("<%=SystemConstant.ACCESS_SYSTEM_ANNOUCEMENT_CONTENT%>");</script>
<% } %>

<i18n:locale translator="<%=lang%>" id="<%=I18nLocale.ATTRB_DEFAULT_TRANSLATOR%>"/>

<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath() %>/lib/screen.css" />
<link rel="stylesheet" type="text/css" media="print" href="<%= request.getContextPath() %>/lib/print.css" />
<link rel="stylesheet" type="text/css" media="all" title="summer" href="<%= request.getContextPath()%>/lib/jscalendar/calendar-win2k-cold-1.css" />

<%@ include file="/lib/script.jsp"%>

<script type="text/javascript" src="<%= request.getContextPath()%>/lib/jscalendar/calendar.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/lib/jscalendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/lib/jscalendar/calendar-setup.js"></script>

