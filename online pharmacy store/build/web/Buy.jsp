<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html data-theme="light">
<head>
<meta charset="ISO-8859-1">
<title>Buy</title>
<link href="https://cdn.jsdelivr.net/npm/daisyui@2.51.6/dist/full.css" rel="stylesheet" type="text/css" />
<script src="https://cdn.tailwindcss.com"></script>
<!--  <link rel="stylesheet" href="css/Buy.css"> -->
</head>
<body>
	<div class="navbar bg-base-100 px-20">
		<div class="navbar-start">
			<a class="btn btn-ghost font-bold tracking-wide text-xl" href="/online_pharmacy_store/index.html">QuickMeds</a>
		</div>
		<div class="navbar-center hidden lg:flex">
			<ul class="menu menu-horizontal px-1">
				<li><a href="Homepage.jsp">HOME</a></li>
				<li><a href="Buy.jsp">BUY</a></li>
				<li><a href="Orders.jsp">ORDERS</a></li>
			</ul>
		</div>
		<div class="navbar-end">
			<a class="btn" href="Logout.jsp">Logout</a>
		</div>
	</div>
	<div class="flex">
		<%@ page import="java.sql.*"%>
		<%@ page import="javax.sql.*"%>
		<%
		HttpSession httpSession = request.getSession();
		String uid = (String) httpSession.getAttribute("currentuser");
		%>



		<%
		int flag = 0;
		ResultSet rs = null;
		PreparedStatement ps = null;
		java.sql.Connection conn = null;
		String query = "select p.pname,p.pid,p.manufacturer,p.mfg,p.price,i.quantity from product p,inventory i where p.pid=i.pid";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "jaybarot2808");
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
		%>

		<%
		while (rs.next()) {
		%>
		<div class="card bg-base-100 shadow-lg w-fit flex-col items-center p-6 gap-4 m-5">
			<img src="images/pills.png" width=180 height=200>
			<h1><%=rs.getString("pname")%></h1>
			<p>
				<b>ID: </b><%=rs.getString("pid")%></p>
			<p>
				<b>Manufacturer: </b><%=rs.getString("manufacturer")%></p>
			<p>
				<b>Mfg Date: </b><%=rs.getDate("mfg")%></p>
			<p>
				<b>Stock: </b><%=rs.getInt("quantity")%></p>
			<p>
				<b>Price: </b><%=rs.getInt("price")%></p>
			<%
			if (rs.getInt("quantity") > 0) {
			%>
			<form action="PlaceOrder.jsp" method="post">
				<input class="input input-bordered input-primary block my-2 w-full" type="number" name="orderquantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" placeholder="Enter quantity" max="<%=rs.getInt("quantity")%>" required>
				<input type="hidden" name="pid" value="<%=rs.getString("pid")%>">
				<p></p>
				<button class="btn btn-primary btn-active block my-2 w-full">Buy</button>
			</form>
			<%
			} else {
			%>
			<p class="text-error font-semibold">Out of Stock</p>
			<%
			}
			%>
		</div>
		<%
		}
		%>
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
		if (ps != null)
			ps.close();
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
