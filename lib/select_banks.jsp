<%@ page import="com.ecosmosis.common.bank.*"%>

<script language="javascript">

<%
	BankBean[] banks = (BankBean[]) Bank.getAll();
%>
    
	banks = new Array(<%=banks.length%>);

<%
	for (int i =0; i< banks.length ; i++) {
%>
    
		banks[<%=i%>] = new Array(2);
		banks[<%=i%>][0] = "<%= banks[i].getBankID() %>";
		banks[<%=i%>][1] = "<%= banks[i].getName() %>";

<%	
	} // end for bank
%>
 
	function loadBank(bankObj, selectedCode) {
	
		var selectedIndexOf = 0;
		
		for ( i = 0 ; i<banks.length ; i++ ) {
		
			if ( selectedCode == banks[i][0] )
				selectedIndexOf = i+1;
				
			bankObj.options[i+1] = new Option(banks[i][1],banks[i][0]);
		}
		
		bankObj.selectedIndex = selectedIndexOf;
		
		return;
		
	} // end loadBank

</script>

 
