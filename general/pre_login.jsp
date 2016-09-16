<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.language.*"%>
<%@ page import="com.ecosmosis.emrm.member.*"%>
<%@ page import="com.ecosmosis.mvc.authentication.*"%>
<%@ page import="java.util.*"%>
<%
	Locale currlocale = (Locale) request.getAttribute("Locale");
	
	String errorMsg = (String) request.getAttribute("Error");
	boolean hasError = errorMsg!=null && errorMsg.length()>0;
	
	String loginURL = null;
	int successID = 0;

	int taskid = 0;
	try {
		taskid = Integer.parseInt(request.getParameter(Sys.TASK));
	} catch (Exception e) {}


	switch (taskid) {

		case HttpAuthenticationManager.ADMIN_LOGIN : {

			loginURL = "/admin/index.jsp";
			successID = HttpAuthenticationManager.ADMIN_LOGIN_SUCCESS;

			break;
		}
		case HttpAuthenticationManager.MEMBER_LOGIN : {

		
			loginURL = "/member/index.jsp";
			successID = HttpAuthenticationManager.MEMBER_LOGIN_SUCCESS;
			
			
			break;
		}
		/*
                case HttpAuthenticationManager.MSTOCKIST_LOGIN : {

			loginURL = "/mstockist/index.jsp";
                        successID = HttpAuthenticationManager.MSTOCKIST_LOGIN_SUCCESS;

			break;
		}
		*/
		case HttpAuthenticationManager.STOCKIST_LOGIN : {

			loginURL = "/stockist/index.jsp";
			successID = HttpAuthenticationManager.STOCKIST_LOGIN_SUCCESS;

			break;
		}
		default :
			break;
	}

	if (hasError) {
	        getServletContext().getRequestDispatcher(loginURL).forward(request, response);
	} else {

	        response.sendRedirect(Sys.getControllerURL(successID,request));
	}
%>
