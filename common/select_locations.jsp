<%@ page import="com.ecosmosis.common.locations.*"%>


<%
	LocationBean[] locationbeans = (LocationBean[]) returnBean.getReturnObject("LocationList");
	String locationdefault = (String) returnBean.getReturnObject("LocationDefault");
	boolean isSelected = false;
%>

<% if (locationbeans != null) { %>
<% for (int i=0;i<locationbeans.length;i++) { 
	    StringBuffer buf = new StringBuffer();
	    isSelected = false;
	    
	    if(locationdefault!=null && !isSelected){
	    	
	    	if(locationbeans[i].getLocationID().equalsIgnoreCase(locationdefault)){
	    		
	    		isSelected = true;
	    	}
	    }
		for (int j=0;j<locationbeans[i].getLocationType()-2;j++)
			buf.append("&nbsp;&nbsp;&nbsp;");
%>
<option value="<%=locationbeans[i].getLocationID()%>" <%=((isSelected)?"selected":"")%>><%=buf.toString()%>(<%=locationbeans[i].getLocationID()%>)&nbsp;<%=locationbeans[i].getName()%> </option>
<% } // end for %>
<% } // end if %>