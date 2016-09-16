<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.messages.*"%>
<%@ page import="java.sql.SQLException"%>

<%

	MvcReturnBean returnBean99788 = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	

	StringBuffer bufferstring123 = new StringBuffer();
	
	if (returnBean99788 != null && (returnBean99788.getException() != null || returnBean99788.hasErrorMessages() || returnBean99788.getSysError() != null))
	{
		int errorcode12345 = 0;
			
		if (returnBean99788.getException() != null)
		{
			Exception e = returnBean99788.getException();
			if (e instanceof SQLException) {
				SQLException sqle = (SQLException) e;
				errorcode12345 = sqle.getErrorCode();
			}
			
			if (errorcode12345 == 1602)  
			{   
				bufferstring123.append("Similar Record alrady exists !!! <br>"+"Error Code is "+errorcode12345+"<br>"+returnBean99788.getException().getMessage());
				bufferstring123.append("<br>");
			}		
			else
			{
				bufferstring123.append(returnBean99788.getException().getMessage());
				bufferstring123.append("<br>");
			}
		}
			
		if (returnBean99788.getSysError() != null)
		{
			bufferstring123.append(returnBean99788.getSysError());	
			bufferstring123.append("<br>");
		}
		
		if (returnBean99788.hasErrorMessages())
		{
			MvcMessage[] msgs = (MvcMessage[]) returnBean99788.getErrorMessages();		

			for (int i=0;i < msgs.length;i++)
			{
				MessageBean msg = lang.getMessageBean(msgs[i].getMessage());
				bufferstring123.append(msg.getMessage());
				bufferstring123.append("<br>");
			}
			
		}
	} // if returnBean99788 not null	and has Error
	
		

	if (returnBean99788 != null && (returnBean99788.hasMessages() || returnBean99788.getSysMessage() != null))
	{
			
		if (returnBean99788.getSysMessage() != null)
		{
			String messages[] = null;
			if(returnBean99788.getSysMessage().indexOf("|") >= 0){				
				messages = returnBean99788.getSysMessage().split("[|]");
			}
			
			if(messages!=null){
				
				for (int i=0;i < messages.length;i++)
				{					
					bufferstring123.append(lang.display(messages[i]));
					bufferstring123.append("<br>");
				}
				
			}else{
				
				bufferstring123.append(lang.display(returnBean99788.getSysMessage()));	
				bufferstring123.append("<br>");
			}
		}
		
		if (returnBean99788.hasMessages())
		{
			MvcMessage[] msgs = (MvcMessage[]) returnBean99788.getMessages();		

			for (int i=0;i < msgs.length;i++)
			{
				MessageBean msg = lang.getMessageBean(msgs[i].getMessage());
				bufferstring123.append(msg.getMessage());
				bufferstring123.append("<br>");
			}	
		}
	} // if returnBean99788 not null	and has Message
		
%>


<% if (bufferstring123.length() > 0) { %>

		<b><i><font color="red"><%=bufferstring123.toString()%></font></i></b>
<br>
<% } %>
