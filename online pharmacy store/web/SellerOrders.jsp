<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html data-theme="light">
<head>
<meta charset="ISO-8859-1">
<title>Orders</title>
<link href="https://cdn.jsdelivr.net/npm/daisyui@2.51.6/dist/full.css" rel="stylesheet" type="text/css" />
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
	<div class="navbar bg-base-100 px-20">
		<div class="navbar-start">
			<a class="btn btn-ghost font-bold tracking-wide text-xl" href="/online_pharmacy_store/index.html">QuickMeds</a>
		</div>
		<div class="navbar-center hidden lg:flex">
			<ul class="menu menu-horizontal px-1">
				<li><a href="SellerHomepage.jsp">HOME</a></li>
				<li><a href="AddProduct.html">ADD</a></li>
				<li><a href="AddInventory.jsp">RESTOCK</a></li>
				<li><a href="SellerOrders.jsp">ORDERS</a></li>
			</ul>
		</div>
		<div class="navbar-end">
			<a class="btn" href="Logout.jsp">Logout</a>
		</div>
	</div>

	
	<div class="active">
		<%@ page import="java.sql.*"%>
		<%@ page import="javax.sql.*"%>
		<%
		HttpSession httpSession = request.getSession();
		String guid = (String) httpSession.getAttribute("currentuser");
		int flag = 0;
		ResultSet rs = null;
		CallableStatement cs = null;
		java.sql.Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "jaybarot2808");
			cs = conn.prepareCall("call getsellerorders(?)");
			cs.setString(1, guid);
			rs = cs.executeQuery();
		%>
		<table class="table mx-auto w-fit mt-10">
			<tr>
				<th>Order ID</th>
				<th>Product ID</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>CUSTOMER ID</th>
				<th>Order Date and Time</th>
			</tr>
			<%
			while (rs.next()) {
			%>

			<tr>
				<td><%=rs.getInt("oid")%></td>
				<td><%=rs.getString("pid")%></td>
				<td><%=rs.getInt("price")%></td>
				<td><%=rs.getInt("quantity")%></td>
				<td><%=rs.getString("uid")%></td>
				<td><%=rs.getTimestamp("orderdatetime")%>
			</tr>

			<%
			}
			%>
		</table>
	</div>
	<%
	} catch (Exception e) {
	out.println("error: " + e);
	} finally {
	try {
		if (rs != null)
			rs.close();
	} catch (Exception e) {
	}
	;
	try {
		if (cs != null)
			cs.close();
	} catch (Exception e) {
	}
	;
	try {
		if (conn != null)
			conn.close();
	} catch (Exception e) {
	}
	;
	}
	%>
</body>
</html>
