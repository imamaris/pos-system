<%@ taglib uri="/WEB-INF/tlds/standard.tld" prefix="std" %>
<%@ taglib uri="/WEB-INF/tlds/i18n.tld" prefix="i18n" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<%@ page import="com.ecosmosis.mvc.accesscontrol.user.*"%>
<%@ page import="com.ecosmosis.mvc.authentication.*"%>
<%@ page import="com.ecosmosis.mvc.constant.*"%>
<%@ page import="com.ecosmosis.mvc.controller.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.MvcReturnBean"%>
<%@ page import="com.ecosmosis.common.messages.*"%>
<%@page import="com.ecosmosis.common.customlibs.I18nLocale"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@page import="com.ecosmosis.orca.stockist.StockistLoginUserBean"%>
<%@page import="com.ecosmosis.orca.users.AdminLoginUserBean"%>
<%@ page import="java.util.*"%>
	
<%
	Object ob19890 = request.getAttribute(ControllerServlet.MVC_ACCESS_CHECK);
	session = request.getSession(true);
	LoginUserBean loginUser = (LoginUserBean) session.getAttribute(HttpAuthenticationManager.AUTH_KEY);
	
	if (ob19890  == null || loginUser == null)
	{
		String url = Sys.getControllerURL(HttpAuthenticationManager.ILLEGAL_DIRECT_JSP_ACCESS,request);			
		response.sendRedirect(url);
	    return;
	}	
	Locale currentLocale = SupportedLocale.DEFAULT_LOCALE;
	
	if (loginUser != null)
		currentLocale = loginUser.getLocale();
	
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

<%@ include file="/lib/script.jsp"%>

<script type="text/javascript" src="<%= request.getContextPath()%>/lib/jscalendar/calendar.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/lib/jscalendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/lib/jscalendar/calendar-setup.js"></script>

