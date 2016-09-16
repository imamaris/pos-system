<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%

   boolean canView = false;
   String testKey = request.getParameter("testKey");
   String msg = "";
   
   if (testKey != null && testKey.equals("ORCA"))
   	  canView = true;
   else if (testKey != null && testKey.length() > 0)
   	  msg = "DB is Running Normally. ";
      
   
   String DB_DRIVER = request.getParameter("dbDriver");
   String DB_URL = request.getParameter("dbUrl");
   String DB_USERID = request.getParameter("dbUserID");
   String DB_PASSWORD = request.getParameter("dbPassword");
   String SQL = request.getParameter("SQL");
   String type = request.getParameter("Type");

   boolean canRun = DB_DRIVER!=null&&DB_URL!=null&&DB_USERID!=null&&DB_PASSWORD!=null&&SQL!=null;

%>
<%!
	// start print object data function
	void printData(JspWriter out, ResultSet rs, int idx) throws Exception {
		
		switch (rs.getMetaData().getColumnType(idx)) {

			case Types.CHAR : case Types.VARCHAR : case Types.LONGVARCHAR : {
				out.print(rs.getString(idx)== null ?"&nbsp;":rs.getString(idx));
				break;
			}

			case Types.DECIMAL :case Types.DOUBLE : {
				out.print(rs.getDouble(idx));
				break;
			}

			case Types.FLOAT : {
				out.print(rs.getFloat(idx));
				break;
			}

			case Types.BIGINT: case Types.INTEGER: case Types.SMALLINT:
			case Types.TINYINT : {
				out.print(rs.getInt(idx));
				break;
			}

			case Types.DATE : {
				out.print(rs.getDate(idx));
				break;
			}

			case Types.TIME : {
				out.print(rs.getTime(idx));
				break;
			}

			case Types.TIMESTAMP : {
				out.print(rs.getTimestamp(idx));
				break;
			}

			case Types.JAVA_OBJECT : case Types.OTHER : case Types.BINARY : 
			case Types.LONGVARBINARY : {
				out.print("[Java Object]");
				break;
			}

			case Types.CLOB : case Types.BLOB : {
				out.print(rs.getBlob(idx));
				break;
			}

			default : out.print(rs.getMetaData().getColumnTypeName(idx));
		}

	}

	// executeQuery function
	void executeQuery(JspWriter out, PreparedStatement stmt) throws Exception {

		ResultSet rs = null;
		ResultSetMetaData meta = null;

	   try {
		rs = stmt.executeQuery();
		meta = rs.getMetaData();
		int numberOfColumns = meta.getColumnCount();


		// get record count
		rs.last();
		int numberOfRows = rs.getRow();
		out.println("<tr><td colspan="+ numberOfColumns +"><b>Total Result : "+ numberOfRows +"</b></td></tr>");

		rs.beforeFirst();


		// print out column name
		out.println("<tr bgcolor=#cecece>");

		for (int i=1; i<=numberOfColumns; i++) {
			out.println("<td><b>"+ meta.getColumnLabel(i) +"</b></td>");
		}

		out.println("</tr>");


		// print out query result
		while (rs.next()) {
	                out.println("<tr>");

			for (int i=1; i<=numberOfColumns; i++) {
				out.print("<td>");
				printData(out, rs, i);
				out.println("</td>");
			}

	                out.println("</tr>");
		}
	   } finally {
		if (rs != null) rs.close();
		rs = null; meta = null;
	   }
	}


	// executeQuery function
	void convertCVS(JspWriter out, PreparedStatement stmt) throws Exception {

		ResultSet rs = null;
		ResultSetMetaData meta = null;

	   try {
		rs = stmt.executeQuery();
		meta = rs.getMetaData();
		int numberOfColumns = meta.getColumnCount();


		// get record count
		rs.last();
		int numberOfRows = rs.getRow();
		out.println("<tr><td colspan="+ numberOfColumns +"><b>Total Result : "+ numberOfRows +"</b></td></tr>");

		rs.beforeFirst();


		// print out column title
		out.println("<tr><td>");

		for (int i=1; i<=numberOfColumns; i++) {
			if (i!=1) out.print(",");
			out.print("\""+ meta.getColumnLabel(i) +"\"");
		}

		out.println("");


		// print out query result to text delimeter
		while (rs.next()) {
			for (int i=1; i<=numberOfColumns; i++) {
				if (i!=1) out.print(",");
				out.print("\"");
				printData(out, rs, i);
				out.print("\"");
			}

	                out.println("");
		}
		out.println("</td></tr>");
	   } finally {
		if (rs != null) rs.close();
		rs = null; meta = null;
	   }
	}

