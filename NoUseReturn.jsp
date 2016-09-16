<%@ page import="java.sql.*" %>
<%@ page import="com.ecosmosis.orca.counter.sales.CounterSalesManager" %>
<%
//CounterSalesManager csoMgr = new CounterSalesManager();

System.out.println("Ke sinikeh index ");

String sku_kode = request.getParameter("sku_kode").toString();
String  data ="";

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
    
    
    String query = "SELECT cso_salesid, cso_trxdocno, cso_trxdocname, cso_bonus_earnerid, cso_bonus_earnername, cso_custid, cso_cust_name, cso_netsales_amt, cso_cust_contact " +
            " FROM counter_sales_order " +            
            " WHERE cso_trxdoctype = 'SR' and cso_trxgroup = 40 and (select count(*) from counter_sales_order where cso_adj_refno = '"+sku_kode+"') = 0 and cso_delivery_amt >= 0 and cso_trxdocno='"+sku_kode+"'";
    
    st = conn.createStatement();
    ResultSet  rs = st.executeQuery(query);
    while(rs.next()) {
        
         data = ":" + rs.getString("cso_salesid") +
                ":" + rs.getString("cso_trxdocname") +
                ":" + rs.getString("cso_bonus_earnerid") +
                ":" + rs.getString("cso_bonus_earnername") +
                ":" + rs.getString("cso_custid") +
                ":" + rs.getString("cso_cust_name") +
                ":" + rs.getString("cso_netsales_amt") +
                ":" + rs.getString("cso_cust_contact") +
                ":" + sku_kode;
    }    
    out.println(data);
} catch (Exception e) {
    e.printStackTrace();
}
%>