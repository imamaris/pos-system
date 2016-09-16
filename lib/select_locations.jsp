<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="java.util.*"%>

<script language="javascript">

<%
  LocationBean root = (LocationBean) Location.getObject("HQ");
  
  if (root != null) {
		LocationBean[] countries = (LocationBean[]) root.getChildArray();
%>
    
	countries = new Array(<%= countries.length %>);
	state = new Array(<%= countries.length %>);
	city = new Array(<%= countries.length %>);
	currencies = new Array(<%= countries.length %>);
	
<%	
		for (int i =0; i< countries.length ; i++) {
%>
    
	countries[<%=i%>] = new Array(2);
	countries[<%=i%>][0] = "<%= countries[i].getLocationID() %>";
	countries[<%=i%>][1] = "<%= countries[i].getName() %>";
	
<%
			String aCurrency = countries[i].getCurrency();
				
			if (aCurrency != null && aCurrency.length() > 0) {
%>		

				currencies[<%=i%>] = new Array(2);
				currencies[<%=i%>][0] = "<%= aCurrency %>";
				currencies[<%=i%>][1] = "<%= aCurrency + " (" + countries[i].getName() + ")" %>";

<%
			}	 // end currencies
%>

<%
	ArrayList stateList = new ArrayList();
	LocationBean[] regions = (LocationBean[]) countries[i].getChildArray();

  for (int m=0; m< regions.length ; m++) {
		
	  ArrayList aList = regions[m].getChilds();
	  
	  if (aList != null && aList.size() > 0)
	  	stateList.addAll(aList);
  }
  
  LocationBean[] states = (LocationBean[]) stateList.toArray(new LocationBean[0]);
  
%> 

	state[<%=i%>] = new Array(<%=states.length%>);
	city[<%=i%>] = new Array(<%=states.length%>);
	
<%
			for (int j =0; j< states.length ; j++) {
%>

			state[<%=i%>][<%=j%>] = new Array(2);
			state[<%=i%>][<%=j%>][0] = "<%= states[j].getLocationID() %>";
			state[<%=i%>][<%=j%>][1] = "<%= states[j].getName() %>";
			
<%
			LocationBean[] cities = (LocationBean[]) states[j].getChildArray();
%>

			city[<%=i%>][<%=j%>] = new Array(<%=cities.length%>);	
			
<%
				for (int k =0; k< cities.length ; k++) {
%>

				city[<%=i%>][<%=j%>][<%=k%>] = new Array(2);
				city[<%=i%>][<%=j%>][<%=k%>][0] = "<%=cities[k].getLocationID()%>";
				city[<%=i%>][<%=j%>][<%=k%>][1] = "<%=cities[k].getName()%>";
				
<%
				} // end for city
			
			} // end for states
		  
		} // end for countries
	
	} // end root != null
%>
 
	function loadCountry(countryObj,selectedCode) {
		var selectedIndexOf = 0;
		
		for ( i = 0 ; i<countries.length ; i++ ) {
			
			if ( selectedCode == countries[i][0] )
				selectedIndexOf = i+1;
				
			countryObj.options[i+1] = new Option(countries[i][1],countries[i][0]);
		}
		
		countryObj.selectedIndex = selectedIndexOf;
		
		return;
		
	} // end loadCountry

	function loadState(countryObj, stateObj, selectedCode) {

		var selectedIndexOf = 0;
		selectedCountry = countryObj.selectedIndex-1;
		
		clearSelect(stateObj,1);
	
		if (selectedCountry>=0) {
		
			for (i = 0 ; i < state[selectedCountry].length ; i++) {
				
				if ( selectedCode == state[selectedCountry][i][0] )
					selectedIndexOf = i+1;		
				
				stateObj.options[i+1] = new Option(state[selectedCountry][i][1],state[selectedCountry][i][0]);
			}
			
			stateObj.selectedIndex = selectedIndexOf;
		}
		
		return;
	
	} // end loadState
 
	function loadCity(countryObj, stateObj, cityObj, selectedCode) {

		var selectedIndexOf = 0;
		selectedCountry = countryObj.selectedIndex-1;
		selectedState = stateObj.selectedIndex-1;
		
		clearSelect(cityObj,1);
	
		if (selectedCountry>=0 && selectedState>=0) {
		 	
			for (i = 0 ; i < city[selectedCountry][selectedState].length ; i++) {
				
				if (selectedCode == city[selectedCountry][selectedState][i][0])
					selectedIndexOf = i+1;	
						
				cityObj.options[i+1] = new Option(city[selectedCountry][selectedState][i][1],city[selectedCountry][selectedState][i][0]);
			}
			
			cityObj.selectedIndex = selectedIndexOf;
		
		}
		
		return;
	
	} // end loadCity
  
	function loadCurrency(obj, selectedCode) {
	
		var selectedIndexOf = 0;
		
		for ( i = 0 ; i<currencies.length ; i++ ) {
		
			if ( selectedCode == currencies[i][0] )
				selectedIndexOf = i+1;
				
			obj.options[i+1] = new Option(currencies[i][1],currencies[i][0]);
		}
		
		obj.selectedIndex = selectedIndexOf;
		
		return;
		
	} // end loadCurrency
	
	function clearSelect(obj, minimumLeft) {
		
		while (obj.length > minimumLeft ) 	
			obj.options[1] = null; 
			
	} // end clearSelect
	
</script>

 