%>

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language=javascript>

function validate(thisform) {

  thisform.submit();

}

function doConvert(thisform) {

  thisform.Type.value = "cvs";
  thisform.submit();

}

</script>

</head>

<body>

<form name=dbaccess method=post>
<input type=hidden name=Type value="query">

<div class="functionhead">Database Diagnosis</div>

<table>
<tr><td><%=msg%></td></tr>
</table>

<table class="listbox">
<tr>
  <td class="odd">Test Key</td>
  <td><input type=text name="testKey" value="<%= canView ? testKey : "" %>" size=15 /></td>
</tr>


<% if (canView) { %> 

<tr>
  <td class="odd">Jdbc Driver</td>
  <td><input type=text name=dbDriver value="<%= canRun?DB_DRIVER:"org.gjt.mm.mysql.Driver" %>" size=30></td>
</tr>
<tr>
  <td class="odd">Database URL</td>
  <td><input type=text name=dbUrl value="<%= canRun?DB_URL:"jdbc:mysql://localhost/" %>" size=30></td>
</tr>
<tr>
  <td class="odd">User ID</td>
  <td><input type=text name=dbUserID value="<%= canRun?DB_USERID:"" %>"></td>
</tr>
<tr>
  <td class="odd">Password</td>
  <td><input type=password name=dbPassword value="<%= canRun?DB_PASSWORD:"" %>"></td>
</tr>
<tr valign=top>
  <td class="odd">SQL Query</td>
  <td><textarea name=SQL cols=120 rows=7><%= canRun?SQL:"" %></textarea></td>
</tr>
<tr>
  <td colspan=2>
    <input type=button value="To CSV" onClick="doConvert(this.form)">
  </td>
</tr>

<% } %>

<tr>
  <td colspan=2>
    <input type=button value="Execute" onClick="validate(this.form)">
  </td>
</tr>
</table>
</form>
<hr>

<%

   if (canRun && canView) {
%>

<table class="listbox">
<%

      if (SQL.length()<=0)
          return;

      try {
          if (DB_DRIVER != null)
             Class.forName(DB_DRIVER);
          else
             Class.forName("org.gjt.mm.mysql.Driver");

      } catch (Exception e) {
          out.println("<b>Driver Error : </b>"+ e.toString() +"</td></tr>");
          return;
      }


      Connection conn = null;
      PreparedStatement stmt = null;

      try {
          conn = DriverManager.getConnection(DB_URL,DB_USERID,DB_PASSWORD);
          stmt = conn.prepareStatement(SQL);

          String tmp_SQL = SQL.toUpperCase().trim();
          if (tmp_SQL.startsWith("INSERT") || tmp_SQL.startsWith("UPDATE") || tmp_SQL.startsWith("DELETE") ||
              tmp_SQL.startsWith("ALTER") || tmp_SQL.startsWith("CREATE") || tmp_SQL.startsWith("DUMP") || 
              tmp_SQL.startsWith("DROP")) {

             int updateCount = stmt.executeUpdate();
             out.println("<tr><td><b>Updated Count :</b> "+ updateCount +"</td></tr>");

          } else {
             if (type.equals("cvs"))
                 convertCVS(out,stmt);
             else
                 executeQuery(out,stmt);
          }

      } catch (Exception e) {

          out.println("<b>Error : </b>"+ e.toString());

      } finally {
          try {
              if (stmt != null) stmt.close();
          } catch (Exception e) {}

          if (conn != null) conn.close();
      }
%>
</table>

<%      
   }
%>
</body>

</html>
