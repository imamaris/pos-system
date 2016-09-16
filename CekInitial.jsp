<%@ page import="java.sql.*" %> 
<%
response.setHeader("Cache-Control", "no-cache");  
response.setHeader("Pragma", "no-cache"); 
response.setDateHeader("Expires", 0); 
                
String tanggal = request.getParameter("tanggal").toString();

System.out.println("Ke sinikeh 2 index, cek voucher payment "+tanggal);
String  data ="";
String  data1 ="test";

Connection conn = null;
String url = "jdbc:mysql://localhost:3306/";
String dbName = "pos_time";
String driver = "com.mysql.jdbc.Driver";
String userName = "root";
String password = "yody";

int sumcount=0;
Statement st;
try {
    Class.forName(driver).newInstance();
        
    System.out.println("hello");
    
    conn = DriverManager.getConnection(url+dbName,userName,password);
    
    String query = "SELECT bpm_periodid FROM bonus_period_master WHERE bpm_periodid = '"+tanggal+"' ";
    
    st = conn.createStatement();    
    ResultSet  rs = st.executeQuery(query);
    System.out.println("Ke sinikeh 3 index, query cek initial date  "+query);
    
    while(rs.next()) {
        
         System.out.println("Ke sinikeh 4 index  cek initial date "+tanggal);
        
        data = ":" + rs.getString("bpm_periodid") +
                ":"+ tanggal;        
    }
	

// println(query);
    out.println(data);
} catch (Exception e) {
    e.printStackTrace();
}
%>
