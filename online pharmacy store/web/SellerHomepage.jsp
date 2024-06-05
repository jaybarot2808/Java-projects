<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html data-theme="light">
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
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
		%>
		<div class="filler"></div>
		<h2 class="font-bold text-xl text-center my-5">
			Welcome
			<%=guid%></h2>
		<%
		ResultSet rs = null;
		PreparedStatement ps = null;
		java.sql.Connection conn = null;
		String query = "select sname,sid,address,phno from seller where sid=?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "jaybarot2808");
			ps = conn.prepareStatement(query);
			ps.setString(1, guid);
			rs = ps.executeQuery();
			if (rs.next()) {
		%>
		<div class="card bg-base-100 shadow-lg w-1/4 flex-col items-center p-6 gap-4 mx-auto">
			<div class="avatar placeholder self-center">
				<div class="bg-neutral-focus text-neutral-content rounded-full w-32">
					<span class="text-5xl"><%=guid.substring(0, 2)%></span>
				</div>
			</div>
			
				<h4>
					<b><%=rs.getString("sname")%></b>
				</h4>
				<p>
					<b>ID: </b><%=rs.getString("sid")%>
				</p>
				<p>
					<b>Address: </b><%=rs.getString("address")%></p>
				<p>
					<b>Phone: </b><%=rs.getString("phno")%></p>
		</div>
		<%
		}
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
	</div>
</body>
</html>
